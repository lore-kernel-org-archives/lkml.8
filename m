Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F00FC433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 07:32:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05E0D2074B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 07:32:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="m1hKMTdw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uhjWVm9Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbgFKHcm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 03:32:42 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:43505 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726834AbgFKHce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 03:32:34 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id D165B5800D1;
        Thu, 11 Jun 2020 03:32:33 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 11 Jun 2020 03:32:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=bKIFK4HlCTngX
        qlGFWYw+rUQ2qZUCm/IgUu0AKgZk3I=; b=m1hKMTdwfktf4ru6P8BfAqeeruQA1
        PXuW2I44hMYYoPJPWeT2GpbjFgJ9VjWsGjVwWFNn7TFoQY83bFoM4xriChh6gnbX
        6uHy5hvlgLR6/hnDNRkpqmfEVn05xqTRn87ZkD0ilGP0GdDztrOEGeErApj9nKVZ
        xILj08Durgh5TBLuVww84Y6V5MchLy1i6Ery2Wp2kRGdfsUUHdWTPePsdMJYCIN8
        3jgiIlOoryfxtwP4tOoLK9rThwVs1ftSIFGh8pFHuzlEROrRjMbm4jP3FP/pckk5
        SYJL1ukuvchx4kdkWZhFHk0DP+RP5Xxnr7QvLO4OI6qAdk7Gsgc50cKUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=bKIFK4HlCTngXqlGFWYw+rUQ2qZUCm/IgUu0AKgZk3I=; b=uhjWVm9Q
        nG6vTr4I8kWxdE13/h6yn6aDirgVb/1fWhMEpFCxTxYrcMv3+a67hrUAkZYPwQft
        IuGsJHgdwXZcjU0uhlQlpCDstzzLWd/7m3YUH5QlN6PmTAJs4xIUK030TUteOq+z
        cm8T4tYxs/JnkFvTqoeC6uDKuNFBZdVUCgxjmvo+ErrXk7W8cZu4FzAPzDS2XLfg
        mLag6izt0eJ+3Pe0nGYRn2/A72suk8TI0HW0MhqnWPE7fdBQfTyWqa/P3rW3ahHE
        icECnuI1cnENjr87wKp2o7oYpsG44q2hDtJMwSAoHzFtlDM51VAiLDSQG8WprZ2q
        W0VucG3e63+uhw==
X-ME-Sender: <xms:Ed7hXlCaWSAtYFK8hoN8TFjvxcO3_GdVGiFJL_EfmSKfrbQ3CE3glw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudehjedguddvvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpedvkeelveefffekjefhffeuleetleefudeifeehuddugffghffhffehveev
    heehvdenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpeehne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:Ed7hXjiwgDCWgt18McVeSz31w7X3tjUR2Ms5kCGkAB3XpDJyRTlzhg>
    <xmx:Ed7hXgmwHUAsuKZgj6vmhH249O37riqGdc1cNXXKZ6y_ww8FR9O_fg>
    <xmx:Ed7hXvx1-1M0cQD4nMIfQBuWRdjUIyh8Nniumc-V9O6ljYKciCQyUA>
    <xmx:Ed7hXtGsrN5DxKONOByoRVo9PXttphdvyS5jUB0AA_Z54EBZsjYpyg>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 6F5D83280069;
        Thu, 11 Jun 2020 03:32:33 -0400 (EDT)
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
Subject: [PATCH v4 08/27] clk: bcm: rpi: Make sure pllb_arm is removed
Date:   Thu, 11 Jun 2020 09:31:57 +0200
Message-Id: <e74b057ee84894710a13439246e4a99151b64725.1591860665.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.58c6e44891ff5bf61052b5804f7da9b5ba074840.1591860665.git-series.maxime@cerno.tech>
References: <cover.58c6e44891ff5bf61052b5804f7da9b5ba074840.1591860665.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pllb_arm clock was created at probe time, but was never removed if
something went wrong later in probe, or if the driver was ever removed from
the system.

Now that we are using clk_hw_register(), we can just use its managed variant
to take care of that for us.

Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org
Acked-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/clk/bcm/clk-raspberrypi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/clk/bcm/clk-raspberrypi.c b/drivers/clk/bcm/clk-raspberrypi.c
index b21dd6ddc4fe..d62605861028 100644
--- a/drivers/clk/bcm/clk-raspberrypi.c
+++ b/drivers/clk/bcm/clk-raspberrypi.c
@@ -240,7 +240,7 @@ static int raspberrypi_register_pllb_arm(struct raspberrypi_clk *rpi)
 {
 	int ret;
 
-	ret = clk_hw_register(rpi->dev, &raspberrypi_clk_pllb_arm.hw);
+	ret = devm_clk_hw_register(rpi->dev, &raspberrypi_clk_pllb_arm.hw);
 	if (ret) {
 		dev_err(rpi->dev, "Failed to initialize pllb_arm\n");
 		return ret;
@@ -250,7 +250,6 @@ static int raspberrypi_register_pllb_arm(struct raspberrypi_clk *rpi)
 						NULL, "cpu0");
 	if (!rpi->pllb_arm_lookup) {
 		dev_err(rpi->dev, "Failed to initialize pllb_arm_lookup\n");
-		clk_hw_unregister_fixed_factor(&raspberrypi_clk_pllb_arm.hw);
 		return -ENOMEM;
 	}
 
-- 
git-series 0.9.1
