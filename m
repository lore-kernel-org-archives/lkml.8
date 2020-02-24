Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73D3BC35679
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 09:14:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 459D22080D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 09:14:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="LZi7lHwv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="b6S8YxUj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728101AbgBXJOZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 04:14:25 -0500
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:33731 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727329AbgBXJJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 04:09:03 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id C1C5659B;
        Mon, 24 Feb 2020 04:09:01 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 24 Feb 2020 04:09:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=mGu5AkMjL+pjY
        A6k881OjqlHEbUW9FF6bXhaleje0CE=; b=LZi7lHwveTkt3hIpYrfLOSqNWduf3
        AOcCqR/HHByHFwImxp4Xyu/ytsDskCLmnKFQVVamV54XCcpbEBE647SToQh0Ikdw
        jkVL6gcLYcRAqcXAUQ8VNgeWaRKBJ5M51n7dyr4BMr+Y0WjpgcCyvTaB3zaa/Zp2
        4c/0WFE4IdeEB10JFyQjv9NZOTfvQDkDtzKGlumKGH+uzWASgg2IydBIzv0xVaxc
        8aOT7o/aijZL4FG/3T1CksPLO0aLJfw+FmIOZc8KUL8PS14DW/YyF1yiOp8rxyuM
        6d3nShANAzZWcJQhzQKIpKozENlCx6I4QM/LVvK/Z6jbn0ybNuHNxtkoA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=mGu5AkMjL+pjYA6k881OjqlHEbUW9FF6bXhaleje0CE=; b=b6S8YxUj
        OSQtUEeR6CsFFTyDDjEwQsJxsexk10aWCbtlh3AEHVB8sUdakunbPqevk9bdprJK
        ClYtBfDLoRpkU/pOqP6N/aSpQVuNER2+DC80LdRtQy4YTID2K9TMHsNXaOxpDCzR
        wrkPNU8lwLlxhB+Yodr8stwKaGOdnYme9aysPt1IVKpHKF8HTClbBhFmjBbsKfDO
        1WApP1De1OBYNQqGgWpVU6IWSk3PhCey3a1JwP62qoC7YQwt3YXxzYnmehACewny
        A4hdVXhEBpKPJtiM7JvAJVBUT8HoVUjGZtNHs/zZCe3LKCc7qw4PyK45KnHCajak
        FkqkE6yPFK+xqQ==
X-ME-Sender: <xms:rZJTXsDU1B-45LBybhbFGLtq8Ucsk_1tIIOirsSqHpGLz34oEpPZbw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrledtucetufdoteggodetrfdotffvucfrrh
    hofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhmvgcutfhi
    phgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecukfhppeeltddrkeelrd
    eikedrjeeinecuvehluhhsthgvrhfuihiivgepheenucfrrghrrghmpehmrghilhhfrhho
    mhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:rZJTXhkhCG07yJLb71LGL3sSL_zuVeC46TUOqlx2QjG51SdYvYLa5w>
    <xmx:rZJTXtqxWt693BEfbKR14YXGJZOQxVElrxewdf0dWe-8yNnZZPYq5g>
    <xmx:rZJTXmPWp89CLQ7C-Xc_6xXAhuGKvekUrihhx5KrVlyVhcjTykuTRg>
    <xmx:rZJTXtfuRt3ZqXh7wd_zA8T7M3rQ2CkBCHyaIDkMjgwx1RBeTd3Xaio2Wsg>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 0A15A3280064;
        Mon, 24 Feb 2020 04:09:00 -0500 (EST)
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
Subject: [PATCH 08/89] clk: bcm: rpi: Statically init clk_init_data
Date:   Mon, 24 Feb 2020 10:06:10 +0100
Message-Id: <9ca2cfd02a75d6680533233a9a4e2b60d2ad0ff5.1582533919.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.6c896ace9a5a7840e9cec008b553cbb004ca1f91.1582533919.git-series.maxime@cerno.tech>
References: <cover.6c896ace9a5a7840e9cec008b553cbb004ca1f91.1582533919.git-series.maxime@cerno.tech>
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
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/clk/bcm/clk-raspberrypi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/clk/bcm/clk-raspberrypi.c b/drivers/clk/bcm/clk-raspberrypi.c
index 94870234824c..64fd91b5ffe9 100644
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
