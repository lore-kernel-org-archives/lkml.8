Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0C61C35242
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 19:24:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86B752168B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 19:24:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388504AbgBNTY6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 14:24:58 -0500
Received: from mga01.intel.com ([192.55.52.88]:21002 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388364AbgBNTYy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 14:24:54 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Feb 2020 11:24:54 -0800
X-IronPort-AV: E=Sophos;i="5.70,441,1574150400"; 
   d="scan'208";a="381537616"
Received: from rchatre-mobl.amr.corp.intel.com (HELO [10.251.23.248]) ([10.251.23.248])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 14 Feb 2020 11:24:53 -0800
Subject: Re: [PATCH v2] x86/resctrl: Preserve CDP enable over cpuhp
To:     James Morse <james.morse@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>
References: <20200214181600.38779-1-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <214c845b-d093-bafc-02d0-dfd810283f1a@intel.com>
Date:   Fri, 14 Feb 2020 11:24:52 -0800
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200214181600.38779-1-james.morse@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 2/14/2020 10:16 AM, James Morse wrote:
> Resctrl assumes that all CPUs are online when the filesystem is
> mounted, and that CPUs remember their CDP-enabled state over CPU
> hotplug.
> 
> This goes wrong when resctrl's CDP-enabled state changes while all
> the CPUs in a domain are offline.
> 
> When a domain comes online, enable (or disable!) CDP to match resctrl's
> current setting.
> 
> Fixes: 5ff193fbde20 ("x86/intel_rdt: Add basic resctrl filesystem support")
> Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> 
> ---
> Changes since v1:
>  * Explicitly test for L2/L3 resources to ignore duplicate calls.
>  * Poke the LxDATA resources to avoid confusing CDP-off with CDP-unsupported.
>  * Moved code to rdtgroup.c for fewer exported functions.
> 
> v1: lore.kernel.org/r/20200212185359.163111-1-james.morse@arm.com
> ---
>  arch/x86/kernel/cpu/resctrl/core.c     |  2 ++
>  arch/x86/kernel/cpu/resctrl/internal.h |  1 +
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 18 ++++++++++++++++++
>  3 files changed, 21 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index 89049b343c7a..d8cc5223b7ce 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -578,6 +578,8 @@ static void domain_add_cpu(int cpu, struct rdt_resource *r)
>  	d->id = id;
>  	cpumask_set_cpu(cpu, &d->cpu_mask);
>  
> +	rdt_domain_reconfigure_cdp(r);
> +
>  	if (r->alloc_capable && domain_setup_ctrlval(r, d)) {
>  		kfree(d);
>  		return;
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index 181c992f448c..3dd13f3a8b23 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -601,5 +601,6 @@ bool has_busy_rmid(struct rdt_resource *r, struct rdt_domain *d);
>  void __check_limbo(struct rdt_domain *d, bool force_free);
>  bool cbm_validate_intel(char *buf, u32 *data, struct rdt_resource *r);
>  bool cbm_validate_amd(char *buf, u32 *data, struct rdt_resource *r);
> +void rdt_domain_reconfigure_cdp(struct rdt_resource *r);
>  
>  #endif /* _ASM_X86_RESCTRL_INTERNAL_H */
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 064e9ef44cd6..5967320a1951 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -1831,6 +1831,9 @@ static int set_cache_qos_cfg(int level, bool enable)
>  	struct rdt_domain *d;
>  	int cpu;
>  
> +	 /* CDP state is restored during cpuhp, which takes this lock */
> +	lockdep_assert_held(&rdtgroup_mutex);
> +

I think this hunk can be dropped. (1) The code path where this
annotation is added is not part of this fix. (2) The comment implies
that the taking of the mutex is something new/unique added in the CPU
hotplug path but that is not accurate since this mutex is also taken in
the only other existing call path of this snippet that is handling the
mounting of the filesystem.

You do mention that these annotations is helpful for the MPAM work.
Could the annotations instead be added as a separate patch forming part
of that work?

>  	if (level == RDT_RESOURCE_L3)
>  		update = l3_qos_cfg_update;
>  	else if (level == RDT_RESOURCE_L2)
> @@ -1859,6 +1862,21 @@ static int set_cache_qos_cfg(int level, bool enable)
>  	return 0;
>  }
>  
> +/* Restore the qos cfg state when a package comes online */

s/package/domain/? When, for example, considering L2 then "package" is
not the right term to use.

> +void rdt_domain_reconfigure_cdp(struct rdt_resource *r)
> +{
> +	lockdep_assert_held(&rdtgroup_mutex);
> +
> +	if (!r->alloc_capable)
> +		return;
> +
> +	if (r == &rdt_resources_all[RDT_RESOURCE_L2DATA])
> +		l2_qos_cfg_update(&r->alloc_enabled);
> +
> +	if (r == &rdt_resources_all[RDT_RESOURCE_L3DATA])
> +		l3_qos_cfg_update(&r->alloc_enabled);
> +}
> +
>  /*
>   * Enable or disable the MBA software controller
>   * which helps user specify bandwidth in MBps.
> 

Thank you very much.

Reinette
