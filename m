Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95C47C0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 20:31:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F2A620663
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 20:31:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732564AbgCPUbz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 16:31:55 -0400
Received: from mga02.intel.com ([134.134.136.20]:47055 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732486AbgCPUbz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 16:31:55 -0400
IronPort-SDR: GiWWNE2F9Lz0Gr8sBeeXupiu0mjoYTvISIWAGVSFEd8zAPNZdK/eLXQV5MSC/S3b2N2fMxMAEW
 QzfsaS42+MKg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2020 13:31:54 -0700
IronPort-SDR: xzRL6UNCMzmpCMbegDbeHR9mq7Kyu+8iNJBgKmHYRgAOXTA6WBtoFvt6Flxv4JlXNJ3IylRjKI
 iCU6dERy42kg==
X-IronPort-AV: E=Sophos;i="5.70,561,1574150400"; 
   d="scan'208";a="390829182"
Received: from rchatre-mobl.amr.corp.intel.com (HELO [10.254.77.132]) ([10.254.77.132])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2020 13:31:54 -0700
Subject: Re: [PATCH 10/10] cacheinfo: Move resctrl's get_cache_id() to the
 cacheinfo header file
To:     James Morse <james.morse@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, Babu Moger <Babu.Moger@amd.com>
References: <20200214182401.39008-1-james.morse@arm.com>
 <20200214182401.39008-11-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <3a20be0d-4d5f-cc0b-38d9-1ad8d648acac@intel.com>
Date:   Mon, 16 Mar 2020 13:31:53 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200214182401.39008-11-james.morse@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 2/14/2020 10:24 AM, James Morse wrote:
> resctrl/core.c defines get_cache_id() for use in its cpu-hotplug
> callbacks. This gets the id attribute of the cache at the corresponding
> level of a cpu.
> 
> Later rework means this private function needs to be shared. Move
> it to the header file.
> 
> The name conflicts with a different definition in intel_cacheinfo.c,
> name it get_cpu_cacheinfo_id() to show its relation with
> get_cpu_cacheinfo().
> 
> Now this is visible on other architectures, check the id attribute
> has actually been set.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>  arch/x86/kernel/cpu/resctrl/core.c | 17 ++---------------
>  include/linux/cacheinfo.h          | 18 ++++++++++++++++++
>  2 files changed, 20 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index 7c9c4bd5fd32..f2968fb6fb9a 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -349,19 +349,6 @@ static void rdt_get_cdp_l2_config(void)
>  	rdt_get_cdp_config(RDT_RESOURCE_L2, RDT_RESOURCE_L2CODE);
>  }
>  
> -static int get_cache_id(int cpu, int level)
> -{
> -	struct cpu_cacheinfo *ci = get_cpu_cacheinfo(cpu);
> -	int i;
> -
> -	for (i = 0; i < ci->num_leaves; i++) {
> -		if (ci->info_list[i].level == level)
> -			return ci->info_list[i].id;
> -	}
> -
> -	return -1;
> -}
> -
>  static void
>  mba_wrmsr_amd(struct rdt_domain *d, struct msr_param *m, struct rdt_resource *r)
>  {
> @@ -559,7 +546,7 @@ static int domain_setup_mon_state(struct rdt_resource *r, struct rdt_domain *d)
>   */
>  static void domain_add_cpu(int cpu, struct rdt_resource *r)
>  {
> -	int id = get_cache_id(cpu, r->cache_level);
> +	int id = get_cpu_cacheinfo_id(cpu, r->cache_level);
>  	struct list_head *add_pos = NULL;
>  	struct rdt_domain *d;
>  
> @@ -603,7 +590,7 @@ static void domain_add_cpu(int cpu, struct rdt_resource *r)
>  
>  static void domain_remove_cpu(int cpu, struct rdt_resource *r)
>  {
> -	int id = get_cache_id(cpu, r->cache_level);
> +	int id = get_cpu_cacheinfo_id(cpu, r->cache_level);
>  	struct rdt_domain *d;
>  
>  	d = rdt_find_domain(r, id, NULL);
> diff --git a/include/linux/cacheinfo.h b/include/linux/cacheinfo.h
> index 46b92cd61d0c..e210225ab7a8 100644
> --- a/include/linux/cacheinfo.h
> +++ b/include/linux/cacheinfo.h
> @@ -3,6 +3,7 @@
>  #define _LINUX_CACHEINFO_H
>  
>  #include <linux/bitops.h>
> +#include <linux/cpu.h>
>  #include <linux/cpumask.h>
>  #include <linux/smp.h>
>  
> @@ -119,4 +120,21 @@ int acpi_find_last_cache_level(unsigned int cpu);
>  
>  const struct attribute_group *cache_get_priv_group(struct cacheinfo *this_leaf);
>  
> +/* Get the id of a particular cache on @cpu. cpuhp lock must held. */

Technically the cache is not _on_ @cpu. How about "Get the id of the
cache associated with @cpu at level @level"?

Also, s/must held/must be held/

> +static inline int get_cpu_cacheinfo_id(int cpu, int level)
> +{
> +	struct cpu_cacheinfo *ci = get_cpu_cacheinfo(cpu);
> +	int i;
> +
> +	for (i = 0; i < ci->num_leaves; i++) {
> +		if (ci->info_list[i].level == level){

Typo here. Could you please insert a space before the open brace?

> +			if (ci->info_list[i].attributes & CACHE_ID)
> +				return ci->info_list[i].id;
> +			return -1;
> +		}
> +	}
> +
> +	return -1;
> +}
> +
>  #endif /* _LINUX_CACHEINFO_H */
> 

The resctrl bits look good to me.

Thank you

Reinette
