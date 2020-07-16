Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1A0BC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 09:03:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4A332071B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 09:03:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728445AbgGPJDD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 05:03:03 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:54260 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728349AbgGPJDC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 05:03:02 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 6B75115B7A521A036300;
        Thu, 16 Jul 2020 17:03:01 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Thu, 16 Jul 2020 17:02:58 +0800
From:   Qinglang Miao <miaoqinglang@huawei.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rich Felker <dalias@libc.org>
CC:     <linux-sh@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] sh: Convert to DEFINE_SHOW_ATTRIBUTE
Date:   Thu, 16 Jul 2020 17:06:53 +0800
Message-ID: <20200716090653.14256-1-miaoqinglang@huawei.com>
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

From: Chen Huang <chenhuang5@huawei.com>

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Chen Huang <chenhuang5@huawei.com>
---
 arch/sh/mm/asids-debugfs.c | 15 ++-------------
 arch/sh/mm/cache-debugfs.c | 15 ++-------------
 arch/sh/mm/pmb.c           | 15 ++-------------
 3 files changed, 6 insertions(+), 39 deletions(-)

diff --git a/arch/sh/mm/asids-debugfs.c b/arch/sh/mm/asids-debugfs.c
index 065519ba6..d16d6f5ec 100644
--- a/arch/sh/mm/asids-debugfs.c
+++ b/arch/sh/mm/asids-debugfs.c
@@ -26,7 +26,7 @@
 #include <asm/processor.h>
 #include <asm/mmu_context.h>
 
-static int asids_seq_show(struct seq_file *file, void *iter)
+static int asids_debugfs_show(struct seq_file *file, void *iter)
 {
 	struct task_struct *p;
 
@@ -48,18 +48,7 @@ static int asids_seq_show(struct seq_file *file, void *iter)
 	return 0;
 }
 
-static int asids_debugfs_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, asids_seq_show, inode->i_private);
-}
-
-static const struct file_operations asids_debugfs_fops = {
-	.owner		= THIS_MODULE,
-	.open		= asids_debugfs_open,
-	.read_iter		= seq_read_iter,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(asids_debugfs);
 
 static int __init asids_debugfs_init(void)
 {
diff --git a/arch/sh/mm/cache-debugfs.c b/arch/sh/mm/cache-debugfs.c
index 114085cd5..b0f185169 100644
--- a/arch/sh/mm/cache-debugfs.c
+++ b/arch/sh/mm/cache-debugfs.c
@@ -22,7 +22,7 @@ enum cache_type {
 	CACHE_TYPE_UNIFIED,
 };
 
-static int cache_seq_show(struct seq_file *file, void *iter)
+static int cache_debugfs_show(struct seq_file *file, void *iter)
 {
 	unsigned int cache_type = (unsigned int)file->private;
 	struct cache_info *cache;
@@ -94,18 +94,7 @@ static int cache_seq_show(struct seq_file *file, void *iter)
 	return 0;
 }
 
-static int cache_debugfs_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, cache_seq_show, inode->i_private);
-}
-
-static const struct file_operations cache_debugfs_fops = {
-	.owner		= THIS_MODULE,
-	.open		= cache_debugfs_open,
-	.read_iter		= seq_read_iter,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(cache_debugfs);
 
 static int __init cache_debugfs_init(void)
 {
diff --git a/arch/sh/mm/pmb.c b/arch/sh/mm/pmb.c
index 1944c412f..68eb7cc6e 100644
--- a/arch/sh/mm/pmb.c
+++ b/arch/sh/mm/pmb.c
@@ -812,7 +812,7 @@ bool __in_29bit_mode(void)
         return (__raw_readl(PMB_PASCR) & PASCR_SE) == 0;
 }
 
-static int pmb_seq_show(struct seq_file *file, void *iter)
+static int pmb_debugfs_show(struct seq_file *file, void *iter)
 {
 	int i;
 
@@ -846,18 +846,7 @@ static int pmb_seq_show(struct seq_file *file, void *iter)
 	return 0;
 }
 
-static int pmb_debugfs_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, pmb_seq_show, NULL);
-}
-
-static const struct file_operations pmb_debugfs_fops = {
-	.owner		= THIS_MODULE,
-	.open		= pmb_debugfs_open,
-	.read_iter		= seq_read_iter,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(pmb_debugfs);
 
 static int __init pmb_debugfs_init(void)
 {
-- 
2.17.1

