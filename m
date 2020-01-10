Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E83ADC33CA4
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 21:02:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDD3B2072E
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 21:02:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="diDEq6At"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbgAJVCo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 16:02:44 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:54012 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727078AbgAJVCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 16:02:42 -0500
Received: by mail-pj1-f65.google.com with SMTP id n96so1447149pjc.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jan 2020 13:02:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=jfaknLo6dB7P4TvTZQmRLqfYR5CIiTdIXE9lXNwSsYU=;
        b=diDEq6At2DzWHKg+ysDMV1tW4o5AwiDyePd9VJ3pD+hsHR8cFV1SQyA59/kk5j+xgK
         1TsiRsOtgi+SYWZwPpnwbgbMpOpTBFOKIhld9J4VOn7z8Dvcdp0cMv0hT4o/pvqNYmDt
         o4KzRsf6U3mSxqr+NmFY1NZJnZtU2+mfib5RYv0qXqMmAsYYbLhAWvkbyVPGWDeCmn8R
         7u0u0fxOpKaCifg3xTVtRj86GX6J5Y91BN2RZHE6YugaM1ohryvVWffdKXI4ka0Un7Ss
         RKeBRruVTUOlB+gGzitr3sXC8NAV3FbdCW7mfIrVpeM7E4B6rp/ZzqXS+QVwjmw5GjMb
         dA7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=jfaknLo6dB7P4TvTZQmRLqfYR5CIiTdIXE9lXNwSsYU=;
        b=ukisyUVjijApoT7bmi2rHm0c5cF9310MOnILXgIgNOpP5lmdfF215YDfVmZJ7GqXUx
         s8IWJ05+0kTQoudi4gIBUnjXq0DZ111Au7oHR2zjwtqOU2VOtnz2/P19U9u2x7cq3QWS
         sT0u4uGDZnimQIcs0AHkNqTx94XcdH5xtT6o3yXeqgulLMBSAfK7qrL5RMRJSs9vy1eD
         jPzEP1qNnVAs10MpfSVOhelDXoBjDtC0PU8HiEY6REtjpiuh0GohRwBCE9uqT/upq/bi
         8b68+Tb/afUdwVoJ24DFZ3e/ggTBcH3S1HFpOTVk9LtCIR/Cqn4T0IDfwTDkcIqE/D+Z
         7rAw==
X-Gm-Message-State: APjAAAXB0Bp3ry/gYMkpEfvGxGBgBfqmaSXlnj8RFBbWB0W7qoI9JeNK
        w4wBqUilNQnFc1QAQwrwaPKf/Jr3TCA=
X-Google-Smtp-Source: APXvYqwcK5EuXgyJPF3Ld4Ugh4h8SPw00JyrmxOuZ/D2wMI6lxIb8hITf4wySqQXcJ4mHz7I9DvGuA==
X-Received: by 2002:a17:902:ff12:: with SMTP id f18mr545089plj.256.1578690162146;
        Fri, 10 Jan 2020 13:02:42 -0800 (PST)
Received: from [10.197.30.113] ([139.104.2.240])
        by smtp.gmail.com with ESMTPSA id d22sm3725278pgg.52.2020.01.10.13.02.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jan 2020 13:02:41 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC PATCH v2 01/10] lib: vdso: ensure all arches have 32bit fallback
Date:   Fri, 10 Jan 2020 11:02:38 -1000
Message-Id: <53785EAC-A04C-4B02-9698-D11D75BE2C4D@amacapital.net>
References: <87sgknrpxy.fsf@nanos.tec.linutronix.de>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrew Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:MIPS" <linux-mips@vger.kernel.org>,
        X86 ML <x86@kernel.org>
In-Reply-To: <87sgknrpxy.fsf@nanos.tec.linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
X-Mailer: iPhone Mail (17C54)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 10, 2020, at 10:56 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
>=20
> =EF=BB=BFAndy Lutomirski <luto@kernel.org> writes:
>=20
>>> On Mon, Dec 23, 2019 at 6:31 AM Christophe Leroy
>>> <christophe.leroy@c-s.fr> wrote:
>>>=20
>>> In order to simplify next step which moves fallback call at arch
>>> level, ensure all arches have a 32bit fallback instead of handling
>>> the lack of 32bit fallback in the common code based
>>> on VDSO_HAS_32BIT_FALLBACK
>>=20
>> I don't like this.  You've implemented what appear to be nonsensical
>> fallbacks (the 32-bit fallback for a 64-bit vDSO build?  There's no
>> such thing).
>>=20
>> How exactly does this simplify patch 2?
>=20
> There is a patchset from Vincenzo which fell through the cracks which
> addresses the VDS_HAS_32BIT_FALLBACK issue properly. I'm about to pick
> it up. See:
>=20
> https://lore.kernel.org/lkml/20190830135902.20861-1-vincenzo.frascino@arm.=
com/
>=20

Thanks.  I had been wondering why the conditionals were still there, since I=
 remember seeing these patches.

> Thanks,
>=20
>        tglx
