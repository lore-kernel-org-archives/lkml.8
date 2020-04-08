Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA8D1C2D0EA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 15:06:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8C4B206F5
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 15:06:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729306AbgDHPGo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 11:06:44 -0400
Received: from mga12.intel.com ([192.55.52.136]:4138 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727847AbgDHPGo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 11:06:44 -0400
IronPort-SDR: B/ZOfr77uwxDHY7CwRYVz4hna9ZIEv+rnsQ1ViKJaV8d5DlSoG4H3sLHf0Ab114t/QX1zCs+Du
 gx/Ajt7LWs5A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2020 08:06:44 -0700
IronPort-SDR: LlYEfILq9fYp4D3uP+cXMTtLzhNNhAr5kEswEiwG4ii4YzqX4eb3oVjs+4xXbI2ZdK05zfwKPA
 RLc2DAGP7/kg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,359,1580803200"; 
   d="scan'208";a="286571815"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga002.fm.intel.com with ESMTP; 08 Apr 2020 08:06:41 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1jMCHr-00Gj7h-Vj; Wed, 08 Apr 2020 18:06:43 +0300
Date:   Wed, 8 Apr 2020 18:06:43 +0300
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Ilya Dryomov <idryomov@gmail.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Petr Mladek <pmladek@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        "Tobin C . Harding" <me@tobin.cc>
Subject: Re: [PATCH v2] vsprintf: don't obfuscate NULL and error pointers
Message-ID: <20200408150643.GD3676135@smile.fi.intel.com>
References: <20200219171225.5547-1-idryomov@gmail.com>
 <CAHp75Vf24yNeLEweq_70AUzKwbdyurB6ze9739Qy9djA9dSefg@mail.gmail.com>
 <CAOi1vP9gfMoU14Ax+VLksQ+_3yOO3m3bh0Uh02SUMfPFDDEW9g@mail.gmail.com>
 <CAOi1vP8NN=8e8kW6g7KegUt52auJoE53ZCdEQHv2DMqFe1=g0Q@mail.gmail.com>
 <CAOi1vP9t=kq0M91rJXbXa1pj43eczsHw+0Y5Km30tQP5AJrs2g@mail.gmail.com>
 <CAHp75VfvUN=E-_n8VAKQ9nQ7mr2hbjS38bYCBbCdh02pxphOwg@mail.gmail.com>
 <CAOi1vP-K-AwzPqdHHDFDvef_nLPx3pr2NnQnSo5Emvsc1hF7Cg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOi1vP-K-AwzPqdHHDFDvef_nLPx3pr2NnQnSo5Emvsc1hF7Cg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 08, 2020 at 04:38:25PM +0200, Ilya Dryomov wrote:
> On Wed, Apr 8, 2020 at 12:31 AM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> >
> > On Wed, Apr 8, 2020 at 12:45 AM Ilya Dryomov <idryomov@gmail.com> wrote:
> > > On Wed, Feb 19, 2020 at 8:23 PM Ilya Dryomov <idryomov@gmail.com> wrote:
> >
> > > Hi Petr,
> > >
> > > Bump, as I don't see this in linux-next or other public branches.
> > > The discussion was split between several threads, revolving around
> > > the vision for how lib/test_printf.c should be structured, but the
> > > fix itself wasn't disputed.
> > >
> > > Could you please pick it up for 5.7-rc1?  If you want to restructure
> > > the test suite before adding any new test cases, v1 doesn't have them.
> > > Other than the test cases, the only difference between v1 and v2 is
> > > added reviews and acks.
> >
> > Petr has some obstacles that prevent him to pay attention on this and
> > actually do anything right now for Linux kernel.
> > If Rasmus, Sergey, you and maybe others will got consensus here, I
> > think Andrew can take it thru his tree.
> 
> Thanks for letting us know, Andy.
> 
> Other than Petr, two people are listed as maintainers of vsprintf.c:
> Sergey and Steve.  Both of them were fine with v1 (no tests) and sent
> their acks.
> 
> Rasmus, you wanted to see some tests, so I posted v2.  However Petr
> wanted to restructure the test suite first, and it didn't seem like you
> him agreed on what exactly that should look like.  Which would you
> prefer to be picked by Andrew, v1 or v2?

I think it's question to maintainers. I'm a reviewer here.

For the better understanding the current state of affairs I suggest to respin
new version after rc1 and we will see again.

-- 
With Best Regards,
Andy Shevchenko


