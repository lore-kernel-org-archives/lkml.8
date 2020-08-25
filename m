Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D9D4C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 16:46:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2623020782
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 16:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598373995;
	bh=h7VlFzTauWqMoJUomlXnnALAqMdX0hYV+PCoeAtM3rU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=2a+jbfRsea2563I9+Z81h+jT07rvXeKvTloRT6cyIP+P0STCnGMEUSclr2pTAz6O5
	 iOnXLINdJL+4f9M0PAFywKiWf33sVenciKvqDeXMKjy6E2WfSNb2VAGIcNPpRDYTZ7
	 Os1vKhnCdHiYZzYaTHzXYwIZraUQ0A6Srjicb8BQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbgHYQqc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 12:46:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:38810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726356AbgHYQq0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 12:46:26 -0400
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35A3F20897
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 16:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598373985;
        bh=h7VlFzTauWqMoJUomlXnnALAqMdX0hYV+PCoeAtM3rU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ixCNTejeXeS4PKewMPrRJz0TPr9F/qVGDl1NVmW5yLCnXY+CNkM1PeCIUztLTNI1J
         yhAfbnlEao6slE5NERq5TsP1mTb+Dm5wPk1oQLas3zK6gxiPkQseCT/9Yk0PjUeetv
         eiOxO5rEY6DiQrfVdAvuOPrz9UgKSZFqqYBcPWU8=
Received: by mail-wr1-f53.google.com with SMTP id x7so7384256wro.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 09:46:25 -0700 (PDT)
X-Gm-Message-State: AOAM530MK1Tixq81K1bMpCUJF5viiGSgGL7YNbyQoeM82wL7b0uWhGFZ
        L+HktYY3+nvHg6nqK6Fv9tZQyxI7VoA/xG+YbQSIkQ==
X-Google-Smtp-Source: ABdhPJxswIrK25qCisxfAyv3fZDFeyCIvRRGk35lL5GQWcCGTLO6frz2GitjxtR2oXxuSk02fsGFCsm1Ywrtb5Smdmg=
X-Received: by 2002:a5d:400e:: with SMTP id n14mr11308231wrp.75.1598373983617;
 Tue, 25 Aug 2020 09:46:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAOp6jLYrwMqV=7hmxgdZUdDZ2aeUB27TTHm=j6cQT7C10Muhww@mail.gmail.com>
 <7DF88F22-0310-40C9-9DA6-5EBCB4877933@amacapital.net> <CALCETrUrvrQNw6dPau_rtHjA_YuCVdCTWYd4dsdcvcGsOaspmg@mail.gmail.com>
 <b0813ec5-b163-cc11-bfc9-e9d08c9c4ff2@zytor.com> <CALCETrXvgb257CWnaA1NgUUp3x08+gJBEOQh4o9OYkB-RvAo1A@mail.gmail.com>
 <CAP045Ao6xBquwSDoCLzzNbEW1Lr969d+D0jQQ2Zb4pX3B77-Xw@mail.gmail.com>
 <CALCETrUgm-Cph4fwqk108VHZPLuM7XWL=nff-xB+hc+hiDrqsg@mail.gmail.com> <CAP045Aqhox6YSdk0v_YZWY=y7Ps4ZfH779MG-W4a=gc+cYEY+Q@mail.gmail.com>
In-Reply-To: <CAP045Aqhox6YSdk0v_YZWY=y7Ps4ZfH779MG-W4a=gc+cYEY+Q@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 25 Aug 2020 09:46:11 -0700
X-Gmail-Original-Message-ID: <CALCETrX+TLB+w0X0jc9jq_U4SQezWXEmSpEmmdPobnbUuYfang@mail.gmail.com>
Message-ID: <CALCETrX+TLB+w0X0jc9jq_U4SQezWXEmSpEmmdPobnbUuYfang@mail.gmail.com>
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

On Tue, Aug 25, 2020 at 9:32 AM Kyle Huey <me@kylehuey.com> wrote:
>
> On Tue, Aug 25, 2020 at 9:12 AM Andy Lutomirski <luto@amacapital.net> wro=
te:
> > I don=E2=80=99t like this at all. Your behavior really shouldn=E2=80=99=
t depend on
> > whether the new instructions are available.  Also, some day I would
> > like to change Linux to have the new behavior even if FSGSBASE
> > instructions are not available, and this will break rr again.  (The
> > current !FSGSBASE behavior is an ugly optimization of dubious value.
> > I would not go so far as to describe it as correct.)
>
> Ok.
>
> > I would suggest you do one of the following things:
> >
> > 1. Use int $0x80 directly to load 32-bit regs into a child.  This
> > might dramatically simplify your code and should just do the right
> > thing.
>
> I don't know what that means.

This is untested, but what I mean is:

static int ptrace32(int req, pid_t pid, int addr, int data) {
   int ret;
   /* new enough kernels won't clobber r8, etc. */
   asm volatile ("int $0x80" : "=3Da" (ret) : "a" (26 /* ptrace */), "b"
(req), "c" (pid), "d" (addr), "S" (data) : "flags", "r8", "r9", "r10",
"r11");
   return ret;
}

with a handful of caveats:

 - This won't compile with -fPIC, I think.  Instead you'll need to
write a little bit of asm to set up and restore ebx yourself.  gcc is
silly like this.

 - Note that addr is an int.  You'll need to mmap(..., MAP_32BIT, ...)
to get a buffer that can be pointed to with an int.

The advantage is that this should work on all kernels that support
32-bit mode at all.

>
> > 2. Something like your patch but make it unconditional.
> >
> > 3. Ask for, and receive, real kernel support for setting FS and GS in
> > the way that 32-bit code expects.
>
> I think the easiest way forward for us would be a PTRACE_GET/SETREGSET
> like operation that operates on the regsets according to the
> *tracee*'s bitness (rather than the tracer, as it works currently).
> Does that sound workable?
>

Strictly speaking, on Linux, there is no unified concept of a task's
bitness, so "set all these registers according to the target's
bitness" is not well defined.  We could easily give you a
PTRACE_SETREGS_X86_32, etc, though.
