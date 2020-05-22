Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 516D7C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 07:51:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 387552072C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 07:51:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728824AbgEVHvL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 03:51:11 -0400
Received: from mail.loongson.cn ([114.242.206.163]:36060 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728152AbgEVHvJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 03:51:09 -0400
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dx72plhMdeCME3AA--.75S3;
        Fri, 22 May 2020 15:51:02 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Tiezhu Yang <yangtiezhu@loongson.cn>
Subject: [PATCH 1/2] nvmem: sprd: Fix return value of sprd_efuse_probe()
Date:   Fri, 22 May 2020 15:51:00 +0800
Message-Id: <1590133861-25515-2-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1590133861-25515-1-git-send-email-yangtiezhu@loongson.cn>
References: <1590133861-25515-1-git-send-email-yangtiezhu@loongson.cn>
X-CM-TRANSID: AQAAf9Dx72plhMdeCME3AA--.75S3
X-Coremail-Antispam: 1UD129KBjvdXoWruw18Zw1xXFykWw1kuFWxWFg_yoWfXrX_Aw
        4rur1fXFW0kr1Fvw1jkw43Z342kanY9rn7uan0qa9xA34UWryIgryqywnxJrs8Aw45GFZx
        Ka4DAFZxu3yfCjkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbSAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGwA2048vs2IY02
        0Ec7CjxVAFwI0_Jrv_JF4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84
        ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AI
        xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
        vE14v26r126r1DMcIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
        r2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVAFwVW8CwCF04k20x
        vY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I
        3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIx
        AIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAI
        cVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2js
        IEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUSeHDUUUUU=
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When call function devm_platform_ioremap_resource(), we should use IS_ERR()
to check the return value and return PTR_ERR() if failed.

Fixes: 096030e7f449 ("nvmem: sprd: Add Spreadtrum SoCs eFuse support")
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 drivers/nvmem/sprd-efuse.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvmem/sprd-efuse.c b/drivers/nvmem/sprd-efuse.c
index 925feb2..5952324 100644
--- a/drivers/nvmem/sprd-efuse.c
+++ b/drivers/nvmem/sprd-efuse.c
@@ -378,8 +378,8 @@ static int sprd_efuse_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	efuse->base = devm_platform_ioremap_resource(pdev, 0);
-	if (!efuse->base)
-		return -ENOMEM;
+	if (IS_ERR(efuse->base))
+		return PTR_ERR(efuse->base);
 
 	ret = of_hwspin_lock_get_id(np, 0);
 	if (ret < 0) {
-- 
2.1.0

