Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1242C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 06:00:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 891F920734
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 06:00:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SVZ0fEb+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbgFDGAo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 02:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbgFDGAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 02:00:43 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 291BEC05BD43
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jun 2020 23:00:43 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id o13so3879361otl.5
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jun 2020 23:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rSb0nNv2rpcsYD2Qo3eCh6ya1OcS6/RmNcjB/qUbXrc=;
        b=SVZ0fEb+aKif+jSSPjT2nFzAVhEJUIuByGQGfv4qlmc+WB9pSASxF/gwGh/M7R0va9
         JIqFMQPWLUmJcXuXo43nukVeTpaleXauned+5wlySa9/aTnL+zQX9DYh0z4U9FVfzFxz
         lWgRYdhd7+VQdlL+p47DScW5f9rlHQfBTP+UfGQBzmKrddeu6vgmt1wgfoPYJiREDkkP
         xuzUfW7mM9AThUGQHYl59KDE+OmD+eWvEe4W19f3PTgyuleeysn5B3Wtd0/tkt44jenH
         O/Ho3vCohBrbjyUO5NxtffJ/fiO+2rzjNkwVOcljB6Sla9z+LKGa1sfB5L5zM7Zbwy1A
         //Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rSb0nNv2rpcsYD2Qo3eCh6ya1OcS6/RmNcjB/qUbXrc=;
        b=L9NdIfg4r++bLJ7VcEM88/CJdifi56MN++6X658SQBEOhLunzpg1axX+KaavA+TzR2
         skdUrzU3uJfoxpbHensmCCh5kx9SkScX1bpyuC/DV/NLPrWqJod/NPPjuELKt9fnOGWH
         ac1vL/2GOTI5j1OE/34AAvIeP+tT1ue+X8W8Po13qgvBesfQcm/HuNc+F8aisCYVnr0T
         CbFKF424Fu/qb2dUIh4i83Ojz6sAtjWcJof6RLsZaHaTLfmCRnHg+hg4rzcBiZRII6DR
         eIztS405WW8WjwdLwFh9x6Kc8u6KF3vin/oGf6qEuuvN/h5z7IGzepPgy24QswIfnZy/
         gIlw==
X-Gm-Message-State: AOAM5312VHOA+HyC1kSrZBgcpfeZaJe03dC4pVdvh7w0dfYUu3sk+wxg
        AP2E5+hHl1vFd8Mh6BxsONlRQb6qHIVrG+xacbhF/w==
X-Google-Smtp-Source: ABdhPJzbd4iuSE6Ro9h2v0W1lihL6HEN5p2lXs7KIy6qCsEwOSCfv/Of2t+IIoCAh9ELsxBi75qgKdHxE3Xgc8jELcY=
X-Received: by 2002:a9d:7dc4:: with SMTP id k4mr2386984otn.251.1591250442319;
 Wed, 03 Jun 2020 23:00:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200603114014.152292216@infradead.org> <20200603120037.GA2570@hirez.programming.kicks-ass.net>
 <20200603120818.GC2627@hirez.programming.kicks-ass.net> <CANpmjNOxLkqh=qpHQjUC_bZ0GCjkoJ4NxF3UuNGKhJSvcjavaA@mail.gmail.com>
 <20200603121815.GC2570@hirez.programming.kicks-ass.net> <CANpmjNPxMo0sNmkbMHmVYn=WJJwtmYR03ZtFDyPhmiMuR1ug=w@mail.gmail.com>
 <CANpmjNPzmynV2X+e76roUmt_3oq8KDDKyLLsgn__qtAb8i0aXQ@mail.gmail.com>
 <20200603160722.GD2570@hirez.programming.kicks-ass.net> <20200603181638.GD2627@hirez.programming.kicks-ass.net>
 <CANpmjNPJ_vTyTYyrXxP2ei0caLo10niDo8PapdJj2s4-w_R3TA@mail.gmail.com>
In-Reply-To: <CANpmjNPJ_vTyTYyrXxP2ei0caLo10niDo8PapdJj2s4-w_R3TA@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Thu, 4 Jun 2020 08:00:30 +0200
Message-ID: <CANpmjNMyC+KHTbLFSxojV_CTK60t3ayJHxtyH4AckeMD2hGCtg@mail.gmail.com>
Subject: Re: [PATCH 0/9] x86/entry fixes
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Jun 2020 at 21:10, Marco Elver <elver@google.com> wrote:
>
> On Wed, 3 Jun 2020 at 20:16, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Wed, Jun 03, 2020 at 06:07:22PM +0200, Peter Zijlstra wrote:
> > > On Wed, Jun 03, 2020 at 04:47:54PM +0200, Marco Elver wrote:
> >
> > > > With that in mind, you could whitelist "__ubsan_handle"-prefixed
> > > > functions in objtool. Given the __always_inline+noinstr+__ubsan_handle
> > > > case is quite rare, it might be reasonable.
> > >
> > > Yes, I think so. Let me go have dinner and then I'll try and do a patch
> > > to that effect.
> >
> > Here's a slightly more radical patch, it unconditionally allows UBSAN.
> >
> > I've not actually boot tested this.. yet.
> >
> > ---
> > Subject: x86/entry, ubsan, objtool: Whitelist __ubsan_handle_*()
> > From: Peter Zijlstra <peterz@infradead.org>
> > Date: Wed Jun  3 20:09:06 CEST 2020
> >
> > The UBSAN instrumentation only inserts external CALLs when things go
> > 'BAD', much like WARN(). So treat them similar to WARN()s for noinstr,
> > that is: allow them, at the risk of taking the machine down, to get
> > their message out.
> >
> > Suggested-by: Marco Elver <elver@google.com>
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>
> This is much cleaner, as it gets us UBSAN coverage back. Seems to work
> fine for me (only lightly tested), so
>
> Acked-by: Marco Elver <elver@google.com>
>
> Thanks!

I was thinking that if we remove __no_sanitize_undefined from noinstr,
we can lift the hard compiler restriction for UBSAN because
__no_sanitize_undefined isn't used anywhere. Turns out, that attribute
isn't broken on GCC <= 7, so I've sent v2 of my series:
https://lkml.kernel.org/r/20200604055811.247298-1-elver@google.com

Thanks,
-- Marco
