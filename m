Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B3DC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 17:44:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65078206DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 17:44:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="I+bZy+8X";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nriX/dB9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728235AbgGHRo6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 13:44:58 -0400
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:41175 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727999AbgGHRoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 13:44:10 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 781A4102B;
        Wed,  8 Jul 2020 13:44:09 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 08 Jul 2020 13:44:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=AM8MsEZZ3zYOQ
        3XQhFBbvPEglr+eKkHlxggT5g99HFU=; b=I+bZy+8X/5pfwS+GERZ1Vj2oNzNOF
        8jZbSHVpIlgASbAkw1bDI1giVKoLlVtPLEJGbWEDAZw9MPIpktXpk1zzy+nLEQnn
        CwVe+iqX/vcXK+XPj1a9C9qPs3r/M5n6BS5vrCOGsVWCZCdMIJpWX3oFDZhfwLoj
        sFB20EWFnB0R/JR/q8f6I5HvXXdbbiFz7BYFcq+k/X4xYcG9avQd1bdUIxQ6uAuk
        M/T2aOdQaJCL7RJpK2E52JOyI8h69pY2Dj8gqeg1zkYX9E74j8GqMeMO0fOcrKLI
        6SVY/kj/MTZzUiQ9qMdvzi6r9MuTaAkiFLl8HPjfvj7CJsOVIRtradArg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=AM8MsEZZ3zYOQ3XQhFBbvPEglr+eKkHlxggT5g99HFU=; b=nriX/dB9
        OiyHzc8DFe1XeNPqlI7R4Oqx+SHvcZRMlmiRPQ50O3cGrnzFDzdR14hLrZqjw0U4
        N7IbwjJOMDlQAB1jcLNHr3m36DB87+V5Swx32ER38/VcE7eplVaktXxrzrC1Oz58
        sIhHXILqttz5tiPALiz4bYIm0rTLnX0ifKipSBFGnMG7ML2EKpm2Dcjz6UR135t0
        a/4i7u+rjbieInzMPrGz/k2NS2dxh0aVCjbMk1rLrGEi3TynakzCwp3f+gAdSZ4q
        c12yjJEBoT+Zi/6tICGolFHI8xlv93eCIVp8MQWD7kXXZRD9dNGUta4bcTyuvETP
        Gy12QO/vLajvYw==
X-ME-Sender: <xms:6AUGX7wk89OWmqaGc8Xb-N4j6zwSXhphhseknOEGRK1m5A914G_BzQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudejgdduudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepiedvne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:6QUGXzSozd6GvY0Nzn3_AQ3oVq9HFLjCb4TUIg59KZ8F3KSLsjIdIQ>
    <xmx:6QUGX1Wu_8FJTScaTCCwEqOINe-OSQM2yS-nz4fIpnhwQjNpX1CPSA>
    <xmx:6QUGX1gEvQEyl7qc6YP5CwDJ95-kxNmTXX7X4SZRTnJpvALdTM03DQ>
    <xmx:6QUGX3Cngdda46JxHOTubLLw2JRguGQoZD4fBYfYYVghqXT8qGgouMX3epk>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id B07343280064;
        Wed,  8 Jul 2020 13:44:08 -0400 (EDT)
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
Subject: [PATCH v4 68/78] drm/vc4: hdmi: Deal with multiple ALSA cards
Date:   Wed,  8 Jul 2020 19:42:16 +0200
Message-Id: <7d4c17db4a1214b7665375aa83fe1f8b4f0fbdfb.1594230107.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.7a1aa1784976093af26cb31fd283cf5b3ed568bb.1594230107.git-series.maxime@cerno.tech>
References: <cover.7a1aa1784976093af26cb31fd283cf5b3ed568bb.1594230107.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The HDMI driver was registering a single ALSA card so far with the name
vc4-hdmi.

Obviously, this is not going to work anymore when will have multiple HDMI
controllers since we will end up trying to register two files with the same
name.

Let's use the variant to avoid that name conflict.

Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_hdmi.c | 3 ++-
 drivers/gpu/drm/vc4/vc4_hdmi.h | 3 +++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index 1b6f51849d6c..0a9a323e03d8 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -1044,7 +1044,7 @@ static int vc4_hdmi_audio_init(struct vc4_hdmi *vc4_hdmi)
 
 	card->dai_link = dai_link;
 	card->num_links = 1;
-	card->name = "vc4-hdmi";
+	card->name = vc4_hdmi->variant->card_name;
 	card->dev = dev;
 
 	/*
@@ -1503,6 +1503,7 @@ static int vc4_hdmi_dev_remove(struct platform_device *pdev)
 static const struct vc4_hdmi_variant bcm2835_variant = {
 	.encoder_type		= VC4_ENCODER_TYPE_HDMI0,
 	.debugfs_name		= "hdmi_regs",
+	.card_name		= "vc4-hdmi",
 	.max_pixel_clock	= 162000000,
 	.cec_available		= true,
 	.registers		= vc4_hdmi_fields,
diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.h b/drivers/gpu/drm/vc4/vc4_hdmi.h
index 4aea5ee8a91d..34138e0dd4a6 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.h
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.h
@@ -30,6 +30,9 @@ struct vc4_hdmi_variant {
 	/* Encoder Type for that controller */
 	enum vc4_encoder_type encoder_type;
 
+	/* ALSA card name */
+	const char *card_name;
+
 	/* Filename to expose the registers in debugfs */
 	const char *debugfs_name;
 
-- 
git-series 0.9.1
