Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D389C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:50:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0159020776
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:50:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="ipUT4Gq9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OA/7dW/l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730628AbgE0Puz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 11:50:55 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:45307 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727942AbgE0PuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 11:50:25 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 6E6F5582086;
        Wed, 27 May 2020 11:50:24 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 27 May 2020 11:50:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=4MdUDm80GBXGn
        TwBeiEDzegeC1j5S1JHHNoMQgIRATM=; b=ipUT4Gq9aHBrWYGGzoaRdCgFSZT9j
        sSTY29tqtyTlQLe09B9CmFeo6zvikfn6dXBIxOyIIGcoAj+ibvKfH53/QHoq3rwl
        egyOmZjNrtZVWie9pDORunzEfhUNPRRpb8vnseJfP2/NKMnGfpcJDHiuvLN+dOdl
        QeGtLLLwz6vhkcQbZsPuuFRBB6awKx12JXM7Wo6axMQgYZhgk9kjLeUxPKzM6MQk
        o3pXbBklTVICEkuU+bKhxBuZwy5OB8hlfpX5891baVd9f/4fG8ySQtqGuLBCBrOQ
        aGov/lD9WuI2kJt5HhJsJeZkGoH01EAyZ32mdyOVxlgzn5vU3wjql3QNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=4MdUDm80GBXGnTwBeiEDzegeC1j5S1JHHNoMQgIRATM=; b=OA/7dW/l
        TahIAL905j8wkxjSrCFj7Ahwz6Oz9EI9UlL7zQYtZVjiJN2M8f5B/NhTw8uSFHcU
        Ae/Q28QzNfIh6T52gZsHf2bH7LwvnqkoTTWVUHa/y1c7hwotZnatVga3LqjbrLNc
        CVPwLQhJJm51rly1MpUTzrtY721Y8WVDYVXcqFbq/4cU/vqzzC+0te4tE7I2FuEs
        H12lecQ147wElucaY2Tzsb/JF3hPeW5Rt2MseM+0Hx14pWSf6Qpq/ej8ljz3RTqq
        Db4I4gSWgL3etdC9T5o7uM6CzXXJxDXb3FuQeWXFT0rjvO1Obfoe6DA3TNOhMckG
        JwUeaDL05K4AjA==
X-ME-Sender: <xms:QIzOXilv0Q8MoafmhCpnWzaIWdjncYMaFe-GvlzgNKRg9xopGPifAA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedruddvgedgkeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepvddune
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:QIzOXp1GzTWHca9KlL73aku8sZcz419ZE6w28l57DDPPScyilNi6zw>
    <xmx:QIzOXgp39Iv9U_3NOdWwD6oKFohbN-gLnm7NAF_8kwBXXrP5EMzaMg>
    <xmx:QIzOXmkXJegQjj7PA4J63QPiTveoG2g2F621SoMWp76mBbmaH36b-w>
    <xmx:QIzOXhmyORXLsYDY6ZGS_lmwiMtr2I26ygma1s00GiWFgitPhDQuAA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 0FCA13280067;
        Wed, 27 May 2020 11:50:23 -0400 (EDT)
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
Subject: [PATCH v3 042/105] drm/vc4: crtc: Move PV dump to config_pv
Date:   Wed, 27 May 2020 17:48:12 +0200
Message-Id: <04750e39caf96b4ae2154732c138b8c21ad84825.1590594512.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.aaf2100bd7da4609f8bcb8216247d4b4e4379639.1590594512.git-series.maxime@cerno.tech>
References: <cover.aaf2100bd7da4609f8bcb8216247d4b4e4379639.1590594512.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_crtc.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_crtc.c b/drivers/gpu/drm/vc4/vc4_crtc.c
index 93161b98e22a..0a67b27cec9b 100644
--- a/drivers/gpu/drm/vc4/vc4_crtc.c
+++ b/drivers/gpu/drm/vc4/vc4_crtc.c
@@ -288,6 +288,14 @@ static void vc4_crtc_config_pv(struct drm_crtc *crtc)
 		       vc4_encoder->type == VC4_ENCODER_TYPE_DSI1);
 	u32 format = is_dsi ? PV_CONTROL_FORMAT_DSIV_24 : PV_CONTROL_FORMAT_24;
 	u8 ppc = vc4_crtc->data->pixels_per_clock;
+	bool debug_dump_regs = false;
+
+	if (debug_dump_regs) {
+		struct drm_printer p = drm_info_printer(&vc4_crtc->pdev->dev);
+		dev_info(&vc4_crtc->pdev->dev, "CRTC %d regs before:\n",
+			 drm_crtc_index(crtc));
+		drm_print_regset32(&p, &vc4_crtc->regset);
+	}
 
 	vc4_crtc_pixelvalve_reset(crtc);
 
@@ -357,32 +365,23 @@ static void vc4_crtc_config_pv(struct drm_crtc *crtc)
 		   PV_CONTROL_WAIT_HSTART |
 		   VC4_SET_FIELD(vc4_encoder->clock_select,
 				 PV_CONTROL_CLK_SELECT));
-}
-
-static void vc4_crtc_mode_set_nofb(struct drm_crtc *crtc)
-{
-	struct vc4_crtc *vc4_crtc = to_vc4_crtc(crtc);
-	struct vc4_crtc_state *vc4_state = to_vc4_crtc_state(crtc->state);
-	bool debug_dump_regs = false;
 
 	if (debug_dump_regs) {
 		struct drm_printer p = drm_info_printer(&vc4_crtc->pdev->dev);
-		dev_info(&vc4_crtc->pdev->dev, "CRTC %d regs before:\n",
+		dev_info(&vc4_crtc->pdev->dev, "CRTC %d regs after:\n",
 			 drm_crtc_index(crtc));
 		drm_print_regset32(&p, &vc4_crtc->regset);
 	}
+}
+
+static void vc4_crtc_mode_set_nofb(struct drm_crtc *crtc)
+{
+	struct vc4_crtc_state *vc4_state = to_vc4_crtc_state(crtc->state);
 
 	if (!vc4_state->feed_txp)
 		vc4_crtc_config_pv(crtc);
 
 	vc4_hvs_mode_set_nofb(crtc);
-
-	if (debug_dump_regs) {
-		struct drm_printer p = drm_info_printer(&vc4_crtc->pdev->dev);
-		dev_info(&vc4_crtc->pdev->dev, "CRTC %d regs after:\n",
-			 drm_crtc_index(crtc));
-		drm_print_regset32(&p, &vc4_crtc->regset);
-	}
 }
 
 static void require_hvs_enabled(struct drm_device *dev)
-- 
git-series 0.9.1
