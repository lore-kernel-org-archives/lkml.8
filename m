Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFA07C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:51:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 824DA20776
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:51:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="ImXknI2V";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JO5gx/b9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730705AbgE0Pvw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 11:51:52 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:51295 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390235AbgE0PvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 11:51:01 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id A067E5820E1;
        Wed, 27 May 2020 11:51:00 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 27 May 2020 11:51:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=7Xm21xCure/jt
        b8FF3BBKZuJ/ZJTfcJibB388wH3Rbg=; b=ImXknI2VBQ/yOE0Z8pCse8QpBGY+p
        zsBpjgT/3nSSoAcxeEPu/ExEvs03dEOWFd/RuT5jHWYQAMr/jwfJ2X38dcXdtWL5
        Dqr6lZbqvHoxj+9LjTk88HHOeekUgpeI3FoNuDVxL9wjZD3K9MpzbphYS+69j/3Q
        tjz5Vo+6gUmcXdsTz18h4isNN/ZndhyhmQNofAwGx9kpMpC8CuLQ0k3g3mMHgs7y
        DKDvweym7qzQURzzsATelEzaupRLRCk4YhDpg+c9pu/cu/OvDl9EcbNoo8LmQnl+
        OC5IngYqspHGSKTtVSkufEM5ujzSS8LuCry55Fp/q3ezqyQjn5+v/c1cA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=7Xm21xCure/jtb8FF3BBKZuJ/ZJTfcJibB388wH3Rbg=; b=JO5gx/b9
        Cf+YGrOm2Ks96QyE7IPVXQVyx+xrsmbRLUvS79W6MLNUw7kHULHOXVSMRUjf4y5i
        gDZ34a4gIQn/rvs8J4kg9XBEZWBngAeNXZAsM4gj8ESN2MlRQdn4e8kBnViqRzj6
        t5H6/LzXMEBGzIRA5lXKTLG53VqGBgakUbOj9xKeYwC1UorLQXxH3UrmUvdmXZ1e
        wRdN1X5CLHkXjVjFpVmZyKrB/s5T4Nb75JZBIE0YB/vi8wHFGl4K05Wv7gH1Jcw1
        x20mh/SFyzhr98+Kg/4buVTUSx0JZ9e3fNJ8hdiJ2cLmJjk8d/Kto9qEYJeCQIRD
        cOtC0RhS2SxZnw==
X-ME-Sender: <xms:ZIzOXqYTkzaOXIwjN1piJRO6xGlDK78u9tgt37AG_KVAHznQkMVBnA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedruddvgedgkeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepgeegne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:ZIzOXtadRLmP7281uZBf1p5uLPQj5ZLbauhh6Vd6xGmakiH7j6qIRA>
    <xmx:ZIzOXk_QrZQDoLU5zLf-pj4v2R3V3qgpAuJ-9Orf3wS_F7naDqbvmQ>
    <xmx:ZIzOXsoX4EbKY8KyWO_YxUUndlLiy1u0db7QwWyyoEF77yN99pge7A>
    <xmx:ZIzOXpJJCUtGKoAeYU4qMR6h3M5LEENyKD27A93g8z0WO9-T2y6BgA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 3F11930618B7;
        Wed, 27 May 2020 11:51:00 -0400 (EDT)
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
Subject: [PATCH v3 065/105] drm/vc4: crtc: Move the txp_armed function to the TXP
Date:   Wed, 27 May 2020 17:48:35 +0200
Message-Id: <338f129930b6730eff4409a4f30a49100c96f722.1590594512.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.aaf2100bd7da4609f8bcb8216247d4b4e4379639.1590594512.git-series.maxime@cerno.tech>
References: <cover.aaf2100bd7da4609f8bcb8216247d4b4e4379639.1590594512.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The TXP driver is the only place where we need to set the txp_armed flag,
so let's move the function in the TXP driver.

Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_crtc.c |  7 -------
 drivers/gpu/drm/vc4/vc4_drv.h  |  1 -
 drivers/gpu/drm/vc4/vc4_txp.c  |  9 ++++++++-
 3 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_crtc.c b/drivers/gpu/drm/vc4/vc4_crtc.c
index d284596ec048..fbddd38ba6a9 100644
--- a/drivers/gpu/drm/vc4/vc4_crtc.c
+++ b/drivers/gpu/drm/vc4/vc4_crtc.c
@@ -483,13 +483,6 @@ static void vc4_crtc_atomic_disable(struct drm_crtc *crtc,
 	}
 }
 
-void vc4_crtc_txp_armed(struct drm_crtc_state *state)
-{
-	struct vc4_crtc_state *vc4_state = to_vc4_crtc_state(state);
-
-	vc4_state->txp_armed = true;
-}
-
 static void vc4_crtc_atomic_enable(struct drm_crtc *crtc,
 				   struct drm_crtc_state *old_state)
 {
diff --git a/drivers/gpu/drm/vc4/vc4_drv.h b/drivers/gpu/drm/vc4/vc4_drv.h
index 999841b1edd8..e14ed9799ecc 100644
--- a/drivers/gpu/drm/vc4/vc4_drv.h
+++ b/drivers/gpu/drm/vc4/vc4_drv.h
@@ -831,7 +831,6 @@ void vc4_crtc_destroy_state(struct drm_crtc *crtc,
 			    struct drm_crtc_state *state);
 void vc4_crtc_reset(struct drm_crtc *crtc);
 void vc4_crtc_handle_vblank(struct vc4_crtc *crtc);
-void vc4_crtc_txp_armed(struct drm_crtc_state *state);
 void vc4_crtc_get_margins(struct drm_crtc_state *state,
 			  unsigned int *right, unsigned int *left,
 			  unsigned int *top, unsigned int *bottom);
diff --git a/drivers/gpu/drm/vc4/vc4_txp.c b/drivers/gpu/drm/vc4/vc4_txp.c
index bf720206727f..d9a8ab87ad25 100644
--- a/drivers/gpu/drm/vc4/vc4_txp.c
+++ b/drivers/gpu/drm/vc4/vc4_txp.c
@@ -222,6 +222,13 @@ static const u32 txp_fmts[] = {
 	TXP_FORMAT_BGRA8888,
 };
 
+static void vc4_txp_armed(struct drm_crtc_state *state)
+{
+	struct vc4_crtc_state *vc4_state = to_vc4_crtc_state(state);
+
+	vc4_state->txp_armed = true;
+}
+
 static int vc4_txp_connector_atomic_check(struct drm_connector *conn,
 					  struct drm_atomic_state *state)
 {
@@ -256,7 +263,7 @@ static int vc4_txp_connector_atomic_check(struct drm_connector *conn,
 	if (fb->pitches[0] & GENMASK(3, 0))
 		return -EINVAL;
 
-	vc4_crtc_txp_armed(crtc_state);
+	vc4_txp_armed(crtc_state);
 
 	return 0;
 }
-- 
git-series 0.9.1
