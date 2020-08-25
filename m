Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FE89C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 16:12:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E69820782
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 16:12:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="S7QxLRcg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbgHYQMy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 12:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726936AbgHYQMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 12:12:49 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27A69C061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 09:12:49 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id o4so9271012wrn.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 09:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KeeelhNThceuvAVrIb7QCi1JJ9d3yQ1o1h3TMUjstBY=;
        b=S7QxLRcgwkhCJDm0molIIQh/dn5C9AQSNgzhFglNsY7kPwH2/+80ldDjv7YnuqoMzs
         TwQZ07quOL4IkCLdH0Paelpi14P7DuGaU7agZf42f0q3v31hZcuGGD5tthub1D4GE+Y8
         fD/5vSOIR9Oy6im/x/qm/TVCyFvLuVVWCDjqXbuM/ihaS5wRz+6gKLKAeDO4+E5amTtD
         08jjNie+BbGpGfFRjGu0XklY39zemCle9Gok1IWrLgM6GJfNzXV7NkqMCoU/xivZcqIy
         Ta95hIzAITgFujSHhTT9SJtAUda7jWZ3PKGDjwJEAzWJ1AS1QBp9VuvtJ3/Io8CWDs3b
         ITWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KeeelhNThceuvAVrIb7QCi1JJ9d3yQ1o1h3TMUjstBY=;
        b=ajyNOdWsLUeHb5xqPt+wYQpyDPPYkvASoSPG6DhCJ1xUa91tjvwSna0nKL7xjzZNh4
         JDJJyFvOw6SyaOky3UHPdynnuJxPcH7z4e/wMCBIqRauanEa6L2TO/2XsdgGyGwMiqZ7
         9da7zvkiHmWpMtXTprKFutb1v7ymt1ipvXCiSyPdu+yT1g+FP/7Yic/dDJd4zZX2Q9su
         gjJq3Z+CbADpfUnvFWEorqP0Jg4fRWkn1JRrfC2ES8goKHyaXXFLUEYiwaVF9aquNkwc
         r8RgFBE9m0I8MoNnmxHkvSaBLXHjwXBX2ZZb2jGAcpqpabCfzN6D8ff1Daey4yk3bw7n
         tqKw==
X-Gm-Message-State: AOAM533+l92FGT9Ua2xti0Wl44HuUkC2YPkQCrCQGtuTHFXZvbGOlEUg
        Is5e7CrHBRpJIwqEfPup35Aq1MDB0iRXFTvGEDSfbB0eBg4jTQ==
X-Google-Smtp-Source: ABdhPJzQZxnWRfCdB7Aq5tK35TRKd8mSWELzn/tMC3PNCV6e42nHkaD8USRkcmfS9b6KV0sRB4lAMjU6iyq9esdm1To=
X-Received: by 2002:adf:9283:: with SMTP id 3mr11194937wrn.70.1598371967713;
 Tue, 25 Aug 2020 09:12:47 -0700 (PDT)
MIME-Version: 1.0
References: <CAOp6jLYrwMqV=7hmxgdZUdDZ2aeUB27TTHm=j6cQT7C10Muhww@mail.gmail.com>
 <7DF88F22-0310-40C9-9DA6-5EBCB4877933@amacapital.net> <CALCETrUrvrQNw6dPau_rtHjA_YuCVdCTWYd4dsdcvcGsOaspmg@mail.gmail.com>
 <b0813ec5-b163-cc11-bfc9-e9d08c9c4ff2@zytor.com> <CALCETrXvgb257CWnaA1NgUUp3x08+gJBEOQh4o9OYkB-RvAo1A@mail.gmail.com>
 <CAP045Ao6xBquwSDoCLzzNbEW1Lr969d+D0jQQ2Zb4pX3B77-Xw@mail.gmail.com>
In-Reply-To: <CAP045Ao6xBquwSDoCLzzNbEW1Lr969d+D0jQQ2Zb4pX3B77-Xw@mail.gmail.com>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Tue, 25 Aug 2020 09:12:36 -0700
Message-ID: <CALCETrUgm-Cph4fwqk108VHZPLuM7XWL=nff-xB+hc+hiDrqsg@mail.gmail.com>
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

> On Aug 24, 2020, at 5:46 PM, Kyle Huey <me@kylehuey.com> wrote:
>
> =EF=BB=BFOn Mon, Aug 24, 2020 at 5:31 PM Andy Lutomirski <luto@kernel.org=
> wrote:
>>
>>> On Mon, Aug 24, 2020 at 4:52 PM H. Peter Anvin <hpa@zytor.com> wrote:
>>>
>>> On 2020-08-24 14:10, Andy Lutomirski wrote:
>>>>
>>>> PTRACE_READ_SEGMENT_DESCRIPTOR to read a segment descriptor.
>>>>
>>>> PTRACE_SET_FS / PTRACE_SET_GS: Sets FS or GS and updates the base acco=
rdingly.
>>>>
>>>> PTRACE_READ_SEGMENT_BASE: pass in a segment selector, get a base out.
>>>> You would use this to populate the base fields.
>>>>
>>>> or perhaps a ptrace SETREGS variant that tries to preserve the old
>>>> base semantics and magically sets the bases to match the selectors if
>>>> the selectors are nonzero.
>>>>
>>>> Do any of these choices sound preferable to any of you?
>>>>
>>>
>>> My suggestion would be to export the GDT and LDT as a (readonly or most=
ly
>>> readonly) regset(s) rather than adding entirely new operations. We coul=
d allow
>>> the LDT and the per-thread GDT entries to be written, subject to the sa=
me
>>> limitations as the corresponding system calls.
>>>
>>
>> That seems useful, although we'd want to do some extensive
>> sanitization of the GDT.  But maybe it's obnoxious to ask Kyle and
>> Robert to parse the GDT, LDT, and selector just to emulate the
>> demented pre-5.9 ptrace() behavior.
>>
>> --Andy
>
> We've already addressed the main issue on rr's side[0]. The only
> outstanding issue is that if you record a trace with 32 bit programs
> on a pre-5.9 64 bit kernel and then try to replay it on 5.9 it won't
> work. If you hit this case rr will print an error message telling you
> to boot your 5.9 kernel with nofsgsbase if you want to replay the
> trace. I think that's probably sufficient. 32 bit is legacy stuff we
> don't care that much about anyways, replaying traces on a different
> kernel/machine has always been a bit dicey, and if you absolutely must
> do it there is a workaround. I'm not inclined to do much work to
> support the narrow remaining case.
>
> - Kyle
>
> [0] Namely, we're tracking fs/gsbase for 32 bit tracees on 64 bit
> kernels where the fs/gsbase instructions work in new recordings now:
> https://github.com/mozilla/rr/commit/c3292c75dbd8c9ce5256496108965c044242=
4eef


I don=E2=80=99t like this at all. Your behavior really shouldn=E2=80=99t de=
pend on
whether the new instructions are available.  Also, some day I would
like to change Linux to have the new behavior even if FSGSBASE
instructions are not available, and this will break rr again.  (The
current !FSGSBASE behavior is an ugly optimization of dubious value.
I would not go so far as to describe it as correct.)

I would suggest you do one of the following things:

1. Use int $0x80 directly to load 32-bit regs into a child.  This
might dramatically simplify your code and should just do the right
thing.

2. Something like your patch but make it unconditional.

3. Ask for, and receive, real kernel support for setting FS and GS in
the way that 32-bit code expects.

Also, for other x86 kernel folks playing along, WTF is
task_user_regset_vew() about?  It has eight callers, in two groups,
and as far as I can tell every single call returns &user_x86_64_view
because it's only called in the 64-bit and x32 syscall paths, and
those are only reachable using the 64-bit SYSCALL instruction.  I
suppose the exception is if someone ptraces the ptracer and changes CS
at syscall entry.  In any case, if task_user_regset_view() ever
returns anything else, the code will malfunction.  I'll send a patch
to get rid of it.

--Andy
