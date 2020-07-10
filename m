Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B04CC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 16:56:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24D352078B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 16:56:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="orobF3YI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728362AbgGJQ4c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 12:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727097AbgGJQ4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 12:56:31 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84B19C08C5DC
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 09:56:30 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id u5so2784768pfn.7
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 09:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B2X5QFPcvgrAboSg6Ax5Zdcay4B6bTN36cXi/Syr5yY=;
        b=orobF3YIzCp0gPmGredIbnPemO/2BXqQA8D51eMgBqgC4wU1bZoLntj/vqLw706pGR
         A5EKYR5icv15YbAs6VYST8prgmXsSchbLc4Ibm2kOV9Nydh+LtrB7lamIjRV4Dv3wODJ
         7dGiCGy6dNFL+tRalZmSFSTYNiKVFwmPE9yGCLe8vVyT28/HFz0miIVnvpNg1Nkw6vXw
         egIudBZMyQHk7bFULT7t73v2QzK4gTbrHB7OM6M4bZuhlULhcnGQzLBWCUDN+tMextEw
         Y8ekfp+DfGZV3YWey9k1NBAYm1bgBrk1PbaWV/bSQ0K5iKffznm+AbdELiZajAD3q7li
         l4rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B2X5QFPcvgrAboSg6Ax5Zdcay4B6bTN36cXi/Syr5yY=;
        b=JhQnbDDKAm+H2cQjbCJptaTSeFjlXcBgkhY2mUMQY05AuBzhruRaDHc7VZvoHU3sr5
         gHM6kpQ4B5pasz8R+VUHcITbD1ze+mF9sgYwKD+/aV5T35c7WWXa5GUSggV9bhcuUsRg
         as3qZbYJ/IekUXl5U5RETZURyOVt3pQu4VgjDrep+/PbwgtaHyXj4ER0K+N1+Sejk4L6
         tbIhbZHuMSEluXNat5S35mdR0VOtqjwuY8FZBHqRb0Jjkx8CavMIhjmHsWZfrlpXk5q6
         JhYSzhU8c8Wh7HxXl1OpgSq7m6lPRLIvYQqhiCk8Ylx/7sAX0wwBBgoH6IV9lZh+S9nQ
         uBWQ==
X-Gm-Message-State: AOAM532cQ++7uB54MZ/owiWxLzmYf5Xwz9fWCYL2hWWL0xpF5LTGWLi7
        coE5nSpSAnEOiJnmy37OJjQH5eHjeGv2uk2d+GrYUFR1tnA=
X-Google-Smtp-Source: ABdhPJw2rLethbQ+9SPY9ZJb2r5ZLWLuVxGIZ3sa/C8ITw8MldYPGx0iArmeHYqjvhP+sGcWlSXBkyqrtdRcx79w9o0=
X-Received: by 2002:a63:7e55:: with SMTP id o21mr60676922pgn.263.1594400189668;
 Fri, 10 Jul 2020 09:56:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200530221127.459704-1-brgerst@gmail.com> <20200530221127.459704-3-brgerst@gmail.com>
 <20200709103024.GO597537@hirez.programming.kicks-ass.net> <CAMzpN2i3TPxpf5ktaQgb5EmB9wd84V+J5U6=_MuihtXx1-cp+A@mail.gmail.com>
 <20200710085327.GW4800@hirez.programming.kicks-ass.net>
In-Reply-To: <20200710085327.GW4800@hirez.programming.kicks-ass.net>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 10 Jul 2020 09:56:16 -0700
Message-ID: <CAKwvOdkccfLX59iCH0tFrwbG2Qd0XeOtKuupih+iosE5xwP0BQ@mail.gmail.com>
Subject: Re: [PATCH v2 02/10] x86/percpu: Clean up percpu_to_op()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Brian Gerst <brgerst@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 10, 2020 at 1:53 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Jul 10, 2020 at 12:38:23AM -0400, Brian Gerst wrote:
> > On Thu, Jul 9, 2020 at 6:30 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > On Sat, May 30, 2020 at 06:11:19PM -0400, Brian Gerst wrote:
> > > > +     if (0) {                                                        \
> > > > +             typeof(_var) pto_tmp__;                                 \
> > > > +             pto_tmp__ = (_val);                                     \
> > > > +             (void)pto_tmp__;                                        \
> > > > +     }                                                               \
> > >
> > > This is repeated at least once more; and it looks very similar to
> > > __typecheck() and typecheck() but is yet another variant afaict.
> >
> > The problem with typecheck() is that it will complain about a mismatch
> > between unsigned long and u64 (defined as unsigned long long) even
> > though both are 64-bits wide on x86-64.  Cleaning that mess up is
> > beyond the scope of this series, so I kept the existing checks.
>
> Fair enough; thanks for explaining.

I brought up the same point in v1, for more context:
https://lore.kernel.org/lkml/CAKwvOdnCcpS_9A2y9tMqeiAg2NfcVx=gNeA2V=+zHknit7wGkg@mail.gmail.com/
-- 
Thanks,
~Nick Desaulniers
