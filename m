Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98BEFC28CBC
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 06:37:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 722E024957
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 06:37:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728954AbgEIGhA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 02:37:00 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:41926 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728818AbgEIGhA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 02:37:00 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 5BA0419A4053DC75D8A2;
        Sat,  9 May 2020 14:36:58 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.487.0; Sat, 9 May 2020 14:36:48 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>
CC:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH 2/3] mm: vmstat: Convert to use DEFINE_SEQ_ATTRIBUTE macro
Date:   Sat, 9 May 2020 14:40:30 +0800
Message-ID: <20200509064031.181091-3-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200509064031.181091-1-wangkefeng.wang@huawei.com>
References: <20200509064031.181091-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEFINE_SEQ_ATTRIBUTE macro to simplify the code.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 mm/vmstat.c | 32 ++++++--------------------------
 1 file changed, 6 insertions(+), 26 deletions(-)

diff --git a/mm/vmstat.c b/mm/vmstat.c
index 7f2e87cb7049..35219271796f 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -2055,24 +2055,14 @@ static int unusable_show(struct seq_file *m, void *arg)
 	return 0;
 }
 
-static const struct seq_operations unusable_op = {
+static const struct seq_operations unusable_sops = {
 	.start	= frag_start,
 	.next	= frag_next,
 	.stop	= frag_stop,
 	.show	= unusable_show,
 };
 
-static int unusable_open(struct inode *inode, struct file *file)
-{
-	return seq_open(file, &unusable_op);
-}
-
-static const struct file_operations unusable_file_ops = {
-	.open		= unusable_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= seq_release,
-};
+DEFINE_SEQ_ATTRIBUTE(unusable);
 
 static void extfrag_show_print(struct seq_file *m,
 					pg_data_t *pgdat, struct zone *zone)
@@ -2107,24 +2097,14 @@ static int extfrag_show(struct seq_file *m, void *arg)
 	return 0;
 }
 
-static const struct seq_operations extfrag_op = {
+static const struct seq_operations extfrag_sops = {
 	.start	= frag_start,
 	.next	= frag_next,
 	.stop	= frag_stop,
 	.show	= extfrag_show,
 };
 
-static int extfrag_open(struct inode *inode, struct file *file)
-{
-	return seq_open(file, &extfrag_op);
-}
-
-static const struct file_operations extfrag_file_ops = {
-	.open		= extfrag_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= seq_release,
-};
+DEFINE_SEQ_ATTRIBUTE(extfrag);
 
 static int __init extfrag_debug_init(void)
 {
@@ -2133,10 +2113,10 @@ static int __init extfrag_debug_init(void)
 	extfrag_debug_root = debugfs_create_dir("extfrag", NULL);
 
 	debugfs_create_file("unusable_index", 0444, extfrag_debug_root, NULL,
-			    &unusable_file_ops);
+			    &unusable_fops);
 
 	debugfs_create_file("extfrag_index", 0444, extfrag_debug_root, NULL,
-			    &extfrag_file_ops);
+			    &extfrag_fops);
 
 	return 0;
 }
-- 
2.26.2

