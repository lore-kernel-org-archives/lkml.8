Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CF33C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 18:50:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2625120738
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 18:50:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b="PeQ1XkRc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbgHYSug (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 14:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbgHYSue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 14:50:34 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB241C061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 11:50:33 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id b17so9642569ejq.8
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 11:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HAiw440qd9YVCUAfh8vthnwmjnCTaCcc92RZaxuiaYQ=;
        b=PeQ1XkRcsWJYKUEjmBfVF6K0pgJ0OC5uXa+1sxS2Q0PRbH+tAqFHE99UvPzMra9erQ
         D+kvIvLeIq1+lDb8rBkn03PSLGxJ0slUsEORE9vMgXSa/C0iuER8zH5u4LI1tj8q8iWL
         RPpNr2bsodk4U46iBCsxzq6qO/9kyzUrg578mnJjY2R0Ilqo1o38rVuFEcTRgX7eJ4VL
         pZiHS0IR5WWazFh9xoDBBXFJLmqs9+aPvR738TQ+H6rMQyMOC3TsHe4/mRR41N+c6tE4
         J02CTP+TwN8K8R2qSxZ6IPw2JkptTKD7iTUeJQYYv+SGrYtKKzOZ7iMasqOuDgXYnlRW
         c46g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HAiw440qd9YVCUAfh8vthnwmjnCTaCcc92RZaxuiaYQ=;
        b=Gsd64t81FSKHK0mdPApoZAkUOvWHxeNLkeVgoK63wSF4Xro7NB1dNIx6W0s5W00Si8
         tpsYNQNRCOZ65EWk9YEeMUG94pUm8mtmmaz4CPdykI7091Mk5pVNTTriKuHXrasld4Dp
         1v6HQ80J1Y1ph/PTDFXxBwZ9ryT5MzrNflK3dy9HPXQmJl1ZFDstK6rWDBHgGnkt7klU
         TVHRHHthLbIGH2++Cg8L9Rv42QxzTTbf+JoEaSFIFV8pT06HCnW6waRW6f/Ay7sKpNNr
         N3mWU6GMuDV6L0tUfwQn8maAbqQk1gRzA817N3aH/xtHN1XwHlFnFrxyJzHzAsuMu3Zb
         gbvA==
X-Gm-Message-State: AOAM530uxZKGtEDHLBiXHqFadVEjDE/fID2m5rE1y5+hIHqBhn0vhs2c
        7nTrLSsqzx5un2Dfzg2693tC+4baPl9f9BIVEjpbrA==
X-Google-Smtp-Source: ABdhPJz5sgPQt2X+txgitP6gmooosTH7BZWJ8/qJyXB/7bqmQ1L6TCGOs4zq8Hf1Zixk+EFu9ANWlxVI1r5s4idHAKM=
X-Received: by 2002:a17:906:b20c:: with SMTP id p12mr11830737ejz.300.1598381432109;
 Tue, 25 Aug 2020 11:50:32 -0700 (PDT)
MIME-Version: 1.0
References: <CAOp6jLYrwMqV=7hmxgdZUdDZ2aeUB27TTHm=j6cQT7C10Muhww@mail.gmail.com>
 <7DF88F22-0310-40C9-9DA6-5EBCB4877933@amacapital.net> <CALCETrUrvrQNw6dPau_rtHjA_YuCVdCTWYd4dsdcvcGsOaspmg@mail.gmail.com>
 <b0813ec5-b163-cc11-bfc9-e9d08c9c4ff2@zytor.com> <CALCETrXvgb257CWnaA1NgUUp3x08+gJBEOQh4o9OYkB-RvAo1A@mail.gmail.com>
 <CAP045Ao6xBquwSDoCLzzNbEW1Lr969d+D0jQQ2Zb4pX3B77-Xw@mail.gmail.com>
 <CALCETrUgm-Cph4fwqk108VHZPLuM7XWL=nff-xB+hc+hiDrqsg@mail.gmail.com>
 <CAP045Aqhox6YSdk0v_YZWY=y7Ps4ZfH779MG-W4a=gc+cYEY+Q@mail.gmail.com>
 <CALCETrX+TLB+w0X0jc9jq_U4SQezWXEmSpEmmdPobnbUuYfang@mail.gmail.com> <CAP045ArKLoNdbX8rhkfC1gSuntTOE6PKaEFszUCh8xTDYYZZZw@mail.gmail.com>
In-Reply-To: <CAP045ArKLoNdbX8rhkfC1gSuntTOE6PKaEFszUCh8xTDYYZZZw@mail.gmail.com>
From:   Kyle Huey <me@kylehuey.com>
Date:   Tue, 25 Aug 2020 11:50:19 -0700
Message-ID: <CAP045Arh1CORYbKn6GvBPWt+8u3S80Op4LFPVHcpbF2mr4upRw@mail.gmail.com>
Subject: Re: [REGRESSION] x86/cpu fsgsbase breaks TLS in 32 bit rr tracees on
 a 64 bit system
To:     Andy Lutomirski <luto@kernel.org>
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        "Robert O'Callahan" <robert@ocallahan.org>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 25, 2020 at 10:31 AM Kyle Huey <me@kylehuey.com> wrote:
>
> On Tue, Aug 25, 2020 at 9:46 AM Andy Lutomirski <luto@kernel.org> wrote:
> >
> > On Tue, Aug 25, 2020 at 9:32 AM Kyle Huey <me@kylehuey.com> wrote:
> > >
> > > On Tue, Aug 25, 2020 at 9:12 AM Andy Lutomirski <luto@amacapital.net>=
 wrote:
> > > > I don=E2=80=99t like this at all. Your behavior really shouldn=E2=
=80=99t depend on
> > > > whether the new instructions are available.  Also, some day I would
> > > > like to change Linux to have the new behavior even if FSGSBASE
> > > > instructions are not available, and this will break rr again.  (The
> > > > current !FSGSBASE behavior is an ugly optimization of dubious value=
.
> > > > I would not go so far as to describe it as correct.)
> > >
> > > Ok.
> > >
> > > > I would suggest you do one of the following things:
> > > >
> > > > 1. Use int $0x80 directly to load 32-bit regs into a child.  This
> > > > might dramatically simplify your code and should just do the right
> > > > thing.
> > >
> > > I don't know what that means.
> >
> > This is untested, but what I mean is:
> >
> > static int ptrace32(int req, pid_t pid, int addr, int data) {
> >    int ret;
> >    /* new enough kernels won't clobber r8, etc. */
> >    asm volatile ("int $0x80" : "=3Da" (ret) : "a" (26 /* ptrace */), "b=
"
> > (req), "c" (pid), "d" (addr), "S" (data) : "flags", "r8", "r9", "r10",
> > "r11");
> >    return ret;
> > }
> >
> > with a handful of caveats:
> >
> >  - This won't compile with -fPIC, I think.  Instead you'll need to
> > write a little bit of asm to set up and restore ebx yourself.  gcc is
> > silly like this.
> >
> >  - Note that addr is an int.  You'll need to mmap(..., MAP_32BIT, ...)
> > to get a buffer that can be pointed to with an int.
> >
> > The advantage is that this should work on all kernels that support
> > 32-bit mode at all.
> >
> > >
> > > > 2. Something like your patch but make it unconditional.
> > > >
> > > > 3. Ask for, and receive, real kernel support for setting FS and GS =
in
> > > > the way that 32-bit code expects.
> > >
> > > I think the easiest way forward for us would be a PTRACE_GET/SETREGSE=
T
> > > like operation that operates on the regsets according to the
> > > *tracee*'s bitness (rather than the tracer, as it works currently).
> > > Does that sound workable?
> > >
> >
> > Strictly speaking, on Linux, there is no unified concept of a task's
> > bitness, so "set all these registers according to the target's
> > bitness" is not well defined.  We could easily give you a
> > PTRACE_SETREGS_X86_32, etc, though.
>
> In the process of responding to this I spent some time doing code
> inspection and discovered a subtlety in the ptrace API that I was
> previously unaware of. PTRACE_GET/SETREGS use the regset views
> corresponding to the tracer but PTRACE_GET/SETREGSET use the regset
> views corresponding to the tracee. This means it is possible for us
> today to set FS/GS "the old way" with a 64 bit tracer/32 bit tracee
> combo, as long as we use PTRACE_SETREGSET with NT_PRSTATUS instead of
> PTRACE_SETREGS.

Alright I reverted the previous changes and switched us to use
PTRACE_SETREGSET with NT_PRSTATUS[0] and our 32 bit tests pass again.
I assume this behavior will remain unchanged indefinitely even when
the fs/gsbase manipulation instructions are not available since the 32
bit user_regs_struct can't grow?

- Kyle

[0] https://github.com/mozilla/rr/commit/5c12d5f9ab77e526f852cbca82f454a42e=
3a6e30#diff-b509a7939392c11bb3c517b00da4526fL1447
(most of the rest of this commit is fixing our *emulation* of
PTRACE_GETREGSET/PTRACE_SETREGSET which was not respecting the
tracee's 32 vs 64 bit stauts).
