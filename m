Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD651C352A4
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 22:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 997CD21569
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 22:53:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729256AbgBLWxf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 17:53:35 -0500
Received: from mga09.intel.com ([134.134.136.24]:64157 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727692AbgBLWxe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 17:53:34 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Feb 2020 14:53:33 -0800
X-IronPort-AV: E=Sophos;i="5.70,434,1574150400"; 
   d="scan'208";a="237856126"
Received: from rchatre-mobl.amr.corp.intel.com (HELO [10.24.14.116]) ([10.24.14.116])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 12 Feb 2020 14:53:33 -0800
Subject: Re: [PATCH] x86/resctrl: Preserve CDP enable over cpuhp
To:     James Morse <james.morse@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>
References: <20200212185359.163111-1-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <8aab67d7-c13e-19f1-9bec-85b7cca55146@intel.com>
Date:   Wed, 12 Feb 2020 14:53:31 -0800
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200212185359.163111-1-james.morse@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

Thank you very much for catching this.

On 2/12/2020 10:53 AM, James Morse wrote:
> Resctrl assumes that all cpus are online when the filesystem is

Please take care throughout to use CPU/CPUs

> mounted, and that cpus remember their CDP-enabled state over cpu
> hotplug.
> 
> This goes wrong when resctrl's CDP-enabled state changes while all
> the cpus in a domain are offline.
> 
> When a domain comes online, enable (or disable!) CDP to match resctrl's
> current setting.
> 
> Fixes: 5ff193fbde20 ("x86/intel_rdt: Add basic resctrl filesystem support")
> Signed-off-by: James Morse <james.morse@arm.com>
> 
> ---
> 
> Seen on a 'Intel(R) Xeon(R) Gold 5120T CPU @ 2.20GHz' from lenovo, taking
> all the cores in one package offline, umount/mount to toggle CDP then
> bringing them back: the first core to come online still has the old
> CDP state.
> 
> This will get called more often than is desirable (worst:3/domain)
> but this is better than on every cpu in the domain. Unless someone
> can spot a better place to hook it in?

From what I can tell this solution is indeed called for every CPU, and
more so, for every capable resource associated with each CPU:
resctrl_online_cpu() is called for each CPU and it in turn runs ...

for_each_capable_rdt_resource(r)
        domain_add_cpu()

... from where the new code is called.


> ---
>  arch/x86/kernel/cpu/resctrl/core.c     | 21 +++++++++++++++++++++
>  arch/x86/kernel/cpu/resctrl/internal.h |  3 +++
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c |  7 +++++--
>  3 files changed, 29 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index 89049b343c7a..1210cb65e6d3 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -541,6 +541,25 @@ static int domain_setup_mon_state(struct rdt_resource *r, struct rdt_domain *d)
>  	return 0;
>  }
>  
> +/* resctrl's use of CDP may have changed while this domain slept */
> +static void domain_reconfigure_cdp(void)
> +{
> +	bool cdp_enable;
> +	struct rdt_resource *r;

(Please note that this area uses reverse-fir tree ordering.)

> +
> +	lockdep_assert_held(&rdtgroup_mutex);
> +
> +	r = &rdt_resources_all[RDT_RESOURCE_L2];
> +	cdp_enable = !r->alloc_enabled;

This logic can become confusing. Also remember that L2 or L3 resources
supporting allocation are not required to support CDP. There are
existing products that support allocation without supporting CDP. The
goal is to configure CDP correctly on a resource that supports CDP and
for that there are the L2DATA, L2CODE, L3DATA, and L3CODE resources.
These resources have their "alloc_capable" set if they support CDP and
"alloc_enabled" set when CDP is enabled.

Would it be possible to have a helper to correctly enable/disable CDP
only for resources that support CDP? This helper could have "cpu" in its
name to distinguish it from the other system-wide helpers.

> +	if (r->alloc_capable)
> +		l2_qos_cfg_update(&cdp_enable);

Since this will run on any system that supports L2 allocation it will
attempt to disable CDP on a system that does not support CDP. I do not
think this is the right thing to do.

> +
> +	r = &rdt_resources_all[RDT_RESOURCE_L3];
> +	cdp_enable = !r->alloc_enabled;
> +	if (r->alloc_capable)
> +		l3_qos_cfg_update(&cdp_enable);
> +}
> +
>  /*
>   * domain_add_cpu - Add a cpu to a resource's domain list.
>   *
> @@ -578,6 +597,8 @@ static void domain_add_cpu(int cpu, struct rdt_resource *r)
>  	d->id = id;
>  	cpumask_set_cpu(cpu, &d->cpu_mask);
>  
> +	domain_reconfigure_cdp();
> +

domain_add_cpu() is called for each resource associated with each CPU.
It seems that this reconfiguration could be moved up to
resctrl_online_cpu() and not be run as many times. (One hint that this
could be done is that this new function is not using any of the
parameters passed from resctrl_online_cpu() to domain_add_cpu().)

The re-configuring of CDP would still be done for each CPU as it comes
online.

>  	if (r->alloc_capable && domain_setup_ctrlval(r, d)) {
>  		kfree(d);
>  		return;
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index 181c992f448c..29c92d3e93f5 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -602,4 +602,7 @@ void __check_limbo(struct rdt_domain *d, bool force_free);
>  bool cbm_validate_intel(char *buf, u32 *data, struct rdt_resource *r);
>  bool cbm_validate_amd(char *buf, u32 *data, struct rdt_resource *r);
>  
> +void l3_qos_cfg_update(void *arg);
> +void l2_qos_cfg_update(void *arg);
> +

The new helper could be located in this same area with all the other CDP
related functions and it will just be the one helper exported.


>  #endif /* _ASM_X86_RESCTRL_INTERNAL_H */
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 064e9ef44cd6..e11356011a4a 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -1804,14 +1804,14 @@ mongroup_create_dir(struct kernfs_node *parent_kn, struct rdtgroup *prgrp,
>  	return ret;
>  }
>  
> -static void l3_qos_cfg_update(void *arg)
> +void l3_qos_cfg_update(void *arg)
>  {
>  	bool *enable = arg;
>  
>  	wrmsrl(MSR_IA32_L3_QOS_CFG, *enable ? L3_QOS_CDP_ENABLE : 0ULL);
>  }
>  
> -static void l2_qos_cfg_update(void *arg)
> +void l2_qos_cfg_update(void *arg)
>  {
>  	bool *enable = arg;
>  
> @@ -1831,6 +1831,9 @@ static int set_cache_qos_cfg(int level, bool enable)
>  	struct rdt_domain *d;
>  	int cpu;
>  
> +	/* CDP state is restored during cpuhp, which takes this lock */
> +	lockdep_assert_held(&rdtgroup_mutex);
> +
>  	if (level == RDT_RESOURCE_L3)
>  		update = l3_qos_cfg_update;
>  	else if (level == RDT_RESOURCE_L2)
> 

Reinette
