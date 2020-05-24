Return-Path: <SRS0=XgUW=7G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0403AC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 08:52:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE71F20787
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 08:52:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728422AbgEXIv7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 04:51:59 -0400
Received: from smtprelay0177.hostedemail.com ([216.40.44.177]:40226 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727848AbgEXIv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 04:51:59 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 2FA4C52C1;
        Sun, 24 May 2020 08:51:57 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: run46_151812526d37
X-Filterd-Recvd-Size: 5163
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Sun, 24 May 2020 08:51:53 +0000 (UTC)
Message-ID: <cc610c7f97dfd5899ab8b751fdfb9670a0cc761e.camel@perches.com>
Subject: Re: [PATCH] staging: rtl8188eu: clean up some declarations
From:   Joe Perches <joe@perches.com>
To:     Michael Straube <straube.linux@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Date:   Sun, 24 May 2020 01:51:50 -0700
In-Reply-To: <20200524082748.12901-1-straube.linux@gmail.com>
References: <20200524082748.12901-1-straube.linux@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2020-05-24 at 10:27 +0200, Michael Straube wrote:
> Clean up some array declarations in phy_iq_calibrate() to reduce
> indentation and clear line over 80 characters checkpatch warnings.

Better still would be to mark these as static const
and also mark the functions that use them to take
const pointers

Something like:
---
 drivers/staging/rtl8188eu/hal/phy.c | 52 ++++++++++++++++++++-----------------
 1 file changed, 28 insertions(+), 24 deletions(-)

diff --git a/drivers/staging/rtl8188eu/hal/phy.c b/drivers/staging/rtl8188eu/hal/phy.c
index 5eca3625d5a8..9a4f1b84fefc 100644
--- a/drivers/staging/rtl8188eu/hal/phy.c
+++ b/drivers/staging/rtl8188eu/hal/phy.c
@@ -786,7 +786,7 @@ static void pathb_fill_iqk(struct adapter *adapt, bool iqkok, s32 result[][8],
 	}
 }
 
-static void save_adda_registers(struct adapter *adapt, u32 *addareg,
+static void save_adda_registers(struct adapter *adapt, const u32 *addareg,
 				u32 *backup, u32 register_num)
 {
 	u32 i;
@@ -795,7 +795,7 @@ static void save_adda_registers(struct adapter *adapt, u32 *addareg,
 		backup[i] = phy_query_bb_reg(adapt, addareg[i], bMaskDWord);
 }
 
-static void save_mac_registers(struct adapter *adapt, u32 *mac_reg,
+static void save_mac_registers(struct adapter *adapt, const u32 *mac_reg,
 			       u32 *backup)
 {
 	u32 i;
@@ -806,7 +806,7 @@ static void save_mac_registers(struct adapter *adapt, u32 *mac_reg,
 	backup[i] = usb_read32(adapt, mac_reg[i]);
 }
 
-static void reload_adda_reg(struct adapter *adapt, u32 *adda_reg,
+static void reload_adda_reg(struct adapter *adapt, const u32 *adda_reg,
 			    u32 *backup, u32 regiester_num)
 {
 	u32 i;
@@ -816,7 +816,7 @@ static void reload_adda_reg(struct adapter *adapt, u32 *adda_reg,
 }
 
 static void reload_mac_registers(struct adapter *adapt,
-				 u32 *mac_reg, u32 *backup)
+				 const u32 *mac_reg, u32 *backup)
 {
 	u32 i;
 
@@ -826,7 +826,7 @@ static void reload_mac_registers(struct adapter *adapt,
 	usb_write32(adapt, mac_reg[i], backup[i]);
 }
 
-static void path_adda_on(struct adapter *adapt, u32 *adda_reg,
+static void path_adda_on(struct adapter *adapt, const u32 *adda_reg,
 			 bool is_path_a_on, bool is2t)
 {
 	u32 path_on;
@@ -844,7 +844,8 @@ static void path_adda_on(struct adapter *adapt, u32 *adda_reg,
 		phy_set_bb_reg(adapt, adda_reg[i], bMaskDWord, path_on);
 }
 
-static void mac_setting_calibration(struct adapter *adapt, u32 *mac_reg, u32 *backup)
+static void mac_setting_calibration(struct adapter *adapt, const u32 *mac_reg,
+				    u32 *backup)
 {
 	u32 i = 0;
 
@@ -952,26 +953,29 @@ static void phy_iq_calibrate(struct adapter *adapt, s32 result[][8],
 	struct odm_dm_struct *dm_odm = &adapt->HalData->odmpriv;
 	u32 i;
 	u8 path_a_ok, path_b_ok;
-	u32 adda_reg[IQK_ADDA_REG_NUM] = {
-					  rFPGA0_XCD_SwitchControl, rBlue_Tooth,
-					  rRx_Wait_CCA, rTx_CCK_RFON,
-					  rTx_CCK_BBON, rTx_OFDM_RFON,
-					  rTx_OFDM_BBON, rTx_To_Rx,
-					  rTx_To_Tx, rRx_CCK,
-					  rRx_OFDM, rRx_Wait_RIFS,
-					  rRx_TO_Rx, rStandby,
-					  rSleep, rPMPD_ANAEN};
-
-	u32 iqk_mac_reg[IQK_MAC_REG_NUM] = {
-					    REG_TXPAUSE, REG_BCN_CTRL,
-					    REG_BCN_CTRL_1, REG_GPIO_MUXCFG};
+	static const u32 adda_reg[IQK_ADDA_REG_NUM] = {
+		rFPGA0_XCD_SwitchControl, rBlue_Tooth,
+		rRx_Wait_CCA, rTx_CCK_RFON,
+		rTx_CCK_BBON, rTx_OFDM_RFON,
+		rTx_OFDM_BBON, rTx_To_Rx,
+		rTx_To_Tx, rRx_CCK,
+		rRx_OFDM, rRx_Wait_RIFS,
+		rRx_TO_Rx, rStandby,
+		rSleep, rPMPD_ANAEN
+	};
+
+	static const u32 iqk_mac_reg[IQK_MAC_REG_NUM] = {
+		REG_TXPAUSE, REG_BCN_CTRL,
+		REG_BCN_CTRL_1, REG_GPIO_MUXCFG
+	};
 
 	/* since 92C & 92D have the different define in IQK_BB_REG */
-	u32 iqk_bb_reg_92c[IQK_BB_REG_NUM] = {
-					      rOFDM0_TRxPathEnable, rOFDM0_TRMuxPar,
-					      rFPGA0_XCD_RFInterfaceSW, rConfig_AntA, rConfig_AntB,
-					      rFPGA0_XAB_RFInterfaceSW, rFPGA0_XA_RFInterfaceOE,
-					      rFPGA0_XB_RFInterfaceOE, rFPGA0_RFMOD};
+	static const u32 iqk_bb_reg_92c[IQK_BB_REG_NUM] = {
+		rOFDM0_TRxPathEnable, rOFDM0_TRMuxPar,
+		rFPGA0_XCD_RFInterfaceSW, rConfig_AntA, rConfig_AntB,
+		rFPGA0_XAB_RFInterfaceSW, rFPGA0_XA_RFInterfaceOE,
+		rFPGA0_XB_RFInterfaceOE, rFPGA0_RFMOD
+	};
 
 	u32 retry_count = 9;
 


