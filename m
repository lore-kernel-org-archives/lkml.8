Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3B90C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:54:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C26F920899
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:54:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="urxn0u51";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VwhFURFS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390525AbgE0PyN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 11:54:13 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:39049 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390235AbgE0Pvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 11:51:53 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id D047F582114;
        Wed, 27 May 2020 11:51:52 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 27 May 2020 11:51:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=JGXVhoFW91mN2
        E2QU0GxY5mdDUGcUQsnXqVzXlG9svM=; b=urxn0u51Ux8czLhE+NeHV6kmhzgfy
        BZKQsRT3bQySq56Ug7ov0q2ni5pNK0VpQuw4q2tOfPTKO++1yRQWdhzgpT0MIqfg
        C/im6hdEbtq4X6Zw3BKcEHv0p0SAVvp6JTk6I0Z8bKp2L75kzc2SP2EzqjCsd1Nx
        JFkYhxncwr18lmOXHcxnz4tR449qb874yKzcLJsKB7O9SC0fUSG9mdgiFG0eEJe0
        lZwNoZlKO7LvegDomkEwtstdSQaHciv8rBnmJmu1k0hDia1sT1dpceRiiTvAGvz1
        GID2DE2ixQi/HzIezTH8aV/4hoxvzJj15751tDKluD46IvvqWLgwnQQTA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=JGXVhoFW91mN2E2QU0GxY5mdDUGcUQsnXqVzXlG9svM=; b=VwhFURFS
        0+vRS3dXHtl9/MQLYZYf6vUD5og+Z08aGTxFxOkcKiscJzCOTOGsjtcI2JqqHl4N
        r9qH3JxFjpas61XpaQkjPLfyotSPfLVen+TJwkwOV9R24UCyQYcKU4ZkKsuHoXDe
        GdaPEtc/T2o8/mQIWFnlSjtb3A+wZ2GDQSiLWHmp4DxwZmIpDex2Iniu+Zwe9J5g
        8T7S9g+v8ZK6Jaid4+6HdLgXjjz4G09c1jwEkkpWBDFHu/H7zRhboGhoe2szcWNy
        pCF9GIev9a7ovdyL44M3QbfytvMvdrZ5GYQg4T+qxL8WLcLZxuhBs1/NhRlySp/v
        oUzhP0yvwghwsg==
X-ME-Sender: <xms:mIzOXq-7qZiy0eLf_1_7sR7JLCnfeGnakrTjcIduM3serzTmksJUNg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedruddvgedgkeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepjeehne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:mIzOXqs_Lo51JlqYf2R0YaLXgWEDLzT_PEdknk6l0c4jaolS9aMiug>
    <xmx:mIzOXgAW6QkHykfb1s6_xvbuZTJavD1TuK5zINwz-xmqp9v7cJ7UYw>
    <xmx:mIzOXifK5S4cSzaA74waLMG6UfXJfCMSKG4pkUxpkM5d5gSVKF2v3A>
    <xmx:mIzOXqcKI2LTdoFzkQYG66CKtuWo6jh4xvR9KT35kPeGKdJsZw_k0Q>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 835B830624CC;
        Wed, 27 May 2020 11:51:52 -0400 (EDT)
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
Subject: [PATCH v3 099/105] drm/vc4: hdmi: Always recenter the HDMI FIFO
Date:   Wed, 27 May 2020 17:49:09 +0200
Message-Id: <d45f4f0c96daebd149dca32303da4bd14c99a87c.1590594512.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.aaf2100bd7da4609f8bcb8216247d4b4e4379639.1590594512.git-series.maxime@cerno.tech>
References: <cover.aaf2100bd7da4609f8bcb8216247d4b4e4379639.1590594512.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to avoid a pixel getting stuck in an unflushable FIFO, we need to
recenter the FIFO every time we're doing a modeset and not only if we're
connected to an HDMI monitor.

Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_hdmi.c | 46 +++++++++++++++++++----------------
 1 file changed, 26 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index 4b23d589377a..a97f378c6d2d 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -425,6 +425,30 @@ static void vc4_hdmi_set_timings(struct vc4_hdmi *vc4_hdmi,
 		   (hsync_pos ? 0 : VC4_HD_VID_CTL_HSYNC_LOW));
 }
 
+static void vc4_hdmi_recenter_fifo(struct vc4_hdmi *vc4_hdmi)
+{
+	u32 drift;
+	int ret;
+
+	drift = HDMI_READ(HDMI_FIFO_CTL);
+	drift &= VC4_HDMI_FIFO_VALID_WRITE_MASK;
+
+	HDMI_WRITE(HDMI_FIFO_CTL,
+		   drift & ~VC4_HDMI_FIFO_CTL_RECENTER);
+	HDMI_WRITE(HDMI_FIFO_CTL,
+		   drift | VC4_HDMI_FIFO_CTL_RECENTER);
+	usleep_range(1000, 1100);
+	HDMI_WRITE(HDMI_FIFO_CTL,
+		   drift & ~VC4_HDMI_FIFO_CTL_RECENTER);
+	HDMI_WRITE(HDMI_FIFO_CTL,
+		   drift | VC4_HDMI_FIFO_CTL_RECENTER);
+
+	ret = wait_for(HDMI_READ(HDMI_FIFO_CTL) &
+		       VC4_HDMI_FIFO_CTL_RECENTER_DONE, 1);
+	WARN_ONCE(ret, "Timeout waiting for "
+		  "VC4_HDMI_FIFO_CTL_RECENTER_DONE");
+}
+
 static void vc4_hdmi_encoder_enable(struct drm_encoder *encoder)
 {
 	struct drm_display_mode *mode = &encoder->crtc->state->adjusted_mode;
@@ -543,8 +567,6 @@ static void vc4_hdmi_encoder_enable(struct drm_encoder *encoder)
 	}
 
 	if (vc4_encoder->hdmi_monitor) {
-		u32 drift;
-
 		WARN_ON(!(HDMI_READ(HDMI_SCHEDULER_CONTROL) &
 			  VC4_HDMI_SCHEDULER_CONTROL_HDMI_ACTIVE));
 		HDMI_WRITE(HDMI_SCHEDULER_CONTROL,
@@ -555,25 +577,9 @@ static void vc4_hdmi_encoder_enable(struct drm_encoder *encoder)
 			   VC4_HDMI_RAM_PACKET_ENABLE);
 
 		vc4_hdmi_set_infoframes(encoder);
-
-		drift = HDMI_READ(HDMI_FIFO_CTL);
-		drift &= VC4_HDMI_FIFO_VALID_WRITE_MASK;
-
-		HDMI_WRITE(HDMI_FIFO_CTL,
-			   drift & ~VC4_HDMI_FIFO_CTL_RECENTER);
-		HDMI_WRITE(HDMI_FIFO_CTL,
-			   drift | VC4_HDMI_FIFO_CTL_RECENTER);
-		usleep_range(1000, 1100);
-		HDMI_WRITE(HDMI_FIFO_CTL,
-			   drift & ~VC4_HDMI_FIFO_CTL_RECENTER);
-		HDMI_WRITE(HDMI_FIFO_CTL,
-			   drift | VC4_HDMI_FIFO_CTL_RECENTER);
-
-		ret = wait_for(HDMI_READ(HDMI_FIFO_CTL) &
-			       VC4_HDMI_FIFO_CTL_RECENTER_DONE, 1);
-		WARN_ONCE(ret, "Timeout waiting for "
-			  "VC4_HDMI_FIFO_CTL_RECENTER_DONE");
 	}
+
+	vc4_hdmi_recenter_fifo(vc4_hdmi);
 }
 
 static enum drm_mode_status
-- 
git-series 0.9.1
