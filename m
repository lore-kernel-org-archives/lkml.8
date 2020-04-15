Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14CC9C3815B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 14:46:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF9F4208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 14:46:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S371003AbgDOOqs (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 10:46:48 -0400
Received: from mga12.intel.com ([192.55.52.136]:42113 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2636826AbgDOOqY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 10:46:24 -0400
IronPort-SDR: jOvm0gSr9FkuZuW2D8Xo3mgDAlGa+bu7bw+c5TgNjfERXtjDBbU6IrqXdi278ZhowiGzm2wpoI
 9OGHYugs9Eew==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2020 07:46:23 -0700
IronPort-SDR: WvJ3PfNSp0d4D/Q+EZpiBrFV5G6/LgKF3nwB5ZW685xLF8l3b3NYIHz591kAaouOVGf4R0uFYi
 x8W7L0gDFqvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,387,1580803200"; 
   d="scan'208";a="332518010"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga001.jf.intel.com with ESMTP; 15 Apr 2020 07:46:20 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1jOjJ1-000oBP-4O; Wed, 15 Apr 2020 17:46:23 +0300
Date:   Wed, 15 Apr 2020 17:46:23 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Jesse Brandeburg <jesse.brandeburg@intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux@rasmusvillemoes.dk,
        dan.j.williams@intel.com, peterz@infradead.org
Subject: Re: [PATCH v6 2/2] lib: make a test module with set/clear bit
Message-ID: <20200415144623.GJ185537@smile.fi.intel.com>
References: <20200310221747.2848474-1-jesse.brandeburg@intel.com>
 <20200310221747.2848474-2-jesse.brandeburg@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200310221747.2848474-2-jesse.brandeburg@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 10, 2020 at 03:17:47PM -0700, Jesse Brandeburg wrote:
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
> insmod lib/test_bitops.ko
> rmmod lib/test_bitops.ko
> <check dmesg>, there should be no compiler/sparse warnings and no
> error messages in log.

Seems this didn't make the kernel. Perhaps you need to send it to Andrew Morton.

-- 
With Best Regards,
Andy Shevchenko


