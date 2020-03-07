Return-Path: <SRS0=IBMW=4Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBC74C10F26
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 14:36:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5747206D7
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 14:36:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="dL+a1XBn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbgCGOgm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Mar 2020 09:36:42 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46693 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbgCGOgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Mar 2020 09:36:41 -0500
Received: by mail-pf1-f194.google.com with SMTP id c19so298125pfo.13
        for <linux-kernel@vger.kernel.org>; Sat, 07 Mar 2020 06:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:subject:mime-version:from:in-reply-to:cc
         :date:message-id:references:to;
        bh=Z4Rg6QQ2ek1P6NQe6NBeu8rqSQu6+SNlYnv1B6QopIc=;
        b=dL+a1XBn1NBkBQn11dVvHkoe9wJzQTRlgGfOLYVH54wkX8+kxpekJ6PEWKd10YxEBD
         /aAw1+vak/IHgDPlcP2znSwk2qM2SO0z3KrYWs+vObzzkBCankh/wiskH1Lg6bhBao+E
         +ue7Tnc4sEF0tzodkgAB7WyJ7ayUriP2GrPVBOmLJMPerA8aJrXMigX40/RB+V3woqJb
         64XrAP5ftztYO97114EXMDVxjCSTH+hPw+sU9ELcTmKPZikE683k/WkeZg2g4idb6snl
         hyNR5IOsBy2pu1mE7wr6AK87EIm/3i3yrUQsOcdLorcVVmQ7nquttoRdFSZfZLzvSZkJ
         90pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:subject:mime-version
         :from:in-reply-to:cc:date:message-id:references:to;
        bh=Z4Rg6QQ2ek1P6NQe6NBeu8rqSQu6+SNlYnv1B6QopIc=;
        b=p1TZypJlbJVsi4xt6k3nCk9HqkTB17Cgo5xDcFtaglUC00rx1+BBjz4fZFQXM1tP+b
         aH45dvL+7qYGRamArE4wSJ7KWuYbc8vdOHfHmv98hHzRpAbReeJDgKBBCWh2D8NRoGMD
         QknsziRyuygM2imYEIzy1xe9SC/p1Q+ovccUd1axjRjSI+dZ6DiKwKi0UFn0uUswHh4I
         KnDTyp1o/x1Ns/SlgBFEQ1QCRvIIovxOVj0Yqcxv+IRZMdJNYjdutfCBn49VhpqglldG
         CbS4NLZNR8+RpYaQoRYBu2mOR87p0gdhNuVFLkpXLcRxUJRvSmr3ufdhLLHVqoCATTfk
         BfDA==
X-Gm-Message-State: ANhLgQ1o/C8nxdIxvhDfMEe7eVwyrCcqjrbG29WH3nGtoqbsBjx53J2P
        XKPzNM9+CtVC3zKc4jCZXot1cQ==
X-Google-Smtp-Source: ADFU+vvxyQrbPQrEaD8iDphaCtnuOGoxneoimZDLHsHgIW7njCbrr/AC7dPXlC3QZEOsGkT36xLSLA==
X-Received: by 2002:a63:7c54:: with SMTP id l20mr8087166pgn.158.1583591798787;
        Sat, 07 Mar 2020 06:36:38 -0800 (PST)
Received: from ?IPv6:2601:646:c200:1ef2:1892:9979:287d:69f2? ([2601:646:c200:1ef2:1892:9979:287d:69f2])
        by smtp.gmail.com with ESMTPSA id b9sm10044706pgi.75.2020.03.07.06.36.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Mar 2020 06:36:37 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] x86/kvm: Disable KVM_ASYNC_PF_SEND_ALWAYS
Mime-Version: 1.0 (1.0)
X-Apple-Notify-Thread: NO
X-Universally-Unique-Identifier: 366B8C02-5F63-478A-9EA9-F534EFF91F53
From:   Andy Lutomirski <luto@amacapital.net>
In-Reply-To: <87o8t8a33u.fsf@nanos.tec.linutronix.de>
Cc:     Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        kvm list <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>, stable@vger.kernel.org
Date:   Sat, 7 Mar 2020 06:36:35 -0800
X-Apple-Message-Smime-Encrypt: NO
Message-Id: <DECFB367-7468-43A8-A6FE-4086D9FF601A@amacapital.net>
References: <87o8t8a33u.fsf@nanos.tec.linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
X-Mailer: iPhone Mail (17D50)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Mar 7, 2020, at 2:09 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
>=20
> =EF=BB=BFAndy Lutomirski <luto@kernel.org> writes:
>=20
>> The ABI is broken and we cannot support it properly.  Turn it off.
>>=20
>> If this causes a meaningful performance regression for someone, KVM
>> can introduce an improved ABI that is supportable.
>>=20
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Andy Lutomirski <luto@kernel.org>
>> ---
>> arch/x86/kernel/kvm.c | 11 ++++++++---
>> 1 file changed, 8 insertions(+), 3 deletions(-)
>>=20
>> diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
>> index 93ab0cbd304e..71f9f39f93da 100644
>> --- a/arch/x86/kernel/kvm.c
>> +++ b/arch/x86/kernel/kvm.c
>> @@ -318,11 +318,16 @@ static void kvm_guest_cpu_init(void)
>>=20
>>        pa =3D slow_virt_to_phys(this_cpu_ptr(&apf_reason));
>>=20
>> -#ifdef CONFIG_PREEMPTION
>> -        pa |=3D KVM_ASYNC_PF_SEND_ALWAYS;
>> -#endif
>>        pa |=3D KVM_ASYNC_PF_ENABLED;
>>=20
>> +        /*
>> +         * We do not set KVM_ASYNC_PF_SEND_ALWAYS.  With the current
>> +         * KVM paravirt ABI, if an async page fault occurs on an early
>> +         * memory access in the normal (sync) #PF path or in an NMI
>> +         * that happens early in the #PF code, the combination of CR2
>> +         * and the APF reason field will be corrupted.
>=20
> I don't think this can happen. In both cases IF =3D=3D 0 and that async
> (think host side) page fault will be completely handled on the
> host. There is no injection happening in such a case ever. If it does,
> then yes the host side implementation is buggered, but AFAICT this is
> not the case.

Indeed. But read v2 please.

>=20
> See also my reply in the other thread:
>=20
>  https://lore.kernel.org/r/87r1y4a3gw.fsf@nanos.tec.linutronix.de
>=20
> Thanks,
>=20
>        tglx
