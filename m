Return-Path: <SRS0=2gEN=4S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6C96C3F2D5
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 05:31:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8439B20848
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 05:31:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727439AbgCAFbJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Mar 2020 00:31:09 -0500
Received: from inva021.nxp.com ([92.121.34.21]:56012 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725887AbgCAFai (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Mar 2020 00:30:38 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 88CEB200A32;
        Sun,  1 Mar 2020 06:30:36 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 44BF9200A2B;
        Sun,  1 Mar 2020 06:30:27 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 83DD3402A7;
        Sun,  1 Mar 2020 13:30:16 +0800 (SGT)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, broonie@kernel.org,
        alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/8] ARM: dts: imx6qdl: Change asrc-width to asrc-format
Date:   Sun,  1 Mar 2020 13:24:13 +0800
Message-Id: <5bb6329e32d7c12019daec403b8f01758df675da.1583039752.git.shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1583039752.git.shengjiu.wang@nxp.com>
References: <cover.1583039752.git.shengjiu.wang@nxp.com>
In-Reply-To: <cover.1583039752.git.shengjiu.wang@nxp.com>
References: <cover.1583039752.git.shengjiu.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

asrc_format is more inteligent, which is align with the alsa
definition snd_pcm_format_t, we don't need to convert it to
format in driver, and it can distinguish S24_LE & S24_3LE.
default value is SNDRV_PCM_FORMAT_S16_LE(2).

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 arch/arm/boot/dts/imx6qdl.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index e6b4b8525f98..062d98ee513b 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -481,7 +481,7 @@
 					dma-names = "rxa", "rxb", "rxc",
 							"txa", "txb", "txc";
 					fsl,asrc-rate  = <48000>;
-					fsl,asrc-width = <16>;
+					fsl,asrc-format = <2>;
 					status = "okay";
 				};
 
-- 
2.21.0

