Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B44DC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 08:42:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55FC320578
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 08:42:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="IhM8tywD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HlRKy6y6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729332AbgFOImQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 04:42:16 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:56163 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729292AbgFOImB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 04:42:01 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 69BAE580151;
        Mon, 15 Jun 2020 04:42:00 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 15 Jun 2020 04:42:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=gnlr+Pk8xA6Pc
        FY6qSNBIheVgCOOISk87u1kUFkHHzk=; b=IhM8tywD/G8Ae84RkeS2W9SEeLtKc
        s2ICt03/3ZfQBpWO7kvpH/ujR+1NP3Q98haqYzijb6x3qavqoEMJueK2ACAgNrOP
        tKdH4eTHghh9fO9KNRTIXZ0vlodmTF90MB1hJ/Jdteurz77AId0yS4Jfa2boT9RI
        7Gs10GCSqoe6YBQv9/8y5xNVRrWs16snDn05P80QnVmjHs2xK9cLFL+uPnWSmWzr
        FaquJyX0fU6KwTj6V5h1NX6Sg2AHGhWbrzbD6tGTPa4dJa4IwtqSKE73/U8gt+B+
        OX1RFLQdJ8Qu1VbNam/wYk8lmJ1rTJxifQHOfxzIjQLnQSVZPyMuQ9rVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=gnlr+Pk8xA6PcFY6qSNBIheVgCOOISk87u1kUFkHHzk=; b=HlRKy6y6
        i0lkCFlWFYcHkX/w/Ho7g52rf0OdH1A4HH1vFcnT5VNWmhkAiaw4uQKjiQYWblgD
        izx1J1c+aWpsi3HZR15ZvTSrzH/7jraJhf+VHCABlYNCxKwB+ah2hka3mA5VwQsf
        +Uy7L5T6alJOP1p8yyz9ixXKXGYnHSznUldWS80r9TXDGUwmDq1erkkShzc16ZFB
        rbAkiIEziEpZGOi1RmAFlSWoQObF9LEjpu78QsprDSjGn8bpKslp0V0CDPMccrme
        6zXXmUlwA3bvQMZ1/GOT8dY/C56lZXxhk1SyfHc/vrPgBvqZQxX+qrlNov94njDl
        0D+QjEGcPrfiJw==
X-ME-Sender: <xms:WDTnXuc5BNLREWvz0qmjJpM6f6Dixh7a1JI7K8kLkW0YhSnEE7SuSg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudeikedgtdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepvddune
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:WDTnXoNNvDJTLwWBVjhDXOjy2LXbwqmaBwe6JTmDnZN_SxDCwlVvfA>
    <xmx:WDTnXvgK9c0UF5R1yiw1GoR-a4_YYpwtrGVCENclRuj5l5Y9MPYIQw>
    <xmx:WDTnXr_ns0rBl70qwiweV2ro0Cwa9zMaRTUMGDybXJRPQstLF8QiLw>
    <xmx:WDTnXkJ2Hh_iPKRGeEG9zpk4gVgY-nh4RQaIR1Jcz9HslxyyljcnrQ>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 06A883061DC5;
        Mon, 15 Jun 2020 04:41:59 -0400 (EDT)
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
        Philipp Zabel <p.zabel@pengutronix.de>,
        Maxime Ripard <maxime@cerno.tech>
Subject: [PATCH v5 25/27] clk: bcm2835: Allow custom CCF flags for the PLLs
Date:   Mon, 15 Jun 2020 10:41:05 +0200
Message-Id: <ae8bd505d8851f6646e244cd76b6b289346973c8.1592210452.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.98f979c2af2337c57217016d21d7c68e1ac2ce8a.1592210452.git-series.maxime@cerno.tech>
References: <cover.98f979c2af2337c57217016d21d7c68e1ac2ce8a.1592210452.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While some clock types allow for each clock to specify its own custom
flags, the PLLs can't. We will need this for the PLLB, so let's add it.

Acked-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Tested-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/clk/bcm/clk-bcm2835.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/bcm/clk-bcm2835.c b/drivers/clk/bcm/clk-bcm2835.c
index 32f5c13be9d1..b50f00f109bf 100644
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
+	init.flags = pll_data->flags | CLK_IGNORE_UNUSED;
 
 	pll = kzalloc(sizeof(*pll), GFP_KERNEL);
 	if (!pll)
-- 
git-series 0.9.1
