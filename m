Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62382C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 17:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38FA6206E2
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 17:42:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="r2V6N3BP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WKTANOBb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbgGHRmz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 13:42:55 -0400
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:39637 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726541AbgGHRmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 13:42:52 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 92339333;
        Wed,  8 Jul 2020 13:42:50 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 08 Jul 2020 13:42:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=+GsL/PhEM1vcC
        hoGS1OCu8EP3VmI+pijDvz5ksKewGI=; b=r2V6N3BPhoh5Ia8G9Z1LPUUcL+9xw
        Ogs5Kw2pcD43qODVazexU/nU3tvY4B2ELcumGAqphneygl1ILSI2JSD8Zn6f2UTQ
        gqkJZDeoy9uK1y5k1Klu1MVlRm7zKiLmwaBXFgtRiYEGcIoybV64SoZLm3oJ0L0D
        Qn8s7P0vsju6K7K8FlyAmoe/LgNBzHyqIe7kDnA25HQlKgddYEyM0u3Tq1Mxxiqw
        JQKKSey/W9oeCelvjWO91V6oNQT+kxltxJM+8R/6l231DL2V+5J1/llqciFT5Nwz
        nfnyQPk3U33PYmPwiIqcovEJG3/N8bhxlqZ65DDen3EKa4VskPMqbczAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=+GsL/PhEM1vcChoGS1OCu8EP3VmI+pijDvz5ksKewGI=; b=WKTANOBb
        CwZDaxzl7y+r1S1upxUrAw8aq/oNadwZOEh8eT9SkrUklb4c2O2wtaanHXNgiGGQ
        PFcwzEv/77gJza/9G22jVmch9Y9qrdi3h7LguXujEZ3r81NRYDQaEABH2Kt073KS
        Y9qLwjZ2wRTwR9zoJpWuN00djUVtI+oDfr/TiNTMxJeWbdF3d72HbdvrHuzvrO/5
        m1//A69vMehvdwEQnEjjm2z/7/jE/RApDUDWd88HbVI3jFwayvU7BkrWzgzzIpHM
        yHuAMOzgF1p7ZtQHuSwjg9D+aUVZjvtvO9xuR2whCDUxBPe0lPCLo9SUJRdqUJqB
        PIj9X8jZXXRhAQ==
X-ME-Sender: <xms:mgUGXxvIw69rXw2tPHJTQZzd6A7OG2hykqvzCyz8O4LhNpzdosFBzA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudejgdduudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepuddune
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:mgUGX6eR_uYo0NOMtQymzB5D04R_VJgDjO0w_dQVjzylUcpxhMJRow>
    <xmx:mgUGX0xmlCB5L1C8KIsvtKXEVodUub9CDaZGobZD1AztmQ86FqK2gQ>
    <xmx:mgUGX4NCC67VBVrce5O8460-UM8XSSTc1NaMCS4oB-JK2Dggmd3ggQ>
    <xmx:mgUGX6PT2zXw4OCpk5PyVDm5oMUrvRkQLSRHAhKlKUOU2edBjVs3pppV-oc>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id D279130600B1;
        Wed,  8 Jul 2020 13:42:49 -0400 (EDT)
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
Subject: [PATCH v4 13/78] drm/vc4: kms: Convert to for_each_new_crtc_state
Date:   Wed,  8 Jul 2020 19:41:21 +0200
Message-Id: <8af06b31c58ec9745ce13c2aca4e532d6ca340e0.1594230107.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.7a1aa1784976093af26cb31fd283cf5b3ed568bb.1594230107.git-series.maxime@cerno.tech>
References: <cover.7a1aa1784976093af26cb31fd283cf5b3ed568bb.1594230107.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The vc4 atomic commit loop has an handrolled loop that is basically
identical to for_each_new_crtc_state, let's convert it to that helper.

Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_kms.c |  9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_kms.c b/drivers/gpu/drm/vc4/vc4_kms.c
index 210cc2408087..717673b18132 100644
--- a/drivers/gpu/drm/vc4/vc4_kms.c
+++ b/drivers/gpu/drm/vc4/vc4_kms.c
@@ -152,14 +152,13 @@ vc4_atomic_complete_commit(struct drm_atomic_state *state)
 	struct drm_device *dev = state->dev;
 	struct vc4_dev *vc4 = to_vc4_dev(dev);
 	struct vc4_hvs *hvs = vc4->hvs;
-	struct vc4_crtc *vc4_crtc;
+	struct drm_crtc_state *new_crtc_state;
+	struct drm_crtc *crtc;
 	int i;
 
-	for (i = 0; i < dev->mode_config.num_crtc; i++) {
-		if (!state->crtcs[i].ptr || !state->crtcs[i].commit)
-			continue;
+	for_each_new_crtc_in_state(state, crtc, new_crtc_state, i) {
+		struct vc4_crtc *vc4_crtc = to_vc4_crtc(crtc);
 
-		vc4_crtc = to_vc4_crtc(state->crtcs[i].ptr);
 		vc4_hvs_mask_underrun(dev, vc4_crtc->channel);
 	}
 
-- 
git-series 0.9.1
