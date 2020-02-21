Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFF9CC35647
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 10:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE997207FD
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 10:25:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728743AbgBUKZU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 05:25:20 -0500
Received: from mga18.intel.com ([134.134.136.126]:22337 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726989AbgBUKZU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 05:25:20 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Feb 2020 02:25:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,467,1574150400"; 
   d="scan'208";a="225179022"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga007.jf.intel.com with ESMTP; 21 Feb 2020 02:25:16 -0800
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1j55Uk-003kb5-Er; Fri, 21 Feb 2020 12:25:18 +0200
Date:   Fri, 21 Feb 2020 12:25:18 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Jesse Brandeburg <jesse.brandeburg@intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux@rasmusvillemoes.dk,
        dan.j.williams@intel.com, peterz@infradead.org
Subject: Re: [PATCH v3 2/2] lib: make a test module with set/clear bit
Message-ID: <20200221102518.GM10400@smile.fi.intel.com>
References: <20200220232155.2123827-1-jesse.brandeburg@intel.com>
 <20200220232155.2123827-2-jesse.brandeburg@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200220232155.2123827-2-jesse.brandeburg@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2020 at 03:21:55PM -0800, Jesse Brandeburg wrote:
> Test some bit clears/sets to make sure assembly doesn't change, and
> that the set_bit and clear_bit functions work and don't cause sparse
> warnings.
> 
> Instruct Kbuild to build this file with extra warning level -Wextra,
> to catch new issues, and also doesn't hurt to build with C=1.
> 
> This was used to test changes to arch/x86/include/asm/bitops.h.
> 
> In particular, sparse (C=1) was very concerned when the last bit
> before a natural boundary, like 7, or 31, was being tested, as this
> causes sign extension (0xffffff7f) for instance when clearing bit 7.
> 
> Recommended usage:
> make defconfig
> scripts/config -m CONFIG_TEST_BITOPS
> make modules_prepare
> make C=1 W=1 lib/test_bitops.ko
> objdump -S -d lib/test_bitops.ko

Thanks!
One comments below, after addressing:
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> 
> ---
> v3: update the test to fail if bits aren't cleared, and make the
> test reproduce the original issue without patch 1/2, showing that
> the issue is fixed in patch 1/2. Thanks PeterZ!
> v2: correct CC: list
> ---
>  lib/Kconfig.debug                  | 13 +++++++
>  lib/Makefile                       |  2 ++
>  lib/test_bitops.c                  | 55 ++++++++++++++++++++++++++++++
>  tools/testing/selftests/lib/config |  1 +
>  4 files changed, 71 insertions(+)
>  create mode 100644 lib/test_bitops.c
> 
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 69def4a9df00..61a5d00ea064 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -1947,6 +1947,19 @@ config TEST_LKM
>  
>  	  If unsure, say N.
>  
> +config TEST_BITOPS
> +	tristate "Test module for compilation of clear_bit/set_bit operations"
> +	depends on m
> +	help
> +	  This builds the "test_bitops" module that is much like the
> +	  TEST_LKM module except that it does a basic exercise of the
> +	  clear_bit and set_bit macros to make sure there are no compiler
> +	  warnings from C=1 sparse checker or -Wextra compilations. It has
> +	  no dependencies and doesn't run or load unless explicitly requested
> +	  by name.  for example: modprobe test_bitops.
> +
> +	  If unsure, say N.
> +
>  config TEST_VMALLOC
>  	tristate "Test module for stress/performance analysis of vmalloc allocator"
>  	default n
> diff --git a/lib/Makefile b/lib/Makefile
> index 611872c06926..b18db565b355 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -89,6 +89,8 @@ obj-$(CONFIG_TEST_OBJAGG) += test_objagg.o
>  obj-$(CONFIG_TEST_STACKINIT) += test_stackinit.o
>  obj-$(CONFIG_TEST_BLACKHOLE_DEV) += test_blackhole_dev.o
>  obj-$(CONFIG_TEST_MEMINIT) += test_meminit.o
> +obj-$(CONFIG_TEST_BITOPS) += test_bitops.o
> +CFLAGS_test_bitops.o += -Werror
>  
>  obj-$(CONFIG_TEST_LIVEPATCH) += livepatch/
>  
> diff --git a/lib/test_bitops.c b/lib/test_bitops.c
> new file mode 100644
> index 000000000000..97339d6455b0
> --- /dev/null
> +++ b/lib/test_bitops.c
> @@ -0,0 +1,55 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/printk.h>
> +
> +/* a tiny module only meant to compile-test set/clear_bit */
> +
> +/* use an enum because thats the most common BITMAP usage */
> +enum bitops_fun {
> +	BITOPS_4 = 4,
> +	BITOPS_7 = 7,
> +	BITOPS_11 = 11,
> +	BITOPS_31 = 31,
> +	BITOPS_88 = 88,
> +	BITOPS_LAST = 255

	BITOPS_LAST = 255,
	BITOPS_LENGTH = 256

and...

> +};
> +
> +static DECLARE_BITMAP(g_bitmap, BITOPS_LAST);

static DECLARE_BITMAP(g_bitmap, BITOPS_LENGTH);

> +
> +static int __init test_bitops_startup(void)
> +{
> +	pr_warn("Loaded test module\n");
> +	set_bit(BITOPS_4, g_bitmap);
> +	set_bit(BITOPS_7, g_bitmap);
> +	set_bit(BITOPS_11, g_bitmap);
> +	set_bit(BITOPS_31, g_bitmap);
> +	set_bit(BITOPS_88, g_bitmap);
> +	return 0;
> +}
> +
> +static void __exit test_bitops_unstartup(void)
> +{
> +	int bit_set;
> +
> +	clear_bit(BITOPS_4, g_bitmap);
> +	clear_bit(BITOPS_7, g_bitmap);
> +	clear_bit(BITOPS_11, g_bitmap);
> +	clear_bit(BITOPS_31, g_bitmap);
> +	clear_bit(BITOPS_88, g_bitmap);
> +
> +	bit_set = find_first_bit(g_bitmap, BITOPS_LAST);
> +	if (bit_set != BITOPS_LAST)
> +		pr_err("ERROR: FOUND SET BIT %d\n", bit_set);
> +
> +	pr_warn("Unloaded test module\n");
> +}
> +
> +module_init(test_bitops_startup);
> +module_exit(test_bitops_unstartup);
> +
> +MODULE_AUTHOR("Jesse Brandeburg <jesse.brandeburg@intel.com>");
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("Bit testing module");
> diff --git a/tools/testing/selftests/lib/config b/tools/testing/selftests/lib/config
> index 14a77ea4a8da..b80ee3f6e265 100644
> --- a/tools/testing/selftests/lib/config
> +++ b/tools/testing/selftests/lib/config
> @@ -2,3 +2,4 @@ CONFIG_TEST_PRINTF=m
>  CONFIG_TEST_BITMAP=m
>  CONFIG_PRIME_NUMBERS=m
>  CONFIG_TEST_STRSCPY=m
> +CONFIG_TEST_BITOPS=m
> -- 
> 2.24.1
> 

-- 
With Best Regards,
Andy Shevchenko


