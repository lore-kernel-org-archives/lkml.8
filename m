Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6797AC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:54:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 421EA20776
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:54:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="EcBQa9pD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AcWMGYTd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388653AbgE0PyO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 11:54:14 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:58893 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730704AbgE0Pvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 11:51:52 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 6B5CC582101;
        Wed, 27 May 2020 11:51:51 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 27 May 2020 11:51:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=d65+1uw8oGAwy
        EgBRSw7oIikorpDLZOAwmmgqX61Vxs=; b=EcBQa9pDVStORYd6d1azjZE+ESG/L
        repjA1nKSLE0W3r8bNH5B9EyMcwuKUP0trwq7J5SY4LC3Lj6nSKg+NTETS8BXoGI
        suFQTSH+QH3x5dsSdVix+qJEzqygbBFpT/ax5lA8B6nk0LzeC6PNp2PGEh6Q+ATC
        d+MUFJkyBy4MpMaoAXmykScDNT5GHN4X/LEU+Oh4DRJZRKinU/tSu7ipBpSwQo3/
        73XTyficDcFt270nZ0V3Q01xn7ofPpDrTaCVId9oIhjeMxJUlCnUG/GhIEoQbSp+
        oWE6fw7gDDCzAOOB6qvtjaD4CDiF9tibCkYZFHEojt5pcYBHNhY50VUig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=d65+1uw8oGAwyEgBRSw7oIikorpDLZOAwmmgqX61Vxs=; b=AcWMGYTd
        wmDkLEL7owLMHO1LnMIiG6RfVX++TS8qJAyIWfF6wDEP0gxxKrj7rH28Gy6SY+TQ
        WTlKlJ7AmG6kwJ9K0YYsYwnkvnlepvEWWrfdQWlRdpBVISl8BFbPtVqcs85Gq/wT
        6uFcfsQu6+QmmTPwt2xq00+d5oQyIwr8pNuLUS6n4d2bFfHDyT2gZcGVzHqZaZ5p
        OX3OdPt9qEwO6ilx8/Qeijtquc/pjrZmYOKBIxrEy484b2N3QL8Py0I2N34pHGQn
        pEpHCZnbDgoxFB74VOJuW116Tu3o3fwTFUKOVdv7aIYRIS2ZSPvFi3b4KG/O60EP
        M98LDbuDpzIrmQ==
X-ME-Sender: <xms:l4zOXp6uZF60LfP17s9Mk8DioE9vwAZKAcSbl8GiVKbOk3EXCYo_Bw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedruddvgedgkeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepjeehne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:l4zOXm5pXusCJoz6PzFdF8AJyQ7ruUHpp_Bvk6KwdpQZAXBUoKFd1A>
    <xmx:l4zOXgcQtJba6O3_QCYZ1YhW8lCqa6kDY0wp1JrjZUzVcjGShQ0_0w>
    <xmx:l4zOXiKJaA65WBpSWFTRLvGQrFcnRDJ7Wh4xaxMw79Zpdh0sbxdeUw>
    <xmx:l4zOXiorDXgkF46-Dde8hUrBfyq0rlwhy0Q8qmsvY5ar7agDU4-DUw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 035433280064;
        Wed, 27 May 2020 11:51:50 -0400 (EDT)
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
Subject: [PATCH v3 098/105] drm/vc4: hdmi: Remove register dumps in enable
Date:   Wed, 27 May 2020 17:49:08 +0200
Message-Id: <b18fa139a3d96c334954175748efbc656d6c53fc.1590594512.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.aaf2100bd7da4609f8bcb8216247d4b4e4379639.1590594512.git-series.maxime@cerno.tech>
References: <cover.aaf2100bd7da4609f8bcb8216247d4b4e4379639.1590594512.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current code has some logic, disabled by default, to dump the register
setup in the HDMI controller.

However, since we're going to split those functions in multiple, shorter,
functions that only make sense where they are called in sequence, keeping
the register dump makes little sense.

Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_hdmi.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index 5ad983ce87d1..4b23d589377a 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -430,7 +430,6 @@ static void vc4_hdmi_encoder_enable(struct drm_encoder *encoder)
 	struct drm_display_mode *mode = &encoder->crtc->state->adjusted_mode;
 	struct vc4_hdmi *vc4_hdmi = encoder_to_vc4_hdmi(encoder);
 	struct vc4_hdmi_encoder *vc4_encoder = to_vc4_hdmi_encoder(encoder);
-	bool debug_dump_regs = false;
 	unsigned long pixel_rate, hsm_rate;
 	int ret;
 
@@ -489,14 +488,6 @@ static void vc4_hdmi_encoder_enable(struct drm_encoder *encoder)
 	if (vc4_hdmi->variant->phy_init)
 		vc4_hdmi->variant->phy_init(vc4_hdmi, mode);
 
-	if (debug_dump_regs) {
-		struct drm_printer p = drm_info_printer(&vc4_hdmi->pdev->dev);
-
-		dev_info(&vc4_hdmi->pdev->dev, "HDMI regs before:\n");
-		drm_print_regset32(&p, &vc4_hdmi->hdmi_regset);
-		drm_print_regset32(&p, &vc4_hdmi->hd_regset);
-	}
-
 	HDMI_WRITE(HDMI_VID_CTL, 0);
 
 	HDMI_WRITE(HDMI_SCHEDULER_CONTROL,
@@ -522,14 +513,6 @@ static void vc4_hdmi_encoder_enable(struct drm_encoder *encoder)
 
 	HDMI_WRITE(HDMI_FIFO_CTL, VC4_HDMI_FIFO_CTL_MASTER_SLAVE_N);
 
-	if (debug_dump_regs) {
-		struct drm_printer p = drm_info_printer(&vc4_hdmi->pdev->dev);
-
-		dev_info(&vc4_hdmi->pdev->dev, "HDMI regs after:\n");
-		drm_print_regset32(&p, &vc4_hdmi->hdmi_regset);
-		drm_print_regset32(&p, &vc4_hdmi->hd_regset);
-	}
-
 	HDMI_WRITE(HDMI_VID_CTL,
 		   HDMI_READ(HDMI_VID_CTL) |
 		   VC4_HD_VID_CTL_ENABLE |
-- 
git-series 0.9.1
