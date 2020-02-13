Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91D58C3B188
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 09:51:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EE7D20848
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 09:51:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729786AbgBMJvX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 04:51:23 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:43461 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729440AbgBMJvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 04:51:22 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1j2B9U-0004Bt-BY; Thu, 13 Feb 2020 10:51:20 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1j2B9T-0002gj-H2; Thu, 13 Feb 2020 10:51:19 +0100
Date:   Thu, 13 Feb 2020 10:51:19 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] ARM: dts: imx6sx: Add missing uart mux function
Message-ID: <20200213095119.f6obrdqb6ql76qqy@pengutronix.de>
References: <1581576189-20490-1-git-send-email-Anson.Huang@nxp.com>
 <20200213072710.4snwbo3i7vfbroqy@pengutronix.de>
 <DB3PR0402MB39163A56BF6AA37E3C691964F51A0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DB3PR0402MB39163A56BF6AA37E3C691964F51A0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Anson,

On Thu, Feb 13, 2020 at 09:18:10AM +0000, Anson Huang wrote:
> > On Thu, Feb 13, 2020 at 02:43:09PM +0800, Anson Huang wrote:
> > > From: Anson Huang <b20788@freescale.com>
> > >
> > > Update i.MX6SX pinfunc header to add uart mux function.
> > 
> > I'm aware you add the macros in a consistent way to the already existing
> > stuff. Still I think there is something to improve here. We now have
> > definitions like:
> > 
> > 	MX6SX_PAD_GPIO1_IO06__UART1_RTS_B
> > 	MX6SX_PAD_GPIO1_IO06__UART1_CTS_B
> > 
> > 	MX6SX_PAD_GPIO1_IO07__UART1_CTS_B
> > 	MX6SX_PAD_GPIO1_IO07__UART1_RTS_B
> > 
> > where (ignoring other pins that could be used) only the following
> > combinations are valid:
> > 
> > 	MX6SX_PAD_GPIO1_IO04__UART1_TX
> > 	MX6SX_PAD_GPIO1_IO05__UART1_RX
> > 	MX6SX_PAD_GPIO1_IO06__UART1_RTS_B
> > 	MX6SX_PAD_GPIO1_IO07__UART1_CTS_B
> > 
> > (in DCE mode) and
> > 
> > 	MX6SX_PAD_GPIO1_IO04__UART1_RX
> > 	MX6SX_PAD_GPIO1_IO05__UART1_TX
> > 	MX6SX_PAD_GPIO1_IO06__UART1_CTS_B
> > 	MX6SX_PAD_GPIO1_IO07__UART1_RTS_B
> > 
> > (in DTE mode).
> 
> Is it possible the using below combination, if possible, then I think the prefix "DTE/DCE" are
> NOT impacting real functions, they are just different names for better identification:
> 
> MX6SX_PAD_GPIO1_IO04__UART1_TX
> MX6SX_PAD_GPIO1_IO05__UART1_RX
> MX6SX_PAD_GPIO1_IO06__UART1_CTS_B
> MX6SX_PAD_GPIO1_IO07__UART1_RTS_B

This is wrong according to my experience. If you look at the diagram in
the i.MX6SX RM in the External Signals chapter (page 4111 in the
IMX6SXRM Rev. 2, 9/2017) you can only either use RX/TX and RTS/CTS for
their original purpose, or swap both pairs together.

> > For i.MX6SLL, i.MX6UL, imx6ULL and i.MX7 the naming convention is saner, a
> > typical definition there is:
> > 
> > 	MX7D_PAD_LPSR_GPIO1_IO04__UART5_DTE_RTS
> > 
> > where the name includes DTE and where is it (more) obvious that this cannot
> > be combined with
> > 
> > 	MX7D_PAD_LPSR_GPIO1_IO07__UART5_DCE_TX
> > 
> > .
> > 
> > I suggest to adapt the latter naming convention also for the other i.MX
> > pinfunc headers, probably with introducing defines for not breaking existing
> > dts files.
> 
> If to improve the name, just change the existing dts files which use them should be OK,
> as this header file ONLY used by DT and should be no compatible issues. So should I
> change the dts files together?

My approach would be one patch for each of:

 - rename existing imx6sx symbols to contain DTE or DCE
   (introducing defines that map the old name to the new)

 - introduce the new defines you added in your patch under discussion
   here (with the new naming scheme obviously)

 - switch all in-tree consumers to the new names
   (maybe offering to split per machine)

I would also drop the _B suffix in the first patch which serves no
useful purpose.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
