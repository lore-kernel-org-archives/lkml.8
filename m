Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76A6CC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:45:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 543E020776
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:45:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="ttA60JMA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iPohzrkJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389827AbgE0Ppk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 11:45:40 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:53775 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730428AbgE0Ppc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 11:45:32 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 81BE05C0220;
        Wed, 27 May 2020 11:45:31 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 27 May 2020 11:45:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=boMgmra7WOWY+
        GlhAM0YnfrTd/Pn6DIw794uUlk43Ho=; b=ttA60JMA/fKXcDYfIddBdTXP31g3u
        ku0HVrrXHgHsp+BZ76zihniJctwItF+ucgnsFBdFyaJC+sydFqaQACjdOYrUW40E
        +JnQr7xN6vWV1e4I91TNsOK4NZRBK/VRWbdpHtq33jjlf3rGF36/4g5w5Z/VEA8Y
        jAxRh1ANk9WO1DwBjDfAB2hkj0ig6LsJOFvBn8udqre+Wdmh3fg+wch+xxG+6hRC
        8T5tW9jIfITAnKFBewIfnDOsyS44DbMemZajrX46shFcmy71Ykt4XKHLeHvQnFtz
        ClDmB8lsuOBsNJSOrI1vbPyK5ZMHGWu2kWFVkLKbjl+8JQ/kayFZq5Rng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=boMgmra7WOWY+GlhAM0YnfrTd/Pn6DIw794uUlk43Ho=; b=iPohzrkJ
        1sqFyhCxxissmlQAAbXK8ZofMHS4lKWW6gvRXdMaFMAuyOhIRfAVHg1CzF7GwUAC
        SvHirGCgNu3rKn/SrV7ztoTketH0SlNaxPrkNGaTjj9LlzwG/yywHig9WMlFbcCb
        uOxM7m0e4l1ZwHa4q2l9JAI0g/x7KsU8U7DI2OZ3xM6++8OZCeyVM9VO6Py4DQqL
        HNr+9iHHVj1nmGL3jjuS9Vsrf1QFbCLsfLfOg5k9F/987zhQtrLI7SDSS+EIabw2
        6jkm410tmot72DWCvAZXxAst/mVLEDyZFOcF7ffLL6h4DIW9WcoqexsUIvle1+vy
        7n/sr3AjoB6+AQ==
X-ME-Sender: <xms:G4vOXv36PFRg8Htj3NDqGLhiaa2YeOC-LOSdpG1X20zdjRbyREJj3A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedruddvgedgkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:G4vOXuFHqLaWFk2lKB6yzLqpEiUuSsxFYvSmST0UFli_fk9ElxI2Ug>
    <xmx:G4vOXv4YB0-FWrPGY0TfMmHhxiUQRYLz1q9uKCj85quPAQ0pyOdwcw>
    <xmx:G4vOXk1EhZkUVi39yPRKGPAjlHyZJuvw8aSpSPp9Yhbo201AtGObvg>
    <xmx:G4vOXvMTcGwTIn3UvA5lkRVP6-CPzL2ZXFxoqhnFQnPUAnVcSLdzyg>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 367E130618B7;
        Wed, 27 May 2020 11:45:31 -0400 (EDT)
From:   Maxime Ripard <maxime@cerno.tech>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>,
        Maxime Ripard <maxime@cerno.tech>
Subject: [PATCH v3 03/25] firmware: rpi: Only create clocks device if we don't have a node for it
Date:   Wed, 27 May 2020 17:44:59 +0200
Message-Id: <f0b979221dedec7db9cab201388bf44c0d987a3d.1590594293.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.662a8d401787ef33780d91252a352de91dc4be10.1590594293.git-series.maxime@cerno.tech>
References: <cover.662a8d401787ef33780d91252a352de91dc4be10.1590594293.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The firmware clocks driver was previously probed through a platform_device
created by the firmware driver.

Since we will now have a node for that clocks driver, we need to create the
device only in the case where there's no node for it already.

Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/firmware/raspberrypi.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/firmware/raspberrypi.c b/drivers/firmware/raspberrypi.c
index ef8098856a47..b25901a77c09 100644
--- a/drivers/firmware/raspberrypi.c
+++ b/drivers/firmware/raspberrypi.c
@@ -208,6 +208,20 @@ rpi_register_hwmon_driver(struct device *dev, struct rpi_firmware *fw)
 
 static void rpi_register_clk_driver(struct device *dev)
 {
+	struct device_node *firmware;
+
+	/*
+	 * Earlier DTs don't have a node for the firmware clocks but
+	 * rely on us creating a platform device by hand. If we do
+	 * have a node for the firmware clocks, just bail out here.
+	 */
+	firmware = of_get_compatible_child(dev->of_node,
+					   "raspberrypi,firmware-clocks");
+	if (firmware) {
+		of_node_put(firmware);
+		return;
+	}
+
 	rpi_clk = platform_device_register_data(dev, "raspberrypi-clk",
 						-1, NULL, 0);
 }
-- 
git-series 0.9.1
