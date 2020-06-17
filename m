Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43D63C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 01:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20CB12100A
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 01:41:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="avFJMyVY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbgFQBl2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 21:41:28 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:19551 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726679AbgFQBje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 21:39:34 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ee973f20000>; Tue, 16 Jun 2020 18:37:54 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 16 Jun 2020 18:39:33 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 16 Jun 2020 18:39:33 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 17 Jun
 2020 01:39:33 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 17 Jun 2020 01:39:32 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.171.186]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5ee974530005>; Tue, 16 Jun 2020 18:39:32 -0700
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <skomatineni@nvidia.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <frankc@nvidia.com>, <hverkuil@xs4all.nl>,
        <sakari.ailus@iki.fi>, <robh+dt@kernel.org>,
        <helen.koike@collabora.com>
CC:     <digetx@gmail.com>, <sboyd@kernel.org>,
        <gregkh@linuxfoundation.org>, <linux-media@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-i2c@vger.kernel.org>
Subject: [RFC PATCH v2 04/18] i2c: tegra: Fix the error path in tegra_i2c_runtime_resume
Date:   Tue, 16 Jun 2020 18:41:20 -0700
Message-ID: <1592358094-23459-5-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1592358094-23459-1-git-send-email-skomatineni@nvidia.com>
References: <1592358094-23459-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1592357875; bh=6abRkuk51eYz02OURFdOxftlQrZtHyE/TdE1BX0E3mw=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=avFJMyVYBuHGK6NEmjBP/w5n8BiEz8ZKF/4tkD8XHOS4OU1h7iFCyv8LarNHY63c5
         KKn8R5vif9cX7Lce5YbJIyNH3vhSGMVv4fXUrSu5iA4Uo/4eW/RkVqcbt8HNgs4Iqs
         pBHLiMFWWTSk2mOtAiz9YO86V682bH9li7XcOnfLOAK6IH4GXS0PI7KcjlhE/yqm1B
         E0xsVOmMJV9UDl6s/I9hAdhxglxCSEy2pEu8wkpJATsCij2k1CFhhgxvBbv7DXbpGC
         l8/pD5mbY24yRYMUosbXi4kd2tHO0t7hXvcuzOvcTcli4OAByV+wvE1e3+sbRtk/CK
         LTWphNU8wp7hw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tegra_i2c_runtime_resume does not disable prior enabled clocks
properly.

This patch fixes it.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/i2c/busses/i2c-tegra.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegra.c
index 3be1018..1b459ca 100644
--- a/drivers/i2c/busses/i2c-tegra.c
+++ b/drivers/i2c/busses/i2c-tegra.c
@@ -668,7 +668,7 @@ static int __maybe_unused tegra_i2c_runtime_resume(struct device *dev)
 		ret = clk_enable(i2c_dev->slow_clk);
 		if (ret < 0) {
 			dev_err(dev, "failed to enable slow clock: %d\n", ret);
-			return ret;
+			goto disable_fast_clk;
 		}
 	}
 
@@ -676,11 +676,16 @@ static int __maybe_unused tegra_i2c_runtime_resume(struct device *dev)
 	if (ret < 0) {
 		dev_err(i2c_dev->dev,
 			"Enabling div clk failed, err %d\n", ret);
-		clk_disable(i2c_dev->fast_clk);
-		return ret;
+		goto disable_slow_clk;
 	}
 
 	return 0;
+
+disable_slow_clk:
+	clk_disable(i2c_dev->slow_clk);
+disable_fast_clk:
+	clk_disable(i2c_dev->fast_clk);
+	return ret;
 }
 
 static int __maybe_unused tegra_i2c_runtime_suspend(struct device *dev)
-- 
2.7.4

