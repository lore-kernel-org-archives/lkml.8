Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03DE2C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:50:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAFED2088E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:49:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="CKnAQTj4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WVS1ZcNo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390189AbgE0Pt7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 11:49:59 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:38611 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390170AbgE0Ptu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 11:49:50 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id C3B9A582034;
        Wed, 27 May 2020 11:49:49 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 27 May 2020 11:49:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=fse909+Uy/SxW
        fg4vh9c6yKXmMtSynUFNN2rQ9mVfiM=; b=CKnAQTj4qF9YmRrmG1WEUm3QBlGmN
        +Z8rAt4fKlNZvAY2Eb+XikZjeCsWRL6RJP/EZtPIvEdPcY0D5RVMjyTxaHGH0aBU
        W5Pfmd35yAayjvkBS62zPpb/usriE4khPkxh9oSA2UPfXxTGaoeGOEhkgJgLyckQ
        rB+mXcLNXZQt+48xIiEAMM/s57iA7jJaLCo+LV8ilOr18tMPd3uLnwUyoudRjkSv
        nbLnkt9peQi8fOK/yuAJFWRYpkdxBaStJEBCqU5YdBlYDkMS+G/cM/VKXQW3tc78
        gMPYitDhLkyMhUH4MacOwqjP6N9ucPsdcX1LyrxU4jxyYkqi7hMaljNyw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=fse909+Uy/SxWfg4vh9c6yKXmMtSynUFNN2rQ9mVfiM=; b=WVS1ZcNo
        FqGEz8XqMA0IYpsSErp7m51LvvR0lGObJ+dUsbdXH6eQU35Y56w5qYrzFBtRhOsl
        2hzgk2EWUcvbGHPiu3utHZQ5zgZlFU27yfeJEVAt0PguyjAmNpReL4rlHdefo/X+
        j732M4b7CbOxrSN9YsngEYwNhjlj+JP32FncSBJeiydEdLwgjCG+moaCIChdWPJn
        jTPDYlMOF4Jnqn1/gLAN9ehLRyuPvupVYaPeMIRNwHRgnuF6uGrSyMR4tesjnFDr
        fS98le+8/daRG2aEu2OqrnHH7qG9BNJHCxqcR6Wk9L34wrcRtsgImA9WqXwoGrPH
        hnHQ5jM7s9K6/w==
X-ME-Sender: <xms:HYzOXmPOhVtbZq6umOLH4FtKV5U4Tj_CosAY3igUXG-WM129k0e4GA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedruddvgedgkeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepfeenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:HYzOXk_un5RM9e-lK-qGZ68t6hcTojeALMY8u1Fah22J90mV8JyAAg>
    <xmx:HYzOXtTJZyLPprvipXGYkG8Tu3vxZ1iby2tBW4q5zAy3MXjngKsOAw>
    <xmx:HYzOXmvT2BHsdkWVaXc0DZ1cmgywxTOJhSXevJj1XYYwO3elv7YLhA>
    <xmx:HYzOXkuqrYplodrUNRB_wbrLkHS7Qd6S4WZStS_tro5ibw_HrziP5A>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 605A63061CCB;
        Wed, 27 May 2020 11:49:49 -0400 (EDT)
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
Subject: [PATCH v3 021/105] drm/vc4: plane: Create more planes
Date:   Wed, 27 May 2020 17:47:51 +0200
Message-Id: <6b4586842314b8c101758fdda6555d4353b7789b.1590594512.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.aaf2100bd7da4609f8bcb8216247d4b4e4379639.1590594512.git-series.maxime@cerno.tech>
References: <cover.aaf2100bd7da4609f8bcb8216247d4b4e4379639.1590594512.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's now create more planes that can be affected to all the CRTCs.

vc4 has 3 CRTCs, 1 primary and 1 cursor each, and was having 24 (8
planes per CRTC) overlays.

However, vc5 has 5 CRTCs, so keeping the same logic would put us at 50
planes which is well above the 32 planes limit imposed by DRM.

Using 16 seems like a good tradeoff between staying under 32 and yet
providing enough planes.

Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_plane.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vc4/vc4_plane.c b/drivers/gpu/drm/vc4/vc4_plane.c
index 5335123ae2a0..c190ccc42c51 100644
--- a/drivers/gpu/drm/vc4/vc4_plane.c
+++ b/drivers/gpu/drm/vc4/vc4_plane.c
@@ -1387,7 +1387,7 @@ int vc4_plane_create_additional_planes(struct drm_device *drm)
 	 * modest number of planes to expose, that should hopefully
 	 * still cover any sane usecase.
 	 */
-	for (i = 0; i < 8; i++) {
+	for (i = 0; i < 16; i++) {
 		struct drm_plane *plane =
 			vc4_plane_init(drm, DRM_PLANE_TYPE_OVERLAY);
 
-- 
git-series 0.9.1
