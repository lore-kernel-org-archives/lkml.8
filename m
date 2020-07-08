Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2EA0C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 17:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A542A206DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 17:46:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="OfPlHpFA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sMfqi+0k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728456AbgGHRqL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 13:46:11 -0400
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:51567 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726106AbgGHRnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 13:43:20 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 33A22D42;
        Wed,  8 Jul 2020 13:43:19 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 08 Jul 2020 13:43:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=PwDr0LiHNE8XD
        DeUfENsNqVIfWzvRdNLh73lKjp7vqQ=; b=OfPlHpFAJYt0liVxxr6hDnVZn2Sst
        O/XdibL8KzKT+0CcrjU4123FK3MchzI0Wl2Uk1qNz3I6kKQ6pYhhL3lsu3B2kW8l
        gZr7KM6LolI8xJPFJkkNoM0m3bupHNeM6cAMqGcMOu88AdeTBbhP2qHSAUK0ZP3a
        G/TUoS62LyB18n74PZepvc/A5yjWxi3wsegHw7mjH2nFFbNr5FiXaV/5GY5fD1Nj
        p52XU9lWdgIXk3DdxafP1jICTqKdsEIogkCYC8krv2MtERDQSyY6+MoZ6cAiD2NJ
        xZBjw2yus3GYDgAXDgyzD+cd1bJdJpOE/IMrYnC7yFbo+LgH+lVgToBSw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=PwDr0LiHNE8XDDeUfENsNqVIfWzvRdNLh73lKjp7vqQ=; b=sMfqi+0k
        J87OHGvr6MsSmKCq7Gh7VzkRsP2rUD8490kjC6pFGY03V+cZqZ6CPTLMETSgZwo1
        l+q81Ikc2zw4WFl5uXPuXy09sH3zqtjqAy5DeiJH4uHxVe+vHDTe1cma72rUHT8B
        JE6JdmSMd+ijVIaHC4fO5CDsObgA2+pnpXZI5Q/TTgYEDRt1MOyHIkHMJYbnnDzG
        +Zz4ZACJ9DzBq0B6gGDLwTAordKWd2j22mLNx7PEjkXyqf0UlQaA6U59OWCH1Z3L
        T+OC+40r3LvWlDjxZlMNYZb1S6M0YAHJDV6rN+LlCluaScSf5WKFBLhMXsxED6Kh
        wYLjOD+nEfr1sg==
X-ME-Sender: <xms:tgUGX5FdWduqV9tiIgMd_QVUpJeIbwHypZ2b3FB9XsWmmgWcjE2vSw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudejgdduudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepfedvne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:tgUGX-U4v_ZYMvjZ5jHt3Tzb5EfVzfODTjqZ32qwdmk-gJdvzkRlOQ>
    <xmx:tgUGX7JPBd049mkDyh6PRl-9qkKEcpJmpz6Z69afTJECFMqR6enGkg>
    <xmx:tgUGX_FG2Pmxy6UqRao_ieUgFyvnLH-RCs4pKI4ZISA9YtkVf3A7hw>
    <xmx:tgUGX2HGLL_VnsmjOUh-NSUufYSlRfbrfgOoNYdeurbzx9G44cV-WvyPM7U>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 6DB3930600B1;
        Wed,  8 Jul 2020 13:43:18 -0400 (EDT)
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
Subject: [PATCH v4 33/78] drm/vc4: hvs: Introduce a function to get the assigned FIFO
Date:   Wed,  8 Jul 2020 19:41:41 +0200
Message-Id: <b1bf2728eb012cf15142dce1079d40b13cf58a85.1594230107.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.7a1aa1784976093af26cb31fd283cf5b3ed568bb.1594230107.git-series.maxime@cerno.tech>
References: <cover.7a1aa1784976093af26cb31fd283cf5b3ed568bb.1594230107.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At boot time, if we detect that a pixelvalve has been enabled, we need to
be able to retrieve the HVS channel it has been assigned to so that we can
disable that channel too. Let's create that function that returns the FIFO
or an error from a given output.

Reviewed-by: Eric Anholt <eric@anholt.net>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_drv.h |  1 +-
 drivers/gpu/drm/vc4/vc4_hvs.c | 54 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 55 insertions(+)

diff --git a/drivers/gpu/drm/vc4/vc4_drv.h b/drivers/gpu/drm/vc4/vc4_drv.h
index 554c2e29b23d..860be019d8e3 100644
--- a/drivers/gpu/drm/vc4/vc4_drv.h
+++ b/drivers/gpu/drm/vc4/vc4_drv.h
@@ -908,6 +908,7 @@ void vc4_irq_reset(struct drm_device *dev);
 /* vc4_hvs.c */
 extern struct platform_driver vc4_hvs_driver;
 void vc4_hvs_stop_channel(struct drm_device *dev, unsigned int output);
+int vc4_hvs_get_fifo_from_output(struct drm_device *dev, unsigned int output);
 int vc4_hvs_atomic_check(struct drm_crtc *crtc, struct drm_crtc_state *state);
 void vc4_hvs_atomic_enable(struct drm_crtc *crtc, struct drm_crtc_state *old_state);
 void vc4_hvs_atomic_disable(struct drm_crtc *crtc, struct drm_crtc_state *old_state);
diff --git a/drivers/gpu/drm/vc4/vc4_hvs.c b/drivers/gpu/drm/vc4/vc4_hvs.c
index 2966dc05c7bb..4ef88c0b51ab 100644
--- a/drivers/gpu/drm/vc4/vc4_hvs.c
+++ b/drivers/gpu/drm/vc4/vc4_hvs.c
@@ -19,6 +19,7 @@
  * each CRTC.
  */
 
+#include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/component.h>
 #include <linux/platform_device.h>
@@ -196,6 +197,59 @@ static void vc4_hvs_update_gamma_lut(struct drm_crtc *crtc)
 	vc4_hvs_lut_load(crtc);
 }
 
+int vc4_hvs_get_fifo_from_output(struct drm_device *dev, unsigned int output)
+{
+	struct vc4_dev *vc4 = to_vc4_dev(dev);
+	u32 reg;
+	int ret;
+
+	if (!vc4->hvs->hvs5)
+		return output;
+
+	switch (output) {
+	case 0:
+		return 0;
+
+	case 1:
+		return 1;
+
+	case 2:
+		reg = HVS_READ(SCALER_DISPECTRL);
+		ret = FIELD_GET(SCALER_DISPECTRL_DSP2_MUX_MASK, reg);
+		if (ret == 0)
+			return 2;
+
+		return 0;
+
+	case 3:
+		reg = HVS_READ(SCALER_DISPCTRL);
+		ret = FIELD_GET(SCALER_DISPCTRL_DSP3_MUX_MASK, reg);
+		if (ret == 3)
+			return -EPIPE;
+
+		return ret;
+
+	case 4:
+		reg = HVS_READ(SCALER_DISPEOLN);
+		ret = FIELD_GET(SCALER_DISPEOLN_DSP4_MUX_MASK, reg);
+		if (ret == 3)
+			return -EPIPE;
+
+		return ret;
+
+	case 5:
+		reg = HVS_READ(SCALER_DISPDITHER);
+		ret = FIELD_GET(SCALER_DISPDITHER_DSP5_MUX_MASK, reg);
+		if (ret == 3)
+			return -EPIPE;
+
+		return ret;
+
+	default:
+		return -EPIPE;
+	}
+}
+
 static int vc4_hvs_init_channel(struct vc4_dev *vc4, struct drm_crtc *crtc,
 				struct drm_display_mode *mode, bool oneshot)
 {
-- 
git-series 0.9.1
