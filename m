Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 547A6C32771
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 10:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DD232465B
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 10:53:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730100AbgA0KxT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 05:53:19 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:44141 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbgA0KxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 05:53:18 -0500
Received: from mail-qk1-f176.google.com ([209.85.222.176]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MDPuq-1ilchH1Wdy-00Aa3p for <linux-kernel@vger.kernel.org>; Mon, 27 Jan
 2020 11:53:17 +0100
Received: by mail-qk1-f176.google.com with SMTP id k6so9116665qki.5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jan 2020 02:53:17 -0800 (PST)
X-Gm-Message-State: APjAAAWHLl/+UWxYE1jI8NZJQ70orwZNSpBjDoGCMLkOOdNrR87pJjah
        jJI7LlXHbFMqPfVe8IuFk3lPwQfu+FRz2dpnliw=
X-Google-Smtp-Source: APXvYqw+sNYd7tg/7ZuXY3v+6ebsuCG0e8arDEWW9YJZhMhyGqIT3XzhzapxsRzTZz5mxB6btWsOiYkrSj0kdtMTaHs=
X-Received: by 2002:a05:620a:16a7:: with SMTP id s7mr373783qkj.3.1580122396308;
 Mon, 27 Jan 2020 02:53:16 -0800 (PST)
MIME-Version: 1.0
References: <1580117979-4629-1-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1580117979-4629-1-git-send-email-peng.fan@nxp.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 27 Jan 2020 11:53:00 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2YLo4rNBXu9NhvKv6QOFUcZhCVXNR4XJe_0Kc_RJ=ubA@mail.gmail.com>
Message-ID: <CAK8P3a2YLo4rNBXu9NhvKv6QOFUcZhCVXNR4XJe_0Kc_RJ=ubA@mail.gmail.com>
Subject: Re: [PATCH V2 0/5] soc: imx: increase build coverage for imx8 soc driver
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "olof@lixom.net" <olof@lixom.net>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        "krzk@kernel.org" <krzk@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:qMn9aGDzmYmr3ImGiYWj/zMwx4thXDIfV5gUSfUrvDHjUDPY4ED
 hdKs7Nsb0vPGlOOcOjPq8rDp84FZo8WDDcEkMU7FIoH3FS41S5djZAaWqHKJHa81+A5wPJT
 jAS5wzK99dyr9UQI8RZTqZFSN+NN0BcyrXDJ3+cgmgbFG51Fcyx5WA6dLOtGYEYhzp3Mi2/
 N1Tc7pTl9TegS0L79/dGA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:BlF8KoqPva8=:gVR7ux8L/dYRMQAfQziitg
 +Wsuvwq7Kz+IL+WyPkWOPMCbeAoX8ePN+ETfpcTY/9l0kumcktOGnTQnC4Zd1+8xi28T80OGy
 NEFro6+d2zVUbYIsLRvmtJ7hYjTPRHO6WOsFIKfZAKY2Aj93fapzsgXCErXmp56MpCAw6Gm+t
 n5JTJgJa2dvKnZGFQR6WAiFs04kmr/cf9voX4iY4+oCx+gB3Xp3Tj9FrpsLkhdA6DCPieR5mC
 7G+ZTNOJr0Gxi7uQpL8kk4h5wWyE120RrD826mw9tuTcVL+CCwhAOOWNKYWym5aOP6ltm8i9C
 rXIy3cMVyFDTX+m4Z6Y7mWbYRLL+PUllY3QNO5T4eJnWxV+EzY8pjcLmj2Wqgwi28F14PAorU
 /6oXAexGTT3AixR6GWILllzj3aH2hFUuVNpsIliQhg0+lZcDVXdsiHJzG0x3ZNJYCR9B9QZEs
 /ZRRzbXCkXyitRiGI+d/CsA0GI30uDzogtbO6HZKM6EQ8kaevV9DNGIrZ4AUf6Zl2yU0F2Oqm
 mShb6uBbgJQOBBli4eo+E8hleEvaPZuEJlC3hu04zLBCcUX5zHc4aVbqAXL6GyzIiipRxFIaO
 Y3dGtBV4N1Y0Yc5vmqXAaVQHVQYqR342BxLUsoDCCd7bkGyb+LqEUI1gXjj0Spx3k5mVr7QtO
 jwwxDokj5+hpqJTrV9QUTGv32MyCjA7uDSicAkvU8G4RFapDO7WALe7S6nePqnjAaBEj1okRL
 pa0/o2z8o9C8AOSJDDUgvvqdrtzljKoWQ6keEX3UsTxrCAI3/zIOcqLXAKFFfE5dkenpUqJZp
 8NXvc/tz5vyHEhwYkVGScMbBXF4ijkdATjOz829xqaQHa3oDQ4=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 27, 2020 at 10:44 AM Peng Fan <peng.fan@nxp.com> wrote:
>
> From: Peng Fan <peng.fan@nxp.com>
>
>
> V2:
>  Include Leonard's patch to fix build break after enable compile test
>  Add Leonard's R-b tag
>
> Rename soc-imx8.c to soc-imx8m.c which is for i.MX8M family
> Add SOC_IMX8M for build gate soc-imx8m.c
> Increase build coverage for i.MX SoC driver

The changes all look good to me, but I'd just do it all in one combined
patch, as the changes are all logically part of the same thing. You
can leave Leonard's fix as a [PATCH 1/2]  if you want, but the rest
should clearly be a single change.

      Arnd
