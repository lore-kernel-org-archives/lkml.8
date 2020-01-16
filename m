Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 195B2C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:18:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4F672467A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579195132;
	bh=0xobRyoduVI+vbV4RQEXgdcoSC69M+uVlzQ0t7y5Dqk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FTq90ssnVbgAd0bXMWkLBbIP2Aib4AkhJyK0FU3RYqqcSYTpipBYQBtdNpNLgjWp7
	 oedSu4G6G3gVbZVNtNf/Tihe2U60BUGrzoMjcwb5CzPy4FIZKdF9r/Vgj+L5UzAo+I
	 O2PP9xgsFJT1+7Wy/bLy0QzXHZ9pEY3v0aJ8CRZI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391559AbgAPRSr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:18:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:46398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391511AbgAPRSf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:18:35 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 56B0D246BF;
        Thu, 16 Jan 2020 17:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579195115;
        bh=0xobRyoduVI+vbV4RQEXgdcoSC69M+uVlzQ0t7y5Dqk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0Z0g2TYriHChNLPFTE0QsRy+nn3PpzqhSIk8vHDSQtGwwMuX0lOphOzw6AQlSLkub
         CWFo/KE2ng3F3nNoWWAtDj6ADRjVEJFINY2egUotO02aDgza0mw8d8NA0vuN9j7Wwf
         pxVYK9MIdfRsPaU4HmjRQkPpqdaSi6hYBNlMfBh4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-spi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 055/371] spi: cadence: Correct initialisation of runtime PM
Date:   Thu, 16 Jan 2020 12:12:03 -0500
Message-Id: <20200116171719.16965-55-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116171719.16965-1-sashal@kernel.org>
References: <20200116171719.16965-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Charles Keepax <ckeepax@opensource.cirrus.com>

[ Upstream commit 734882a8bf984c2ac8a57d8ac3ee53230bd0bed8 ]

Currently the driver calls pm_runtime_put_autosuspend but without ever
having done a pm_runtime_get, this causes the reference count in the pm
runtime core to become -1. The bad reference count causes the core to
sometimes suspend whilst an active SPI transfer is in progress.

arizona spi0.1: SPI transfer timed out
spi_master spi0: failed to transfer one message from queue

The correct proceedure is to do all the initialisation that requires the
hardware to be powered up before enabling the PM runtime, then enable
the PM runtime having called pm_runtime_set_active to inform it that the
hardware is currently powered up. The core will then power it down at
it's leisure and no explicit pm_runtime_put is required.

Fixes: d36ccd9f7ea4 ("spi: cadence: Runtime pm adaptation")
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-cadence.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-cadence.c b/drivers/spi/spi-cadence.c
index 02bd1eba045b..d08ad93d97a1 100644
--- a/drivers/spi/spi-cadence.c
+++ b/drivers/spi/spi-cadence.c
@@ -584,11 +584,6 @@ static int cdns_spi_probe(struct platform_device *pdev)
 		goto clk_dis_apb;
 	}
 
-	pm_runtime_use_autosuspend(&pdev->dev);
-	pm_runtime_set_autosuspend_delay(&pdev->dev, SPI_AUTOSUSPEND_TIMEOUT);
-	pm_runtime_set_active(&pdev->dev);
-	pm_runtime_enable(&pdev->dev);
-
 	ret = of_property_read_u32(pdev->dev.of_node, "num-cs", &num_cs);
 	if (ret < 0)
 		master->num_chipselect = CDNS_SPI_DEFAULT_NUM_CS;
@@ -603,8 +598,10 @@ static int cdns_spi_probe(struct platform_device *pdev)
 	/* SPI controller initializations */
 	cdns_spi_init_hw(xspi);
 
-	pm_runtime_mark_last_busy(&pdev->dev);
-	pm_runtime_put_autosuspend(&pdev->dev);
+	pm_runtime_set_active(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
+	pm_runtime_use_autosuspend(&pdev->dev);
+	pm_runtime_set_autosuspend_delay(&pdev->dev, SPI_AUTOSUSPEND_TIMEOUT);
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq <= 0) {
-- 
2.20.1

