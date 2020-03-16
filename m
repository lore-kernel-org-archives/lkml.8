Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB6DFC18E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 18:58:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DDE8206E2
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 18:58:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732412AbgCPS61 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 14:58:27 -0400
Received: from mga02.intel.com ([134.134.136.20]:39992 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732330AbgCPS61 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 14:58:27 -0400
IronPort-SDR: fXM7eCr9rJ02WJAZxrsnWpScd0foB4onTYPRfg5LycUKl+mw2d/0IQXB3cOCPh1o7HXulXH1uh
 N602GoQK3qrA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2020 11:58:26 -0700
IronPort-SDR: LK6A+v0XB8RXGAGrcpE3nBDdPwtfZfgUtho12c3oIdP4eRtUl3EA6Gx1CfbjXzVr6AOFgUMWdW
 /5Oadvyrwm1Q==
X-IronPort-AV: E=Sophos;i="5.70,561,1574150400"; 
   d="scan'208";a="390803268"
Received: from rchatre-mobl.amr.corp.intel.com (HELO [10.254.77.132]) ([10.254.77.132])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2020 11:58:25 -0700
Subject: Re: [PATCH 09/10] x86/resctrl: Add arch_has_sparse_bitmaps to explain
 AMD/Intel CAT difference
To:     James Morse <james.morse@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, Babu Moger <Babu.Moger@amd.com>
References: <20200214182401.39008-1-james.morse@arm.com>
 <20200214182401.39008-10-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <721d1f77-40cc-1472-553e-a62f7a423b00@intel.com>
Date:   Mon, 16 Mar 2020 11:58:25 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200214182401.39008-10-james.morse@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 2/14/2020 10:24 AM, James Morse wrote:
> Intel expects the cache bitmap provided by user-space to have on a
> single span of 1s, whereas AMD can support bitmaps like 0xf00f.
> Arm's MPAM support also allows sparse bitmaps.
> 
> To move resctrl out to /fs/ we need to explain platform differences
> like this. Add a resource property arch_has_sparse_bitmaps. Test this
> around the 'non-consecutive' test in cbm_validate().
> 
> Merging the validate calls causes AMD top gain the min_cbm_bits test
> needed for Haswell, but as it always sets this value to 1, it will
> never match.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>  arch/x86/kernel/cpu/resctrl/core.c        |  4 +--
>  arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 36 +++++------------------
>  arch/x86/kernel/cpu/resctrl/internal.h    |  6 ++--
>  3 files changed, 12 insertions(+), 34 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index e90c10ca85f4..7c9c4bd5fd32 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -920,7 +920,7 @@ static __init void rdt_init_res_defs_intel(void)
>  		    r->rid == RDT_RESOURCE_L2 ||
>  		    r->rid == RDT_RESOURCE_L2DATA ||
>  		    r->rid == RDT_RESOURCE_L2CODE)
> -			r->cbm_validate = cbm_validate_intel;
> +			r->cache.arch_has_sparse_bitmaps = false;
>  		else if (r->rid == RDT_RESOURCE_MBA) {
>  			r->msr_base = MSR_IA32_MBA_THRTL_BASE;
>  			r->msr_update = mba_wrmsr_intel;
> @@ -940,7 +940,7 @@ static __init void rdt_init_res_defs_amd(void)
>  		    r->rid == RDT_RESOURCE_L2 ||
>  		    r->rid == RDT_RESOURCE_L2DATA ||
>  		    r->rid == RDT_RESOURCE_L2CODE)
> -			r->cbm_validate = cbm_validate_amd;
> +			r->cache.arch_has_sparse_bitmaps = true;
>  		else if (r->rid == RDT_RESOURCE_MBA) {
>  			r->msr_base = MSR_IA32_MBA_BW_BASE;
>  			r->msr_update = mba_wrmsr_amd;
> diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> index 416becb591d1..38df876feb54 100644
> --- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> +++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> @@ -76,12 +76,14 @@ int parse_bw(struct rdt_parse_data *data, struct rdt_resource *r,
>  }
>  
>  /*
> - * Check whether a cache bit mask is valid. The SDM says:
> + * Check whether a cache bit mask is valid.
> + * For Intel The SDM says:

s/The/the/

>   *	Please note that all (and only) contiguous '1' combinations
>   *	are allowed (e.g. FFFFH, 0FF0H, 003CH, etc.).
>   * Additionally Haswell requires at least two bits set.
> + * AMD allows non-contiguous bitmasks.
>   */
> -bool cbm_validate_intel(char *buf, u32 *data, struct rdt_resource *r)
> +static bool cbm_validate(char *buf, u32 *data, struct rdt_resource *r)
>  {
>  	unsigned long first_bit, zero_bit, val;
>  	unsigned int cbm_len = r->cache.cbm_len;
> @@ -101,7 +103,9 @@ bool cbm_validate_intel(char *buf, u32 *data, struct rdt_resource *r)
>  	first_bit = find_first_bit(&val, cbm_len);
>  	zero_bit = find_next_zero_bit(&val, cbm_len, first_bit);
>  
> -	if (find_next_bit(&val, cbm_len, zero_bit) < cbm_len) {
> +	/* Are non-contiguous bitmaps allowed? */
> +	if (!r->cache.arch_has_sparse_bitmaps &&
> +	    (find_next_bit(&val, cbm_len, zero_bit) < cbm_len)) {
>  		rdt_last_cmd_printf("The mask %lx has non-consecutive 1-bits\n", val);
>  		return false;
>  	}
> @@ -116,30 +120,6 @@ bool cbm_validate_intel(char *buf, u32 *data, struct rdt_resource *r)
>  	return true;
>  }
>  
> -/*
> - * Check whether a cache bit mask is valid. AMD allows non-contiguous
> - * bitmasks
> - */
> -bool cbm_validate_amd(char *buf, u32 *data, struct rdt_resource *r)
> -{
> -	unsigned long val;
> -	int ret;
> -
> -	ret = kstrtoul(buf, 16, &val);
> -	if (ret) {
> -		rdt_last_cmd_printf("Non-hex character in the mask %s\n", buf);
> -		return false;
> -	}
> -
> -	if (val > r->default_ctrl) {
> -		rdt_last_cmd_puts("Mask out of range\n");
> -		return false;
> -	}
> -
> -	*data = val;
> -	return true;
> -}
> -
>  /*
>   * Read one cache bit mask (hex). Check that it is valid for the current
>   * resource type.
> @@ -165,7 +145,7 @@ int parse_cbm(struct rdt_parse_data *data, struct rdt_resource *r,
>  		return -EINVAL;
>  	}
>  
> -	if (!r->cbm_validate(data->buf, &cbm_val, r))
> +	if (!cbm_validate(data->buf, &cbm_val, r))
>  		return -EINVAL;
>  
>  	if ((rdtgrp->mode == RDT_MODE_EXCLUSIVE ||
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index 45fc695081d1..0172a87de814 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -350,6 +350,7 @@ struct msr_param {
>   *			in a cache bit mask
>   * @shareable_bits:	Bitmask of shareable resource with other
>   *			executing entities
> + * @arch_has_sparse_bitmaps:   True if a bitmap like f00f is valid.
>   */

This area uses tab for spacing.

>  struct rdt_cache {
>  	unsigned int	cbm_len;
> @@ -357,6 +358,7 @@ struct rdt_cache {
>  	unsigned int	cbm_idx_mult;
>  	unsigned int	cbm_idx_offset;
>  	unsigned int	shareable_bits;
> +	bool		arch_has_sparse_bitmaps;
>  };
>  
>  /**
> @@ -426,7 +428,6 @@ struct rdt_parse_data {
>   * @cache:		Cache allocation related data
>   * @format_str:		Per resource format string to show domain value
>   * @parse_ctrlval:	Per resource function pointer to parse control values
> - * @cbm_validate	Cache bitmask validate function
>   * @evt_list:		List of monitoring events
>   * @num_rmid:		Number of RMIDs available
>   * @mon_scale:		cqm counter * mon_scale = occupancy in bytes
> @@ -453,7 +454,6 @@ struct rdt_resource {
>  	int (*parse_ctrlval)(struct rdt_parse_data *data,
>  			     struct rdt_resource *r,
>  			     struct rdt_domain *d);
> -	bool (*cbm_validate)(char *buf, u32 *data, struct rdt_resource *r);
>  	struct list_head	evt_list;
>  	int			num_rmid;
>  	unsigned int		mon_scale;
> @@ -594,7 +594,5 @@ void cqm_setup_limbo_handler(struct rdt_domain *dom, unsigned long delay_ms);
>  void cqm_handle_limbo(struct work_struct *work);
>  bool has_busy_rmid(struct rdt_resource *r, struct rdt_domain *d);
>  void __check_limbo(struct rdt_domain *d, bool force_free);
> -bool cbm_validate_intel(char *buf, u32 *data, struct rdt_resource *r);
> -bool cbm_validate_amd(char *buf, u32 *data, struct rdt_resource *r);
>  
>  #endif /* _ASM_X86_RESCTRL_INTERNAL_H */
> 

Just the two small comments from my side. For the rest:

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Babu may want to take a look.

Reinette


