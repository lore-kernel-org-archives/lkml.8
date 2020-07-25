Return-Path: <SRS0=eufF=BE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5DB1C433E3
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 18:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAACC206D7
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 18:31:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727881AbgGYSbQ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 14:31:16 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:40755 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727036AbgGYSbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 14:31:16 -0400
Received: from mail-qt1-f182.google.com ([209.85.160.182]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1Mrxjf-1kcGWt1uvF-00nw44 for <linux-kernel@vger.kernel.org>; Sat, 25 Jul
 2020 20:31:14 +0200
Received: by mail-qt1-f182.google.com with SMTP id d27so9352923qtg.4
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jul 2020 11:31:14 -0700 (PDT)
X-Gm-Message-State: AOAM5301xd2oIbOYOjo/q/r1MPGJ+YVzepFdV9GvQa7L87ishQG5rhn6
        yQymadWi59KJ2nC/6V6jd892hulGhmpyvCD1lYU=
X-Google-Smtp-Source: ABdhPJzHTyApat0bw84tF3h2Af+bo13zlqQHPFO7nlxTyX9nNY7CCrPypsrX45LFfU24UHEra8Rxd1j0sNISFQyNMFw=
X-Received: by 2002:ac8:5195:: with SMTP id c21mr454635qtn.304.1595701873366;
 Sat, 25 Jul 2020 11:31:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200724145401.2566-1-krzk@kernel.org> <20200724145401.2566-3-krzk@kernel.org>
 <PWBZDQ.D1XCW6N2YMRA@crapouillou.net> <CAJKOXPc2w0QHQDEwqoeg9Nm361MszM4LRaCoJD2En-fPgPp+4Q@mail.gmail.com>
 <IBDZDQ.K28R5FAI0BXI2@crapouillou.net> <20200724155436.GA7460@kozik-lap> <K5Y0EQ.WYAK00ADM46F3@crapouillou.net>
In-Reply-To: <K5Y0EQ.WYAK00ADM46F3@crapouillou.net>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 25 Jul 2020 20:30:56 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0HDu15u5dREd6gk_e9D6mrZ9JqT0DJs9AeC9C2602nAw@mail.gmail.com>
Message-ID: <CAK8P3a0HDu15u5dREd6gk_e9D6mrZ9JqT0DJs9AeC9C2602nAw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] mtd: rawnand: ingenic: Limit MTD_NAND_JZ4780 to
 architecture only
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Harvey Hunt <harveyhuntnexus@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:H2XqmAMuyGphOIpbigKAPK09HPpmKnkYoLEhmeGweI/C798jmwW
 czcR82TdRmHP7zVVafOrCcCe6yMr+UC382js6yKm2K8h50Yv926koJWrF3r25b0iZlbMWZO
 ei00/nDjKHVyjMZtyi5p/9+r6KT0aomIqb1QGeiTg6ziqobDdwKQwRdbFocC0ZwesiQL0Yf
 fiE+tmOVwuL6aezksr9FQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:RiioCsFudRg=:Rj734fPAkZEIeZMBMjzidc
 TXqy1SwAn03UCGz5zSGKvkfnX9A41ZUzHB+6vZgmXXicFxGpuXtchlppua+ziCulObMOvQznA
 uW9gjTfkx7jfm2Nf5ETxgXcNacSIqbqqR/lgq9aOhnJzXYsXPCPxo4gOfCi5nN8f+2XnYrKPJ
 MBxlEpHV2sVXiBd1kxZoyvmCQmU9xLDeb7pzaNM5UwZ9KGxruBevBTo+AEuygVlU+m0hPzOr8
 1E/kXlOjSmLkVRK8hWIPJOzbgxL3QtgnO+SxqAxE/fAWtZTA9Mg9AzJRzFsCnU8kTL79Gftbd
 kSCVDoKvgezEINfa+Uf1WkSnpOmmpHB2RoJqPfBLUUXrwTizKLXX5V1mYA8HD5rFO8hyDrFLa
 sJVTN2O0vWimdXjl/7jcadiIuq/TpUxXl9WhWnp8JF7tNg/pz09yyMz8+fMmD0kzdMsrnzH59
 6oyI+tkFFFPdk+7+HYbl2+ybJjUizavI57HIXzwJ//OynUunNV+Dzk2TAEU3QcDcTNquK8Idh
 c2ycqzBTYbIGr7utw+fd7gS2C1gbasUe1k/Akp3rV1IY7Eu38ua28f3J5QwVK0w2ZgT2LeMxe
 43Tc3Qjda0pJzibCxzVcqIuflhqlKCzoSXyiRNCxVa3NMZmMAt6S/9wXr8p0AbYTTofF7dWm2
 MqFo1FhS8bXc5kGSbWriKCT6GTFai3QUEO/PYSp8DkHQdGuP0ypvzJ8oEgvCQNhZe0XH7CQtW
 364aKB8mIUfX3ba126jbJjwhhald2JZZvhfRK5RG6ZbKgWqDf9O98pBQh1Rl4Du8ju83/zV2s
 7+CQmRF41avEPzjanzd44vRCm2FiuYO7hNYuAspmVpu/zKHu83MqPRiU6L1ak+BCg/JNuM1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 25, 2020 at 2:17 PM Paul Cercueil <paul@crapouillou.net> wrote:
> Le ven. 24 juil. 2020 à 17:54, Krzysztof Kozlowski <krzk@kernel.org> a
> écrit :
> > On Fri, Jul 24, 2020 at 05:50:06PM +0200, Paul Cercueil wrote:
> >>  Le ven. 24 juil. 2020 à 17:33, Krzysztof Kozlowski
> >> <krzk@kernel.org> a écrit:
> >>  > On Fri, 24 Jul 2020 at 17:19, Paul Cercueil <paul@crapouillou.net>
> >>  > wrote:
> >>
> >>  On MIPS, the SoC selection is a Kconfig "choice", so you can only
> >> support
> >>  one SoC family, unfortunately.
> >
> > Let's say someone selected then some other architecture
> > (MIPS_ALCHEMY).
> > They could select this MTD driver.
> >
> > Does it mean they would be able to run it on Ingenic hardware?
>
> In *theory* yes, as long as the Kconfig options that MACH_INGENIC
> selects are enabled, the kernel should boot and work on Ingenic SoCs.

Right now, this won't work yet, because there are platform specific
functions that are implemented by each of the platforms in arch/mips,
e.g. arch/mips/generic/init.c and arch/mips/jz4740/setup.c.

A lot of the newer platforms are part of arch/mips/generic
(CONFIG_MIPS_GENERIC), which roughly corresponds to
CONFIG_ARCH_MULTIPLATFORM on in arch/arm/.
Similarly, there are header files in arch/mips/include/asm/mach-*/
that conflict and you need to have the right one.

To have more than one platform enabled, each one needs to
have all of that platform code converted to fit into the
MIPS_GENERIC framework. This can be a lot of work, but
I suppose the ingenic platform would be a candidate for
which this makes sense, as long as new SoCs of that family
still come out.

       Arnd
