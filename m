Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CAF8C433E3
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 17:44:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DD93206DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 17:44:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="fawW+UNA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pvq3xDsC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728059AbgGHRoR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 13:44:17 -0400
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:57651 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727916AbgGHRoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 13:44:08 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 8E84E109A;
        Wed,  8 Jul 2020 13:44:06 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 08 Jul 2020 13:44:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=pt9TFI6RvUVSu
        NKW8zJg2qYLrIvyFPkfvn0jKN0hzvg=; b=fawW+UNA67OCmtPZmc7+8QPifcg45
        6W9E1rBMVS3IaJ2dcwXx8iMarsnkwaOZ+jGG7cVw4XBq/6mjkNaSChtKRzBVZFym
        86EEHTA2d0rwrDt24BiDJgf/UveGfSLuDFxa+DEpGeSTygpQfn1HbWs9ag3VhH/K
        8bDBTYc6vazQg3AM1gP54GfOksl/hqSKBGC1LNGSMnyYmIrCqIFuf2CLCu0/M/jy
        YVZX2iisrlfFsqQR8G8/Z9Wea5rAzYFdGtNb/neFIoT3H9dPMGt7ZBT0wYsTVnJ7
        0815T+CMLNY5pF1zP39Mg/Wq5cX7e0+ZcDp+o+/OZ7K9U/qvyTS59Rm0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=pt9TFI6RvUVSuNKW8zJg2qYLrIvyFPkfvn0jKN0hzvg=; b=pvq3xDsC
        nC4xM6goTgv/ut74GmbByNPRsEz1GDm1iY6ddOYFtd863jbzeL/W5vhRD4cpLj0u
        BAkFsMCuQYdnWXoCB+kFKRpz/1t/bqH4EQPaC/cP6oudHeB6zTg4W0suJu7/dnoW
        T1VjWF5OmrX3TnYi2uNpG2JXiruWM3BiaJkBz10kJ0feCYnfH8lt32PxzkOYCfza
        MKQi3WFAY8VWFC63Y0Drrb1I4Dd8ZQTDOZmCaI4pbpERyac47WSORjVFgs1F9HSa
        r4ITPi0p8SDXgPsLFEe1XuE1pme9MyMrAQ+pbhFYXqeezE36ai/k2fxkQLL12sVP
        9BOve7UA6JaHPA==
X-ME-Sender: <xms:5gUGX76SiD4soAWkwcqOfmYhLoPwqJHHbXTDHWP6wxjgAGp6IK9pKQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudejgdduudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepiedvne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:5gUGXw5LG6dW-Miy-MieLcDRrrSE2tSwSWMqAAeDyA_dOPbkxcmEZw>
    <xmx:5gUGXyfhVfhaa-jh3LkMT8XUxtf_SdGDSpFgoNG3BddPddeTOOETHg>
    <xmx:5gUGX8JTsYtEEdcCm6mowVsmejwHVbgHoc6p1KDn4QtCly8aktqCyQ>
    <xmx:5gUGX8q0Rdn7SCmv0bIbwNItLheCWDnSexeUsrppWb5BkJUvzQm4HLJ2dJI>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id D31733280059;
        Wed,  8 Jul 2020 13:44:05 -0400 (EDT)
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
Subject: [PATCH v4 66/78] drm/vc4: hdmi: Set the b-frame marker to the match ALSA's default.
Date:   Wed,  8 Jul 2020 19:42:14 +0200
Message-Id: <a0553ce25cb66a4da407405f63711efdf79d61e3.1594230107.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.7a1aa1784976093af26cb31fd283cf5b3ed568bb.1594230107.git-series.maxime@cerno.tech>
References: <cover.7a1aa1784976093af26cb31fd283cf5b3ed568bb.1594230107.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Stevenson <dave.stevenson@raspberrypi.com>

ALSA's iec958 plugin by default sets the block start preamble
to 8, whilst this driver was programming the hardware to expect
0xF.
Amend the hardware config to match ALSA.

Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_hdmi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index c96d9f2af2bf..e1ef0907a827 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -754,10 +754,11 @@ static int vc4_hdmi_audio_hw_params(struct snd_pcm_substream *substream,
 
 	vc4_hdmi_audio_set_mai_clock(vc4_hdmi);
 
+	/* The B frame identifier should match the value used by alsa-lib (8) */
 	audio_packet_config =
 		VC4_HDMI_AUDIO_PACKET_ZERO_DATA_ON_SAMPLE_FLAT |
 		VC4_HDMI_AUDIO_PACKET_ZERO_DATA_ON_INACTIVE_CHANNELS |
-		VC4_SET_FIELD(0xf, VC4_HDMI_AUDIO_PACKET_B_FRAME_IDENTIFIER);
+		VC4_SET_FIELD(0x8, VC4_HDMI_AUDIO_PACKET_B_FRAME_IDENTIFIER);
 
 	channel_mask = GENMASK(vc4_hdmi->audio.channels - 1, 0);
 	audio_packet_config |= VC4_SET_FIELD(channel_mask,
-- 
git-series 0.9.1
