Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E23DAC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:09:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDDB220775
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:09:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390235AbgF2VJl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:09:41 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:34015 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390473AbgF2VJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 17:09:28 -0400
Received: from mail-qk1-f175.google.com ([209.85.222.175]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1M4s8v-1jrFTq3scJ-001xiw for <linux-kernel@vger.kernel.org>; Mon, 29 Jun
 2020 13:41:46 +0200
Received: by mail-qk1-f175.google.com with SMTP id e11so14907359qkm.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 04:41:45 -0700 (PDT)
X-Gm-Message-State: AOAM530sasEil8ERRVXJh5zFKP1CdrVns+7gvM+HvUKJIpZdPyYxNSib
        bX128uWEDQ9oUqMRrgwIQpYpOk2AWicmkyr1piM=
X-Google-Smtp-Source: ABdhPJyLhYoeBgzSA7MmAOwFTB9Sh+/zmsg8s7//3A8nJfIgT+w1yf4DFF1bfEfMRnermkkMST/HbKNPG8frHLqR+GA=
X-Received: by 2002:a37:a496:: with SMTP id n144mr14552649qke.286.1593430904740;
 Mon, 29 Jun 2020 04:41:44 -0700 (PDT)
MIME-Version: 1.0
References: <1593425623-31810-1-git-send-email-Anson.Huang@nxp.com>
 <CAK8P3a1pr8YbZMpSXg6o_UeDvaU=dDqfo45DudTASNcsxeg3kg@mail.gmail.com>
 <DB3PR0402MB3916292FC3FDE4F28AFEB5EBF56E0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <CAK8P3a0Za99-xXTwtHNHO-Dzbo-1uesNC2oO91RA-gZZG3Anmw@mail.gmail.com> <DB3PR0402MB3916ADD54CB167B8ED10076DF56E0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
In-Reply-To: <DB3PR0402MB3916ADD54CB167B8ED10076DF56E0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 29 Jun 2020 13:41:28 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1mCD1JFg80HSos9hp0ye1vu_hk79wFGz6YZ3kj10XACg@mail.gmail.com>
Message-ID: <CAK8P3a1mCD1JFg80HSos9hp0ye1vu_hk79wFGz6YZ3kj10XACg@mail.gmail.com>
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
X-Provags-ID: V03:K1:33+CLiKFpT3UwZb3REktnSgLhRP+TGYP0n/qx2LjY7hgPxhJAs2
 Pp3vKZfLmKdVlv+ITRF0uFDiLRTXRwl/S6xx4y3v6eO0JktCgeYJBybd/CXHT6FsSFW9H8h
 Bxsk6XNBAa2NWgPMZCWr4X93/t2P2qwqlwlZfCt+0u7l5uI6jYVF/f2QTfDf1KtoX7do+qT
 CE32p7T+OInySAmP7P0vA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:14PJPh03Tpw=:+oF22SLQQmREumaoa5GRLe
 4qt78LSb+I/Xqs07uVD8KMw2x8Q9lrkZOTXyhWInIAEG8ai6/mnvRlAFDknTG6LdYoTOdhk/5
 4Kv6KmQfv1gd9UD7bIizWAX5l3Xm9bPnzJ17i3bXrgqUNsHWm1oJz9ue8J9cdWbr1XQ3xfK66
 9LaSJHYtTsugrjnHiOknqk1lsrVHfm5auPX73WoP/84xX7ARhxU+gFjAFaD5H19+Jy8HfxfaA
 /sGBexzMi0MKOXmvzOFrD4T9cghzSlf2H0hm+IdhIol+13o4dKyrs3HJIuaBuxwTdvzu63gRR
 1NWOpLloDJUBKRPmnUbbk3ctIM+n7GJBO1kaXNni9hKDpM24zd5Y1OS0vUUiqfSYzQQaHZDZ6
 hV4Cp3VhWJy88nGRKqSaKnpXS6qkirLUZoXlSKNRnU6SL76gzn4rtg4JXFx1ttgh9Z3mMt7dk
 SF9WAy6M8mV+jbt3WZTD9eTKuYexIydpOVv6aoIMy4cpsdABUnfA7lp7CescAeORTWwgF6+SV
 8mZoS9P43BLiXT0WdHt6gGfYOYYKVw1CTChk6svkUkWH9gFccR3llF/TRQOICrRyGpMqX+HLm
 tzFvXXQqmAQUfYuFszPq1Kqv8OyZpJ3sKt9HZWy+jDaKfjJwRDZ2AxfjUlVbjH3IdZo0DA1RC
 4V33ebPOw4UVYvutowfV6L4mMiYkaTa2Kd5t6GeeD+JjCLRU+1O8/a0mbOZLaBVdWue4vqOil
 u1ZPZ3ujUt0s/9QYIaT8WJqz+CNqP3gsWXvDBo0ud+rZ55o4mK/JfqXuccth3K4dA8i5w8+9b
 qJdlRdN4nqZNEz6GFC7rEf355pdqV9WnRAFg10DWOg7C/Lf3gs=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 29, 2020 at 1:32 PM Anson Huang <anson.huang@nxp.com> wrote:
> > Subject: Re: [PATCH 1/3] reset: imx7: Support module build
> >
> > On Mon, Jun 29, 2020 at 12:45 PM Anson Huang <anson.huang@nxp.com>
> > wrote:
> > > > Subject: Re: [PATCH 1/3] reset: imx7: Support module build On Mon,
> > > > Jun 29, 2020 at 12:25 PM Anson Huang <Anson.Huang@nxp.com> wrote:
> > >
> > > The reset driver normally won't be removed since it is necessary for
> > > drivers which need it, it is just for Android GKI support, in this
> > > case, do we need to change it to module_platform_driver()?
> >
> > Please at least try to do it, or explain in the changelog what went wrong if it
> > doesn't work.
> >
> > I don't think "because Android GKI" should ever be the sole justification for a
> > patch. Making drivers loadable module is a good idea regardless of GKI, and if
> > you do that, then make it behave like any other loadable module.
> >
>
> OK, will do it in V2, BTW, I think there is nothing need to be done for .remove() callback,
> can I just skip it or need to add a blank callback anyway?

I think if everything is done through devm_() calls you should be able to
have no .remove() callback at all, but I have not tried that.

     Arnd
