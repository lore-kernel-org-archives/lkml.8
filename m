Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08D67C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 16:44:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8F0A2070A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 16:44:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390421AbgAXQou (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 11:44:50 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:34419 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388149AbgAXQot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 11:44:49 -0500
Received: from mail-qv1-f42.google.com ([209.85.219.42]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1M42zo-1iv24d2g1g-0007eb for <linux-kernel@vger.kernel.org>; Fri, 24 Jan
 2020 17:44:47 +0100
Received: by mail-qv1-f42.google.com with SMTP id dp13so1196585qvb.7
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jan 2020 08:44:47 -0800 (PST)
X-Gm-Message-State: APjAAAVYSHHm0rKFRCgTQG9sv9cAm+epx3Uu4g4aBntl3NPp6xZwqHlT
        aDO++NcFOWR74SKa57HJYNGjML+9bfsxYqASoZg=
X-Google-Smtp-Source: APXvYqzFQ1FtUSG9wkimTmxteMnVFvr9Gz1AZVLyLtQ0jTyI+0DlAmS2jcwdJ/giEZ8tJzV4iznRbrDorlKqP0K6C+c=
X-Received: by 2002:a0c:8e08:: with SMTP id v8mr3741766qvb.4.1579884286531;
 Fri, 24 Jan 2020 08:44:46 -0800 (PST)
MIME-Version: 1.0
References: <1578989048-10162-1-git-send-email-peng.fan@nxp.com>
 <20200114081751.3wjbbnaem7lbnn3v@pengutronix.de> <AM0PR04MB4481A2FB7E2C56C2386297E888340@AM0PR04MB4481.eurprd04.prod.outlook.com>
 <CAK8P3a3x55A8y9kR34zy8YyRhto8uay7PZGbDAufupiNS3+ihA@mail.gmail.com>
 <AM0PR04MB44813A1D55659658E3FA203188370@AM0PR04MB4481.eurprd04.prod.outlook.com>
 <CAK8P3a29=KWrhO8uu7mMS2gbeCGpkL7Q-xaaUVO2wcVD9MN93g@mail.gmail.com> <CAHCN7xKtfKVQeaAg9sjvc3cHjLoAqAX6F-JyvkG5u23w1OG8CA@mail.gmail.com>
In-Reply-To: <CAHCN7xKtfKVQeaAg9sjvc3cHjLoAqAX6F-JyvkG5u23w1OG8CA@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 24 Jan 2020 17:44:30 +0100
X-Gmail-Original-Message-ID: <CAK8P3a19FPc_=RK3_NthZEhryx6t1PmFvj2h_Gzo2M2rJEehhg@mail.gmail.com>
Message-ID: <CAK8P3a19FPc_=RK3_NthZEhryx6t1PmFvj2h_Gzo2M2rJEehhg@mail.gmail.com>
Subject: Re: [PATCH] soc: imx: Makefile: only build soc-imx8 when CONFIG_ARM64
To:     Adam Ford <aford173@gmail.com>
Cc:     Peng Fan <peng.fan@nxp.com>, Abel Vesa <abel.vesa@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:aZ8+IY535Qz09L1Pe9qksn7zMhv31SOa0t1GTq28E7+GW/2giM0
 LxVwCmmgMAa75dcqIVyN62n2g0uPqjmW+qOOca+O3mBGB779SGz5exD9g4Y2RK0gh2R8XqD
 UWX+veNuHrJmTUVDuWmqveEMV3OalSDmP864IFtjLABsaMv61ViTNCvRXwANYkKPLxNSd+1
 EQy36gjTNEnLsiCnRcqWw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vQ85UnL42NY=:AOQHpmVd3VBc5oQIkDSW4p
 NcpdWHb4U3ZlZQHuJPoxd4mzi3ijtjwoISDOVwXBg4ivq1RhLT4COkbYKxsrI/1PFKq3jtNvN
 un5MLp68zAuUf250HVNzBcMNkYw/B0iqbYtVBCSOHn4yc6O3OmqM6t251qAM4EtD/1hBUQFmt
 15rEy2O5YTJaP8nzLM26skTZZ5LgA9pt5LuCRTGGModVAxPi0t4B1+tS3flrUBuDI6agoazpQ
 srRggeA6oTIVB2sVRmG1XTn2sBWfiudlGt3iycSLaesqHdAoNCqApbYKgpXfazRQD+Vc+a/NI
 vEBrySzmTHg6YSRp5sFzF702RkFHeVjMjE/cH67CA2ey36j7mQpBoqq8aV4z6u/BpN95ZvyY1
 0PkGMu0uq7DrRzhtjFSalYky6AjRc4eLL9IZrvCy7HSe3Kh4CoszjSdIQ9HmvpeRjy9bZlBJH
 D9etvoGsIBuuMT987eQJrNarxDOLEH6/rBE7AuUVFXelzRMspZzupMbHvHnhR8RwdP7La8PIs
 x3Yx8Fmz3EX68OomrnyJgFOTn+UVUdZ8Rj6N8c9JGsS9AJ92B3ZbejsOIMonBaWSxk7pj9gqT
 dgqzbihgu0LvYz6Dz0v9TRTrerviR8ib2sGlp2dLdKeQbDxhM53ULY4DBkx0cBZyPhog8zYlb
 cAse9v+A+8y/NpnTVsVey1kZAeTAMJm7O6vZpXIQKjvNN9Zv8hMFNOwmsIrIKJK5vVCAcTAkT
 B4QdYtP3Up4zgHZ23aBdKXG2GmpewXOy8h5D/v0z855RxFjOogt2xomInU3KGtvPwcZ1vJdel
 S5D1VtAyBJOnxy42stcSl63x+J6P5c2rFQnwXnnO0MdXq9b05M=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 24, 2020 at 4:54 PM Adam Ford <aford173@gmail.com> wrote:
> On Wed, Jan 15, 2020 at 4:39 AM Arnd Bergmann <arnd@arndb.de> wrote:
> > On Wed, Jan 15, 2020 at 3:38 AM Peng Fan <peng.fan@nxp.com> wrote:
>
> I would be interested in learning more about running the i.MX8M in
> 32-bit mode.  I'm looking at running Linux on a device with < 1GB of
> RAM, so having 32-bit pointers and instructions would be preferred.
> My preference would be to run as ARMv7 for migration purposes, but I'm
> open to alternatives.
>
> Does anyone have any suggestions on where I might find some generic
> stuff for either iMX8M or generic ARMv8 docs for doing something like
> this?

By far the easiest way is to just run a 64-bit kernel and 32-bit user space,
which should give you 90% of the space savings. This requires no further
work, just pick the 32-bit distro of your choice.

The get the last few percent of memory savings and run a 64-bit kernel,
at least a bit of porting effort should be needed. In principle you should
be able to pass the dtb file for your machine to a 32-bit kernel, but
all drivers have to be there and you need to adjust a few dependencies
to allow 32-bit builds such as

 config CLK_IMX8MM
         bool "IMX8MM CCM Clock Driver"
-        depends on ARCH_MXC && ARM64
+       depends on ARCH_MXC && ARM64
         help
             Build the driver for i.MX8MM CCM Clock Driver

and then there will likely be a few bugs.

      Arnd
