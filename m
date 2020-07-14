Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61C42C433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 09:09:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E74E2076D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 09:09:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbgGNJJV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 05:09:21 -0400
Received: from mail.loongson.cn ([114.242.206.163]:35316 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726479AbgGNJJV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 05:09:21 -0400
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9CxqdQ7dg1fIVcEAA--.3823S2;
        Tue, 14 Jul 2020 17:09:16 +0800 (CST)
From:   Qing Zhang <zhangqing@loongson.cn>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Qing Zhang <zhangqing@loongson.cn>
Subject: [PATCH] spi: Use clk_prepare_enable and clk_disable_unprepare
Date:   Tue, 14 Jul 2020 17:09:14 +0800
Message-Id: <1594717754-25428-1-git-send-email-zhangqing@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf9CxqdQ7dg1fIVcEAA--.3823S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Ary8Ww4UCw1fJF4UXryfXrb_yoW8Cr17pF
        Z7tFWF9r4xXa109FsFv3yqvFyYy34fKa42kw4rK34ru345tryUtF48Xa4IvF4xuFykAF1I
        9F4UKrs8Aan8ur7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyK14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
        xl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
        6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr
        0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxAIw28IcxkI7VAK
        I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
        xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xII
        jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
        0EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
        1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfU0iiSUUUUU
X-CM-SenderInfo: x2kd0wptlqwqxorr0wxvrqhubq/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert clk_enable/clk_disable to clk_prepare_enable/clk_disable_unprepare
calls as required by common clock framework.

Signed-off-by: Qing Zhang <zhangqing@loongson.cn>
---
 drivers/spi/spi-coldfire-qspi.c | 4 ++--
 drivers/spi/spi-omap-uwire.c    | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-coldfire-qspi.c b/drivers/spi/spi-coldfire-qspi.c
index f80e06c..8996115 100644
--- a/drivers/spi/spi-coldfire-qspi.c
+++ b/drivers/spi/spi-coldfire-qspi.c
@@ -387,7 +387,7 @@ static int mcfqspi_probe(struct platform_device *pdev)
 		status = PTR_ERR(mcfqspi->clk);
 		goto fail0;
 	}
-	clk_enable(mcfqspi->clk);
+	clk_prepare_enable(mcfqspi->clk);
 
 	master->bus_num = pdata->bus_num;
 	master->num_chipselect = pdata->num_chipselect;
@@ -425,7 +425,7 @@ static int mcfqspi_probe(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 	mcfqspi_cs_teardown(mcfqspi);
 fail1:
-	clk_disable(mcfqspi->clk);
+	clk_disable_unprepare(mcfqspi->clk);
 fail0:
 	spi_master_put(master);
 
diff --git a/drivers/spi/spi-omap-uwire.c b/drivers/spi/spi-omap-uwire.c
index ce8dbdb..71402f7 100644
--- a/drivers/spi/spi-omap-uwire.c
+++ b/drivers/spi/spi-omap-uwire.c
@@ -443,7 +443,7 @@ static void uwire_cleanup(struct spi_device *spi)
 static void uwire_off(struct uwire_spi *uwire)
 {
 	uwire_write_reg(UWIRE_SR3, 0);
-	clk_disable(uwire->ck);
+	clk_disable_unprepare(uwire->ck);
 	spi_master_put(uwire->bitbang.master);
 }
 
@@ -475,7 +475,7 @@ static int uwire_probe(struct platform_device *pdev)
 		spi_master_put(master);
 		return status;
 	}
-	clk_enable(uwire->ck);
+	clk_prepare_enable(uwire->ck);
 
 	if (cpu_is_omap7xx())
 		uwire_idx_shift = 1;
-- 
2.1.0

