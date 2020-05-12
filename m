Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC995C54E4A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 10:32:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95438206DD
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 10:32:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729520AbgELKcj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 06:32:39 -0400
Received: from inva021.nxp.com ([92.121.34.21]:51996 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729412AbgELKci (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 06:32:38 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 72DE0200F2E;
        Tue, 12 May 2020 12:32:37 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id E6ABC200F8B;
        Tue, 12 May 2020 12:32:32 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 0D4E9402BC;
        Tue, 12 May 2020 18:32:26 +0800 (SGT)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, broonie@kernel.org,
        alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: fsl_asrc: Set ASR76K and ASR56K based on processing clock
Date:   Tue, 12 May 2020 18:22:59 +0800
Message-Id: <1589278979-31008-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The processing clock is different for platforms, so it is better
to set ASR76K and ASR56K based on processing clock, rather than
hard coding the value for them.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Signed-off-by: Mihai Serban <mihai.serban@nxp.com>
---
 sound/soc/fsl/fsl_asrc.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
index 067a54ab554f..ca926915068f 100644
--- a/sound/soc/fsl/fsl_asrc.c
+++ b/sound/soc/fsl/fsl_asrc.c
@@ -858,6 +858,8 @@ static const struct regmap_config fsl_asrc_regmap_config = {
  */
 static int fsl_asrc_init(struct fsl_asrc *asrc)
 {
+	unsigned long ipg_rate;
+
 	/* Halt ASRC internal FP when input FIFO needs data for pair A, B, C */
 	regmap_write(asrc->regmap, REG_ASRCTR, ASRCTR_ASRCEN);
 
@@ -875,11 +877,14 @@ static int fsl_asrc_init(struct fsl_asrc *asrc)
 	regmap_update_bits(asrc->regmap, REG_ASRTFR1,
 			   ASRTFR1_TF_BASE_MASK, ASRTFR1_TF_BASE(0xfc));
 
-	/* Set the processing clock for 76KHz to 133M */
-	regmap_write(asrc->regmap, REG_ASR76K, 0x06D6);
-
-	/* Set the processing clock for 56KHz to 133M */
-	return regmap_write(asrc->regmap, REG_ASR56K, 0x0947);
+	/*
+	 * Set the period of the 76KHz and 56KHz sampling clocks based on
+	 * the ASRC processing clock.
+	 * On iMX6, ipg_clk = 133MHz, REG_ASR76K = 0x06D6, REG_ASR56K = 0x0947
+	 */
+	ipg_rate = clk_get_rate(asrc->ipg_clk);
+	regmap_write(asrc->regmap, REG_ASR76K, ipg_rate / 76000);
+	return regmap_write(asrc->regmap, REG_ASR56K, ipg_rate / 56000);
 }
 
 /**
-- 
2.21.0

