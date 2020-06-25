Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB45BC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 08:13:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C1F62067D
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 08:13:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390542AbgFYINR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 04:13:17 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:34269 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726930AbgFYINQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 04:13:16 -0400
Received: from mail-qk1-f172.google.com ([209.85.222.172]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1My6xz-1iv8kf3MyN-00zTAH for <linux-kernel@vger.kernel.org>; Thu, 25 Jun
 2020 10:13:15 +0200
Received: by mail-qk1-f172.google.com with SMTP id e11so4550529qkm.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 01:13:14 -0700 (PDT)
X-Gm-Message-State: AOAM533Rg+6Tnx7Ptv5MGyRAbyh2nv/p0t9dJgMfFsnbXuZ8FJHEynDv
        MX0KwHxkPFCSpf4QVXm50k+/A+oi4/C4EI/z+9M=
X-Google-Smtp-Source: ABdhPJyQ4Dw0Jl+qFPTW3FnNdbWckzbhZDf0wVOnCuLr26L/KFZZAfwaRwhkmdXaJOf9IoqmqkzMCC1q5edEYB6JOm8=
X-Received: by 2002:a37:a496:: with SMTP id n144mr16346478qke.286.1593072793699;
 Thu, 25 Jun 2020 01:13:13 -0700 (PDT)
MIME-Version: 1.0
References: <1593044164-32362-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1593044164-32362-1-git-send-email-Anson.Huang@nxp.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 25 Jun 2020 10:12:57 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2uh2eBHE+XPt1gUDEj0vnXwES-GmL=rsBRDHpK5HXc0A@mail.gmail.com>
Message-ID: <CAK8P3a2uh2eBHE+XPt1gUDEj0vnXwES-GmL=rsBRDHpK5HXc0A@mail.gmail.com>
Subject: Re: [PATCH V2] firmware: imx: Move i.MX SCU soc driver into imx
 firmware folder
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Leo Li <leoyang.li@nxp.com>, Vinod Koul <vkoul@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Olof Johansson <olof@lixom.net>, Peng Fan <peng.fan@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Franck Lenormand <franck.lenormand@nxp.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        NXP Linux Team <Linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:cQde4KPxtx/TpxlseTBsNpVcQ+r1G5tV+dKJec5iKpQlbvTBUC2
 ruItMWeuKhIFvaNESqLvg4b1rTX3QnIl9KXXF8Cq/beIuvmCGib0VTyV7xYkYY+C892UImk
 Nn2bn6UZG0rofBasJkRvZzYZD2Tzn8Xwq8jrRuEazhBns8E+U6WE6Sh8CNKJFyoDnPdxWgA
 gMteFxqxtEzF+6GvARuFg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:J2IrnnD4ATI=:GQuCxxa7onu8ha/QgbkYKZ
 L5jJGrKoIksO6H/IpLKTL/n8MAH7VJR/9Bh296W1LZ9Q2p1LM2v4dFKEktIKrfpN3/T2YkyPq
 mtzyN78Vk5Pcl9NNdcjBuzgcdCu3RAHnHAyJsed6Yqz5ikqUb6Y3XnMI9cqVY93tAyIaxH7QD
 +293d8KHjTpd1fFgzw/WA79ODkGNN5CD/n+sIN1VmA+d4MkL2N9bPwRTh3alYVlc/e7QQ+P5i
 6rTr4GA5FAurBzldlqzwwLBnUv2DJwpZa574lp9urfH/iVlGcMDrU3m0JXSIy08Gw+YrR2ZPy
 ecWzr9jqaTv8J9WJFx1Ve8PoiMayyzutmkKN1T6OsLmVrUQKC+/A/mTfA3eft2ZaxMVKHkxN0
 yx2LRWt4SXfdJw/2Emz4LlQ4AdZx3L6zMiqOj2kMimoAdKdsSIjeASnqsdTqvzvqhv+6bxhXF
 bo99LBLKdQZ+xb89UvzhF1BKtZ3nGc8R9rjwYVVfWKt8uywlRl//YLNYPAcNKfcvURPFAReZ0
 nHB3FJungkOQd3hpTEergKgRDiMwq4nNAxSG+dcqPf18KEX6c4yIXrsky3RRu2o6fLdq7fl3C
 P5bt12bcjhV2/WSkDEfq1Tm7+OuLnvO5vm0c/CADFP46EpdsAcWWal4LmPaByIlX/n4V2rUCP
 HvtC95QKzg2oHkN66jFB/YC/1C6+YWCRaILnEw23OSzuhqP0V37nkSCXD0iIPcXny7B41TpvM
 +O1QJ5houfrFu3M+cTC//+EtBp1k/IVUDR+ELYHKqxzT3GfE3wkFjJdNb3U2t+nOfU+Sx3vRS
 K5gIh8skVdfGuDYtq8s0pFl/v9SqQLtBA22+3eo8w/qSxsLfwc=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 25, 2020 at 2:27 AM Anson Huang <Anson.Huang@nxp.com> wrote:
>
> The i.MX SCU soc driver depends on SCU firmware driver, so it has to
> use platform driver model for proper defer probe operation, since
> it has no device binding in DT file, a simple platform device is
> created together inside the platform driver. To make it more clean,
> we can just move the entire SCU soc driver into imx firmware folder
> and initialized by i.MX SCU firmware driver.
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Looks good except for one irritating issue:

> index 17ea361..b76acba 100644
> --- a/drivers/firmware/imx/Makefile
> +++ b/drivers/firmware/imx/Makefile
> @@ -1,4 +1,4 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-$(CONFIG_IMX_DSP)          += imx-dsp.o
> -obj-$(CONFIG_IMX_SCU)          += imx-scu.o misc.o imx-scu-irq.o rm.o
> +obj-$(CONFIG_IMX_SCU)          += imx-scu.o misc.o imx-scu-irq.o rm.o imx-scu-soc.o
>  obj-$(CONFIG_IMX_SCU_PD)       += scu-pd.o

This makes separate loadable modules out of the driver when CONFIG_IMX_SCU=m,
including the badly named misc.ko and rm.ko modules that might conflict
with other modules of the same name (module names are a global namespace
for modprobe).

The way to make this a single module from four files is

obj-$(CONFIG_IMX_SCU)          += imx-scu-mod.o
imx-scu-mod-y := imx-scu.o misc.o imx-scu-irq.o rm.o imx-scu-soc.o

> +EXPORT_SYMBOL(imx_scu_soc_init);

Consequently, there should not be an EXPORT_SYMBOL here.

       Arnd
