Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38C4BC433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 08:09:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A455206C0
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 08:09:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="mu1Rj9OJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IZZlT9wT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728822AbgICIJo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 04:09:44 -0400
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:50677 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728417AbgICICf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 04:02:35 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id BC219C26;
        Thu,  3 Sep 2020 04:02:33 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 03 Sep 2020 04:02:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=Qy1bXI9WTAVPe
        UBYzEAgOTUAeaY+jJnvj8XtlP1MKN4=; b=mu1Rj9OJ3b4zp1ORZwi6K3l8zBHfT
        0uU5/mSaZr/7pz0w70QPECMA3fuOuZQ8jQstMDthohnsfEg1feNcQa4lklXGhpa+
        uMdDcQAIcRXktyNQ+5N3eVb1hcLEC5aqQlcXVulaARpD3yzysNT8YdG6Ck89Ynl5
        c05V+ppWOCyWcfb8aBmChnZpsk03dFngb2wGKGJ7RdLLs4PgY6GjThFxtvT3ZCc4
        sg+4JZrI1VaKbvsJfxPZYC/GBqZAUJaErW79RKfgEI9Zv3/F6IxRM1NGpya2UPb8
        IrZSwrHUbaaKyRYaTyEmRQoanKi8qUwoM3WxQGU8mCrcV4qPLJvCJjgIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=Qy1bXI9WTAVPeUBYzEAgOTUAeaY+jJnvj8XtlP1MKN4=; b=IZZlT9wT
        BosAMVq1Tnj9lvZa+czWhjv6ER057F6n1FYvOccdj62V/6vHgngHBVRO7WjkFOT7
        5ZlF3BSd8+44qjS861ctnZIpbmL8gr8T2CU80vmA74PYoWY7CTXwiMstHEpy34hW
        D51D+ub4T/67s9oFudN6cf/DCJ6rb2akiYUTr86JvghkDLjw7D0+72HMIu/28DQC
        r8pqep1fOyh4mky39vW9Gyo6iG/M+Ef787QZCJTlCuH/YSxVgBY5sXwkcJqqVuub
        uBvNVgtECeOHsxB8FpUZngnDVUoUNtl+QyS429fHBHR0LMSj4u7qsgghsCDsGQSd
        1b5uaT1/DX+6Nw==
X-ME-Sender: <xms:GaNQXwyBeyG_Fz5fFMLtKCAiwoeeM795qq8HmAkVsQYX_eUMfL4aHA>
    <xme:GaNQX0TWjN7bA8EYxMbO7j3z_DRXwuF2qYAzan9qOhK5nFyxZKjC5Uk6ZZkXygoJp
    zukweIswYNSYXyv42U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudegtddguddviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpedvkeelveefffekjefhffeuleetleefudeifeehuddugffghffhffehveev
    heehvdenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedvje
    enucfrrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:GaNQXyWriMABSsnYnQf3hqnQfc80Z_PaQgl3FG_eGRv-XieB15fIkg>
    <xmx:GaNQX-iI8-Tk_2gSg2W81WIUU5hx__G7mRrk5FWJp5aRl8tl9l4EPw>
    <xmx:GaNQXyB_1eoRjoblp6J5VkmUd2e_fpKgba-ct6j1Q0XlCTYIZnc0Sw>
    <xmx:GaNQXzKw28VygCfI4-2acOqxbNd_zSAV8vG7lr-Hl3kJXORVgpnHyx-IRKA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id C0D483280065;
        Thu,  3 Sep 2020 04:02:32 -0400 (EDT)
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
Subject: [PATCH v5 28/80] drm/vc4: encoder: Add finer-grained encoder callbacks
Date:   Thu,  3 Sep 2020 10:01:00 +0200
Message-Id: <1dd78efe8f29add73c97d0148cfd4ec8e34aaf22.1599120059.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.dddc064d8bb83e46744336af67dcb13139e5747d.1599120059.git-series.maxime@cerno.tech>
References: <cover.dddc064d8bb83e46744336af67dcb13139e5747d.1599120059.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the BCM2711, the setup of the HVS, pixelvalve and HDMI controller
requires very precise ordering and timing that the regular atomic callbacks
don't provide. Let's add new callbacks on top of the regular ones to be
able to split the configuration as needed.

Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Tested-by: Chanwoo Choi <cw00.choi@samsung.com>
Tested-by: Hoegeun Kwon <hoegeun.kwon@samsung.com>
Tested-by: Stefan Wahren <stefan.wahren@i2se.com>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_crtc.c | 19 +++++++++++++++++++
 drivers/gpu/drm/vc4/vc4_drv.h  |  7 +++++++
 2 files changed, 26 insertions(+)

diff --git a/drivers/gpu/drm/vc4/vc4_crtc.c b/drivers/gpu/drm/vc4/vc4_crtc.c
index b7b0e19e2fe1..d0b326e1df0a 100644
--- a/drivers/gpu/drm/vc4/vc4_crtc.c
+++ b/drivers/gpu/drm/vc4/vc4_crtc.c
@@ -389,6 +389,8 @@ static void vc4_crtc_atomic_disable(struct drm_crtc *crtc,
 {
 	struct drm_device *dev = crtc->dev;
 	struct vc4_crtc *vc4_crtc = to_vc4_crtc(crtc);
+	struct drm_encoder *encoder = vc4_get_crtc_encoder(crtc);
+	struct vc4_encoder *vc4_encoder = to_vc4_encoder(encoder);
 	int ret;
 
 	require_hvs_enabled(dev);
@@ -401,10 +403,16 @@ static void vc4_crtc_atomic_disable(struct drm_crtc *crtc,
 	ret = wait_for(!(CRTC_READ(PV_V_CONTROL) & PV_VCONTROL_VIDEN), 1);
 	WARN_ONCE(ret, "Timeout waiting for !PV_VCONTROL_VIDEN\n");
 
+	if (vc4_encoder->post_crtc_disable)
+		vc4_encoder->post_crtc_disable(encoder);
+
 	CRTC_WRITE(PV_CONTROL, CRTC_READ(PV_CONTROL) & ~PV_CONTROL_EN);
 
 	vc4_hvs_atomic_disable(crtc, old_state);
 
+	if (vc4_encoder->post_crtc_powerdown)
+		vc4_encoder->post_crtc_powerdown(encoder);
+
 	/*
 	 * Make sure we issue a vblank event after disabling the CRTC if
 	 * someone was waiting it.
@@ -424,6 +432,8 @@ static void vc4_crtc_atomic_enable(struct drm_crtc *crtc,
 {
 	struct drm_device *dev = crtc->dev;
 	struct vc4_crtc *vc4_crtc = to_vc4_crtc(crtc);
+	struct drm_encoder *encoder = vc4_get_crtc_encoder(crtc);
+	struct vc4_encoder *vc4_encoder = to_vc4_encoder(encoder);
 
 	require_hvs_enabled(dev);
 
@@ -434,15 +444,24 @@ static void vc4_crtc_atomic_enable(struct drm_crtc *crtc,
 
 	vc4_hvs_atomic_enable(crtc, old_state);
 
+	if (vc4_encoder->pre_crtc_configure)
+		vc4_encoder->pre_crtc_configure(encoder);
+
 	vc4_crtc_config_pv(crtc);
 
 	CRTC_WRITE(PV_CONTROL, CRTC_READ(PV_CONTROL) | PV_CONTROL_EN);
 
+	if (vc4_encoder->pre_crtc_enable)
+		vc4_encoder->pre_crtc_enable(encoder);
+
 	/* When feeding the transposer block the pixelvalve is unneeded and
 	 * should not be enabled.
 	 */
 	CRTC_WRITE(PV_V_CONTROL,
 		   CRTC_READ(PV_V_CONTROL) | PV_VCONTROL_VIDEN);
+
+	if (vc4_encoder->post_crtc_enable)
+		vc4_encoder->post_crtc_enable(encoder);
 }
 
 static enum drm_mode_status vc4_crtc_mode_valid(struct drm_crtc *crtc,
diff --git a/drivers/gpu/drm/vc4/vc4_drv.h b/drivers/gpu/drm/vc4/vc4_drv.h
index dfcc684f5d28..251fcc35530c 100644
--- a/drivers/gpu/drm/vc4/vc4_drv.h
+++ b/drivers/gpu/drm/vc4/vc4_drv.h
@@ -439,6 +439,13 @@ struct vc4_encoder {
 	struct drm_encoder base;
 	enum vc4_encoder_type type;
 	u32 clock_select;
+
+	void (*pre_crtc_configure)(struct drm_encoder *encoder);
+	void (*pre_crtc_enable)(struct drm_encoder *encoder);
+	void (*post_crtc_enable)(struct drm_encoder *encoder);
+
+	void (*post_crtc_disable)(struct drm_encoder *encoder);
+	void (*post_crtc_powerdown)(struct drm_encoder *encoder);
 };
 
 static inline struct vc4_encoder *
-- 
git-series 0.9.1
