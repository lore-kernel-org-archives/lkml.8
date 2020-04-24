Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9CACC54FD0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 15:38:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90CD320767
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 15:38:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="YKrze/7p";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Pn9zzOM6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728990AbgDXPiK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 11:38:10 -0400
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:40073 "EHLO
        wnew2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728817AbgDXPhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 11:37:16 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 9327710AA;
        Fri, 24 Apr 2020 11:37:14 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 24 Apr 2020 11:37:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=v0wT99TRG4A07
        CiLRgiNJop5CNO/2rg6M7E82BWYHLU=; b=YKrze/7plwHLwACpj24dyp2L9+FfA
        PBIkH+/g60+68fh4KNV5CXnxb3lJQJ6ReZcnlcozbPBcXH8CE4Rd3/ghdGEqcTCh
        YCWSXIpbMUl9xrluRAm5iJapg0aVv7RydHL6p3w2TY0ggbKlkMEN4B7su+Ct1Y1R
        2Surnu/J20oKt9UEPgyFH0P2jqEYcnRQUJxOtvsq63rns/XcYoBxI5SPS71Wkvfc
        anjD0ifw+8rbrqqlvTnVyk1VQTUfh+mNTfeYjIhj418q90wMxcCYjOJF2cG2Zsmk
        yBmxUt+sB8fi753Wdtln7Jc07uq0ac0YUKEuh62hA/i/j+eY1+qH+RuBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=v0wT99TRG4A07CiLRgiNJop5CNO/2rg6M7E82BWYHLU=; b=Pn9zzOM6
        iBvBLlsXaxT7ZCQMMMB8tF4yJ7txV0YT71fbyKVC+Di04LfNQOdnjkXGLw0ZP7H/
        0sUmmkib0ca0gf7GkXbtBs8B7c/w6fEMoHm2hjRWkEEpAD1Hij80NemBB3RVwU06
        Oahp2y40zPs0FwpSbnz0FASI8oLC8F2hJEFtIPfwi7nuC3UZPzcPbS/p1/H0RV3M
        9gS1EtpVYcDzI7xvw0CV3xDbXNMH/dYBNr/OPQ78cg/C5V5s70Tv+KSGwD2UTpKN
        uKeqgvcFvj68QObnHvVutnu212var7nHhU/tFy9hLSAiGuv9Q3raMa0RvdNyourR
        b89BLF5u0fxR9Q==
X-ME-Sender: <xms:qgejXvNFYpmqDlm6gH4L1BGeRe4gQd4HEUWHELwWPManjWIPkCOOrw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrhedugdekiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucfkphepledtrd
    ekledrieekrdejieenucevlhhushhtvghrufhiiigvpeejtdenucfrrghrrghmpehmrghi
    lhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:qgejXuMP2XCDuNAxgGBjcnUlQdmOiULAfm5mYngk5eTr1CTq-jZB3w>
    <xmx:qgejXpSioFEa9WjTEIdXBV3FD6C09EiAQ79FBBNgQlyYQmDouJhuqA>
    <xmx:qgejXoA65VpA33Rg1XLvlFxRPaGnd39C1w8VnSX6Q-fQWkhZFu1OXA>
    <xmx:qgejXpLzQ35NbXvkoRWqkqu3Hy84VAerf56va_oNJ_9j6JhvssddbKLDmc8>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id CCFD23280063;
        Fri, 24 Apr 2020 11:37:13 -0400 (EDT)
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
Subject: [PATCH v2 80/91] drm/vc4: hdmi: Move CEC init to its own function
Date:   Fri, 24 Apr 2020 17:35:01 +0200
Message-Id: <8485077451e339cbb491746ae98980f76eedc754.1587742492.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <cover.d1e741d37e43e1ba2d2ecd93fc81d42a6df99d14.1587742492.git-series.maxime@cerno.tech>
References: <cover.d1e741d37e43e1ba2d2ecd93fc81d42a6df99d14.1587742492.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CEC init code was put directly into the bind function, which was quite
inconsistent with how the audio support was done, and would prevent us from
further changes to skip that initialisation entirely.

Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_hdmi.c | 108 +++++++++++++++++++++-------------
 1 file changed, 67 insertions(+), 41 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index aae5b10a2d11..1c612db1d22c 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -1172,6 +1172,67 @@ static const struct cec_adap_ops vc4_hdmi_cec_adap_ops = {
 	.adap_log_addr = vc4_hdmi_cec_adap_log_addr,
 	.adap_transmit = vc4_hdmi_cec_adap_transmit,
 };
+
+static int vc4_hdmi_cec_init(struct vc4_hdmi *vc4_hdmi)
+{
+	struct cec_connector_info conn_info;
+	struct platform_device *pdev = vc4_hdmi->pdev;
+	u32 value;
+	int ret;
+
+	vc4_hdmi->cec_adap = cec_allocate_adapter(&vc4_hdmi_cec_adap_ops,
+						  vc4_hdmi, "vc4",
+						  CEC_CAP_DEFAULTS |
+						  CEC_CAP_CONNECTOR_INFO, 1);
+	ret = PTR_ERR_OR_ZERO(vc4_hdmi->cec_adap);
+	if (ret < 0)
+		return ret;
+
+	cec_fill_conn_info_from_drm(&conn_info, &vc4_hdmi->connector);
+	cec_s_conn_info(vc4_hdmi->cec_adap, &conn_info);
+
+	HDMI_WRITE(HDMI_CEC_CPU_MASK_SET, 0xffffffff);
+	value = HDMI_READ(HDMI_CEC_CNTRL_1);
+	value &= ~VC4_HDMI_CEC_DIV_CLK_CNT_MASK;
+	/*
+	 * Set the logical address to Unregistered and set the clock
+	 * divider: the hsm_clock rate and this divider setting will
+	 * give a 40 kHz CEC clock.
+	 */
+	value |= VC4_HDMI_CEC_ADDR_MASK |
+		 (4091 << VC4_HDMI_CEC_DIV_CLK_CNT_SHIFT);
+	HDMI_WRITE(HDMI_CEC_CNTRL_1, value);
+	ret = devm_request_threaded_irq(&pdev->dev, platform_get_irq(pdev, 0),
+					vc4_cec_irq_handler,
+					vc4_cec_irq_handler_thread, 0,
+					"vc4 hdmi cec", vc4_hdmi);
+	if (ret)
+		goto err_delete_cec_adap;
+
+	ret = cec_register_adapter(vc4_hdmi->cec_adap, &pdev->dev);
+	if (ret < 0)
+		goto err_delete_cec_adap;
+
+	return 0;
+
+err_delete_cec_adap:
+	cec_delete_adapter(vc4_hdmi->cec_adap);
+
+	return ret;
+}
+
+static void vc4_hdmi_cec_exit(struct vc4_hdmi *vc4_hdmi)
+{
+	cec_unregister_adapter(vc4_hdmi->cec_adap);
+}
+#else
+static int vc4_hdmi_cec_init(struct vc4_hdmi *vc4_hdmi)
+{
+	return 0;
+}
+
+static void vc4_hdmi_cec_exit(struct vc4_hdmi *vc4_hdmi) {};
+
 #endif
 
 static int vc4_hdmi_build_regset(struct vc4_hdmi *vc4_hdmi,
@@ -1249,9 +1310,6 @@ static int vc4_hdmi_init_resources(struct vc4_hdmi *vc4_hdmi)
 
 static int vc4_hdmi_bind(struct device *dev, struct device *master, void *data)
 {
-#ifdef CONFIG_DRM_VC4_HDMI_CEC
-	struct cec_connector_info conn_info;
-#endif
 	struct platform_device *pdev = to_platform_device(dev);
 	struct drm_device *drm = dev_get_drvdata(master);
 	const struct vc4_hdmi_variant *variant;
@@ -1339,43 +1397,13 @@ static int vc4_hdmi_bind(struct device *dev, struct device *master, void *data)
 	if (ret)
 		goto err_destroy_encoder;
 
-#ifdef CONFIG_DRM_VC4_HDMI_CEC
-	vc4_hdmi->cec_adap = cec_allocate_adapter(&vc4_hdmi_cec_adap_ops,
-						  vc4_hdmi, "vc4",
-						  CEC_CAP_DEFAULTS |
-						  CEC_CAP_CONNECTOR_INFO, 1);
-	ret = PTR_ERR_OR_ZERO(vc4_hdmi->cec_adap);
-	if (ret < 0)
-		goto err_destroy_conn;
-
-	cec_fill_conn_info_from_drm(&conn_info, &vc4_hdmi->connector);
-	cec_s_conn_info(vc4_hdmi->cec_adap, &conn_info);
-
-	HDMI_WRITE(HDMI_CEC_CPU_MASK_SET, 0xffffffff);
-	value = HDMI_READ(HDMI_CEC_CNTRL_1);
-	value &= ~VC4_HDMI_CEC_DIV_CLK_CNT_MASK;
-	/*
-	 * Set the logical address to Unregistered and set the clock
-	 * divider: the hsm_clock rate and this divider setting will
-	 * give a 40 kHz CEC clock.
-	 */
-	value |= VC4_HDMI_CEC_ADDR_MASK |
-		 (4091 << VC4_HDMI_CEC_DIV_CLK_CNT_SHIFT);
-	HDMI_WRITE(HDMI_CEC_CNTRL_1, value);
-	ret = devm_request_threaded_irq(dev, platform_get_irq(pdev, 0),
-					vc4_cec_irq_handler,
-					vc4_cec_irq_handler_thread, 0,
-					"vc4 hdmi cec", vc4_hdmi);
+	ret = vc4_hdmi_cec_init(vc4_hdmi);
 	if (ret)
-		goto err_delete_cec_adap;
-	ret = cec_register_adapter(vc4_hdmi->cec_adap, dev);
-	if (ret < 0)
-		goto err_delete_cec_adap;
-#endif
+		goto err_destroy_conn;
 
 	ret = vc4_hdmi_audio_init(vc4_hdmi);
 	if (ret)
-		goto err_destroy_encoder;
+		goto err_free_cec;
 
 	vc4_debugfs_add_file(drm, variant->debugfs_name,
 			     vc4_hdmi_debugfs_regs,
@@ -1383,12 +1411,10 @@ static int vc4_hdmi_bind(struct device *dev, struct device *master, void *data)
 
 	return 0;
 
-#ifdef CONFIG_DRM_VC4_HDMI_CEC
-err_delete_cec_adap:
-	cec_delete_adapter(vc4_hdmi->cec_adap);
+err_free_cec:
+	vc4_hdmi_cec_exit(vc4_hdmi);
 err_destroy_conn:
 	vc4_hdmi_connector_destroy(&vc4_hdmi->connector);
-#endif
 err_destroy_encoder:
 	vc4_hdmi_encoder_destroy(encoder);
 err_unprepare_hsm:
@@ -1413,7 +1439,7 @@ static void vc4_hdmi_unbind(struct device *dev, struct device *master,
 	kfree(vc4_hdmi->hdmi_regset.regs);
 	kfree(vc4_hdmi->hd_regset.regs);
 
-	cec_unregister_adapter(vc4_hdmi->cec_adap);
+	vc4_hdmi_cec_exit(vc4_hdmi);
 	vc4_hdmi_connector_destroy(&vc4_hdmi->connector);
 	vc4_hdmi_encoder_destroy(&vc4_hdmi->encoder.base.base);
 
-- 
git-series 0.9.1
