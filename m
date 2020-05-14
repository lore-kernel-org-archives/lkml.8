Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08244C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 14:20:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7FA32065D
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 14:20:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U7GifXij"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbgENOU5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 10:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726051AbgENOU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 10:20:56 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B6C2C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 07:20:56 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id i5so1202189uaq.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 07:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kr3umhTv0KENiyp0wU7PxiKM+as47imy2UfDBknXLLk=;
        b=U7GifXijyReSXUq3LmOzUs4pV9Xx3CqZd0FQQF9oXyQwnBfla1LWxzXZdthLHqBngv
         AtshgLS6WPzb3SY+PYTphziTFvxexbY9S0ugZ84rnSyKSRtVH1Xd19VW6U6xnL8YsQXL
         GTJ5s82/CMLf86w3sdGo6poFV8M4tg8pprU+sBnQZm43EO0ivTg6PrSnpz2m62kJ1rIu
         DpTdon54LpMiJpEkmXZjXwdw+uQQ+yNzcA/5aL1y9tZCU0BfjuPNidsaeeDSW0BJm0W3
         lN3ySCmEb3y1hXc3AJQ5479GzlVGaCRGzkbXbomtHNwUkgCFzbFeOXflIE2WAE1Rt656
         CesQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kr3umhTv0KENiyp0wU7PxiKM+as47imy2UfDBknXLLk=;
        b=nYcPRm/AC1PILyN/u6yggVA8n6XT01NvF112/lU7gEcLCBL00fXu/AFwcBwLqSq8rn
         Val4HB4cDyBoh6z9+REHXTQtRoUyRDqwx9FOxPYHhRWDjFTyJ917N74/vk0CGPm71hIr
         dz+kpCnpc1ZaLvz9F0uZvVmH345/vdFj+mJ08cXlx8GpXW5byis9MYBgbuUfn5uqxTeg
         Nql32eyDtoTxVu8tazV1f5BBZM+LIOoKINZSEeuBWgLUh0Rza7a6Os22iyakWOADn+nX
         A5oXWAgQOHDzmuezsxNYMm1O13v8MsgXohzkasyLOyGFojQ1y86RWofseb8aGqUUqG08
         R/ow==
X-Gm-Message-State: AOAM531TdIeryBnkIbsDqlj8RubHJNt0+JRHBjuCfU4m6FWfaPDpArsJ
        4lVt1wyISZJyQN0fsINTm7rJLRv/yDpJbZVFluhRnA==
X-Google-Smtp-Source: ABdhPJzJCwRh7jz4V4nLpEULmN6zbDTseafsky+IjejFjrduVx7XbffImw+BszNeeLhqkujJCh1P9RFFdbABK/s2vrk=
X-Received: by 2002:a9f:31cb:: with SMTP id w11mr4204971uad.128.1589466055185;
 Thu, 14 May 2020 07:20:55 -0700 (PDT)
MIME-Version: 1.0
References: <CANpmjNNo3rhwqG=xEbpP9JiSd8-Faw8fkoUhYJjesHK5S5_KQQ@mail.gmail.com>
 <20200512190755.GL2957@hirez.programming.kicks-ass.net> <CANpmjNNeSnrAgfkskE5Y0NNu3-DS6hk+SwjkBunrr8FRxwwT-Q@mail.gmail.com>
 <20200513111057.GN2957@hirez.programming.kicks-ass.net> <CANpmjNMariz3-keqwUsLHVrpk2r7ThLSKtkhHxTDa3SEGeznhA@mail.gmail.com>
 <20200513123243.GO2957@hirez.programming.kicks-ass.net> <20200513124021.GB20278@willie-the-truck>
 <CANpmjNM5XW+ufJ6Mw2Tn7aShRCZaUPGcH=u=4Sk5kqLKyf3v5A@mail.gmail.com>
 <20200513132440.GN2978@hirez.programming.kicks-ass.net> <CANpmjNM5dD1VH0hoQwsZYEL=mhWunKwAEJMQgASzHSN019OCnw@mail.gmail.com>
 <20200514141344.GB2978@hirez.programming.kicks-ass.net>
In-Reply-To: <20200514141344.GB2978@hirez.programming.kicks-ass.net>
From:   Marco Elver <elver@google.com>
Date:   Thu, 14 May 2020 16:20:42 +0200
Message-ID: <CANpmjNPb0nr+PGRhogySdm1ixdSRTF_Xi5P8pn_8er+mDtt3kQ@mail.gmail.com>
Subject: Re: [PATCH v5 00/18] Rework READ_ONCE() to improve codegen
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Will Deacon <will@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 May 2020 at 16:13, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, May 13, 2020 at 03:58:30PM +0200, Marco Elver wrote:
> > On Wed, 13 May 2020 at 15:24, Peter Zijlstra <peterz@infradead.org> wrote:
>
> > > Also, could not this compiler instrumentation live as a kernel specific
> > > GCC-plugin instead of being part of GCC proper? Because in that case,
> > > we'd have much better control over it.
> >
> > I'd like it if we could make it a GCC-plugin for GCC, but how? I don't
> > see a way to affect TSAN instrumentation. FWIW Clang already has
> > distinguish-volatile support (unreleased Clang 11).
>
> Ah, I figured not use the built-in TSAN at all, do a complete
> replacement of the instrumentation with a plugin. AFAIU plugins are able
> to emit instrumentation, but this isn't something I know a lot about.

Interesting option. But it will likely not solve the no_sanitize and
inlining problem, because those are deeply tied to the optimization
pipelines.
