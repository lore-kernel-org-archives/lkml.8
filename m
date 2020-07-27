Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A002FC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 07:56:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86D7920672
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 07:56:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbgG0H4P convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 03:56:15 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:47899 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbgG0H4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 03:56:13 -0400
Received: from mail-qk1-f182.google.com ([209.85.222.182]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MQMmF-1kDWnN0KfJ-00MOyW for <linux-kernel@vger.kernel.org>; Mon, 27 Jul
 2020 09:56:12 +0200
Received: by mail-qk1-f182.google.com with SMTP id b79so14432212qkg.9
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 00:56:11 -0700 (PDT)
X-Gm-Message-State: AOAM531Wokv7W6aWtxRYW721+KHdJb9UAPeHbLfQMdcfObI6Qfyzbwmp
        zz8dw9mnGiRu004mmfrYLXlTjNNL35lEY9i0lmc=
X-Google-Smtp-Source: ABdhPJwN73bC8kIruJcdjJC2GFRSQxWwqPQCem38agJRvfEW+LrAzk5A0Z4s9LvPRY/dFw6d3xdJR2PEcDvNhP9aTUY=
X-Received: by 2002:a37:385:: with SMTP id 127mr20493263qkd.3.1595836570861;
 Mon, 27 Jul 2020 00:56:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200724145401.2566-1-krzk@kernel.org> <20200724145401.2566-3-krzk@kernel.org>
 <PWBZDQ.D1XCW6N2YMRA@crapouillou.net> <CAJKOXPc2w0QHQDEwqoeg9Nm361MszM4LRaCoJD2En-fPgPp+4Q@mail.gmail.com>
 <IBDZDQ.K28R5FAI0BXI2@crapouillou.net> <20200724155436.GA7460@kozik-lap>
 <K5Y0EQ.WYAK00ADM46F3@crapouillou.net> <CAK8P3a0HDu15u5dREd6gk_e9D6mrZ9JqT0DJs9AeC9C2602nAw@mail.gmail.com>
 <20200726160616.GA2662@kozik-lap> <RO33EQ.546WD84D5N7K2@crapouillou.net>
 <20200726161545.GA6058@kozik-lap> <B243EQ.VEXGA7ZL5JAE2@crapouillou.net>
In-Reply-To: <B243EQ.VEXGA7ZL5JAE2@crapouillou.net>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 27 Jul 2020 09:55:54 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1r6AMz2wKBEosAqn7qkuJY4LGFYK7o85sO++d+TSVOgQ@mail.gmail.com>
Message-ID: <CAK8P3a1r6AMz2wKBEosAqn7qkuJY4LGFYK7o85sO++d+TSVOgQ@mail.gmail.com>
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
X-Provags-ID: V03:K1:dU5DLlV+sbrqR4UICfuTpx0/Lh9IPvagrWGBCSIgUCh5uqnV5r8
 L9aw89+q+Gk1+tn9DBWV25UHAZmwYqmxnbf/VDQQ5vLg9AUAtLERNC7m/gAusPnq3jnR46c
 3MWCoGKLyAt7dR/sfP+0UioTI7NSUz8w+3uXxqG5uyZJ5JTmZusvK1YkdfqQ6HUd7adAaFk
 cVsrC+GeAKX3L9ffVzuPw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+PvoUUmvStM=:2Kfr7htIz1Pt0/aj/fVZPh
 O2N2gSr2lj0ywHcZMXVpZQHZpHulQ/2smksiRdojaoBvt4BXqc6r2zCPDSoVFRAK58DGh/+ia
 8Aigoom5sxUFmD1Tcyr2YLU5Niay/2h5FTEdvn5F6cDHUkmsrzn08RRZo9cPmNqqR5k2QuFAd
 KFSKbTWtdi/h3xzMxIeaHYrvfY9gLPOB4lsOSPVdm5WMEPsKMlozv0uq9PgS49+Tr7yfvrYJr
 FEGx3CQUDgO9E6ozaEO90Y3Rv4rj3Z6akea2yQetDsu0vxxclcJUbkeOmC0jUfYlsyHKP9nU6
 5S+FzRT3MVzfaf6/4hVGSRgjW+skoj3bKajvb/nU3jN5K9K5YkNPN6fmPcOvaPizkRj9f2xnb
 c8A5pHsDSb0MT2mLkSud+JrhzYPiofxsRb4nl2L8BRLo4cpV53OC4jWF5ze+2F4c+yqKRxFY9
 +OgAS9i6+KuvzKpVZte/QzNyy4dBD9+1ucj7pGkZ+tpSaW3VP0n9S4BvHfA8KzKMq+sPsbaie
 YLGXVy9y4lkwzd54SzabgOjUUGtuEYFYGvSCJ7aO89xEj7aBh+LRC6zMEgz2x1KV/P6ph3/Nn
 YdVSWDG8KhGxttFlbkitZFcerxgwAC1mHK6GR/uEeAKunppun7eGurlpY1x5aBGKW7QGwcflK
 wFDErshG6jGveJE99NQ+U7LblC1cgRNGxXFbArQe+Tz4mzEQSA+8S4wJNnms2Mvzva9agHAb6
 yzlR4+6crAwZg6oGkyihLqsmAQs1ntzihcLfuSAYG9PjKvhYcPuMsG0I5hrLvvW2r/dGy0tlZ
 7YlALXdtwaec/pJEWqew1wWVlh5EvjKHpwyU35sqCRDJzcnyC3R6/hNSYsHOkH7pqhhwH++Zt
 +TETEBeLwFlFbapzHsbEXuf103/fqpBxLEPm7v+oUDnsIFnAx1bnTqkflSlqP+yNEDpDo5yPW
 5HY6+ikXF7/wH5PcLNK+vFVIx9AyFyQ92l53hfme3GOx/Fsqx643X
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 26, 2020 at 6:20 PM Paul Cercueil <paul@crapouillou.net> wrote:
> Le dim. 26 juil. 2020 à 18:15, Krzysztof Kozlowski <krzk@kernel.org> a écrit :
> > On Sun, Jul 26, 2020 at 06:12:27PM +0200, Paul Cercueil wrote:
> >>  Le dim. 26 juil. 2020 à 18:06, Krzysztof Kozlowski <krzk@kernel.org> a écrit
 >
> > OK, that's true. Anyway, I don't have strong opinion on any of this. I
> > just followed Arnd's hint.
> >
> > For the memory driver (and MTD NAND as well) which one you prefer:
> > 1. https://lore.kernel.org/lkml/20200724074038.5597-6-krzk@kernel.org/
> > 2. depends on MACH_INGENIC || MIPS_GENERIC || COMPILE_TEST
> >
> > ?
>
> I'd say a slightly modified #1. The driver shouldn't be "default y" in
> the first place, so the patch could be to disable it by default.

If it defaults to 'n' even for MACH_INGENIC, you may have to enable
it in the four defconfig files for these machines to avoid surprises.

> And when the Ingenic code is merged into the MIPS generic framework, I'll
> send a set of patches to change all driver dependencies on MIPS to
> MIPS_GENERIC.

The way we do it on Arm, the machine Kconfig identifiers stay around
even for multiplatform targets (which now make up basically actively
maintained machines).

I don't think it makes any sense for a driver to depend on MIPS_GENERIC:
either it is a generic driver that should always be visible or it is specific
to a set of SoCs and should depend on some corresponding vendor
specific identifiers.

       Arnd
