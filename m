Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85537C54FCB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 15:37:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D17720767
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 15:37:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="ZTD5D/ee";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="0mH7+YzT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728732AbgDXPhA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 11:37:00 -0400
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:42801 "EHLO
        wnew2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728673AbgDXPgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 11:36:51 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 88B59334;
        Fri, 24 Apr 2020 11:36:49 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 24 Apr 2020 11:36:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=4MRxmQw6WIk7+
        /yuSZxIsFfc/Z4dOdvEvdQXNBgfJXI=; b=ZTD5D/ee2UX0twHmXAsF6INqz7fMv
        NBsxgd7afb+MkqXpWKA7sCDkQVC+R/1B4nBktbp0PA1DARJCH/AqkpS6EbQXjmj5
        S3rimTTZ86bXHkAtkzeozdnydC05qKklTxFHIwCtd3RPS7a9QjwWkARxKXTxggyP
        af6ClPJBXKsX4jRggUn/K8F9UmdNZqfnnTgYI11QTumVF0XdJxbS3ADzlI21lrMG
        5nddrZ7Nw6DtRVOAf9ny3knrZfbVy1yVvm7sexj8Lfh5FuTyZ5Z4OCTxNuramLPw
        11b9ujVZm2Fgsi8rtHZdEccwRGVy/AYbnDKbhrI/s7VnaOgE1LiH5NT7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=4MRxmQw6WIk7+/yuSZxIsFfc/Z4dOdvEvdQXNBgfJXI=; b=0mH7+YzT
        nGszAop1FQD5lx2kqDUpOlHKigMKDFPHhVBbuS0uRtFrFqG4iUIlgybNKsSDEpU1
        LyoAp3q4FN1yLbPKUOg/n9gkudIw7UOP6Nh43IqQe568XqhP7WWZs6/QOsoh4t8Q
        gFFQoEu0lBdyaAR7VprSocCCbdSHb1HSQSn+bWpO+v0Yx4Zx4QZOmtAw9J5ZFV00
        0WPDj1w8+JcP/PD3OogxVf5HFKa+vd4fzxImGLKIojdNJweDWNHLg21IClPo63px
        Km+TToNbUK8p3ZB/u6vgfSMD/z3ml5FbJCtuC5IH4KFg1WAaJ2ohwXcBI11D0ocV
        6KMcAg+pSaw+hw==
X-ME-Sender: <xms:kQejXmotfLQDKTwuDX1OTwR7wfOYe-F0IwTBka7IC0nqMM8O7FUdfA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrhedugdekiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucfkphepledtrd
    ekledrieekrdejieenucevlhhushhtvghrufhiiigvpeehheenucfrrghrrghmpehmrghi
    lhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:kQejXn-A9imGHffPcO_NPHSGK-DvivPQlFSRFivy81puttG_014nTQ>
    <xmx:kQejXvR5svqChuAratn0YB9W3J4GVWhfZG5RLg51unRN5BwioOTLtQ>
    <xmx:kQejXsRuTlFAQ5GPthwbe2Nzw-OeCTAXmtuXtl-imddMy7EUzvjmfg>
    <xmx:kQejXtRrzGi_YHtHzBBHk7cqmK8885GoRPED5GEqSUuP2UJGqOybBDA_aCg>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id A5E733280066;
        Fri, 24 Apr 2020 11:36:48 -0400 (EDT)
From:   Maxime Ripard <maxime@cerno.tech>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Eric Anholt <eric@anholt.net>
Cc:     dri-devel@lists.freedesktop.org,
        linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>,
        Maxime Ripard <maxime@cerno.tech>
Subject: [PATCH v2 62/91] drm/vc4: hdmi: Move structure to header
Date:   Fri, 24 Apr 2020 17:34:43 +0200
Message-Id: <7a02eb030448551171e3a7742a03a9313a1e9a5a.1587742492.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <cover.d1e741d37e43e1ba2d2ecd93fc81d42a6df99d14.1587742492.git-series.maxime@cerno.tech>
References: <cover.d1e741d37e43e1ba2d2ecd93fc81d42a6df99d14.1587742492.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We will need to share the vc4_hdmi and related structures with multiple
files, so let's create a header for it.

Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_hdmi.c | 76 +-------------------------------
 drivers/gpu/drm/vc4/vc4_hdmi.h | 86 +++++++++++++++++++++++++++++++++++-
 2 files changed, 87 insertions(+), 75 deletions(-)
 create mode 100644 drivers/gpu/drm/vc4/vc4_hdmi.h

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index a9e32ad7b0ab..4b21292072e4 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -48,87 +48,13 @@
 #include <sound/soc.h>
 #include "media/cec.h"
 #include "vc4_drv.h"
+#include "vc4_hdmi.h"
 #include "vc4_regs.h"
 
 #define HSM_CLOCK_FREQ 163682864
 #define CEC_CLOCK_FREQ 40000
 #define CEC_CLOCK_DIV  (HSM_CLOCK_FREQ / CEC_CLOCK_FREQ)
 
-/* HDMI audio information */
-struct vc4_hdmi_audio {
-	struct snd_soc_card card;
-	struct snd_soc_dai_link link;
-	struct snd_soc_dai_link_component cpu;
-	struct snd_soc_dai_link_component codec;
-	struct snd_soc_dai_link_component platform;
-	int samplerate;
-	int channels;
-	struct snd_dmaengine_dai_dma_data dma_data;
-	struct snd_pcm_substream *substream;
-};
-
-/* General HDMI hardware state. */
-struct vc4_hdmi {
-	struct platform_device *pdev;
-
-	struct drm_encoder *encoder;
-	struct drm_connector *connector;
-
-	struct vc4_hdmi_audio audio;
-
-	struct i2c_adapter *ddc;
-	void __iomem *hdmicore_regs;
-	void __iomem *hd_regs;
-	int hpd_gpio;
-	bool hpd_active_low;
-
-	struct cec_adapter *cec_adap;
-	struct cec_msg cec_rx_msg;
-	bool cec_tx_ok;
-	bool cec_irq_was_rx;
-
-	struct clk *pixel_clock;
-	struct clk *hsm_clock;
-
-	struct debugfs_regset32 hdmi_regset;
-	struct debugfs_regset32 hd_regset;
-};
-
-#define HDMI_READ(offset) readl(vc4->hdmi->hdmicore_regs + offset)
-#define HDMI_WRITE(offset, val) writel(val, vc4->hdmi->hdmicore_regs + offset)
-#define HD_READ(offset) readl(vc4->hdmi->hd_regs + offset)
-#define HD_WRITE(offset, val) writel(val, vc4->hdmi->hd_regs + offset)
-
-/* VC4 HDMI encoder KMS struct */
-struct vc4_hdmi_encoder {
-	struct vc4_encoder base;
-	bool hdmi_monitor;
-	bool limited_rgb_range;
-};
-
-static inline struct vc4_hdmi_encoder *
-to_vc4_hdmi_encoder(struct drm_encoder *encoder)
-{
-	return container_of(encoder, struct vc4_hdmi_encoder, base.base);
-}
-
-/* VC4 HDMI connector KMS struct */
-struct vc4_hdmi_connector {
-	struct drm_connector base;
-
-	/* Since the connector is attached to just the one encoder,
-	 * this is the reference to it so we can do the best_encoder()
-	 * hook.
-	 */
-	struct drm_encoder *encoder;
-};
-
-static inline struct vc4_hdmi_connector *
-to_vc4_hdmi_connector(struct drm_connector *connector)
-{
-	return container_of(connector, struct vc4_hdmi_connector, base);
-}
-
 static const struct debugfs_reg32 hdmi_regs[] = {
 	VC4_REG32(VC4_HDMI_CORE_REV),
 	VC4_REG32(VC4_HDMI_SW_RESET_CONTROL),
diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.h b/drivers/gpu/drm/vc4/vc4_hdmi.h
new file mode 100644
index 000000000000..5ec5d1f6b1e6
--- /dev/null
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.h
@@ -0,0 +1,86 @@
+#ifndef _VC4_HDMI_H_
+#define _VC4_HDMI_H_
+
+#include <drm/drm_connector.h>
+#include <media/cec.h>
+#include <sound/dmaengine_pcm.h>
+#include <sound/soc.h>
+
+#include "vc4_drv.h"
+
+/* HDMI audio information */
+struct vc4_hdmi_audio {
+	struct snd_soc_card card;
+	struct snd_soc_dai_link link;
+	struct snd_soc_dai_link_component cpu;
+	struct snd_soc_dai_link_component codec;
+	struct snd_soc_dai_link_component platform;
+	int samplerate;
+	int channels;
+	struct snd_dmaengine_dai_dma_data dma_data;
+	struct snd_pcm_substream *substream;
+};
+
+/* General HDMI hardware state. */
+struct vc4_hdmi {
+	struct platform_device *pdev;
+
+	struct drm_encoder *encoder;
+	struct drm_connector *connector;
+
+	struct vc4_hdmi_audio audio;
+
+	struct i2c_adapter *ddc;
+	void __iomem *hdmicore_regs;
+	void __iomem *hd_regs;
+	int hpd_gpio;
+	bool hpd_active_low;
+
+	struct cec_adapter *cec_adap;
+	struct cec_msg cec_rx_msg;
+	bool cec_tx_ok;
+	bool cec_irq_was_rx;
+
+	struct clk *pixel_clock;
+	struct clk *hsm_clock;
+
+	struct debugfs_regset32 hdmi_regset;
+	struct debugfs_regset32 hd_regset;
+};
+
+#define HDMI_READ(offset) readl(vc4->hdmi->hdmicore_regs + offset)
+#define HDMI_WRITE(offset, val) writel(val, vc4->hdmi->hdmicore_regs + offset)
+#define HD_READ(offset) readl(vc4->hdmi->hd_regs + offset)
+#define HD_WRITE(offset, val) writel(val, vc4->hdmi->hd_regs + offset)
+
+/* VC4 HDMI encoder KMS struct */
+struct vc4_hdmi_encoder {
+	struct vc4_encoder base;
+	bool hdmi_monitor;
+	bool limited_rgb_range;
+};
+
+static inline struct vc4_hdmi_encoder *
+to_vc4_hdmi_encoder(struct drm_encoder *encoder)
+{
+	return container_of(encoder, struct vc4_hdmi_encoder, base.base);
+}
+
+/* VC4 HDMI connector KMS struct */
+struct vc4_hdmi_connector {
+	struct drm_connector base;
+
+	/* Since the connector is attached to just the one encoder,
+	 * this is the reference to it so we can do the best_encoder()
+	 * hook.
+	 */
+	struct drm_encoder *encoder;
+};
+
+static inline struct vc4_hdmi_connector *
+to_vc4_hdmi_connector(struct drm_connector *connector)
+{
+	return container_of(connector, struct vc4_hdmi_connector, base);
+}
+
+#endif /* _VC4_HDMI_H_ */
-- 
git-series 0.9.1
