Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B728BC47257
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 06:37:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A42F824953
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 06:37:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728972AbgEIGhB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 02:37:01 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4368 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728821AbgEIGhA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 02:37:00 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 2CBD2EC15A0DB5255038;
        Sat,  9 May 2020 14:36:58 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.487.0; Sat, 9 May 2020 14:36:49 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>
CC:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH 3/3] kernel: kprobes: Convert to use DEFINE_SEQ_ATTRIBUTE macro
Date:   Sat, 9 May 2020 14:40:31 +0800
Message-ID: <20200509064031.181091-4-wangkefeng.wang@huawei.com>
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

Cc: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 kernel/kprobes.c | 33 ++++++---------------------------
 1 file changed, 6 insertions(+), 27 deletions(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index ffbe03a45c16..f961f5b13f43 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -2398,24 +2398,14 @@ static int show_kprobe_addr(struct seq_file *pi, void *v)
 	return 0;
 }
 
-static const struct seq_operations kprobes_seq_ops = {
+static const struct seq_operations kprobes_sops = {
 	.start = kprobe_seq_start,
 	.next  = kprobe_seq_next,
 	.stop  = kprobe_seq_stop,
 	.show  = show_kprobe_addr
 };
 
-static int kprobes_open(struct inode *inode, struct file *filp)
-{
-	return seq_open(filp, &kprobes_seq_ops);
-}
-
-static const struct file_operations debugfs_kprobes_operations = {
-	.open           = kprobes_open,
-	.read           = seq_read,
-	.llseek         = seq_lseek,
-	.release        = seq_release,
-};
+DEFINE_SEQ_ATTRIBUTE(kprobes);
 
 /* kprobes/blacklist -- shows which functions can not be probed */
 static void *kprobe_blacklist_seq_start(struct seq_file *m, loff_t *pos)
@@ -2446,24 +2436,14 @@ static int kprobe_blacklist_seq_show(struct seq_file *m, void *v)
 	return 0;
 }
 
-static const struct seq_operations kprobe_blacklist_seq_ops = {
+static const struct seq_operations kprobe_blacklist_sops = {
 	.start = kprobe_blacklist_seq_start,
 	.next  = kprobe_blacklist_seq_next,
 	.stop  = kprobe_seq_stop,	/* Reuse void function */
 	.show  = kprobe_blacklist_seq_show,
 };
 
-static int kprobe_blacklist_open(struct inode *inode, struct file *filp)
-{
-	return seq_open(filp, &kprobe_blacklist_seq_ops);
-}
-
-static const struct file_operations debugfs_kprobe_blacklist_ops = {
-	.open           = kprobe_blacklist_open,
-	.read           = seq_read,
-	.llseek         = seq_lseek,
-	.release        = seq_release,
-};
+DEFINE_SEQ_ATTRIBUTE(kprobe_blacklist);
 
 static int arm_all_kprobes(void)
 {
@@ -2622,13 +2602,12 @@ static int __init debugfs_kprobe_init(void)
 
 	dir = debugfs_create_dir("kprobes", NULL);
 
-	debugfs_create_file("list", 0400, dir, NULL,
-			    &debugfs_kprobes_operations);
+	debugfs_create_file("list", 0400, dir, NULL, &kprobes_fops);
 
 	debugfs_create_file("enabled", 0600, dir, &value, &fops_kp);
 
 	debugfs_create_file("blacklist", 0400, dir, NULL,
-			    &debugfs_kprobe_blacklist_ops);
+			    &kprobe_blacklist_fops);
 
 	return 0;
 }
-- 
2.26.2

