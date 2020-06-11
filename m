Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDF70C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 07:33:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB88A20812
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 07:33:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="Kv/a90dQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QYNFOOC6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbgFKHdJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 03:33:09 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:60969 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727016AbgFKHc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 03:32:58 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 886045800D1;
        Thu, 11 Jun 2020 03:32:57 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 11 Jun 2020 03:32:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=SGor/vFDB/XZ/
        dnJR0vAHVbMnfcW44zyTkkJk0votSE=; b=Kv/a90dQVAjMjAND1HNKxlnQjZf3V
        Id5mqYU6DzfalJH+dG4tpVDofTsFmPb2EhP67J0fIcMiFAx5MdyWmbHdk0GZTYw8
        LCEfPz0Kr2Bdu9pRQVAjF5/ydCE/Q3Ljf647LMG20go64lDENLPUph2SNm6geVJe
        nLsfr9qnIN0C+qdoIOZNDaYbj2bBch9wi4Nkj6wMupRt+D9OEPTm5QUKB3OB+7Q0
        0kmuT0QPhnQKcPkN3yxVKrvmFADBUR+P8hE1OCkBPayWyPr6dyeUzc1ksFFgZJnO
        Ew2ryTH8lS+krLKotWKilju6HW9JCmrc5uxc5PL4UxYwvdIKHGiJ1IaFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=SGor/vFDB/XZ/dnJR0vAHVbMnfcW44zyTkkJk0votSE=; b=QYNFOOC6
        SQSAfBpHCm55xeS8HA/PFhQkuqcTY6sVm9BiwVkut9uOzHBgj0kUm1oaPIU+h+Kq
        aT4R3Bq0LRWVo7be+RLkm0wV5aCWmHs/Av72mvXn9+0mXZzPL5Mm4ssbIkl2iqYF
        z6s+Z7bUr8ySpkM89UKKdZphsANGS3gpg4HrCiXS9/kc+We1zLs+jPE0sytAf6Uc
        TzmOfHx0ChzBuyc5V27LLEeG5w1XrIQ7lTpVo1mbGHuLaG093jwLuvVvKsF2S4PN
        C8vJBwMr7MZ4ZpUacFy51r5+qzAORgnWtcUMeSpoyBfHkan4oEVtUZKiAqhi3Ore
        Kloz5uu69GHGCw==
X-ME-Sender: <xms:Kd7hXhalnmlcx_3OCrWKpNv_UCx01HUDoeGd5-V67gE-mH9O60R0hg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudehjedguddvvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpedvkeelveefffekjefhffeuleetleefudeifeehuddugffghffhffehveev
    heehvdenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedvtd
    enucfrrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:Kd7hXoYqHA2Q1fFK_2FWubrKqKzLKrPqzKVacCdudAUwISkcnTpV8A>
    <xmx:Kd7hXj_XGkKuRX3IpOeLt8nQ7QSjFpaptI6H5A3qMVJz9sLvkfxKRw>
    <xmx:Kd7hXvqrx5ft3RY7S99ZMMEbrag7WfrgwB8QAE3wP-57gI02KSh8qg>
    <xmx:Kd7hXocNul61Wq9E7nXTbM6_k2NC9Dqwo7LsAXwTTdkW3Z82L0N8kg>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 269FE3061CB6;
        Thu, 11 Jun 2020 03:32:57 -0400 (EDT)
From:   Maxime Ripard <maxime@cerno.tech>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Maxime Ripard <maxime@cerno.tech>
Subject: [PATCH v4 23/27] Revert "clk: bcm2835: remove pllb"
Date:   Thu, 11 Jun 2020 09:32:12 +0200
Message-Id: <2795d7ad33c9eba631fb356df7ff075ee5e8a0b8.1591860665.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.58c6e44891ff5bf61052b5804f7da9b5ba074840.1591860665.git-series.maxime@cerno.tech>
References: <cover.58c6e44891ff5bf61052b5804f7da9b5ba074840.1591860665.git-series.maxime@cerno.tech>
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
index 6bb7efa12037..32f5c13be9d1 100644
--- a/drivers/clk/bcm/clk-bcm2835.c
+++ b/drivers/clk/bcm/clk-bcm2835.c
@@ -1684,10 +1684,32 @@ static const struct bcm2835_clk_desc clk_desc_array[] = {
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
