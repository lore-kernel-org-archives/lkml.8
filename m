Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D601C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 17:47:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C70D206E2
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 17:47:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="M3sowvlW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dXMpXop+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726629AbgGHRmy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 13:42:54 -0400
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:51433 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726514AbgGHRmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 13:42:50 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 28F6BFE4;
        Wed,  8 Jul 2020 13:42:49 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 08 Jul 2020 13:42:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=imK7Na+duZmRm
        fePws9Go/wcyLUu9qMlTwV9YYPboKQ=; b=M3sowvlWJZBdeV+Kdee8RwAkyr8iv
        thyWrWNYeTtXcHZCSdeMtG7urwlppfjQPzedZinIPZodVhIWFdOeNLncBghKfFOZ
        8Np0l7JCSv4iH7no4ZfFDHN27zyEaqUht+j12ItzlZWgkcafAyM64UTrId0kfFIO
        L70NO//SflEMXzMdTVL+7axeIetxydtftQR6drBOczbJEUhoZ1rhfqXKlO5jTWHA
        BepHcn90hsjsZ4TK3irf2KidaNRmuM9YHPvY1vCvU+djdWtbCdYTgKHtRj/FVLkk
        KyAInH4++XAbN+zg/z21Hkm5WoVIvD31JGkNJIovcP2sFzu4PNIz8YlCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=imK7Na+duZmRmfePws9Go/wcyLUu9qMlTwV9YYPboKQ=; b=dXMpXop+
        cW7nvm1iTpF7nqelL/gUOyx0jwjFPc0HjNyMvFBpUeyPJLplSuxBAnfulQo37Tsp
        Im3YOlMV+cfq41hKUgUjeNMG5oZ9x96GTQPMEfto8Jtwgpv/x61WayImSSezjrxS
        mPoiy/SjaMV6Ds28LDysqfg7v+ZQZT33jyLxfMbGPCIIzhy3MxwR0VOYWRiMQJLd
        lsEEQlZIfnTai0OR75VQQcQI/9chExrxUYqFBRmynV7beCOwxk+2C3uDe2aalP/1
        76tAQzZCPpVNN4NBx31F3Kv9qD+z3aLXD2vYqGGN1qTuo3cU125tI65ObMSe9Gsy
        yfOvUg/GiXfODQ==
X-ME-Sender: <xms:mAUGX8-yQCVT3xDuH3SrtH3GMRxRnyh8GAkTRlwIIGwLWdjZy3xd0g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudejgdduudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepuddune
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:mAUGX0s4_J2N6-5gI-PjLZ6RlJShnXP4e76ecTx6jj7b-k3bD9wQ_Q>
    <xmx:mAUGXyCye8UsXAM6EdYRZhxGh8Ry7CrE10k8HuPNGkhanidjTSaOyw>
    <xmx:mAUGX8cDF3Kmo2lvJ58qWtbF7r4GI4fe8n7bpTAopSXv4wr-067JJQ>
    <xmx:mAUGX0dr4KkFdbO9US0aHGhPoA4bZOdvZycS3RVmzVtub5z9gFjpdFcFCF0>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 63A933280060;
        Wed,  8 Jul 2020 13:42:48 -0400 (EDT)
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
Subject: [PATCH v4 12/78] drm/vc4: crtc: Enable and disable the PV in atomic_enable / disable
Date:   Wed,  8 Jul 2020 19:41:20 +0200
Message-Id: <3d00592745e9559b754e84ffc74b4a727b82e8ab.1594230107.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.7a1aa1784976093af26cb31fd283cf5b3ed568bb.1594230107.git-series.maxime@cerno.tech>
References: <cover.7a1aa1784976093af26cb31fd283cf5b3ed568bb.1594230107.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The VIDEN bit in the pixelvalve currently being used to enable or disable
the pixelvalve seems to not be enough in some situations, which whill end
up with the pixelvalve stalling.

In such a case, even re-enabling VIDEN doesn't bring it back and we need to
clear the FIFO. This can only be done if the pixelvalve is disabled though.

In order to overcome this, we can configure the pixelvalve during
mode_set_no_fb, but only enable it in atomic_enable and flush the FIFO
there, and in atomic_disable disable the pixelvalve again.

Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_crtc.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_crtc.c b/drivers/gpu/drm/vc4/vc4_crtc.c
index cdeaa0cd981f..fe2e5675aed4 100644
--- a/drivers/gpu/drm/vc4/vc4_crtc.c
+++ b/drivers/gpu/drm/vc4/vc4_crtc.c
@@ -332,9 +332,7 @@ static void vc4_crtc_config_pv(struct drm_crtc *crtc)
 		   PV_CONTROL_TRIGGER_UNDERFLOW |
 		   PV_CONTROL_WAIT_HSTART |
 		   VC4_SET_FIELD(vc4_encoder->clock_select,
-				 PV_CONTROL_CLK_SELECT) |
-		   PV_CONTROL_FIFO_CLR |
-		   PV_CONTROL_EN);
+				 PV_CONTROL_CLK_SELECT));
 }
 
 static void vc4_crtc_mode_set_nofb(struct drm_crtc *crtc)
@@ -386,6 +384,8 @@ static void vc4_crtc_atomic_disable(struct drm_crtc *crtc,
 	ret = wait_for(!(CRTC_READ(PV_V_CONTROL) & PV_VCONTROL_VIDEN), 1);
 	WARN_ONCE(ret, "Timeout waiting for !PV_VCONTROL_VIDEN\n");
 
+	CRTC_WRITE(PV_CONTROL, CRTC_READ(PV_CONTROL) & ~PV_CONTROL_EN);
+
 	vc4_hvs_atomic_disable(crtc, old_state);
 
 	/*
@@ -410,6 +410,10 @@ static void vc4_crtc_atomic_enable(struct drm_crtc *crtc,
 
 	require_hvs_enabled(dev);
 
+	/* Reset the PV fifo. */
+	CRTC_WRITE(PV_CONTROL, CRTC_READ(PV_CONTROL) |
+		   PV_CONTROL_FIFO_CLR | PV_CONTROL_EN);
+
 	/* Enable vblank irq handling before crtc is started otherwise
 	 * drm_crtc_get_vblank() fails in vc4_crtc_update_dlist().
 	 */
-- 
git-series 0.9.1
