Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD9D1C433E7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 15:37:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E7CF20678
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 15:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599061021;
	bh=aA+PtX6Nad2JFzWaGrJQ2P+Mkq0OmWZKEB6gRo24RH8=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=GHzpli7BpIew7iCUoqBuymuoqjKyV1OXAxNNInkBkiiEaUiCibotoW7cvjhw93xKn
	 f2QjgVJaXxvfclAMJsWBoUn9RLVDydkqqI5tv+9qLH8bx87VHnqsBK5OhEb721lGil
	 gFgkyC9j+RiB6otCAr9PSVzMejwH2QqGy1CTI/cc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728234AbgIBPhA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 11:37:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:41406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726618AbgIBPEA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 11:04:00 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 64C4520773;
        Wed,  2 Sep 2020 15:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599059040;
        bh=aA+PtX6Nad2JFzWaGrJQ2P+Mkq0OmWZKEB6gRo24RH8=;
        h=From:To:Cc:Subject:Date:From;
        b=u8LETQ3giKPlRcn+a/R/eWqA6GUVG4FAiqFYzmRMqn2vlA5UNNO4H+WwjxOb0g8eq
         hxJeGI+2kXZjju7EZqjBXc+v0aQxSQjU/MShvRjy1dpwcGl3HZ2fXE5lo291Z/ZQ+H
         XHI1KR/Hg7nXMdGRxmZlmXpmZTqUmUHApR6W5ywQ=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        David Lechner <david@lechnology.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-arm-msm@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 01/10] clk: at91: Drop unused at91sam9g45_pcr_layout
Date:   Wed,  2 Sep 2020 17:03:39 +0200
Message-Id: <20200902150348.14465-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The at91sam9g45_pcr_layout is not used so drop it to fix build warning:

  drivers/clk/at91/at91sam9g45.c:49:36: warning:
    'at91sam9g45_pcr_layout' defined but not used [-Wunused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/clk/at91/at91sam9g45.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/clk/at91/at91sam9g45.c b/drivers/clk/at91/at91sam9g45.c
index c88ee20bee31..cb4a406ed15d 100644
--- a/drivers/clk/at91/at91sam9g45.c
+++ b/drivers/clk/at91/at91sam9g45.c
@@ -46,13 +46,6 @@ static const struct {
 	{ .n = "pck1",  .p = "prog1",    .id = 9 },
 };
 
-static const struct clk_pcr_layout at91sam9g45_pcr_layout = {
-	.offset = 0x10c,
-	.cmd = BIT(12),
-	.pid_mask = GENMASK(5, 0),
-	.div_mask = GENMASK(17, 16),
-};
-
 struct pck {
 	char *n;
 	u8 id;
-- 
2.17.1

