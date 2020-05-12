Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 982E6C54E8D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 15:19:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F8DE206D6
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 15:19:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730435AbgELPTH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 11:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbgELPTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 11:19:03 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A0F4C061A0E;
        Tue, 12 May 2020 08:19:03 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jYWgN-0007EM-Og; Tue, 12 May 2020 17:18:59 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 57A471C0475;
        Tue, 12 May 2020 17:18:59 +0200 (CEST)
Date:   Tue, 12 May 2020 15:18:59 -0000
From:   "tip-bot2 for Masami Hiramatsu" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/kprobes] kprobes: Lock kprobe_mutex while showing kprobe_blacklist
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200505134059.571125195@linutronix.de>
References: <20200505134059.571125195@linutronix.de>
MIME-Version: 1.0
Message-ID: <158929673928.390.10899451832905837154.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/kprobes branch of tip:

Commit-ID:     4fdd88877e5259dcc5e504dca449acc0324d71b9
Gitweb:        https://git.kernel.org/tip/4fdd88877e5259dcc5e504dca449acc0324d71b9
Author:        Masami Hiramatsu <mhiramat@kernel.org>
AuthorDate:    Thu, 26 Mar 2020 23:49:36 +09:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 12 May 2020 17:15:31 +02:00

kprobes: Lock kprobe_mutex while showing kprobe_blacklist

Lock kprobe_mutex while showing kprobe_blacklist to prevent updating the
kprobe_blacklist.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200505134059.571125195@linutronix.de

---
 kernel/kprobes.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 2625c24..570d608 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -2420,6 +2420,7 @@ static const struct file_operations debugfs_kprobes_operations = {
 /* kprobes/blacklist -- shows which functions can not be probed */
 static void *kprobe_blacklist_seq_start(struct seq_file *m, loff_t *pos)
 {
+	mutex_lock(&kprobe_mutex);
 	return seq_list_start(&kprobe_blacklist, *pos);
 }
 
@@ -2446,10 +2447,15 @@ static int kprobe_blacklist_seq_show(struct seq_file *m, void *v)
 	return 0;
 }
 
+static void kprobe_blacklist_seq_stop(struct seq_file *f, void *v)
+{
+	mutex_unlock(&kprobe_mutex);
+}
+
 static const struct seq_operations kprobe_blacklist_seq_ops = {
 	.start = kprobe_blacklist_seq_start,
 	.next  = kprobe_blacklist_seq_next,
-	.stop  = kprobe_seq_stop,	/* Reuse void function */
+	.stop  = kprobe_blacklist_seq_stop,
 	.show  = kprobe_blacklist_seq_show,
 };
 
