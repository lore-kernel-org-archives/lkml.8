Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A409C433E7
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 08:07:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D9A7208B3
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 08:07:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="aSZDAT6I";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Wg4thRAp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728768AbgICIH3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 04:07:29 -0400
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:41843 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728479AbgICIDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 04:03:17 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 66119C02;
        Thu,  3 Sep 2020 04:03:16 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 03 Sep 2020 04:03:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=nDtwCT/GEboFZ
        6h2FalfKwFluMDJ6O4H2K3IGSnhOgU=; b=aSZDAT6IIt7QAKKa0fxFrWzYUyVxP
        RlF6FVPu7j7kuJVO0jYhI5UoqtUngHrP853CCqgjBvXTwMKnACN8qYUTcRefbiIB
        3seXWGvU7CAVyZaKBl2pK9HAW6YgMydhju8f7U0kU4jctfGHRWqdiMT/x3Xuntq4
        NEV6xmqX8cvG2424ECzzsP4ovIdZW5bhym5G78Sy4S23n+olAtrribyWr1oB7T6R
        xcfuDobP0OWk3R4Es50e3uMuPZoS2rwR79egm5PjOqNlX92iOCyYWwjx5Ep3md+G
        lC5fiFcJVK11kW4837wYSpzZwcPXinHwZRwRsPZsvgUixfmVgeUYcDPZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=nDtwCT/GEboFZ6h2FalfKwFluMDJ6O4H2K3IGSnhOgU=; b=Wg4thRAp
        wWoeQ0tYAbvzXY7j6OkSI6PrrkwcDBNFsZlcu6lg00soOM0vfX7zw27/FuHj/5z/
        e6wp1ctGGnkCA++f4r4Tj3mGmizlUbreWMrfSCkTdXXDYcQl7cSTk4vTM1H1zt6r
        nWWE0orYiaCAGKoxl9BwkQLRgIPlYYxSEQHtOciZh9VDrtf6L0caCPdFSrNYEaGS
        On8lJvyc37JvnpBhfYXr2imAnsYfpVUa115F8cDXBlrlfXFJAa3xn7hcsrKkmCU9
        IubY9QQ4OTRk6OVIMvhKTfPhv+UDgRL7eKEswsx54Lcr8+e9M2IQyzT68Qpt2vDP
        1Ng5Hw39TX5JIA==
X-ME-Sender: <xms:Q6NQXxXrObUoGXq7WF4R0TG5nWk81IbusJz4raYQcUzM8wA6F1Q5zA>
    <xme:Q6NQXxkSMGixEvqTiVIjoqploIs0M-_XJvHZ4nwlTvxhu1NhRf0eSgAOZfhSxf74l
    CPltfzFoD9vApW7Yiw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudegtddguddviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpedvkeelveefffekjefhffeuleetleefudeifeehuddugffghffhffehveev
    heehvdenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpeehge
    enucfrrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:Q6NQX9aCJuHC8hn8qKQkwlZclnU0R5bZVUfj9J5hEnTnmdx6QkOpSA>
    <xmx:Q6NQX0VlHe0CGLTgCGI7jcIDyY7Yti9-XDnEHwDobvZrMFkulcBb5A>
    <xmx:Q6NQX7ngX8y9n0m4XSA8cW9F2HGX3jYd963WeW4J-5q4gOrw1uQ0Bw>
    <xmx:RKNQX5cHEIEUKuBC_HQxY01eKBz0zS2nXam6HFYJV460s5LENdhEZSrUDaY>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id A6428328005A;
        Thu,  3 Sep 2020 04:03:15 -0400 (EDT)
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
Subject: [PATCH v5 58/80] drm/vc4: hdmi: Deal with multiple debugfs files
Date:   Thu,  3 Sep 2020 10:01:30 +0200
Message-Id: <9505c1eb40b3ef3709277bf9e8af77917b249c32.1599120059.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.dddc064d8bb83e46744336af67dcb13139e5747d.1599120059.git-series.maxime@cerno.tech>
References: <cover.dddc064d8bb83e46744336af67dcb13139e5747d.1599120059.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The HDMI driver was registering a single debugfs file so far with the name
hdmi_regs.

Obviously, this is not going to work anymore when will have multiple HDMI
controllers since we will end up trying to register two files with the same
name.

Let's use the variant to avoid that name conflict.

Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Tested-by: Chanwoo Choi <cw00.choi@samsung.com>
Tested-by: Hoegeun Kwon <hoegeun.kwon@samsung.com>
Tested-by: Stefan Wahren <stefan.wahren@i2se.com>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_hdmi.c | 5 ++++-
 drivers/gpu/drm/vc4/vc4_hdmi.h | 3 +++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index f6d18bdbd1bb..4d0b44a2ac61 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -1369,7 +1369,9 @@ static int vc4_hdmi_bind(struct device *dev, struct device *master, void *data)
 	if (ret)
 		goto err_destroy_encoder;
 
-	vc4_debugfs_add_file(drm, "hdmi_regs", vc4_hdmi_debugfs_regs, vc4_hdmi);
+	vc4_debugfs_add_file(drm, variant->debugfs_name,
+			     vc4_hdmi_debugfs_regs,
+			     vc4_hdmi);
 
 	return 0;
 
@@ -1447,6 +1449,7 @@ static int vc4_hdmi_dev_remove(struct platform_device *pdev)
 
 static const struct vc4_hdmi_variant bcm2835_variant = {
 	.encoder_type		= VC4_ENCODER_TYPE_HDMI0,
+	.debugfs_name		= "hdmi_regs",
 	.registers		= vc4_hdmi_fields,
 	.num_registers		= ARRAY_SIZE(vc4_hdmi_fields),
 
diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.h b/drivers/gpu/drm/vc4/vc4_hdmi.h
index 0d529db4b3ab..794216f3228d 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.h
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.h
@@ -30,6 +30,9 @@ struct vc4_hdmi_variant {
 	/* Encoder Type for that controller */
 	enum vc4_encoder_type encoder_type;
 
+	/* Filename to expose the registers in debugfs */
+	const char *debugfs_name;
+
 	/* List of the registers available on that variant */
 	const struct vc4_hdmi_register *registers;
 
-- 
git-series 0.9.1
