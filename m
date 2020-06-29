Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6C35C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:01:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA4E320720
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:01:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732749AbgF2VBY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:01:24 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:57627 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390117AbgF2VBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 17:01:16 -0400
Received: from mail-qk1-f180.google.com ([209.85.222.180]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MKsax-1jWq9I1guT-00LHp8; Mon, 29 Jun 2020 13:33:33 +0200
Received: by mail-qk1-f180.google.com with SMTP id l6so14863002qkc.6;
        Mon, 29 Jun 2020 04:33:33 -0700 (PDT)
X-Gm-Message-State: AOAM5328dsWrDwEGKaYKF55sT8S/iBqgzomm53AU8WinhIgcfmtr0EpS
        vo9u6IrVjdO5h7GYjOgm9H4DZvkmVz4uDOMJbZ4=
X-Google-Smtp-Source: ABdhPJye1KWp3fw6Y9xHkgeRSfS3PyrD8nrjYY7J24blGVdz8f1gm/UtrzMRZEXgieMS3379QDGNnd1Ku5iv2TMFnu8=
X-Received: by 2002:a37:b484:: with SMTP id d126mr14557185qkf.394.1593430412219;
 Mon, 29 Jun 2020 04:33:32 -0700 (PDT)
MIME-Version: 1.0
References: <1593410042-10598-1-git-send-email-Anson.Huang@nxp.com> <1593410042-10598-3-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1593410042-10598-3-git-send-email-Anson.Huang@nxp.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 29 Jun 2020 13:33:16 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2ZL6_rV=2brNz=UDdji3mddF+1Nb6Ew+=n4j0-fNrCug@mail.gmail.com>
Message-ID: <CAK8P3a2ZL6_rV=2brNz=UDdji3mddF+1Nb6Ew+=n4j0-fNrCug@mail.gmail.com>
Subject: Re: [PATCH V3 02/10] init.h: Fix the __setup_param() macro for module build
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
X-Provags-ID: V03:K1:07GlrRMWmO5DvLo7yBHmrip+tsbslFabumF1hH9WCHW3OEHg9B0
 gXZwj36mzUSffIjIBWLCKPSYTHvew7iFkk3H7u/5Q5cBo92PcUzsX898z+7cbaRUnneb15d
 FKmxOB1TsQ+a7c5U88lgUCThx63kWVWf4edm7LRUJdjnzixuMM6pP4u0BJnZm9FqwX/4iPP
 dCB+AUSFttLsKuQdBdbZQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:cut6NnEb7eY=:n4VyG8vxiQxJPJxagmrYp5
 h+PjDDYquSdLoygHweSVsCjyOuu19SU8qs3MSxvWDPfnj/nGNd0ZJNro5Olzuio3sTxU5aknL
 r0oHQ9AZsXjIrK81NBWyNkrpZzS1z9ghGByQ4qzEEWaZOb2JkIt9IPvJDDnC02n5+hNQrJ0bN
 nfKxVRnJrnKBJS/TxPiO/m+79EMFMn7U3zBtEGXawjoggtaeJSCPxcfe1WC9KSO9De7C+hPZG
 +kX7tM5fnPOB++3/9GHVKYMZYOoV8CFwI9VJY4l1cYg5sNc4Rl4J6yPwXlMaFfSNkAWHo8tc+
 OMpGCnFj0AF6yvqi7I6mymoZvMhtc+uZ4v+BevKQCI6QhfLiEKpGaKLpv9aqyY5bkwNmDqNSx
 NJm6BvcWKISwMOdaVrxrseYYbKSr7BN1GpWBC4iZ1prgyYR52HxdjUcO8J6xd0HLf/CbfvvWZ
 nNOFxB4tYZEo3MN5+mLFT5nidNSYXezxZo7KC+p25ce+eYbw89NW9xUKR1NFtU58lYL8H3uC0
 KZ+7gsmNefLgmsgQ8BRtc1BEupHeM/svWp799ah8Yyhndf/dZLWj4NeYwRuOpXXTRQ4loWBK+
 TFKES6oDUKrRSLzaKlksTDi4RWCX+WvEiRz2p0W93DhReFzmx/ztMF5J2rVFS03p3BCCjeyen
 DUOnEp//GHZwe9gRgSXqVmAW4WtKpwyy85519E9jq3gpMgriAEp9adrM6ZbWi0k0H03CgAKJ2
 cG0BV147K7YZ8wa/BR/Hs/MfcpwYKH6in6ge0+dVdUn3FtcV202ubJJ4/+uF67mY6IHpfDxXU
 /HFMPTayINqZA+BvEe5O3MUxIRmu9nRhTtzIqQcGVfPN0kq9Is=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 29, 2020 at 8:06 AM Anson Huang <Anson.Huang@nxp.com> wrote:
>
> Keep __setup_param() to use same parameters for both built in
> and built as module, it can make the drivers which call it easier
> when the drivers can be built in or built as module.
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

I wonder if we should instead drop the __setup() and __setup_param()
definitions from the #else block here. This was clearly not used anywhere,
and it sounds like any possible user is broken and should be changed to
not use __setup() anyway.

      Arnd
