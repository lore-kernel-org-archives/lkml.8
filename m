Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DC47C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 10:37:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D0062077D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 10:37:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725997AbgFCKhf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 06:37:35 -0400
Received: from inva020.nxp.com ([92.121.34.13]:43808 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725828AbgFCKhe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 06:37:34 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 40D181A0101;
        Wed,  3 Jun 2020 12:37:33 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 0588A1A00FE;
        Wed,  3 Jun 2020 12:37:28 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 408FA40299;
        Wed,  3 Jun 2020 18:37:21 +0800 (SGT)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     perex@perex.cz, tiwai@suse.com, lgirdwood@gmail.com,
        broonie@kernel.org, ckeepax@opensource.cirrus.com,
        allison@lohutok.net, info@metux.net, tglx@linutronix.de,
        patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 1/2] ASoC: bindings: wm8960: Add property for headphone detection
Date:   Wed,  3 Jun 2020 18:26:52 +0800
Message-Id: <1591180013-12416-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add two properties for headphone detection.

wlf,hp-cfg: A list of headphone jack detect configuration register values
wlf,gpio-cfg: A list of GPIO configuration register values

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 Documentation/devicetree/bindings/sound/wm8960.txt | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/wm8960.txt b/Documentation/devicetree/bindings/sound/wm8960.txt
index 6d29ac3750ee..85d3b287108c 100644
--- a/Documentation/devicetree/bindings/sound/wm8960.txt
+++ b/Documentation/devicetree/bindings/sound/wm8960.txt
@@ -21,6 +21,17 @@ Optional properties:
 	enabled and disabled together with HP_L and HP_R pins in response to jack
 	detect events.
 
+  - wlf,hp-cfg: A list of headphone jack detect configuration register values.
+		The list must be 3 entries long.
+		hp-cfg[0]: HPSEL[1:0] of R48 (Additional Control 4).
+		hp-cfg[1]: {HPSWEN:HPSWPOL} of R24 (Additional Control 2).
+		hp-cfg[2]: {TOCLKSEL:TOEN} of R23 (Additional Control 1).
+
+  - wlf,gpio-cfg: A list of GPIO configuration register values.
+		  The list must be 2 entries long.
+		  gpio-cfg[0]: ALRCGPIO of R9 (Audio interface)
+		  gpio-cfg[1]: {GPIOPOL:GPIOSEL[2:0]} of R48 (Additional Control 4).
+
 Example:
 
 wm8960: codec@1a {
-- 
2.21.0

