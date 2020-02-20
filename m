Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 674F7C11D0C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 19:03:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40184206F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 19:03:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728907AbgBTTDt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 14:03:49 -0500
Received: from mga11.intel.com ([192.55.52.93]:7877 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728646AbgBTTDs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 14:03:48 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Feb 2020 11:03:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,465,1574150400"; 
   d="scan'208";a="259372904"
Received: from jbrandeb-desk4.amr.corp.intel.com (HELO localhost) ([10.166.241.50])
  by fmsmga004.fm.intel.com with ESMTP; 20 Feb 2020 11:03:48 -0800
Date:   Thu, 20 Feb 2020 11:03:47 -0800
From:   Jesse Brandeburg <jesse.brandeburg@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <x86@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux@rasmusvillemoes.dk>, <andriy.shevchenko@intel.com>,
        <dan.j.williams@intel.com>
Subject: Re: [PATCH v2 2/2] lib: make a test module with set/clear bit
Message-ID: <20200220110347.00005557@intel.com>
In-Reply-To: <20200220181033.GW14897@hirez.programming.kicks-ass.net>
References: <20200220173722.2034546-1-jesse.brandeburg@intel.com>
        <20200220173722.2034546-2-jesse.brandeburg@intel.com>
        <20200220181033.GW14897@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Feb 2020 19:10:33 +0100 Peter wrote:
> On Thu, Feb 20, 2020 at 09:37:22AM -0800, Jesse Brandeburg wrote:
> > Test some bit clears/sets to make sure assembly doesn't change.
> > Instruct Kbuild to build this file with extra warning level -Wextra,
> > to catch new issues, and also doesn't hurt to build with C=1.
> > 
> > This was used to test changes to arch/x86/include/asm/bitops.h.
> > 
> > Recommended usage:
> > make defconfig
> > scripts/config -m CONFIG_TEST_BITOPS
> > make modules_prepare
> > make C=1 W=1 lib/test_bitops.ko
> > objdump -S -d lib/test_bitops.ko  
> 
> I only applied this second patch:
> 
> # sparse --version
> 0.6.0 (Debian: 0.6.0-3+b1)

Thanks for the review! The module was created to verify assembly didn't
change before/after, but it's not a reproducer.  Let me fix that (I had
skipped that step as I originally didn't plan to upstream the
test-patch).


