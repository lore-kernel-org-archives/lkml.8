Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C72BC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:51:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17AE320776
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:51:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="t3rscJZB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WgP10HlS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390320AbgE0PvW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 11:51:22 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:53043 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727092AbgE0Puq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 11:50:46 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 52C805820B7;
        Wed, 27 May 2020 11:50:45 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 27 May 2020 11:50:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=ZyCl4iy/AfxZI
        XSOog2Fc/TgXjHAJO3V3x2olSe7lsU=; b=t3rscJZBw4Hi+ELfuZ8cnRpKqc+p+
        OWYJlhRWhd/CHxEPKh/+gQAULBv9Dd3/Sm+T3tcsgXT5pB51n29/QoZ0zc7/CThl
        K5ebD9cDhM5RPqeVWkBAtLEjiXECBrH7L4Hobqz2pmgZByG02oN6zR1tpg3hchwB
        ToKCymcN6rbz9yYk2mQJ4IMmqlMD+0+7py94DT5wcP/z6Pwt1RDR5dr1cuWEKzJM
        3MAX+u7vdGojSJF460S+Zs+oI649HBA6bW+HvbZXptE74wmgly6Qtjj1/Cg5GeuV
        vKZmC7SEvKtHGKgrwn7TDhjFY+nmGzb8hVmkUv/y979/HrHIV9MZHHORw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=ZyCl4iy/AfxZIXSOog2Fc/TgXjHAJO3V3x2olSe7lsU=; b=WgP10HlS
        QJ/MouSez0dPxjYEvDXKEXDCi3MwejCejkFkF0IhrN6M80RLipW0+nGPxTEHwVrP
        UGYIZfNezV4GzjXlFaaXt3pcgdy/fEQ3e97OOb5CTI+HRu6HFm5G/lcKGjlO4P64
        JZFHIin+HwYS2kc+Vs1ZULvGjkbNztZHrggZY05NravGOFwt2+iPXHXMhfi4vDVL
        oQheyMxXx3etFFspzvuJEu5ne+DZYx+kWL/xf52E9nSZmd7U797QV6U3dutRLAPf
        7MdmFmZ468dJHbF3u13p5z3HjM8P1GyNAR5SFh64nBaFJywd+6ts7hll1UAv0Mmb
        snc1yq+qrKoTPg==
X-ME-Sender: <xms:VYzOXpTjbxGmyiPZPo9E-uUbGozYZ4fYxzyyz8BPGQGSR75G6rGjdQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedruddvgedgkeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepfeeine
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:VYzOXiz6gF9y-xpMSp7vY27JPatx4WI1_NDtN2TIa97XHyKNKtgRWQ>
    <xmx:VYzOXu1knkq7JrMlTQPezlmC1PPpKuJ_6VM5OeJrjJ3zHeACjTbOAQ>
    <xmx:VYzOXhBTfelK_d_hVWUisDA-XZTd_wFDVYh5sXsrgohnm3gNTCTFDg>
    <xmx:VYzOXmhnDRCluHNwrNfNoH_BJ5KRI4DYceXup1CumSIaQYDlSqG3fQ>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id E9F5F3061CCB;
        Wed, 27 May 2020 11:50:44 -0400 (EDT)
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
Subject: [PATCH v3 055/105] drm/vc4: hvs: Introduce a function to get the assigned FIFO
Date:   Wed, 27 May 2020 17:48:25 +0200
Message-Id: <f1b1737fe0665e7191c3d2a3cd9bfafb831866be.1590594512.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.aaf2100bd7da4609f8bcb8216247d4b4e4379639.1590594512.git-series.maxime@cerno.tech>
References: <cover.aaf2100bd7da4609f8bcb8216247d4b4e4379639.1590594512.git-series.maxime@cerno.tech>
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

Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_drv.h |  1 +-
 drivers/gpu/drm/vc4/vc4_hvs.c | 51 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 52 insertions(+)

diff --git a/drivers/gpu/drm/vc4/vc4_drv.h b/drivers/gpu/drm/vc4/vc4_drv.h
index d51b695732e0..99001f8783aa 100644
--- a/drivers/gpu/drm/vc4/vc4_drv.h
+++ b/drivers/gpu/drm/vc4/vc4_drv.h
@@ -880,6 +880,7 @@ void vc4_irq_reset(struct drm_device *dev);
 /* vc4_hvs.c */
 extern struct platform_driver vc4_hvs_driver;
 void vc4_hvs_stop_channel(struct drm_device *dev, unsigned int output);
+int vc4_hvs_get_fifo_from_output(struct drm_device *dev, unsigned int output);
 int vc4_hvs_atomic_check(struct drm_crtc *crtc, struct drm_crtc_state *state);
 void vc4_hvs_atomic_enable(struct drm_crtc *crtc, struct drm_crtc_state *old_state);
 void vc4_hvs_atomic_disable(struct drm_crtc *crtc, struct drm_crtc_state *old_state);
diff --git a/drivers/gpu/drm/vc4/vc4_hvs.c b/drivers/gpu/drm/vc4/vc4_hvs.c
index 1785c49534cf..56657959778f 100644
--- a/drivers/gpu/drm/vc4/vc4_hvs.c
+++ b/drivers/gpu/drm/vc4/vc4_hvs.c
@@ -19,6 +19,7 @@
  * each CRTC.
  */
 
+#include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/component.h>
 #include <linux/platform_device.h>
@@ -196,6 +197,56 @@ static void vc4_hvs_update_gamma_lut(struct drm_crtc *crtc)
 	vc4_hvs_lut_load(crtc);
 }
 
+int vc4_hvs_get_fifo_from_output(struct drm_device *dev, unsigned int output)
+{
+	struct vc4_dev *vc4 = to_vc4_dev(dev);
+	u32 reg;
+	int ret;
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
