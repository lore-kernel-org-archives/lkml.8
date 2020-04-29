Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDB7CC83003
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 10:16:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7C76217D8
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 10:16:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbgD2KQ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 06:16:27 -0400
Received: from mga01.intel.com ([192.55.52.88]:23799 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726526AbgD2KQ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 06:16:26 -0400
IronPort-SDR: S0tlMSvjxlAN/dvKaU8teQdUqN2tV2Fac7W47Kq2Md5ZP1ZIQZSt9Y41kibpq3HzOtssDwnpCi
 FYIGciF87Wgw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2020 03:16:25 -0700
IronPort-SDR: ngckBcLrKNJFRp8xmTszNq8Xur4yS1Mm54nHARqiJhCoUke7GLa0SK7o2I+riwHxLGqgZHxR9h
 PGBBxZ9r9Tow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,331,1583222400"; 
   d="scan'208";a="302959240"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by FMSMGA003.fm.intel.com with ESMTP; 29 Apr 2020 03:16:24 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jTjlT-003htc-Ne; Wed, 29 Apr 2020 13:16:27 +0300
Date:   Wed, 29 Apr 2020 13:16:27 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Syed Nayyar Waris <syednwaris@gmail.com>
Cc:     akpm@linux-foundation.org, vilhelm.gray@gmail.com,
        linus.walleij@linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/4] lib/test_bitmap.c: Add for_each_set_clump test
 cases
Message-ID: <20200429101627.GD185537@smile.fi.intel.com>
References: <cover.1588112714.git.syednwaris@gmail.com>
 <46108644a1cc2750e281c33fd0efe99bd57c50e2.1588112715.git.syednwaris@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46108644a1cc2750e281c33fd0efe99bd57c50e2.1588112715.git.syednwaris@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 29, 2020 at 04:35:58AM +0530, Syed Nayyar Waris wrote:
> The introduction of the generic for_each_set_clump macro need test
> cases to verify the implementation. This patch adds test cases for
> scenarios in which clump sizes are 8 bits, 24 bits, 30 bits and 6 bits.
> The cases contain situations where clump is getting split at the word
> boundary and also when zeroes are present in the start and middle of
> bitmap.

...

> +static void __init test_for_each_set_clump(void)
> +{
> +	/* common bitmap of max size for different tests */
> +	DECLARE_BITMAP(bits, 256);
> +
> +	/* set bitmap for test case 1 with clump size as 8 bits */
> +	bitmap_set_value(bits, 0x38000201, 0, 32);
> +	bitmap_set_value(bits, 0x05ff0f38, 32, 32);
> +
> +	execute_for_each_set_clump(bits, 64, clump_exp1, 8);
> +
> +	/* set bitmap for test case 2 with clump size as 24 bits */
> +	bitmap_set_value(bits, 0xeffedcba, 0, 32);
> +	bitmap_set_value(bits, 0xbbbbabcd, 32, 32);
> +	bitmap_set_value(bits, 0x000000aa, 64, 32);
> +	bitmap_set_value(bits, 0x000000aa, 96, 32);
> +	bitmap_set_value(bits, 0x00ff0000, 128, 32);
> +	bitmap_set_value(bits, 0xaaaaaa00, 160, 32);
> +	bitmap_set_value(bits, 0xff000000, 192, 32);
> +	bitmap_set_value(bits, 0x00aa0000, 224, 32);
> +
> +	execute_for_each_set_clump(bits, 240, clump_exp2, 24);
> +
> +	/* set bitmap for test case 3 with clump size as 30 bits */
> +	bitmap_set_value(bits, 0x00000000, 0, 32);
> +	bitmap_set_value(bits, 0x00000000, 32, 32);
> +	bitmap_set_value(bits, 0x00000000, 64, 32);
> +	bitmap_set_value(bits, 0x0f000000, 96, 32);
> +
> +	execute_for_each_set_clump(bits, 240, clump_exp3, 30);
> +
> +	/* set bitmap for test case 4 with clump size as 6 bits */
> +	bitmap_set_value(bits, 0x00000ac0, 0, 32);
> +	execute_for_each_set_clump(bits, 18, clump_exp4, 6);

You can roll entire function into one loop

	for i in ARRAY(test_data_configuration):
		prepare_test_data()
		execute_test()

> +}

-- 
With Best Regards,
Andy Shevchenko


