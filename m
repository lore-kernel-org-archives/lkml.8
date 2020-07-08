Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36192C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 17:44:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 156AF206DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 17:44:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="dWtICfbT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bKkVdE06"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728233AbgGHRot (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 13:44:49 -0400
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:34323 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728031AbgGHRoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 13:44:13 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 9201A333;
        Wed,  8 Jul 2020 13:44:12 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 08 Jul 2020 13:44:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=xdl2eLghVNafT
        Ut0e6LydxebMrJ4MDHKK656BcDDsp4=; b=dWtICfbTZHOne+h/JQzxnBLKVsjeQ
        bKDesKRYnha6ox+JhczGcRGYnXjapL77jv+6ANkn5q5tFFp6PardO3k0jDkiP1+Z
        78gHX5fGzTvcyZItCDPmW+O2loMZ4hKAfp6JPC2loDPs7ErgbA16ID1qI5HJaceR
        Ou9VREbHwTYzB0tJmBmt5++9gfMwp6/SbBwhL8phPcSwreCLF3wJNfn8nf638wDo
        PDjPctkoy/EKF+TIZp91dK7o+xZsLCxpwxMiu18N+HGDz23qKcQ0AlYK9bbJgzDw
        nzar+akvQ5ZGJdQbTCf/fP5005burcxfBw4/zZKCzzH3GRcVZH20JET5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=xdl2eLghVNafTUt0e6LydxebMrJ4MDHKK656BcDDsp4=; b=bKkVdE06
        D9/V428o+6LsuZL3sh4L2N4yBbBl8ZHmVpp6uEmfwlHmagJCjOvBQABgy8xoU2Dl
        GY2qEjiHfCpLjhla6Z4iDzwbRSXcE0rn+QCXWj8U7wuYXCdKmg7Q6cqrf3B7LaaE
        JDjL75mIFi23H8nFDhTeFiezSQwDL2B9uLPoO8HO96TAiSxb/lqMEY66wCwbfQO5
        bQ1/HAKpp9i6ugS4vglB1KsW7ExKW1RnJyEsggg0+WaOYhSzd2QUGi5QOX9B6IhL
        GgBoeLsNuPdACqq6nvkbP30yP2EG/T4N/AQ4sWwYVnzRA0EPpkz//oPrqZQN9ula
        R2kfKnX0D8cwWQ==
X-ME-Sender: <xms:7AUGX8nLvgv83U-KkCLPLnzcMW2W6gcRbI2519rET4vjl240edy-MQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudejgdduudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepieeine
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:7AUGX712ld61A7-9vc3s_w_WDZwaiENvvxkdWGTMnLJ39SBgjZnxnw>
    <xmx:7AUGX6q07WGhDK1reEcRF87CWURkG9QT5iKWtmd-lO2RkZxAKcGIhA>
    <xmx:7AUGX4kUIoAJspvaGClsnxuQoKXVDuKun-QvUh2mujd-NQlGUIXXAA>
    <xmx:7AUGXzkq7k4nVizJBHxWStwTeq4t3HRe3a2nZ4F5hVArU-V1tP3TEbQcBoE>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id CF62A328005E;
        Wed,  8 Jul 2020 13:44:11 -0400 (EDT)
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
Subject: [PATCH v4 70/78] drm/vc4: hdmi: Always recenter the HDMI FIFO
Date:   Wed,  8 Jul 2020 19:42:18 +0200
Message-Id: <12499869afccd632b222eec328a6352111472986.1594230107.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.7a1aa1784976093af26cb31fd283cf5b3ed568bb.1594230107.git-series.maxime@cerno.tech>
References: <cover.7a1aa1784976093af26cb31fd283cf5b3ed568bb.1594230107.git-series.maxime@cerno.tech>
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
index 4058985940e6..00592c1ada73 100644
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
