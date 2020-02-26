Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4ACBC4BA24
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 21:54:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B24FE24653
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 21:54:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SvafYS8f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727714AbgBZVyp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 16:54:45 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:40364 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727503AbgBZVyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 16:54:45 -0500
Received: by mail-il1-f193.google.com with SMTP id i7so522807ilr.7
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 13:54:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4XwFC9zK7rdNFiU4fD2W53gqKQJ5N1hfb8kc+66F6nM=;
        b=SvafYS8fran1hLSVtvbh3r5bGn9MzewnRSIACfZVF83EuMq+8JQ2qXCJGEy/RugvH7
         xgC5MCs552la8bmpl3KUvf6vUB4Feze2tFO2bpsvCclTJ4Cd/2CycNNRYgEwuXR0AIgC
         lxHNybkmt0URMPWz4GYWI7kjO9jUYGP/SkmQgUMZqrQ4GDuDIuRu480/ebLy16QPM35Z
         Dc8rHwFPEHi0DeDyj7OYodMFWLHz8TcFWYtnhu6ogg9yV8iATTLG6iRp8C1ZAlHmWfhm
         60DCHpJGKkRY+eSSutwV/dwEebDwafmfm/rQhi9h3uiilQ2tQJF5HLyh0YSyks1AIs9H
         5+PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4XwFC9zK7rdNFiU4fD2W53gqKQJ5N1hfb8kc+66F6nM=;
        b=DoJTtGe7gcO4+VFbPITe3Yr1OlNq+GYUUseSggMVmaVs/LHYvYchrN9Q9fXP0Er+tV
         XHJDKv6cMCJBHDpUTyHWcKBz1QeyORMo0bx0EDwK2MrqeEAT2CmrDkMV3O7xOJaBm6q3
         TaXJSZ20BFKZ33B9YHSfCT/0R5xNej60RhycHC3P9K+Rd/QDntsHt7iSLpwPFWm0P6gA
         BA0vez54LhzRxpye8dpVy4zXFd1Av2bm6/m95SNa1UtjVs1dz3Pro/4TESTic0FmV44R
         L2sS4dmr3C2mm9/qI00eaZoHLgeMSi6iFGgO2X29o1fihX423E2J56KyFvADCEy96bik
         64FQ==
X-Gm-Message-State: APjAAAU+VoNKb7b749tx0oOsw/LzJDrC+nWbTPTrVPUObl12nFdqlwdc
        pKpwCpt3xJoHV46XXT0GwO1N02aFcvwt3BAH8w==
X-Google-Smtp-Source: APXvYqyYQnPC7xjE0yUNtfxPz0QVi/FLAMLOrYwidqVBrh1Z+jdutAz4oRZvxLhuNg/XeDuDAKd53+GuSMh0DrE4wJM=
X-Received: by 2002:a05:6e02:1014:: with SMTP id n20mr1047518ilj.172.1582754084409;
 Wed, 26 Feb 2020 13:54:44 -0800 (PST)
MIME-Version: 1.0
References: <20200225224719.950376311@linutronix.de> <20200225231609.000955823@linutronix.de>
 <CAMzpN2ij8ReOXZH00puhzraCGRdKY8qt+TMipd_14_XWTu8xtg@mail.gmail.com> <87k149p0na.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87k149p0na.fsf@nanos.tec.linutronix.de>
From:   Brian Gerst <brgerst@gmail.com>
Date:   Wed, 26 Feb 2020 16:54:33 -0500
Message-ID: <CAMzpN2j7EHZ2bKg9SZ2Ri-qsmEoknAAJO6O5yoLn-fY8_h1B2A@mail.gmail.com>
Subject: Re: [patch 01/15] x86/irq: Convey vector as argument and not in ptregs
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Juergen Gross <jgross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 26, 2020 at 3:13 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Brian Gerst <brgerst@gmail.com> writes:
>
> > On Tue, Feb 25, 2020 at 6:26 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> >>
> >> Device interrupts which go through do_IRQ() or the spurious interrupt
> >> handler have their separate entry code on 64 bit for no good reason.
> >>
> >> Both 32 and 64 bit transport the vector number through ORIG_[RE]AX in
> >> pt_regs. Further the vector number is forced to fit into an u8 and is
> >> complemented and offset by 0x80 for historical reasons.
> >
> > The reason for the 0x80 offset is so that the push instruction only
> > takes two bytes.  This allows each entry stub to be packed into a
> > fixed 8 bytes.  idt_setup_apic_and_irq_gates() assumes this 8-byte
> > fixed length for the stubs, so now every odd vector after 0x80 is
> > broken.
> >
> >      508:       6a 7f                   pushq  $0x7f
> >      50a:       e9 f1 08 00 00          jmpq   e00 <common_interrupt>
> >      50f:       90                      nop
> >      510:       68 80 00 00 00          pushq  $0x80
> >      515:       e9 e6 08 00 00          jmpq   e00 <common_interrupt>
> >      51a:       66 0f 1f 44 00 00       nopw   0x0(%rax,%rax,1)
> >      520:       68 81 00 00 00          pushq  $0x81
> >      525:       e9 d6 08 00 00          jmpq   e00 <common_interrupt>
> >      52a:       66 0f 1f 44 00 00       nopw   0x0(%rax,%rax,1)
> >
> > The 0x81 vector should start at 0x518, not 0x520.
>
> Bah, I somehow missed that big fat comment explaining it. :)
>
> Thanks for catching it. So my testing just has been lucky to not hit one
> of those.
>
> Now the question is whether we care about the packed stubs or just make
> them larger by using alignment to get rid of this silly +0x80 and
> ~vector fixup later on. The straight forward thing clearly has its charm
> and I doubt it matters in measurable ways.

I think we can get rid of the inversion.  That was done so orig_ax had
a negative number (signifying it's not a syscall), but if you replace
it with -1 that isn't necessary.  A simple -0x80 offset should be
sufficient.

I think it's a worthy optimization to keep.  There are 240 of these
stubs, so increasing the allocation to 16 bytes would add 1920 bytes
to the kernel text.

--
Brian Gerst
