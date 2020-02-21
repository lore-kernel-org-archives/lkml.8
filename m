Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACA79C35646
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 14:21:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84EA4206EF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 14:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582294882;
	bh=1zpYu1SWYzsuX4cYaFE2Wol7UHn8SagFeA2CAEbPRzc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=Tslq6wIIrKalWPSnNwGwh0tcxjwMZvga2wxpMy4qJlPhDX7jggw24NxF/iSwIehpZ
	 uw7gVLq14aCCZQIi9R6lFK78gCy3OldmHIc0cYQHKl5hM9QOVJsrPQ5HeVcfzBIcC7
	 5Oyfj1/wE+blLB04lpMSTDYXVg5ie1GK5GaJGcY0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728913AbgBUOVV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 09:21:21 -0500
Received: from foss.arm.com ([217.140.110.172]:40460 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727851AbgBUOVU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 09:21:20 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1652C101E;
        Fri, 21 Feb 2020 06:21:20 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8143A3F703;
        Fri, 21 Feb 2020 06:21:19 -0800 (PST)
Date:   Fri, 21 Feb 2020 14:21:17 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Yuji Sasaki <sasakiy@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Yuji sasaki <sasakiy@chromium.org>
Subject: Applied "spi: qup: call spi_qup_pm_resume_runtime before suspending" to the spi tree
In-Reply-To: <20200214074340.2286170-1-vkoul@kernel.org>
Message-Id: <applied-20200214074340.2286170-1-vkoul@kernel.org>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: qup: call spi_qup_pm_resume_runtime before suspending

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.6

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From 136b5cd2e2f97581ae560cff0db2a3b5369112da Mon Sep 17 00:00:00 2001
From: Yuji Sasaki <sasakiy@chromium.org>
Date: Fri, 14 Feb 2020 13:13:40 +0530
Subject: [PATCH] spi: qup: call spi_qup_pm_resume_runtime before suspending

spi_qup_suspend() will cause synchronous external abort when
runtime suspend is enabled and applied, as it tries to
access SPI controller register while clock is already disabled
in spi_qup_pm_suspend_runtime().

Signed-off-by: Yuji sasaki <sasakiy@chromium.org>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Link: https://lore.kernel.org/r/20200214074340.2286170-1-vkoul@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-qup.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-qup.c b/drivers/spi/spi-qup.c
index dd3434a407ea..a364b99497e2 100644
--- a/drivers/spi/spi-qup.c
+++ b/drivers/spi/spi-qup.c
@@ -1217,6 +1217,11 @@ static int spi_qup_suspend(struct device *device)
 	struct spi_qup *controller = spi_master_get_devdata(master);
 	int ret;
 
+	if (pm_runtime_suspended(device)) {
+		ret = spi_qup_pm_resume_runtime(device);
+		if (ret)
+			return ret;
+	}
 	ret = spi_master_suspend(master);
 	if (ret)
 		return ret;
@@ -1225,10 +1230,8 @@ static int spi_qup_suspend(struct device *device)
 	if (ret)
 		return ret;
 
-	if (!pm_runtime_suspended(device)) {
-		clk_disable_unprepare(controller->cclk);
-		clk_disable_unprepare(controller->iclk);
-	}
+	clk_disable_unprepare(controller->cclk);
+	clk_disable_unprepare(controller->iclk);
 	return 0;
 }
 
-- 
2.20.1

