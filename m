Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7097C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 07:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC41E212CC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 07:21:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727978AbgFRHVM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 03:21:12 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:36211 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbgFRHVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 03:21:11 -0400
Received: from mail-qt1-f181.google.com ([209.85.160.181]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1Mq2vU-1j7pP513qM-00nBZC for <linux-kernel@vger.kernel.org>; Thu, 18 Jun
 2020 09:21:09 +0200
Received: by mail-qt1-f181.google.com with SMTP id v19so1219861qtq.10
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 00:21:09 -0700 (PDT)
X-Gm-Message-State: AOAM532e+QKVC3mrrWSKnlFNQ7oH+KWRV1DYSPkKcqQK8MSIUBSa6D7l
        ugjq8U9n5dEliVAfVJ1abp80i62CvjziJRf/C/U=
X-Google-Smtp-Source: ABdhPJyZwB+YzjDh0fJqM1eWf1KZdD5m3whVUi2LGOR5Rq66DfLtWAExIzP5DMOjDRUJoSdl6RPuwHagBzsvGAhJDHc=
X-Received: by 2002:ac8:7417:: with SMTP id p23mr3048812qtq.204.1592464868127;
 Thu, 18 Jun 2020 00:21:08 -0700 (PDT)
MIME-Version: 1.0
References: <1592369623-10723-1-git-send-email-Anson.Huang@nxp.com>
 <AM6PR04MB49667E1B41DC2A77B3E2FEBF809A0@AM6PR04MB4966.eurprd04.prod.outlook.com>
 <AM6PR0402MB3911B852B49E194E5FE84505F59A0@AM6PR0402MB3911.eurprd04.prod.outlook.com>
 <DB3PR0402MB39167727A8B7CEDAC531D94EF59A0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
In-Reply-To: <DB3PR0402MB39167727A8B7CEDAC531D94EF59A0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 18 Jun 2020 09:20:52 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3zHBRqSg1VeuKcmyQquE7n5wrEViw5KFbDGJNaMjtZRw@mail.gmail.com>
Message-ID: <CAK8P3a3zHBRqSg1VeuKcmyQquE7n5wrEViw5KFbDGJNaMjtZRw@mail.gmail.com>
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
X-Provags-ID: V03:K1:ZyQynNmYvlOC2TyBDj7V1T5SOx7MS8SCgIOcJqy3h4eX4fBoKM8
 Gmxm4y5mEaO1Y3mMSM/AKkJpsq7N8OLwZ76qn6TQbvwgLRQsDDCmPgVxeSo0FUyvKB5ilbQ
 zsa06YWn8GLava34X17UXh0DIa6vwLTLOYOAtzxRA78ipzWDh2W12Vix3gZ/xCovsxddK31
 czcGds9Ycpmcknxsdeqig==
X-UI-Out-Filterresults: notjunk:1;V03:K0:x/gm8/irSGM=:GuMZgqwOvNlvtBUnB/TYXf
 MrP9OOT5XZRu/0YmZkQqWzw9Dy962CiOzQCUh/3ZflrUAg52264hhAraKM6c4llDBJAmKc5fF
 qqItK6Dc1MGDUjT4IlVP+uP2+MCPAjwtH8MHyohzaDeLQiqhQUkueD4l4xuMkPjnDi4+MKJ3o
 t3Po2B23v/LTwbfMhCYNlkdvGUlvK+8SIRdxN7fRbK91Ajzqi/vcNBkq2gUnJnvpVOhTGdbZw
 Odzs7F1A+aRMEWqnYKoHxw05wflnvgdOannPLbODn67yu4ZiS2BJxnrfIpl/LV7zKCXPbTGQn
 kHA6BNOLIsvppeN0iiG6OfjQM4qTp12KsSdtyzeTfbzyw2Aca9GV8D9DlMz4FsJgMf7OqFbcf
 t9MR7suHRdYKQLbP3tfAg0k2wcEeCwlOTMvQx8OZ2TEkEd7JhAESERUJVpJuKA4W6dVeCj7Hw
 fx7yE90sAmZUtRtI3anT0hmGnanTQrT0xm2hU/dA5pOlIhM/f+AK8Hjt1ugHDual8DepkGL85
 gnUvgu3w7t+5rMt0lvGWu8syOEPE19GwLg6gYEl1wytMRScAG6T4BT0Q1OB4NQ4n/PcOvbIvV
 Na6CNIkiF2WNwMlUQc50x+qO7GFHlAtm7EBts7YoE79lfVrwrtdnXvDnDmtUGc/yjAg03jNaF
 3Mcfmdzlin8ZlJ+jRTPhoSEoX72n7U4oHatPthB7jj15GjBzGF4+UbX2jJlRGcQGTQHDMmwai
 PczGpd48oiGdnYvGsjJTbhBsInpO6csa5fTt1TiI+eQgUFfGYT33cQ/5XvjVfl381fKKjJ01D
 TGkTWLPv1la3McnVMfn6o3eIsBO84/szyPkXtnlK5t6TCEeMv0=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 17, 2020 at 11:41 AM Anson Huang <anson.huang@nxp.com> wrote:

> > >
> > > I'm ok with the change. But I'm curious how can this module be
> > > autoloaded without MODULE_DEVICE_TABLE.
> > > Have you tested if it can work?
> > >
> >
> > I ONLY tested the manual insmod, if want to support auto load, may need
> > some more change, will try it later and send out a V2 if needed.
>
> The further check shows that, if want to support auto load, the platform device
> register needs to be done in somewhere else which is built-in (in my test, I move it
> to clk-imx8qxp.c's probe), and also need to add below module alias in this driver,
> because it has no device node in DT and no device table in driver.
>
> +MODULE_ALIAS("platform:imx-scu-soc");
>
> Since this driver has no device node in DT, and the target is to build all SoC specific
> drivers as module, so the best way is to add a virtual device node in DT in order to support
> auto load?

I see that there is indeed a driver for the device node in
drivers/firmware/imx/imx-scu.c,
the only reason for this module using device_initcall() with a manual
platform_device_register_simple() seems to be that we cannot have two
platform drivers bind to the same device node.

I think a cleaner way to handle this would be to just move the entire soc
driver into the firmware driver and then remove the duplication.

       Arnd
