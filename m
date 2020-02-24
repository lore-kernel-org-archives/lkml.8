Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71931C3567B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 09:11:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C11F20658
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 09:11:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="vfKbFpt/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Uhl8WNmV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728312AbgBXJKn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 04:10:43 -0500
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:60409 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727619AbgBXJKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 04:10:39 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id 03A37647;
        Mon, 24 Feb 2020 04:10:37 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 24 Feb 2020 04:10:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=k5rHIZCQqyFit
        FdSYMhQftJVPXYFXpjC9sqwflJAvrE=; b=vfKbFpt/wSMF5Cuc3sQRodFF330Rq
        QyYFOEbijd/PKuP47iU8FW1VmO0fmQF05H0caJMiCrQiMzBl7wmUlnSYMjD85s6h
        dwJjOmtKYgkuNfRExmpw8FNTvss2GT3LyRPEU++gakuJwvkL0Ztq4KcVEciZfgOX
        F8xMyh3rGV+1z6rJgHmWmd2oKbbd5fUfYuX78u6aFfWuiIMTW1eZA1l5zkfbDz7C
        CHcTP+hbp3ZUIqdeSZ2NNUbInIWZrho5SNXe4KQnAgbGXwy7EwLrKuz+I2YQZWZY
        sdyRwxykQXZ+eeaOXfYW6FJ4SE5jpzHWD7DFevnKTPD2xcy2DHeKtK5Tg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=k5rHIZCQqyFitFdSYMhQftJVPXYFXpjC9sqwflJAvrE=; b=Uhl8WNmV
        4sbAQbKWOGkTMx1lZjdhdYQjOZ5yAq4SCAutJ+MAWvzLnpccYf0B7fLfMbEMaj+T
        Vhfig7mCQLvCgVRwSgYitr7He4EpeYgmlP7+HbA2tM2+RxDRkY2Sle3kAAcKJ1LU
        eCrjSslycjR5h6Vhbw7tWAhpeP4rr2OXc36ky1b9WsTaonUAkxTOukba0IOFR8je
        WYoIn2ipeR2qiwEC0gNbRaVmOHT3SPhlazqUl2xPSjK8Dj8VvC5c16fdpoebs2TC
        x1c4tzs0NsAHYc1UXUX8okA99rwywZoqL9GVgiU3Y0acYmf6l4MKeTyNZxuEDWho
        KvD1Y/N7Ixsp2g==
X-ME-Sender: <xms:DZNTXhVqTcP8bnqGDYRBIo-jrBnJQ-rsMfguCt9yfWirFnSMIuEeig>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrledtucetufdoteggodetrfdotffvucfrrh
    hofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhmvgcutfhi
    phgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecukfhppeeltddrkeelrd
    eikedrjeeinecuvehluhhsthgvrhfuihiivgepudegnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:DZNTXtBWNwXKE-T2Zer4WUqL48sQW88so1baWZ77jFWKe8fPfXzV_Q>
    <xmx:DZNTXg7qOeC0eag1QO8ZdXG9HOqtZUqfAZxb3qH3QZ2A6q5QXgvc4g>
    <xmx:DZNTXowiBoVEhOuqAz-NWH6HWF6Ja7uNRqtm2K2K53VHwcrgC0K_1A>
    <xmx:DZNTXsiHuNrC066C20bDe9vVCyyS6t1SNNsbQdzHSCxNQY3YIazFp1OOQMs>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 44E523060FCB;
        Mon, 24 Feb 2020 04:10:37 -0500 (EST)
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
Subject: [PATCH 75/89] drm/vc4: hdmi: Add PHY init and disable function
Date:   Mon, 24 Feb 2020 10:07:17 +0100
Message-Id: <2ebcffada98f6a900b6c0651eb4c35ae6f75f901.1582533919.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.6c896ace9a5a7840e9cec008b553cbb004ca1f91.1582533919.git-series.maxime@cerno.tech>
References: <cover.6c896ace9a5a7840e9cec008b553cbb004ca1f91.1582533919.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The HDMI PHY in the BCM2711 HDMI controller is significantly more
complicated to setup than in the older BCM283x SoCs.

Let's add hooks to enable and disable the PHY.

Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/Makefile       |  1 +
 drivers/gpu/drm/vc4/vc4_hdmi.c     | 14 +++++++-------
 drivers/gpu/drm/vc4/vc4_hdmi.h     | 14 ++++++++++++++
 drivers/gpu/drm/vc4/vc4_hdmi_phy.c | 25 +++++++++++++++++++++++++
 4 files changed, 47 insertions(+), 7 deletions(-)
 create mode 100644 drivers/gpu/drm/vc4/vc4_hdmi_phy.c

diff --git a/drivers/gpu/drm/vc4/Makefile b/drivers/gpu/drm/vc4/Makefile
index b303703bc7f3..d0163e18e9ca 100644
--- a/drivers/gpu/drm/vc4/Makefile
+++ b/drivers/gpu/drm/vc4/Makefile
@@ -12,6 +12,7 @@ vc4-y := \
 	vc4_kms.o \
 	vc4_gem.o \
 	vc4_hdmi.o \
+	vc4_hdmi_phy.o \
 	vc4_vec.o \
 	vc4_hvs.o \
 	vc4_irq.o \
diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index 29e94eee9f23..14c5ce4e7010 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -323,7 +323,9 @@ static void vc4_hdmi_encoder_disable(struct drm_encoder *encoder)
 
 	HDMI_WRITE(HDMI_RAM_PACKET_CONFIG, 0);
 
-	HDMI_WRITE(HDMI_TX_PHY_RESET_CTL, 0xf << 16);
+	if (vc4_hdmi->variant->phy_disable)
+		vc4_hdmi->variant->phy_disable(vc4_hdmi);
+
 	HDMI_WRITE(HDMI_VID_CTL,
 		   HDMI_READ(HDMI_VID_CTL) & ~VC4_HD_VID_CTL_ENABLE);
 
@@ -383,12 +385,8 @@ static void vc4_hdmi_encoder_enable(struct drm_encoder *encoder)
 	if (vc4_hdmi->variant->reset)
 		vc4_hdmi->variant->reset(vc4_hdmi);
 
-	/* PHY should be in reset, like
-	 * vc4_hdmi_encoder_disable() does.
-	 */
-	HDMI_WRITE(HDMI_TX_PHY_RESET_CTL, 0xf << 16);
-
-	HDMI_WRITE(HDMI_TX_PHY_RESET_CTL, 0);
+	if (vc4_hdmi->variant->phy_init)
+		vc4_hdmi->variant->phy_init(vc4_hdmi, mode);
 
 	if (debug_dump_regs) {
 		struct drm_printer p = drm_info_printer(&vc4_hdmi->pdev->dev);
@@ -1413,6 +1411,8 @@ struct vc4_hdmi_variant bcm2835_variant = {
 
 	.init_resources		= vc4_hdmi_init_resources,
 	.reset			= vc4_hdmi_reset,
+	.phy_init		= vc4_hdmi_phy_init,
+	.phy_disable		= vc4_hdmi_phy_disable,
 };
 
 static const struct of_device_id vc4_hdmi_dt_match[] = {
diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.h b/drivers/gpu/drm/vc4/vc4_hdmi.h
index 270397c9e800..39ae5273f36b 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.h
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.h
@@ -21,6 +21,9 @@ to_vc4_hdmi_encoder(struct drm_encoder *encoder)
 	return container_of(encoder, struct vc4_hdmi_encoder, base.base);
 }
 
+struct drm_display_mode;
+
+struct vc4_hdmi;
 struct vc4_hdmi_register;
 
 struct vc4_hdmi_variant {
@@ -37,6 +40,13 @@ struct vc4_hdmi_variant {
 
 	/* Callback to reset the HDMI block */
 	void (*reset)(struct vc4_hdmi *vc4_hdmi);
+
+	/* Callback to initialize the PHY according to the mode */
+	void (*phy_init)(struct vc4_hdmi *vc4_hdmi,
+			 struct drm_display_mode *mode);
+
+	/* Callback to disable the PHY */
+	void (*phy_disable)(struct vc4_hdmi *vc4_hdmi);
 };
 
 /* HDMI audio information */
@@ -94,4 +104,8 @@ encoder_to_vc4_hdmi(struct drm_encoder *encoder)
 	return container_of(_encoder, struct vc4_hdmi, encoder);
 }
 
+void vc4_hdmi_phy_init(struct vc4_hdmi *vc4_hdmi,
+		       struct drm_display_mode *mode);
+void vc4_hdmi_phy_disable(struct vc4_hdmi *vc4_hdmi);
+
 #endif /* _VC4_HDMI_H_ */
diff --git a/drivers/gpu/drm/vc4/vc4_hdmi_phy.c b/drivers/gpu/drm/vc4/vc4_hdmi_phy.c
new file mode 100644
index 000000000000..26d6ee08edcf
--- /dev/null
+++ b/drivers/gpu/drm/vc4/vc4_hdmi_phy.c
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2015 Broadcom
+ * Copyright (c) 2014 The Linux Foundation. All rights reserved.
+ * Copyright (C) 2013 Red Hat
+ * Author: Rob Clark <robdclark@gmail.com>
+ */
+
+#include "vc4_hdmi.h"
+#include "vc4_hdmi_regs.h"
+
+void vc4_hdmi_phy_init(struct vc4_hdmi *vc4_hdmi, struct drm_display_mode *mode)
+{
+	/* PHY should be in reset, like
+         * vc4_hdmi_encoder_disable() does.
+         */
+
+	HDMI_WRITE(HDMI_TX_PHY_RESET_CTL, 0xf << 16);
+	HDMI_WRITE(HDMI_TX_PHY_RESET_CTL, 0);
+}
+
+void vc4_hdmi_phy_disable(struct vc4_hdmi *vc4_hdmi)
+{
+	HDMI_WRITE(HDMI_TX_PHY_RESET_CTL, 0xf << 16);
+}
-- 
git-series 0.9.1
