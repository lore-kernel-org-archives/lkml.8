Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5382C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 11:34:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B811A2073E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 11:34:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728963AbgGFLeB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 07:34:01 -0400
Received: from mga17.intel.com ([192.55.52.151]:50859 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728414AbgGFLeB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 07:34:01 -0400
IronPort-SDR: ePR4olwShwi4UOsiopsZIr4Yr11XzFZACnYTbmlm7zTIuNKosIZwyeXi6/WuWIIQSjf0lhzval
 a77xGGipaHLA==
X-IronPort-AV: E=McAfee;i="6000,8403,9673"; a="127473481"
X-IronPort-AV: E=Sophos;i="5.75,318,1589266800"; 
   d="scan'208";a="127473481"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2020 04:34:00 -0700
IronPort-SDR: VztLuEsJgrosVmMFsJXymfd6iaG3kqLQtlbM6feRg8HB5WJNr3KjwMfwJ/iGNnMLCJwaMc2TyW
 PYb/29AoM+Kw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,318,1589266800"; 
   d="scan'208";a="322359492"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by FMSMGA003.fm.intel.com with ESMTP; 06 Jul 2020 04:33:59 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jsPNo-000Iop-96; Mon, 06 Jul 2020 14:34:00 +0300
Date:   Mon, 6 Jul 2020 14:34:00 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Wei Yang <richard.weiyang@gmail.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] lib/test_bitops: Do the full test during module init
Message-ID: <20200706113400.GU3703480@smile.fi.intel.com>
References: <20200706112900.7097-1-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200706112900.7097-1-geert@linux-m68k.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 06, 2020 at 01:29:00PM +0200, Geert Uytterhoeven wrote:
> Currently, the bitops test consists of two parts: one part is executed
> during module load, the second part during module unload. This is
> cumbersome for the user, as he has to perform two steps to execute all
> tests, and is different from most (all?) other tests.
> 
> Merge the two parts, so both are executed during module load.

I think it's right way to go, sorry, I didn't notice this during module
submission.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

One question though, is compiler barrier enough to prevent potential ordering issues?

> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
> v2:
>   - Keep a dummy module_exit() function to support module unloading.
> ---
>  lib/test_bitops.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/lib/test_bitops.c b/lib/test_bitops.c
> index ced25e3a779baf96..471141ddd6913724 100644
> --- a/lib/test_bitops.c
> +++ b/lib/test_bitops.c
> @@ -52,9 +52,9 @@ static unsigned long order_comb_long[][2] = {
>  
>  static int __init test_bitops_startup(void)
>  {
> -	int i;
> +	int i, bit_set;
>  
> -	pr_warn("Loaded test module\n");
> +	pr_info("Starting bitops test\n");
>  	set_bit(BITOPS_4, g_bitmap);
>  	set_bit(BITOPS_7, g_bitmap);
>  	set_bit(BITOPS_11, g_bitmap);
> @@ -81,12 +81,8 @@ static int __init test_bitops_startup(void)
>  				       order_comb_long[i][0]);
>  	}
>  #endif
> -	return 0;
> -}
>  
> -static void __exit test_bitops_unstartup(void)
> -{
> -	int bit_set;
> +	barrier();
>  
>  	clear_bit(BITOPS_4, g_bitmap);
>  	clear_bit(BITOPS_7, g_bitmap);
> @@ -98,7 +94,13 @@ static void __exit test_bitops_unstartup(void)
>  	if (bit_set != BITOPS_LAST)
>  		pr_err("ERROR: FOUND SET BIT %d\n", bit_set);
>  
> -	pr_warn("Unloaded test module\n");
> +	pr_info("Completed bitops test\n");
> +
> +	return 0;
> +}
> +
> +static void __exit test_bitops_unstartup(void)
> +{
>  }
>  
>  module_init(test_bitops_startup);
> -- 
> 2.17.1
> 

-- 
With Best Regards,
Andy Shevchenko


