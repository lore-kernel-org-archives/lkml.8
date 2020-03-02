Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75D0CC3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 14:58:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C40E20863
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 14:58:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="e9eq6vyB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727367AbgCBO6f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 09:58:35 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:42012 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726997AbgCBO6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 09:58:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zvD0SGWoDC0uqgXi90N7evMtZTjmywIDSfUBtMitzKU=; b=e9eq6vyB1MtiV/13tz5dsyzHnN
        4/kyLweGP48k3B74zr5S9YoW5XTsVrXTMM3rDC1WhGEdxwdthJB9DcFLZN0pLlFUcT7RIqFO6J7mj
        6YhdQwUknqEf4lmHFqvyrsIKrJpg7cX+auhLrkOCkJ71DE3XbjjMJnuN/ErjeXspKYeQah86kMSuy
        jGv8866+9maMTOkll5G6rI0E3FVe3qEHWD7xKN1ID7zYxIGc/R+rqwWJU5ZgCld0KdaA9bl94QsCz
        +uFBvpocN6tXMIaRf5kDiSiq7sfZafHtwZJE0cLjPXul3jdCyVg7KXLdGCyrauZ14ydkCKTyCRucd
        kxXMuxJg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j8mWW-0007c2-Fi; Mon, 02 Mar 2020 14:58:24 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 71109304D2B;
        Mon,  2 Mar 2020 15:56:24 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2A86C2141AAC4; Mon,  2 Mar 2020 15:58:22 +0100 (CET)
Date:   Mon, 2 Mar 2020 15:58:22 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jann Horn <jannh@google.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: x86 entry perf unwinding failure (missing IRET_REGS annotation
 on stack switch?)
Message-ID: <20200302145822.GC2562@hirez.programming.kicks-ass.net>
References: <CAG48ez1rkN0YU-ieBaUZDKFYG5XFnd7dhDjSDdRmVfWyQzsA5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez1rkN0YU-ieBaUZDKFYG5XFnd7dhDjSDdRmVfWyQzsA5g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 01, 2020 at 07:02:15AM +0100, Jann Horn wrote:

> 0000000000000a2f <swapgs_restore_regs_and_return_to_usermode>:
>      a2f: 41 5f                pop    %r15
> #######sp:sp-8 bp:(und) type:regs end:0
>      a31: 41 5e                pop    %r14
> #######sp:sp-16 bp:(und) type:regs end:0
>      a33: 41 5d                pop    %r13
> #######sp:sp-24 bp:(und) type:regs end:0
>      a35: 41 5c                pop    %r12
> #######sp:sp-32 bp:(und) type:regs end:0
>      a37: 5d                    pop    %rbp
> #######sp:sp-40 bp:(und) type:regs end:0
>      a38: 5b                    pop    %rbx
> #######sp:sp-48 bp:(und) type:regs end:0
>      a39: 41 5b                pop    %r11
> #######sp:sp-56 bp:(und) type:regs end:0
>      a3b: 41 5a                pop    %r10
> #######sp:sp-64 bp:(und) type:regs end:0
>      a3d: 41 59                pop    %r9
> #######sp:sp-72 bp:(und) type:regs end:0
>      a3f: 41 58                pop    %r8
> #######sp:sp-80 bp:(und) type:regs end:0
>      a41: 58                    pop    %rax
> #######sp:sp-88 bp:(und) type:regs end:0
>      a42: 59                    pop    %rcx
> #######sp:sp-96 bp:(und) type:regs end:0
>      a43: 5a                    pop    %rdx
> #######sp:sp-104 bp:(und) type:regs end:0
>      a44: 5e                    pop    %rsi
> #######sp:sp-112 bp:(und) type:regs end:0
>      a45: 48 89 e7              mov    %rsp,%rdi
>      a48: 65 48 8b 24 25 00 00 mov    %gs:0x0,%rsp
>      a4f: 00 00

Right, so here we flip stacks,

>      a51: ff 77 30              pushq  0x30(%rdi)
> #######sp:sp-104 bp:(und) type:regs end:0
>      a54: ff 77 28              pushq  0x28(%rdi)
> #######sp:sp-96 bp:(und) type:regs end:0
>      a57: ff 77 20              pushq  0x20(%rdi)
> #######sp:sp-88 bp:(und) type:regs end:0
>      a5a: ff 77 18              pushq  0x18(%rdi)
> #######sp:sp-80 bp:(und) type:regs end:0
>      a5d: ff 77 10              pushq  0x10(%rdi)

And here we've pushed an IRET frame

> #######sp:sp-72 bp:(und) type:regs end:0
>      a60: ff 37                pushq  (%rdi)

> It looks to me like things go wrong at the point where we switch over
> to the trampoline stack? The ORC info claims that we have full user
> registers on the trampoline stack (and that we're clobbering them with
> our pushes - apparently objtool is not smart enough to realize that
> that looks bogus), but at that point we should probably actually use
> something like UNWIND_HINT_IRET_REGS, right?

I _think_ you've nailed it, but I'm somewhat new to this part of
objtool.

Josh?
