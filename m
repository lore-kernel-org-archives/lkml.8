Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 261AEC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:51:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB890208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:51:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="sxKM2ghA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lxe6q5Vu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390255AbgE0PvF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 11:51:05 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:47645 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730565AbgE0Pud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 11:50:33 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 0F52B582093;
        Wed, 27 May 2020 11:50:32 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 27 May 2020 11:50:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=E53byJeSNwsr3
        s5waq0oOBfsjIRNSegJ0GAwzJ3dKV0=; b=sxKM2ghAxtoX8X7/rDFVhvjLsFkyo
        WWHNPKANFQSb4tm6a/8eKNl8tb9VWBnC4K0anIfMM9B+0P10p82Q5w+58/OW/oUc
        UU0nLVYXIIHevosOreIRoPCuiHHEkdkPs+/n8jhQ5Cs4u0L+5S39opaYwm/ZjMmB
        TC9GPXuwXD6magMViFfP5EFWcDP/ezjWJ56bLnGsnBg9UwQb5eO++o3LqPoa8SmM
        Ewf4Tp0VBeRsGaYbEqYO7zrzWGpDyz5Lc14IFcDEIOB1pFytlWoC2CCRrJjUYggO
        B71HdY8aAUkB7LS9DdXIUgfAQKZlmr5Q2P90F+NjGDosFaFCLW/VkiRDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=E53byJeSNwsr3s5waq0oOBfsjIRNSegJ0GAwzJ3dKV0=; b=lxe6q5Vu
        2OaUqxU1RVX4LXxpIXGYnFZGL1oiQO9MHElCorOtDsExBvJ1fO53SN732yGG6Mct
        RVVHTQ0fAkDylwWtwY4WlcOsSLA9729JaURg23Yu4YrO8wv3OU2QUlU33MmwRMJf
        637oLMpcYv639+Ko3NGgHTGRPuPcHw9LGygmCo6qUaFxdR4yjH6VD2ndNWj34E8I
        ueSL+sh1bp/bPgbPZv245Nt9RbYK8azkWwR6eoUF4NaVFE5RJaXDfAOWc3/J798V
        dn05WEqzbu2vBFP27HfsG7IKfXLBMjwuzH2KTSnVyAXi0Vep9BRjm5TwitPmztcC
        goFvYarCdc/lqg==
X-ME-Sender: <xms:R4zOXtyHhyRtifLbDGaG1F-I87LsgoBRSMnudmdEeQX5wunsBXhslw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedruddvgedgkeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepvdelne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:R4zOXtSciqCeBEfCYrjmgDXfnb6VTTFIFvbEfc-af6BnMeND5OF1hg>
    <xmx:R4zOXnWWu0am_Vgnyi3qUPytpyLF_ut9P2yoOTlM6-Bs2c9L8xQHtQ>
    <xmx:R4zOXviZyxWp7bvsCz-jydGkZmVW_ZWOmTCtTC8c0EE4Wl25BL6IpQ>
    <xmx:SIzOXhAE5VrsDfoHA6VwPz8y6xN-PJbsPT5JAecBlJd6GHbs6d1sAQ>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id A6C35306218B;
        Wed, 27 May 2020 11:50:31 -0400 (EDT)
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
Subject: [PATCH v3 047/105] drm/vc4: crtc: Remove mode_set_nofb
Date:   Wed, 27 May 2020 17:48:17 +0200
Message-Id: <41435b33f4f0c072aa1645dc84f78c4390b457b0.1590594512.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.aaf2100bd7da4609f8bcb8216247d4b4e4379639.1590594512.git-series.maxime@cerno.tech>
References: <cover.aaf2100bd7da4609f8bcb8216247d4b4e4379639.1590594512.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On BCM2711 to avoid stale pixels getting stuck in intermediate FIFOs, the
pixelvalve needs to be setup each time there's a mode change or enable /
disable sequence.

Therefore, we can't really use mode_set_nofb anymore to configure it, but
we need to move it to atomic_enable.

Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_crtc.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_crtc.c b/drivers/gpu/drm/vc4/vc4_crtc.c
index a69e0d456b79..08bd595f6a7c 100644
--- a/drivers/gpu/drm/vc4/vc4_crtc.c
+++ b/drivers/gpu/drm/vc4/vc4_crtc.c
@@ -374,14 +374,6 @@ static void vc4_crtc_config_pv(struct drm_crtc *crtc)
 	}
 }
 
-static void vc4_crtc_mode_set_nofb(struct drm_crtc *crtc)
-{
-	struct vc4_crtc_state *vc4_state = to_vc4_crtc_state(crtc->state);
-
-	if (!vc4_state->feed_txp)
-		vc4_crtc_config_pv(crtc);
-}
-
 static void require_hvs_enabled(struct drm_device *dev)
 {
 	struct vc4_dev *vc4 = to_vc4_dev(dev);
@@ -443,6 +435,9 @@ static void vc4_crtc_atomic_enable(struct drm_crtc *crtc,
 
 	vc4_crtc_pixelvalve_reset(crtc);
 
+	if (!vc4_state->feed_txp)
+		vc4_crtc_config_pv(crtc);
+
 	CRTC_WRITE(PV_CONTROL, CRTC_READ(PV_CONTROL) | PV_CONTROL_EN);
 
 	/* Enable vblank irq handling before crtc is started otherwise
@@ -814,7 +809,6 @@ static const struct drm_crtc_funcs vc4_crtc_funcs = {
 };
 
 static const struct drm_crtc_helper_funcs vc4_crtc_helper_funcs = {
-	.mode_set_nofb = vc4_crtc_mode_set_nofb,
 	.mode_valid = vc4_crtc_mode_valid,
 	.atomic_check = vc4_crtc_atomic_check,
 	.atomic_flush = vc4_hvs_atomic_flush,
-- 
git-series 0.9.1
