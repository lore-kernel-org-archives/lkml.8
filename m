Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0CA6C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 17:32:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C67842076C
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 17:32:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b="YQx42pHO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbgHYRcO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 13:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgHYRcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 13:32:12 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 937E2C061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 10:32:11 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id q4so2152241eds.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 10:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=37YjFvfGUrUoPQRff1MpT8oVlpr3fqL+nMv5i4fSK4g=;
        b=YQx42pHOZc5N8G3XsEfnMM2ARp6TEv3TI3yU31wboJckh6S83T90uD2dqH0i07L0EX
         iSOOGkhqqxpHCpYzPf6XiWNxBTNcT131QQHTWLrPgwG2zG03Bugt2FvJ4714K5x/z+Ar
         KLrS+KC+jA7IzgfjUOveTR0GvQQO/ts27jwxxC0JRr4oAKP8pqrnu58MsosM6B994+CD
         m3bU/nFcsUtvuQUMwpdn5W0TzoD3qFCbobBYkSrNeKgvVHjLu0mb9+dDjh+HsomW9ylg
         x5fx92q5rHPWOGgydHGQLziOgs/m6LCfzV9UdWz+vnZHoCwtCD8v1JtlH2kaP0ar6IWN
         pXow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=37YjFvfGUrUoPQRff1MpT8oVlpr3fqL+nMv5i4fSK4g=;
        b=trFyr9OjTEO2gtO73PInXwMPhmk+gfWbHGOD11lXEqBINfPS5G5Qkdil+qJje4UpmW
         gzCI00SFHud8/UaU4J9j0eDFq+BPUYpBWhVImdSRhEp0O9wAxh+bVg63YLNVMDJexShv
         xai8OcaanQ7V61aMicAkaCpZQ2oJm61oMhlhietpLa07qFHpNEK9SOAHuw7hjtogTBdJ
         4Sf0+bdE+knVxWoF1OdzRIi29AbdBtsSXpemJczfdSV9zYgR+YczwVgYlDUXU3L15C8k
         WOGrqHSzwjAphvMpu+fp5eBk7L4yUktMEx/ZOYrhqy3uRt803x7eCJlisyhl+E+HHSwq
         HBZQ==
X-Gm-Message-State: AOAM530GD8DPTTMx+AsHORmxY6Lx/1c1REFcJKsj3Ev29oS4CC9rka8W
        eNnkkTZavxO2cOYHMwlV5X3Erw7ouHGnZ25inAHjjQ==
X-Google-Smtp-Source: ABdhPJxr6PkGNq+grGUmoUA1Eewz9GLvKH0m7Xk7R8zM2K7cAckkPz9Y7lFlFW+5XkVD8xC0790k9phF74yJ1/KtaeU=
X-Received: by 2002:aa7:da9a:: with SMTP id q26mr11600701eds.163.1598376730101;
 Tue, 25 Aug 2020 10:32:10 -0700 (PDT)
MIME-Version: 1.0
References: <CAOp6jLYrwMqV=7hmxgdZUdDZ2aeUB27TTHm=j6cQT7C10Muhww@mail.gmail.com>
 <7DF88F22-0310-40C9-9DA6-5EBCB4877933@amacapital.net> <CALCETrUrvrQNw6dPau_rtHjA_YuCVdCTWYd4dsdcvcGsOaspmg@mail.gmail.com>
 <b0813ec5-b163-cc11-bfc9-e9d08c9c4ff2@zytor.com> <CALCETrXvgb257CWnaA1NgUUp3x08+gJBEOQh4o9OYkB-RvAo1A@mail.gmail.com>
 <CAP045Ao6xBquwSDoCLzzNbEW1Lr969d+D0jQQ2Zb4pX3B77-Xw@mail.gmail.com>
 <CALCETrUgm-Cph4fwqk108VHZPLuM7XWL=nff-xB+hc+hiDrqsg@mail.gmail.com>
 <CAP045Aqhox6YSdk0v_YZWY=y7Ps4ZfH779MG-W4a=gc+cYEY+Q@mail.gmail.com> <CALCETrX+TLB+w0X0jc9jq_U4SQezWXEmSpEmmdPobnbUuYfang@mail.gmail.com>
In-Reply-To: <CALCETrX+TLB+w0X0jc9jq_U4SQezWXEmSpEmmdPobnbUuYfang@mail.gmail.com>
From:   Kyle Huey <me@kylehuey.com>
Date:   Tue, 25 Aug 2020 10:31:58 -0700
Message-ID: <CAP045ArKLoNdbX8rhkfC1gSuntTOE6PKaEFszUCh8xTDYYZZZw@mail.gmail.com>
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

On Tue, Aug 25, 2020 at 9:46 AM Andy Lutomirski <luto@kernel.org> wrote:
>
> On Tue, Aug 25, 2020 at 9:32 AM Kyle Huey <me@kylehuey.com> wrote:
> >
> > On Tue, Aug 25, 2020 at 9:12 AM Andy Lutomirski <luto@amacapital.net> w=
rote:
> > > I don=E2=80=99t like this at all. Your behavior really shouldn=E2=80=
=99t depend on
> > > whether the new instructions are available.  Also, some day I would
> > > like to change Linux to have the new behavior even if FSGSBASE
> > > instructions are not available, and this will break rr again.  (The
> > > current !FSGSBASE behavior is an ugly optimization of dubious value.
> > > I would not go so far as to describe it as correct.)
> >
> > Ok.
> >
> > > I would suggest you do one of the following things:
> > >
> > > 1. Use int $0x80 directly to load 32-bit regs into a child.  This
> > > might dramatically simplify your code and should just do the right
> > > thing.
> >
> > I don't know what that means.
>
> This is untested, but what I mean is:
>
> static int ptrace32(int req, pid_t pid, int addr, int data) {
>    int ret;
>    /* new enough kernels won't clobber r8, etc. */
>    asm volatile ("int $0x80" : "=3Da" (ret) : "a" (26 /* ptrace */), "b"
> (req), "c" (pid), "d" (addr), "S" (data) : "flags", "r8", "r9", "r10",
> "r11");
>    return ret;
> }
>
> with a handful of caveats:
>
>  - This won't compile with -fPIC, I think.  Instead you'll need to
> write a little bit of asm to set up and restore ebx yourself.  gcc is
> silly like this.
>
>  - Note that addr is an int.  You'll need to mmap(..., MAP_32BIT, ...)
> to get a buffer that can be pointed to with an int.
>
> The advantage is that this should work on all kernels that support
> 32-bit mode at all.
>
> >
> > > 2. Something like your patch but make it unconditional.
> > >
> > > 3. Ask for, and receive, real kernel support for setting FS and GS in
> > > the way that 32-bit code expects.
> >
> > I think the easiest way forward for us would be a PTRACE_GET/SETREGSET
> > like operation that operates on the regsets according to the
> > *tracee*'s bitness (rather than the tracer, as it works currently).
> > Does that sound workable?
> >
>
> Strictly speaking, on Linux, there is no unified concept of a task's
> bitness, so "set all these registers according to the target's
> bitness" is not well defined.  We could easily give you a
> PTRACE_SETREGS_X86_32, etc, though.

In the process of responding to this I spent some time doing code
inspection and discovered a subtlety in the ptrace API that I was
previously unaware of. PTRACE_GET/SETREGS use the regset views
corresponding to the tracer but PTRACE_GET/SETREGSET use the regset
views corresponding to the tracee. This means it is possible for us
today to set FS/GS "the old way" with a 64 bit tracer/32 bit tracee
combo, as long as we use PTRACE_SETREGSET with NT_PRSTATUS instead of
PTRACE_SETREGS.

- Kyle
