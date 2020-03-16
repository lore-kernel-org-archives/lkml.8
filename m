Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DE2CC0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 18:42:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFF2520719
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 18:42:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732369AbgCPSmm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 14:42:42 -0400
Received: from mga02.intel.com ([134.134.136.20]:38658 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732266AbgCPSml (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 14:42:41 -0400
IronPort-SDR: hujwtZmSr9SpI7kG4jtB9Up3MpHBRGxjHJcTgaYjyVSutWATDwpirirP3SLZqX6JERNj8i4bIV
 Cvck/0Bo6wIw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2020 11:42:41 -0700
IronPort-SDR: VrkgkWgSTknaT+OicebeFeiCDwPtG2e57U9h9BIhYDsteL6pwnub+wQMaO0RZG1vkY2kqKtWYO
 ddfF71zNvh/Q==
X-IronPort-AV: E=Sophos;i="5.70,561,1574150400"; 
   d="scan'208";a="390796175"
Received: from rchatre-mobl.amr.corp.intel.com (HELO [10.254.77.132]) ([10.254.77.132])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2020 11:42:40 -0700
From:   Reinette Chatre <reinette.chatre@intel.com>
Subject: Re: [PATCH 08/10] x86/resctrl: Merge AMD/Intel parse_bw() calls
To:     James Morse <james.morse@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, Babu Moger <Babu.Moger@amd.com>
References: <20200214182401.39008-1-james.morse@arm.com>
 <20200214182401.39008-9-james.morse@arm.com>
Message-ID: <deed72cb-53a5-f80a-03e9-623288c5d6e5@intel.com>
Date:   Mon, 16 Mar 2020 11:42:40 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200214182401.39008-9-james.morse@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 2/14/2020 10:23 AM, James Morse wrote:
> Now that we've explained arch_needs_linear to resctrl, the parse_bw()
> calls are almost the same between AMD and Intel.
> 
> The difference is '!is_mba_sc()', which is not checked on AMD. This
> will always be true on AMD CPUs as mba_sc cannot be enabled as
> is_mba_linear() is false.
> 
> Removing this duplication means user-space visible behaviour and
> error messages are not validated or generated in different places.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>  arch/x86/kernel/cpu/resctrl/core.c        |  4 +-
>  arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 55 +----------------------
>  arch/x86/kernel/cpu/resctrl/internal.h    |  6 +--
>  3 files changed, 5 insertions(+), 60 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index f022dc823c53..e90c10ca85f4 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -924,7 +924,7 @@ static __init void rdt_init_res_defs_intel(void)
>  		else if (r->rid == RDT_RESOURCE_MBA) {
>  			r->msr_base = MSR_IA32_MBA_THRTL_BASE;
>  			r->msr_update = mba_wrmsr_intel;
> -			r->parse_ctrlval = parse_bw_intel;
> +			r->parse_ctrlval = parse_bw;
>  		}
>  	}
>  }
> @@ -944,7 +944,7 @@ static __init void rdt_init_res_defs_amd(void)
>  		else if (r->rid == RDT_RESOURCE_MBA) {
>  			r->msr_base = MSR_IA32_MBA_BW_BASE;
>  			r->msr_update = mba_wrmsr_amd;
> -			r->parse_ctrlval = parse_bw_amd;
> +			r->parse_ctrlval = parse_bw;
>  		}
>  	}
>  }

Now that these values are identical more duplication can be avoided by
moving the initialization to earlier where rdt_resources_all[] is
initialized. Could you please modify this patch to do so?

> diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> index db8e6c0cadb1..416becb591d1 100644
> --- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> +++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> @@ -21,59 +21,6 @@
>  #include <linux/slab.h>
>  #include "internal.h"
>  
> -/*
> - * Check whether MBA bandwidth percentage value is correct. The value is
> - * checked against the minimum and maximum bandwidth values specified by
> - * the hardware. The allocated bandwidth percentage is rounded to the next
> - * control step available on the hardware.
> - */
> -static bool bw_validate_amd(char *buf, unsigned long *data,
> -			    struct rdt_resource *r)
> -{
> -	unsigned long bw;
> -	int ret;
> -
> -	/* temporary: always false on AMD */
> -	if (!r->membw.delay_linear && r->membw.arch_needs_linear) {
> -		rdt_last_cmd_puts("No support for non-linear MB domains\n");
> -		return false;
> -	}
> -
> -	ret = kstrtoul(buf, 10, &bw);
> -	if (ret) {
> -		rdt_last_cmd_printf("Non-decimal digit in MB value %s\n", buf);
> -		return false;
> -	}
> -
> -	if (bw < r->membw.min_bw || bw > r->default_ctrl) {
> -		rdt_last_cmd_printf("MB value %ld out of range [%d,%d]\n", bw,
> -				    r->membw.min_bw, r->default_ctrl);
> -		return false;
> -	}
> -
> -	*data = roundup(bw, (unsigned long)r->membw.bw_gran);
> -	return true;
> -}
> -
> -int parse_bw_amd(struct rdt_parse_data *data, struct rdt_resource *r,
> -		 struct rdt_domain *d)
> -{
> -	unsigned long bw_val;
> -
> -	if (d->have_new_ctrl) {
> -		rdt_last_cmd_printf("Duplicate domain %d\n", d->id);
> -		return -EINVAL;
> -	}
> -
> -	if (!bw_validate_amd(data->buf, &bw_val, r))
> -		return -EINVAL;
> -
> -	d->new_ctrl = bw_val;
> -	d->have_new_ctrl = true;
> -
> -	return 0;
> -}
> -
>  /*
>   * Check whether MBA bandwidth percentage value is correct. The value is
>   * checked against the minimum and max bandwidth values specified by the
> @@ -110,7 +57,7 @@ static bool bw_validate(char *buf, unsigned long *data, struct rdt_resource *r)
>  	return true;
>  }
>  
> -int parse_bw_intel(struct rdt_parse_data *data, struct rdt_resource *r,
> +int parse_bw(struct rdt_parse_data *data, struct rdt_resource *r,
>  		   struct rdt_domain *d)

This change affects the alignment here ... could you please fix the
alignment to match open parenthesis?

>  {
>  	unsigned long bw_val;
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index 1fa692c54e15..45fc695081d1 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -462,10 +462,8 @@ struct rdt_resource {
>  
>  int parse_cbm(struct rdt_parse_data *data, struct rdt_resource *r,
>  	      struct rdt_domain *d);
> -int parse_bw_intel(struct rdt_parse_data *data, struct rdt_resource *r,
> -		   struct rdt_domain *d);
> -int parse_bw_amd(struct rdt_parse_data *data, struct rdt_resource *r,
> -		 struct rdt_domain *d);
> +int parse_bw(struct rdt_parse_data *data, struct rdt_resource *r,
> +	     struct rdt_domain *d);
>  
>  extern struct mutex rdtgroup_mutex;
>  
> 

Babu may want to take a look also.

Thank you

Reinette
