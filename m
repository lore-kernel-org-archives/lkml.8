Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49056C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:51:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FD72208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:51:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="yGj2WBWf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="C5KeHyMO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390241AbgE0PvC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 11:51:02 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:59645 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730574AbgE0Pug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 11:50:36 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 24771582091;
        Wed, 27 May 2020 11:50:35 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 27 May 2020 11:50:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=hn1mG4jcbIIbo
        0o9ITAXWH7T5+mqDrg6shUmeSL5Ixs=; b=yGj2WBWf7aNTKqe1XIdQP4IugcG9G
        TuzE15VYtv8mLN71gqg4eV581al6ajI26dzIllgwH27l3dnkV+2BaP1f9IR+rnor
        DU7qpFnW0P5kgua31cubGUsyTCeoRQSIt4YyaMelcQkzgnnohDQtuFYjBHsgVD7G
        ikup90t+Cu+pC+5N3/QRUOZPoHaV5tiBDWPl4ujvSvCkNfOrcqKz75MjPXpLycz6
        Capu3XGBShRlvZuU9gTUxktRy7MgcvZj4ldZwrn1ks+aNXDuWbBmO2xYjGAldHkD
        jik0JVaEEUtKaPbJXlaKtG5If3HJOgSPE2HJRd9lXWx5AaoZFaiCNO14Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=hn1mG4jcbIIbo0o9ITAXWH7T5+mqDrg6shUmeSL5Ixs=; b=C5KeHyMO
        TOkvrTlxF/7oCvfP3SWDCIWcAEREFST4OiTEdFsZA0p7TaczWuc72n008+yJBISr
        aKsYXfYKCYbk/yiOpWCEs83P9JCwmd+DLpXYQ7cABrv8s6O1NMRqiEmK0QLBBkFC
        xCB69EglMkj2r3PGVtP5Fkcu2rteC5KKVu5Fe0eOfE21GkK3Iqg89XHftbeRDnVO
        OmB4Oi99OmXEBub/5GpLsoDBbFXiZ/ir28g6bJZXGptyX6GXdqtxtywVUX5fvvNL
        TxXhK2CgEvq54RoQrrL69yAe4ydssNVzFmUpP7M8a/wDJ2n/2/YkiE4taGBEfNQi
        ceGKr3ZvL121Jw==
X-ME-Sender: <xms:SozOXmDJWrCkdo2nd4Lz7cJR6MfsSZV_MwwY7COZ57Df3OHAbZtSHQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedruddvgedgkeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepvdelne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:S4zOXggaCtR7hg7cv6dn4bg-ezlvtNObeeOTXozymM7UzWsqYoMPHw>
    <xmx:S4zOXpmdcELaqVxt9UWNNvBxbIAAdgyjqM2Qnf4pVTCkfmco4eWIYw>
    <xmx:S4zOXkz8ebPac6UM5GKPlDcb6nlZ3Ubz3z2cP6dKQROyl29jMFqrRQ>
    <xmx:S4zOXkQ2zqijMys-l8NIkgkAoUPUu-AOPkB3dc5bVHAj-IWCMLiRTw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id B3C2D306218B;
        Wed, 27 May 2020 11:50:34 -0400 (EDT)
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
Subject: [PATCH v3 049/105] drm/vc4: crtc: Move HVS channel init before the PV initialisation
Date:   Wed, 27 May 2020 17:48:19 +0200
Message-Id: <04fdaf2379fbb315a1e73d44139e9205490e7a6b.1590594512.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.aaf2100bd7da4609f8bcb8216247d4b4e4379639.1590594512.git-series.maxime@cerno.tech>
References: <cover.aaf2100bd7da4609f8bcb8216247d4b4e4379639.1590594512.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to avoid stale pixels getting stuck in an intermediate FIFO
between the HVS and the pixelvalve on BCM2711, we need to configure the HVS
channel before the pixelvalve is reset and configured.

Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_crtc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_crtc.c b/drivers/gpu/drm/vc4/vc4_crtc.c
index 3c9b0d684136..83fb5ba19b43 100644
--- a/drivers/gpu/drm/vc4/vc4_crtc.c
+++ b/drivers/gpu/drm/vc4/vc4_crtc.c
@@ -433,11 +433,6 @@ static void vc4_crtc_atomic_enable(struct drm_crtc *crtc,
 
 	require_hvs_enabled(dev);
 
-	if (!vc4_state->feed_txp)
-		vc4_crtc_config_pv(crtc);
-
-	CRTC_WRITE(PV_CONTROL, CRTC_READ(PV_CONTROL) | PV_CONTROL_EN);
-
 	/* Enable vblank irq handling before crtc is started otherwise
 	 * drm_crtc_get_vblank() fails in vc4_crtc_update_dlist().
 	 */
@@ -445,6 +440,11 @@ static void vc4_crtc_atomic_enable(struct drm_crtc *crtc,
 
 	vc4_hvs_atomic_enable(crtc, old_state);
 
+	if (!vc4_state->feed_txp)
+		vc4_crtc_config_pv(crtc);
+
+	CRTC_WRITE(PV_CONTROL, CRTC_READ(PV_CONTROL) | PV_CONTROL_EN);
+
 	/* When feeding the transposer block the pixelvalve is unneeded and
 	 * should not be enabled.
 	 */
-- 
git-series 0.9.1
