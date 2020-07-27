Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BEE4C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 20:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6547320759
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 20:12:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729085AbgG0UMI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 16:12:08 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:56261 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbgG0UMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 16:12:08 -0400
Received: from mail-qk1-f177.google.com ([209.85.222.177]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MRnTQ-1kNqVY1dFq-00TDuV; Mon, 27 Jul 2020 22:12:06 +0200
Received: by mail-qk1-f177.google.com with SMTP id 11so16561764qkn.2;
        Mon, 27 Jul 2020 13:12:06 -0700 (PDT)
X-Gm-Message-State: AOAM532eTDT/WyF5SgwCHoSWxf5bRERH0BS9WOpmp2JnnL7oESawzEro
        DNU+y2Jo3WkfDDbibqr7rtWubvojaRfAWkrC91Y=
X-Google-Smtp-Source: ABdhPJwl8pJMM4Hd65/Ot3xFOpQaYa5B7rSGHYgIGEgDAywOJdEUK0itmnQY8BcVNrSOqpiK6dkmg90FsvQP5ZU4PpU=
X-Received: by 2002:a37:b942:: with SMTP id j63mr10888732qkf.138.1595880725136;
 Mon, 27 Jul 2020 13:12:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200727112236.8199-1-lars.povlsen@microchip.com>
 <CAK8P3a3WJTKH7-KGgp7CuhZv_wtrtY1k+1LEL-62_Rj+wqbrGQ@mail.gmail.com> <159587873833.1360974.11729154337431621644@swboyd.mtv.corp.google.com>
In-Reply-To: <159587873833.1360974.11729154337431621644@swboyd.mtv.corp.google.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 27 Jul 2020 22:11:49 +0200
X-Gmail-Original-Message-ID: <CAK8P3a27u7UkjGJ32KsRp02FoF34mKW0gRUsms0+YBkxy+L4Gg@mail.gmail.com>
Message-ID: <CAK8P3a27u7UkjGJ32KsRp02FoF34mKW0gRUsms0+YBkxy+L4Gg@mail.gmail.com>
Subject: Re: [PATCH linux-next] clk: sparx5: Review changes
To:     Stephen Boyd <sboyd@kernel.org>
List-Id: <soc.lore.kernel.org>
Cc:     Lars Povlsen <lars.povlsen@microchip.com>,
        SoC Team <soc@kernel.org>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:JsoTw7nq0jS9T6T0VF5vsItTYUjCtq8Aiu+4lB2D8Olr7HlGHwL
 YdpR3t+vcPB0MpFzVcZFZhljq+3VEAUSsSvImplIOIH/t6ehmTiUzqJ6vEl8dRMhUua45dT
 ZMfNfCIEbi1qmmodL9UbIDBtq2DJKSmaCG/i1ehhEoFV0Xb/LRqmWDDBPpYbG5kVpyYIr3L
 xcUnhc3WaeWr8ebFIvM5w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:scJ9a76fXE4=:UAUCSqfQqD4d8w5uElORay
 oDzsDhRIuA+/qKrJ2l+ePaFbRlaFFGCgt/EyospWkLhQrJkVqTcT0BXHUvzfh5/Unq1bExuKe
 Gs63zPjxdYGvbDchfYOcXDbS1Y2L+bWL3f4GWookRwSRWYLqDVykRThlKdcCP7w2+HEGKldcz
 b2RMGhD/Qvsind/XUz8NxU99iA7HhwYPaSgzY+65vK+AN3Y52jc31nXXLvB78s0LSipeL9lDk
 hj4SM8j3urnSFkCmArDRA6KAaggyu2HbfCnA+138ySGosHJ9TAoDxfQzpWydZy2TgMvhaJX8H
 ygC3o/PwxFKRpJZnuUWUp3tvoT5x7Kz6zG+I1rM75iMljuJmBvOlYOwBKjo+g1Vmlwsnv8Nph
 RRsck4DH3EimSyLckrp02GxUeowAwvhmQsud/+kfNqU/xZbG8CU7sTrZ9p+WaYmBHhXCSP1Va
 gksyJ9gWaYyW6p7dcCDugYamqpMvTgzacUh1r6Od/KM2OAkjdxrNVgyEQXkLhtcHXsmQxDpXG
 /tlBsdDvCSreuEXaf/vJHI9BDwbMaFdtvCmnS/ZZVAXwkrAiKYJW0Q6JIS6y/p8qcDKAwIBmb
 q9+waXLqK/OAqWTDUExXyNd/P3lOet4xLb93OR/yCzXb2aSSwbgTPNXmKiuAfyL7hwCaHB7oS
 OEiWiorhh/RZpnwSeQqdH89KA/uun8hUlg4M4wYqJqfG/FS44ozR4LRLyV6x4QZupP6jH6FHN
 TqMCKKxffx+ebv8UbPexcKKnJywoPN//WwNe1lKgydqVLB5kOSgIh5HnUxB3CojyPhA/8NRpA
 XtOMB5a2MUo14/rGPV4qrpikrIziOp2WlFTGHAy4OZJAYBa+OOtX7bqb9CzCFoNmHUy/koZII
 dQVHnVA34Ojeo7ohBVG780Fed6hCJRkBmJ+nIb5a6EnadHPQa4e0/2FwlHrcCAnEIJS60dpWY
 p9GZPZsmNL1XZcoMnT1bNbIHHupXhZdv78+GUpghjbRqVVKVXdIdx
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 27, 2020 at 9:39 PM Stephen Boyd <sboyd@kernel.org> wrote:
> Quoting Arnd Bergmann (2020-07-27 05:02:56)
> > On Mon, Jul 27, 2020 at 1:22 PM Lars Povlsen <lars.povlsen@microchip.com> wrote:
> > >
> > > This address the review comments for the sparx5 clk driver from Stephen
> > > Boyd <sboyd@kernel.org>:
> > >
> > >  - Remove unused include of of_address.h
> > >  - Remove unused member in s5_hw_clk struct
> > >  - Changed type (to unsigned long) for freq in s5_pll_conf struct
> > >  - Use .parent_data instead of looking up parent name
> > >  - Use devm_of_clk_add_hw_provider
> > >  - Some minor comsmetics
> > >
> > > The patch is intended for linux-next (incremental), as the original
> > > driver was already merged.
> > >
> > > Signed-off-by: Lars Povlsen <lars.povlsen@microchip.com>
> >
> > Hi Lars, thank you for addressing these!
> >
> > Generally speaking, you should avoid having patches that list a
> > number of unrelated things that are done by a single commit.
> >
> > Splitting this up into six patches is probably a little too much,
> > but maybe you can find a better balance. What I'd like to see
> > is to split the purely cosmetic changes from those that might
> > actually change the behavior, and then for each patch that
> > changes something non-obvious, explain why this was done.
> >
>
> Why was the clk driver merged to linux-next outside of the clk tree? Was
> there some sort of dependency?

I merged the entire series of the base platform support along with
a few core drivers. I had asked for the series to be submitted to
soc@kernel.org after all parts had been reviewed, but I missed that
the clk driver was still missing maintainer review (I saw you had
reviewed some patches, but apparently that was just the binding,
not the driver).

I rebased the 'arm/newsoc' branch the other day to fix another mistake,
so if you prefer, I can rebase it again and drop the clk driver or
all the sparx5 patches.

       Arnd
