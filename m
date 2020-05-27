Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CACF4C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:54:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92B4920776
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:54:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="Vi5DDjJg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mZBiVJkt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390599AbgE0Pyi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 11:54:38 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:46269 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730605AbgE0Pvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 11:51:33 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id EAD3658150C;
        Wed, 27 May 2020 11:51:32 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 27 May 2020 11:51:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=cEGqeWIoGZHcW
        UZtLdrVVNYHXqJvib1Zg3nABEqU4iM=; b=Vi5DDjJgv1qaBfsY+BiJMyx74BCAN
        dvcPLPOe4ToONNZWjBwK+l6y7iGAcOOtSsEkdBpTr74BjegA/q0D6C4KoXStB/Zi
        kZOS7Z4/x+dEF5uJZm7kuntvchDUy0qB8VMB5DcbXSnWzzHELIrSHdt6Eh6Cq1Ww
        wo5C8Sgf32Qar61gyg1q6JwCfoYaWnxlJlT3wqyoCVQ4ojvJuRL8ajy333rCuAo0
        kucnC6WKjWk1QIKnRfrYVPGCiuXKFFkp0z9ZeJLJkpgtlp+QC5jK6OI37wlktmiZ
        gcvhZkOuCfWzLfwIzL74CizrJ44z1kAO0PLjAj2M+eTCxbZMiQo9NtRig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=cEGqeWIoGZHcWUZtLdrVVNYHXqJvib1Zg3nABEqU4iM=; b=mZBiVJkt
        1v7+FbT30XVPijEsAgxWL7xFNNdqwIJlRoHF7XBiAGEPhvqQnakceoUQyM9N/0+7
        8PkA+0uU3GITMuj7MdpCpWYNGIR5OOyAqdk59aAJj8E77fdh9ffSUaPz/LnLQX2s
        lQmhof278HU2JbffhdNn6MWSBTWEDLmlgPtvSZT9f7LgtUS3Q645a4gXs7AejewO
        JFqI/vY3yDeJRuYJaBH1jz+VbuGD4sq8jdkusfDKwvxjFl8qtpPLR7ZMB6OY8yZp
        llSo86OjekEngCNZk6vx4WLg1fQ+CqhEuGDw5vf43iGEmNJt8K2rEZpqBqN3pNFf
        kcXLgnyiJ6Agsg==
X-ME-Sender: <xms:hIzOXrkNt8c1PTs2Xyc4ao3ocp3GqX-7JWxNi-lDPd9dLll3TpmNdw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedruddvgedgkeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepieefne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:hIzOXu0px9uXgWoVMoxuZQOK0sQusj7mk8yWXiXmZRug_HYQ8GAWPA>
    <xmx:hIzOXhogVKdLBMwL_UTZzf3WbzJJugaer_FH6CUDzNVSVS3neDUBbg>
    <xmx:hIzOXjlzhDyTIB_Vqq6TfWYKOWluapRBDXc2iWW8JVDil8xUHbZVBA>
    <xmx:hIzOXmkJsy1HGb6buNM89AwVnOcd6xjf7bRsy0rS1Yw75ZlJ24rF6Q>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 8EB093280066;
        Wed, 27 May 2020 11:51:32 -0400 (EDT)
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
Subject: [PATCH v3 086/105] drm/vc4: hdmi: Deal with multiple debugfs files
Date:   Wed, 27 May 2020 17:48:56 +0200
Message-Id: <b9d56c9fae4697ae1aadd6d89a74f3359d5a9355.1590594512.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.aaf2100bd7da4609f8bcb8216247d4b4e4379639.1590594512.git-series.maxime@cerno.tech>
References: <cover.aaf2100bd7da4609f8bcb8216247d4b4e4379639.1590594512.git-series.maxime@cerno.tech>
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

Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_hdmi.c | 5 ++++-
 drivers/gpu/drm/vc4/vc4_hdmi.h | 3 +++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index 7542447eb314..8a63ac3dd86b 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -1366,7 +1366,9 @@ static int vc4_hdmi_bind(struct device *dev, struct device *master, void *data)
 	if (ret)
 		goto err_destroy_encoder;
 
-	vc4_debugfs_add_file(drm, "hdmi_regs", vc4_hdmi_debugfs_regs, vc4_hdmi);
+	vc4_debugfs_add_file(drm, variant->debugfs_name,
+			     vc4_hdmi_debugfs_regs,
+			     vc4_hdmi);
 
 	return 0;
 
@@ -1428,6 +1430,7 @@ static int vc4_hdmi_dev_remove(struct platform_device *pdev)
 
 static const struct vc4_hdmi_variant bcm2835_variant = {
 	.encoder_type		= VC4_ENCODER_TYPE_HDMI0,
+	.debugfs_name		= "hdmi_regs",
 	.registers		= vc4_hdmi_fields,
 	.num_registers		= ARRAY_SIZE(vc4_hdmi_fields),
 
diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.h b/drivers/gpu/drm/vc4/vc4_hdmi.h
index 4240c5ea7fde..22100820c81b 100644
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
