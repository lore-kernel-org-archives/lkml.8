Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0059C3B189
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 07:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EFB62073C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 07:27:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729861AbgBMH1T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 02:27:19 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:40163 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729735AbgBMH1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 02:27:18 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1j28u0-0005XO-CY; Thu, 13 Feb 2020 08:27:12 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1j28ty-0007vn-A1; Thu, 13 Feb 2020 08:27:10 +0100
Date:   Thu, 13 Feb 2020 08:27:10 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH] ARM: dts: imx6sx: Add missing uart mux function
Message-ID: <20200213072710.4snwbo3i7vfbroqy@pengutronix.de>
References: <1581576189-20490-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1581576189-20490-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 13, 2020 at 02:43:09PM +0800, Anson Huang wrote:
> From: Anson Huang <b20788@freescale.com>
> 
> Update i.MX6SX pinfunc header to add uart mux function.

I'm aware you add the macros in a consistent way to the already existing
stuff. Still I think there is something to improve here. We now have
definitions like:

	MX6SX_PAD_GPIO1_IO06__UART1_RTS_B
	MX6SX_PAD_GPIO1_IO06__UART1_CTS_B

	MX6SX_PAD_GPIO1_IO07__UART1_CTS_B
	MX6SX_PAD_GPIO1_IO07__UART1_RTS_B

where (ignoring other pins that could be used) only the following
combinations are valid:

	MX6SX_PAD_GPIO1_IO04__UART1_TX
	MX6SX_PAD_GPIO1_IO05__UART1_RX
	MX6SX_PAD_GPIO1_IO06__UART1_RTS_B
	MX6SX_PAD_GPIO1_IO07__UART1_CTS_B

(in DCE mode) and

	MX6SX_PAD_GPIO1_IO04__UART1_RX
	MX6SX_PAD_GPIO1_IO05__UART1_TX
	MX6SX_PAD_GPIO1_IO06__UART1_CTS_B
	MX6SX_PAD_GPIO1_IO07__UART1_RTS_B

(in DTE mode).

For i.MX6SLL, i.MX6UL, imx6ULL and i.MX7 the naming convention is saner,
a typical definition there is:

	MX7D_PAD_LPSR_GPIO1_IO04__UART5_DTE_RTS

where the name includes DTE and where is it (more) obvious that this
cannot be combined with

	MX7D_PAD_LPSR_GPIO1_IO07__UART5_DCE_TX

.

I suggest to adapt the latter naming convention also for the other i.MX
pinfunc headers, probably with introducing defines for not breaking
existing dts files.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
