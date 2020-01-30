Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA0E6C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 18:22:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9041520658
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 18:22:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="xIZ5H0OF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729336AbgA3SWy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 13:22:54 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34195 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729324AbgA3SWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 13:22:54 -0500
Received: by mail-pg1-f193.google.com with SMTP id j4so2084270pgi.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 10:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=nWq9lQr4gY/O3nQtwyE+Upg2jqT1CFZOGXf4yigQ6lw=;
        b=xIZ5H0OFKDa9x+2VsMSDOIEqBeldOgXXLSvyVBdrGVPuh+EoXOJXQJXGuxUMQs2vFo
         wCpPNIe5swrh72AoHjUOAy9v6MWvzkXCe5NWjutWpfYRTKeyraNfms7AXQSxod7L0Spw
         3d5r3W1WbWVG8WG/YbstwfGO31cY0+CtpzHuJWABPeJuImpPZfE48gw0z3uG+T684rcL
         s8+pzGfY7zRd/nXZPO57LtW5uH8mXVlOlEKI/H1uqeTM4E9jWd5oDVUSaaGr272Fz0Zj
         XeRQcUlgBsD0My7YOh+U3CRfEoE7o3Jgej3uSCz/G5IrFuJI8VpBZC6azyTZGnOCVCuE
         X6tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=nWq9lQr4gY/O3nQtwyE+Upg2jqT1CFZOGXf4yigQ6lw=;
        b=niYrUjNXnENv8wSsOg5jiPtwXxh09pXF9PBrkfrdUGqpY3Z6Hx4EbA+jMUMNOAe982
         qTUyi2zCDX14IWbOjT+4aOOPmZOo90W0ibibIzOZ0U4RuYv0G4cLqU5OPGO9ESQ80PgO
         OFj1kDdn3OOeuo3/D+6yjjAt2BwICDXBOVwEO3p1MxUWMLf2/0OFJk+sPfVhAfDw4/ij
         caoHd5451Po/SbGoQJUYpaMSc30Y4xLw7Cg7/ixOo9ahdIJ3onUPX8Uc4r5FJE5aNw15
         9oYMLIP9BN9+g8RmlIl7GHem28FEV79j+t0+OQbuniG226qTswRVE5EcFX3j8UMYFZOL
         oBFg==
X-Gm-Message-State: APjAAAVf+F/BYhYXMpZCRoF55uHA4UmQ6madxHXJjTGKWqTsUYohok7Z
        QA3omVnhgyu5k3Xpaw66uMhLBw==
X-Google-Smtp-Source: APXvYqyDDIxAoglYXGW23lF855un6isNVal9COVWXFB0qe34GeX2S8RonKDBtNwJ1rDoeiOgnLXXtQ==
X-Received: by 2002:a63:4641:: with SMTP id v1mr5850003pgk.389.1580408573726;
        Thu, 30 Jan 2020 10:22:53 -0800 (PST)
Received: from ?IPv6:2601:646:c200:1ef2:4dba:bdf9:9435:1433? ([2601:646:c200:1ef2:4dba:bdf9:9435:1433])
        by smtp.gmail.com with ESMTPSA id d24sm7941223pfq.75.2020.01.30.10.22.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jan 2020 10:22:52 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: 5.6-### doesn't boot
Date:   Thu, 30 Jan 2020 10:22:51 -0800
Message-Id: <8E4D91A4-8A35-481D-B5F6-4779FBDE3876@amacapital.net>
References: <CAHk-=wjOXE4cqFOdtSymYnMMayZq8Lv7qDy-6BzCs=2=8HcoBA@mail.gmail.com>
Cc:     =?utf-8?Q?J=C3=B6rg_Otte?= <jrg.otte@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
In-Reply-To: <CAHk-=wjOXE4cqFOdtSymYnMMayZq8Lv7qDy-6BzCs=2=8HcoBA@mail.gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
X-Mailer: iPhone Mail (17C54)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 30, 2020, at 10:08 AM, Linus Torvalds <torvalds@linux-foundation.or=
g> wrote:
>=20
> =EF=BB=BFOn Thu, Jan 30, 2020 at 9:32 AM J=C3=B6rg Otte <jrg.otte@gmail.co=
m> wrote:
>>=20
>> my notebook doesn't boot with current kernel. Booting stops right after
>> displaying "loading initial ramdisk..". No further displays.
>> Also nothing is wriiten to the logs.
>>=20
>> last known good kernel is : vmlinuz-5.5.0-00849-gb0be0eff1a5a
>> first known bad kernel is : vmlinuz-5.5.0-01154-gc677124e631d
>=20
> It would be lovely if you can bisect a bit. But my merges in that
> range are all from Ingo:
>=20
> Ingo Molnar (7):
>    header cleanup
>    objtool updates
>    RCU updates
>    EFI updates
>    locking updates
>    perf updates
>    scheduler updates
>=20
> but not having any messages at all makes it hard to guess where it would b=
e.
>=20
> A few bisect runs would narrow it down a fair amount. Bisecting all
> the way would be even better, of course,
>=20
>=20

It would also be nice to know: are you EFI-booting or BIOS-booting?  And are=
 you using EFI mixed mode?  (That is, are you booting a 64-bit kernel using 3=
2-bit EFI?)=
