Return-Path: <SRS0=XgUW=7G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DAB8C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 10:17:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 246A0207FB
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 10:17:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hzL0+W/A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387614AbgEXKRa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 06:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728766AbgEXKR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 06:17:29 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA0C6C061A0E
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 03:17:27 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id u13so4163134wml.1
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 03:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eOcAVw3WZJieXwB4DiqXh5Y9KuUxyuAgDULNchWs2PU=;
        b=hzL0+W/AF1i4IJSy1JF1cAJ23MpUuV9jY/U7zBK0L4wdsDc7t5uGUw+K/OCLsLHDio
         zrC4+6H/xjHOI5pmNBtVP1EqPUQecKUdf+ishS4C9TUeL+8pBrdQ6FlX1ZXYJtMfheOY
         IkBv7yM6KiGPOlIftlxwOr15t2Q+MbpBKoWsIi7ol08Jz1ZILyCqbdqB9Fbq2ePtT/CN
         mVYDtO1Ji/cw+JyAxibSJfm1zCCfHolNWZ9HtgyC5koz0jXik76xSJj/2UEdjgqBj+VP
         2LxfS9E/8efxAZxyGaCpqV3FGAowJo8Zi09FQUdw3d8fMKlMTguCFmXqRKByEaw0I+3D
         ODPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eOcAVw3WZJieXwB4DiqXh5Y9KuUxyuAgDULNchWs2PU=;
        b=sPwWCl+pjHf8ptO4DEw1xIRtEqje6YHXMxLbi/kcLS9AqSDvz/zTcQt3aAuzqCljp2
         V6EYIRju3cs2yXwkhwpNOE33AtndRnG2l7sCx4ni3veI/MSOZlSZVSAvbPwoiivwe5rU
         ou91Ip6m73cxvIcFdvKdSr8EWRfvXYGn+m3ivglfOVXEIT+lVyhlDwHyBccEIZ3Z5hv7
         nlCrnAbqVitqXXgwHrClhOpbk7U3OVyRW9kx++WCBqGO44XtNJ6fMLR4eKBTH9cGCVgp
         3OjMpnbL6jeQBiJdeONKErvUMrzjtqAPwuPyqMHs5aWzcT8ftJ3H55xcGpq9CRQqaOrF
         dKdA==
X-Gm-Message-State: AOAM530vRG2rgJsofRzeMgk60u1boVtuu+EofvkuOOQTlA7a5NUbgEcL
        v0DvSXiO7U+frRJDo93TTV8=
X-Google-Smtp-Source: ABdhPJwMB/mbnH5AbZExAt3LlayIWmdR7walb5ixZfgyALYp8AuG7orpvP6OUiPaUKZ5vifNz+BIiw==
X-Received: by 2002:a1c:acc8:: with SMTP id v191mr21852638wme.154.1590315446501;
        Sun, 24 May 2020 03:17:26 -0700 (PDT)
Received: from localhost.localdomain (dslb-178-006-252-159.178.006.pools.vodafone-ip.de. [178.6.252.159])
        by smtp.gmail.com with ESMTPSA id o6sm3819058wrp.3.2020.05.24.03.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2020 03:17:25 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 1/2] staging: rtl8188eu: clean up some declarations
Date:   Sun, 24 May 2020 12:15:13 +0200
Message-Id: <20200524101514.20557-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up some array declarations in phy_iq_calibrate() to reduce
indentation and clear line over 80 characters checkpatch warnings.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
v1 -> v2
Added patch that makes arrays static const.

 drivers/staging/rtl8188eu/hal/phy.c | 33 +++++++++++++++--------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/rtl8188eu/hal/phy.c b/drivers/staging/rtl8188eu/hal/phy.c
index 5eca3625d5a8..a0522d6764d6 100644
--- a/drivers/staging/rtl8188eu/hal/phy.c
+++ b/drivers/staging/rtl8188eu/hal/phy.c
@@ -953,25 +953,26 @@ static void phy_iq_calibrate(struct adapter *adapt, s32 result[][8],
 	u32 i;
 	u8 path_a_ok, path_b_ok;
 	u32 adda_reg[IQK_ADDA_REG_NUM] = {
-					  rFPGA0_XCD_SwitchControl, rBlue_Tooth,
-					  rRx_Wait_CCA, rTx_CCK_RFON,
-					  rTx_CCK_BBON, rTx_OFDM_RFON,
-					  rTx_OFDM_BBON, rTx_To_Rx,
-					  rTx_To_Tx, rRx_CCK,
-					  rRx_OFDM, rRx_Wait_RIFS,
-					  rRx_TO_Rx, rStandby,
-					  rSleep, rPMPD_ANAEN};
-
+		rFPGA0_XCD_SwitchControl, rBlue_Tooth,
+		rRx_Wait_CCA, rTx_CCK_RFON,
+		rTx_CCK_BBON, rTx_OFDM_RFON,
+		rTx_OFDM_BBON, rTx_To_Rx,
+		rTx_To_Tx, rRx_CCK,
+		rRx_OFDM, rRx_Wait_RIFS,
+		rRx_TO_Rx, rStandby,
+		rSleep, rPMPD_ANAEN
+	};
 	u32 iqk_mac_reg[IQK_MAC_REG_NUM] = {
-					    REG_TXPAUSE, REG_BCN_CTRL,
-					    REG_BCN_CTRL_1, REG_GPIO_MUXCFG};
-
+		REG_TXPAUSE, REG_BCN_CTRL,
+		REG_BCN_CTRL_1, REG_GPIO_MUXCFG
+	};
 	/* since 92C & 92D have the different define in IQK_BB_REG */
 	u32 iqk_bb_reg_92c[IQK_BB_REG_NUM] = {
-					      rOFDM0_TRxPathEnable, rOFDM0_TRMuxPar,
-					      rFPGA0_XCD_RFInterfaceSW, rConfig_AntA, rConfig_AntB,
-					      rFPGA0_XAB_RFInterfaceSW, rFPGA0_XA_RFInterfaceOE,
-					      rFPGA0_XB_RFInterfaceOE, rFPGA0_RFMOD};
+		rOFDM0_TRxPathEnable, rOFDM0_TRMuxPar,
+		rFPGA0_XCD_RFInterfaceSW, rConfig_AntA, rConfig_AntB,
+		rFPGA0_XAB_RFInterfaceSW, rFPGA0_XA_RFInterfaceOE,
+		rFPGA0_XB_RFInterfaceOE, rFPGA0_RFMOD
+	};
 
 	u32 retry_count = 9;
 
-- 
2.26.2

