Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A172C433E7
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 08:06:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09433215A4
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 08:06:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="cDAp9pcm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GJR49dxW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728735AbgICIGl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 04:06:41 -0400
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:53315 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728503AbgICIDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 04:03:35 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 59740C18;
        Thu,  3 Sep 2020 04:03:34 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 03 Sep 2020 04:03:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=7xfe+tngvDJEY
        yUZhayJC8QppzfdlwLaBZR0Cls2PKk=; b=cDAp9pcmmAjzSkzW6PCfYurgzp2S/
        lloNta+FniysiGwo/Z7KYRo3PMIbZAczW+Bzhkqh0BiP0S5CeNc0ibJ+HfuoFxIz
        dhty100SiMFZCAe3DbhAlh9ZiRrKQcSZSrrVeux2j4JZvhyz2l3oMNSn4dYX+PTQ
        CUu99lez8j5eCWxE4OEblco3WB4uKfWNrwmKQuVvcKSQqLx+ndH/JDvniVRtJMGk
        AaSYLeyt4GHt25tOcFbRUIyJiZ+Yj3EJIBpnIPdzsNJve4ItxizfT87JJUqnni9Q
        3s+s5+DnkuEgHs61YK1O6El3ksqkQG8flHaGT+1Bht6i1WGG0tMgQUgWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=7xfe+tngvDJEYyUZhayJC8QppzfdlwLaBZR0Cls2PKk=; b=GJR49dxW
        6IBXLqWnkyf72+VJOp5lV6LXGbBVzZl5c+JoY2Ulu29yVLhtjxpZSZjs0LCqiY7x
        nHBGXp5A/ZVcThs8PndsOah2ooUaOvs09E5OIdejzo/T8OedlfImTv5aV8fsBT6D
        iUGynUt6gtf0NAF6M+e52QkwBt7sGppx2ENw07oT9eBqyUau5w81Hu1cKeQqKvYg
        8jjMIgFyVr0yE7V+Ys7YjnyV8ghBmTeG7Db+ZA2c7sZjvtPEK5D9XvsiZTycJU1p
        9c/0ocqNyje0qRqSNQElMsza5OcW8nJeGPOF3GMVvl99XbDIB95dwRTowyT/uHIc
        IBLmWyckwHlWNA==
X-ME-Sender: <xms:VaNQX0EScVT9I_3-rQecQE5Nqy4L9h7o-CagpCHSa1vHLg_bZ3mc5Q>
    <xme:VaNQX9VHbQQTKw6MUBCt0VXoo_fNIaerGaek4bWgJVAZgrRbsLPzez_TjL4XkjoBE
    RyzVxIbgZrdrl7kva4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudegtddguddviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpedvkeelveefffekjefhffeuleetleefudeifeehuddugffghffhffehveev
    heehvdenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpeeije
    enucfrrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:VaNQX-JLzfYAtkPl5cHp1o6ueo3K71wcuQURl5UypX2ra4pFDVPKlg>
    <xmx:VaNQX2HH0byuLFHsk64cOEP-9iHPNZZBi3M2aoIKQRGHpuD6EedepQ>
    <xmx:VaNQX6XOIgbgH7_u-McmvEOcbEUOI1l65F1ajSWad6-D6RwadUxCsA>
    <xmx:VqNQXxO0kevK005VXW04D1sknp3XTOthZFuzVi3Fv73vGXSBp0YIWtNavEk>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 964CC306005B;
        Thu,  3 Sep 2020 04:03:33 -0400 (EDT)
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
        Maxime Ripard <maxime@cerno.tech>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Hoegeun Kwon <hoegeun.kwon@samsung.com>,
        Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH v5 71/80] drm/vc4: hdmi: Always recenter the HDMI FIFO
Date:   Thu,  3 Sep 2020 10:01:43 +0200
Message-Id: <b3faaf05ac6c4d3c364d28fa441571eb85903269.1599120059.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.dddc064d8bb83e46744336af67dcb13139e5747d.1599120059.git-series.maxime@cerno.tech>
References: <cover.dddc064d8bb83e46744336af67dcb13139e5747d.1599120059.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to avoid a pixel getting stuck in an unflushable FIFO, we need to
recenter the FIFO every time we're doing a modeset and not only if we're
connected to an HDMI monitor.

Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Tested-by: Chanwoo Choi <cw00.choi@samsung.com>
Tested-by: Hoegeun Kwon <hoegeun.kwon@samsung.com>
Tested-by: Stefan Wahren <stefan.wahren@i2se.com>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_hdmi.c | 46 +++++++++++++++++++----------------
 1 file changed, 26 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index 3c7862a1dda8..c9eae5352b9a 100644
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
