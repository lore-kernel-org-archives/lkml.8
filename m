Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77529C2BB85
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 11:16:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 626DD21D82
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 11:16:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506125AbgDPLQc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 07:16:32 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:35707 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2506182AbgDPLNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 07:13:55 -0400
Received: from mail-qv1-f49.google.com ([209.85.219.49]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MuDPh-1j6o4C3Hq9-00uaJK; Thu, 16 Apr 2020 13:12:01 +0200
Received: by mail-qv1-f49.google.com with SMTP id y19so1575640qvv.4;
        Thu, 16 Apr 2020 04:12:01 -0700 (PDT)
X-Gm-Message-State: AGi0PubRT2SdYTkhIEjJSZmqyTc0qSMC/rqcVrbySVmMnMRFiBtUWHra
        4u3zl+sq1SfKxlSNwIzblvmJJAtajZ24vv1trIg=
X-Google-Smtp-Source: APiQypKUBOB6XQd2d+M75WuZ0DqJUTG/HnuwXa8550Av2Y6bO9ZONTvLBnhPRU7U+ROebImWwMBgxhHTnpmmhVTBibs=
X-Received: by 2002:a0c:a602:: with SMTP id s2mr9756889qva.222.1587035520523;
 Thu, 16 Apr 2020 04:12:00 -0700 (PDT)
MIME-Version: 1.0
References: <1586937773-5836-1-git-send-email-abel.vesa@nxp.com> <1586937773-5836-3-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1586937773-5836-3-git-send-email-abel.vesa@nxp.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 16 Apr 2020 13:11:44 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1Zd8Pctn9ra9dH7bTUSSMoTOwmDNOc6JwmKQA4fgdpWw@mail.gmail.com>
Message-ID: <CAK8P3a1Zd8Pctn9ra9dH7bTUSSMoTOwmDNOc6JwmKQA4fgdpWw@mail.gmail.com>
Subject: Re: [PATCH v3 02/13] Documentation: mfd: Add DT bindings for i.MX Mix
To:     Abel Vesa <abel.vesa@nxp.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Shawn Guo <shawnguo@kernel.org>,
        Peng Fan <peng.fan@nxp.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Anson Huang <anson.huang@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:+sq+YMxtlC9OU/qKkZhu9BGJJ5gWuzZ4Ytnc0jfFhmWzcXtl8+M
 Q95Yh2SeJzbVsDYPxBAg+r4yfopOTdjV65qorKsHYDqfkavkuHc23AZjKcoTXN1ULekS/Rh
 gKZ/WDwKJkGbVkbIcexDMUqmPwWYE64i/VuZ/s7HV8H7v3g7stGbn9SBDKw46MmNCPp/Eej
 s6MydABCpcfdbZ9dV0LGA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:n3Rsk45AdaQ=:EaVzcBvIGXitKFCtnWj6Xf
 0pLpWUsZtJIIoFMn78shvZX8VWdWAVeUIg9J4demjPjeKUODaW/CpIKBFB70iMVbf8InxR3I+
 +FfJkG4RiH6W+rMrpz8ZfphUc/VPGuHlkE+K1P3Hswct0XFAuToVa8Zfx2hq9801TjHbl7jyu
 H70lU8TmpXNKlnmK4MtwzYXBuOqRXhtaLHZHjO2qSne2tm8rs6TsTO5VrBk3tYNff3gC3fWw9
 lhGI5iKrWPxxPnz3ZTy2KtePbzhA+vb+YLX/X8QlIRAZKndk6RnSZ7Nx5apHFdNQ8EzBPg6h9
 rUNcNMioMDUXp7wrSQL6JIrQpsMOXllNXag16Ep6QxJ5HD3ox0iNARfM4b9Xu6c7YVmY1Xc0t
 Bme/cjR2hw5ovsObpAm2TcKOwBv9h3K0Pn/Ac6G46kM7y/Lf+Lb7CK+Nsj0poXx6JzLYsI0Tv
 ZEi6jCjvvsTkzsh+dTY8yhOtvRFx9uAGqWxd75ccy1vN0LJmUinyNwrPiSBmf3JZxZjdX+Pzt
 4ZfxfHlKSpPJ8bJTsQOyrF6+3UjpZcXXnkPIeM8Z/0USfHQhJAeUgM2M1Rl0bWy2odwwgaalj
 2sZLyanKooMUe76ztk7cLOM+m3AoxCgJge4M4mni6/Dn0F8Dy2B00u49wDa6WZmqbibd+vDTY
 GF0D6NLH6olyyTnBvZtuhaXNBnalSxkkuf83oIgKNbJmPbHW5XZgRq7Y/6Tb6WBq1sGIUwBBp
 9he2vzD455wDPZDzqMlu34kghREwKYKjeBfz9dg3NQEpj+9s7DpQ0/QC2UjwU0BPaPrs0wMdB
 0bxyJ3JKkH8L7c98Xejqk2YZoKDIWk7ILaB4M4d5+335vjKSSY=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 15, 2020 at 10:05 AM Abel Vesa <abel.vesa@nxp.com> wrote:
>
> Documnent the i.MX Mix with its devicetree properties.
>
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> ---
>  .../devicetree/bindings/mfd/fsl,imx-mix.yaml       | 34 ++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/fsl,imx-mix.yaml
>
> diff --git a/Documentation/devicetree/bindings/mfd/fsl,imx-mix.yaml b/Documentation/devicetree/bindings/mfd/fsl,imx-mix.yaml
> new file mode 100644
> index 00000000..8b1870e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/fsl,imx-mix.yaml
> @@ -0,0 +1,34 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/fsl,imx-mix.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Freescale i.MX mix
> +
> +description: |
> +  i.MX mix is a conglomerate of different GPRs that are
> +  usually dedicated to one subsystem. These GPRs can be
> +  further split between different types of drivers, once
> +  the MFD populates all the devices based on its devicetree
> +  subnodes.

This does not describe the hardware but the implementation in Linux.
Please rephrase it to not independent of the software that interprets
the DT nodes.

       Arnd
