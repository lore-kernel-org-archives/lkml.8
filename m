Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A969FC18E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 18:37:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EFEE20679
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 18:37:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732384AbgCPShz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 14:37:55 -0400
Received: from mga14.intel.com ([192.55.52.115]:38017 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732294AbgCPShz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 14:37:55 -0400
IronPort-SDR: 7/lba+NGC5h9Gto00I92tEIfX76hdhl0EnBVUzLH5w6wJW/fYFko3yocx97LxTKxQpPmtpFA8i
 3gP8tD8y0Bsw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2020 11:37:54 -0700
IronPort-SDR: KJT01j4/cj0PAG9jf5wdckPSQVyMJOWVoYCCscoM4RpPoeo7zdKJjuWSP8sINvpluwcG3BgvdQ
 viJJJTKq9J7Q==
X-IronPort-AV: E=Sophos;i="5.70,561,1574150400"; 
   d="scan'208";a="390794166"
Received: from rchatre-mobl.amr.corp.intel.com (HELO [10.254.77.132]) ([10.254.77.132])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2020 11:37:54 -0700
Subject: Re: [PATCH 07/10] x86/resctrl: Add arch_needs_linear to explain
 AMD/Intel MBA difference
To:     James Morse <james.morse@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, Babu Moger <Babu.Moger@amd.com>
References: <20200214182401.39008-1-james.morse@arm.com>
 <20200214182401.39008-8-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <bab1dd35-bf60-c106-a023-8cbd5e64e03d@intel.com>
Date:   Mon, 16 Mar 2020 11:37:53 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200214182401.39008-8-james.morse@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 2/14/2020 10:23 AM, James Morse wrote:
> The configuration values user-space provides to the resctrl filesystem
> are ABI. To make this work on another architecture we want to move all
> the ABI bits out of /arch/x86 and under /fs.
> 
> To do this, the differences between AMD and Intel CPUs needs to be
> explained to resctrl via resource properties, instead of function
> pointers that let the arch code accept subtly different values on
> different platforms/architectures.
> 
> For MBA, Intel CPUs reject configuration attempts for non-linear
> resources, whereas AMD ignore this field as its MBA resource is never
> linear. To merge the parse/validate functions we need to explain
> this difference.
> 
> Add arch_needs_linear to indicate the arch code needs the linear
> property to be true to configure this resource. AMD can set this
> and delay_linear to false. Intel can set arch_needs_linear
> to true to keep the existing "No support for non-linear MB domains"
> error message for affected platforms.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>  arch/x86/kernel/cpu/resctrl/core.c        | 3 +++
>  arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 8 +++++++-
>  arch/x86/kernel/cpu/resctrl/internal.h    | 2 ++
>  3 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index 7d295ae620bb..f022dc823c53 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -260,6 +260,7 @@ static bool __get_mem_config_intel(struct rdt_resource *r)
>  	r->num_closid = edx.split.cos_max + 1;
>  	max_delay = eax.split.max_delay + 1;
>  	r->default_ctrl = MAX_MBA_BW;
> +	r->membw.arch_needs_linear = true;
>  	if (ecx & MBA_IS_LINEAR) {
>  		r->membw.delay_linear = true;
>  		r->membw.min_bw = MAX_MBA_BW - max_delay;
> @@ -267,6 +268,7 @@ static bool __get_mem_config_intel(struct rdt_resource *r)
>  	} else {
>  		if (!rdt_get_mb_table(r))
>  			return false;
> +		r->membw.arch_needs_linear = false;
>  	}
>  	r->data_width = 3;
>  
> @@ -288,6 +290,7 @@ static bool __rdt_get_mem_config_amd(struct rdt_resource *r)
>  
>  	/* AMD does not use delay */
>  	r->membw.delay_linear = false;
> +	r->membw.arch_needs_linear = false;
>  
>  	r->membw.min_bw = 0;
>  	r->membw.bw_gran = 1;
> diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> index 055c8613b531..db8e6c0cadb1 100644
> --- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> +++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> @@ -33,6 +33,12 @@ static bool bw_validate_amd(char *buf, unsigned long *data,
>  	unsigned long bw;
>  	int ret;
>  
> +	/* temporary: always false on AMD */
> +	if (!r->membw.delay_linear && r->membw.arch_needs_linear) {
> +		rdt_last_cmd_puts("No support for non-linear MB domains\n");
> +		return false;
> +	}
> +
>  	ret = kstrtoul(buf, 10, &bw);
>  	if (ret) {
>  		rdt_last_cmd_printf("Non-decimal digit in MB value %s\n", buf);
> @@ -82,7 +88,7 @@ static bool bw_validate(char *buf, unsigned long *data, struct rdt_resource *r)
>  	/*
>  	 * Only linear delay values is supported for current Intel SKUs.
>  	 */
> -	if (!r->membw.delay_linear) {
> +	if (!r->membw.delay_linear && r->membw.arch_needs_linear) {
>  		rdt_last_cmd_puts("No support for non-linear MB domains\n");
>  		return false;
>  	}
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index 3e3ba85843c4..1fa692c54e15 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -363,6 +363,7 @@ struct rdt_cache {
>   * struct rdt_membw - Memory bandwidth allocation related data
>   * @min_bw:		Minimum memory bandwidth percentage user can request
>   * @bw_gran:		Granularity at which the memory bandwidth is allocated
> + * @arch_needs_linear:  True if we can't configure non-linear resources
>   * @delay_linear:	True if memory B/W delay is in linear scale
>   * @mba_sc:		True if MBA software controller(mba_sc) is enabled
>   * @mb_map:		Mapping of memory B/W percentage to memory B/W delay

This area uses tab for spacing.

> @@ -371,6 +372,7 @@ struct rdt_membw {
>  	u32		min_bw;
>  	u32		bw_gran;
>  	u32		delay_linear;
> +	bool		arch_needs_linear;
>  	bool		mba_sc;
>  	u32		*mb_map;
>  };
> 

Babu may want to take a look.

Just the one small comment from my side, apart from that it looks good
to me.

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Thank you

Reinette
