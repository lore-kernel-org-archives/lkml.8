Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97E67C35DE1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 11:52:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7437E21556
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 11:52:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730132AbgBYLwV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 06:52:21 -0500
Received: from mga05.intel.com ([192.55.52.43]:11152 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729976AbgBYLwU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 06:52:20 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Feb 2020 03:52:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,484,1574150400"; 
   d="scan'208";a="271280971"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga002.fm.intel.com with ESMTP; 25 Feb 2020 03:52:18 -0800
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1j6Yl9-004eDR-MA; Tue, 25 Feb 2020 13:52:19 +0200
Date:   Tue, 25 Feb 2020 13:52:19 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Jesse Brandeburg <jesse.brandeburg@intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux@rasmusvillemoes.dk,
        dan.j.williams@intel.com, peterz@infradead.org
Subject: Re: [PATCH v5 1/2] x86: fix bitops.h warning with a moved cast
Message-ID: <20200225115219.GI10400@smile.fi.intel.com>
References: <20200224225020.2212544-1-jesse.brandeburg@intel.com>
 <20200225103050.GD10400@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200225103050.GD10400@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2020 at 12:30:50PM +0200, Andy Shevchenko wrote:
> On Mon, Feb 24, 2020 at 02:50:19PM -0800, Jesse Brandeburg wrote:
> > Fix many sparse warnings when building with C=1.
> > 
> > When the kernel is compiled with C=1, there are lots of messages like:
> >   arch/x86/include/asm/bitops.h:77:37: warning: cast truncates bits from constant value (ffffff7f becomes 7f)
> > 
> > CONST_MASK() is using a signed integer "1" to create the mask which
> > is later cast to (u8) when used, in order to yield an 8-bit value
> > for the assembly instructions to use. Simplify the expressions used to
> > clearly indicate they are working on 8-bit values only, which still
> > keeps sparse happy without an accidental promotion to a 32 bit integer.
> > 
> 
> > The reason the warning was occurring is because certain bitmasks that
> > end with a mask next to a natural boundary like 7, 15, 23, 31, end up
> > with a mask like 0x7f, which then results in sign extension when doing
> > an invert (but I'm not a compiler expert). It was really only
> > "clear_bit" that was having problems, and it was only on bit checks next
> > to a byte boundary (top bit).
> 
> I guess this describes it incorrectly.

Forget about it, I looked at the warning again and there is the 0x7f byte at
the end. Sorry for noise.

> I think it is a C standard which dictates this, compiler just follows.

-- 
With Best Regards,
Andy Shevchenko


