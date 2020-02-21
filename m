Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04BE8C35669
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 23:16:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D94F224650
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 23:16:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729488AbgBUXQO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 18:16:14 -0500
Received: from mga14.intel.com ([192.55.52.115]:60327 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726290AbgBUXQM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 18:16:12 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Feb 2020 15:16:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,470,1574150400"; 
   d="scan'208";a="383595884"
Received: from jbrandeb-desk4.amr.corp.intel.com (HELO localhost) ([10.166.241.50])
  by orsmga004.jf.intel.com with ESMTP; 21 Feb 2020 15:16:11 -0800
Date:   Fri, 21 Feb 2020 15:16:11 -0800
From:   Jesse Brandeburg <jesse.brandeburg@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <x86@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux@rasmusvillemoes.dk>, <dan.j.williams@intel.com>,
        <peterz@infradead.org>
Subject: Re: [PATCH v3 2/2] lib: make a test module with set/clear bit
Message-ID: <20200221151611.00003b17@intel.com>
In-Reply-To: <20200221102518.GM10400@smile.fi.intel.com>
References: <20200220232155.2123827-1-jesse.brandeburg@intel.com>
        <20200220232155.2123827-2-jesse.brandeburg@intel.com>
        <20200221102518.GM10400@smile.fi.intel.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Feb 2020 12:25:18 +0200 Andy wrote:
> On Thu, Feb 20, 2020 at 03:21:55PM -0800, Jesse Brandeburg wrote:
> > Test some bit clears/sets to make sure assembly doesn't change, and
> > that the set_bit and clear_bit functions work and don't cause sparse
> > warnings.
> > 
> > Instruct Kbuild to build this file with extra warning level -Wextra,
> > to catch new issues, and also doesn't hurt to build with C=1.
> > 
> > This was used to test changes to arch/x86/include/asm/bitops.h.
> > 
> > In particular, sparse (C=1) was very concerned when the last bit
> > before a natural boundary, like 7, or 31, was being tested, as this
> > causes sign extension (0xffffff7f) for instance when clearing bit 7.
> > 
> > Recommended usage:
> > make defconfig
> > scripts/config -m CONFIG_TEST_BITOPS
> > make modules_prepare
> > make C=1 W=1 lib/test_bitops.ko
> > objdump -S -d lib/test_bitops.ko  
> 
> Thanks!
> One comments below, after addressing:
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

Thanks!

> 	BITOPS_LAST = 255,
> 	BITOPS_LENGTH = 256
> 
> and...
> 
> static DECLARE_BITMAP(g_bitmap, BITOPS_LENGTH);

Fixed in v4
