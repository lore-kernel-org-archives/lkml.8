Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4950AC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:08:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3591B2076C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:08:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389916AbgF2VI1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:08:27 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:48001 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388430AbgF2VIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 17:08:23 -0400
Received: from mail-qt1-f177.google.com ([209.85.160.177]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MO9vD-1jRJwr2z1t-00OWKv; Mon, 29 Jun 2020 13:40:44 +0200
Received: by mail-qt1-f177.google.com with SMTP id i3so12481802qtq.13;
        Mon, 29 Jun 2020 04:40:44 -0700 (PDT)
X-Gm-Message-State: AOAM531MqA3YaeQ4u0gkltxA/lNCDogD8K+5A5eInGwjOcWPXBeLNSJV
        E2nNC1GXgpQcogyW3gFvFbK7lz2rvDAsboBmnY4=
X-Google-Smtp-Source: ABdhPJz3molUt3XhhH/gcKqW2wmJX47FKk5O6OYBrVzFJ60Zs/j1zw8wVX5Qp6lQIudUPZgdiQLCp03/RIF2vyQgt/Q=
X-Received: by 2002:ac8:2b98:: with SMTP id m24mr15453696qtm.7.1593430843466;
 Mon, 29 Jun 2020 04:40:43 -0700 (PDT)
MIME-Version: 1.0
References: <1593410042-10598-1-git-send-email-Anson.Huang@nxp.com> <1593410042-10598-11-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1593410042-10598-11-git-send-email-Anson.Huang@nxp.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 29 Jun 2020 13:40:27 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1W4Wxj0o3dtcjGq0L5VQqsH0=ntego=jmH2Von97+H-w@mail.gmail.com>
Message-ID: <CAK8P3a1W4Wxj0o3dtcjGq0L5VQqsH0=ntego=jmH2Von97+H-w@mail.gmail.com>
Subject: Re: [PATCH V3 10/10] clk: imx8qxp: Support module build
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     Russell King - ARM Linux <linux@armlinux.org.uk>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, oleksandr.suvorov@toradex.com,
        Stefan Agner <stefan.agner@toradex.com>,
        Peng Fan <peng.fan@nxp.com>, Abel Vesa <abel.vesa@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Andy Duan <fugang.duan@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        NXP Linux Team <Linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:qjtlj8TGy0jLGv32fYdCmtHGDy7Bb9UeJuTTjvVFYP38Co4vuRQ
 YxefKZD5wb7lxo2cLKCDvnFVAZVHTt1ZNTdNRXsBcBKPKShAxM0ksIzr3sD2CDLtplpIDQa
 lacuVPdlPRkQNtbKD8zOu221RZfKPXtVMRAyi4eozYHZPqVjUmNh3w0xjIlVvWyTJVbFf9y
 gz3MgeIZ+OfnoJrsogFMA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XmOmyTZ29KU=:rbSDWbNcV72GnMWdxPDS+s
 Qf/zf7Lrix47xUNmauLLdpWKNV6qyE/1sOX6FX5kIRVZQ0PDy8yb+4GYjnLnorIfamSXsMqOw
 m2qUuz8/U7f1uJC5mdiqpfwwvkmhu7Aw4eBvBS5P9GnpHj88m2dBcLgEy0DaAjPBiS7Hs02DJ
 lF3cZTr8Gg3MVBq1mcOi+e7w0c3JXQuFKjoU1ID7Ro71q6qa73iiSzg+qpRHzTGqSQZSzTuud
 QT3W1wjrTTSPMdIiBO2W9YB7RZUN/3xbfjWYAOJT8g6LD+7RlPFBsQLNm3TDodLra/9Kg7V8r
 s0eyTkfngEczgDggK0m7rse9H0jhLlYiQZeP2In5Q9+B/36/OaOmeYCLhkOeALkQtxJUhnbKp
 29thSTPXQOFzr59fA/uv3Zwi2uH3zlkFm/5tL23DDSwSoGGnl5VTq6Eb4bCFsPMgC0m7SUSmr
 0vMGJKRKnkgxCd/e4qcWCnfylJYR3UijhOmg84yrJaoWO8zTk7OUfJJH5hgMCLJmT+Y+TjdFa
 3MDH8YGwqaRt0lgFQRnt8mCgWPM96++b7ubjPp7NmkEgY1Vj+kYmZbE3A/ZNWEZmBfiDOhoPH
 PCU7UqDDrQT8X3KZZThSM+q983yZmGLQYhFbCHxplVdbKnMZBcSyU5DHzuYLA9wS+5yso0wGF
 ZEW7y+JpmMK8tbx9ZDeXuL4GVFVODJKLQc70E6/Lo0hr+QggVn4kOs46sF0VNn1a5ROdQ2iTR
 CmljM009f1gl7ypDil3MkBzhorYr4slnVQkjLzEEq+Sg3yTuMNjJu+gzHLCt1mdt+BPbZpvCl
 +5lfWcZv09W9Fh2AFhYgGyRVlpMzX4nrinSw93Ys41wovI6vxg=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 29, 2020 at 8:06 AM Anson Huang <Anson.Huang@nxp.com> wrote:
>
> Support building i.MX8QXP clock driver as module.
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

I would just combine the per-soc patches into one, as they all have the same
changelog text.

> diff --git a/drivers/clk/imx/clk-imx8qxp-lpcg.c b/drivers/clk/imx/clk-imx8qxp-lpcg.c
> index 04c8ee3..8afaefc 100644
> --- a/drivers/clk/imx/clk-imx8qxp-lpcg.c
> +++ b/drivers/clk/imx/clk-imx8qxp-lpcg.c
> @@ -232,3 +232,4 @@ static struct platform_driver imx8qxp_lpcg_clk_driver = {
>  };
>
>  builtin_platform_driver(imx8qxp_lpcg_clk_driver);
> +MODULE_LICENSE("GPL v2");

Same thing here: please try to make it possible to unload these drivers,
and add MODULE_AUTHOR/MODULE_DESCRIPTION tags in addition
to MODULE_LICENSE.

          Arnd
