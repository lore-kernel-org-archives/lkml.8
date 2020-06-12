Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC047C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 09:18:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BE1F20801
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 09:18:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="YcJ5J/GM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbgFLJSN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 05:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbgFLJSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 05:18:12 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58911C03E96F
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 02:18:12 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id h10so124061pgq.10
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 02:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=ea05IbzOsFLNzK/q1opdgiePX7/yQgXvQW1ZI8l1OV0=;
        b=YcJ5J/GME/6OIE7GKIsIYPbJBOn9vMjQq8TeEYfj+ViczSLokFiKbgVemPZrSLwG1+
         SpS5qfEwaxNM0Y+lPV07VdRyLVZPHocM9UZJHHd6kphl1408svBB5mjw9x7oCL+PcN0U
         4Qpvt+A/mWF1Wj42xgr26GGYHU/L18VliNyE2dSThiCQMQfsJwo0JvKeQGH2xifET/GT
         9j2hDlj6/dUCz6Y4vLL8ZHieO4OQE8kWIRfn0KaMWhA0poUc2jDmkNtok/gjVkr1TXF2
         u5xEcVwlZP2qdWlVF97oQyTnrVQhgZGyZGI2ADU16rEDbrOOnUm8on20kp2uMOHIukTw
         VgGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=ea05IbzOsFLNzK/q1opdgiePX7/yQgXvQW1ZI8l1OV0=;
        b=WEUi7ITphvH2URJR0qsloA7A5m4CjTwO7M6VIJbOERqPn0PkrZurgY1KE0VkyVno9C
         TWADPG5dWHuHn9Ji/3OLp36H9KSHAlfTEmOOBsSkj76Sg3z8Y9ZSagkYSk73s4E4WSUm
         3A3YrMdNfStBNKcOhBWwqT0BhL94FZp/AEOHIEJnvK6LUwIY+LR6IrMX73Uk3E5OjR5p
         UuLsWuw84tZJoc1G66Gxzram76VSm8CSeM3FT1yXho/y3olgMaOS8daIxwLo+cg1M7Kq
         d4eEakVyTfYQ2iGZnI8qEXMr6l4wAMSTaOHlVXSpMZt8KKutwV65gFdSQtmKeoZpOuzt
         ugoA==
X-Gm-Message-State: AOAM532j2NGEl/1lmCDDruCB/EnzuhG/T88zCQ0hBMlvPdih8jtAQORV
        LSwIXBnqADGx+ioxZsnNJiaSUw==
X-Google-Smtp-Source: ABdhPJw7p3AmjrmF4gOEPh4Mj8IFSG1eQgga0wJBu8krDLvWm/OqeLmjNLzSHAr0nxxzeYgL9rsYzA==
X-Received: by 2002:aa7:9537:: with SMTP id c23mr10802234pfp.149.1591953491704;
        Fri, 12 Jun 2020 02:18:11 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:c0da:d349:5a19:d9c1? ([2601:646:c200:1ef2:c0da:d349:5a19:d9c1])
        by smtp.gmail.com with ESMTPSA id m9sm5530035pfo.200.2020.06.12.02.18.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jun 2020 02:18:10 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: Perf: WARNING: arch/x86/entry/common.c:624 idtentry_exit_cond_rcu+0x92/0xc0
Date:   Fri, 12 Jun 2020 02:18:07 -0700
Message-Id: <8DD3180E-0E69-4FD6-92C3-311AAB3F688F@amacapital.net>
References: <87imfwd5f6.fsf@nanos.tec.linutronix.de>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>, cj.chengjian@huawei.com,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michel Lespinasse <walken@google.com>,
        lkft-triage@lists.linaro.org,
        Dave Hansen <dave.hansen@linux.intel.com>
In-Reply-To: <87imfwd5f6.fsf@nanos.tec.linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
X-Mailer: iPhone Mail (17F80)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jun 12, 2020, at 2:01 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
>=20
> =EF=BB=BFAndy Lutomirski <luto@kernel.org> writes:
>> On Thu, Jun 11, 2020 at 4:22 PM Andy Lutomirski <luto@kernel.org> wrote:
>>=20
>> Two bugs here.
>>=20
>> 1. We had an issue with WARN. Patch sent.
>=20
> Grabbed it
>=20
>> 2. idtentry.h has, for x86_32:
>>=20
>> # define DEFINE_IDTENTRY_IST  DEFINE_IDTENTRY
>>=20
>> This is nonsense.  It's getting late over here and I'd rather focus on
>> the more interesting RCU issue, so that's all from me today.
>=20
> Well, this might be nonsense, but it's exactly matching the current code
> in mainline which, e.g. for #DB does:
>=20
> SYM_CODE_START(debug)
>    /*
>     * Entry from sysenter is now handled in common_exception
>     */
>    ASM_CLAC
>    pushl    $0
>    pushl    $do_debug
>    jmp    common_exception
> SYM_CODE_END(debug)
>=20
> There is no IST on 32bit, never was. We do software stack switching for
> device interrupts, but that's a different story.
>=20

DEFINE_IDTENTRY does the idtentry_enter_cond_rcu() dance, which isn=E2=80=99=
t intended to be safe from NMI context.  It should probably map to DEFINE_ID=
TENTRY_RAW() instead.  The specific issue is that NMI ends up there, and at l=
east DEFINE_IDTENTRY_NMI should be raw.

I haven=E2=80=99t tried this at all, nor have I dug through all the users of=
 these macros to check what they expect.  Perhaps we should not have the _IS=
T one defined at all on 32 bit and rename it to DEFINE_IDTENTRY_IST_RAW on 6=
4 bit to make it more clear what=E2=80=99s going on when reading the C code.=


Or maybe I=E2=80=99m too sleepy and I=E2=80=99m nuts. But I don=E2=80=99t th=
ink I am.


> Thanks,
>=20
>        tglx
