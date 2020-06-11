Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35F93C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 07:33:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03D6D2074B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 07:33:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="gqjSXbaT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ivWAj0Hx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbgFKHd0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 03:33:26 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:60969 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727035AbgFKHdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 03:33:01 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id AB8C35800D1;
        Thu, 11 Jun 2020 03:33:00 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 11 Jun 2020 03:33:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=dnn2VwXT/vDYg
        D25QRwQqmGTjs6iJIx5UDDgqGWJzpY=; b=gqjSXbaThFVeYrZj74p7UxRK8aGse
        ggtThe3LaT6T7kwHNuwMpEBJnSa+gTKr/z6P9GlrVhfZjGXAjKibdKzHHy3ADjOf
        r38DPcOEXT5K7ITz5jLzuJQ6RJRDn1OzJUcTdEkCurn7i9u9DphRgvYlOLd+FG12
        jTz8PCHLwc3EABIEEGHJ1z7otuipLDZYQOixJdOUKnq7725crI747M6g9ZuTqp67
        bsDiWRq1uSG80oA2kC/07yHWTCUjQtCjgFi/VfoKC9riG9kh4kzu+cUc1S+U7DRl
        ClulElmCcJDrJwFOsjhLz8OhI6mIbHsyGu/jELf1xs/42DBEPZlqDAL8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=dnn2VwXT/vDYgD25QRwQqmGTjs6iJIx5UDDgqGWJzpY=; b=ivWAj0Hx
        CIwa+R19EQSVIC5KDTz+IvfE+NeiGpeFL5eo62teLR4ti2/x4HBWXBAvrV+b3/+f
        p5P32pUMSEkp5Mrj1JcsfTRBk3rBrmnqw/T8nvFcflyPMklcwr9IihzT5B4WK2xy
        mkIsY1fN+/QK5YekawMnOWp2E31DivOojBzL/bV/vJy4uNI1gd94syuIiNAwwhEm
        Hi/zDM3QVYBirZBIFADIj/BixMmKHu/cuqox/XeZ2rg5OR/0IgLjGabxpNSGhUnK
        +6HAl6NU7taIAv31EoRA/Ey2jdxlOjdDLkMB5joAk4sDUFwgqxLdKU8Yh5a/UWRH
        BhGRiMP3zU2koA==
X-ME-Sender: <xms:LN7hXvBu2S7-ObcUmH8UvXHZsRpdpteIPejqNvIEmyMrNBu2oPFBbA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudehjedguddvvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpedvkeelveefffekjefhffeuleetleefudeifeehuddugffghffhffehveev
    heehvdenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedvtd
    enucfrrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:LN7hXlj4dfmMvBF-FyYDIVwdBA58rci8ZrN15ovXTUFNo0tU_IbWXg>
    <xmx:LN7hXqkl2mytxiW0agjmpZu40Mum3jAJr23bIw-0FYW6sN2Y16yk-Q>
    <xmx:LN7hXhxLZ-EQCBuxZClvNQdbFkxfuyX07zUNl_rijlAmWaCN9Pi1xQ>
    <xmx:LN7hXnHK8f8H2ItW47LvNMt0ddTIYLqsG6V9Y5sKy6LiXkhxqJ8Aow>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 4CF3D3061856;
        Thu, 11 Jun 2020 03:33:00 -0400 (EDT)
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
Subject: [PATCH v4 25/27] clk: bcm2835: Allow custom CCF flags for the PLLs
Date:   Thu, 11 Jun 2020 09:32:14 +0200
Message-Id: <abfae9fb4bfd76cd83d5ae97499b97b56b5dee58.1591860665.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.58c6e44891ff5bf61052b5804f7da9b5ba074840.1591860665.git-series.maxime@cerno.tech>
References: <cover.58c6e44891ff5bf61052b5804f7da9b5ba074840.1591860665.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While some clock types allow for each clock to specify its own custom
flags, the PLLs can't. We will need this for the PLLB, so let's add it.

Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/clk/bcm/clk-bcm2835.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/bcm/clk-bcm2835.c b/drivers/clk/bcm/clk-bcm2835.c
index 32f5c13be9d1..846ea68b2c73 100644
--- a/drivers/clk/bcm/clk-bcm2835.c
+++ b/drivers/clk/bcm/clk-bcm2835.c
@@ -421,6 +421,7 @@ struct bcm2835_pll_data {
 	u32 reference_enable_mask;
 	/* Bit in CM_LOCK to indicate when the PLL has locked. */
 	u32 lock_mask;
+	u32 flags;
 
 	const struct bcm2835_pll_ana_bits *ana;
 
@@ -1310,7 +1311,7 @@ static struct clk_hw *bcm2835_register_pll(struct bcm2835_cprman *cprman,
 	init.num_parents = 1;
 	init.name = pll_data->name;
 	init.ops = &bcm2835_pll_clk_ops;
-	init.flags = CLK_IGNORE_UNUSED;
+	init.flags = data->flags | CLK_IGNORE_UNUSED;
 
 	pll = kzalloc(sizeof(*pll), GFP_KERNEL);
 	if (!pll)
-- 
git-series 0.9.1
