Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 220E5C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 07:34:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF6A720825
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 07:34:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="FHUNabk6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="K3BBOHqb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727805AbgFKHeF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 03:34:05 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:59159 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726793AbgFKHca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 03:32:30 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 1D81D5800D2;
        Thu, 11 Jun 2020 03:32:29 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 11 Jun 2020 03:32:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=LSIsfiNq5IpAS
        JINyuaxA/q7xkNPFUcq7XPKpT78W2w=; b=FHUNabk68335jcXzDJE1L2bS6ShRv
        XYjvSIHvVZCYSi1mkhX95aoB/NGC2N5WPxOwzwQYQ7YgsPeZ4xXUVWbcb0WWztek
        fOnt+b0HsYCp7vu6s+6KNd2k9rmcQfR5NOVD1tFvkk5vuRNxgXr4i66mcDGq4Bz4
        rzKP9V7MEdlmHy7zmoM6txVS7TGnIS0pViPdEVQRcBj3HwE2wj8i5N0e9JqO8DsO
        oNUrogLTKCWh35/1+0cYkPJqSnRJ/yCrxtfvF1bonDnjvfbINWvCHkJZsoxNp3jF
        fdVm5+GzzOnfU789hKyZu1/jT84DpkR3n8MBeXPAkvzLVzAiFzyLnfhfA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=LSIsfiNq5IpASJINyuaxA/q7xkNPFUcq7XPKpT78W2w=; b=K3BBOHqb
        N5urRueOgQ6R94yUQCugBINgwQa9WPCnngdU9BWGMiCq09rmtowSaSs0cIa3sv2v
        ZkOEtbTNoic7qc9wmz1i7nTwk44t20TM+mz5eHOjhqR2AIYurrCb8SduHszldOoM
        ba4AjHa9GwUgsPi9HPOjaJiXSLqJjtH/WAJ5sPuI4Qx7mvMrKHKXR+YFPM/HOm19
        TSkxSO/SUhMV2BpLqakpgD9KqzN/+NuT3Z8F6q5tFdC5a4ooRy+aByInka7zHvXH
        38M+lIeVTVgR4VxflI/8CQrTmt0+LiyZqdv6fhsxCATN3d0CX4micJHB+3tfr1iV
        iA979Zg3tsgg1Q==
X-ME-Sender: <xms:DN7hXkBaV3ANVIQki0vLn30UTGCCgh4L01-i5Sd5LLzVedoy01fs8g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudehjedguddvvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpedvkeelveefffekjefhffeuleetleefudeifeehuddugffghffhffehveev
    heehvdenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedune
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:Dd7hXmgJPUvpzSxxBudwjmvYfpoAmEtI5z73SpZIA1xSq3_bj2rtNQ>
    <xmx:Dd7hXnnJsLLf-nbcOsK0M62_wTEeKTzThngNEXOqXfrxSce9k-RLqA>
    <xmx:Dd7hXqzqt9inWLNmD-uh7brLnS9kHfnUyASPI1WAdptmPynAlKK3Zw>
    <xmx:Dd7hXkEC-aIVq1ipRUkm_mes6iEtkd4lJ0laIzzCRSl0ly0LSvXAug>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id B30DA30618B7;
        Thu, 11 Jun 2020 03:32:28 -0400 (EDT)
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
Subject: [PATCH v4 05/27] clk: bcm: rpi: Statically init clk_init_data
Date:   Thu, 11 Jun 2020 09:31:54 +0200
Message-Id: <d38be655274084b74c29030acffd9b83d1be2a29.1591860665.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.58c6e44891ff5bf61052b5804f7da9b5ba074840.1591860665.git-series.maxime@cerno.tech>
References: <cover.58c6e44891ff5bf61052b5804f7da9b5ba074840.1591860665.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of declaring the clk_init_data and then calling memset on it, just
initialise properly.

Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
Acked-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/clk/bcm/clk-raspberrypi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/clk/bcm/clk-raspberrypi.c b/drivers/clk/bcm/clk-raspberrypi.c
index 8610355bda47..ddc72207212e 100644
--- a/drivers/clk/bcm/clk-raspberrypi.c
+++ b/drivers/clk/bcm/clk-raspberrypi.c
@@ -175,11 +175,10 @@ static const struct clk_ops raspberrypi_firmware_pll_clk_ops = {
 
 static int raspberrypi_register_pllb(struct raspberrypi_clk *rpi)
 {
+	struct clk_init_data init = {};
 	u32 min_rate = 0, max_rate = 0;
-	struct clk_init_data init;
 	int ret;
 
-	memset(&init, 0, sizeof(init));
 
 	/* All of the PLLs derive from the external oscillator. */
 	init.parent_names = (const char *[]){ "osc" };
-- 
git-series 0.9.1
