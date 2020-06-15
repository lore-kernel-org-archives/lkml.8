Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EA2BC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 08:42:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7916220578
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 08:42:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="c0ptGUmc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="P0C0rwe3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729315AbgFOImG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 04:42:06 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:49935 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729294AbgFOImD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 04:42:03 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 0487858014B;
        Mon, 15 Jun 2020 04:42:02 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 15 Jun 2020 04:42:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=09HauIrGgpLtm
        7Rxrd5mOCdFdIG3U7aJzbJ8aXuu6DQ=; b=c0ptGUmcmO3q6fzt8fI4bCrPhjRnj
        hVFeYBmiGw5yxsQCNNPdbQXNPQAjK9fP0171+Jk9e/WN7ZUCJDEH3CIKjC8Y0Cxv
        KIMzYfoO/+AXkoSk9avzcZkaOq+9YnAdfL/8ftFV8COPpLofaTfAhCjZUFYenVeH
        Bya8zj0G8GtKA6Zf39LxRDSQX7Dftm0EotQB4lywkiRLkQq0aHtO7iVhxS2zYuXq
        /wf+84l8fOqZvtgFAGacGIgDgn6sCOv9qY7iwsOphmfOwMCMEjTFroeWLKD2f7RV
        RFiGVhiUQFbQpPLL7T9/itbr9xTwzJa57nQeQQgw2P8h3nz/BFaRrTFhA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=09HauIrGgpLtm7Rxrd5mOCdFdIG3U7aJzbJ8aXuu6DQ=; b=P0C0rwe3
        exR25Cz7Ap4rOUlcKvv4xG0djccgEtPQ5KEYA18kK69d+gQafgkbj2zWiiVVntu4
        bpq9y1ukfWjgqVf+EjS8KRHy5/2sa2ZgNMMpIJ7Jtsj2sO8wHjdFn9fG3MjfVadC
        j3gqRGWCMxfQicz8kanTUVnDbI87UkU/cdhAw31YHy6JgsRatflM+qJxVkm+cnwQ
        liPOAoWMZ9n6LqO2PF7W8NXoK5AMHE8U/tR0o1dJpVUmQeYoliwhJwKgW4dC35dv
        My0J8mffsk/giyHUVtS2q8nCSosqqNzZ942g/8vU2BFjkFdGDuSyljmRjz8cBcfI
        pAUVFo9Qe/8bqg==
X-ME-Sender: <xms:WTTnXuJ9SzWvryHF9vBU4y6WcpRJ-8xO5HIlLG5sPenWOUoK-8hBwA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudeikedgtdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepvddune
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:WTTnXmLBi9QWXoOUmW4QOIYFmfDP6Td5Ly4hb5t3w4flXJ83gDEz-A>
    <xmx:WTTnXuu690h5mZFoZxSO20C8r11ajzXjIhEtsED5Lz0PY6HqdC3m6Q>
    <xmx:WTTnXjYk8QIK2yaq2yKABwc3bY7_KsCE7KpoBBD7xERDwdzZgLPfNw>
    <xmx:WjTnXnm-D2ctHhTvvsl-vs32jEwXcEj_r6Ywlg2WDBSslVj9ssdwSA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 933033280064;
        Mon, 15 Jun 2020 04:42:01 -0400 (EDT)
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
Subject: [PATCH v5 26/27] clk: bcm2835: Don't cache the PLLB rate
Date:   Mon, 15 Jun 2020 10:41:06 +0200
Message-Id: <9864daba2f584ed49aee5ed1d2f4d48507c58197.1592210452.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.98f979c2af2337c57217016d21d7c68e1ac2ce8a.1592210452.git-series.maxime@cerno.tech>
References: <cover.98f979c2af2337c57217016d21d7c68e1ac2ce8a.1592210452.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PLLB rate will be changed through the firmware clocks drivers and will
change behind this drivers' back, so we don't want to cache the rate.

Acked-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Tested-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/clk/bcm/clk-bcm2835.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/bcm/clk-bcm2835.c b/drivers/clk/bcm/clk-bcm2835.c
index b50f00f109bf..027eba31f793 100644
--- a/drivers/clk/bcm/clk-bcm2835.c
+++ b/drivers/clk/bcm/clk-bcm2835.c
@@ -1700,7 +1700,8 @@ static const struct bcm2835_clk_desc clk_desc_array[] = {
 
 		.min_rate = 600000000u,
 		.max_rate = 3000000000u,
-		.max_fb_rate = BCM2835_MAX_FB_RATE),
+		.max_fb_rate = BCM2835_MAX_FB_RATE,
+		.flags = CLK_GET_RATE_NOCACHE),
 	[BCM2835_PLLB_ARM]	= REGISTER_PLL_DIV(
 		SOC_ALL,
 		.name = "pllb_arm",
@@ -1710,7 +1711,7 @@ static const struct bcm2835_clk_desc clk_desc_array[] = {
 		.load_mask = CM_PLLB_LOADARM,
 		.hold_mask = CM_PLLB_HOLDARM,
 		.fixed_divider = 1,
-		.flags = CLK_SET_RATE_PARENT),
+		.flags = CLK_SET_RATE_PARENT | CLK_GET_RATE_NOCACHE),
 
 	/*
 	 * PLLC is the core PLL, used to drive the core VPU clock.
-- 
git-series 0.9.1
