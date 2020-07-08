Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D5E9C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 17:43:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B40720874
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 17:43:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="MdxNv077";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lp6j9SpF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727865AbgGHRnw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 13:43:52 -0400
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:42565 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727820AbgGHRnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 13:43:47 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 889D12F2;
        Wed,  8 Jul 2020 13:43:46 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 08 Jul 2020 13:43:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=de0mF+VjX2q6u
        xMlPlcBcexMCkVgd8GF6/Q5G21dgxU=; b=MdxNv07736/c5yjumaS2Cpwh9F8P3
        9gjJ7FdQCxmhVf0IntpcjfVO7odpLTAnP27ar4vuqnroPigJfoNrKl2z7u6CxBBH
        bND2Ba+a3sPIHAlCk5Vf3niqFgtPffQRNoe0kqmcOagA/eUwrlQVvG//jIuFV77J
        Wfb03MDAKABcdqpo8NcIYDPJ0jQxsIEvIwXc8eN933SRG6+QQJElmEMVlQ98o4ET
        IkpSiNU6cdK4fCoTvRzC+eVs3O0qmdUQ0RgDs7xu1lRnR/MVtidTJUKDNNBJETAe
        fagOs+9aQq6YZ+hHF31Cw4tCBPQeRRZhlY2y8LI9IfROebqS4qbl6alKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=de0mF+VjX2q6uxMlPlcBcexMCkVgd8GF6/Q5G21dgxU=; b=lp6j9SpF
        YbKxXFOCIeZnRWdHdv56RTumbvWmDytVhK2Bb3fABHzNxONNbUyrY4c6BnuzDiGq
        544ahJ7Q0J+lL0pZzgXYKEmR850v8lUqcVOfmGa7T8j14H3V4WeYcxgnN19rXUBb
        VEGOl1zoxaxRDzCdPLb87VydhW+0bZuJ9BH0BQjg9iCAVyEkc88vhzHGDKghr00l
        exqH9smHzGnAehEPvZlvD+B5T8Gebpguv+o0aK/SrAo9abBPRpWWByGjcaiQN8Oq
        B/+VPzRXfIe6Wv8RaBj6sgioip++kagw0N/c6HeLxdcRBOXLklVuYHMbUNLzu6V9
        u8P2QA50qGc5zw==
X-ME-Sender: <xms:0gUGXy0KMyP_Roz8DJ5XXhMpy17rUhSB75r_Jbpc3jg_GEpy2wMAIw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudejgdduudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepgeeine
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:0gUGX1HfUYfvK-3kq3JMTPWVZ65-LJdT3Wtl1W1DtAR2gcnV26z-EA>
    <xmx:0gUGX64zi0CxtAKQ_lVWN0faIT_ZJgnJjLMUf_63cOq_DoBNQ6DhFQ>
    <xmx:0gUGXz3B_ljWC0O2EF5UHxEu0GjFGHfFWlrBt1lkWAkcnindmJFecA>
    <xmx:0gUGX83fpYKQ8C1foaqehVN-o8MDQTZr_rFbiK_Dkj5iBcIJj8WNy04WwKI>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id BF14D328005D;
        Wed,  8 Jul 2020 13:43:45 -0400 (EDT)
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
Subject: [PATCH v4 52/78] drm/vc4: hdmi: Add reset callback
Date:   Wed,  8 Jul 2020 19:42:00 +0200
Message-Id: <ab00cc4655224f26d74c307a410bbca8d67dbbbb.1594230107.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.7a1aa1784976093af26cb31fd283cf5b3ed568bb.1594230107.git-series.maxime@cerno.tech>
References: <cover.7a1aa1784976093af26cb31fd283cf5b3ed568bb.1594230107.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The BCM2711 and BCM283x HDMI controllers use a slightly different reset
sequence, so let's add a callback to reset the controller.

Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_hdmi.c | 31 ++++++++++++++++++-------------
 drivers/gpu/drm/vc4/vc4_hdmi.h |  3 +++
 2 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index a4fed1439bf3..80bc3dd9d4a8 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -69,6 +69,21 @@ static int vc4_hdmi_debugfs_regs(struct seq_file *m, void *unused)
 	return 0;
 }
 
+static void vc4_hdmi_reset(struct vc4_hdmi *vc4_hdmi)
+{
+	HDMI_WRITE(HDMI_M_CTL, VC4_HD_M_SW_RST);
+	udelay(1);
+	HDMI_WRITE(HDMI_M_CTL, 0);
+
+	HDMI_WRITE(HDMI_M_CTL, VC4_HD_M_ENABLE);
+
+	HDMI_WRITE(HDMI_SW_RESET_CONTROL,
+		   VC4_HDMI_SW_RESET_HDMI |
+		   VC4_HDMI_SW_RESET_FORMAT_DETECT);
+
+	HDMI_WRITE(HDMI_SW_RESET_CONTROL, 0);
+}
+
 static enum drm_connector_status
 vc4_hdmi_connector_detect(struct drm_connector *connector, bool force)
 {
@@ -363,11 +378,8 @@ static void vc4_hdmi_encoder_enable(struct drm_encoder *encoder)
 		return;
 	}
 
-	HDMI_WRITE(HDMI_SW_RESET_CONTROL,
-		   VC4_HDMI_SW_RESET_HDMI |
-		   VC4_HDMI_SW_RESET_FORMAT_DETECT);
-
-	HDMI_WRITE(HDMI_SW_RESET_CONTROL, 0);
+	if (vc4_hdmi->variant->reset)
+		vc4_hdmi->variant->reset(vc4_hdmi);
 
 	/* PHY should be in reset, like
 	 * vc4_hdmi_encoder_disable() does.
@@ -1292,14 +1304,6 @@ static int vc4_hdmi_bind(struct device *dev, struct device *master, void *data)
 		vc4_hdmi->hpd_active_low = hpd_gpio_flags & OF_GPIO_ACTIVE_LOW;
 	}
 
-	/* HDMI core must be enabled. */
-	if (!(HDMI_READ(HDMI_M_CTL) & VC4_HD_M_ENABLE)) {
-		HDMI_WRITE(HDMI_M_CTL, VC4_HD_M_SW_RST);
-		udelay(1);
-		HDMI_WRITE(HDMI_M_CTL, 0);
-
-		HDMI_WRITE(HDMI_M_CTL, VC4_HD_M_ENABLE);
-	}
 	pm_runtime_enable(dev);
 
 	drm_simple_encoder_init(drm, encoder, DRM_MODE_ENCODER_TMDS);
@@ -1428,6 +1432,7 @@ static const struct vc4_hdmi_variant bcm2835_variant = {
 	.num_registers		= ARRAY_SIZE(vc4_hdmi_fields),
 
 	.init_resources		= vc4_hdmi_init_resources,
+	.reset			= vc4_hdmi_reset,
 };
 
 static const struct of_device_id vc4_hdmi_dt_match[] = {
diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.h b/drivers/gpu/drm/vc4/vc4_hdmi.h
index b36e0210671f..17a30589f39c 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.h
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.h
@@ -35,6 +35,9 @@ struct vc4_hdmi_variant {
 	 * clocks, etc) for that variant.
 	 */
 	int (*init_resources)(struct vc4_hdmi *vc4_hdmi);
+
+	/* Callback to reset the HDMI block */
+	void (*reset)(struct vc4_hdmi *vc4_hdmi);
 };
 
 /* HDMI audio information */
-- 
git-series 0.9.1
