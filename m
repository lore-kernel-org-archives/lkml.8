Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0549AC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:46:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0D8920776
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:46:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="tf3AqUsB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lGQUFNi8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389983AbgE0PqO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 11:46:14 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:44813 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389940AbgE0PqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 11:46:04 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id D45325C022C;
        Wed, 27 May 2020 11:46:02 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 27 May 2020 11:46:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=/IdQH2nH4CK+s
        IwdlyXU/9/PW3BDGx+K5YD8cFcWaxE=; b=tf3AqUsBCcSCyGJrQktLAndFms8wG
        uQm1n4OuyniBECD0B8iV7Yq9Q317Sev2eQNP275a2k6UNs0bv4VdZUqL72YzRaW3
        +uTo9kTTpU9KVeJ8GK4Mj5tGYx6//mHwwCge5u3Yzcgt14lSqqr4NPpvGloSckA0
        pocQ2bUraZYDddhdgQ4L3AYg/cCYtMM3wf83YIgcMAvzdaSLvGDuAkIvdnBZeKuW
        KCHxDiCMjAsvQP6C9i4cbDzZECOk9eJOXloUkhQHTChzCm/obMb0WLHmES6a8muX
        yLBHzCgfr+uLyjqgvIXSU4rl8AAZeI6lWD6FQRfxCaStQejrLfm9K5ZHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=/IdQH2nH4CK+sIwdlyXU/9/PW3BDGx+K5YD8cFcWaxE=; b=lGQUFNi8
        EqCqChsw60m+aOiBoYzILwmwiMDmdn1QrW0b8JEZtUvsoCRPRvMW28ZJflOSN5qA
        MY3Fo83/N+AyZxGFSOxu4Pb2vwwd81KX5CJpobO3gECvV5D/VRqOXbDdrB8nRzjf
        s205viK5jUy4mZzv4ltmSN7nJlHYBbdgbFQcVv5foWil3gM+jgyyBJIPaa3n/LWW
        8/brLdc8ilW1+9AcFm6TnE87DOjVGGxWivtrxxMdsE5cS6zaPIWjgmGYHrl8Nb3z
        3sa2kzKkNCx4jtuiDpx26JbMPUCCdUOqUnOquUDzh+ZuOfpQMy4WsGsYJrKX9ljF
        8REQGkY/jhUa5g==
X-ME-Sender: <xms:OovOXvdOEMDlN2veEmho4Ng5VxdUceXdq5eccpUD9AfF4q7yuvqa9g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedruddvgedgkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepudekne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:OovOXlOljbOU_ppm1qmIrQbdgtBZWB9DFpZXQPjGmbk-zGq4bw5weA>
    <xmx:OovOXohOvA-4EsUhAfxwWqL5WjrWM98Xh--SNcb5-VU-Zbfxl_wK5A>
    <xmx:OovOXg8M_3tjiFZfhrLPZeDzF9rOxUAykOuaRQW1rB09_DOBLHEZOA>
    <xmx:OovOXhXwfNoOcxc0qRdh_V_0rhKAzIkbNMprNkeYuN8emZ9T97J6Bw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 59AD33061856;
        Wed, 27 May 2020 11:46:02 -0400 (EDT)
From:   Maxime Ripard <maxime@cerno.tech>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>,
        Maxime Ripard <maxime@cerno.tech>
Subject: [PATCH v3 23/25] Revert "clk: bcm2835: remove pllb"
Date:   Wed, 27 May 2020 17:45:19 +0200
Message-Id: <b7bcd08ff1cff914c5b8b2546665a3f9fb9a58a8.1590594293.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.662a8d401787ef33780d91252a352de91dc4be10.1590594293.git-series.maxime@cerno.tech>
References: <cover.662a8d401787ef33780d91252a352de91dc4be10.1590594293.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 2256d89333bd17b8b56b42734a7e1046d52f7fc3. Since we
will be expanding the firmware clock driver, we'll need to remove the
quirks to deal with the PLLB. However, we still want to expose the clock
tree properly, so having that clock in the MMIO driver will allow that.

Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/clk/bcm/clk-bcm2835.c | 30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/bcm/clk-bcm2835.c b/drivers/clk/bcm/clk-bcm2835.c
index ded13ccf768e..587a67a3cbcb 100644
--- a/drivers/clk/bcm/clk-bcm2835.c
+++ b/drivers/clk/bcm/clk-bcm2835.c
@@ -1678,10 +1678,32 @@ static const struct bcm2835_clk_desc clk_desc_array[] = {
 		.fixed_divider = 1,
 		.flags = CLK_SET_RATE_PARENT),
 
-	/*
-	 * PLLB is used for the ARM's clock. Controlled by firmware, see
-	 * clk-raspberrypi.c.
-	 */
+	/* PLLB is used for the ARM's clock. */
+	[BCM2835_PLLB]		= REGISTER_PLL(
+		SOC_ALL,
+		.name = "pllb",
+		.cm_ctrl_reg = CM_PLLB,
+		.a2w_ctrl_reg = A2W_PLLB_CTRL,
+		.frac_reg = A2W_PLLB_FRAC,
+		.ana_reg_base = A2W_PLLB_ANA0,
+		.reference_enable_mask = A2W_XOSC_CTRL_PLLB_ENABLE,
+		.lock_mask = CM_LOCK_FLOCKB,
+
+		.ana = &bcm2835_ana_default,
+
+		.min_rate = 600000000u,
+		.max_rate = 3000000000u,
+		.max_fb_rate = BCM2835_MAX_FB_RATE),
+	[BCM2835_PLLB_ARM]	= REGISTER_PLL_DIV(
+		SOC_ALL,
+		.name = "pllb_arm",
+		.source_pll = "pllb",
+		.cm_reg = CM_PLLB,
+		.a2w_reg = A2W_PLLB_ARM,
+		.load_mask = CM_PLLB_LOADARM,
+		.hold_mask = CM_PLLB_HOLDARM,
+		.fixed_divider = 1,
+		.flags = CLK_SET_RATE_PARENT),
 
 	/*
 	 * PLLC is the core PLL, used to drive the core VPU clock.
-- 
git-series 0.9.1
