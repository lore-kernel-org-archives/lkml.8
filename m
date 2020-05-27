Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E618CC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:56:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3E4D20873
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:56:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="fYBAxbLd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="S50iwG11"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729338AbgE0PuN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 11:50:13 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:38329 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390190AbgE0PuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 11:50:00 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id F391A582047;
        Wed, 27 May 2020 11:49:58 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 27 May 2020 11:49:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=Pxu7vA5Ztijwd
        iw3yLEGYhK1l1UJ+hr3CS6N4Y76y48=; b=fYBAxbLd98sy8dK67SHNOEzOO077K
        UzkZGNQZTYfiR8bpvhKS1EzxRbEgATF5KbBjqt48Lsj9Vc8rKBphZ+jPkZ6WtSik
        SYumh3bPHig18CVgoxuBPf7hbpNob1NuzFgKsN9oTL+WTdR1OleVXOF26zQp8Xp2
        VsruCU+gnly9kLlmZRJlQy+K+jwmlNQWoaasXVGKtgXtcjot/CU/7i+2uVf0e6PO
        LR9Bs/6MX6Nfmd56UdiOGeo9NrewKCsMGSSmUWd5G8MA6Uchz1TyfYt3xJTpnItT
        zXvIBjQYAoeG2nU7QjXCZnXtas4ry9ZAp+iOBfO7lIZVsRIy9mi5x6+Fw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=Pxu7vA5Ztijwdiw3yLEGYhK1l1UJ+hr3CS6N4Y76y48=; b=S50iwG11
        xmYOc8ssPxOQL/ispbjNy4wwvKOVG67Ji/LBVK/q906PgkrEahq/ny1YTUPmZLmG
        RCsDXTMb2Xt1cw5OfBAPz+r8JukKpcA+J0td75VPiUXcaV72hGn2JzeVN+eDrrLl
        ibdkKSTTQQ5yW2yqwnGf6G4zeiago+u+ieuXoJdhdKqkd+VeTljHOf0/xfguNwyy
        HvuY/ztFNqUde44v01APswKhNN5dZX5QU7qCr0yf/40PqMQVwBwvzO8KAoz28q0W
        KB32TLlmrPOpy66UbWvuL7fwlcBXJW7gJEGRj3tOYdp5UmdSpBB9TeV34UqZ2vdr
        DiblzDH02BKXCA==
X-ME-Sender: <xms:JozOXi9BDjxQEewzf0thTjoo-yLetDggu2LkItqM2uXScH0NxBijwQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedruddvgedgkeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepjeenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:JozOXisX7IGRjnvn5m6xH4oYzbmnp9HSF09dYFoGOfI7h5JjebPizQ>
    <xmx:JozOXoDXWgvgXS2umQAck0Vvw2ntE-Ed0dbTc7JNmDMF-6u62G578w>
    <xmx:JozOXqctLmLyK19jIqq6QtFkRHPL6J3zuqnaEzXj0uGu-30B9H5D4w>
    <xmx:JozOXifCBWe1my8-h0gaJgxDXlkrhGqgnmMVeAkKtE0WuwHSfQvMgg>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 957AC3061856;
        Wed, 27 May 2020 11:49:58 -0400 (EDT)
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
Subject: [PATCH v3 027/105] drm/vc4: crtc: Turn static const variable into a define
Date:   Wed, 27 May 2020 17:47:57 +0200
Message-Id: <8535c679f79af8abaa1b7796261bfeda11f874fd.1590594512.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.aaf2100bd7da4609f8bcb8216247d4b4e4379639.1590594512.git-series.maxime@cerno.tech>
References: <cover.aaf2100bd7da4609f8bcb8216247d4b4e4379639.1590594512.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hvs_latency_pix variable doesn't need to be a variable and can just be
defined.

Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_crtc.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_crtc.c b/drivers/gpu/drm/vc4/vc4_crtc.c
index fd248ee546e8..8dbf06cdb069 100644
--- a/drivers/gpu/drm/vc4/vc4_crtc.c
+++ b/drivers/gpu/drm/vc4/vc4_crtc.c
@@ -44,6 +44,8 @@
 #include "vc4_drv.h"
 #include "vc4_regs.h"
 
+#define HVS_FIFO_LATENCY_PIX	6
+
 #define CRTC_WRITE(offset, val) writel(val, vc4_crtc->regs + (offset))
 #define CRTC_READ(offset) readl(vc4_crtc->regs + (offset))
 
@@ -231,18 +233,17 @@ vc4_crtc_update_gamma_lut(struct drm_crtc *crtc)
 static u32 vc4_get_fifo_full_level(u32 format)
 {
 	static const u32 fifo_len_bytes = 64;
-	static const u32 hvs_latency_pix = 6;
 
 	switch (format) {
 	case PV_CONTROL_FORMAT_DSIV_16:
 	case PV_CONTROL_FORMAT_DSIC_16:
-		return fifo_len_bytes - 2 * hvs_latency_pix;
+		return fifo_len_bytes - 2 * HVS_FIFO_LATENCY_PIX;
 	case PV_CONTROL_FORMAT_DSIV_18:
 		return fifo_len_bytes - 14;
 	case PV_CONTROL_FORMAT_24:
 	case PV_CONTROL_FORMAT_DSIV_24:
 	default:
-		return fifo_len_bytes - 3 * hvs_latency_pix;
+		return fifo_len_bytes - 3 * HVS_FIFO_LATENCY_PIX;
 	}
 }
 
-- 
git-series 0.9.1
