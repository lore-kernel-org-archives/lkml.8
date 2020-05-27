Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4032C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE921208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:56:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="vLOvYNlq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yQipRvmp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbgE0P4n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 11:56:43 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:51869 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728984AbgE0Ptz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 11:49:55 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 5E5CC58203B;
        Wed, 27 May 2020 11:49:54 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 27 May 2020 11:49:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=TRM6X4G5yvAqt
        +dJj7RIy+HHWn9k6iwxRb21u0ULa7A=; b=vLOvYNlqIOnZzt3gzwvw+h/q7oSO7
        N3b6FCRPQNWBBWfzFjaqSlmZmA8f2rS3WNN0jNpDyCkxT960aAv//iQbZc6Y1nfn
        4IFgHMrdj2Ji1XU3PKqOWm4JtkUQPXlVTAYE1sFbV3/f543anCjaJxD89EG9jmDD
        GLsAMKSo5WPtGBxLnOTSIxeRRysNUBMUSYtpkTjAaqZZkMNclnmrLQdgIxx4KRBK
        Av7MFsACa4/gNwyS1GbZvCsi7cMxfDD1/3b75vHzpZ9isEFSQH+HqaoAkB/OOT8X
        UW2hxaJFzl1WHBMsWdhRCh7Eis7F/2WEBd8uJzUADT782SJHCt+qccHYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=TRM6X4G5yvAqt+dJj7RIy+HHWn9k6iwxRb21u0ULa7A=; b=yQipRvmp
        FTGI469+E50yNwt8QK0Oq7C4vx/y+b669MY0NfBurwZLQfqSTVKc/P9oyBmc+cO0
        w1SOs2Q0z0ZFYfmz/86TZISsYT28aJu/j52vikxcQJs+SIwSiJQKxYFims8pEOO2
        t2LvVlanUineDOL8pDru4sq+rkDUTH2kZBd677YpebWHhDF/AVBQ09kI6rnWtQ/G
        jKzX1WUmqEJTowy/d2ILpmOF8qxN5drGMVXvseOmVvkcuiOCBhX4651C5AsvHzQd
        JwXJal8s+ltidOTkp9//HuSvYbzevvEtQyctgYqKUIMqARGsWiMsGZuOgUteZWlM
        4UtdF9QCIOHbbw==
X-ME-Sender: <xms:IozOXhk5sn-x8hHuZwpHJhsyhEevtbyEhdh7IdHQ0nJY4Qefg1k0Gg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedruddvgedgkeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepfeenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:IozOXs3hMBfbD7sPUcOAUHE61jJ1KlirWg2TPm9Y3K1ElYkc1PI1vg>
    <xmx:IozOXnqqCrH8b870EhDINuxQ421bFNkE9-K-Ch3U67q1Z7zujMpk2g>
    <xmx:IozOXhmeDzBkwG7Rw7mArJgk9xNhh7UGdm_ikUioDyLJMPhQ5mfH2Q>
    <xmx:IozOXkl5emjGhIWdFC54yor6rVcKPa22k5Soc0Q7svSrCdjyAUpaaQ>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id F287F328005A;
        Wed, 27 May 2020 11:49:53 -0400 (EDT)
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
Subject: [PATCH v3 024/105] drm/vc4: crtc: Move crtc state to common header
Date:   Wed, 27 May 2020 17:47:54 +0200
Message-Id: <1e6e563f9c75961e2885c9d648a3130d3b46b6d1.1590594512.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.aaf2100bd7da4609f8bcb8216247d4b4e4379639.1590594512.git-series.maxime@cerno.tech>
References: <cover.aaf2100bd7da4609f8bcb8216247d4b4e4379639.1590594512.git-series.maxime@cerno.tech>
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
index b668bb8d060c..db056dfe14df 100644
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
index 80633c488b04..329185a53a79 100644
--- a/drivers/gpu/drm/vc4/vc4_drv.h
+++ b/drivers/gpu/drm/vc4/vc4_drv.h
@@ -486,6 +486,27 @@ to_vc4_crtc(struct drm_crtc *crtc)
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
