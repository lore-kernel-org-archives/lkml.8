Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0E11C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 09:49:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C23AB2467D
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 09:49:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbgCJJtu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 05:49:50 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33126 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbgCJJtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 05:49:50 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jBbW9-0003Hx-L0; Tue, 10 Mar 2020 10:49:41 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 3B7871C21F0;
        Tue, 10 Mar 2020 10:49:41 +0100 (CET)
Date:   Tue, 10 Mar 2020 09:49:40 -0000
From:   "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/mce/dev-mcelog: Dynamically allocate space for
 machine check records
Cc:     Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@suse.de>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200218184408.GA23048@agluck-desk2.amr.corp.intel.com>
References: <20200218184408.GA23048@agluck-desk2.amr.corp.intel.com>
MIME-Version: 1.0
Message-ID: <158383378084.28353.4530898474579093158.tip-bot2@tip-bot2>
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

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     d8ecca4043f2d9d89daab7915eca8c2ec6254d0f
Gitweb:        https://git.kernel.org/tip/d8ecca4043f2d9d89daab7915eca8c2ec6254d0f
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Tue, 18 Feb 2020 10:44:08 -08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 10 Mar 2020 10:25:14 +01:00

x86/mce/dev-mcelog: Dynamically allocate space for machine check records

We have had a hard coded limit of 32 machine check records since the
dawn of time.  But as numbers of cores increase, it is possible for
more than 32 errors to be reported before a user process reads from
/dev/mcelog. In this case the additional errors are lost.

Keep 32 as the minimum. But tune the maximum value up based on the
number of processors.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200218184408.GA23048@agluck-desk2.amr.corp.intel.com
---
 arch/x86/include/asm/mce.h           |  6 +--
 arch/x86/kernel/cpu/mce/dev-mcelog.c | 47 +++++++++++++++------------
 2 files changed, 30 insertions(+), 23 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index 4359b95..9d5b099 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -102,7 +102,7 @@
 
 #define MCE_OVERFLOW 0		/* bit 0 in flags means overflow */
 
-#define MCE_LOG_LEN 32
+#define MCE_LOG_MIN_LEN 32U
 #define MCE_LOG_SIGNATURE	"MACHINECHECK"
 
 /* AMD Scalable MCA */
@@ -135,11 +135,11 @@
  */
 struct mce_log_buffer {
 	char signature[12]; /* "MACHINECHECK" */
-	unsigned len;	    /* = MCE_LOG_LEN */
+	unsigned len;	    /* = elements in .mce_entry[] */
 	unsigned next;
 	unsigned flags;
 	unsigned recordlen;	/* length of struct mce */
-	struct mce entry[MCE_LOG_LEN];
+	struct mce entry[];
 };
 
 enum mce_notifier_prios {
diff --git a/arch/x86/kernel/cpu/mce/dev-mcelog.c b/arch/x86/kernel/cpu/mce/dev-mcelog.c
index 7c8958d..d089567 100644
--- a/arch/x86/kernel/cpu/mce/dev-mcelog.c
+++ b/arch/x86/kernel/cpu/mce/dev-mcelog.c
@@ -29,11 +29,7 @@ static char *mce_helper_argv[2] = { mce_helper, NULL };
  * separate MCEs from kernel messages to avoid bogus bug reports.
  */
 
-static struct mce_log_buffer mcelog = {
-	.signature	= MCE_LOG_SIGNATURE,
-	.len		= MCE_LOG_LEN,
-	.recordlen	= sizeof(struct mce),
-};
+static struct mce_log_buffer *mcelog;
 
 static DECLARE_WAIT_QUEUE_HEAD(mce_chrdev_wait);
 
@@ -45,21 +41,21 @@ static int dev_mce_log(struct notifier_block *nb, unsigned long val,
 
 	mutex_lock(&mce_chrdev_read_mutex);
 
-	entry = mcelog.next;
+	entry = mcelog->next;
 
 	/*
 	 * When the buffer fills up discard new entries. Assume that the
 	 * earlier errors are the more interesting ones:
 	 */
-	if (entry >= MCE_LOG_LEN) {
-		set_bit(MCE_OVERFLOW, (unsigned long *)&mcelog.flags);
+	if (entry >= mcelog->len) {
+		set_bit(MCE_OVERFLOW, (unsigned long *)&mcelog->flags);
 		goto unlock;
 	}
 
-	mcelog.next = entry + 1;
+	mcelog->next = entry + 1;
 
-	memcpy(mcelog.entry + entry, mce, sizeof(struct mce));
-	mcelog.entry[entry].finished = 1;
+	memcpy(mcelog->entry + entry, mce, sizeof(struct mce));
+	mcelog->entry[entry].finished = 1;
 
 	/* wake processes polling /dev/mcelog */
 	wake_up_interruptible(&mce_chrdev_wait);
@@ -214,21 +210,21 @@ static ssize_t mce_chrdev_read(struct file *filp, char __user *ubuf,
 
 	/* Only supports full reads right now */
 	err = -EINVAL;
-	if (*off != 0 || usize < MCE_LOG_LEN*sizeof(struct mce))
+	if (*off != 0 || usize < mcelog->len * sizeof(struct mce))
 		goto out;
 
-	next = mcelog.next;
+	next = mcelog->next;
 	err = 0;
 
 	for (i = 0; i < next; i++) {
-		struct mce *m = &mcelog.entry[i];
+		struct mce *m = &mcelog->entry[i];
 
 		err |= copy_to_user(buf, m, sizeof(*m));
 		buf += sizeof(*m);
 	}
 
-	memset(mcelog.entry, 0, next * sizeof(struct mce));
-	mcelog.next = 0;
+	memset(mcelog->entry, 0, next * sizeof(struct mce));
+	mcelog->next = 0;
 
 	if (err)
 		err = -EFAULT;
@@ -242,7 +238,7 @@ out:
 static __poll_t mce_chrdev_poll(struct file *file, poll_table *wait)
 {
 	poll_wait(file, &mce_chrdev_wait, wait);
-	if (READ_ONCE(mcelog.next))
+	if (READ_ONCE(mcelog->next))
 		return EPOLLIN | EPOLLRDNORM;
 	if (!mce_apei_read_done && apei_check_mce())
 		return EPOLLIN | EPOLLRDNORM;
@@ -261,13 +257,13 @@ static long mce_chrdev_ioctl(struct file *f, unsigned int cmd,
 	case MCE_GET_RECORD_LEN:
 		return put_user(sizeof(struct mce), p);
 	case MCE_GET_LOG_LEN:
-		return put_user(MCE_LOG_LEN, p);
+		return put_user(mcelog->len, p);
 	case MCE_GETCLEAR_FLAGS: {
 		unsigned flags;
 
 		do {
-			flags = mcelog.flags;
-		} while (cmpxchg(&mcelog.flags, flags, 0) != flags);
+			flags = mcelog->flags;
+		} while (cmpxchg(&mcelog->flags, flags, 0) != flags);
 
 		return put_user(flags, p);
 	}
@@ -339,8 +335,18 @@ static struct miscdevice mce_chrdev_device = {
 
 static __init int dev_mcelog_init_device(void)
 {
+	int mce_log_len;
 	int err;
 
+	mce_log_len = max(MCE_LOG_MIN_LEN, num_online_cpus());
+	mcelog = kzalloc(sizeof(*mcelog) + mce_log_len * sizeof(struct mce), GFP_KERNEL);
+	if (!mcelog)
+		return -ENOMEM;
+
+	strncpy(mcelog->signature, MCE_LOG_SIGNATURE, sizeof(mcelog->signature));
+	mcelog->len = mce_log_len;
+	mcelog->recordlen = sizeof(struct mce);
+
 	/* register character device /dev/mcelog */
 	err = misc_register(&mce_chrdev_device);
 	if (err) {
@@ -350,6 +356,7 @@ static __init int dev_mcelog_init_device(void)
 		else
 			pr_err("Unable to init device /dev/mcelog (rc: %d)\n", err);
 
+		kfree(mcelog);
 		return err;
 	}
 
