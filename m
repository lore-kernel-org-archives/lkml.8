Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC8EC433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 13:38:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDEE520760
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 13:38:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="X/AOES0M";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IZQwgbYE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbgFKNix (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 09:38:53 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:35321 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728193AbgFKNio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 09:38:44 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id D62A35801DD;
        Thu, 11 Jun 2020 09:38:43 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 11 Jun 2020 09:38:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=gICVuJ6JxKf6T
        QPbCxr0GHMfBnZdU1/nxb1POOuoQgE=; b=X/AOES0MbnLou+TuWpjBo8gabvUj/
        bLtiuyEAus5zAF0VuVlLXe82tQqP0h6PjLSV7k6zh8g0b9XCih7t4Oqv4UnM6OOJ
        OCdmOVBtTbie9u/E8ssDcBxS+EsdAu4ynYLF/szb9KPwmexvQNv63/ocB0DyBGyW
        3oC+qy3uyypgPJjZ48PJfuL0GB5AudiyT4SW6Jc3sYqLa3Zr5se+QTKpi1DtrVvk
        WnhnUxdydhRKvivg6ax1bobXLaGQr6MQEuLORl9C13jcIFL3RQo0YIjajw9CTLwa
        lIhuYW9X1oAxv3b2ccYA18M7Gjv7SkgdB010W+Y9CpHJzwGV+SFNKECxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=gICVuJ6JxKf6TQPbCxr0GHMfBnZdU1/nxb1POOuoQgE=; b=IZQwgbYE
        lJzAL5F1kbyC3drkqxzv1e47AkQIqCnhFjwxBLWmNIK11+WO6ZFhUBhD58aQPDQM
        VygDHAr1NP6Yqr1Lft3k/cfwtAcaZ4PtPKQ9pwwXkEWxji4B0JWMwFpYI3LOEkGB
        Y6dQi0u7QfQFDNp4gFMKvOLTR+v2+IkCII7SyrQ21HHwrXE07vO7HC1dznyoURrG
        fJtG/J5JeCiwKtXA/ySHOL4Z1FsWFyDrjWocWzzPPeF34eNsOFPuEfYarur2Va8b
        /knECGuS5ZeclsGATV5NXksnLKeoFBQbrEXpZS9QPU1uu+NFfbDdMAP7TX1Lh0dG
        V3rzJjbenTStWA==
X-ME-Sender: <xms:4zPiXmskKEeP4nHHtYF6DSoyKMhOdHSoZVBgQjmajmtptwhpV4CCOw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudehledggeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepfeenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:4zPiXre_aQFikMkOfnu5xnsPDUXqecjcxYVCW-TE6fXE7g--bwNhtg>
    <xmx:4zPiXhxjWQKZOzfmNvnPrES6v-F2QU79gNfDWwAi20E8hVGUWguOjA>
    <xmx:4zPiXhPHzTn9qjsw8aQ_JAEEkHlQUKzOMxj6-i5VmKHOfI57Ma2iuA>
    <xmx:4zPiXrOlrqDmv2qmsq-EFYZIcT8wWQOd6pQLcJRvPoK5EfP5QsNgMA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id A02A5328023E;
        Thu, 11 Jun 2020 09:37:10 -0400 (EDT)
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
Subject: [PATCH v4 7/9] drm/vc4: crtc: Move the txp_armed function to the TXP
Date:   Thu, 11 Jun 2020 15:36:52 +0200
Message-Id: <12b383e7b8462e281b00c0a21b2b50f13691bead.1591882579.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.c33f5fd8b1b2703081f25398eb879937c9f7ce0b.1591882579.git-series.maxime@cerno.tech>
References: <cover.c33f5fd8b1b2703081f25398eb879937c9f7ce0b.1591882579.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The TXP driver is the only place where we need to set the txp_armed flag,
so let's move the function in the TXP driver.

Reviewed-by: Eric Anholt <eric@anholt.net>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_crtc.c |  7 -------
 drivers/gpu/drm/vc4/vc4_drv.h  |  1 -
 drivers/gpu/drm/vc4/vc4_txp.c  |  9 ++++++++-
 3 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_crtc.c b/drivers/gpu/drm/vc4/vc4_crtc.c
index e30a5036d2e6..82ebdf8da108 100644
--- a/drivers/gpu/drm/vc4/vc4_crtc.c
+++ b/drivers/gpu/drm/vc4/vc4_crtc.c
@@ -390,13 +390,6 @@ static void vc4_crtc_atomic_disable(struct drm_crtc *crtc,
 	}
 }
 
-void vc4_crtc_txp_armed(struct drm_crtc_state *state)
-{
-	struct vc4_crtc_state *vc4_state = to_vc4_crtc_state(state);
-
-	vc4_state->txp_armed = true;
-}
-
 static void vc4_crtc_atomic_enable(struct drm_crtc *crtc,
 				   struct drm_crtc_state *old_state)
 {
diff --git a/drivers/gpu/drm/vc4/vc4_drv.h b/drivers/gpu/drm/vc4/vc4_drv.h
index 1c49c27a564f..fa19160c801f 100644
--- a/drivers/gpu/drm/vc4/vc4_drv.h
+++ b/drivers/gpu/drm/vc4/vc4_drv.h
@@ -808,7 +808,6 @@ void vc4_crtc_destroy_state(struct drm_crtc *crtc,
 			    struct drm_crtc_state *state);
 void vc4_crtc_reset(struct drm_crtc *crtc);
 void vc4_crtc_handle_vblank(struct vc4_crtc *crtc);
-void vc4_crtc_txp_armed(struct drm_crtc_state *state);
 void vc4_crtc_get_margins(struct drm_crtc_state *state,
 			  unsigned int *right, unsigned int *left,
 			  unsigned int *top, unsigned int *bottom);
diff --git a/drivers/gpu/drm/vc4/vc4_txp.c b/drivers/gpu/drm/vc4/vc4_txp.c
index bf720206727f..d9a8ab87ad25 100644
--- a/drivers/gpu/drm/vc4/vc4_txp.c
+++ b/drivers/gpu/drm/vc4/vc4_txp.c
@@ -222,6 +222,13 @@ static const u32 txp_fmts[] = {
 	TXP_FORMAT_BGRA8888,
 };
 
+static void vc4_txp_armed(struct drm_crtc_state *state)
+{
+	struct vc4_crtc_state *vc4_state = to_vc4_crtc_state(state);
+
+	vc4_state->txp_armed = true;
+}
+
 static int vc4_txp_connector_atomic_check(struct drm_connector *conn,
 					  struct drm_atomic_state *state)
 {
@@ -256,7 +263,7 @@ static int vc4_txp_connector_atomic_check(struct drm_connector *conn,
 	if (fb->pitches[0] & GENMASK(3, 0))
 		return -EINVAL;
 
-	vc4_crtc_txp_armed(crtc_state);
+	vc4_txp_armed(crtc_state);
 
 	return 0;
 }
-- 
git-series 0.9.1
