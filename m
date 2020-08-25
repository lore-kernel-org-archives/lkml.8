Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A385C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 19:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 002552075E
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 19:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598383942;
	bh=nmIX0CDjceyKvGjRzvTncu508gplaJItsNm8ytqKqdQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=CqJA8zoUCGtew6yC3PioVSCrer1yPj8V0jXeMHuyUm4NNUP7KeT+pWCKOLIJ9IALR
	 yoRH+UIUKMpaRRPPTkAba8KiShWzU16jbU87iTmT2JQPiWZ4QPEPhP5vNUo//jaf5L
	 oX2jOz1j/wx6aQ+QZX9MkG0YAo75Y+IsvR1RYwSs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbgHYTcU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 15:32:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:35050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726090AbgHYTcU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 15:32:20 -0400
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD9BB2076C
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 19:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598383939;
        bh=nmIX0CDjceyKvGjRzvTncu508gplaJItsNm8ytqKqdQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DLCQT1HMKJ6i3NCy8d7cAa97A8jf7CHeF3ycGqv8RE3AtFKMpatNcyh0ObVC6Pw0Z
         /JZ8OM90UODrryZ+xdTJbUkSXkJGzyX/znuvx5dlW3LULUxBO+t4D2Ct3OuCR5P/Po
         r8DGk3BmCOXpzJV4/ir7tCB7glenfrp5Klx/sED8=
Received: by mail-wr1-f51.google.com with SMTP id h15so7313724wrt.12
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 12:32:18 -0700 (PDT)
X-Gm-Message-State: AOAM532uU/oSpZXkTNhvVbStVDnEUpQeiYpsTdnfjsDogUU8oH2kG6pC
        WRvfWN8gA/p8SvZ/vb4g/Ur+1yJTtePIbZDRIdaYeQ==
X-Google-Smtp-Source: ABdhPJw3kXnxWC5vvj6gEzKJ7b8Tp03b1p64T+g25p4sZz3/aywEvoBScEvExlBFjz84+AVcn/sSmU6Vs3VgcLgZ8Qc=
X-Received: by 2002:a5d:4145:: with SMTP id c5mr12277770wrq.18.1598383937286;
 Tue, 25 Aug 2020 12:32:17 -0700 (PDT)
MIME-Version: 1.0
References: <CAOp6jLYrwMqV=7hmxgdZUdDZ2aeUB27TTHm=j6cQT7C10Muhww@mail.gmail.com>
 <7DF88F22-0310-40C9-9DA6-5EBCB4877933@amacapital.net> <CALCETrUrvrQNw6dPau_rtHjA_YuCVdCTWYd4dsdcvcGsOaspmg@mail.gmail.com>
 <b0813ec5-b163-cc11-bfc9-e9d08c9c4ff2@zytor.com> <CALCETrXvgb257CWnaA1NgUUp3x08+gJBEOQh4o9OYkB-RvAo1A@mail.gmail.com>
 <CAP045Ao6xBquwSDoCLzzNbEW1Lr969d+D0jQQ2Zb4pX3B77-Xw@mail.gmail.com>
 <CALCETrUgm-Cph4fwqk108VHZPLuM7XWL=nff-xB+hc+hiDrqsg@mail.gmail.com>
 <CAP045Aqhox6YSdk0v_YZWY=y7Ps4ZfH779MG-W4a=gc+cYEY+Q@mail.gmail.com>
 <CALCETrX+TLB+w0X0jc9jq_U4SQezWXEmSpEmmdPobnbUuYfang@mail.gmail.com>
 <CAP045ArKLoNdbX8rhkfC1gSuntTOE6PKaEFszUCh8xTDYYZZZw@mail.gmail.com> <CAP045Arh1CORYbKn6GvBPWt+8u3S80Op4LFPVHcpbF2mr4upRw@mail.gmail.com>
In-Reply-To: <CAP045Arh1CORYbKn6GvBPWt+8u3S80Op4LFPVHcpbF2mr4upRw@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 25 Aug 2020 12:32:05 -0700
X-Gmail-Original-Message-ID: <CALCETrVnd4VVyReTxmGd0BeHPGp-7W7HoHJA8qdzZsy1OgF91A@mail.gmail.com>
Message-ID: <CALCETrVnd4VVyReTxmGd0BeHPGp-7W7HoHJA8qdzZsy1OgF91A@mail.gmail.com>
Subject: Re: [REGRESSION] x86/cpu fsgsbase breaks TLS in 32 bit rr tracees on
 a 64 bit system
To:     Kyle Huey <me@kylehuey.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
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

On Tue, Aug 25, 2020 at 11:50 AM Kyle Huey <me@kylehuey.com> wrote:
>
> On Tue, Aug 25, 2020 at 10:31 AM Kyle Huey <me@kylehuey.com> wrote:
> >
> > On Tue, Aug 25, 2020 at 9:46 AM Andy Lutomirski <luto@kernel.org> wrote=
:
> > >
> > > On Tue, Aug 25, 2020 at 9:32 AM Kyle Huey <me@kylehuey.com> wrote:
> > > >
> > > > On Tue, Aug 25, 2020 at 9:12 AM Andy Lutomirski <luto@amacapital.ne=
t> wrote:
> > > > > I don=E2=80=99t like this at all. Your behavior really shouldn=E2=
=80=99t depend on
> > > > > whether the new instructions are available.  Also, some day I wou=
ld
> > > > > like to change Linux to have the new behavior even if FSGSBASE
> > > > > instructions are not available, and this will break rr again.  (T=
he
> > > > > current !FSGSBASE behavior is an ugly optimization of dubious val=
ue.
> > > > > I would not go so far as to describe it as correct.)
> > > >
> > > > Ok.
> > > >
> > > > > I would suggest you do one of the following things:
> > > > >
> > > > > 1. Use int $0x80 directly to load 32-bit regs into a child.  This
> > > > > might dramatically simplify your code and should just do the righ=
t
> > > > > thing.
> > > >
> > > > I don't know what that means.
> > >
> > > This is untested, but what I mean is:
> > >
> > > static int ptrace32(int req, pid_t pid, int addr, int data) {
> > >    int ret;
> > >    /* new enough kernels won't clobber r8, etc. */
> > >    asm volatile ("int $0x80" : "=3Da" (ret) : "a" (26 /* ptrace */), =
"b"
> > > (req), "c" (pid), "d" (addr), "S" (data) : "flags", "r8", "r9", "r10"=
,
> > > "r11");
> > >    return ret;
> > > }
> > >
> > > with a handful of caveats:
> > >
> > >  - This won't compile with -fPIC, I think.  Instead you'll need to
> > > write a little bit of asm to set up and restore ebx yourself.  gcc is
> > > silly like this.
> > >
> > >  - Note that addr is an int.  You'll need to mmap(..., MAP_32BIT, ...=
)
> > > to get a buffer that can be pointed to with an int.
> > >
> > > The advantage is that this should work on all kernels that support
> > > 32-bit mode at all.
> > >
> > > >
> > > > > 2. Something like your patch but make it unconditional.
> > > > >
> > > > > 3. Ask for, and receive, real kernel support for setting FS and G=
S in
> > > > > the way that 32-bit code expects.
> > > >
> > > > I think the easiest way forward for us would be a PTRACE_GET/SETREG=
SET
> > > > like operation that operates on the regsets according to the
> > > > *tracee*'s bitness (rather than the tracer, as it works currently).
> > > > Does that sound workable?
> > > >
> > >
> > > Strictly speaking, on Linux, there is no unified concept of a task's
> > > bitness, so "set all these registers according to the target's
> > > bitness" is not well defined.  We could easily give you a
> > > PTRACE_SETREGS_X86_32, etc, though.
> >
> > In the process of responding to this I spent some time doing code
> > inspection and discovered a subtlety in the ptrace API that I was
> > previously unaware of. PTRACE_GET/SETREGS use the regset views
> > corresponding to the tracer but PTRACE_GET/SETREGSET use the regset
> > views corresponding to the tracee. This means it is possible for us
> > today to set FS/GS "the old way" with a 64 bit tracer/32 bit tracee
> > combo, as long as we use PTRACE_SETREGSET with NT_PRSTATUS instead of
> > PTRACE_SETREGS.
>
> Alright I reverted the previous changes and switched us to use
> PTRACE_SETREGSET with NT_PRSTATUS[0] and our 32 bit tests pass again.
> I assume this behavior will remain unchanged indefinitely even when
> the fs/gsbase manipulation instructions are not available since the 32
> bit user_regs_struct can't grow?

Correct.

I think it would be reasonable to add new, less erratic PTRACE_SETxyz
modes, but the old ones will stay as is.

Strictly speaking, the issue you had wasn't a ptrace change.  It was a
context switching change.  Before the change, you were programming
garbage into the tracee state, but the context switch code wasn't
capable of restoring the garbage correctly and instead happened to
restore the state you actually wanted.  With the new code, the context
switch actually worked correctly (for some value of correctly), and
the tracee crashed.  Not that this distinction really matters.
