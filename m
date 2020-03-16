Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D34EDC10DCE
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 02:35:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1E9720738
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 02:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584326127;
	bh=L57iPVKkL097o6qLvQ+L5j2oTFH13RI1AUODGUtvQTY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=j0ZykF8rK58dmPuuOF2xqdUiWeSwupJR9szKWqI5R9/4BtPCD1qh72UcBKEX5egf/
	 35CVTwOVURpQRAqX3LVI4kYeoEG9dOyNrXpbr04M3eTtB9ukf+QJYrGlfOU0X9oLrU
	 3pE3TEao+jxjJ4M1Vh08r5AbtybK2c8lEye1gWAY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730158AbgCPCf0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Mar 2020 22:35:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:39770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729732AbgCPCfX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 22:35:23 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B473D20736;
        Mon, 16 Mar 2020 02:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584326122;
        bh=L57iPVKkL097o6qLvQ+L5j2oTFH13RI1AUODGUtvQTY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YfeQBcXS7nbwyWzrVdjD6YUgCjx2ofoxQoU0TmQ7nqLfieMF8cPBJxKGqH6Z1CpK+
         38AhEi20rxGk16vrAHwtViqozv2imujXq5oWXKt74Tat0exfx9i/QFCZG+a6rp6o2b
         Tw/SKq8NZ0nj9+sRlQABbMwuiXHbnkBhZe4G7wgQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yuji Sasaki <sasakiy@chromium.org>, Vinod Koul <vkoul@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 02/15] spi: qup: call spi_qup_pm_resume_runtime before suspending
Date:   Sun, 15 Mar 2020 22:35:06 -0400
Message-Id: <20200316023519.2050-2-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200316023519.2050-1-sashal@kernel.org>
References: <20200316023519.2050-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yuji Sasaki <sasakiy@chromium.org>

[ Upstream commit 136b5cd2e2f97581ae560cff0db2a3b5369112da ]

spi_qup_suspend() will cause synchronous external abort when
runtime suspend is enabled and applied, as it tries to
access SPI controller register while clock is already disabled
in spi_qup_pm_suspend_runtime().

Signed-off-by: Yuji sasaki <sasakiy@chromium.org>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Link: https://lore.kernel.org/r/20200214074340.2286170-1-vkoul@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-qup.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-qup.c b/drivers/spi/spi-qup.c
index 974a8ce58b68b..cb74fd1af2053 100644
--- a/drivers/spi/spi-qup.c
+++ b/drivers/spi/spi-qup.c
@@ -1190,6 +1190,11 @@ static int spi_qup_suspend(struct device *device)
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
@@ -1198,10 +1203,8 @@ static int spi_qup_suspend(struct device *device)
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

