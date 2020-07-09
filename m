Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA71DC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 08:17:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B70FF20720
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 08:17:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbgGIIRQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 04:17:16 -0400
Received: from foss.arm.com ([217.140.110.172]:41852 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726433AbgGIIRO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 04:17:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0C5331045;
        Thu,  9 Jul 2020 01:17:14 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0D7563F887;
        Thu,  9 Jul 2020 01:17:12 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Dien Pham <dien.pham.ry@renesas.com>
Subject: [PATCH v2 2/2] clk: scmi: Fix min and max rate when registering clocks with discrete rates
Date:   Thu,  9 Jul 2020 09:17:05 +0100
Message-Id: <20200709081705.46084-2-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200709081705.46084-1-sudeep.holla@arm.com>
References: <20200709081705.46084-1-sudeep.holla@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently we are not initializing the scmi clock with discrete rates
correctly. We fetch the min_rate and max_rate value only for clocks with
ranges and ignore the ones with discrete rates. This will lead to wrong
initialization of rate range when clock supports discrete rate.

Fix this by using the first and the last rate in the sorted list of the
discrete clock rates while registering the clock.

Link: https://lore.kernel.org/r/20200708110725.18017-2-sudeep.holla@arm.com
Fixes: 6d6a1d82eaef7 ("clk: add support for clocks provided by SCMI")
Reported-by: Dien Pham <dien.pham.ry@renesas.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/clk/clk-scmi.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

Hi Stephen,

If you are fine, I can take this via ARM SoC along with the change in
firmware driver. However it is also fine if you want to merge this
independently as there is no strict dependency. Let me know either way.

v1[1]->v2:
	- Fixed the missing ; which was sent by mistake.

Regards,
Sudeep

[1] https://lore.kernel.org/r/20200708110725.18017-2-sudeep.holla@arm.com

diff --git a/drivers/clk/clk-scmi.c b/drivers/clk/clk-scmi.c
index c491f5de0f3f..c754dfbb73fd 100644
--- a/drivers/clk/clk-scmi.c
+++ b/drivers/clk/clk-scmi.c
@@ -103,6 +103,8 @@ static const struct clk_ops scmi_clk_ops = {
 static int scmi_clk_ops_init(struct device *dev, struct scmi_clk *sclk)
 {
 	int ret;
+	unsigned long min_rate, max_rate;
+
 	struct clk_init_data init = {
 		.flags = CLK_GET_RATE_NOCACHE,
 		.num_parents = 0,
@@ -112,9 +114,23 @@ static int scmi_clk_ops_init(struct device *dev, struct scmi_clk *sclk)
 
 	sclk->hw.init = &init;
 	ret = devm_clk_hw_register(dev, &sclk->hw);
-	if (!ret)
-		clk_hw_set_rate_range(&sclk->hw, sclk->info->range.min_rate,
-				      sclk->info->range.max_rate);
+	if (ret)
+		return ret;
+
+	if (sclk->info->rate_discrete) {
+		int num_rates = sclk->info->list.num_rates;
+
+		if (num_rates <= 0)
+			return -EINVAL;
+
+		min_rate = sclk->info->list.rates[0];
+		max_rate = sclk->info->list.rates[num_rates - 1];
+	} else {
+		min_rate = sclk->info->range.min_rate;
+		max_rate = sclk->info->range.max_rate;
+	}
+
+	clk_hw_set_rate_range(&sclk->hw, min_rate, max_rate);
 	return ret;
 }
 
-- 
2.17.1

