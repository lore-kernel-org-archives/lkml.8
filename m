Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50A03C433F7
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 23:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EBDD2080D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 23:48:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="jKBpT3+3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728458AbgGWXs1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 19:48:27 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:7661 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728364AbgGWXsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 19:48:19 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f1a21b60002>; Thu, 23 Jul 2020 16:48:07 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 23 Jul 2020 16:48:19 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 23 Jul 2020 16:48:19 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 23 Jul
 2020 23:48:19 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Thu, 23 Jul 2020 23:48:19 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.168.236]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5f1a21c20000>; Thu, 23 Jul 2020 16:48:18 -0700
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <skomatineni@nvidia.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <frankc@nvidia.com>, <hverkuil@xs4all.nl>,
        <sakari.ailus@iki.fi>, <robh+dt@kernel.org>,
        <helen.koike@collabora.com>
CC:     <digetx@gmail.com>, <sboyd@kernel.org>,
        <gregkh@linuxfoundation.org>, <linux-media@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-i2c@vger.kernel.org>
Subject: [RFC PATCH v4 04/14] i2c: tegra: Fix runtime resume to re-init VI I2C
Date:   Thu, 23 Jul 2020 16:51:02 -0700
Message-ID: <1595548272-9809-5-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595548272-9809-1-git-send-email-skomatineni@nvidia.com>
References: <1595548272-9809-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1595548087; bh=rVT7elWIzK6dQfAm9YaBBuoEEleair7GkfBCOrcVb5U=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=jKBpT3+3s55E2h9AArSUiywyocG4pjbOBhVwPfwkX1Mtqm90/N3w1vW/NaefYSIM2
         EUHw+9EbnKSoHBy4GOXtYuYPbRfZWdSG+yfELAwEkuF1QCyjwG1VTEV8jD9Ikt6BQj
         YBHiIjAZCqNhzHoH7iBOn4Csp3PICSRkD6fzcWW4Ad7ap7zxPcVouD4CWLEQwkVZAn
         k7QEdrD9DkoX9xIZPn7uqvNU2QVcQQtzoFPVxN76B03UqAt/1y7jIf4cK1FzY1hhc2
         xrXVjCaod9P22W29FUsUo42cfqWYGc/mRm/aCQt/AZrGmu0zpkqqfVwYAXliNiq4J8
         oywWiv9A7VflA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VI I2C is on host1x bus and is part of VE power domain.

During suspend/resume VE power domain goes through power off/on.

So, controller reset followed by i2c re-initialization is required
after the domain power up.

This patch fixes it.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/i2c/busses/i2c-tegra.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegra.c
index 7b93c45..1bf3666 100644
--- a/drivers/i2c/busses/i2c-tegra.c
+++ b/drivers/i2c/busses/i2c-tegra.c
@@ -293,6 +293,8 @@ struct tegra_i2c_dev {
 	bool is_curr_atomic_xfer;
 };
 
+static int tegra_i2c_init(struct tegra_i2c_dev *i2c_dev, bool clk_reinit);
+
 static void dvc_writel(struct tegra_i2c_dev *i2c_dev, u32 val,
 		       unsigned long reg)
 {
@@ -675,8 +677,22 @@ static int __maybe_unused tegra_i2c_runtime_resume(struct device *dev)
 		goto disable_slow_clk;
 	}
 
+	/*
+	 * VI I2C device is attached to VE power domain which goes through
+	 * power ON/OFF during PM runtime resume/suspend. So, controller
+	 * should go through reset and need to re-initialize after power
+	 * domain ON.
+	 */
+	if (i2c_dev->is_vi) {
+		ret = tegra_i2c_init(i2c_dev, true);
+		if (ret)
+			goto disable_div_clk;
+	}
+
 	return 0;
 
+disable_div_clk:
+	clk_disable(i2c_dev->div_clk);
 disable_slow_clk:
 	clk_disable(i2c_dev->slow_clk);
 disable_fast_clk:
-- 
2.7.4

