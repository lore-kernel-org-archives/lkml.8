Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE236C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 17:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 979A6206ED
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 17:42:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727967AbgBMRmP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 12:42:15 -0500
Received: from foss.arm.com ([217.140.110.172]:51516 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726282AbgBMRmO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 12:42:14 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DEC80328;
        Thu, 13 Feb 2020 09:42:13 -0800 (PST)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D31293F6CF;
        Thu, 13 Feb 2020 09:42:12 -0800 (PST)
Subject: Re: [PATCH] x86/resctrl: Preserve CDP enable over cpuhp
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>
References: <20200212185359.163111-1-james.morse@arm.com>
 <8aab67d7-c13e-19f1-9bec-85b7cca55146@intel.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <720c9253-d590-82d5-2338-7f577a71b791@arm.com>
Date:   Thu, 13 Feb 2020 17:42:11 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <8aab67d7-c13e-19f1-9bec-85b7cca55146@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On 12/02/2020 22:53, Reinette Chatre wrote:
> On 2/12/2020 10:53 AM, James Morse wrote:
>> Resctrl assumes that all cpus are online when the filesystem is
> 
> Please take care throughout to use CPU/CPUs

Capitals, sure. (or did I miss a plural somewhere...)


>> mounted, and that cpus remember their CDP-enabled state over cpu
>> hotplug.
>>
>> This goes wrong when resctrl's CDP-enabled state changes while all
>> the cpus in a domain are offline.
>>
>> When a domain comes online, enable (or disable!) CDP to match resctrl's
>> current setting.
>>
>> Fixes: 5ff193fbde20 ("x86/intel_rdt: Add basic resctrl filesystem support")
>> Signed-off-by: James Morse <james.morse@arm.com>
>>
>> ---
>>
>> Seen on a 'Intel(R) Xeon(R) Gold 5120T CPU @ 2.20GHz' from lenovo, taking
>> all the cores in one package offline, umount/mount to toggle CDP then
>> bringing them back: the first core to come online still has the old
>> CDP state.
>>
>> This will get called more often than is desirable (worst:3/domain)
>> but this is better than on every cpu in the domain. Unless someone
>> can spot a better place to hook it in?
> 
> From what I can tell this solution is indeed called for every CPU, and
> more so, for every capable resource associated with each CPU:
> resctrl_online_cpu() is called for each CPU and it in turn runs ...
> 
> for_each_capable_rdt_resource(r)
>         domain_add_cpu()
> 
> ... from where the new code is called.

Indeed, but the domain_reconfigure_cdp() is after:

|	d = rdt_find_domain(r, id, &add_pos);
[...]
|	if (d) {
|		cpumask_set_cpu(cpu, &d->cpu_mask);
|		return;
|	}

Any second CPU that comes through domain_add_cpu() will find the domain created by the
first, and add itself to d->cpu_mask. Only the first CPU gets to allocate a domain and
reset the ctrlvals, and now reconfigure cdp.


It is called for each capable resource in that domain, so once for each of the
BOTH/CODE/DATA caches. I can't spot anywhere to hook this in that is only called once per
really-exists domain. I guess passing the resource, to try and filter out the duplicates
fixes the 3x.

(MPAM does some origami with all this to merge the BOTH/CODE/DATA stuff for what becomes
the arch code interface to resctrl.)


>> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
>> index 89049b343c7a..1210cb65e6d3 100644
>> --- a/arch/x86/kernel/cpu/resctrl/core.c
>> +++ b/arch/x86/kernel/cpu/resctrl/core.c
>> @@ -541,6 +541,25 @@ static int domain_setup_mon_state(struct rdt_resource *r, struct rdt_domain *d)
>>  	return 0;
>>  }
>>  
>> +/* resctrl's use of CDP may have changed while this domain slept */
>> +static void domain_reconfigure_cdp(void)
>> +{
>> +	bool cdp_enable;
>> +	struct rdt_resource *r;
> 
> (Please note that this area uses reverse-fir tree ordering.)
> 
>> +
>> +	lockdep_assert_held(&rdtgroup_mutex);
>> +
>> +	r = &rdt_resources_all[RDT_RESOURCE_L2];
>> +	cdp_enable = !r->alloc_enabled;
> 
> This logic can become confusing. Also remember that L2 or L3 resources
> supporting allocation are not required to support CDP. There are
> existing products that support allocation without supporting CDP.

Ah, yes. So on a non-CDP-capable system, we try to disable CDP because it wasn't enabled.
Oops.


> The
> goal is to configure CDP correctly on a resource that supports CDP and
> for that there are the L2DATA, L2CODE, L3DATA, and L3CODE resources.> These resources have their "alloc_capable" set if they support CDP and
> "alloc_enabled" set when CDP is enabled.
> 
> Would it be possible to have a helper to correctly enable/disable CDP> only for resources that support CDP?

(Making CDP a global property which the arch code then enables it on the resources that
support it when resctrl switches to its odd/even mode? Sounds like a great idea!)


> This helper could have "cpu" in its
> name to distinguish it from the other system-wide helpers.

(not domain? I thought this MSR was somehow the same register on all the CPUs in a package)


>> +	if (r->alloc_capable)
>> +		l2_qos_cfg_update(&cdp_enable);
> 
> Since this will run on any system that supports L2 allocation it will
> attempt to disable CDP on a system that does not support CDP. I do not
> think this is the right thing to do.

Yup, I'd forgotten it was optional as it is supported on both machines I've seen.

Changing it to use one of the CODE/DATA versions would take that into account.
It becomes:

	r_cdp = &rdt_resources_all[RDT_RESOURCE_L3CODE];
	if (r_cdp->alloc_capable)
		l3_qos_cfg_update(&r_cdp->alloc_enabled);


>> @@ -578,6 +597,8 @@ static void domain_add_cpu(int cpu, struct rdt_resource *r)
>>  	d->id = id;
>>  	cpumask_set_cpu(cpu, &d->cpu_mask);
>>  
>> +	domain_reconfigure_cdp();
>> +
> 
> domain_add_cpu() is called for each resource associated with each CPU.
> It seems that this reconfiguration could be moved up to
> resctrl_online_cpu() and not be run as many times. (One hint that this
> could be done is that this new function is not using any of the
> parameters passed from resctrl_online_cpu() to domain_add_cpu().)

Moving it above domain_add_cpu()'s bail-out for online-ing to an existing domain causes it
to run per-cpu instead. This was the only spot I could find that 'knows' this is a new
domain, thus it might need that MSR re-sycing.

Yes, none of the arguments are used as CDP-enabled really ought to be a global system
property.


> The re-configuring of CDP would still be done for each CPU as it comes
> online.

I don't think that happens, surely per-cpu is worse than 3x per-domain.


>> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
>> index 181c992f448c..29c92d3e93f5 100644
>> --- a/arch/x86/kernel/cpu/resctrl/internal.h
>> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
>> @@ -602,4 +602,7 @@ void __check_limbo(struct rdt_domain *d, bool force_free);
>>  bool cbm_validate_intel(char *buf, u32 *data, struct rdt_resource *r);
>>  bool cbm_validate_amd(char *buf, u32 *data, struct rdt_resource *r);
>>  
>> +void l3_qos_cfg_update(void *arg);
>> +void l2_qos_cfg_update(void *arg);
>> +
> 
> The new helper could be located in this same area with all the other CDP
> related functions and it will just be the one helper exported.

... I think you're describing adding:

void rdt_domain_reconfigure_cdp(struct rdt_resource *r)
{
	struct rdt_resource *r_cdp;

	lockdep_assert_held(&rdtgroup_mutex);

	if (r->rid != RDT_RESOURCE_L2 && r->rid != RDT_RESOURCE_L3)
		return;

	r_cdp = &rdt_resources_all[RDT_RESOURCE_L2CODE];
	if (r_cdp->alloc_capable)
		l2_qos_cfg_update(&r_cdp->alloc_enabled);

	r_cdp = &rdt_resources_all[RDT_RESOURCE_L3CODE];
	if (r_cdp->alloc_capable)
		l3_qos_cfg_update(&r_cdp->alloc_enabled);
}

to rdtgroup.c and using that from core.c?

I think domain in the name is important to hint you only need to call it once per domain,
as set_cache_qos_cfg() does today.



Thanks,

James
