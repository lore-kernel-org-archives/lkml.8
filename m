Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A7F3C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 21:13:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 391F02085B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 21:13:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LRdD0rCj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbgFPVNj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 17:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbgFPVNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 17:13:38 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A7BC061573
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 14:13:37 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id q2so148633vsr.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 14:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X0rMkiop0+pruLh0Yl4qvTvDnfP83BWucM9LZrNczAw=;
        b=LRdD0rCjrSL9JaaL0kHwdPx0M+nkvoO/8C892/SEoqI4UtOAwS2vVtEepad05HhUU8
         m2m0yDAwLoNo6ORezqjQ7rOlOjqifjAfGJgCG8HwyFTy4mv+M46M6cFBDVfPhDGs1Zyt
         4xZdlt3gWUPPNHnHNr3/JhLeXoOrU+9CI3aPe5ieEeYonz4inwVW8vHjPLuBE1cLd5df
         3WGPaoqq/QpbM4Q/LSeFt6itsktKKdBT03aYrkPQ3ekG8URvAhZCf59ov/i2DZb1SNkF
         eEQXvHmEDOpsAdyibdcwVhXxuSpMcoKVd2goW26v344s5fztOzrpJS+JywrD74ifRd+a
         KDNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X0rMkiop0+pruLh0Yl4qvTvDnfP83BWucM9LZrNczAw=;
        b=I7NRIEW8prh3S6kBbWittaqdItBqpnxLlQRYKBtovqzwLOgLdwPf2KvbRDtDoVGPh3
         VXFEF88+u0Lee3y7CCGGKeIVACPIDAENSbv0lfEUUY9dp5GRZ4Wj7MltsBpGZcSkwF6S
         ME9Lv4UmqDemym09iJ2+z4Q0fVzL1T6Vmd9a8uJ9P3n+FAxMsPRjfVwu25j07gQp+2Zp
         GmSNBP1hdZ4GxcuZt4Nx03VqA67itew7G0dfoIRlGtSiRq+s1ZPmjoHzrmYfpxBytBsa
         V+RwBH1Hxluk+y6qGCNKZCVBkKq4Gr+sahhpb1U7JlCVxplHfJsVJWKzn34J/qGqi3yf
         JdDw==
X-Gm-Message-State: AOAM532+KZc9g9xLCkWaLhH8Pxno4yT2M8eQxc1stZ5VULbJfffrervg
        1fv90dJOndaxpX4dty0f/k4SmjoGclgEZvBqUGM=
X-Google-Smtp-Source: ABdhPJxChHzc2yaVqH9Es+Pc3yCaZLNjBvLc3EzAyBWiKNdl6kHaxrdGGhVBZa67D+PxbQYUP7jPXoIsbp3UjculvcE=
X-Received: by 2002:a67:f918:: with SMTP id t24mr3400638vsq.18.1592342017019;
 Tue, 16 Jun 2020 14:13:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200613155738.2249399-1-jim.cromie@gmail.com>
 <20200613155738.2249399-21-jim.cromie@gmail.com> <20200616134507.GO31238@alley>
In-Reply-To: <20200616134507.GO31238@alley>
From:   jim.cromie@gmail.com
Date:   Tue, 16 Jun 2020 15:13:10 -0600
Message-ID: <CAJfuBxxvejGJtyQfcPmG7i6p6NAESjTuBPHeGDUwTVkg9_JfzQ@mail.gmail.com>
Subject: Re: [PATCH v2 20/24] dyndbg: WIP towards debug-print-class based
 callsite controls
To:     Petr Mladek <pmladek@suse.com>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc:     Jason Baron <jbaron@akamai.com>,
        LKML <linux-kernel@vger.kernel.org>, akpm@linuxfoundation.org,
        Greg KH <gregkh@linuxfoundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi Petr,

On Tue, Jun 16, 2020 at 7:45 AM Petr Mladek <pmladek@suse.com> wrote:
>
> On Sat 2020-06-13 09:57:34, Jim Cromie wrote:
> > There are *lots* of ad-hoc debug printing solutions in kernel,
> > this is a 1st attempt at providing a common mechanism for many of them.
>
> I agree that it might make sense to provide some common mechanism.
>
>
> > Basically, there are 2 styles of debug printing:
> > - levels, with increasing verbosity, 1-10 forex
> > - bits/flags, independently controlling separate groups of dprints
> >
> > This patch does bits/flags only.
> >
> > proposed API:
> >
> > Usage model is for a module developer to create N exclusive subsets of
> > pr_debug()s by changing some of them to pr_debug_n(1,) .. pr_debug_n(N,).
> > Each callsite must be a single print-class, with 0 default.
> >
> > No multi-type classification ala pr_debug_M(1|2, ...) is contemplated.
> >
> >   Qfoo() { echo module foo $* >/proc/dynamic_debug/control }
> >   Qfoo +p             # all groups, including default 0
> >   Qfoo mflags 1 +p    # only group 1
> >   Qfoo mflags 12 +p   # TBD[1]: groups 1 or 2
> >   Qfoo mflags 0 +p    # ignored atm TBD[2]
> >   Qfoo mflags af +p   # TBD[3]: groups a or f (10 or 15)
>
> My problem with this approach is that it is too generic. Each class
> would have different meaning in each subsystem.
>

I think generic is a feature.

subsystem and module are the organizational level
where print-classes would be sensibly defined.
Thats why I required a module query-term with mflags,
 so that no mflags query could operate on all the callsites.
I might go further to prohibit a wildcard in the module query-term value,
so its absolutely locked in to a specific module.

maybe there would be consensus about having 1 or 2 kernel-wide print-classes,
but other than something akin to stdin, stdout, stderr, I cant think
of what it would look like.



> It might help to replace any existing variants. But it would be hard
> for developers debugging the code. They would need to study/remember
> the meaning of these groups for particular subsystems. They would
> need to set different values for different messages.
>
> Could you please provide more details about the potential users?

Ive ccd Stanimir, who wanted HI MID LOW classifications on some of his
debug prints.
Im doing the simplest possible thing that might work for him.

> Would be possible to find some common patterns and common
> meaning of the groups?

probably should start with anti-patterns.

KISAP - simple as possible
I offer exclusive classes only, no this or that.
prclass = 0 is reserved for every current use.

If module authors think they need many  print-classes, rethink.
control output exposes whole structure of code,
file and function names are chosen to convey organization,
a small set of queries will recreate most arbitrary print-classes

use the echo >control interface only.
I briefly thought about checking module debug parameters,
that now sounds like madness

Any chunk of code with N pr-debug* callsites, however badly architected,
can be completely controlled by N separate queries.
for better code, its much smaller.


ISTM the only sane way to allow external modules to control their own
dynamic debug callsites is to expose ddebug_exec_queries,
and let them issue the callsite modifications they want.

then, they can map any updates to their debug-flags storage
onto a pair of on-off queries for each bit.

Lastly, Id note that exclusive classes doesnt mean levels (debug++, debug--)
cant be handled.
we could reserve pr-classes 1-9 to mean all inclusive below N.

Or that meaning could be handled by merely issuing the fill-in activations.
In the module that wants debug levels

  echo module foo mflags 4 >control
auto generates same query 3 more times, with mflags 3 flags 2 mflags:1



>
> Best Regards,
> Petr
