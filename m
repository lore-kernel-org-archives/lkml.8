Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51209C7619D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 08:23:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F6AC2067D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 08:23:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728209AbgBQIX4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 03:23:56 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:58507 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726823AbgBQIX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 03:23:56 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1j3bh0-0004ma-Ne; Mon, 17 Feb 2020 09:23:50 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1j3bh0-000772-9G; Mon, 17 Feb 2020 09:23:50 +0100
Date:   Mon, 17 Feb 2020 09:23:50 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH V2 1/7] ARM: dts: imx6sx: Improve UART pins macro defines
Message-ID: <20200217082350.o4jjnoslptv74fh6@pengutronix.de>
References: <1581743758-4475-1-git-send-email-Anson.Huang@nxp.com>
 <1581743758-4475-2-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1581743758-4475-2-git-send-email-Anson.Huang@nxp.com>
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

On Sat, Feb 15, 2020 at 01:15:52PM +0800, Anson Huang wrote:
> Add DCE/DTE to UART pins macro defines to distinguish the
> DCE and DTE functions, keep old defines at the end of file
> for some time to make it backward compatible.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Please squash the following diff into your patch:


diff --git a/arch/arm/boot/dts/imx6sx-pinfunc.h b/arch/arm/boot/dts/imx6sx-pinfunc.h
index 738a0000f212..9814db090487 100644
--- a/arch/arm/boot/dts/imx6sx-pinfunc.h
+++ b/arch/arm/boot/dts/imx6sx-pinfunc.h
@@ -1016,8 +1016,8 @@
 #define MX6SX_PAD_QSPI1B_SCLK__WEIM_DATA_8                        0x01B4 0x04FC 0x0000 0x6 0x0
 #define MX6SX_PAD_QSPI1B_SCLK__SIM_M_HADDR_11                     0x01B4 0x04FC 0x0000 0x7 0x0
 #define MX6SX_PAD_QSPI1B_SS0_B__QSPI1_B_SS0_B                     0x01B8 0x0500 0x0000 0x0 0x0
-#define MX6SX_PAD_QSPI1B_SS0_B__UART3_DTE_RX                      0x01B8 0x0500 0x0840 0x1 0x5
 #define MX6SX_PAD_QSPI1B_SS0_B__UART3_DCE_TX                      0x01B8 0x0500 0x0000 0x1 0x0
+#define MX6SX_PAD_QSPI1B_SS0_B__UART3_DTE_RX                      0x01B8 0x0500 0x0840 0x1 0x5
 #define MX6SX_PAD_QSPI1B_SS0_B__ECSPI3_SS0                        0x01B8 0x0500 0x073C 0x2 0x1
 #define MX6SX_PAD_QSPI1B_SS0_B__ESAI_TX_HF_CLK                    0x01B8 0x0500 0x0784 0x3 0x3
 #define MX6SX_PAD_QSPI1B_SS0_B__CSI1_DATA_17                      0x01B8 0x0500 0x06E0 0x4 0x1
@@ -1334,8 +1334,8 @@
 #define MX6SX_PAD_SD3_CLK__TPSMP_HDATA_29                         0x0250 0x0598 0x0000 0x7 0x0
 #define MX6SX_PAD_SD3_CLK__SDMA_DEBUG_EVENT_CHANNEL_5             0x0250 0x0598 0x0000 0x9 0x0
 #define MX6SX_PAD_SD3_CMD__USDHC3_CMD                             0x0254 0x059C 0x0000 0x0 0x0
-#define MX6SX_PAD_SD3_CMD__UART4_DTE_RX                           0x0254 0x059C 0x0848 0x1 0x0
 #define MX6SX_PAD_SD3_CMD__UART4_DCE_TX                           0x0254 0x059C 0x0000 0x1 0x0
+#define MX6SX_PAD_SD3_CMD__UART4_DTE_RX                           0x0254 0x059C 0x0848 0x1 0x0
 #define MX6SX_PAD_SD3_CMD__ECSPI4_MOSI                            0x0254 0x059C 0x0748 0x2 0x0
 #define MX6SX_PAD_SD3_CMD__AUDMUX_AUD6_RXC                        0x0254 0x059C 0x067C 0x3 0x0
 #define MX6SX_PAD_SD3_CMD__LCDIF2_HSYNC                           0x0254 0x059C 0x07E4 0x4 0x1
@@ -1621,11 +1621,11 @@
 #define MX6SX_PAD_SD2_DATA3__UART6_RX		MX6SX_PAD_SD2_DATA3__UART6_DTE_RX
 #define MX6SX_PAD_SD2_DATA3__UART6_TX		MX6SX_PAD_SD2_DATA3__UART6_DCE_TX
 #define MX6SX_PAD_SD3_CLK__UART4_CTS_B		MX6SX_PAD_SD3_CLK__UART4_DCE_CTS
+#define MX6SX_PAD_SD3_CMD__UART4_RX		MX6SX_PAD_SD3_CMD__UART4_DTE_RX
+#define MX6SX_PAD_SD3_CMD__UART4_TX		MX6SX_PAD_SD3_CMD__UART4_DCE_TX
 #define MX6SX_PAD_SD3_DATA2__UART4_RTS_B	MX6SX_PAD_SD3_DATA2__UART4_DCE_RTS
 #define MX6SX_PAD_SD3_DATA3__UART4_RX		MX6SX_PAD_SD3_DATA3__UART4_DCE_RX
 #define MX6SX_PAD_SD3_DATA3__UART4_TX		MX6SX_PAD_SD3_DATA3__UART4_DTE_TX
-#define MX6SX_PAD_SD3_CMD__UART4_RX		MX6SX_PAD_SD3_CMD__UART4_DTE_RX
-#define MX6SX_PAD_SD3_CMD__UART4_TX		MX6SX_PAD_SD3_CMD__UART4_DCE_TX
 #define MX6SX_PAD_SD3_DATA4__UART3_RX		MX6SX_PAD_SD3_DATA4__UART3_DCE_RX
 #define MX6SX_PAD_SD3_DATA4__UART3_TX		MX6SX_PAD_SD3_DATA4__UART3_DTE_TX
 #define MX6SX_PAD_SD3_DATA5__UART3_RX		MX6SX_PAD_SD3_DATA5__UART3_DTE_RX
@@ -1636,7 +1636,7 @@
 #define MX6SX_PAD_SD4_DATA4__UART5_TX		MX6SX_PAD_SD4_DATA4__UART5_DTE_TX
 #define MX6SX_PAD_SD4_DATA5__UART5_RX		MX6SX_PAD_SD4_DATA5__UART5_DTE_RX
 #define MX6SX_PAD_SD4_DATA5__UART5_TX		MX6SX_PAD_SD4_DATA5__UART5_DCE_TX
-#define MX6SX_PAD_SD4_DATA7__UART5_CTS_B	MX6SX_PAD_SD4_DATA7__UART5_DCE_CTS
 #define MX6SX_PAD_SD4_DATA6__UART5_RTS_B	MX6SX_PAD_SD4_DATA6__UART5_DCE_RTS
+#define MX6SX_PAD_SD4_DATA7__UART5_CTS_B	MX6SX_PAD_SD4_DATA7__UART5_DCE_CTS
 
-#endif /*		__DTS_IMX6SX_PINFUNC_H */
+#endif /* __DTS_IMX6SX_PINFUNC_H */

Apart from the last change it is just about ordering. i.e. always list
the DCE function first consistently and have the compat defines in the
same order than the old definition.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
