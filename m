Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F581C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:57:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 259D8206F1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:57:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389990AbgF2U46 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:56:58 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:39213 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389986AbgF2U4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 16:56:54 -0400
Received: from mail-qk1-f172.google.com ([209.85.222.172]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1Mzi3l-1iuAwi1hTd-00vgo9 for <linux-kernel@vger.kernel.org>; Mon, 29 Jun
 2020 13:29:21 +0200
Received: by mail-qk1-f172.google.com with SMTP id c30so10984018qka.10
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 04:29:21 -0700 (PDT)
X-Gm-Message-State: AOAM532KVF3Mrwsp88XFnB5qMzvUOyGYvzELSJ7vfp+3LkFxDCSgCuhk
        tKdIdL1SiK8XewrnMn2E8AunhBmTcltVXq88Osw=
X-Google-Smtp-Source: ABdhPJxOWyRR6TiiwQf9Wh2sxQ3AKNOhcX8BfRNiFAEby8tFCy7k4tx1AsKF2pBnKqqLfN8S+NOpfx/YguO5KbiA4Jk=
X-Received: by 2002:a37:a496:: with SMTP id n144mr14507722qke.286.1593430160300;
 Mon, 29 Jun 2020 04:29:20 -0700 (PDT)
MIME-Version: 1.0
References: <1593425623-31810-1-git-send-email-Anson.Huang@nxp.com> <1593425623-31810-2-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1593425623-31810-2-git-send-email-Anson.Huang@nxp.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 29 Jun 2020 13:29:04 +0200
X-Gmail-Original-Message-ID: <CAK8P3a31coESQTssW1mndGuZ1pvxXSRRpY=XT1ZO+pkj9aabxg@mail.gmail.com>
Message-ID: <CAK8P3a31coESQTssW1mndGuZ1pvxXSRRpY=XT1ZO+pkj9aabxg@mail.gmail.com>
Subject: Re: [PATCH 2/3] arm64: defconfig: Select CONFIG_RESET_IMX7 by default
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     Russell King - ARM Linux <linux@armlinux.org.uk>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Stefan Agner <stefan.agner@toradex.com>,
        oleksandr.suvorov@toradex.com,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Leo Li <leoyang.li@nxp.com>, Vinod Koul <vkoul@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Olof Johansson <olof@lixom.net>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        NXP Linux Team <Linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:L/cCgtNTGpTZuLd/vE7UdNH3zJxmqthQ+1RD5O4Pl1kAR+QwSLC
 xbdM/tcUzx1D2AQfTzXsK0/CirZfD/hMsNayPxrJyKbeZ4Xe0no4guHiEYDDU/psXr5wBir
 jmZ3Qin4lIcO9thalxj6l/rOxbB8Br0T2OheyFLCWcYPLUXmd1hahymuFFgEY71fxffFDpG
 l6u8XrxzFuFndOwe/0nvw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:k4fUJO9ov5M=:MBC+10tvQBuFpd2IVfJD9l
 L4jMInpaovEk2f0E0nZg6O0VNMeJ/QGOJ+U8j6eADoO6XC6NG1wrNq5PpsoeahAuIF2aFgwM5
 kKyZwko6j1BG7qX/PuhnvbEcLSkrhLAEtjyNaWwGDWcG6sWYOnjpqqggGTq86bkU6yIbVpO7B
 MAcH2q5FgISQc1Soo/R/9QVhB8brNdxtcRId4MhbZHwfAUSM6i8R9H9wGwuPBFYucywSlwFKg
 snKF7fOsKb7J3KIY4vbl9ZR1cjeBbDtLTaZszlnjt1rUyN0n7ND3le/reGxcCYtQCQR2khQ+C
 FEARXPnwSRkiFP2vE5mbt2QjBqCFZahyrdqljGjH3Gi1t5k5MgblyTyujGCJ/4Ix06yFSXh3N
 3yN27M7M0ular2BfOsTu45eh99YO0IoEjTRcfxXjWYKD5a9OsBi1+WU1I91KrzvBZ2fsJhSWH
 VdBFnt2DEr0gU9aDtTx3zYPl+JO/TC/8vuSzkovh77BAkWiU+L26oQqIlfHybI6VdXXrHeDRm
 Cb0aL0fwyVJnFMX2MCIhVKsfZREkawUAz2DZ4pFWB9y5czHScPq3m5U7Eaca0ei0Zh1VlbLLk
 Q0iLfPBPugURcJ7wArexRqaAjQeTXbiseMvDtD9O71mOLFbpQXdClIFFM47zXLA9qBXb3FwkK
 D81rAUjodioeTBVjLVtwD7xKDgBoI5KfetXuc+T4ZfPUNcVtWz4VdtHiAsCo6KykktkYZfJzC
 zDxRNX7GDBExnic5+29k1fGsRZCJPWEoYLK/kqlGpb5PSXaIRk5yZOX1sGBYISP9zOQ79heGL
 4g6ihZzewdviFcwCECr2zMFfNI9UF4prpgV3gIuNhFbBJ683K8=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 29, 2020 at 12:25 PM Anson Huang <Anson.Huang@nxp.com> wrote:
>
> i.MX7 reset driver now supports module build, it is no longer
> built in by default, need to select it explicitly.
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Why not make it =m now that this is possible?

      Arnd
