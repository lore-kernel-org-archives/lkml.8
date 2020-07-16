Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B637BC433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 08:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BD7C2074B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 08:52:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728391AbgGPIwz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 04:52:55 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:40462 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726837AbgGPIwz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 04:52:55 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 215AE7860A1264D70A90;
        Thu, 16 Jul 2020 16:52:53 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Thu, 16 Jul 2020 16:52:50 +0800
From:   Qinglang Miao <miaoqinglang@huawei.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Santosh Shilimkar <ssantosh@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH -next] soc: ti: Convert to DEFINE_SHOW_ATTRIBUTE
Date:   Thu, 16 Jul 2020 16:56:45 +0800
Message-ID: <20200716085645.10851-1-miaoqinglang@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
---
 drivers/soc/ti/knav_dma.c        | 16 +++-------------
 drivers/soc/ti/knav_qmss_queue.c | 14 ++------------
 2 files changed, 5 insertions(+), 25 deletions(-)

diff --git a/drivers/soc/ti/knav_dma.c b/drivers/soc/ti/knav_dma.c
index fa6bb14f8..8c863ecb1 100644
--- a/drivers/soc/ti/knav_dma.c
+++ b/drivers/soc/ti/knav_dma.c
@@ -355,7 +355,7 @@ static void dma_debug_show_devices(struct seq_file *s,
 	}
 }
 
-static int dma_debug_show(struct seq_file *s, void *v)
+static int knav_dma_debug_show(struct seq_file *s, void *v)
 {
 	struct knav_dma_device *dma;
 
@@ -370,17 +370,7 @@ static int dma_debug_show(struct seq_file *s, void *v)
 	return 0;
 }
 
-static int knav_dma_debug_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, dma_debug_show, NULL);
-}
-
-static const struct file_operations knav_dma_debug_ops = {
-	.open		= knav_dma_debug_open,
-	.read_iter		= seq_read_iter,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(knav_dma_debug);
 
 static int of_channel_match_helper(struct device_node *np, const char *name,
 					const char **dma_instance)
@@ -778,7 +768,7 @@ static int knav_dma_probe(struct platform_device *pdev)
 	}
 
 	debugfs_create_file("knav_dma", S_IFREG | S_IRUGO, NULL, NULL,
-			    &knav_dma_debug_ops);
+			    &knav_dma_debug_fops);
 
 	device_ready = true;
 	return ret;
diff --git a/drivers/soc/ti/knav_qmss_queue.c b/drivers/soc/ti/knav_qmss_queue.c
index 85702d66b..a460f201b 100644
--- a/drivers/soc/ti/knav_qmss_queue.c
+++ b/drivers/soc/ti/knav_qmss_queue.c
@@ -478,17 +478,7 @@ static int knav_queue_debug_show(struct seq_file *s, void *v)
 	return 0;
 }
 
-static int knav_queue_debug_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, knav_queue_debug_show, NULL);
-}
-
-static const struct file_operations knav_queue_debug_ops = {
-	.open		= knav_queue_debug_open,
-	.read_iter		= seq_read_iter,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(knav_queue_debug);
 
 static inline int knav_queue_pdsp_wait(u32 * __iomem addr, unsigned timeout,
 					u32 flags)
@@ -1878,7 +1868,7 @@ static int knav_queue_probe(struct platform_device *pdev)
 	}
 
 	debugfs_create_file("qmss", S_IFREG | S_IRUGO, NULL, NULL,
-			    &knav_queue_debug_ops);
+			    &knav_queue_debug_fops);
 	device_ready = true;
 	return 0;
 
-- 
2.17.1

