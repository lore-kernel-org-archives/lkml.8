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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01027C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 08:30:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F018207C3
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 08:30:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f/2AKCpD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728125AbgEXIag (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 04:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726331AbgEXIag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 04:30:36 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3DDAC061A0E
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 01:30:35 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id z5so17605970ejb.3
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 01:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=86C6qQlpj66Vdu46Is+yMMwh5i/kAr5WUUQnyqcq9nw=;
        b=f/2AKCpDmqUEshPrE7Wk4dThtsUXAUuOvBREWBCWtdTJKMWgsKWoKykMtqNery1Ziw
         sjHbcZsbq6dh82xXTDdvHee0IpZrdjv7c/c2RDMtqmT/xLZ8YKoeXMgxPR0RPH2C3KTt
         Oj6zEwI8rXXvdFwD1xkS9kOiJQwXUjA/F1yKyXWnUnfIypca6C/gFigvCdj75W47krr3
         DJf8wtMaq9PWbYt5wBVtb5vQPwwTxnj7Iu4X+hKrmfRNoXMYGGqqjqmpMiUWA2wRLGKh
         O8VHXrmFnNZ/xRTS8q5aKtIQVEQxQFpcoi/hWLWIGHWsA0VlWobTfqCgU5Iiw3oSv18D
         qLVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=86C6qQlpj66Vdu46Is+yMMwh5i/kAr5WUUQnyqcq9nw=;
        b=Wm5LNfP0zlfKSn+180jo6GWZE6kH07A2qxR+s9ly/W3GLcaCDi0yJtyJAWBbQCOIOT
         3uMARo5ty9PeLYYxLmia6YZD1LxVT8b7iCxUN012LIFQbgMnvax/ZCeFcwIiah7o++iH
         eGO9NM3fJXpizH814MxW3IfcmwY9+MipSAyOtjF1XaEwb1rpWJQf4LB7cFeug6jC4Yub
         MIRiqHzQctTsb6SxF0UcgJGi/AZxVb0o9lPpDE+iSYRSg7bEf6XfGfnbCUCZovlS6P2A
         QQh3w6S90372W9WpXfysHRQaOCygaDNhY0jk/0SnlccOyshK5e1RQgrwCStgOtYxxvQ1
         uSIA==
X-Gm-Message-State: AOAM531wG0KMVSuU57UiawB7REuXuCE+MtoQ4Y0KNQfnSFc7jSy0bmmZ
        oXhy/eirD014N4TRsKET5sQ=
X-Google-Smtp-Source: ABdhPJyDmd1aAO6M8pHpbFtz+KWAKSSM/4ZTyXwcwqhOUmXidYFZDslKjBLQ2fqs4Fi3nQBBO7lFxw==
X-Received: by 2002:a17:906:7e03:: with SMTP id e3mr1282041ejr.363.1590309034281;
        Sun, 24 May 2020 01:30:34 -0700 (PDT)
Received: from localhost.localdomain (dslb-178-006-252-177.178.006.pools.vodafone-ip.de. [178.6.252.177])
        by smtp.gmail.com with ESMTPSA id d22sm12430381ejb.15.2020.05.24.01.30.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2020 01:30:33 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH] staging: rtl8188eu: clean up some declarations
Date:   Sun, 24 May 2020 10:27:48 +0200
Message-Id: <20200524082748.12901-1-straube.linux@gmail.com>
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

