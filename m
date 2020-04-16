Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F551C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 12:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F786217D8
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 12:34:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2635732AbgDPMeS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 08:34:18 -0400
Received: from inva021.nxp.com ([92.121.34.21]:49802 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2635550AbgDPMeA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 08:34:00 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 0CD94200CE4;
        Thu, 16 Apr 2020 14:33:57 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 63F4D200CD9;
        Thu, 16 Apr 2020 14:33:51 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 57759402FC;
        Thu, 16 Apr 2020 20:33:44 +0800 (SGT)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, broonie@kernel.org,
        alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v9 2/7] ASoC: dt-bindings: fsl_asrc: Add new property fsl,asrc-format
Date:   Thu, 16 Apr 2020 20:25:32 +0800
Message-Id: <e7acbde4b26a82b674a4091515a219e09f847eac.1587038908.git.shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1587038908.git.shengjiu.wang@nxp.com>
References: <cover.1587038908.git.shengjiu.wang@nxp.com>
In-Reply-To: <cover.1587038908.git.shengjiu.wang@nxp.com>
References: <cover.1587038908.git.shengjiu.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to support new EASRC and simplify the code structure,
We decide to share the common structure between them. This bring
a problem that EASRC accept format directly from devicetree, but
ASRC accept width from devicetree.

In order to align with new ESARC, we add new property fsl,asrc-format.
The fsl,asrc-format can replace the fsl,asrc-width, then driver
can accept format from devicetree, don't need to convert it to
format through width.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/sound/fsl,asrc.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/fsl,asrc.txt b/Documentation/devicetree/bindings/sound/fsl,asrc.txt
index cb9a25165503..998b4c8a7f78 100644
--- a/Documentation/devicetree/bindings/sound/fsl,asrc.txt
+++ b/Documentation/devicetree/bindings/sound/fsl,asrc.txt
@@ -51,6 +51,10 @@ Optional properties:
 			  will be in use as default. Otherwise, the big endian
 			  mode will be in use for all the device registers.
 
+   - fsl,asrc-format	: Defines a mutual sample format used by DPCM Back
+			  Ends, which can replace the fsl,asrc-width.
+			  The value is 2 (S16_LE), or 6 (S24_LE).
+
 Example:
 
 asrc: asrc@2034000 {
-- 
2.21.0

