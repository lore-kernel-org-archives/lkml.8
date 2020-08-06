Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68957C433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 16:27:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C80423119
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 16:27:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Bcrgi5QW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728268AbgHFQ1s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 12:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727852AbgHFQSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 12:18:47 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39601C0D942B
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 08:45:28 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id r7so8551051vsq.5
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 08:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xElNgfkVHDPC4sqUWluN88xy7lPnIILHrEinFfAygbQ=;
        b=Bcrgi5QWbcUXRBVbnwaHLfdfY8Iw9QYXkPVVl5h73OgZ2XPOkoet/e1plhnYnmHcxn
         VrthHnb7hjFtEf59ZKcfQLfdZJI/8/Eju4AcM1js70HAuA0ir1XeNBc7anyAImyFiiNU
         gREefwt423+uA+HS6v26+6PSpLBMLo8bSmq1w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xElNgfkVHDPC4sqUWluN88xy7lPnIILHrEinFfAygbQ=;
        b=Js53i9zBTFXg8oTshLvjVZ7r0TJAu6G/gcnGPxLSutR+kCYH4eMRnryf/d0Ic1kYjd
         LgeHPFLgkIGvplMgiPbKaqCRXiuuf9BkmCgkVw699k+9mvg7FTt45C3fI+KZuUS0PGMA
         mXRNIHt25q1aF7l6cL6ZIxS1QQF+f0sReC78/RueXy5pJUfr4X50SvzK5j5xyvZR8FQy
         +4gclCP92AHlTqUbGRliVimyS2abccJ9wCuvmhcF0ATRJPF+DfVp7kwxFOFZm5TIbPmN
         /7h1IOTU+tIh9QXctKbThSQqWyLgTNdxlwbwlLQz2BV7Y6kdL9H+Q+EYKmFt6TT6LyB/
         mdlQ==
X-Gm-Message-State: AOAM531f7nb2g+OL4hKzM2YlrHiTcYNQvmicz7SFs1kK3kgVSedeF7WM
        vP2joytygrUFIix1Jy7GhPd44zPiDWY=
X-Google-Smtp-Source: ABdhPJzur+Vo8KF7qvTZklv3F76db/KrvrILFCJE4rnA++TGqyo6baadUzbN4XfnUK8taMQixzUyKg==
X-Received: by 2002:a67:fb0f:: with SMTP id d15mr7317338vsr.83.1596728726424;
        Thu, 06 Aug 2020 08:45:26 -0700 (PDT)
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com. [209.85.217.53])
        by smtp.gmail.com with ESMTPSA id n62sm1084402vke.12.2020.08.06.08.45.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2020 08:45:26 -0700 (PDT)
Received: by mail-vs1-f53.google.com with SMTP id r7so8550994vsq.5
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 08:45:25 -0700 (PDT)
X-Received: by 2002:a67:fd67:: with SMTP id h7mr6443874vsa.121.1596728724905;
 Thu, 06 Aug 2020 08:45:24 -0700 (PDT)
MIME-Version: 1.0
References: <20191019111216.1.I82eae759ca6dc28a245b043f485ca490e3015321@changeid>
 <20191120191813.GD4799@willie-the-truck> <CAD=FV=Wntf0TCwdtNNvPY-CXX1VL_SZK8Y8yw1r=UfeayHfwgw@mail.gmail.com>
 <CAD=FV=WgoVN-scgT41R=6Toif2Zrskb3rNzZn_xbP_-ByZC1MA@mail.gmail.com> <20200806154144.GD1551@shell.armlinux.org.uk>
In-Reply-To: <20200806154144.GD1551@shell.armlinux.org.uk>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 6 Aug 2020 08:45:13 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XBinO0+uSt_sDTw_YFiZC4Gf8RMSC9ycDg+RWH=63Tog@mail.gmail.com>
Message-ID: <CAD=FV=XBinO0+uSt_sDTw_YFiZC4Gf8RMSC9ycDg+RWH=63Tog@mail.gmail.com>
Subject: Re: [PATCH] ARM: hw_breakpoint: Handle inexact watchpoint addresses
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Pratyush Anand <panand@redhat.com>,
        Pavel Labath <labath@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Kazuhiro Inaba <kinaba@google.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Aug 6, 2020 at 8:41 AM Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
>
> On Thu, Aug 06, 2020 at 08:05:10AM -0700, Doug Anderson wrote:
> > Hi,
> >
> > On Mon, Dec 2, 2019 at 8:36 AM Doug Anderson <dianders@chromium.org> wrote:
> > >
> > > Hi,
> > >
> > > On Wed, Nov 20, 2019 at 11:18 AM Will Deacon <will@kernel.org> wrote:
> > > >
> > > > On Sat, Oct 19, 2019 at 11:12:26AM -0700, Douglas Anderson wrote:
> > > > > This is commit fdfeff0f9e3d ("arm64: hw_breakpoint: Handle inexact
> > > > > watchpoint addresses") but ported to arm32, which has the same
> > > > > problem.
> > > > >
> > > > > This problem was found by Android CTS tests, notably the
> > > > > "watchpoint_imprecise" test [1].  I tested locally against a copycat
> > > > > (simplified) version of the test though.
> > > > >
> > > > > [1] https://android.googlesource.com/platform/bionic/+/master/tests/sys_ptrace_test.cpp
> > > > >
> > > > > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > > > > ---
> > > > >
> > > > >  arch/arm/kernel/hw_breakpoint.c | 96 ++++++++++++++++++++++++---------
> > > > >  1 file changed, 70 insertions(+), 26 deletions(-)
> > > >
> > > > Sorry for taking so long to look at this. After wrapping my head around the
> > > > logic again
> > >
> > > Yeah.  It was a little weird and (unfortunately) arbitrarily different
> > > in some places compared to the arm64 code.
> > >
> > >
> > > > I think it looks fine, so please put it into the patch system
> > > > with my Ack:
> > > >
> > > > Acked-by: Will Deacon <will@kernel.org>
> > >
> > > Thanks!  Submitted as:
> > >
> > > https://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=8944/1
> >
> > Oddly, I found that if I go visit that page now I see:
> >
> > > - - - Note 2 submitted by Russell King on 17 Jan 2020 11:16:34 (UTC) - - -
> > > Moved to applied
> > >
> > > Applied to git-curr (misc branch).
> >
> > Yet if I go check mainline the patch is not there.  This came to my
> > attention since we had my patch picked to the Chrome OS 4.19 tree and
> > suddenly recently got a stable merge conflict with "ARM: 8986/1:
> > hw_breakpoint: Don't invoke overflow handler on uaccess watchpoints".
> >
> > Anyone know what happened here?
>
> Yes.  Stephen Rothwell raised a complaint against it, which you were
> copied with:

Was a mailing list copied?  If so, do you have a lore.kernel.org link?
 I certainly don't see the email so I can only assume it made it to
spam.  That's unfortunate.


> > Hi all,
> >
> > Commit
> >
> >   116375be0461 ("ARM: 8944/1: hw_breakpoint: Handle inexact watchpoint addresses")
> >
> > is missing a Signed-off-by from its author.
>
> My reply to Stephen's email was:
>
> > Thanks Stephen, patch dropped.
> >
> > It looks like Doug used his "m.disordat.com" address to submit the
> > patch through the web interface, and there was no From: in the patch
> > itself, so that was used as the patch author.  However, as you spotted,
> > it was signed off using Doug's "chromium.org" address.
> >
> > I think it's time to make the patch system a bit more strict, checking
> > that the submission address is mentioned in a signed-off-by tag
> > somewhere in the commit message.
> >
> > Doug, the patch system does have your "chromium.org" address, if that's
> > the one you want to use as the author, please submit using that instead.
> > Thanks.
> >
> > Russell.
>
> Neither email got a response from you, so the patch was dropped and
> nothing further happened.

OK, I guess I'll have to rebase and resend.

-Doug
