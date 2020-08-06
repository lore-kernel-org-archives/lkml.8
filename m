Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9AF4C433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:48:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 012C7206B2
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:48:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="V0kKR174"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730465AbgHFRsM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 13:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728952AbgHFQfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 12:35:47 -0400
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF6A6C0A8937
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 08:05:26 -0700 (PDT)
Received: by mail-ua1-x942.google.com with SMTP id g11so2336943ual.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 08:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2574RlgF+iKSb8pLYcGAdJ2nQ/imhKaFZrt0sBio8rA=;
        b=V0kKR174Sjfx9VDdkI05TbPvA8HiaJEEicV+UecZM/xQeqVrUeFfh2LfH25y9Qpmf2
         bNfmtysveg5dnoVC9HaJACB06LZxhE4Z+PTpsbBPyFu0+n9+8nnNFvqf2vhCbUYeKGTg
         N68jHWYIPcG0s80seVHHpSqrJTsmH/A+xVVyg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2574RlgF+iKSb8pLYcGAdJ2nQ/imhKaFZrt0sBio8rA=;
        b=ldQS8hvQei9M1/DmePJaBUY2HLK8q+k/VbnQIAL51loZW8mTn6HdRwuDhi/c+dvMK9
         79qgygRWYObgUmp6Gulp8E/19aXWnWVlgbvK/wUdP3YcynTaNd3b8F4wsw6kpF5SlGQF
         44OcbZTRSV24xQfF4wMEkhUk/hBMcUSGRvuzAdBw1FoEPxyynvvWwVIVm7bFuaEP33va
         7ck/dzB/h6/VKFRQryT78orpgatLesk9iIhDs8t2byCuajEZ75JDJ35Kadm7rPg3X/Oj
         DH+3NpmCF/F4+lVyLDBNXQfhW77q6LT9f2sieGwcOnDoL8xbBeoLBwTkzHA9a/HKYd1O
         Lf+g==
X-Gm-Message-State: AOAM531NMbFyLEDC0hRBX6/o1GdcyZJe8U/Prcl7nj2OBin9QoQfTbE1
        8s7nA5a1TV6j5ay4KQvUHES8ITXMIRQ=
X-Google-Smtp-Source: ABdhPJy3cnE/49We7400yEA7TOg87tBtF61LfWMa58F/BsWzxj1PRzjtonmAiqnUGAOMvY4v8vgFCA==
X-Received: by 2002:ab0:4263:: with SMTP id i90mr6825664uai.35.1596726323559;
        Thu, 06 Aug 2020 08:05:23 -0700 (PDT)
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com. [209.85.217.44])
        by smtp.gmail.com with ESMTPSA id f10sm749888uad.5.2020.08.06.08.05.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2020 08:05:23 -0700 (PDT)
Received: by mail-vs1-f44.google.com with SMTP id y8so18035254vsq.8
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 08:05:22 -0700 (PDT)
X-Received: by 2002:a05:6102:213a:: with SMTP id f26mr6774155vsg.6.1596726321900;
 Thu, 06 Aug 2020 08:05:21 -0700 (PDT)
MIME-Version: 1.0
References: <20191019111216.1.I82eae759ca6dc28a245b043f485ca490e3015321@changeid>
 <20191120191813.GD4799@willie-the-truck> <CAD=FV=Wntf0TCwdtNNvPY-CXX1VL_SZK8Y8yw1r=UfeayHfwgw@mail.gmail.com>
In-Reply-To: <CAD=FV=Wntf0TCwdtNNvPY-CXX1VL_SZK8Y8yw1r=UfeayHfwgw@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 6 Aug 2020 08:05:10 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WgoVN-scgT41R=6Toif2Zrskb3rNzZn_xbP_-ByZC1MA@mail.gmail.com>
Message-ID: <CAD=FV=WgoVN-scgT41R=6Toif2Zrskb3rNzZn_xbP_-ByZC1MA@mail.gmail.com>
Subject: Re: [PATCH] ARM: hw_breakpoint: Handle inexact watchpoint addresses
To:     Will Deacon <will@kernel.org>, Russell King <linux@armlinux.org.uk>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Pavel Labath <labath@google.com>,
        Pratyush Anand <panand@redhat.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Kazuhiro Inaba <kinaba@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Guenter Roeck <groeck@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Dec 2, 2019 at 8:36 AM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Wed, Nov 20, 2019 at 11:18 AM Will Deacon <will@kernel.org> wrote:
> >
> > On Sat, Oct 19, 2019 at 11:12:26AM -0700, Douglas Anderson wrote:
> > > This is commit fdfeff0f9e3d ("arm64: hw_breakpoint: Handle inexact
> > > watchpoint addresses") but ported to arm32, which has the same
> > > problem.
> > >
> > > This problem was found by Android CTS tests, notably the
> > > "watchpoint_imprecise" test [1].  I tested locally against a copycat
> > > (simplified) version of the test though.
> > >
> > > [1] https://android.googlesource.com/platform/bionic/+/master/tests/sys_ptrace_test.cpp
> > >
> > > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > > ---
> > >
> > >  arch/arm/kernel/hw_breakpoint.c | 96 ++++++++++++++++++++++++---------
> > >  1 file changed, 70 insertions(+), 26 deletions(-)
> >
> > Sorry for taking so long to look at this. After wrapping my head around the
> > logic again
>
> Yeah.  It was a little weird and (unfortunately) arbitrarily different
> in some places compared to the arm64 code.
>
>
> > I think it looks fine, so please put it into the patch system
> > with my Ack:
> >
> > Acked-by: Will Deacon <will@kernel.org>
>
> Thanks!  Submitted as:
>
> https://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=8944/1

Oddly, I found that if I go visit that page now I see:

> - - - Note 2 submitted by Russell King on 17 Jan 2020 11:16:34 (UTC) - - -
> Moved to applied
>
> Applied to git-curr (misc branch).

Yet if I go check mainline the patch is not there.  This came to my
attention since we had my patch picked to the Chrome OS 4.19 tree and
suddenly recently got a stable merge conflict with "ARM: 8986/1:
hw_breakpoint: Don't invoke overflow handler on uaccess watchpoints".

Anyone know what happened here?

-Doug
