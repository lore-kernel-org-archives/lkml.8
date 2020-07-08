Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F617C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 17:43:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F3A2207C4
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 17:43:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="RqLbJIcu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="d6PsKOF9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbgGHRnr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 13:43:47 -0400
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:47633 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727110AbgGHRnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 13:43:39 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id D4D4D10A4;
        Wed,  8 Jul 2020 13:43:37 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 08 Jul 2020 13:43:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=zFJHZQUTy1bnY
        gAlf5FgTQ/rrMfeSejtTuATKfAIljc=; b=RqLbJIcuKW/eO/qNSvs2YT/BL/mun
        +05zOklUcWsC6pMQksD780TqCTrCKjF5uoicjh9crC9C3JtJK0i4TZ8a72Aqyf4H
        8tviz13KT5BTmR7AaMyis4t/HnJV8XwKu0cOMKIxB+EgDesn/j7KsLOfJ5K55e9c
        mmPyHn95xjcKSaKFN9sUIkbwGcyxWqt9mfYTpJ/fZGKVzA6qXgUpbmQfpO8fOTm8
        oQpqDZIbOwK4Q89VTDHW2zHdWsZmVxoBOlgewymo/FLruZTpwO0UUMQWZ9YIyg4f
        S26GpersvxdRUTc9tzR7TSXURk7iNhU1gDE2Qo0TW2cuxkGcdaGQkq3nQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=zFJHZQUTy1bnYgAlf5FgTQ/rrMfeSejtTuATKfAIljc=; b=d6PsKOF9
        K+8uprWGJK3CFQU8k+Sz9Hvbn97bAIsmMOh+YNqXOGfDB/DjzUjhXjyDzAtn0vAK
        92/fQbgS7xWV1nVAHLQVAQQkaJX19u+Q7Hm/JR7vyUBSasH7eQBfEUdyLqVAk4Gp
        FUMEN0ddgrWUaxnyOaK48Vhi+7eI1U7vjuim8NTqEg3dYnLcg5W71Qqb3VNh3NEl
        OepwuzauTTsev+3tgu2BnIX0EYje2SwgK+njOMMNujIRUQ5VCVGlU3Ch3Oi0wW/1
        Ce3C8foes6glN0Rabf4w8pwmzZbhq9ajGalh3BfDqfdU/4LKyPrJ90uKKnGuoSZZ
        6OHRRbSx4pPxbA==
X-ME-Sender: <xms:yQUGX9D8opCPc-hq4cpm8JXag8XeZpk7YdURMiZrpCnYeR5voTy-_Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudejgdduudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepgeefne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:yQUGX7igPrxXS1OBfYrJF0fF_Tu531CWMNLZyVIiQ-To6gqObnzg2Q>
    <xmx:yQUGX4kWEBx5yUHdxyLzsu2PRWM-GrE7eoOC2qbuYrfO7egxIzGGyQ>
    <xmx:yQUGX3waSEABySXQurXPYs1m0sF_faW9JF-s8gwg8HvBB89ETthHYg>
    <xmx:yQUGX_TI8Q7rIrwCNbgFonXezeHUlnenWibB41OcylV3NWA4F8dHesshPTQ>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 1951D328005A;
        Wed,  8 Jul 2020 13:43:37 -0400 (EDT)
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
Subject: [PATCH v4 46/78] drm/vc4: hdmi: Pass vc4_hdmi to CEC code
Date:   Wed,  8 Jul 2020 19:41:54 +0200
Message-Id: <5d99c9c1fe8831588af896178ceffd0cce0d3885.1594230107.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.7a1aa1784976093af26cb31fd283cf5b3ed568bb.1594230107.git-series.maxime@cerno.tech>
References: <cover.7a1aa1784976093af26cb31fd283cf5b3ed568bb.1594230107.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Our CEC code also retrieves the associated vc4_hdmi by setting the
vc4_dev pointer as its private data, and then dereferences its vc4_hdmi
pointer.

In order to eventually get rid of that pointer, we can simply pass the
vc4_hdmi pointer directly.

Reviewed-by: Eric Anholt <eric@anholt.net>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_hdmi.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index d9db3c38f433..09b297a1b39d 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -1033,8 +1033,7 @@ static int vc4_hdmi_audio_init(struct vc4_hdmi *vc4_hdmi)
 #ifdef CONFIG_DRM_VC4_HDMI_CEC
 static irqreturn_t vc4_cec_irq_handler_thread(int irq, void *priv)
 {
-	struct vc4_dev *vc4 = priv;
-	struct vc4_hdmi *vc4_hdmi = vc4->hdmi;
+	struct vc4_hdmi *vc4_hdmi = priv;
 
 	if (vc4_hdmi->cec_irq_was_rx) {
 		if (vc4_hdmi->cec_rx_msg.len)
@@ -1054,9 +1053,8 @@ static irqreturn_t vc4_cec_irq_handler_thread(int irq, void *priv)
 	return IRQ_HANDLED;
 }
 
-static void vc4_cec_read_msg(struct vc4_dev *vc4, u32 cntrl1)
+static void vc4_cec_read_msg(struct vc4_hdmi *vc4_hdmi, u32 cntrl1)
 {
-	struct vc4_hdmi *vc4_hdmi = vc4->hdmi;
 	struct cec_msg *msg = &vc4_hdmi->cec_rx_msg;
 	unsigned int i;
 
@@ -1074,8 +1072,7 @@ static void vc4_cec_read_msg(struct vc4_dev *vc4, u32 cntrl1)
 
 static irqreturn_t vc4_cec_irq_handler(int irq, void *priv)
 {
-	struct vc4_dev *vc4 = priv;
-	struct vc4_hdmi *vc4_hdmi = vc4->hdmi;
+	struct vc4_hdmi *vc4_hdmi = priv;
 	u32 stat = HDMI_READ(VC4_HDMI_CPU_STATUS);
 	u32 cntrl1, cntrl5;
 
@@ -1086,7 +1083,7 @@ static irqreturn_t vc4_cec_irq_handler(int irq, void *priv)
 	cntrl5 = HDMI_READ(VC4_HDMI_CEC_CNTRL_5);
 	vc4_hdmi->cec_irq_was_rx = cntrl5 & VC4_HDMI_CEC_RX_CEC_INT;
 	if (vc4_hdmi->cec_irq_was_rx) {
-		vc4_cec_read_msg(vc4, cntrl1);
+		vc4_cec_read_msg(vc4_hdmi, cntrl1);
 		cntrl1 |= VC4_HDMI_CEC_CLEAR_RECEIVE_OFF;
 		HDMI_WRITE(VC4_HDMI_CEC_CNTRL_1, cntrl1);
 		cntrl1 &= ~VC4_HDMI_CEC_CLEAR_RECEIVE_OFF;
@@ -1102,8 +1099,7 @@ static irqreturn_t vc4_cec_irq_handler(int irq, void *priv)
 
 static int vc4_hdmi_cec_adap_enable(struct cec_adapter *adap, bool enable)
 {
-	struct vc4_dev *vc4 = cec_get_drvdata(adap);
-	struct vc4_hdmi *vc4_hdmi = vc4->hdmi;
+	struct vc4_hdmi *vc4_hdmi = cec_get_drvdata(adap);
 	/* clock period in microseconds */
 	const u32 usecs = 1000000 / CEC_CLOCK_FREQ;
 	u32 val = HDMI_READ(VC4_HDMI_CEC_CNTRL_5);
@@ -1146,8 +1142,7 @@ static int vc4_hdmi_cec_adap_enable(struct cec_adapter *adap, bool enable)
 
 static int vc4_hdmi_cec_adap_log_addr(struct cec_adapter *adap, u8 log_addr)
 {
-	struct vc4_dev *vc4 = cec_get_drvdata(adap);
-	struct vc4_hdmi *vc4_hdmi = vc4->hdmi;
+	struct vc4_hdmi *vc4_hdmi = cec_get_drvdata(adap);
 
 	HDMI_WRITE(VC4_HDMI_CEC_CNTRL_1,
 		   (HDMI_READ(VC4_HDMI_CEC_CNTRL_1) & ~VC4_HDMI_CEC_ADDR_MASK) |
@@ -1158,8 +1153,7 @@ static int vc4_hdmi_cec_adap_log_addr(struct cec_adapter *adap, u8 log_addr)
 static int vc4_hdmi_cec_adap_transmit(struct cec_adapter *adap, u8 attempts,
 				      u32 signal_free_time, struct cec_msg *msg)
 {
-	struct vc4_dev *vc4 = cec_get_drvdata(adap);
-	struct vc4_hdmi *vc4_hdmi = vc4->hdmi;
+	struct vc4_hdmi *vc4_hdmi = cec_get_drvdata(adap);
 	u32 val;
 	unsigned int i;
 
@@ -1306,7 +1300,7 @@ static int vc4_hdmi_bind(struct device *dev, struct device *master, void *data)
 
 #ifdef CONFIG_DRM_VC4_HDMI_CEC
 	vc4_hdmi->cec_adap = cec_allocate_adapter(&vc4_hdmi_cec_adap_ops,
-						  vc4, "vc4",
+						  vc4_hdmi, "vc4",
 						  CEC_CAP_DEFAULTS |
 						  CEC_CAP_CONNECTOR_INFO, 1);
 	ret = PTR_ERR_OR_ZERO(vc4_hdmi->cec_adap);
@@ -1330,7 +1324,7 @@ static int vc4_hdmi_bind(struct device *dev, struct device *master, void *data)
 	ret = devm_request_threaded_irq(dev, platform_get_irq(pdev, 0),
 					vc4_cec_irq_handler,
 					vc4_cec_irq_handler_thread, 0,
-					"vc4 hdmi cec", vc4);
+					"vc4 hdmi cec", vc4_hdmi);
 	if (ret)
 		goto err_delete_cec_adap;
 	ret = cec_register_adapter(vc4_hdmi->cec_adap, dev);
-- 
git-series 0.9.1
