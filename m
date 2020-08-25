Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92723C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 20:03:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C70F2072D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 20:03:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b="iu4uZkCs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbgHYUDw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 16:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgHYUDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 16:03:51 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92362C061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 13:03:50 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id l2so12156090eji.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 13:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KQDIiZy98GX5Xim6YXb546wx9NRSHPk1zUnMZMln4ko=;
        b=iu4uZkCs6ySZEOsj8gMFTslBMJVVf4orMqR2ZnhH8gLNvxddS//sCsXd1bJdNUP3zJ
         p49pPK92dGoGg8EK9PM/U123z5KGu6pZ9Jd6yIPG5dZoct6RcPfMeAMOqagTZaAqu+l1
         f2IPyFC+vxxwIGY7A2PD8ETKji+HmlSEfAiGf5TJ51oVpEbis6iQ3vHd6JCfUCNLK8OJ
         q/QK8XBJ6GDv9VNYS937QiTW6FGisWhq7xi3Ps1TdCGuoT37BQCOT9Ev+x/whG5dmOyS
         6+qgHKyDduWrOuyb57g85Xt93K6jpG/bK/YsCZvQYVCfq7G+9JtOwPyNsEWakVLDYO6i
         WDng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KQDIiZy98GX5Xim6YXb546wx9NRSHPk1zUnMZMln4ko=;
        b=i3/UdVNRGadf7J4/1IpbXKDywVdNYm66Tx5xgUxkH6+1xRa7h5MrL18a41ykXC0zzL
         GCK6PYtg5hwLhTz8ShVWUKRFtRu4A0RzJ4xRSPTFBxVe1ci7j3JZy3FF8cye7T3354b7
         4KtbmlilfvYeWtA7uytqzJVlvkgcGqgyF90ujbvNbJ3Qnie+iaz/6YE7ErMnQr6q5pCE
         mwhBDz9ndKH9gfu1mEGVR7E59hDfiT9lCL8nS1Vkxzh/8n9glWf/wrXX1HrnwAVqxepz
         IhWX+HPpUevnXIm7BG9E5OGI6amQvtV5q0LouKR8aKQTzmo99Zc/qXKJc7hZNzy8f9Dc
         RXEA==
X-Gm-Message-State: AOAM530cc1Xs0GzE4oMprmO0w1Sf8QtKDnJ78gUNUjOzwA7cHpzWKEKK
        vorwKy1eNqq90NzZm7h3hn2SwgbLZ8kYO0WBXiPdHA==
X-Google-Smtp-Source: ABdhPJxYJR1nLWA/6jxxBNAf1GNBE4NWIkEE/o2nmGQ4S0XJ1gR79t/1O67oGjHc/nEFZQxbDquAmn+lGPdeqcK7BOA=
X-Received: by 2002:a17:906:d187:: with SMTP id c7mr12668828ejz.196.1598385827444;
 Tue, 25 Aug 2020 13:03:47 -0700 (PDT)
MIME-Version: 1.0
References: <CAOp6jLYrwMqV=7hmxgdZUdDZ2aeUB27TTHm=j6cQT7C10Muhww@mail.gmail.com>
 <7DF88F22-0310-40C9-9DA6-5EBCB4877933@amacapital.net> <CALCETrUrvrQNw6dPau_rtHjA_YuCVdCTWYd4dsdcvcGsOaspmg@mail.gmail.com>
 <b0813ec5-b163-cc11-bfc9-e9d08c9c4ff2@zytor.com> <CALCETrXvgb257CWnaA1NgUUp3x08+gJBEOQh4o9OYkB-RvAo1A@mail.gmail.com>
 <CAP045Ao6xBquwSDoCLzzNbEW1Lr969d+D0jQQ2Zb4pX3B77-Xw@mail.gmail.com>
 <CALCETrUgm-Cph4fwqk108VHZPLuM7XWL=nff-xB+hc+hiDrqsg@mail.gmail.com>
 <CAP045Aqhox6YSdk0v_YZWY=y7Ps4ZfH779MG-W4a=gc+cYEY+Q@mail.gmail.com>
 <CALCETrX+TLB+w0X0jc9jq_U4SQezWXEmSpEmmdPobnbUuYfang@mail.gmail.com>
 <CAP045ArKLoNdbX8rhkfC1gSuntTOE6PKaEFszUCh8xTDYYZZZw@mail.gmail.com>
 <CAP045Arh1CORYbKn6GvBPWt+8u3S80Op4LFPVHcpbF2mr4upRw@mail.gmail.com> <CALCETrVnd4VVyReTxmGd0BeHPGp-7W7HoHJA8qdzZsy1OgF91A@mail.gmail.com>
In-Reply-To: <CALCETrVnd4VVyReTxmGd0BeHPGp-7W7HoHJA8qdzZsy1OgF91A@mail.gmail.com>
From:   Kyle Huey <me@kylehuey.com>
Date:   Tue, 25 Aug 2020 13:03:36 -0700
Message-ID: <CAP045Ao+OYoJWsiUYiBCp2Q6kh8+q0xD793ic9=4+NRbn3mfWQ@mail.gmail.com>
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

On Tue, Aug 25, 2020 at 12:32 PM Andy Lutomirski <luto@kernel.org> wrote:
>
> On Tue, Aug 25, 2020 at 11:50 AM Kyle Huey <me@kylehuey.com> wrote:
> >
> > On Tue, Aug 25, 2020 at 10:31 AM Kyle Huey <me@kylehuey.com> wrote:
> > >
> > > On Tue, Aug 25, 2020 at 9:46 AM Andy Lutomirski <luto@kernel.org> wro=
te:
> > > >
> > > > On Tue, Aug 25, 2020 at 9:32 AM Kyle Huey <me@kylehuey.com> wrote:
> > > > >
> > > > > On Tue, Aug 25, 2020 at 9:12 AM Andy Lutomirski <luto@amacapital.=
net> wrote:
> > > > > > I don=E2=80=99t like this at all. Your behavior really shouldn=
=E2=80=99t depend on
> > > > > > whether the new instructions are available.  Also, some day I w=
ould
> > > > > > like to change Linux to have the new behavior even if FSGSBASE
> > > > > > instructions are not available, and this will break rr again.  =
(The
> > > > > > current !FSGSBASE behavior is an ugly optimization of dubious v=
alue.
> > > > > > I would not go so far as to describe it as correct.)
> > > > >
> > > > > Ok.
> > > > >
> > > > > > I would suggest you do one of the following things:
> > > > > >
> > > > > > 1. Use int $0x80 directly to load 32-bit regs into a child.  Th=
is
> > > > > > might dramatically simplify your code and should just do the ri=
ght
> > > > > > thing.
> > > > >
> > > > > I don't know what that means.
> > > >
> > > > This is untested, but what I mean is:
> > > >
> > > > static int ptrace32(int req, pid_t pid, int addr, int data) {
> > > >    int ret;
> > > >    /* new enough kernels won't clobber r8, etc. */
> > > >    asm volatile ("int $0x80" : "=3Da" (ret) : "a" (26 /* ptrace */)=
, "b"
> > > > (req), "c" (pid), "d" (addr), "S" (data) : "flags", "r8", "r9", "r1=
0",
> > > > "r11");
> > > >    return ret;
> > > > }
> > > >
> > > > with a handful of caveats:
> > > >
> > > >  - This won't compile with -fPIC, I think.  Instead you'll need to
> > > > write a little bit of asm to set up and restore ebx yourself.  gcc =
is
> > > > silly like this.
> > > >
> > > >  - Note that addr is an int.  You'll need to mmap(..., MAP_32BIT, .=
..)
> > > > to get a buffer that can be pointed to with an int.
> > > >
> > > > The advantage is that this should work on all kernels that support
> > > > 32-bit mode at all.
> > > >
> > > > >
> > > > > > 2. Something like your patch but make it unconditional.
> > > > > >
> > > > > > 3. Ask for, and receive, real kernel support for setting FS and=
 GS in
> > > > > > the way that 32-bit code expects.
> > > > >
> > > > > I think the easiest way forward for us would be a PTRACE_GET/SETR=
EGSET
> > > > > like operation that operates on the regsets according to the
> > > > > *tracee*'s bitness (rather than the tracer, as it works currently=
).
> > > > > Does that sound workable?
> > > > >
> > > >
> > > > Strictly speaking, on Linux, there is no unified concept of a task'=
s
> > > > bitness, so "set all these registers according to the target's
> > > > bitness" is not well defined.  We could easily give you a
> > > > PTRACE_SETREGS_X86_32, etc, though.
> > >
> > > In the process of responding to this I spent some time doing code
> > > inspection and discovered a subtlety in the ptrace API that I was
> > > previously unaware of. PTRACE_GET/SETREGS use the regset views
> > > corresponding to the tracer but PTRACE_GET/SETREGSET use the regset
> > > views corresponding to the tracee. This means it is possible for us
> > > today to set FS/GS "the old way" with a 64 bit tracer/32 bit tracee
> > > combo, as long as we use PTRACE_SETREGSET with NT_PRSTATUS instead of
> > > PTRACE_SETREGS.
> >
> > Alright I reverted the previous changes and switched us to use
> > PTRACE_SETREGSET with NT_PRSTATUS[0] and our 32 bit tests pass again.
> > I assume this behavior will remain unchanged indefinitely even when
> > the fs/gsbase manipulation instructions are not available since the 32
> > bit user_regs_struct can't grow?
>
> Correct.
>
> I think it would be reasonable to add new, less erratic PTRACE_SETxyz
> modes, but the old ones will stay as is.
>
> Strictly speaking, the issue you had wasn't a ptrace change.  It was a
> context switching change.  Before the change, you were programming
> garbage into the tracee state, but the context switch code wasn't
> capable of restoring the garbage correctly and instead happened to
> restore the state you actually wanted.  With the new code, the context
> switch actually worked correctly (for some value of correctly), and
> the tracee crashed.  Not that this distinction really matters.

Yes. We've been feeding the kernel trash for years. You were just
letting us get away with it before ;)

- Kyle
