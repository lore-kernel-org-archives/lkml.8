Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A63EDC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 07:19:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CD0C22B4D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 07:19:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbgGTHTk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 03:19:40 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:8331 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725815AbgGTHTj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 03:19:39 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id E8D1DB2296DD67E748DE;
        Mon, 20 Jul 2020 15:19:36 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Mon, 20 Jul 2020 15:19:27 +0800
From:   Kai Ye <yekai13@huawei.com>
To:     <linux-accelerators@lists.ozlabs.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <zhangfei.gao@linaro.org>
CC:     Kai Ye <yekai13@huawei.com>
Subject: [PATCH] uacce: fix some coding styles
Date:   Mon, 20 Jul 2020 15:18:43 +0800
Message-ID: <1595229523-14103-1-git-send-email-yekai13@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. add some parameter check.
2. delete some redundant code.
3. modify the module author information.

Signed-off-by: Kai Ye <yekai13@huawei.com>
Reviewed-by: Zhou Wang <wangzhou1@hisilicon.com>
---
 drivers/misc/uacce/uacce.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/drivers/misc/uacce/uacce.c b/drivers/misc/uacce/uacce.c
index 107028e..2e1af58 100644
--- a/drivers/misc/uacce/uacce.c
+++ b/drivers/misc/uacce/uacce.c
@@ -63,8 +63,12 @@ static long uacce_fops_unl_ioctl(struct file *filep,
 				 unsigned int cmd, unsigned long arg)
 {
 	struct uacce_queue *q = filep->private_data;
-	struct uacce_device *uacce = q->uacce;
+	struct uacce_device *uacce;
+
+	if (WARN_ON(!q))
+		return -EINVAL;
 
+	uacce = q->uacce;
 	switch (cmd) {
 	case UACCE_CMD_START_Q:
 		return uacce_start_queue(q);
@@ -206,11 +210,16 @@ static const struct vm_operations_struct uacce_vm_ops = {
 static int uacce_fops_mmap(struct file *filep, struct vm_area_struct *vma)
 {
 	struct uacce_queue *q = filep->private_data;
-	struct uacce_device *uacce = q->uacce;
-	struct uacce_qfile_region *qfr;
 	enum uacce_qfrt type = UACCE_MAX_REGION;
+	struct uacce_qfile_region *qfr;
+	struct uacce_device *uacce;
 	int ret = 0;
 
+	if (WARN_ON(!q))
+		return -EINVAL;
+
+	uacce = q->uacce;
+
 	if (vma->vm_pgoff < UACCE_MAX_REGION)
 		type = vma->vm_pgoff;
 	else
@@ -239,17 +248,6 @@ static int uacce_fops_mmap(struct file *filep, struct vm_area_struct *vma)
 
 	switch (type) {
 	case UACCE_QFRT_MMIO:
-		if (!uacce->ops->mmap) {
-			ret = -EINVAL;
-			goto out_with_lock;
-		}
-
-		ret = uacce->ops->mmap(q, vma, qfr);
-		if (ret)
-			goto out_with_lock;
-
-		break;
-
 	case UACCE_QFRT_DUS:
 		if (!uacce->ops->mmap) {
 			ret = -EINVAL;
@@ -541,5 +539,5 @@ subsys_initcall(uacce_init);
 module_exit(uacce_exit);
 
 MODULE_LICENSE("GPL");
-MODULE_AUTHOR("Hisilicon Tech. Co., Ltd.");
+MODULE_AUTHOR("HiSilicon Tech. Co., Ltd.");
 MODULE_DESCRIPTION("Accelerator interface for Userland applications");
-- 
2.8.1

