Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67BCBC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 14:00:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 437D620724
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 14:00:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404016AbgFXOAA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 10:00:00 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:40065 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403781AbgFXN77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 09:59:59 -0400
Received: from mail-lf1-f45.google.com ([209.85.167.45]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MPXpS-1jRSiV30MM-00MbtX for <linux-kernel@vger.kernel.org>; Wed, 24 Jun
 2020 15:59:57 +0200
Received: by mail-lf1-f45.google.com with SMTP id c11so1328220lfh.8
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 06:59:57 -0700 (PDT)
X-Gm-Message-State: AOAM530lmETpDYdINjNhT0wSU6W65z0db0Ca31dxGYgKeeuaWXJXkAnH
        0+1DPKU3+4x2LYo7wK4jrCdGC8sPYBBzy9cdL+M=
X-Google-Smtp-Source: ABdhPJzidUkwqPQ9dWj21NP41CLPEZXUG0LOw5sFrrxQOORaU6Fi21EMkqhuPDwj5uYNywnjm0MAY6nX/1Un8Uic6xA=
X-Received: by 2002:a19:11:: with SMTP id 17mr15768448lfa.125.1593007197230;
 Wed, 24 Jun 2020 06:59:57 -0700 (PDT)
MIME-Version: 1.0
References: <1593000687-12213-1-git-send-email-Anson.Huang@nxp.com>
 <AM4PR0401MB24016D7F1E97F70AEC23BEB392950@AM4PR0401MB2401.eurprd04.prod.outlook.com>
 <DB3PR0402MB391634C85F53E8A9456E89F0F5950@DB3PR0402MB3916.eurprd04.prod.outlook.com>
In-Reply-To: <DB3PR0402MB391634C85F53E8A9456E89F0F5950@DB3PR0402MB3916.eurprd04.prod.outlook.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 24 Jun 2020 15:59:41 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0avMwB8n2Tw35j1+Ps92jABXUCfsgrTM=jHNmPGmAGUw@mail.gmail.com>
Message-ID: <CAK8P3a0avMwB8n2Tw35j1+Ps92jABXUCfsgrTM=jHNmPGmAGUw@mail.gmail.com>
Subject: Re: [PATCH] firmware: imx: Move i.MX SCU soc driver into SCU firmware driver
To:     Anson Huang <anson.huang@nxp.com>
Cc:     Franck Lenormand <franck.lenormand@nxp.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        Leo Li <leoyang.li@nxp.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "geert+renesas@glider.be" <geert+renesas@glider.be>,
        "olof@lixom.net" <olof@lixom.net>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        "krzk@kernel.org" <krzk@kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:hxtVNsnC1ABa4SkYoAzwmGxXfzq35+sZkVk6kIBMQizwjNS2gUH
 AYtUrhwPoxWXiXu1hokSfRiukwryD0g/7lyQi4h7W85WOHPl/8rNenBbJAKlg9RdIl9Ipho
 O4rXbPmbPymdXg9wJazvUitD6MQJZraY7majOEXliYdBd4lo+s14yWb+ywP9anve8S3O17D
 PiCOR9WbiKjLrdlMcoLJQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FMCbqfMeuIs=:/iv787cTIFERBq2pFiKC95
 yAZptiFfaivaL/Z6HpxtvC8HH5BjvsReUeyaCiH/ZtAFWAxmK1Hfj7ZvOVL3hHBhPJFbvYVZz
 1nTaBQMHHQG/QRlw8TfNzelEdo7xctAdflnGT7pyNYduAu55QXOgaI05DwdfGeJiaZHV56La6
 JeoO32+jKbIcxoFIu6w7D1h5U5xQjfTYpS+ErM2mKLRZ5nsPXtpM4SpDCkrML3wIPpY+G8jTg
 Zx2KJeaaoDtwODqWvhXVWZ5n8FTZSs9PJQpnW072+ctjvL0q6lbMznNui9Z5Ih3PZLqPtlzdi
 mCwPsVeH4El0Ywl/OTbaOFdKwTdvzKAQ07hcNdPgNY813XZmSv3rUFLMH2Nq7Ne6PqFR9U7jy
 shLhlG0VuKrf/9uaivCDqrdxzsY0CNwDGZJ2xX7Dd8hHxK39DeQFC1cNrwB1JqFfJsIfy1vkP
 L2nzalFMjs1Xj+iFfpPxnLvYVzD3IGqrItgTNsHF6hmzmtcIaszrin3AYaMlMJPcmatMz32kx
 Eev3AlmuGTNM10u0kgi9i9r5W0lpKKTaAm/4iP3bFJ5u5ssBqxgkiqvHWszPyyYrsIau3HDQ+
 FfwozzdLCUkoylLhK6XLjlBi1aMGmvXuSUF7q5v3LVG8QzkZynH9n0DqObmsOA6nN4J7xy6Ms
 1tGItuuZCSu1O6WV2j1Ll7N3K80r/NKeua0Fme7oWkoseBQYGnJ7J5R26rXIFz4c+NxYNHSrJ
 pphXH7h4guT9DqQz/DzZL2ZXR2c6yBFU3mO0K6OvIVVO+TRBck2NTE5UaLeMgMZpqgXeFTO1h
 tSaUEe+ZQt5w4crdp8hni28Mb7eXVEaceaFenIxc/uO2fkXp2p9g7eWyxYlsIMYLMxUAtaY
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 3:15 PM Anson Huang <anson.huang@nxp.com> wrote:
>
> Hi, Franck/Arnd
>
> > Subject: RE: [PATCH] firmware: imx: Move i.MX SCU soc driver into SCU
> > firmware driver
> >
> > Hello,
> >
> > The move of folder is a good idea however I do not feel adding the code of
> > soc-imx-scu.c  to imx-scu.c is the best.
> > Until now imx-scu.c was focused on exchanging the RPC and init the IRQ.
> > Why not have soc-imx-scu.c  copied to imx-scu-soc.c (change filename) to
> > have a pattern similar to imx-scu-irq? And keep the  imx_scu_soc_init into
> > imx-scu.c.
> >
> Sound like making sense to me, it can make the code architecture more clear.
>
>         What do you think?

Yes, I agree that is a good idea.

        Arnd
