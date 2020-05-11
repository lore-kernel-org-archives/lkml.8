Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A711DC47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 08:45:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E4AC20661
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 08:45:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tH1xyULT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729201AbgEKIpl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 04:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728471AbgEKIpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 04:45:41 -0400
Received: from mail-oo1-xc44.google.com (mail-oo1-xc44.google.com [IPv6:2607:f8b0:4864:20::c44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D76DC061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 01:45:41 -0700 (PDT)
Received: by mail-oo1-xc44.google.com with SMTP id t3so1765479oou.8
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 01:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CXyk9pD8GiPYbrmsgGPsMzIe7WnVGxVB8QF/X4cMkHw=;
        b=tH1xyULTB1Tug2ZFWrkrSlIu0kazzBAmC0d7ASAUam2Nm+KjLPEo3EuDPk1i2zKm4A
         WhkNqvCi5AqW0Z4iI5dsSslvO2QUzOrYoy9+iG8Q5EVhlUB5uY3BAR/lENni1oevul3G
         zrsDWISutihyNh1wK9m8dNVFDLyOWMoGsLFtYaJGljfmw8LZ5Ux3vAQHOmXEam4DltZZ
         7TV8hYObHuPuomfyPbQZY2JobEvOTPVwjMwhPewqAwPPAP85yjJyzE80iSPzvv2UzNZl
         QDHFJpyUZoTVlE9GqSfDDluaqUfDbK3zp5NNk+Oi1MKLKr6xylZhikr3FEzSBOHtJCav
         1WGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CXyk9pD8GiPYbrmsgGPsMzIe7WnVGxVB8QF/X4cMkHw=;
        b=azLL8EZgnroOiyulEpfvjfeNV0+9g1epp1yepuxsHvTL/cdyHmrVF5zVbCnkb3Gq0/
         MrQ2uE1dzWHpdn6OyrSP2WRoqON3V9V/vEfsG1ejO99Vvgyrh9ktaFNTdx8VvWvtxRLI
         fV+t2uLVZyvkYqctbc+5GmpD9dUs9AjXJL/8Q3qfkLbgWiYm5SMhDBGfLjsL/9+kRzu1
         GtjC6qNsSx2MN7TrH1Qs9JXjFmkoEuZm5GdHZuOP4IuaAcldzH63z3aYLkEj0wR1WCya
         CXz3x/Kqm70w50LOXNsnKo9xmcLyqowXF10Y0tXcNC0FoFlO69pja4kqK9S8Pz8MNmA0
         giBQ==
X-Gm-Message-State: AGi0PuYWAGlcbQWUQbX6I6CczCTWGsFp7hzHRNBWuAtBVL74k53kyHbJ
        yE/g7djd0aS8V3dxwpyX+c5Cat+ilMTbldLHkmN1dw==
X-Google-Smtp-Source: APiQypKqu7Lh30iHtAG6v1+SjOyDTD5J917W5jtQkJ44UaZafhHFvKcTgZ6MwPG87WptrojEUdTRsTmIkOw7buiASsA=
X-Received: by 2002:a05:6820:164:: with SMTP id k4mr13069183ood.30.1589186740054;
 Mon, 11 May 2020 01:45:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200509113717.9084-1-pmenzel@molgen.mpg.de> <87eerr3ppb.fsf@nanos.tec.linutronix.de>
 <edc5af47-27e6-753f-c095-bd3087942690@molgen.mpg.de>
In-Reply-To: <edc5af47-27e6-753f-c095-bd3087942690@molgen.mpg.de>
From:   Radoslaw Biernacki <biernacki@google.com>
Date:   Mon, 11 May 2020 10:45:28 +0200
Message-ID: <CAM4=Rn+7RGHEGa7u33zUA0b-cBehadw4NKN75JtjKjOhxm2Fxg@mail.gmail.com>
Subject: Re: [PATCH] x86/tsc: Use hard-coded crystal clock for Skylake mobile
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        Ross Zwisler <zwisler@google.com>,
        Daniel Drake <drake@endlessm.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Len Brown <len.brown@intel.com>,
        Linux Upstreaming Team <linux@endlessm.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 11, 2020 at 9:38 AM Paul Menzel <pmenzel@molgen.mpg.de> wrote:
>
> Dear Thomas,
>
>
> Thank you for the quick reply.
>
> Am 11.05.20 um 09:17 schrieb Thomas Gleixner:
>
> > Paul Menzel <pmenzel@molgen.mpg.de> writes:
> >
> > please send patches to LKML and not offlist.
>
> Sorry about that. From `MAINTAINERS` I thought x86@kernel.org is wanted.
> Other subsystems list LKML explicitly there.
>
> >> From: Radoslaw Biernacki <biernacki@google.com>
> >>
> >> @@ -636,10 +636,24 @@ unsigned long native_calibrate_tsc(void)
> >>       * Denverton SoCs don't report crystal clock, and also don't supp=
ort
> >>       * CPUID.0x16 for the calculation below, so hardcode the 25MHz cr=
ystal
> >>       * clock.
> >> +     * Also estimation code is not reliable and gives 1.5%  differenc=
e for
> >> +     * tsc/clock ratio on Skylake mobile. Therefore below is a hardco=
ded
> >> +     * crystal frequency for Skylake which was removed by upstream co=
mmit
> >> +     * "x86/tsc: Use CPUID.0x16 to calculate missing crystal frequenc=
y"
> >> +     * This is temporary workaround for bugs:
> >> +     * b/148108096, b/154283905, b/146787525, b/153400677, b/14817892=
9
> >> +     * chromium/1031054
> >>       */
> >> -    if (crystal_khz =3D=3D 0 &&
> >> -                    boot_cpu_data.x86_model =3D=3D INTEL_FAM6_ATOM_GO=
LDMONT_D)
> >> -            crystal_khz =3D 25000;
> >> +    if (crystal_khz =3D=3D 0) {
> >> +            switch (boot_cpu_data.x86_model) {
> >> +            case INTEL_FAM6_SKYLAKE_MOBILE:
> >> +                    crystal_khz =3D 24000;    /* 24.0 MHz */
> >> +                    break;
> >> +            case INTEL_FAM6_ATOM_GOLDMONT_X:
> >> +                    crystal_khz =3D 25000;    /* 25.0 MHz */
> >> +                    break;
> >> +            }
> >
> > Aside of being a workaround for Google issues which are probably caused=
 > by broken BIOSes
>
> Even if it was caused by broken firmware, wouldn=E2=80=99t Linux=E2=80=99=
 no regression
> policy still consider this a regression as user should be able to the
> Linux kernel =E2=80=9Cno matter what=E2=80=9D?
>
> > that patch is broken.
> >
> >     INTEL_FAM6_ATOM_GOLDMONT_D !=3D INTEL_FAM6_ATOM_GOLDMONT_X
>
> Good catch. The commit didn=E2=80=99t apply cleanly to the master branch,=
 and I
> missed this.
>
> I=E2=80=99ll wait for Radoslaw to comment before proceeding further with =
this.

We found that regression only on specific SKU which was used in one
model of ChromeBook.
What's interesting is that some other SKU is fine.

The consequences of this are rather not trivial,
so this was considered a quickfix and temporary till we develop
something better.
In contrast to ChromeOs, I know that there is no way of finding if
there are in fact regressions on generic kernel in the field (this is
SKU dependent),
but we also think that this problem should be addressed in a better
way (if possible).

We plan to work on this.
Any help is welcome.

>
>
> Kind regards,
>
> Paul
