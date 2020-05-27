Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8E76C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:54:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3AE920776
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:54:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="Y7g8Yr+2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FRp4on9b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730694AbgE0Pvt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 11:51:49 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:55453 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389820AbgE0PvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 11:51:00 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 1A5545820DD;
        Wed, 27 May 2020 11:50:59 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 27 May 2020 11:50:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=ounqDkKyB9FLa
        CDv2YNyzZ5BItMJjprgBr0/54Ryzxs=; b=Y7g8Yr+2xMKAOZQ8bzPpv/1tMXBiR
        AeyNgtwN9vLgyXFKq9IqmhXZusMdMggLEXnwiR/XUo01f8xFt3EZKZG7uzR8XWLC
        kpERJdh9mp9FImjNIeYVAyNsmCog/2jxStbBP5nqqsQdFSSGb7ZUcM01D0LcHlmX
        p5hnnqzxkydwLWZqBL4rE3VnNf9njKM8yPcNMdVlk6wJcxoG1Dv2Qt0h21LxcPAJ
        xbeEEoEHSUGhzedVxhnaASVcbqpbphsP8yzXYS5NDjwiKzE2Uy60Vc9hqmJKiR2A
        eCM6A9iuMwe+yrsHQ91yor82jnGj1OwO1sdn+xxgqHtVcUaGX4jFv/quA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=ounqDkKyB9FLaCDv2YNyzZ5BItMJjprgBr0/54Ryzxs=; b=FRp4on9b
        c9xGZztCjLa2tvjA4sKtG+SqJVXDrbFz/32ipl8piNlf/mQSCinb4ugs3hI51vvZ
        mayd6YXFHCkiq2hTdgdDBRIRHEDogjgw9FCxMUvan+FFBeunYMkHiq78iiHa5JQD
        D0pfOSNKeXCrqg+vL4HHIvwnY8CySBlNqC73LVqGY1CXJW4R75vNlMCPFxKOC/JO
        J3tT4wxNOKtLbudR/ucpst/x3OWQcr8mOw2jOaDcKVFE48fuXkCXHpWZI5D44OZL
        6stis0HkAmjown4AiPrNlkfe401Z8Q1kikP5h5N8pgAEhBesnaeQLAs6onjUn+by
        reRL7eG2pd1o5g==
X-ME-Sender: <xms:YozOXk8kDZnEoD_cS6SMfqHa789Nd4FCN3x7AOh1i9dZBNlffhAxng>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedruddvgedgkeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepgeegne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:YozOXsuLATyAfm73AxzeblL0V3Ou0iKSSt-8vfhnAQZ5Lt1igTCAHQ>
    <xmx:YozOXqA_xdCAYYcGKM8tlKN1xlE_me93MPd6nLA-sHhn-11iQIkAEg>
    <xmx:YozOXkdDicfZUJPRYPH7yQjFpI5A4aE2WnZYgGEmdE0aFD4H4JVM4g>
    <xmx:Y4zOXsee4amgMUSkSNr_-HVAcyaxVn3ve8-l71OnX7AkcQPh1nGeVw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id B22CC3280059;
        Wed, 27 May 2020 11:50:58 -0400 (EDT)
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
Subject: [PATCH v3 064/105] drm/vc4: crtc: Change the HVS5 test for of_device_is_compatible
Date:   Wed, 27 May 2020 17:48:34 +0200
Message-Id: <2165607ede34d229d0cbce916c70c7fb6c0337be.1590594512.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.aaf2100bd7da4609f8bcb8216247d4b4e4379639.1590594512.git-series.maxime@cerno.tech>
References: <cover.aaf2100bd7da4609f8bcb8216247d4b4e4379639.1590594512.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The TXP probes before the HVS, so testing the hvs5 flag in the hvs pointer
of the main device structure won't work and result in a null pointer
dereference.

Let's test for the main device compatible instead so that it can work.

Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_crtc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_crtc.c b/drivers/gpu/drm/vc4/vc4_crtc.c
index 6d7799ff8f87..d284596ec048 100644
--- a/drivers/gpu/drm/vc4/vc4_crtc.c
+++ b/drivers/gpu/drm/vc4/vc4_crtc.c
@@ -1055,7 +1055,6 @@ int vc4_crtc_init(struct drm_device *drm, struct vc4_crtc *vc4_crtc,
 		  const struct drm_crtc_funcs *crtc_funcs,
 		  const struct drm_crtc_helper_funcs *crtc_helper_funcs)
 {
-	struct vc4_dev *vc4 = to_vc4_dev(drm);
 	struct drm_crtc *crtc = &vc4_crtc->base;
 	struct drm_plane *primary_plane;
 	unsigned int i;
@@ -1076,7 +1075,7 @@ int vc4_crtc_init(struct drm_device *drm, struct vc4_crtc *vc4_crtc,
 				  crtc_funcs, NULL);
 	drm_crtc_helper_add(crtc, crtc_helper_funcs);
 
-	if (!vc4->hvs->hvs5) {
+	if (!of_device_is_compatible(drm->dev->of_node, "brcm,bcm2711-vc5")) {
 		drm_mode_crtc_set_gamma_size(crtc, ARRAY_SIZE(vc4_crtc->lut_r));
 
 		/* We support CTM, but only for one CRTC at a
-- 
git-series 0.9.1
