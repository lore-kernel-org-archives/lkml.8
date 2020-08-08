Return-Path: <SRS0=uMsS=BS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 958DDC433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 23:36:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7317B206D8
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 23:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596929781;
	bh=5FS1bRYbhh3iZG9BJtPW8I/Q7cLQiRbWaIwY811DndM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=heF7YB4fyW49+WTk4bXFiHIkCkoAN+2JQpbTCwdB8bET7QkYbDjGDo7HF18iJsA6t
	 d3W8kfxax4ktE8F85rhrwUiF7DDvyFGjTZS/mGjfQCYaGJTOft11e3s9y6pZcKSdyl
	 /ZGfXa0uzZb2a66FD7Rj8+cGAw6Zn5WsUdvSxo/E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbgHHXgT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Aug 2020 19:36:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:48660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726798AbgHHXgS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Aug 2020 19:36:18 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 69B7920716;
        Sat,  8 Aug 2020 23:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596929778;
        bh=5FS1bRYbhh3iZG9BJtPW8I/Q7cLQiRbWaIwY811DndM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cefXIEo0DVWHUp76r2okkzVKDnF5Emet+xGoImO7y5WqCWF3W+NefB3297jQl+2cA
         SbDTV9yRlZLDMGKfRXBviq86iQIkqektuCn6X+wp+jSx89zcCHkJtkRDTMKtxC0MGO
         Hsoy8aona2N/Qpw8Ad+pxmoTnoaigRdKSyyaSYzA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Dien Pham <dien.pham.ry@renesas.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
Subject: [PATCH AUTOSEL 5.8 27/72] clk: scmi: Fix min and max rate when registering clocks with discrete rates
Date:   Sat,  8 Aug 2020 19:34:56 -0400
Message-Id: <20200808233542.3617339-27-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200808233542.3617339-1-sashal@kernel.org>
References: <20200808233542.3617339-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sudeep Holla <sudeep.holla@arm.com>

[ Upstream commit fcd2e0deae50bce48450f14c8fc5611b08d7438c ]

Currently we are not initializing the scmi clock with discrete rates
correctly. We fetch the min_rate and max_rate value only for clocks with
ranges and ignore the ones with discrete rates. This will lead to wrong
initialization of rate range when clock supports discrete rate.

Fix this by using the first and the last rate in the sorted list of the
discrete clock rates while registering the clock.

Link: https://lore.kernel.org/r/20200709081705.46084-2-sudeep.holla@arm.com
Fixes: 6d6a1d82eaef7 ("clk: add support for clocks provided by SCMI")
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
Reported-and-tested-by: Dien Pham <dien.pham.ry@renesas.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/clk-scmi.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/clk-scmi.c b/drivers/clk/clk-scmi.c
index c491f5de0f3f4..c754dfbb73fd4 100644
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
2.25.1

