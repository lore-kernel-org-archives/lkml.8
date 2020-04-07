Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D295AC2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 12:34:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EF1F2051A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 12:34:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eEx66aTR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728703AbgDGMeA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 08:34:00 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59962 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728152AbgDGMeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 08:34:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=riSm6OQQkxYGmZsCsCgLPBnh+Vw6HfHvJMjb39H1oCI=; b=eEx66aTRxbCtW82gVL8Fg6OgoT
        zuCCgwzeKDkpJD4uQkBXnWb41/+7CkwmIdmJNbVaEWHfqU7Ebpl8vr21hM3oMZatFeUwMgntd8Cmf
        /k3nRtlLkr3jWVG+XMo2/5GjS50F7ooMGUSf3W/pl5bjirWSK/M1BMBG7uypXgV0On6x068Kza0k2
        /z3hgtBLS40Pdyf3oq3lMApJlxM/vltY/P0mUyu9WKPFt8Z/S1jpzeT4+ghBIs27Foqjrthh+qItB
        DvsduGzFNNBKUOZmOEa4N/1B9cWEatzIgap9ZjEMN695xceJbm1N450abi43436fWV3u34BBT/4hP
        jVe0jBmw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jLnQN-0004HC-0T; Tue, 07 Apr 2020 12:33:51 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9FD11304D58;
        Tue,  7 Apr 2020 14:33:48 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 86B4D2B907A8B; Tue,  7 Apr 2020 14:33:48 +0200 (CEST)
Date:   Tue, 7 Apr 2020 14:33:48 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kyle Huey <me@kylehuey.com>
Cc:     Keno Fischer <keno@juliacomputing.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andi Kleen <andi@firstfloor.org>,
        Kyle Huey <khuey@kylehuey.com>,
        Robert O'Callahan <robert@ocallahan.org>
Subject: Re: [RFC PATCH v2] x86/arch_prctl: Add ARCH_SET_XCR0 to set XCR0
 per-thread
Message-ID: <20200407123348.GV20730@hirez.programming.kicks-ass.net>
References: <20200407011259.GA72735@juliacomputing.com>
 <2A931F48-D28F-46F3-827F-FF7F4D5D3E66@amacapital.net>
 <CABV8kRyi-5wyiCV3HsPfFx6x1_icV72BSy+5eK8UC3UCexTSCA@mail.gmail.com>
 <CAP045AohDoxZ+tvm+hBWWXgXz6N-z0+UWj--_o1AiVRubWYm6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP045AohDoxZ+tvm+hBWWXgXz6N-z0+UWj--_o1AiVRubWYm6A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 06, 2020 at 09:53:40PM -0700, Kyle Huey wrote:
> On Mon, Apr 6, 2020 at 9:45 PM Keno Fischer <keno@juliacomputing.com> wrote:
> >
> > On Mon, Apr 6, 2020 at 11:58 PM Andy Lutomirski <luto@amacapital.net> wrote:
> > >
> > >
> > > > On Apr 6, 2020, at 6:13 PM, Keno Fischer <keno@juliacomputing.com> wrote:
> > > >
> > > > ﻿This is a follow-up to my from two-years ago [1].
> > >
> > > Your changelog is missing an explanation of why this is useful.  Why would a user program want to change XCR0?
> >
> > Ah, sorry - I wasn't sure what the convention was around repeating the
> > applicable parts from the v1 changelog in this email.
> > Here's the description from the v1 patch:
> >
> > > The rr (http://rr-project.org/) debugger provides user space
> > > record-and-replay functionality by carefully controlling the process
> > > environment in order to ensure completely deterministic execution
> > > of recorded traces. The recently added ARCH_SET_CPUID arch_prctl
> > > allows rr to move traces across (Intel) machines, by allowing cpuid
> > > invocations to be reliably recorded and replayed. This works very
> > > well, with one catch: It is currently not possible to replay a
> > > recording from a machine supporting a smaller set of XCR0 state
> > > components on one supporting a larger set. This is because the
> > > value of XCR0 is observable in userspace (either by explicit
> > > xgetbv or by looking at the result of xsave) and since glibc
> > > does observe this value, replay divergence is almost immediate.
> > > I also suspect that people interested in process (or container)
> > > live-migration may eventually care about this if a migration happens
> > > in between a userspace xsave and a corresponding xrstor.
> > >
> > > We encounter this problem quite frequently since most of our users
> > > are using pre-Skylake systems (and thus don't support the AVX512
> > > state components), while we recently upgraded our main development
> > > machines to Skylake.
> >
> > Basically, for rr to work, we need to tightly control any user-visible
> > CPU behavior,
> > either by putting in the CPU in the right state or by trapping and emulating
> > (as we do for rdtsc, cpuid, etc). XCR0 controls a bunch of
> > user-visible CPU behavior,
> > namely:
> > 1) The size of the xsave region if xsave is passed an all-ones mask
> > (which is fairly common)
> > 2) The return value of xgetbv
> 
> It's mentioned elsewhere, but I want to emphasize that the return
> value of xgetbv is the big one because the dynamic linker uses this.
> rr trace portability is essentially limited to machines with identical
> xcr0 values because of it.

I'm thinking just exposing that value is doable in a much less
objectionable fashion, no?
