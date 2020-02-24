Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E716C3567B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 09:10:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFEBE20866
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 09:09:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="mjMpcBn3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="0cSn/KUr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728030AbgBXJJ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 04:09:58 -0500
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:52995 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727962AbgBXJJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 04:09:54 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id 47E41616;
        Mon, 24 Feb 2020 04:09:53 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 24 Feb 2020 04:09:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=BZ8qwxiUvBZQ8
        XCeOSM3aeENgF1M6Ek2r+XXrpD++oU=; b=mjMpcBn3VEn4Gs90PJobNhLX2RuUb
        BflwJrrAag3d6nTqtlDu24NAzO3nhtFRs+ZfN/8Thv3WYOooHzCemH7dzdZt5AiP
        OA7mXEDA6aKIMkgFPeLe/2o/E/odOm3FDKfUrNiSqSJeG2fcox9PJ9oMgXWJ0OTe
        pqBJg0Gpo7Ogr4RGnM2vF/e9eeRo0ya+wGdslASNv15wAkd3LSo8qfekwf387oP/
        opNHmTL8xeGPXcSBlLe8igHjaUkhGqDuiM5LMjEzFDY2x9ZeSufcio1/DYfI7ox9
        UA0wepbXSCHmAxvrwcAvyImkQRew0ubQ+0N8mkex5l7ovhRaQ/F9iW+Pg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=BZ8qwxiUvBZQ8XCeOSM3aeENgF1M6Ek2r+XXrpD++oU=; b=0cSn/KUr
        E6BGzZgjxL/czDTV+0FL37QBGDimVzDe70HCgfbg59q00D/G9//O3BQpqJk0X+g7
        MBCorlzMe8x+GvkCM3CKiMyZ8h65E2yEpNdIft2huQ6JuccNKtge96ol9rlsLO2L
        77wJpqz1gvK9leA42tqThvApBGHkwxvqc88wx2R6fyBe+1vWwslPxqGzFhDMZwEd
        SgOJ4mMZroYJ+HZTwc9+2OkOlmaCGX2mr+zmKCjnLQECGgOqEQlP+PvvmxAYHn+8
        T9juDgpK8O2U0GrHeaffKvXpXTDlGvarRmn5J6h+uLxWTBvtxdE8lJxpsXb0ghqO
        CnUhOS9C41WgDA==
X-ME-Sender: <xms:4JJTXjuN0lM882kL32HTTu8YYRbTQRs921Ri9aYF4bCglsWUPN_1sA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrledtucetufdoteggodetrfdotffvucfrrh
    hofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhmvgcutfhi
    phgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecukfhppeeltddrkeelrd
    eikedrjeeinecuvehluhhsthgvrhfuihiivgepfeehnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:4JJTXi9OgsXoroxAkvZlBf8Ts6Z27TUrPWeF9SiFg65zpj9atAjybQ>
    <xmx:4JJTXhmrfQP8zLUWzz8ZtJIi8X8bI-hJUAtggzXkgy5Y-vUGCMG4iw>
    <xmx:4JJTXobbvLJscED640_8uQ3q5qWWkGcVY9E4v1mBgS7PPigHS06zgw>
    <xmx:4JJTXibTrcp4CZaO4d1jweq6jp3m-mxxVZCkfzdj3ajJGy6rpFxeC1HNG6s>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 8373A328005D;
        Mon, 24 Feb 2020 04:09:52 -0500 (EST)
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
Subject: [PATCH 44/89] drm/vc4: crtc: Move crtc state to common header
Date:   Mon, 24 Feb 2020 10:06:46 +0100
Message-Id: <7cd63487d785ccad68c847d9bbf6afe867996e5e.1582533919.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.6c896ace9a5a7840e9cec008b553cbb004ca1f91.1582533919.git-series.maxime@cerno.tech>
References: <cover.6c896ace9a5a7840e9cec008b553cbb004ca1f91.1582533919.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We'll need to access the crtc_state from outside of vc4_crtc.c, so let's
move it to vc4_drv.h

Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_crtc.c | 21 ---------------------
 drivers/gpu/drm/vc4/vc4_drv.h  | 21 +++++++++++++++++++++
 2 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_crtc.c b/drivers/gpu/drm/vc4/vc4_crtc.c
index ce902d31f92c..0f8446e4a397 100644
--- a/drivers/gpu/drm/vc4/vc4_crtc.c
+++ b/drivers/gpu/drm/vc4/vc4_crtc.c
@@ -44,27 +44,6 @@
 #include "vc4_drv.h"
 #include "vc4_regs.h"
 
-struct vc4_crtc_state {
-	struct drm_crtc_state base;
-	/* Dlist area for this CRTC configuration. */
-	struct drm_mm_node mm;
-	bool feed_txp;
-	bool txp_armed;
-
-	struct {
-		unsigned int left;
-		unsigned int right;
-		unsigned int top;
-		unsigned int bottom;
-	} margins;
-};
-
-static inline struct vc4_crtc_state *
-to_vc4_crtc_state(struct drm_crtc_state *crtc_state)
-{
-	return (struct vc4_crtc_state *)crtc_state;
-}
-
 #define CRTC_WRITE(offset, val) writel(val, vc4_crtc->regs + (offset))
 #define CRTC_READ(offset) readl(vc4_crtc->regs + (offset))
 
diff --git a/drivers/gpu/drm/vc4/vc4_drv.h b/drivers/gpu/drm/vc4/vc4_drv.h
index 07318badf82c..0aa3a9e64ea0 100644
--- a/drivers/gpu/drm/vc4/vc4_drv.h
+++ b/drivers/gpu/drm/vc4/vc4_drv.h
@@ -484,6 +484,27 @@ to_vc4_crtc(struct drm_crtc *crtc)
 	return (struct vc4_crtc *)crtc;
 }
 
+struct vc4_crtc_state {
+	struct drm_crtc_state base;
+	/* Dlist area for this CRTC configuration. */
+	struct drm_mm_node mm;
+	bool feed_txp;
+	bool txp_armed;
+
+	struct {
+		unsigned int left;
+		unsigned int right;
+		unsigned int top;
+		unsigned int bottom;
+	} margins;
+};
+
+static inline struct vc4_crtc_state *
+to_vc4_crtc_state(struct drm_crtc_state *crtc_state)
+{
+	return (struct vc4_crtc_state *)crtc_state;
+}
+
 #define V3D_READ(offset) readl(vc4->v3d->regs + offset)
 #define V3D_WRITE(offset, val) writel(val, vc4->v3d->regs + offset)
 #define HVS_READ(offset) readl(vc4->hvs->regs + offset)
-- 
git-series 0.9.1
