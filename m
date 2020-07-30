Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12326C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 07:25:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9F7A20809
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 07:25:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728943AbgG3HZw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 03:25:52 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:37009 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728891AbgG3HZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 03:25:52 -0400
Received: from mail-qv1-f53.google.com ([209.85.219.53]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MD9Kp-1jsUE31pDt-00959j; Thu, 30 Jul 2020 09:25:50 +0200
Received: by mail-qv1-f53.google.com with SMTP id a19so6086533qvy.3;
        Thu, 30 Jul 2020 00:25:50 -0700 (PDT)
X-Gm-Message-State: AOAM533aIqEn2mpnxT+wj8g9dJqz/zbFTaNhs+MKrKoOFGaRPIAYkQk3
        Xg6PLah6aeoYg5L0pCIF2JiKMRGs8E8KFXeLOz0=
X-Google-Smtp-Source: ABdhPJxo0B56G4g8c9U5UEFN/6NIHD+B8GlCDLd3ue8LWoLl/ZDumtskrygHT6FtHJpCZOT2NM8BwvtBIs7ABsj/erQ=
X-Received: by 2002:a0c:b5c2:: with SMTP id o2mr1540145qvf.210.1596093949221;
 Thu, 30 Jul 2020 00:25:49 -0700 (PDT)
MIME-Version: 1.0
References: <1596034117-24246-1-git-send-email-Anson.Huang@nxp.com>
 <1596034117-24246-2-git-send-email-Anson.Huang@nxp.com> <86ae1d4e-27c9-07e4-73be-37d490cb0063@infradead.org>
 <DB3PR0402MB3916559F7E1908D76B47FE66F5700@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <34161e5c-0e83-97de-3cb6-1040d8abdc71@infradead.org> <DB3PR0402MB3916E18C8B36010D60086EA2F5710@DB3PR0402MB3916.eurprd04.prod.outlook.com>
In-Reply-To: <DB3PR0402MB3916E18C8B36010D60086EA2F5710@DB3PR0402MB3916.eurprd04.prod.outlook.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 30 Jul 2020 09:25:32 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0nOWHFr42K0maoXVxsLnasuYXGy0z68JoCbEzADOC6kA@mail.gmail.com>
Message-ID: <CAK8P3a0nOWHFr42K0maoXVxsLnasuYXGy0z68JoCbEzADOC6kA@mail.gmail.com>
Subject: Re: [PATCH V7 1/6] clk: imx6sl: Use BIT(x) to avoid shifting signed
 32-bit value by 31 bits
To:     Anson Huang <anson.huang@nxp.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Peng Fan <peng.fan@nxp.com>, Abel Vesa <abel.vesa@nxp.com>,
        Andy Duan <fugang.duan@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "yuehaibing@huawei.com" <yuehaibing@huawei.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:TAaq4YmSI4FU3F8/B28S4g5SJrjn2jR1x/gJRJCjQinhufa2MP4
 cWSxat9Td7fm9KccJrxej8NrNXWcStCmgtJx7GyS0ubbJEVIH8CtEjjm/Cj2zpYbxsaHHL5
 PaFpwlXgX0U2udf8VBzIOet+4ffsRrm/59BuT6dBasFF1CqJwsgMsYskEshkKvQifWddoCs
 inYM16nfVTQsBZgXz5Lag==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2HoLvJI1isM=:WRrah1Zx0obHqCk092nmim
 mNmU1GU4Vimj0N2pXtF/jl5lYr45PwQjF/MRsOmB1ZW9OsnF3Ty59uNHJFRaaYyYoQwb8PieQ
 JQzaDhJNFZqOrdLIHQ3T7eu8ndcuWiSbfsk8NIOJAbwmPwC/CLczDdXu6h3zfqAcrTmvQ1ddX
 T63bo6gN/O01Wa3rRib594DDmNVdtN4TQFeSTVvpYamtcXFTm4DzD5/x/jlTnFx8ckrW0rIRN
 5uVqF5TrCMGsimBnjUTMaUK9PN7wFeN+fHof0eCCDluzegxmNm6duTbpyfegIBP0lblV3Llx2
 QfstSMemJoJ2oK41lE9lBrVE6cnxK8Lz20lwxl4P633ghC9Wc9WVEZaBduLaQ5mAnL1W7x5r4
 n0aUhTHPBUej8N5on/Q06OrwUDoodhhoyUN5KMouJ+Sw4pYY0kAG1w+lKAwexNxlAoBoRrXzx
 AUUKHVyiia+TiEJTzV7HxqfYrddkEvHM/JNNQi0JPk/S5X1khFlNto7FdbiGuQF8Ubt0UitXU
 8jEhxyrIgEkG1iuHpn2wRJsbE061soFMPvkxfZkkEI1ehYxlYcKZ8CuaKUeEK1WBXkfQibFEy
 9dj3S9zWelr9icMANdfsGTYGnnOGjmdLi9chsWH78SmLoAJ9s+wqaeQIRXQKFtWRiABeVHg0L
 tiqGfxsiavrWrdS4tQ8CZEDzTezyE/jkB5pMpUUBE10R97FW3gcgsmGbYIetG6fvUilUerUGN
 l+Jfx/ruyDgrTCrXoztW4vfGkbWfL8/sqMFl4DB5j5N+5EoUve1smlu1XYHNdbE/Ih9GfPhFU
 aeUHwE0QxpBGbLkXMN+nTVvYIsQFPLOt7FPLLcHsVY4wPTGOBPNGWX4TRI220ufPZuBL7m/4O
 Yq1iywJ/qJ2jwY9BMdw/miruyiA71HUrxAsJNeLL6qDe858i7sChf4RrdSL2wS03hDiTkBIM/
 R22JQEG1G6GFRJ5nKrWL8RUTAVRXOgY94M7X4KXGSQTLglVsAxlv3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 30, 2020 at 3:14 AM Anson Huang <anson.huang@nxp.com> wrote:
> > Subject: Re: [PATCH V7 1/6] clk: imx6sl: Use BIT(x) to avoid shifting signed
> > 32-bit value by 31 bits

> > or you could read Documentation/process/submit-checklist.rst,
> > where rule #1 says:
> >
> > 1) If you use a facility then #include the file that defines/declares
> >    that facility.  Don't depend on other header files pulling in ones
> >    that you use.
>
> Understood, while I search "BIT()" in clk driver, most of the drivers does NOT include
> linux/bits.h even they use it.
>
> But OK, I will send V9 to include it.

Ok, good.

I have a patch series that adds it to a lot of files. Note that linux/bitops.h
itself is a fairly big header with everything else that it includes, and it
is included almost everywhere indirectly.  When we change the other
headers to not require linux/bitops.h any more, everything that uses BIT()
needs to include linux/bits.h.

     Arnd
