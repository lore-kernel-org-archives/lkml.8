Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33B68C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 08:58:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D0E9206CD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 08:58:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbgGGI6t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 04:58:49 -0400
Received: from inva021.nxp.com ([92.121.34.21]:50484 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725825AbgGGI6r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 04:58:47 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id A5D0E2008CD;
        Tue,  7 Jul 2020 10:58:45 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 5E35E2015DF;
        Tue,  7 Jul 2020 10:58:41 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id BC92C402F0;
        Tue,  7 Jul 2020 16:58:35 +0800 (SGT)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] ASoC: fsl_spdif: Clear the validity bit for TX
Date:   Tue,  7 Jul 2020 16:54:25 +0800
Message-Id: <1594112066-31297-2-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1594112066-31297-1-git-send-email-shengjiu.wang@nxp.com>
References: <1594112066-31297-1-git-send-email-shengjiu.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In IEC958 spec, "The validity bit is logical "0" if the
information in the main data field is reliable, and it
is logical "1" if it is not".

The default value of "ValCtrl" is zero, which means
"Outgoing Validity always set", then all the data is not
reliable, then some spdif sink device will drop the data.

So set "ValCtrl" to 1, that is to clear "Outgoing Validity"
in default.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/fsl_spdif.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/fsl/fsl_spdif.c b/sound/soc/fsl/fsl_spdif.c
index 9fb95c6ee7ba..576370dc6e70 100644
--- a/sound/soc/fsl/fsl_spdif.c
+++ b/sound/soc/fsl/fsl_spdif.c
@@ -985,6 +985,10 @@ static int fsl_spdif_dai_probe(struct snd_soc_dai *dai)
 
 	snd_soc_add_dai_controls(dai, fsl_spdif_ctrls, ARRAY_SIZE(fsl_spdif_ctrls));
 
+	/*Clear the val bit for Tx*/
+	regmap_update_bits(spdif_private->regmap, REG_SPDIF_SCR,
+			   SCR_VAL_MASK, SCR_VAL_CLEAR);
+
 	return 0;
 }
 
-- 
2.21.0

