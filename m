Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB0D3C2BA1A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 00:28:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E58A2072A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 00:28:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="utepuFsA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbgDGA2X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 20:28:23 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46563 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbgDGA2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 20:28:23 -0400
Received: by mail-pf1-f196.google.com with SMTP id q3so8422852pff.13
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 17:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :user-agent:message-id:content-transfer-encoding;
        bh=lUrQEjas9LyAD7t4uBRXKepPh+kc7mCeSR7ByaIVLxM=;
        b=utepuFsAgCGVrQNm105LCP3VGpoDyYIztLJkGNzysn8V6DNXIn28TDRMjfjj1gR2BL
         MBDFjQT5pphQJhTLWSBKVliMfaeRt0+H43bb1LMpWUfUgTq7zpC+1IFdSF5qOrvLmx6Y
         S95d1hEn6eAf2hs9UvHWKHEZUzJ1aLItVFkF0yrGPRPfWbt3uDxNlTCoTpBuOzw473oj
         DkgcLUl4QTAHkxbeM1ihwvCbXYjVk0XDTOxvyMwH8Mg5iMMdSgyQ31z5XDtdhEH+Ak2f
         toMYHaJodfIQx6VJNAiRxV3kTrvpMwBQg6Ru6Aak3Uud/upHN8bmNnpAGk59aLDkjpvX
         ZekQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:user-agent:message-id:content-transfer-encoding;
        bh=lUrQEjas9LyAD7t4uBRXKepPh+kc7mCeSR7ByaIVLxM=;
        b=l6l796v8i2l3lelpqgCTOcA8FBZcfTJgHofsGiPVb7Mv+OTDyOiE9lrhCLcsvDzYc0
         KkhsghlIb9LZMN8BYar9QFpSVGVRDTP4gKrsCI1k+iRU+mKxlDilJu2rFCQPpBb4tbaZ
         IChXkiKnljRcPBP+05EcP1i5aYqfwC8zRy5JumoRL9e2bL2ZMrNgItjhMgH8+SQSs+g2
         xi3G0HcAIfY5qIyzpAdz5+xfZ5EhP8j9rw3SFJ6ZF6mDRHjWfxMh5Gk/aMPrfYYTCWpa
         VlTYv9seThIpwbbCFEg6zVJGGMjyavy16fAfYwOWLLMrrROrNWKjm/2I9bjOO8Ww22wT
         v3cw==
X-Gm-Message-State: AGi0PubAVUpzFVaVsIq7CKYVo0yElsV9Flnih9BHDsKpA3EGijXUf5O0
        5okEYsTPryGHbcmOLpPKBoE=
X-Google-Smtp-Source: APiQypL8KF2u89jekKB31NajaeIR1jJV1MTZAwcHEpViXoLNTQO3q4pnc4wwC3IusIfGrjn70laCGQ==
X-Received: by 2002:a63:db10:: with SMTP id e16mr1548594pgg.361.1586219302200;
        Mon, 06 Apr 2020 17:28:22 -0700 (PDT)
Received: from localhost (60-241-117-97.tpgi.com.au. [60.241.117.97])
        by smtp.gmail.com with ESMTPSA id 8sm1762515pfz.12.2020.04.06.17.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 17:28:21 -0700 (PDT)
Date:   Tue, 07 Apr 2020 10:26:58 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [RFC PATCH v2 12/13] powerpc/kernel: Do not inconditionally save
 non volatile registers on system call
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Michael Ellerman <mpe@ellerman.id.au>, msuchanek@suse.de,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <029e1064b1ad738785718221ea468c9cfc282457.1586108649.git.christophe.leroy@c-s.fr>
        <4ef6d617cfd34e09e9bf5a456b2e0b6d2a8a3c96.1586108649.git.christophe.leroy@c-s.fr>
        <1586135554.pnqaj0giue.astroid@bobo.none>
        <48d3e2e5-318f-011e-a59b-ec89bd7b76d2@c-s.fr>
In-Reply-To: <48d3e2e5-318f-011e-a59b-ec89bd7b76d2@c-s.fr>
MIME-Version: 1.0
User-Agent: astroid/0.15.0 (https://github.com/astroidmail/astroid)
Message-Id: <1586218971.lolwg4f0lh.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy's on April 7, 2020 4:18 am:
>=20
>=20
> Le 06/04/2020 =C3=A0 03:25, Nicholas Piggin a =C3=A9crit=C2=A0:
>> Christophe Leroy's on April 6, 2020 3:44 am:
>>> Before : 347 cycles on null_syscall
>>> After  : 327 cycles on null_syscall
>>=20
>> The problem I had doing this is that signal delivery wnats full regs,
>> and you don't know if you have a signal pending ahead of time if you
>> have interrupts enabled.
>>=20
>> I began to try bailing out back to asm to save nvgprs and call again.
>> I think that can be made to work, but it is more complication in asm,
>> and I soon found that 64s CPUs don't care about NVGPRs too much so it's
>> nice to get rid of the !fullregs state.
>=20
> I tried a new way in v3, please have a look. I split=20
> syscall_exit_prepare() in 3 parts and the result is unexpected: it is=20
> better than before the series (307 cycles now versus 311 cycles with=20
> full ASM syscall entry/exit).

Great! Well I don't really see a problem with how you changed the C code=20
around. I'll have to look at the assembly but I don't think it would=20
have caused a problem for 64s.

Thanks,
Nick
=
