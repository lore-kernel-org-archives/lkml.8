Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26EB9C11D2B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 09:09:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E125A20675
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 09:09:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="uvzNVw6B";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sm8FQuxJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727463AbgBXJJL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 04:09:11 -0500
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:44425 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727426AbgBXJJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 04:09:08 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id 20E285E3;
        Mon, 24 Feb 2020 04:09:06 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 24 Feb 2020 04:09:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=3M4EyaGONSLCL
        toRUS3p9if81q7yU+s/124NlIsYLBc=; b=uvzNVw6B7+xtv6hNLktricI2W8I1f
        pEuOZb0VTQsUIlDONpYTJgzVM7Hk7VCjQpEtE/I788rOmR10XPFcBUCPYOuwbuV/
        s73RfW++BWGAbjkDw0pRPuJOVHRaVXPS0ReQ9DeRQp89mMIj+XF7nTJl4+eevPci
        1fDWVNXD+b8AfV6SGuz4XdRQc2tkUxsqryoe/iBmK8OjtOcvudORewP7N3LwD/dK
        vUQ0bIDJRZ4hRQmFrX1h63OmG3TAYJ9eCuJr5Nqxfa8p6NC+xCEqrnmdEoPlOHEU
        7ZMRlbHCN+KfH6GAwtvVnAqsakdiUpKn9y+qeoRw+LMuOzGe/Rj3qJFWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=3M4EyaGONSLCLtoRUS3p9if81q7yU+s/124NlIsYLBc=; b=sm8FQuxJ
        AcmCRM6UpMV88VDFYZ97c+Gxr+ugl7+JE1WafLoryBNrme4C8GUd3fbtEaZKEvJe
        IcqGXVrKENIjJtzcu4aMjCMFekTvT4KVJT7MCC6NzeuEwVTH1bntBqnvr31Wjtr7
        B7bhR7eFgfGPJUpzZCUc1H7M/hg1lMMn2/y/XxBQntRQYjX6snIgGJvf1F/unuEo
        BiRuvjzsSghzU3f+jYs1/uN8FVFs8JXIQeFssMp4v3sfnoHGkHR3nhjDfJja6HV3
        3ngI3GzrgaBxFhzIx02XWBknNZ1W3Ib/7vIl64GBDb9TUzdfNq8OcGjmVTc8ClN6
        ISLxHKAh6gQJIw==
X-ME-Sender: <xms:sZJTXiSIbk4F30TzWWUkCwVUklQ3tuw24XKv0LZiZ1bzl8gJqn7kPg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrledtucetufdoteggodetrfdotffvucfrrh
    hofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhmvgcutfhi
    phgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecukfhppeeltddrkeelrd
    eikedrjeeinecuvehluhhsthgvrhfuihiivgepheenucfrrghrrghmpehmrghilhhfrhho
    mhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:sZJTXvbHR2T_M5429C_BLP4EyqngIleMz-e0Lmm2p7-KgAmY0akknw>
    <xmx:sZJTXgAvyPCDtXn4dkAACkRi4BWMit8GMAyvBkm4kq-ispYSLn-cuw>
    <xmx:sZJTXmDoNxrOmGre1fDLdPK1J1qM1DHX0Pl4Kbaz_VZsiLc4VZWxUw>
    <xmx:sZJTXsJMNlY2WGCDqJ_R4C6jjsR-Hc-AbPbpbGMtCMyuw85u91PabZI_XeU>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 58D4A3060BD1;
        Mon, 24 Feb 2020 04:09:05 -0500 (EST)
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
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org
Subject: [PATCH 11/89] clk: bcm: rpi: Make sure pllb_arm is removed
Date:   Mon, 24 Feb 2020 10:06:13 +0100
Message-Id: <5571315e0aa8c8af02ad61cb396137707d4b6da4.1582533919.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.6c896ace9a5a7840e9cec008b553cbb004ca1f91.1582533919.git-series.maxime@cerno.tech>
References: <cover.6c896ace9a5a7840e9cec008b553cbb004ca1f91.1582533919.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pllb_arm clock was created at probe time, but was never removed if
something went wrong later in probe, or if the driver was ever removed from
the system.

Now that we are using clk_hw_register, we can just use its managed variant
to take care of that for us.

Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/clk/bcm/clk-raspberrypi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/clk/bcm/clk-raspberrypi.c b/drivers/clk/bcm/clk-raspberrypi.c
index 61a942f9a6a2..783c8c5e5373 100644
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
