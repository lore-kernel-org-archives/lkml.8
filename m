Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47363C43468
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 11:14:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 883F922D05
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 11:14:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729357AbgHFKGA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 06:06:00 -0400
Received: from mga03.intel.com ([134.134.136.65]:7947 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729146AbgHFKFp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 06:05:45 -0400
IronPort-SDR: M2ASli/YHeQq9vVP6jKxQOx845Gy9NNDGM+EEdB/4FcneqSCZr5Qdt2YxwDQ5kquEDjaTG7sYW
 ANY+Hq9MBALA==
X-IronPort-AV: E=McAfee;i="6000,8403,9704"; a="152725388"
X-IronPort-AV: E=Sophos;i="5.75,441,1589266800"; 
   d="scan'208";a="152725388"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2020 03:05:45 -0700
IronPort-SDR: rE3lJhlRUXmwvLUip+sH/wzJoWOMlybFBgk21RUiVATUNM9Yo0xhByxdA6k/S9SOSHDpi+iupS
 1254V3QJHu8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,441,1589266800"; 
   d="scan'208";a="275037615"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga007.fm.intel.com with ESMTP; 06 Aug 2020 03:05:42 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1k3cmK-006p2q-Lr; Thu, 06 Aug 2020 13:05:40 +0300
Date:   Thu, 6 Aug 2020 13:05:40 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Arpitha Raghunandan <98.arpi@gmail.com>
Cc:     brendanhiggins@google.com, skhan@linuxfoundation.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] lib: Convert test_hexdump.c to KUnit
Message-ID: <20200806100540.GE3703480@smile.fi.intel.com>
References: <20200806094440.14962-1-98.arpi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200806094440.14962-1-98.arpi@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 06, 2020 at 03:14:40PM +0530, Arpitha Raghunandan wrote:
> Converts test lib/test_hexdump.c to KUnit.
> More information about KUnit can be found at
> https://www.kernel.org/doc/html/latest/dev-tools/kunit/index.html.
> KUnit provides a common framework for unit tests in the kernel.

...

> -	if (memcmp(test, real, TEST_HEXDUMP_BUF_SIZE)) {
> -		pr_err("Len: %zu row: %d group: %d\n", len, rowsize, groupsize);
> -		pr_err("Result: '%s'\n", real);
> -		pr_err("Expect: '%s'\n", test);
> -		failed_tests++;
> -	}
> +	KUNIT_EXPECT_EQ(kunittest, 0, memcmp(test, real, TEST_HEXDUMP_BUF_SIZE));


Ah, can you explain how user will see now what is being expected and what is in
reality in the buffer? I'm not gonna accept such changes without showing in
explicitly that user is not going to suffer of this change.

-- 
With Best Regards,
Andy Shevchenko


