Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56C89C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 11:15:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CF7821D7F
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 11:15:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2632820AbgDPLPa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 07:15:30 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:40531 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2506125AbgDPLKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 07:10:50 -0400
Received: from mail-qt1-f172.google.com ([209.85.160.172]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MLz3X-1jgyo13MSv-00Hzkr; Thu, 16 Apr 2020 13:10:37 +0200
Received: by mail-qt1-f172.google.com with SMTP id q17so15700545qtp.4;
        Thu, 16 Apr 2020 04:10:36 -0700 (PDT)
X-Gm-Message-State: AGi0Publh/6A1ywhzJFXljY1iei2ApTYHDxrHvtwIUqAcPAotF8yROQ+
        q1xzUFVjdnNi5WJySQLFnyo1y1tIhKA9ehA3AL0=
X-Google-Smtp-Source: APiQypKTnCrAJKWmvxQPPtXXxzoAVa6UTCMFQ9ATB3ibHu7YaQVTiYtm10ABd1Vj8N7EIF+bQAx1sinndyRxZBuK7IM=
X-Received: by 2002:ac8:296f:: with SMTP id z44mr23735521qtz.18.1587035435488;
 Thu, 16 Apr 2020 04:10:35 -0700 (PDT)
MIME-Version: 1.0
References: <1586937773-5836-1-git-send-email-abel.vesa@nxp.com> <1586937773-5836-12-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1586937773-5836-12-git-send-email-abel.vesa@nxp.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 16 Apr 2020 13:10:19 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0fDJQvGLEtG0fxLkG08Fh9V7LEMPsx4AaS+2Ldo_xWxw@mail.gmail.com>
Message-ID: <CAK8P3a0fDJQvGLEtG0fxLkG08Fh9V7LEMPsx4AaS+2Ldo_xWxw@mail.gmail.com>
Subject: Re: [PATCH v3 11/13] dt-bindings: reset: imx8mp: Add ids for audiomix reset
To:     Abel Vesa <abel.vesa@nxp.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Shawn Guo <shawnguo@kernel.org>,
        Peng Fan <peng.fan@nxp.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Anson Huang <anson.huang@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:KQ+T8D0HvWvxIDVOE8VSY51PYvng9yj5NHqSmIvlwfO7JKnO5+S
 SyTDOtWMwBqH30u7KqZszvunI9Gy+oOeWkYtwLBdTaoVQCdSD7tXPTMQQzfbflEEvyZljL4
 sKUgxwAN5/T7NVY1qV1j8z56OGqu8ONaJTqgOuKExuA1TH9AYwj/eHnkQw/bKR8luJjhHVr
 2PIG2FlBc9rAj+B8Ug9Ag==
X-UI-Out-Filterresults: notjunk:1;V03:K0:F6L9vopFEUo=:LqVBk8PtrZdoNV8X1XRXaz
 bNSd4Es1iOJgq+MB61ogStg0FrWUFWRzO53jNw0J8sI8VnHK01dInOk0/jzlAAdM0yLKQpvcP
 FP200WdBfSHjeewvHvJQP4ZwvBhGEcTfhN1/M1WmuxEYU6iEv0YB8yUprLxN4+h6awPn5e00y
 DDURCXpt2xe8miGl8Td3eLWMFu9dUxhd7b+MIbsZpzY2dG9t/MomCF0lV9zhO03cz0ZEU7n1L
 +OoASIpQkVflGCGRTJoAeAE76q3lZ5gmwbWpTrYaNXQlFHzjaDLwkHEVun6eemUupm3INKqWu
 AVN/I5vOk7kjsUEgO4CFn2RVGeY8sPHnswV5kt9jD6v+7bBoGO09tbpFJxiAp3GpNURmo9VFV
 72US6hNy46Ngmv4yje+qytpO8PBfOpphu8Qg7Pnw1K+2CBcq7u0w5Uq3ZavN+jaYJFnzAqdxD
 fZMlVQHsioUibV/RF7syAR5lSGyo/mUC+TzrFZDqXVeUUVMUG9stQ/wOR8ACD4zr6pJQUOWaR
 ORadF8TzZHqPXYiYVcrxwnJkc8rkz11nub2q2Rfz6TzESWptjf4EpscRPyFv5Qlw/og+ixiIQ
 9Tk4MINlJTS23ogvmD0SfnUHELS5PPBEv4gFFpKugpDNFh9LaCAtO/gzL+kly2+8zzJcCtrL2
 s/gQVITXhCYPPJcN1WZpDPKu/ID1tuRzgQ4vKWREpoBVx0NqrN86tZEY24GLQ3HzaBL9/9BjW
 RtbOAR7/KruHaCn2R8gYSzXZRC4KWBt7F4haW2zsY6abTv6CkpS4FXSR2AhDitTCGclgmRl4G
 G+ib1vdnPUFJi2E3cUIoRzmlgsMaiKqLAuvtc8shbSEGKYAKec=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 15, 2020 at 10:04 AM Abel Vesa <abel.vesa@nxp.com> wrote:
>
> Add all the reset ids for the audiomix reset.
>
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> ---
>  include/dt-bindings/reset/imx-audiomix-reset.h | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>  create mode 100644 include/dt-bindings/reset/imx-audiomix-reset.h
>
> diff --git a/include/dt-bindings/reset/imx-audiomix-reset.h b/include/dt-bindings/reset/imx-audiomix-reset.h
> new file mode 100644
> index 00000000..67392c3
> --- /dev/null
> +++ b/include/dt-bindings/reset/imx-audiomix-reset.h
> @@ -0,0 +1,15 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright 2019 NXP.
> + */
> +
> +#ifndef DT_BINDING_RESET_IMX_AUDIOMIX_H
> +#define DT_BINDING_RESET_IMX_AUDIOMIX_H
> +
> +#define IMX_AUDIOMIX_EARC_RESET                0x0
> +#define IMX_AUDIOMIX_EARC_PHY_RESET    0x1
> +
> +#define IMX_AUDIOMIX_RESET_NUM         2
> +

This list doesn't seem necessary, as the number you pass ends up
simply being the bit index in a single register.

In a case like this you should better not have macros at all, those
are only needed when there is no easy way to the numbers in
the DT into something the driver can make sense of.

       Arnd
