Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D82F9C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 19:11:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFD15207DD
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 19:11:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wves+/+X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728213AbgEFTLh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 15:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725915AbgEFTLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 15:11:36 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEFE2C061A0F
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 12:11:35 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id r25so2773326oij.4
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 12:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M1S9qPXBUJql9JmKoVhTWc9F3kKNmnoGb/SmJ6xO5Fs=;
        b=Wves+/+XLXygjtxkWvW3RBKz34DM6vuEPqF0sDZQYhW+P/zfKecqzhJ30qSYBKt5gT
         Z2b6EL6Aehoe3uKYIQmYSPZFiNsLntlO1GyZ5FS084kysMY6DSKzoUS1EXRNdcTSXVTy
         sKPtcwE0bL93LwlHv+dE6zhPTtGBDm6vF8njlTdYP1n/urMy8GDNo03HuIojVBE0vbW4
         NbBay64XpACnPE6YHE3CCwWN0RIwE/MXtFG9PiRX1m8VYSvN6ck1bqMup8O/Ztt7IMtv
         Y8C60zeyBGQ/MSgrdeJX0P2buUxKULO8qrHNlJDbQ4WU95Pvb2l2XuHLD0WybYhaqxez
         CZXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M1S9qPXBUJql9JmKoVhTWc9F3kKNmnoGb/SmJ6xO5Fs=;
        b=SH84k3TwbhCMJ3WsqxoNzBJHWZbLT+7QzD7Oy0rB8S22wAj2EcNHuNsgb+sCCxC/nf
         hPPhRyCPiXgL6aK54fIHHWFAbYSjXdWCrvH5QCVZYNCWQpzPvXTi1/L5qt2DYhHRdsk2
         IQcvs69qtyPJsWHluOxSeEoyMZTDsTM42TK6dCSYwJd1biOoaKg2IDpbF/A9WXp8oh97
         qOW/ZfenI4ZdJymuL0IVaVFWQK8Bip+pM6fUpeZugI4htXIbpYZFNWsf6uXVy40ISc/6
         J1BU6F/likOKxmF7p2/7Lynf0a+jnoAwCQxZbvF8UZfFXKBNQkesTi+1IHz6iQHxF8HL
         xd8g==
X-Gm-Message-State: AGi0PubrMrYr2PNhOFfEMwr4GhM0+yu24Y70RDNwu/vSbi4xisF6sWwd
        KbooIiHi/OwBnPnZRtVuEkXLvuLvImZkoVsygBJBwpW/1LA=
X-Google-Smtp-Source: APiQypLdL6vl6Mi1sC5j4woNIvCmulwIhICzfUgyQcKzymmV6NSaI6fBdShg0F2/WBDryDL/LL3KeqLtGhNizIcJBz0=
X-Received: by 2002:a05:6808:b36:: with SMTP id t22mr3881236oij.121.1588792294261;
 Wed, 06 May 2020 12:11:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200506132816.GJ8043@willie-the-truck> <20200506143616.GY2869@paulmck-ThinkPad-P72>
 <20200506144141.GA12919@willie-the-truck> <CANpmjNP3ge49sXJZS-KaL5bpEq0rmc4CqepjGRbtbCVwm7rwpw@mail.gmail.com>
 <20200506180232.GB2869@paulmck-ThinkPad-P72>
In-Reply-To: <20200506180232.GB2869@paulmck-ThinkPad-P72>
From:   Marco Elver <elver@google.com>
Date:   Wed, 6 May 2020 21:11:23 +0200
Message-ID: <CANpmjNP1v8wORd_nfQb7hVH2EY5P565uJYsRFt0dXi4KZvQ46A@mail.gmail.com>
Subject: Re: Please can I have a stable KCSAN branch for 5.8?
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Will Deacon <will@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 May 2020 at 20:02, Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Wed, May 06, 2020 at 05:26:56PM +0200, Marco Elver wrote:
> > On Wed, 6 May 2020 at 16:41, Will Deacon <will@kernel.org> wrote:
> > >
> > > Hi Paul,
> > >
> > > Cheers for the quick reply!
> > >
> > > On Wed, May 06, 2020 at 07:36:16AM -0700, Paul E. McKenney wrote:
> > > > On Wed, May 06, 2020 at 02:28:17PM +0100, Will Deacon wrote:
> > > > > I'm looking to rebase my READ_ONCE() series [1] on top of the KCSAN patches
> > > > > so that we can get them in for 5.8. However, tip/locking/kcsan seems to be
> > > > > missing some bits:
> > > > >
> > > > >   * An update to checkpatch.pl to warn about missing comments for
> > > > >     data_race():
> > > > >
> > > > >     https://lore.kernel.org/r/20200401101714.44781-1-elver@google.com
> > > >
> > > > For some reason, I thought this was going up some other tree, but I do
> > > > not see it in -next.  So unless I hear otherwise, I will pull it into
> > > > the v5.8 kcsan branch.
> > >
> > > Brill, thanks.
> > >
> > > > >   * I'm unable to apply these two patches from Marco that are needed for
> > > > >     my READ_ONCE() work:
> > > > >
> > > > >     https://lore.kernel.org/lkml/20200424154730.190041-1-elver@google.com/
> > > > >
> > > > >     I think these depend on stuff that has been queued by Paul, and appears
> > > > >     in linux-next, but to be honest with you I'm quite confused about what
> > > > >     is queued for 5.8 and what isn't.
> > > >
> > > > This one is queued, but I currently have it in the v5.9 pile (but
> > > > tentatively for v5.8).  Unless Marco tells me otherwise, I will move it
> > > > to the v5.8 branch, which will be part of my pull request next week.
> > >
> > > Great, then this would all show up on tip/locking/kscan, right?
> > >
> > > > > What's the best base for me to use?
> > > >
> > > > The -next tree has the latter, but not yet the former.
> > >
> > > That probably means -next is good enough for me to cook a new version of my
> > > series, and then I can make a proper branch next week.
> > >
> > > > Hopefully we can get this straightened out, and please accept my apologies
> > > > for the hassle!
> > >
> > > No need to apologise, I just couldn't figure out what was what and decided
> > > it was easier to ask the experts ;)
> >
> > Just confirming that I don't see any issues with the plan -- the
> > patches that Will needs are good to go into the v5.8 branch.
>
> OK, I have updated -rcu's kcsan and kcsan-dev branches.  Could you please
> double-check, given that pull-request time is quite soon?

I believe "objtool, kcsan: Add kcsan_disable_current() and
kcsan_enable_current_nowarn()" is missing, which should go after
"kcsan: Add __kcsan_{enable,disable}_current() variants".

Thanks,
-- Marco
