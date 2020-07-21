Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ACFDC433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 03:46:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 137F720B1F
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 03:46:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728665AbgGUDqD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 23:46:03 -0400
Received: from inva021.nxp.com ([92.121.34.21]:59740 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726856AbgGUDqC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 23:46:02 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 9FDB420038B;
        Tue, 21 Jul 2020 05:45:59 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 6393D200390;
        Tue, 21 Jul 2020 05:45:54 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 121134031C;
        Tue, 21 Jul 2020 11:27:12 +0800 (SGT)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] ASoC: bindings: fsl-asoc-card: Support properties for configuring dai fmt
Date:   Tue, 21 Jul 2020 11:41:50 +0800
Message-Id: <1595302910-19688-2-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595302910-19688-1-git-send-email-shengjiu.wang@nxp.com>
References: <1595302910-19688-1-git-send-email-shengjiu.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to support configuring dai fmt through DT, add some properties.
These properiese are same as the properties in simple card.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 Documentation/devicetree/bindings/sound/fsl-asoc-card.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/fsl-asoc-card.txt b/Documentation/devicetree/bindings/sound/fsl-asoc-card.txt
index 8a6a3d0fda5e..63ebf52b43e8 100644
--- a/Documentation/devicetree/bindings/sound/fsl-asoc-card.txt
+++ b/Documentation/devicetree/bindings/sound/fsl-asoc-card.txt
@@ -71,6 +71,11 @@ Optional properties:
 
   - hp-det-gpio		: The GPIO that detect headphones are plugged in
   - mic-det-gpio	: The GPIO that detect microphones are plugged in
+  - bitclock-master	: Indicates dai-link bit clock master; for details see simple-card.yaml.
+  - frame-master	: Indicates dai-link frame master; for details see simple-card.yaml.
+  - dai-format		: audio format, for details see simple-card.yaml.
+  - frame-inversion	: dai-link uses frame clock inversion, for details see simple-card.yaml.
+  - bitclock-inversion	: dai-link uses bit clock inversion, for details see simple-card.yaml.
 
 Optional unless SSI is selected as a CPU DAI:
 
-- 
2.27.0

