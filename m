Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB5FEC34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 18:44:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3BA321D56
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 18:44:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbgBRSoL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 13:44:11 -0500
Received: from mga18.intel.com ([134.134.136.126]:59939 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726225AbgBRSoL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 13:44:11 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Feb 2020 10:44:10 -0800
X-IronPort-AV: E=Sophos;i="5.70,456,1574150400"; 
   d="scan'208";a="253813972"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.68])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Feb 2020 10:44:10 -0800
Date:   Tue, 18 Feb 2020 10:44:08 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] x86/mce: /dev/mcelog: Dynamically allocate space for
 machine check records
Message-ID: <20200218184408.GA23048@agluck-desk2.amr.corp.intel.com>
References: <20200208000551.11364-1-tony.luck@intel.com>
 <20200217204756.GE14426@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200217204756.GE14426@zn.tnic>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have had a hard coded limit of 32 machine check records since the
dawn of time.  But as numbers of cores increase, it is possible for
more than 32 errors to be reported before a user process reads from
/dev/mcelog. In this case the additional errors are lost.

Keep 32 as the minimum. But tune the maximum value up based on the
number of processors.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
v2: Fix comments from Boris
	1) Spaces around a multiply '*' operator
	2) Reverse Christmas tree order for local variables
	3) MCE_LOG_MIN_LEN need to be unsigned for use by max()
	4) Missing blank line

 arch/x86/include/asm/mce.h           |  6 ++--
 arch/x86/kernel/cpu/mce/dev-mcelog.c | 47 ++++++++++++++++------------
 2 files changed, 30 insertions(+), 23 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index 4359b955e0b7..9d5b09913ef3 100644
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
index 7c8958dee103..d089567a9ce8 100644
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
@@ -242,7 +238,7 @@ static ssize_t mce_chrdev_read(struct file *filp, char __user *ubuf,
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
 
-- 
2.21.1

