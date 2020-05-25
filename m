Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BDF0C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 03:32:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E95122073B
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 03:32:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388795AbgEYDcC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 23:32:02 -0400
Received: from mail.loongson.cn ([114.242.206.163]:48326 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388450AbgEYDcB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 23:32:01 -0400
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxD94sPMte3cI4AA--.386S2;
        Mon, 25 May 2020 11:31:56 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Tiezhu Yang <yangtiezhu@loongson.cn>
Subject: [PATCH 1/2] clk: hisilicon: Use correct return value about hisi_reset_init()
Date:   Mon, 25 May 2020 11:31:55 +0800
Message-Id: <1590377516-32117-1-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf9DxD94sPMte3cI4AA--.386S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAFW3WFWfGrW8uw1rJryfXrb_yoW5XrWkpF
        48JFW2ya4Yga17X3ZrXr90yFy5Za42gayUGFW8Z3srZwn8JrWUZr1fury8Zayqqrs3KFWa
        9r40kr48ua1jyFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkm14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr
        1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
        6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr
        0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVAFwVW8
        GwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r
        1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij
        64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr
        0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6Fyj6rWUJwCI42IY6I8E87Iv67AKxVW8JVWxJwCI
        42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfU1NVyDUUUU
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The return value about hisi_reset_init() is not correct, fix it.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 drivers/clk/hisilicon/clk-hi3519.c      | 4 ++--
 drivers/clk/hisilicon/crg-hi3516cv300.c | 4 ++--
 drivers/clk/hisilicon/crg-hi3798cv200.c | 4 ++--
 drivers/clk/hisilicon/reset.c           | 4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/hisilicon/clk-hi3519.c b/drivers/clk/hisilicon/clk-hi3519.c
index ad0c7f3..803fa66 100644
--- a/drivers/clk/hisilicon/clk-hi3519.c
+++ b/drivers/clk/hisilicon/clk-hi3519.c
@@ -149,8 +149,8 @@ static int hi3519_clk_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	crg->rstc = hisi_reset_init(pdev);
-	if (!crg->rstc)
-		return -ENOMEM;
+	if (IS_ERR(crg->rstc))
+		return PTR_ERR(crg->rstc);
 
 	crg->clk_data = hi3519_clk_register(pdev);
 	if (IS_ERR(crg->clk_data)) {
diff --git a/drivers/clk/hisilicon/crg-hi3516cv300.c b/drivers/clk/hisilicon/crg-hi3516cv300.c
index 5d4e61c..c2af03d 100644
--- a/drivers/clk/hisilicon/crg-hi3516cv300.c
+++ b/drivers/clk/hisilicon/crg-hi3516cv300.c
@@ -271,8 +271,8 @@ static int hi3516cv300_crg_probe(struct platform_device *pdev)
 		return -ENOENT;
 
 	crg->rstc = hisi_reset_init(pdev);
-	if (!crg->rstc)
-		return -ENOMEM;
+	if (IS_ERR(crg->rstc))
+		return PTR_ERR(crg->rstc);
 
 	crg->clk_data = crg->funcs->register_clks(pdev);
 	if (IS_ERR(crg->clk_data)) {
diff --git a/drivers/clk/hisilicon/crg-hi3798cv200.c b/drivers/clk/hisilicon/crg-hi3798cv200.c
index 08a19ba..66fd6a9 100644
--- a/drivers/clk/hisilicon/crg-hi3798cv200.c
+++ b/drivers/clk/hisilicon/crg-hi3798cv200.c
@@ -354,8 +354,8 @@ static int hi3798cv200_crg_probe(struct platform_device *pdev)
 		return -ENOENT;
 
 	crg->rstc = hisi_reset_init(pdev);
-	if (!crg->rstc)
-		return -ENOMEM;
+	if (IS_ERR(crg->rstc))
+		return PTR_ERR(crg->rstc);
 
 	crg->clk_data = crg->funcs->register_clks(pdev);
 	if (IS_ERR(crg->clk_data)) {
diff --git a/drivers/clk/hisilicon/reset.c b/drivers/clk/hisilicon/reset.c
index 93cee17..f17d15f 100644
--- a/drivers/clk/hisilicon/reset.c
+++ b/drivers/clk/hisilicon/reset.c
@@ -93,11 +93,11 @@ struct hisi_reset_controller *hisi_reset_init(struct platform_device *pdev)
 
 	rstc = devm_kmalloc(&pdev->dev, sizeof(*rstc), GFP_KERNEL);
 	if (!rstc)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 
 	rstc->membase = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(rstc->membase))
-		return NULL;
+		return rstc->membase;
 
 	spin_lock_init(&rstc->lock);
 	rstc->rcdev.owner = THIS_MODULE;
-- 
2.1.0

