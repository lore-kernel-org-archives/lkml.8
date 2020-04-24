Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E050FC55186
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 15:37:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C105A21473
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 15:37:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="Mop+5LrD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aBD28wAx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728855AbgDXPhW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 11:37:22 -0400
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:44049 "EHLO
        wnew2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728799AbgDXPhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 11:37:13 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id C3E441449;
        Fri, 24 Apr 2020 11:37:11 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 24 Apr 2020 11:37:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=6SaaEI3QM+61n
        2vOknfdtmtFx1seHZfhMU+DJZTniks=; b=Mop+5LrD3zHeX/QJFwX7Dreo7JRUj
        cJHhAFF8DK7FVOpDjW7K0c4IMnmN5iaiFMwmaINDsCEAS9N6ZvXdytCZcMeCyWDD
        ePYF+WLhk9BKKBpSGf92srkDWNSCpr6qp6zCsX2TxacpVK2ca8xX29BR0wUlvVOS
        i2iuqzXXtd/b6Gl6bs6S2FY3UPCWpMxwDbZIdLuCiQpQ8OkCwLYitUkXAe8umsLS
        StcM3GG059xm9iSNjGJZhz/XpxmGLAILnHkDf05mvsZ34vzqimV786/3Vhk4UZwz
        nJMKPjTs18xe9wBRVaRwug5krE+kZHicwGnolm5XD3QQHgJ8W9kplI+0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=6SaaEI3QM+61n2vOknfdtmtFx1seHZfhMU+DJZTniks=; b=aBD28wAx
        Q2+4LRPoQvWJ5hmp1d8ORRDQev4du4QfsTvywEotCkiEur3BAhiynWrwLQzCojcI
        yzJ8OCsEpLC7y07V0HWcYpxrS9sq+lBpBvwqXkfvyWEH6VLSD0I7ONWrF+If6qKL
        4uHbdhtSa5c5z/D+mXTY/lVHQcxf6WyCHrkAlRos0JvVA9hC7K+UvMbbmZCaQ/qn
        SFjnYdOz8BErri/VxSPUw4hnYHZWk2IvLhl776kG7HFnYNiWRhHne50pDOCsQk7O
        wj5eoE6UHXQntsXYN4J/0hg5OZ8xdk/jEot3YK1UPtTv/Br8F5M0HsXTstg6xMHt
        CsCCANW4bKd9CA==
X-ME-Sender: <xms:pwejXjv8xfIE9kJhcjzXtmTG2pUdhbYnAgjzvLyJMFz7H536VYnx2A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrhedugdekiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucfkphepledtrd
    ekledrieekrdejieenucevlhhushhtvghrufhiiigvpeejtdenucfrrghrrghmpehmrghi
    lhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:pwejXhLCL78ZhCP8T_YfrQzHLTzB6kfeCI5dfhpU_WJElwTCrw8Axg>
    <xmx:pwejXv0itTBRCsQk-N_siR78Tz76T0n_TxTbyBs4TLV6IiZ-9NUqmA>
    <xmx:pwejXnNhA4TxPyVKWOvUqUEwCT9Pno2QCu-wxyJEf6ERF0WRnEeBsQ>
    <xmx:pwejXs4euoG1I-dATu3pJn7oOEGhO4R2INVCNtSuGWOQerhjOrsH-yx7LMg>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 100823280063;
        Fri, 24 Apr 2020 11:37:10 -0400 (EDT)
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
Subject: [PATCH v2 78/91] drm/vc4: hdmi: Store the encoder type in the variant structure
Date:   Fri, 24 Apr 2020 17:34:59 +0200
Message-Id: <104c57b01e4fc67640d0236b38663417e07178ab.1587742492.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <cover.d1e741d37e43e1ba2d2ecd93fc81d42a6df99d14.1587742492.git-series.maxime@cerno.tech>
References: <cover.d1e741d37e43e1ba2d2ecd93fc81d42a6df99d14.1587742492.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The vc4 CRTC will use the encoder type to control its output clock
muxing. However, this will be different from HDMI0 to HDMI1, so let's
store our type in the variant structure so that we can support multiple
controllers later on.

Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_hdmi.c | 4 ++--
 drivers/gpu/drm/vc4/vc4_hdmi.h | 3 +++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index b3a98a17f8f8..aaf96420d0ec 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -1264,11 +1264,10 @@ static int vc4_hdmi_bind(struct device *dev, struct device *master, void *data)
 	vc4_hdmi = devm_kzalloc(dev, sizeof(*vc4_hdmi), GFP_KERNEL);
 	if (!vc4_hdmi)
 		return -ENOMEM;
-
 	vc4_hdmi->pdev = pdev;
 	variant = of_device_get_match_data(dev);
 	vc4_hdmi->variant = variant;
-	vc4_hdmi->encoder.base.type = VC4_ENCODER_TYPE_HDMI0;
+	vc4_hdmi->encoder.base.type = variant->encoder_type;
 	encoder = &vc4_hdmi->encoder.base.base;
 
 	ret = variant->init_resources(vc4_hdmi);
@@ -1439,6 +1438,7 @@ static int vc4_hdmi_dev_remove(struct platform_device *pdev)
 }
 
 static const struct vc4_hdmi_variant bcm2835_variant = {
+	.encoder_type		= VC4_ENCODER_TYPE_HDMI0,
 	.registers		= vc4_hdmi_fields,
 	.num_registers		= ARRAY_SIZE(vc4_hdmi_fields),
 
diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.h b/drivers/gpu/drm/vc4/vc4_hdmi.h
index 4a67d62aef53..4240c5ea7fde 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.h
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.h
@@ -27,6 +27,9 @@ struct vc4_hdmi;
 struct vc4_hdmi_register;
 
 struct vc4_hdmi_variant {
+	/* Encoder Type for that controller */
+	enum vc4_encoder_type encoder_type;
+
 	/* List of the registers available on that variant */
 	const struct vc4_hdmi_register *registers;
 
-- 
git-series 0.9.1
