Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31497C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 09:18:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B46F207D3
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 09:18:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726625AbgFCJSD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 05:18:03 -0400
Received: from mga02.intel.com ([134.134.136.20]:44651 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726315AbgFCJSB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 05:18:01 -0400
IronPort-SDR: VNF3EFgQRKIPfkDwrbR0n3HJIuN1o2IfhURCP6bII/+GL5Z/fmM2xTTaNdXiw/vhu90nL/ascx
 unZQJTsoZiEA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2020 02:18:00 -0700
IronPort-SDR: lcV0hIJtkR4mv0VBdYlE+o3u2RojrAHcL55zTPoXsiBstjpzJxUiksp7xvLjh/8A2ZqUF1s/R+
 I33+2Prd+WiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,467,1583222400"; 
   d="scan'208";a="471064857"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga005.fm.intel.com with ESMTP; 03 Jun 2020 02:17:58 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jgPX8-00Aaqv-1X; Wed, 03 Jun 2020 12:18:02 +0300
Date:   Wed, 3 Jun 2020 12:18:02 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     akpm@linux-foundation.org, christian.brauner@ubuntu.com,
        linux-kernel@vger.kernel.org
Subject: Re: [Patch v2] lib: test get_count_order/long in test_bitops.c
Message-ID: <20200603091802.GN2428291@smile.fi.intel.com>
References: <20200602223728.32722-1-richard.weiyang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200602223728.32722-1-richard.weiyang@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 02, 2020 at 10:37:28PM +0000, Wei Yang wrote:
> Add some test for get_count_order/long in test_bitops.c.

Thanks! LGTM,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Note, we can have as many MODULE_AUTHOR() lines as we want.

> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> 
> ---
> v2: merge the test into test_bitops.c
> ---
>  lib/Kconfig.debug | 10 +++++-----
>  lib/test_bitops.c | 40 ++++++++++++++++++++++++++++++++++++++--
>  2 files changed, 43 insertions(+), 7 deletions(-)
> 
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index f80d5609798f..512111a72e34 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -1987,15 +1987,15 @@ config TEST_LKM
>  	  If unsure, say N.
>  
>  config TEST_BITOPS
> -	tristate "Test module for compilation of clear_bit/set_bit operations"
> +	tristate "Test module for compilation of bitops operations"
>  	depends on m
>  	help
>  	  This builds the "test_bitops" module that is much like the
>  	  TEST_LKM module except that it does a basic exercise of the
> -	  clear_bit and set_bit macros to make sure there are no compiler
> -	  warnings from C=1 sparse checker or -Wextra compilations. It has
> -	  no dependencies and doesn't run or load unless explicitly requested
> -	  by name.  for example: modprobe test_bitops.
> +	  set/clear_bit macros and get_count_order/long to make sure there are
> +	  no compiler warnings from C=1 sparse checker or -Wextra
> +	  compilations. It has no dependencies and doesn't run or load unless
> +	  explicitly requested by name.  for example: modprobe test_bitops.
>  
>  	  If unsure, say N.
>  
> diff --git a/lib/test_bitops.c b/lib/test_bitops.c
> index fd50b3ae4a14..702d5973a5b6 100644
> --- a/lib/test_bitops.c
> +++ b/lib/test_bitops.c
> @@ -9,7 +9,11 @@
>  #include <linux/module.h>
>  #include <linux/printk.h>
>  
> -/* a tiny module only meant to test set/clear_bit */
> +/* a tiny module only meant to test
> + *
> + *   set/clear_bit
> + *   get_count_order/long
> + */
>  
>  /* use an enum because thats the most common BITMAP usage */
>  enum bitops_fun {
> @@ -24,6 +28,26 @@ enum bitops_fun {
>  
>  static DECLARE_BITMAP(g_bitmap, BITOPS_LENGTH);
>  
> +unsigned int order_comb[][2] = {
> +	{0x00000003,  2},
> +	{0x00000004,  2},
> +	{0x00001fff, 13},
> +	{0x00002000, 13},
> +	{0x50000000, 31},
> +	{0x80000000, 31},
> +	{0x80003000, 32},
> +};
> +
> +unsigned long order_comb_long[][2] = {
> +	{0x0000000300000000, 34},
> +	{0x0000000400000000, 34},
> +	{0x00001fff00000000, 45},
> +	{0x0000200000000000, 45},
> +	{0x5000000000000000, 63},
> +	{0x8000000000000000, 63},
> +	{0x8000300000000000, 64},
> +};
> +
>  static int __init test_bitops_startup(void)
>  {
>  	pr_warn("Loaded test module\n");
> @@ -32,6 +56,18 @@ static int __init test_bitops_startup(void)
>  	set_bit(BITOPS_11, g_bitmap);
>  	set_bit(BITOPS_31, g_bitmap);
>  	set_bit(BITOPS_88, g_bitmap);
> +
> +	for (i = 0; i < ARRAY_SIZE(order_comb); i++) {
> +		if (order_comb[i][1] != get_count_order(order_comb[i][0]))
> +			pr_warn("get_count_order wrong for %x\n",
> +				       order_comb[i][0]); }
> +
> +	for (i = 0; i < ARRAY_SIZE(order_comb_long); i++) {
> +		if (order_comb_long[i][1] !=
> +			       get_count_order_long(order_comb_long[i][0]))
> +			pr_warn("get_count_order_long wrong for %lx\n",
> +				       order_comb_long[i][0]); }
> +
>  	return 0;
>  }
>  
> @@ -55,6 +91,6 @@ static void __exit test_bitops_unstartup(void)
>  module_init(test_bitops_startup);
>  module_exit(test_bitops_unstartup);
>  
> -MODULE_AUTHOR("Jesse Brandeburg <jesse.brandeburg@intel.com>");
> +MODULE_AUTHOR("Jesse Brandeburg <jesse.brandeburg@intel.com>, Wei Yang <richard.weiyang@gmail.com>");
>  MODULE_LICENSE("GPL");
>  MODULE_DESCRIPTION("Bit testing module");
> -- 
> 2.23.0
> 

-- 
With Best Regards,
Andy Shevchenko


