Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3E5BC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:56:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D2BE20776
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:56:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="LnDfksf5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="l1ON8em1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730851AbgE0P4t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 11:56:49 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:57355 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390174AbgE0Ptw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 11:49:52 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 4EC79582037;
        Wed, 27 May 2020 11:49:51 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 27 May 2020 11:49:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=JNjtzlAqDA9+g
        wfnpcyHMYWUnTOc/3kzSZCf4w6U+OU=; b=LnDfksf5nWrkGfQXWCTE/DliYINM6
        eVueHAn0nHZiyNNw905TcjPS4YAXXLL2OooMnwymQ8Ik/tfBpBvlTgQPk2zlVMOF
        6jA1/xzpq2s9Q1Hm/nVtqzLBPuFlzhMLtkgLISDZtqXKke5QWIniM9+nk1fCDShh
        LHzMBxSNZWl2qFgu9riWNENn9BqnqohzmLxGdSBZBBfIQ6wA37E99iyFIEWdwEYE
        Hpdgly+BmhFMIK980Dv1o4eZiQ+JLvTBzb5QKCrymyd+OoaxVT0IvRdvCro3CWL7
        N0yD7l0VwHYZA4non6q8R5TDCPPtaXGkTuNbgtU5jUBKUYesCTQun1b+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=JNjtzlAqDA9+gwfnpcyHMYWUnTOc/3kzSZCf4w6U+OU=; b=l1ON8em1
        pY46XNPMqzTkH1x/xq4P9QZ/pcHY89YOkwCk8hEFkVdk7B6CEZF1B6My4uIvdhwR
        R+r4B/awzs4owzwO78lRrEj+kHVOLKNuvG6Z2B6YB6dpJb88Wm5uQHws3Tk+p6N9
        9LXPS1XEmCYykkaJhfO//npVVnhrk6v63m5qcC+DPmGUsQ+zankhYNpPegnhdg9X
        DsyI6Grgc35oTvogPG0IcufcBEqJrYNqqt4L4H+NfnG2AWnK4D3FR5nNfe8ABAUh
        c3kAWtDNhRbxYZAJx/TuD/7X6mVbzhQJujx59qRGWqS2qikcjcvPcRRN5vRN/WQa
        RmSBdtqpfabOcw==
X-ME-Sender: <xms:H4zOXku904LgSvczNi5yrs7XhlPeDOKQJW4xBb56uPQDlQHvP2qTqQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedruddvgedgkeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepfeenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:H4zOXhcXU8OSN2Z4zOy-tEdKKt5NicrYvnzc_ezarqJrTHN49TSHHQ>
    <xmx:H4zOXvzWswPhtlu0iwUICFPVl9QxJMiZZtVXUFIjzKzXJl6N-KlRLQ>
    <xmx:H4zOXnNd7CM6nrAQh66PKwbf2C0xAbvH5YEq-eBLKJa0PHx1p7i2aQ>
    <xmx:H4zOXhOVHEf7W8Sy5SsPEtdlNbb2njiO2lpdRZ3mNVl9ZEB3FjlQLQ>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id E2F2F328005E;
        Wed, 27 May 2020 11:49:50 -0400 (EDT)
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
Subject: [PATCH v3 022/105] drm/vc4: crtc: Rename SoC data structures
Date:   Wed, 27 May 2020 17:47:52 +0200
Message-Id: <39aed7dd512ce2a4560902974ec26b16b88ec68b.1590594512.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.aaf2100bd7da4609f8bcb8216247d4b4e4379639.1590594512.git-series.maxime@cerno.tech>
References: <cover.aaf2100bd7da4609f8bcb8216247d4b4e4379639.1590594512.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we're going to introduce pixelvalve data structures for other SoCs
than the BCM2835, let's rename the structures defined in the code to
make it obvious which SoC we're targeting.

Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_crtc.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_crtc.c b/drivers/gpu/drm/vc4/vc4_crtc.c
index 2131164779dd..9fdb0ccc4a28 100644
--- a/drivers/gpu/drm/vc4/vc4_crtc.c
+++ b/drivers/gpu/drm/vc4/vc4_crtc.c
@@ -1058,7 +1058,7 @@ static const struct drm_crtc_helper_funcs vc4_crtc_helper_funcs = {
 	.get_scanout_position = vc4_crtc_get_scanout_position,
 };
 
-static const struct vc4_crtc_data pv0_data = {
+static const struct vc4_crtc_data bcm2835_pv0_data = {
 	.hvs_channel = 0,
 	.debugfs_name = "crtc0_regs",
 	.encoder_types = {
@@ -1067,7 +1067,7 @@ static const struct vc4_crtc_data pv0_data = {
 	},
 };
 
-static const struct vc4_crtc_data pv1_data = {
+static const struct vc4_crtc_data bcm2835_pv1_data = {
 	.hvs_channel = 2,
 	.debugfs_name = "crtc1_regs",
 	.encoder_types = {
@@ -1076,7 +1076,7 @@ static const struct vc4_crtc_data pv1_data = {
 	},
 };
 
-static const struct vc4_crtc_data pv2_data = {
+static const struct vc4_crtc_data bcm2835_pv2_data = {
 	.hvs_channel = 1,
 	.debugfs_name = "crtc2_regs",
 	.encoder_types = {
@@ -1086,9 +1086,9 @@ static const struct vc4_crtc_data pv2_data = {
 };
 
 static const struct of_device_id vc4_crtc_dt_match[] = {
-	{ .compatible = "brcm,bcm2835-pixelvalve0", .data = &pv0_data },
-	{ .compatible = "brcm,bcm2835-pixelvalve1", .data = &pv1_data },
-	{ .compatible = "brcm,bcm2835-pixelvalve2", .data = &pv2_data },
+	{ .compatible = "brcm,bcm2835-pixelvalve0", .data = &bcm2835_pv0_data },
+	{ .compatible = "brcm,bcm2835-pixelvalve1", .data = &bcm2835_pv1_data },
+	{ .compatible = "brcm,bcm2835-pixelvalve2", .data = &bcm2835_pv2_data },
 	{}
 };
 
-- 
git-series 0.9.1
