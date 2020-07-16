Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C66FC433EB
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 08:54:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EECAB20771
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 08:54:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726629AbgGPIyo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 04:54:44 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7759 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726013AbgGPIyn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 04:54:43 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 398F9A10BBD81C6EFCED;
        Thu, 16 Jul 2020 16:54:42 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.487.0; Thu, 16 Jul 2020 16:54:40 +0800
From:   Qinglang Miao <miaoqinglang@huawei.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>
CC:     <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] RAS/CEC: Convert to DEFINE_SHOW_ATTRIBUTE
Date:   Thu, 16 Jul 2020 16:58:34 +0800
Message-ID: <20200716085834.11484-1-miaoqinglang@huawei.com>
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

From: Yongqiang Liu <liuyongqiang13@huawei.com>

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Yongqiang Liu <liuyongqiang13@huawei.com>
---
 drivers/ras/cec.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/drivers/ras/cec.c b/drivers/ras/cec.c
index a992bb426..ed47b59e4 100644
--- a/drivers/ras/cec.c
+++ b/drivers/ras/cec.c
@@ -435,7 +435,7 @@ DEFINE_DEBUGFS_ATTRIBUTE(action_threshold_ops, u64_get, action_threshold_set, "%
 
 static const char * const bins[] = { "00", "01", "10", "11" };
 
-static int array_dump(struct seq_file *m, void *v)
+static int array_show(struct seq_file *m, void *v)
 {
 	struct ce_array *ca = &ce_arr;
 	int i;
@@ -467,18 +467,7 @@ static int array_dump(struct seq_file *m, void *v)
 	return 0;
 }
 
-static int array_open(struct inode *inode, struct file *filp)
-{
-	return single_open(filp, array_dump, NULL);
-}
-
-static const struct file_operations array_ops = {
-	.owner	 = THIS_MODULE,
-	.open	 = array_open,
-	.read_iter	 = seq_read_iter,
-	.llseek	 = seq_lseek,
-	.release = single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(array);
 
 static int __init create_debugfs_nodes(void)
 {
@@ -513,7 +502,7 @@ static int __init create_debugfs_nodes(void)
 		goto err;
 	}
 
-	array = debugfs_create_file("array", S_IRUSR, d, NULL, &array_ops);
+	array = debugfs_create_file("array", S_IRUSR, d, NULL, &array_fops);
 	if (!array) {
 		pr_warn("Error creating array debugfs node!\n");
 		goto err;
-- 
2.17.1

