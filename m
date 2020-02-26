Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13FA6C4BA0B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 11:20:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D73F624685
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 11:20:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="h2WHtBI0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728184AbgBZLU3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 06:20:29 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42739 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727860AbgBZLU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 06:20:29 -0500
Received: by mail-pf1-f196.google.com with SMTP id 4so1297874pfz.9
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 03:20:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=cNtk5E6yBg6B3/z5M+SkvidmF9inEE+2d6uICsSh8LM=;
        b=h2WHtBI07xgxSUSkOp2ZStJaBUlbMbinoEAoe8rZvsKwosN/034yfIaYTuV/R/miue
         ItQp+1jcSZIOE7SImU0IYxQxmoP9HUatZzweHXMat62gS11374o0ZdCRV4wxdBH37sDO
         2S8Qchnz4UzanC9KJnFySulPN0I6EBvzhOw/SBrd0SYiXrmzmtkFNgIiF43Gz9rKPchh
         S17IMmCwoH1hqK7I26vBPylFyMROZujoiv+B9hxje49SLNch/02+A5MbqBFRndth/iC/
         Eyqji9euLlNOhh+vIadIuL0yW77v3i5CMpq6HrFus+9cnnwWPEeo2uYUHKAYPEGXPBxx
         ZMKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=cNtk5E6yBg6B3/z5M+SkvidmF9inEE+2d6uICsSh8LM=;
        b=i/lYdsMTtiVG8cZxtc37z+/wrLhwIZQYHt80lXXQRcOTaANI7taBvQwemPZJDoqQTd
         4lmNdnzX4u/VNLf8LcbCue0P1e34/UMhRvgsOc9Zt97tBW2fvdfy3/TNCpmeo0bLPmv1
         IyuplLge+CMR3dNkYLYI7Y2hypOvrKyhUamn2vJy89OeRTT1WFvm/09eAOBbrlp2m0xK
         3rUwFlTaU1ygF+ZKyJJ5rl/gwotFNho0fd4YPubGWTfYNG1TLtt+Hb7GYTAqt/9JqQhi
         xrKUK1aSTF/Xvm6/zRUQZCSsyNSEaUuuyqYJPYmds5TjTdtvAwTfN2apiAPEARqk2scA
         I6Og==
X-Gm-Message-State: APjAAAUj6YfgxshWWzkThJ5bMt9oI148EqRzGaQ/XEImPCEb2g0cbGmp
        YEobApONoaSUnLuytETKMwmNQw==
X-Google-Smtp-Source: APXvYqzDZDT2U2PYi5RGWZ0bGww/ZtcfCXQKFSB0VAa9eJtI8amWjSkDkL8lIQjbEX5yO1pvm5Y57Q==
X-Received: by 2002:a63:ba05:: with SMTP id k5mr3335463pgf.174.1582716027000;
        Wed, 26 Feb 2020 03:20:27 -0800 (PST)
Received: from ?IPv6:2601:646:c200:1ef2:b477:69e0:6292:cf08? ([2601:646:c200:1ef2:b477:69e0:6292:cf08])
        by smtp.gmail.com with ESMTPSA id q11sm2708049pff.111.2020.02.26.03.20.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2020 03:20:26 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [patch 4/8] x86/entry: Move irq tracing on syscall entry to C-code
Date:   Wed, 26 Feb 2020 03:20:25 -0800
Message-Id: <83D8A083-792A-4A82-985C-CAC33BC702DB@amacapital.net>
References: <20200226081726.GQ18400@hirez.programming.kicks-ass.net>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <JGross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <20200226081726.GQ18400@hirez.programming.kicks-ass.net>
To:     Peter Zijlstra <peterz@infradead.org>
X-Mailer: iPhone Mail (17D50)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Feb 26, 2020, at 12:17 AM, Peter Zijlstra <peterz@infradead.org> wrote:=

>=20
> =EF=BB=BFOn Tue, Feb 25, 2020 at 09:43:46PM -0800, Andy Lutomirski wrote:
>>> On 2/25/20 2:08 PM, Thomas Gleixner wrote:
>>> Now that the C entry points are safe, move the irq flags tracing code in=
to
>>> the entry helper.
>>=20
>> I'm so confused.
>>=20
>>>=20
>>> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>>> ---
>>> arch/x86/entry/common.c          |    5 +++++
>>> arch/x86/entry/entry_32.S        |   12 ------------
>>> arch/x86/entry/entry_64.S        |    2 --
>>> arch/x86/entry/entry_64_compat.S |   18 ------------------
>>> 4 files changed, 5 insertions(+), 32 deletions(-)
>>>=20
>>> --- a/arch/x86/entry/common.c
>>> +++ b/arch/x86/entry/common.c
>>> @@ -57,6 +57,11 @@ static inline void enter_from_user_mode(
>>>  */
>>> static __always_inline void syscall_entry_fixups(void)
>>> {
>>> +    /*
>>> +     * Usermode is traced as interrupts enabled, but the syscall entry
>>> +     * mechanisms disable interrupts. Tell the tracer.
>>> +     */
>>> +    trace_hardirqs_off();
>>=20
>> Your earlier patches suggest quite strongly that tracing isn't safe
>> until enter_from_user_mode().  But trace_hardirqs_off() calls
>> trace_irq_disable_rcuidle(), which looks [0] like a tracepoint.
>>=20
>> Did you perhaps mean to do this *after* enter_from_user_mode()?
>=20
> aside from the fact that enter_from_user_mode() itself also has a
> tracepoint, the crucial detail is that we must not trace/kprobe the
> function calling this.
>=20
> Specifically for #PF, because we need read_cr2() before this. See later
> patches.

Indeed. I=E2=80=99m fine with this patch, but I still don=E2=80=99t understa=
nd what the changelog is about. And I=E2=80=99m still rather baffled by most=
 of the notrace annotations in the series.=
