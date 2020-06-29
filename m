Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91831C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:56:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77436206F1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:56:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389851AbgF2U4W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:56:22 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:39337 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731284AbgF2U4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 16:56:17 -0400
Received: from mail-qk1-f182.google.com ([209.85.222.182]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1Mf0uq-1jATjC3nC6-00gVz9 for <linux-kernel@vger.kernel.org>; Mon, 29 Jun
 2020 13:28:29 +0200
Received: by mail-qk1-f182.google.com with SMTP id 145so12356881qke.9
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 04:28:28 -0700 (PDT)
X-Gm-Message-State: AOAM531XpgxAB+w5fH3gfSbm+rKX69mxTCiqz6nWFprhnirr/OR+eQYW
        DnQVWtUCdOYH68V3QlnL0ARLUNriJHyq2Ez7pPo=
X-Google-Smtp-Source: ABdhPJx1a27SVGh6LzPXCycNokQG+CDZxoOG3UMU7wKdxdg7U0z8BdyRfM4glFcYitYHD0+6fYEnvcVI9PbQkgjt+84=
X-Received: by 2002:a05:620a:1654:: with SMTP id c20mr8009980qko.138.1593430107812;
 Mon, 29 Jun 2020 04:28:27 -0700 (PDT)
MIME-Version: 1.0
References: <1593425623-31810-1-git-send-email-Anson.Huang@nxp.com>
 <CAK8P3a1pr8YbZMpSXg6o_UeDvaU=dDqfo45DudTASNcsxeg3kg@mail.gmail.com> <DB3PR0402MB3916292FC3FDE4F28AFEB5EBF56E0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
In-Reply-To: <DB3PR0402MB3916292FC3FDE4F28AFEB5EBF56E0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 29 Jun 2020 13:28:11 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0Za99-xXTwtHNHO-Dzbo-1uesNC2oO91RA-gZZG3Anmw@mail.gmail.com>
Message-ID: <CAK8P3a0Za99-xXTwtHNHO-Dzbo-1uesNC2oO91RA-gZZG3Anmw@mail.gmail.com>
Subject: Re: [PATCH 1/3] reset: imx7: Support module build
To:     Anson Huang <anson.huang@nxp.com>
Cc:     Russell King - ARM Linux <linux@armlinux.org.uk>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Stefan Agner <stefan.agner@toradex.com>,
        "oleksandr.suvorov@toradex.com" <oleksandr.suvorov@toradex.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Leo Li <leoyang.li@nxp.com>, Vinod Koul <vkoul@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Olof Johansson <olof@lixom.net>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:EjVc+ogzzXXqEFzj480i0DqLvw32xnU3m5wQrDzQpck5eHfOAfG
 HRkDxl0F5CwwRdLh0Zz7Lgp/Lducn1f5siBLvS/4KwMcXoqwuo90hZnojvFkOLiUGBodhLq
 ZZDGFKb97mLmKRB+U4KX75rOUuewGHe0m3Oay4XugYVvGCSrpeiZdacjK5aBQmQabDfoHgQ
 +9Z6yBTSaH+/EdxvFRr9Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:oMdFggA9gVQ=:fYdvnFtJM8WbK1LXfVVpVR
 OAeV1wzLC2zNCHgCAYMSt2Uv189+iCWulXlCRf8DuSL+hTboTaQw1oSO6T5dxxvF38glH2Njr
 fpV2isTMuu3f8MzIDfFCP308dfcuRxdnMEuYePmCkOryXXf6AccriHPTjIAdIVXg/Dc7LtXvS
 sx9tfY22QDWd0d45rDV9uNzLswJ3Yn9juiKaAsxtlP9O1gQCY0ZZmFMd9+R+zzSJbA1Ne5R+l
 jJDI9glctp+R2m8tRnSP+Nl7VUgZOG7x2d+LwMVuqKqTHlFD9zknwXkXo+526VTXFSQeNdaN5
 /i3kUrbhWTfKTv91m50spkroIAK+GJaSdMglkgYtBMwpkoTqIs+MkiYMdtZX2E7hXD6WmO4qv
 1rWbT0wH8CsG6ohyUZwa4Cc9DU/jKqcbu9IIoP+om2fNXHN8M96snYFF75PStpUhC7sTLPXO9
 hnSxSKQGx1PwpWFDhXyC9neX7W29R9frldJFqRYcL93All9UkQklFYuRmXxlUknK6pLvS2LBp
 k13wlNldLuPYtTMI4UWvqGshaJisstq42c7iQWIg4MRPBH2OjKbISvuezEIrQnnPeeS6vl3z7
 Y/YvzwHyrZt7hUle5DLV2cYCAe5VHeyaeBFwJnYvBKUETqmYRJzQwvSqMBzzLPp/yLWOKZBIm
 LwhiN/Sdx5aYuX5XpGLv44k7sIiusl0GGel/pQ83qTkOIoeLrQ+95Om3CHKj9ta3F1tFle4WP
 iwM2awJzQCTyfK9Y7zjpMdQz+d7YYhWnoxjQ+9eO8nm/teAk1h7t0X6loZveflhz60v6H64q3
 lxK1GV+VxmtO3NZZ6hTg2hyC7QsyA/wKcdhS4Z+lfqajNPEKDdIrlz+vcylo7SYDtr+OMDrCh
 UvMFeb6K4ox5M0QXURumk/eYPk/AEBSvjF/RL9WxYZyL16wdkrtRtvK8IfnK6rU6yQauguInP
 QDce767acQeU4EBaaM7dVF4lvAgqpaVojtzqT6Pv3xvN57vXhvweM
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 29, 2020 at 12:45 PM Anson Huang <anson.huang@nxp.com> wrote:
> > Subject: Re: [PATCH 1/3] reset: imx7: Support module build
> > On Mon, Jun 29, 2020 at 12:25 PM Anson Huang <Anson.Huang@nxp.com> wrote:
>
> The reset driver normally won't be removed since it is necessary for drivers which
> need it, it is just for Android GKI support, in this case, do we need to change it to
> module_platform_driver()?

Please at least try to do it, or explain in the changelog what went wrong
if it doesn't work.

I don't think "because Android GKI" should ever be the sole justification for
a patch. Making drivers loadable module is a good idea regardless of GKI,
and if you do that, then make it behave like any other loadable module.

        Arnd
