Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC124C433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 08:05:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7909220C09
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 08:05:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="bBE6pAul";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ObHfDdpB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728414AbgICIFy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 04:05:54 -0400
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:36545 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728454AbgICIDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 04:03:10 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 308DF968;
        Thu,  3 Sep 2020 04:03:08 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 03 Sep 2020 04:03:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=jxCvojCz1iv4P
        IK0d7Aqcf61S140hivG1KozbVKpi6k=; b=bBE6pAulOxz3Bh/Ylm8P1TQhrtwTG
        lA7eVTXydg+AAkDvX4nHYiQkzZ15EhEd5VVxz613i0Wop6azQcahlXEx0q8c6rLX
        GOn7HC9pnoxLbA6KfhAxpbm14RVQVXvQAXLa0qmGqL9D7huBFuOCXqgz5k6DFYfe
        IkNcBP9lILHkbbS1mtdM75xS+Xo8CiptRJLhzo2sCcy95DIkehmSMqfdmJ7X30ef
        VOLfEdv5uq7sQ8rWxN/FTv3cG0k/C40L18A7uAPzVEs10IKR1r3ScTimagNKtXSY
        Vm+GzLnajKLMzLaLN062JOENmNs1ptkOUbnJbH3hTw3mB6MRUt3WxG9dQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=jxCvojCz1iv4PIK0d7Aqcf61S140hivG1KozbVKpi6k=; b=ObHfDdpB
        oS2A/P5BU4OVlp9Teiz/D9h/HS/n3oK6DV0x8BTCO76GSE8NreRn1kqz+UG5GOKK
        NT4OfwnI9VgHllCL3nJV3LOX3bg3VLAxsqd+JM+IllWjVB6reERZ7hYbc+1g1ZBQ
        KLCPsKxCtclzPmO3w0hL5zc845S/cTGxM82Dc0GUKJ9D7l2GTUVQ+uPUx5QqFG05
        tbHtnJTZQ9ZpkXA0co7L9KBpsoAbFh2qFojd4LxyG4TQmh6xzkYFx0Lvp2wVUWpB
        CEUKCp4rArH18i/fhDjPjJnHPDZ4V+2LPURm1cPuZDImkEgF1gudiCYV9aoCDLFi
        XeoCj8oD2BhRWw==
X-ME-Sender: <xms:O6NQXzr2ibIERSqXn8y0KPoTw92AiLXdkkWFXdvb50PRPABMDI3pmw>
    <xme:O6NQX9oOZIk4WrLk4YwQ7cm_v4da01xf8eZbZ0lRtLPrD8lyiC56y47Nd7a7DkNHJ
    loJJfu9Rhz175SAh2Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudegtddguddviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpedvkeelveefffekjefhffeuleetleefudeifeehuddugffghffhffehveev
    heehvdenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpeegie
    enucfrrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:O6NQXwOHShl8XQ9HoVaOxBwR2m88uO0frl47Qiv5ahPV4Rr1YqrsWQ>
    <xmx:O6NQX26arw_GqKq_YNHjv3c6eyLIJnm060Lz1LxGDhPblbz1AtxLvw>
    <xmx:O6NQXy5ZL3APPioF6nbDOghOpEd9xK5nh45otC29VbqV3GnFh-k68A>
    <xmx:O6NQX6gF2UREQK5QVZeFq_9Vv-eb7xOfauos4stHWWsBwDZiXYidy0UBvCg>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 69B7D3280064;
        Thu,  3 Sep 2020 04:03:06 -0400 (EDT)
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
Subject: [PATCH v5 52/80] drm/vc4: hdmi: Add reset callback
Date:   Thu,  3 Sep 2020 10:01:24 +0200
Message-Id: <a34bcb493da07eae58ed704f65e72ce0748e8952.1599120059.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.dddc064d8bb83e46744336af67dcb13139e5747d.1599120059.git-series.maxime@cerno.tech>
References: <cover.dddc064d8bb83e46744336af67dcb13139e5747d.1599120059.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The BCM2711 and BCM283x HDMI controllers use a slightly different reset
sequence, so let's add a callback to reset the controller.

Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Tested-by: Chanwoo Choi <cw00.choi@samsung.com>
Tested-by: Hoegeun Kwon <hoegeun.kwon@samsung.com>
Tested-by: Stefan Wahren <stefan.wahren@i2se.com>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_hdmi.c | 31 ++++++++++++++++++-------------
 drivers/gpu/drm/vc4/vc4_hdmi.h |  3 +++
 2 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index adc7c0693650..77971be075ec 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -69,6 +69,21 @@ static int vc4_hdmi_debugfs_regs(struct seq_file *m, void *unused)
 	return 0;
 }
 
+static void vc4_hdmi_reset(struct vc4_hdmi *vc4_hdmi)
+{
+	HDMI_WRITE(HDMI_M_CTL, VC4_HD_M_SW_RST);
+	udelay(1);
+	HDMI_WRITE(HDMI_M_CTL, 0);
+
+	HDMI_WRITE(HDMI_M_CTL, VC4_HD_M_ENABLE);
+
+	HDMI_WRITE(HDMI_SW_RESET_CONTROL,
+		   VC4_HDMI_SW_RESET_HDMI |
+		   VC4_HDMI_SW_RESET_FORMAT_DETECT);
+
+	HDMI_WRITE(HDMI_SW_RESET_CONTROL, 0);
+}
+
 static enum drm_connector_status
 vc4_hdmi_connector_detect(struct drm_connector *connector, bool force)
 {
@@ -363,11 +378,8 @@ static void vc4_hdmi_encoder_enable(struct drm_encoder *encoder)
 		return;
 	}
 
-	HDMI_WRITE(HDMI_SW_RESET_CONTROL,
-		   VC4_HDMI_SW_RESET_HDMI |
-		   VC4_HDMI_SW_RESET_FORMAT_DETECT);
-
-	HDMI_WRITE(HDMI_SW_RESET_CONTROL, 0);
+	if (vc4_hdmi->variant->reset)
+		vc4_hdmi->variant->reset(vc4_hdmi);
 
 	/* PHY should be in reset, like
 	 * vc4_hdmi_encoder_disable() does.
@@ -1291,14 +1303,6 @@ static int vc4_hdmi_bind(struct device *dev, struct device *master, void *data)
 		vc4_hdmi->hpd_active_low = hpd_gpio_flags & OF_GPIO_ACTIVE_LOW;
 	}
 
-	/* HDMI core must be enabled. */
-	if (!(HDMI_READ(HDMI_M_CTL) & VC4_HD_M_ENABLE)) {
-		HDMI_WRITE(HDMI_M_CTL, VC4_HD_M_SW_RST);
-		udelay(1);
-		HDMI_WRITE(HDMI_M_CTL, 0);
-
-		HDMI_WRITE(HDMI_M_CTL, VC4_HD_M_ENABLE);
-	}
 	pm_runtime_enable(dev);
 
 	drm_simple_encoder_init(drm, encoder, DRM_MODE_ENCODER_TMDS);
@@ -1427,6 +1431,7 @@ static const struct vc4_hdmi_variant bcm2835_variant = {
 	.num_registers		= ARRAY_SIZE(vc4_hdmi_fields),
 
 	.init_resources		= vc4_hdmi_init_resources,
+	.reset			= vc4_hdmi_reset,
 };
 
 static const struct of_device_id vc4_hdmi_dt_match[] = {
diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.h b/drivers/gpu/drm/vc4/vc4_hdmi.h
index b36e0210671f..17a30589f39c 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.h
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.h
@@ -35,6 +35,9 @@ struct vc4_hdmi_variant {
 	 * clocks, etc) for that variant.
 	 */
 	int (*init_resources)(struct vc4_hdmi *vc4_hdmi);
+
+	/* Callback to reset the HDMI block */
+	void (*reset)(struct vc4_hdmi *vc4_hdmi);
 };
 
 /* HDMI audio information */
-- 
git-series 0.9.1
