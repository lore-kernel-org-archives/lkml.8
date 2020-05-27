Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B47CEC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:52:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89A8F2088E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:52:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="sVRlM84x";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="J2/RQ2kR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390431AbgE0PwR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 11:52:17 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:53493 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730592AbgE0Pv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 11:51:28 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id D3F575814F9;
        Wed, 27 May 2020 11:51:26 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 27 May 2020 11:51:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=Qt9/P4yukHV2B
        TUxxyxl9vY352xX2ptPfPzVLjzzRFg=; b=sVRlM84xe3TyV0NPrwgJBwH7ZsZAM
        MklsRzKl5y8mqAaxIjVJfMCCzXWCLoLw1lOiDVR38y92KDT6erd1dxqbpFAuOcYs
        jD/IUd/4Idc5i2IxJbNEGSjWbrqtEMpAiPiXE39KOK3SbaOcOI/WcuFxdRmXAL1A
        iTv55a9sIv3Vsi+GDw6zEZ9nB+WeDuDKIkb+MsiERKL81YitJRKiW4RQHRsg2Rzz
        CECGngwsNIZSfIc87ba/VPw43Ga26aSEMfYJVWUJYXtbnYvZUfE+IYvAXhJPJmWu
        Yqk9wEFkhriC5aehnjBkZQFZYwTfkq7ajlWbKo9IwNLADp4dPgHTpEhJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=Qt9/P4yukHV2BTUxxyxl9vY352xX2ptPfPzVLjzzRFg=; b=J2/RQ2kR
        v98ruPKOf6pL1rocIL6Qq8IONCT+Kdz5cO+nRBnjzH2xmuhp9on7iQg89CSLJb53
        vPIkM01yg1d/uBJ9o0dvthq92FCAmYpWzknhKor+0T+wwK2kdkhZivE9mpj0FjaX
        sussLiepjHxHgLfmKlHqMWwXQuPH0RrUvwmCsGAvLVNVj9WWxwGkI0aE/QzyqduG
        qW2KRRQWeLoomrhsQFfi0Z8OCtuQ49+hXX2LsgzrwDS9TYmolUqVCxsO9EYoc6ze
        nQspnsjEVD1w0mcEb8RZbQw1R8Yc/hFKryjuy/k7oT+CkItQl9K8dKS5bIpiMaMy
        0p6+2Oqu8Wklkg==
X-ME-Sender: <xms:fozOXsb_v5XmlXhJaaxJF-_Yi8JNYEyV6XePpFHa2SHst1Cq9gYG_A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedruddvgedgkeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepheelne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:fozOXnbnCQnxw9FAZYgHPC53wNkGhGMIKi1TqUFYvl3mARhZz7m0PA>
    <xmx:fozOXm_pU2veX9JEoHkEzT8LGFlk-HeIPNIHqTtZBHKPdhBSaFGUkg>
    <xmx:fozOXmqKq88bTAK5_3mllqyVTqD5o9z4VpBwOXKz4SzWiBFuE0YBLw>
    <xmx:fozOXjI7NHNfBccefGtHERMKpJ85yKikb7u4znAgg7aG1oJtRUjjSw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 70284328005E;
        Wed, 27 May 2020 11:51:26 -0400 (EDT)
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
Subject: [PATCH v3 082/105] drm/vc4: hdmi: Add PHY init and disable function
Date:   Wed, 27 May 2020 17:48:52 +0200
Message-Id: <f56124810ee0dd417cefa40546d3302e61c828ed.1590594512.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.aaf2100bd7da4609f8bcb8216247d4b4e4379639.1590594512.git-series.maxime@cerno.tech>
References: <cover.aaf2100bd7da4609f8bcb8216247d4b4e4379639.1590594512.git-series.maxime@cerno.tech>
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
 drivers/gpu/drm/vc4/vc4_hdmi.h     | 13 +++++++++++++
 drivers/gpu/drm/vc4/vc4_hdmi_phy.c | 25 +++++++++++++++++++++++++
 4 files changed, 46 insertions(+), 7 deletions(-)
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
index dceff505c840..3d5e35aa96ff 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -321,7 +321,9 @@ static void vc4_hdmi_encoder_disable(struct drm_encoder *encoder)
 
 	HDMI_WRITE(HDMI_RAM_PACKET_CONFIG, 0);
 
-	HDMI_WRITE(HDMI_TX_PHY_RESET_CTL, 0xf << 16);
+	if (vc4_hdmi->variant->phy_disable)
+		vc4_hdmi->variant->phy_disable(vc4_hdmi);
+
 	HDMI_WRITE(HDMI_VID_CTL,
 		   HDMI_READ(HDMI_VID_CTL) & ~VC4_HD_VID_CTL_ENABLE);
 
@@ -381,12 +383,8 @@ static void vc4_hdmi_encoder_enable(struct drm_encoder *encoder)
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
@@ -1414,6 +1412,8 @@ static const struct vc4_hdmi_variant bcm2835_variant = {
 
 	.init_resources		= vc4_hdmi_init_resources,
 	.reset			= vc4_hdmi_reset,
+	.phy_init		= vc4_hdmi_phy_init,
+	.phy_disable		= vc4_hdmi_phy_disable,
 };
 
 static const struct of_device_id vc4_hdmi_dt_match[] = {
diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.h b/drivers/gpu/drm/vc4/vc4_hdmi.h
index 93695674c2d3..39ae5273f36b 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.h
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.h
@@ -21,6 +21,8 @@ to_vc4_hdmi_encoder(struct drm_encoder *encoder)
 	return container_of(encoder, struct vc4_hdmi_encoder, base.base);
 }
 
+struct drm_display_mode;
+
 struct vc4_hdmi;
 struct vc4_hdmi_register;
 
@@ -38,6 +40,13 @@ struct vc4_hdmi_variant {
 
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
@@ -95,4 +104,8 @@ encoder_to_vc4_hdmi(struct drm_encoder *encoder)
 	return container_of(_encoder, struct vc4_hdmi, encoder);
 }
 
+void vc4_hdmi_phy_init(struct vc4_hdmi *vc4_hdmi,
+		       struct drm_display_mode *mode);
+void vc4_hdmi_phy_disable(struct vc4_hdmi *vc4_hdmi);
+
 #endif /* _VC4_HDMI_H_ */
diff --git a/drivers/gpu/drm/vc4/vc4_hdmi_phy.c b/drivers/gpu/drm/vc4/vc4_hdmi_phy.c
new file mode 100644
index 000000000000..5a1746877bb5
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
+	 * vc4_hdmi_encoder_disable() does.
+	 */
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
