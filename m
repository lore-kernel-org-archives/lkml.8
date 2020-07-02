Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DC06C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 14:12:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1156020772
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 14:12:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729727AbgGBOMX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 10:12:23 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:59148 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728651AbgGBOMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 10:12:20 -0400
Received: from xps.home (unknown [IPv6:2a01:e35:2fb5:1510:315a:ecf0:6250:a3ed])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: aferraris)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 8C01F2A5EC3;
        Thu,  2 Jul 2020 15:12:18 +0100 (BST)
From:   Arnaud Ferraris <arnaud.ferraris@collabora.com>
Cc:     kernel@collabora.com, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Timur Tabi <timur@kernel.org>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/2] dt-bindings: sound: fsl-asoc-card: add new compatible for I2S slave
Date:   Thu,  2 Jul 2020 16:11:14 +0200
Message-Id: <20200702141114.232688-2-arnaud.ferraris@collabora.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200702141114.232688-1-arnaud.ferraris@collabora.com>
References: <20200702141114.232688-1-arnaud.ferraris@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fsl-asoc-card currently doesn't support generic codecs with the SoC
acting as I2S slave.

This commit adds a new `fsl,imx-audio-i2s-slave` for this use-case, as
well as the following mandatory properties:
- `audio-codec-dai-name` for specifying the codec DAI to be used
- `audio-slot-width`

Signed-off-by: Arnaud Ferraris <arnaud.ferraris@collabora.com>
---
 .../bindings/sound/fsl-asoc-card.txt          | 23 ++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/fsl-asoc-card.txt b/Documentation/devicetree/bindings/sound/fsl-asoc-card.txt
index 133d7e14a4d0..694a138df462 100644
--- a/Documentation/devicetree/bindings/sound/fsl-asoc-card.txt
+++ b/Documentation/devicetree/bindings/sound/fsl-asoc-card.txt
@@ -22,6 +22,8 @@ Note: The card is initially designed for those sound cards who use AC'97, I2S
 The compatible list for this generic sound card currently:
  "fsl,imx-audio-ac97"
 
+ "fsl,imx-audio-i2s-slave"
+
  "fsl,imx-audio-cs42888"
 
  "fsl,imx-audio-cs427x"
@@ -75,7 +77,13 @@ Optional unless SSI is selected as a CPU DAI:
 
   - mux-ext-port	: The external port of the i.MX audio muxer
 
-Example:
+Optional unless compatible is "fsl,imx-audio-i2s-slave":
+
+  - audio-codec-dai-name: The name of the DAI provided by the codec
+
+  - audio-slot-width	: The audio sample format
+
+Examples:
 sound-cs42888 {
 	compatible = "fsl,imx-audio-cs42888";
 	model = "cs42888-audio";
@@ -96,3 +104,16 @@ sound-cs42888 {
 		"AIN2L", "Line In Jack",
 		"AIN2R", "Line In Jack";
 };
+
+sound-bluetooth {
+	compatible = "fsl,imx-audio-i2s-slave";
+	audio-cpu = <&ssi1>;
+	audio-codec = <&codec_bluetooth>;
+	audio-codec-dai-name = "bt-sco-pcm-wb";
+	audio-slot-width = <16>;
+	audio-routing =
+		"RX", "Mic Jack",
+		"Headphone Jack", "TX";
+	mux-int-port = <1>;
+	mux-ext-port = <4>;
+};
-- 
2.27.0

