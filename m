Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 245D0C433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 14:39:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A1AB207D8
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 14:39:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389371AbgE0Ojb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 10:39:31 -0400
Received: from mail.loongson.cn ([114.242.206.163]:42626 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389179AbgE0Oja (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 10:39:30 -0400
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Ax9umae85e9bA5AA--.593S2;
        Wed, 27 May 2020 22:39:22 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Tiezhu Yang <yangtiezhu@loongson.cn>
Subject: [PATCH v4 1/2] clk: hisilicon: Use correct return value about hisi_reset_init()
Date:   Wed, 27 May 2020 22:39:21 +0800
Message-Id: <1590590362-11570-1-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf9Ax9umae85e9bA5AA--.593S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAFW3WFWfGrW8uw1rJryfXrb_yoW5Ar4fpF
        48JFW2ya4Yga17X3ZrX390yFy5Za42gayUGFW8Z3sxZwn8JrWDZr1fury8Zayqqrs3KFWa
        9r40kr48ua1jyFUanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9S14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE
        5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeV
        CFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1l
        c7CjxVAaw2AFwI0_JF0_Jw1lc2xSY4AK67AK6ry5MxAIw28IcxkI7VAKI48JMxC20s026x
        CaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_
        JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r
        1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_
        Zr0_Wr1UMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr
        1UYxBIdaVFxhVjvjDU0xZFpf9x0JU21v-UUUUU=
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The return value about hisi_reset_init() is not correct, fix it.

Fixes: e9a2310fb689 ("reset: hisilicon: fix potential NULL pointer dereference")
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---

v2:
  - No changes, just add "Fixes:" tag

v3:
  - Use ERR_CAST(rstc->membase) to fix the sparse warning

v4:
  - No changes

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
index 93cee17..c733e2e 100644
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
+		return ERR_CAST(rstc->membase);
 
 	spin_lock_init(&rstc->lock);
 	rstc->rcdev.owner = THIS_MODULE;
-- 
2.1.0

