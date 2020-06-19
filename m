Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7363DC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 12:09:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 585452083B
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 12:09:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730721AbgFSMJh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 08:09:37 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:42165 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727074AbgFSMJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 08:09:35 -0400
Received: from mail-qt1-f179.google.com ([209.85.160.179]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1M3DeV-1jjE5z29Of-003aNF for <linux-kernel@vger.kernel.org>; Fri, 19 Jun
 2020 14:09:34 +0200
Received: by mail-qt1-f179.google.com with SMTP id e16so6972584qtg.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 05:09:34 -0700 (PDT)
X-Gm-Message-State: AOAM530o/TjpGfNnAsRSA5Cd0y1FN1Se4HlxlrF/eNOAVMvjg7IxdXg8
        jNgNqTH/o5bKitY077myE9SO3jgmmuF4Hu27qOs=
X-Google-Smtp-Source: ABdhPJxA0xAoTTK83uVN3FDnLwdbtZgW7ukPPu7FTx6JnhSlyVPHYpyZqYx5kttP3YZlWw/HjwTmkIUAT2zUBrSAWJU=
X-Received: by 2002:ac8:7417:: with SMTP id p23mr3002032qtq.204.1592568573384;
 Fri, 19 Jun 2020 05:09:33 -0700 (PDT)
MIME-Version: 1.0
References: <1592369623-10723-1-git-send-email-Anson.Huang@nxp.com>
 <AM6PR04MB49667E1B41DC2A77B3E2FEBF809A0@AM6PR04MB4966.eurprd04.prod.outlook.com>
 <AM6PR0402MB3911B852B49E194E5FE84505F59A0@AM6PR0402MB3911.eurprd04.prod.outlook.com>
 <DB3PR0402MB39167727A8B7CEDAC531D94EF59A0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <CAK8P3a3zHBRqSg1VeuKcmyQquE7n5wrEViw5KFbDGJNaMjtZRw@mail.gmail.com>
 <AM6PR04MB496696A8695FA85D1EEE276B80980@AM6PR04MB4966.eurprd04.prod.outlook.com>
 <DB3PR0402MB3916B7B5E730E2D2B93C5ECCF5980@DB3PR0402MB3916.eurprd04.prod.outlook.com>
In-Reply-To: <DB3PR0402MB3916B7B5E730E2D2B93C5ECCF5980@DB3PR0402MB3916.eurprd04.prod.outlook.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 19 Jun 2020 14:09:15 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3AnZ3LpYmeerHQUWNWE4iT6Zn=QAiuJb2Crz02Pc4kAg@mail.gmail.com>
Message-ID: <CAK8P3a3AnZ3LpYmeerHQUWNWE4iT6Zn=QAiuJb2Crz02Pc4kAg@mail.gmail.com>
Subject: Re: [PATCH] soc: imx-scu: Support module build
To:     Anson Huang <anson.huang@nxp.com>
Cc:     Aisheng Dong <aisheng.dong@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Peng Fan <peng.fan@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "krzk@kernel.org" <krzk@kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:jl/lT1XI87C/+ifYXhg/52Hr7i4i5c1nDgolYvu1U/DOCiSY1Wu
 56yxmljRi5Y36yryDX7kF0kD4st9wXiPUV4VedCMCs2GGI5LTPcMlNL81e3I+cAwfXKvdXK
 WTcJoi1+mWNnAVQ3fAvDxhU/aIMGNEOgsA3NgR9L+zF25+K+PNqbLBTVyfKmsXLuvtZ9v/M
 JcJBx+t9QxKdurVIBtI4A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:l5O1qcmzP18=:sP3yiUzvTWspeFuNvthZnz
 eRPCFITOjNCUxcJvjJKeHcGjAKsVmI29xJTDn5nEKjB5FsqMKEO1OOUhQY0vhhDBbFFSYjZoD
 r3fr80thR9CY0NqrDFDCah1UvXc1PLpgT/cRTPzZLVbtb7t/ialI5VuiS2jFlxXm9933O4fru
 W9//+vIKYnPxOxM4kjvnhCPEwBslbuvndwoK5M8LHDNvjeGrdTvH7Di3EPbvHh4QNh7XM7kfL
 VqZjY1nVJHxM/b+stOesWZ8fqLSbs7KNvEogIxJMgOaVLU2YoqCkMzla9HJ9PDmPDt+tlzGle
 LK6YYUt8eoOVqfeBKN92/92+TJ1bO6vUHvITO4FU0ltTGX4djh4QLLNG5wm9Py4NSEr2F2VaY
 A+I9SKzdUfT/6X74L1ZYgEEsSkuKE1C3eco6HL5iyP1gZiU8eZuD08Fyy1y7Ws6ALIUeDW2kT
 Y2IJa8e673l3AJCs1MAmwDI/2iKFARY/3ZuEL8541Wo98rwCgfPmWXO30SPo8tEXUImzPKejZ
 1L6gfpxNvMsdL+HqUUjGog+nGFll+VG7uWs1i7Gm99PD9dfRr3nCicxG51FAetaPqjJ4Q9j15
 JzL9X0VzHU9i32M93oeLmmv/988Lj2bG4Dl9ExzcnezrHNa8poz9o1AZMdzJpLKw+RgBB17Xc
 zapZBM9M7I5ddJBL7uLOWbiJL/rE+JJ45le3i8fMkSEncqt+GTLKucnM+hrPETkwQpJcftcOP
 ICYCfHAx9HgFhSF36wiQ8HB+MkAVaybSIO6mGIuvZRIR9NyRafF6bepQTJZ7/Q+k7BeHU8CeB
 DJcmg0bscrtt9Q5prGcgP2r8HDhdivbwK1rmoGEZbu7ifGJEaU=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 19, 2020 at 9:40 AM Anson Huang <anson.huang@nxp.com> wrote:
> > Subject: RE: [PATCH] soc: imx-scu: Support module build
> >
> > > From: Arnd Bergmann <arnd@arndb.de> Sent: Thursday, June 18, 2020 3:21 PM
> > > I see that there is indeed a driver for the device node in
> > > drivers/firmware/imx/imx-scu.c, the only reason for this module using
> > > device_initcall() with a manual
> > > platform_device_register_simple() seems to be that we cannot have two
> > > platform drivers bind to the same device node.
> > >
> > > I think a cleaner way to handle this would be to just move the entire
> > > soc driver into the firmware driver and then remove the duplication.
> > >
> >
> > Yes, sounds like a good idea to me.
>
> So the idea is to remove this driver and implement the soc id/revision/serial_number etc.
> in drivers/firmware/imx/imx-scu.c, right?

Yes, I think you can basically merge imx_scu_soc_probe() into imx_scu_probe()
or call it from there, with only a few changes.

      Arnd
