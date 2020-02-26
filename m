Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B075C4BA24
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 21:35:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DEA82072D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 21:35:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="vCg8DAvd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727701AbgBZVfx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 16:35:53 -0500
Received: from mail-pl1-f172.google.com ([209.85.214.172]:41102 "EHLO
        mail-pl1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727504AbgBZVfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 16:35:52 -0500
Received: by mail-pl1-f172.google.com with SMTP id t14so213343plr.8
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 13:35:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=DrlZPkFHPfMcURWoioWFQWpr3JzSyq1PfKt5XZOS+/A=;
        b=vCg8DAvdA3g+W72QHHE+zKDFACo1PwmeeTyqymX6t6fSaulXsjls6LWVFozeraFsIo
         thFFqi7LecFqiN+z8CUQ3rh6Ghk/DgDrYBFRJ8vPcY0U+S3ohzyoJyb7rLiNYMG1zoY4
         mbpPRik0XfiKtjXuQCpYS4VlcH6ayNfv6yT5q76Px4fFk9oIW6Kw/7B/nrY842xjhM0A
         TWDcZBfVyyukLkN52XsNJTQ2YiEysKihb9ABlYYjNaVUkOHaZ5adZ+bQ8mFY+Mj7JA9a
         62cDD4yZvLZuKvldTpl4t7fMBCGmLnXnE3xjoEIyNhDeCXIMe3zf7ZYlKoVDXcDpQwbj
         tqKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=DrlZPkFHPfMcURWoioWFQWpr3JzSyq1PfKt5XZOS+/A=;
        b=B+WFVKmyIyxY45eyhtfc3E2wIoMVDJgb5hut/IT9Bueqxt8cm0EZwfGWS+u5tW4SyV
         PprCWc8QBYhIz2C/sUxtPAP11qYOZwXQ8OFYxB+YYcBwVdYrBYNbWZx13l5PZ5krJ5Uc
         mL6PvKBjwhrSPSkanT8NRzOgLSEHIk9Kyx36hEdHrnEhiv1PlX1chBhdj6xDJWl7qOxw
         hLvQMQxy/hnjJn3EIzbq6ooqj3+A10k+eHKi73Z5djXT3Ang0ThRrytnl8P1dm65wzpb
         2gdB/PHTjyR02HMGCWM22DOwUSJlISJEgtEXKMbKJUOtindIOrOoVo1levpSHBV4TOhM
         ZTlQ==
X-Gm-Message-State: APjAAAVy2K5K7AfMxr4iFvNHVF5d7TIGPbS283IuwqKb7xMbC2qKXD2B
        Bk5Hx2ROW8e2HBHvoMFf/R26eA==
X-Google-Smtp-Source: APXvYqz22bWldVd9W9T7Ta0bNPEyMrgudab5vYStzc0Tm0ul9/LC4n+44EYy8LlFcX+AcmY220g78Q==
X-Received: by 2002:a17:90a:928c:: with SMTP id n12mr1207226pjo.45.1582752950025;
        Wed, 26 Feb 2020 13:35:50 -0800 (PST)
Received: from ?IPv6:2600:1010:b069:8a27:ddd9:92ea:d62b:8a52? ([2600:1010:b069:8a27:ddd9:92ea:d62b:8a52])
        by smtp.gmail.com with ESMTPSA id d69sm4545987pfd.72.2020.02.26.13.35.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2020 13:35:49 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [patch 01/15] x86/irq: Convey vector as argument and not in ptregs
Date:   Wed, 26 Feb 2020 13:35:47 -0800
Message-Id: <0BF722CE-26CF-43AC-A2E4-5C4639794159@amacapital.net>
References: <87k149p0na.fsf@nanos.tec.linutronix.de>
Cc:     Brian Gerst <brgerst@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Juergen Gross <JGross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <87k149p0na.fsf@nanos.tec.linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
X-Mailer: iPhone Mail (17D50)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Feb 26, 2020, at 12:13 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
>=20
> =EF=BB=BFBrian Gerst <brgerst@gmail.com> writes:
>=20
>>> On Tue, Feb 25, 2020 at 6:26 PM Thomas Gleixner <tglx@linutronix.de> wro=
te:
>>>=20
>>> Device interrupts which go through do_IRQ() or the spurious interrupt
>>> handler have their separate entry code on 64 bit for no good reason.
>>>=20
>>> Both 32 and 64 bit transport the vector number through ORIG_[RE]AX in
>>> pt_regs. Further the vector number is forced to fit into an u8 and is
>>> complemented and offset by 0x80 for historical reasons.
>>=20
>> The reason for the 0x80 offset is so that the push instruction only
>> takes two bytes.  This allows each entry stub to be packed into a
>> fixed 8 bytes.  idt_setup_apic_and_irq_gates() assumes this 8-byte
>> fixed length for the stubs, so now every odd vector after 0x80 is
>> broken.
>>=20
>>     508:       6a 7f                   pushq  $0x7f
>>     50a:       e9 f1 08 00 00          jmpq   e00 <common_interrupt>
>>     50f:       90                      nop
>>     510:       68 80 00 00 00          pushq  $0x80
>>     515:       e9 e6 08 00 00          jmpq   e00 <common_interrupt>
>>     51a:       66 0f 1f 44 00 00       nopw   0x0(%rax,%rax,1)
>>     520:       68 81 00 00 00          pushq  $0x81
>>     525:       e9 d6 08 00 00          jmpq   e00 <common_interrupt>
>>     52a:       66 0f 1f 44 00 00       nopw   0x0(%rax,%rax,1)
>>=20
>> The 0x81 vector should start at 0x518, not 0x520.
>=20
> Bah, I somehow missed that big fat comment explaining it. :)
>=20
> Thanks for catching it. So my testing just has been lucky to not hit one
> of those.
>=20
> Now the question is whether we care about the packed stubs or just make
> them larger by using alignment to get rid of this silly +0x80 and
> ~vector fixup later on. The straight forward thing clearly has its charm
> and I doubt it matters in measurable ways.

I agree it probably doesn=E2=80=99t matter. That being said, I have a distin=
ct memory of fixing that asm so it would fail the build if the alignment was=
 off.

>=20
> Thanks,
>=20
>        tglx
>=20
>=20
