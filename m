Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FB5CC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 17:46:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EF94206DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 17:46:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="gFQDY2qS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RNOfrw7s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728479AbgGHRqP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 13:46:15 -0400
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:43571 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726897AbgGHRnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 13:43:19 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id BA6D9333;
        Wed,  8 Jul 2020 13:43:17 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 08 Jul 2020 13:43:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=eamnrKRXGSO+A
        sypAxyQ7f407VS54U62sC8+fEe9GOU=; b=gFQDY2qSacjGF9g/KsWEN27exkiii
        p8WJfcONQxB9cPIqHCy4GVSqdUMdY16WyOeIc14IGDeMWGo7nS+9XCMxzMgPe2q8
        we1FBkH8to1jRvHlatWijNTcrdq4hn6QlYEFxs+BlUvstfHmGq2INlAcPEgfdCSI
        98fNZLSkrLgGCk58cwnsR0YbK2vVnWDXKD+XjiHB+vqHRpCayrxW8zh8M3i0vbSk
        kD9ttV/wcUBp94+Kazq5gLvTIGpaHsHlHzul0CRdDuT3/XCk7IAGgSxBJuOZQfTP
        NaRlcTQ2LJ8xZOt7OYdFkUYwMoFumFpA+iD3G8yuHd98Ii1f4vGGTAZYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=eamnrKRXGSO+AsypAxyQ7f407VS54U62sC8+fEe9GOU=; b=RNOfrw7s
        kRkdZAXFVC7piWnQgslH2xIgbJFcxXe6qNJzjdN25OgQhBqKatrgBjfCCBacMC6k
        86AahbeviAso9aVLoTgB0osRs85Z4BMe9L7/gdEbxwqmTHEm6VyDIP9lgw2DbMPM
        SbjqkciWULqP3kw8IWesFrGBNcGjjKmefhSEIyEH2VTMyrJoxGSGXN0IkysYFE9Q
        54X2q9ZY41pfTVJCCLN3BIs1efDm2EJBG5k5YC70XoyylxEmu5RZ4GlDIC/4z/wN
        aamu6YAQ9/rLcy+ry5IUFwOpO60gnW6k2bP8PPfb69I0kxEGWPL3zi4PlZY/JbdH
        k2v394S+TVSXHw==
X-ME-Sender: <xms:tQUGXzgIS6jrqGXgcvv63IwMrvvR-vUoUc_xIBwwpHQ3sCU989ROAw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudejgdduudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepvdekne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:tQUGXwDs6nwSEg5hfdeH1fjoD40Z9LCqIN2Wn8-GRMC-sshDeM9OeQ>
    <xmx:tQUGXzHUbseXNh01RcEWga3I9oTbNqdGSTGw3tW0tmm9dZVMkeBH4g>
    <xmx:tQUGXwTL49zOX9cqhFcvtHLnNoxyABl5n4OcI4kGJOlq2EQqHDlwhA>
    <xmx:tQUGXzx252_13H3lmyz6JTMAKGjWyiUy1zo0rK4DDXgDjn-TtMccgU5_5Wk>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id F293A328005A;
        Wed,  8 Jul 2020 13:43:16 -0400 (EDT)
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
Subject: [PATCH v4 32/78] drm/vc4: hvs: Make the stop_channel function public
Date:   Wed,  8 Jul 2020 19:41:40 +0200
Message-Id: <ba2dcc46fca6711fd8e5ba1c8afc29e83801b619.1594230107.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.7a1aa1784976093af26cb31fd283cf5b3ed568bb.1594230107.git-series.maxime@cerno.tech>
References: <cover.7a1aa1784976093af26cb31fd283cf5b3ed568bb.1594230107.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During the transition from the firmware to the KMS driver, we need to pay
particular attention to how we deal with the pixelvalves that have already
been enabled, otherwise either timeouts or stuck pixels can occur. We'll
thus need to call the function to stop an HVS channel at boot.

Reviewed-by: Eric Anholt <eric@anholt.net>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_drv.h | 1 +
 drivers/gpu/drm/vc4/vc4_hvs.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vc4/vc4_drv.h b/drivers/gpu/drm/vc4/vc4_drv.h
index 251fcc35530c..554c2e29b23d 100644
--- a/drivers/gpu/drm/vc4/vc4_drv.h
+++ b/drivers/gpu/drm/vc4/vc4_drv.h
@@ -907,6 +907,7 @@ void vc4_irq_reset(struct drm_device *dev);
 
 /* vc4_hvs.c */
 extern struct platform_driver vc4_hvs_driver;
+void vc4_hvs_stop_channel(struct drm_device *dev, unsigned int output);
 int vc4_hvs_atomic_check(struct drm_crtc *crtc, struct drm_crtc_state *state);
 void vc4_hvs_atomic_enable(struct drm_crtc *crtc, struct drm_crtc_state *old_state);
 void vc4_hvs_atomic_disable(struct drm_crtc *crtc, struct drm_crtc_state *old_state);
diff --git a/drivers/gpu/drm/vc4/vc4_hvs.c b/drivers/gpu/drm/vc4/vc4_hvs.c
index 64b9d72471ef..2966dc05c7bb 100644
--- a/drivers/gpu/drm/vc4/vc4_hvs.c
+++ b/drivers/gpu/drm/vc4/vc4_hvs.c
@@ -248,7 +248,7 @@ static int vc4_hvs_init_channel(struct vc4_dev *vc4, struct drm_crtc *crtc,
 	return 0;
 }
 
-static void vc4_hvs_stop_channel(struct drm_device *dev, unsigned int chan)
+void vc4_hvs_stop_channel(struct drm_device *dev, unsigned int chan)
 {
 	struct vc4_dev *vc4 = to_vc4_dev(dev);
 
-- 
git-series 0.9.1
