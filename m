Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 762F9C11D2A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 09:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C50020658
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 09:10:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="BNwCM3Aq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GFxVExl7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728362AbgBXJKw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 04:10:52 -0500
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:54993 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727681AbgBXJKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 04:10:48 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id 878C160C;
        Mon, 24 Feb 2020 04:10:46 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 24 Feb 2020 04:10:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=Ff3uGUcGXy4TD
        fBH2MRflci1U8oWaQz52lbUwl02l9U=; b=BNwCM3Aq0Y49bTHPqxVM1RsW8FT2o
        kNjo16S3ZDPUXJb7WO7kuXqJsGQyRwsVI0825YZh/MuMFySajdM4FD0ML5N/+nl4
        z39yug1SICr1TemgcPxTIYTSYYxQqXoWVFfsaq1xkQmnT4uiuQMYrUnwojTfPpfc
        AWKWJNjTLtIF1HMEyJ2wc2XtHPOjA55x6EtfO4Z+TwhrlJNkPzdnjqfREdSbNHO9
        HpvKV+1CAZ9jAqlOuMOWRJiZLOEvRduxbCyDT8KJOSN52npmLp9YmL6BZH5VkLFj
        QCC+2tA2Dc3hCw72Al+yfFmLNm2rQkaZ488VCnqjrb+1h41WwHd6iNlGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=Ff3uGUcGXy4TDfBH2MRflci1U8oWaQz52lbUwl02l9U=; b=GFxVExl7
        z7YaPf5tJTDNA7y7Z175WVqCb8HRBUNutDGm5wnIpBY0YOjr2WXlkVNLN1R7/pQq
        8YIM0G94yJcy2O+v8v+hoVIThWSlx10cz5MJOFG2Hma2/bCYTD4CWYGYWjWwxMYf
        EKJAaB5kX42SyLlmhmUJAagFTQ6d91+G4JxOvzWjhpEwKh+tfn4jGh5z9vm4SOno
        V5IwKl2RhyLHQ9SVYaAP6xhwYdBcq72Qc+zEvf4JHylyHrNP18FxwpF2sLZnY6rC
        I78n8yp3o02GnqCTKE2wJybyKqmfAA8UyBLvEd+yMOjs/+Lb3ZlDL59UFMYcLGxn
        WMpxAAQWnSO/0A==
X-ME-Sender: <xms:FpNTXn4QbAwAHtXHIrASL_Oz-lZaEgvOsKWAERp568c9eVgyzlnCsg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrledtucetufdoteggodetrfdotffvucfrrh
    hofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhmvgcutfhi
    phgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecukfhppeeltddrkeelrd
    eikedrjeeinecuvehluhhsthgvrhfuihiivgepudeknecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:FpNTXuZVw5rdV8AppwcWYCjSg9UlOqegBkYAhxH4P_TNwaHuF-6Hog>
    <xmx:FpNTXnHFeL1kq7czW0bYo5XrpZVjiJAyTKLIh7_zyDlX-C6N4iNEKw>
    <xmx:FpNTXqKpVHW7g6Aqw8GNXKn1opT5XJJV06AxWttOng5Jgw1sDSCOHA>
    <xmx:FpNTXhi1BGPxNidcbz8MTe1aFRxzR8Bt3BL4lUHwElEeDuqX-Zo1OdgMgnI>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id CAB163060F09;
        Mon, 24 Feb 2020 04:10:45 -0500 (EST)
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
Subject: [PATCH 81/89] drm/vc4: hdmi: Add an audio support flag
Date:   Mon, 24 Feb 2020 10:07:23 +0100
Message-Id: <16464cc202d1867843f68f4c2746d5a1b2facecd.1582533919.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.6c896ace9a5a7840e9cec008b553cbb004ca1f91.1582533919.git-series.maxime@cerno.tech>
References: <cover.6c896ace9a5a7840e9cec008b553cbb004ca1f91.1582533919.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The BCM2711 audio support doesn't work yet, so let's add a boolean to
indicate whether or not it's supported, and only register a sound card if
that boolean is set.

Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_hdmi.c | 4 ++++
 drivers/gpu/drm/vc4/vc4_hdmi.h | 3 +++
 2 files changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index 25fbe2fb72fb..a98661c12c24 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -930,6 +930,9 @@ static int vc4_hdmi_audio_init(struct vc4_hdmi *vc4_hdmi)
 	const __be32 *addr;
 	int ret;
 
+	if (!vc4_hdmi->variant->audio_available)
+		return 0;
+
 	if (!of_find_property(dev->of_node, "dmas", NULL)) {
 		dev_warn(dev,
 			 "'dmas' DT property is missing, no HDMI audio\n");
@@ -1429,6 +1432,7 @@ static int vc4_hdmi_dev_remove(struct platform_device *pdev)
 }
 
 struct vc4_hdmi_variant bcm2835_variant = {
+	.audio_available	= true,
 	.registers		= vc4_hdmi_fields,
 	.num_registers		= ARRAY_SIZE(vc4_hdmi_fields),
 
diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.h b/drivers/gpu/drm/vc4/vc4_hdmi.h
index 4d3117de383a..f41116507156 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.h
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.h
@@ -32,6 +32,9 @@ struct vc4_hdmi_variant {
 	 */
 	unsigned int id;
 
+	/* Set to true when the audio support is available */
+	bool audio_available;
+
 	/* List of the registers available on that variant */
 	const struct vc4_hdmi_register *registers;
 
-- 
git-series 0.9.1
