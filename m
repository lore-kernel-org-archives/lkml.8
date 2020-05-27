Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CFC1C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:50:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D072120776
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:50:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="aIQNde5A";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="2/J0b4qf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390229AbgE0Pul (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 11:50:41 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:60511 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729762AbgE0PuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 11:50:17 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 7C75958206F;
        Wed, 27 May 2020 11:50:16 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 27 May 2020 11:50:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=84iVjZEVQJdxU
        ub2RqdoiAca3IQhRqY+Zryl/iBO7LM=; b=aIQNde5AckuCt3Hui7I4pRqEy3l5V
        J0h1tbjbDzXbOD/nRZy5IueBPtl7ump3pxopfEKK8LYqkHsRWLnqCGAyMbq3cFzJ
        O4xY+sw9TWWnm46GcNa0iNJ/GIK492oXV/9nJNpNX49tejKq/ZtnBWVhFvgITrn2
        ggDEMO9jnJSuKG6ISJouYZrVWX8EI7MNBfsz5xZnnm82JrptV69LJaU7AvlaKnVB
        ZGjlhTvXkKD7+Hg1RmZ687d5GZ2S2TrMiteifzFmXS+U6B3rJvSbO/MW0RJgcYBC
        56NMteCKgcRm9J99kNZZgS/utQrTsu2S2zcbTAETSkjJw3RHcD00Wjksw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=84iVjZEVQJdxUub2RqdoiAca3IQhRqY+Zryl/iBO7LM=; b=2/J0b4qf
        MT7M5Zdxkn9Othpn8jgwdJuMFQshdII71CyzdxHztsnMbNWDfKy3X2FwKpzilVN7
        ueUY9CgEMJ0uNpHYrF43OvhjqzQSkDMYX7agVoIBqKcmL4Kmla4HUgi9fEo5xZNr
        TY3vIvhXZSaebFAMVzo/llco70e0UQ2yZDVoTHTIx3+GeQEhQ95B6uhkyZGfTKOk
        Eq2v5690/s5lTzqUHMiPBoEcKeuEHnz/Neqg8GD9ytyiSAUqyKjxvvs8uKts93Uz
        IGw6G5uOmBxJlf+kn6beMxDv0n0I/DBRU19IdmWl6iOW4z7h0kXGc0qyP4r+Y8vc
        vLzch9Bx3fm+BQ==
X-ME-Sender: <xms:OIzOXqyRAND6Nnp9Wv8QYqbqenPs9WcUabo57MfsEKh98xu8G7gBzg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedruddvgedgkeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepudejne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:OIzOXmSqpM3M_jL8U0mI57vamMWWmUgoyCrQ04yV_4w6VEC-EOWifw>
    <xmx:OIzOXsW8wkMH2nHkWjYyi_AQXkH6uvbJi6zWDCwhWvHSLXU_rfq0cg>
    <xmx:OIzOXgjKAvBv5k_HZHqY0tWmL_sjj9TQidoFbWoEvc47BxqkhR6UQw>
    <xmx:OIzOXqCV3Sd724CtH92CfnW84S3Q-j762vGAhDj-WphHL6rkDpEjWQ>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 1D5A83061CCB;
        Wed, 27 May 2020 11:50:16 -0400 (EDT)
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
Subject: [PATCH v3 037/105] drm/vc4: crtc: Add HDMI1 encoder type
Date:   Wed, 27 May 2020 17:48:07 +0200
Message-Id: <5ddada6589946b06858ed78b1f6e27abc611f19d.1590594512.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.aaf2100bd7da4609f8bcb8216247d4b4e4379639.1590594512.git-series.maxime@cerno.tech>
References: <cover.aaf2100bd7da4609f8bcb8216247d4b4e4379639.1590594512.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The BCM2711 sports a second HDMI controller, so let's add that second HDMI
encoder type.

Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_drv.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/vc4/vc4_drv.h b/drivers/gpu/drm/vc4/vc4_drv.h
index cc30e54d75ab..974cda3c5292 100644
--- a/drivers/gpu/drm/vc4/vc4_drv.h
+++ b/drivers/gpu/drm/vc4/vc4_drv.h
@@ -430,6 +430,7 @@ to_vc4_plane_state(struct drm_plane_state *state)
 enum vc4_encoder_type {
 	VC4_ENCODER_TYPE_NONE,
 	VC4_ENCODER_TYPE_HDMI0,
+	VC4_ENCODER_TYPE_HDMI1,
 	VC4_ENCODER_TYPE_VEC,
 	VC4_ENCODER_TYPE_DSI0,
 	VC4_ENCODER_TYPE_DSI1,
-- 
git-series 0.9.1
