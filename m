Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9C5AC3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 15:04:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7824A206D7
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 15:04:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iLw7TQwZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729266AbgEDPEr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 11:04:47 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:40366 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728232AbgEDPEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 11:04:46 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 044Elhbi024556;
        Mon, 4 May 2020 15:04:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=yN7fiCPis1NfHiTjMfGSvpjx0uW8eE+ETSwTj0Wh6UE=;
 b=iLw7TQwZOW2TBPjxo/Dr44GRZ5X4dP/0Tq1yFGXZ9GFgF2aQbrHti8D7zNo0NhaQwiuF
 md2F6KfoWASy3w3V1l4Ia6F+md4uaZR1Z4NjivazpdONUi5btxjtdApZ82yFcLMbiAFJ
 TpKq62WQoW8yDkqv7NhJW6/Wvde/OMTSNJSItn+qNq4+6LtKKoKYo50zy2nAQSXEtmgx
 LQnM82168dsVlRbKa1WM8tGhHQ/cEPJ/tRyXv14bh4QnFA/+uJFYMtbw+fLl3IFYBCBS
 N7S4/Khv4ToQGetmxLDvWfGfS8rTJ03yGv0IpeJX1CEBYp/ei6wzwvYCoIweocJ+twBV sg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 30s1gmy9j7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 May 2020 15:04:19 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 044EkfBq094779;
        Mon, 4 May 2020 15:04:18 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 30sjdqqnbq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 May 2020 15:04:18 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 044F4Gmm028489;
        Mon, 4 May 2020 15:04:17 GMT
Received: from linux-1.home.com (/10.175.9.166)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 04 May 2020 08:04:16 -0700
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        x86@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     pbonzini@redhat.com, konrad.wilk@oracle.com,
        jan.setjeeilers@oracle.com, liran.alon@oracle.com,
        junaids@google.com, graf@amazon.de, rppt@linux.vnet.ibm.com,
        kuzuno@gmail.com, mgross@linux.intel.com,
        alexandre.chartre@oracle.com
Subject: [RFC v4][PATCH part-3 03/14] asidrv: Introduce the ASIDRV_IOCTL_RUN_SEQUENCE ioctl
Date:   Mon,  4 May 2020 17:02:24 +0200
Message-Id: <20200504150235.12171-4-alexandre.chartre@oracle.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20200504150235.12171-1-alexandre.chartre@oracle.com>
References: <20200504150235.12171-1-alexandre.chartre@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9610 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 mlxscore=0
 bulkscore=0 adultscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005040123
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9610 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 mlxscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 phishscore=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005040123
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ASIDRV_IOCTL_RUN_SEQUENCE ioctl runs a specified sequence with
the test ASI. The ioctl returns whether the run was successful or
not, and if the test ASI was active at the end of the run.

For now, two test sequences are implemented:
 - ASIDRV_SEQ_NOP does nothing but enters and exits the test ASI;
 - ASIDRV_SEQ_PRINTK calls printk while running with ASI.

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
---
 drivers/staging/asi/asidrv.c | 248 +++++++++++++++++++++++++++++++++++
 drivers/staging/asi/asidrv.h |  29 ++++
 2 files changed, 277 insertions(+)
 create mode 100644 drivers/staging/asi/asidrv.h

diff --git a/drivers/staging/asi/asidrv.c b/drivers/staging/asi/asidrv.c
index c06e4734e0e5..4f0548edb2f9 100644
--- a/drivers/staging/asi/asidrv.c
+++ b/drivers/staging/asi/asidrv.c
@@ -10,15 +10,28 @@
 
 #include <asm/asi.h>
 #include <asm/dpt.h>
+#include <asm/tlbflush.h>
+
+#include "asidrv.h"
 
 struct asidrv_test {
 	struct asi		*asi;	/* ASI for testing */
 	struct dpt		*dpt;	/* ASI decorated page-table */
 };
 
+struct asidrv_sequence {
+	const char *name;
+	enum asidrv_run_error (*setup)(struct asidrv_test *t);
+	enum asidrv_run_error (*run)(struct asidrv_test *t);
+	void (*cleanup)(struct asidrv_test *t);
+};
+
 static struct asidrv_test *asidrv_test;
 
 static void asidrv_test_destroy(struct asidrv_test *test);
+static void asidrv_run_fini(struct asidrv_test *test);
+static void asidrv_run_cleanup(struct asidrv_test *test,
+			       struct asidrv_sequence *sequence);
 
 static struct asidrv_test *asidrv_test_create(void)
 {
@@ -86,8 +99,243 @@ static void asidrv_test_destroy(struct asidrv_test *test)
 	kfree(test);
 }
 
+static int asidrv_asi_is_active(struct asi *asi)
+{
+	struct asi *current_asi;
+	unsigned long cr3;
+	bool is_active;
+	int idepth;
+
+	if (!asi)
+		return false;
+
+	current_asi = this_cpu_read(cpu_asi_session.asi);
+	if (current_asi == asi) {
+		idepth = this_cpu_read(cpu_asi_session.idepth);
+		is_active = (idepth == 0);
+	} else {
+		is_active = false;
+		if (current_asi) {
+			/* weird... another ASI is active! */
+			pr_debug("ASI %px is active (testing ASI = %px)\n",
+				 current_asi, asi);
+		}
+	}
+
+	/*
+	 * If the ASI is active check that the CR3 value is consistent with
+	 * this ASI being active. Otherwise, check that CR3 value doesn't
+	 * reference an ASI.
+	 */
+	cr3 = __native_read_cr3();
+	if (is_active) {
+		if ((cr3 ^ asi->base_cr3) >> ASI_PCID_PREFIX_SHIFT == 0)
+			return true;
+
+		pr_warn("ASI %px: active ASI has inconsistent CR3 value (cr3=%lx, ASI base=%lx)\n",
+			asi, cr3, asi->base_cr3);
+
+	} else if (cr3 & ASI_PCID_PREFIX_MASK) {
+		pr_warn("ASI %px: inactive ASI has inconsistent CR3 value (cr3=%lx, ASI base=%lx)\n",
+			asi, cr3, asi->base_cr3);
+	}
+
+	return false;
+}
+
+/*
+ * Printk Test Sequence
+ */
+static enum asidrv_run_error asidrv_printk_run(struct asidrv_test *test)
+{
+	pr_notice("asidrv printk test...\n");
+	return ASIDRV_RUN_ERR_NONE;
+}
+
+struct asidrv_sequence asidrv_sequences[] = {
+	[ASIDRV_SEQ_NOP] = {
+		"nop",
+		NULL, NULL, NULL,
+	},
+	[ASIDRV_SEQ_PRINTK] = {
+		"printk",
+		NULL, asidrv_printk_run, NULL,
+	},
+};
+
+static enum asidrv_run_error asidrv_run_init(struct asidrv_test *test)
+{
+	int err;
+
+	/*
+	 * Map the current stack, we need it to enter ASI.
+	 */
+	err = dpt_map(test->dpt, current->stack,
+		      PAGE_SIZE << THREAD_SIZE_ORDER);
+	if (err) {
+		asidrv_run_fini(test);
+		return ASIDRV_RUN_ERR_MAP_STACK;
+	}
+
+	/*
+	 * Map the current task, schedule() needs it.
+	 */
+	err = dpt_map(test->dpt, current, sizeof(struct task_struct));
+	if (err)
+		return ASIDRV_RUN_ERR_MAP_TASK;
+
+	/*
+	 * The ASI page-table has been updated so bump the generation
+	 * number to have the ASI TLB flushed.
+	 */
+	atomic64_inc(&test->asi->pgtable_gen);
+
+	return ASIDRV_RUN_ERR_NONE;
+}
+
+static void asidrv_run_fini(struct asidrv_test *test)
+{
+	dpt_unmap(test->dpt, current);
+	dpt_unmap(test->dpt, current->stack);
+}
+
+static enum asidrv_run_error asidrv_run_setup(struct asidrv_test *test,
+					      struct asidrv_sequence *sequence)
+{
+	int run_err = ASIDRV_RUN_ERR_NONE;
+
+	if (sequence->setup) {
+		run_err = sequence->setup(test);
+		if (run_err)
+			goto failed;
+	}
+
+	return ASIDRV_RUN_ERR_NONE;
+
+failed:
+	return run_err;
+}
+
+static void asidrv_run_cleanup(struct asidrv_test *test,
+			       struct asidrv_sequence *sequence)
+{
+	if (sequence->cleanup)
+		sequence->cleanup(test);
+}
+
+/*
+ * Run the specified sequence with ASI. Report result back.
+ */
+static enum asidrv_run_error asidrv_run(struct asidrv_test *test,
+					enum asidrv_seqnum seqnum,
+					bool *asi_active)
+{
+	struct asidrv_sequence *sequence = &asidrv_sequences[seqnum];
+	int run_err = ASIDRV_RUN_ERR_NONE;
+	int err = 0;
+
+	if (seqnum >= ARRAY_SIZE(asidrv_sequences)) {
+		pr_debug("Undefined sequence %d\n", seqnum);
+		return ASIDRV_RUN_ERR_SEQUENCE;
+	}
+
+	pr_debug("ASI running sequence %s\n", sequence->name);
+
+	run_err = asidrv_run_setup(test, sequence);
+	if (run_err)
+		return run_err;
+
+	err = asi_enter(test->asi);
+	if (err) {
+		run_err = ASIDRV_RUN_ERR_ENTER;
+		goto failed_noexit;
+	}
+
+	if (!asidrv_asi_is_active(test->asi)) {
+		run_err = ASIDRV_RUN_ERR_ACTIVE;
+		goto failed;
+	}
+
+	if (sequence->run) {
+		run_err = sequence->run(test);
+		if (run_err != ASIDRV_RUN_ERR_NONE)
+			goto failed;
+	}
+
+	*asi_active = asidrv_asi_is_active(test->asi);
+
+failed:
+	asi_exit(test->asi);
+
+failed_noexit:
+	asidrv_run_cleanup(test, sequence);
+
+	return run_err;
+}
+
+static int asidrv_ioctl_run_sequence(struct asidrv_test *test,
+				     unsigned long arg)
+{
+	struct asidrv_run_param __user *urparam;
+	struct asidrv_run_param rparam;
+	enum asidrv_run_error run_err;
+	enum asidrv_seqnum seqnum;
+	bool asi_active = false;
+
+	urparam = (struct asidrv_run_param *)arg;
+	if (copy_from_user(&rparam, urparam, sizeof(rparam)))
+		return -EFAULT;
+
+	seqnum = rparam.sequence;
+
+	pr_debug("ASI sequence %d\n", seqnum);
+
+	run_err = asidrv_run_init(test);
+	if (run_err) {
+		pr_debug("ASI run init error %d\n", run_err);
+		goto failed_nofini;
+	}
+
+	run_err = asidrv_run(test, seqnum, &asi_active);
+	if (run_err) {
+		pr_debug("ASI run error %d\n", run_err);
+	} else {
+		pr_debug("ASI run okay, ASI is %s\n",
+			 asi_active ? "active" : "inactive");
+	}
+
+	asidrv_run_fini(test);
+
+failed_nofini:
+	rparam.run_error = run_err;
+	rparam.asi_active = asi_active;
+
+	if (copy_to_user(urparam, &rparam, sizeof(rparam)))
+		return -EFAULT;
+
+	return 0;
+}
+
+static long asidrv_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
+{
+	struct asidrv_test *test = asidrv_test;
+
+	switch (cmd) {
+
+	/* Test ioctls */
+
+	case ASIDRV_IOCTL_RUN_SEQUENCE:
+		return asidrv_ioctl_run_sequence(test, arg);
+
+	default:
+		return -ENOTTY;
+	};
+}
+
 static const struct file_operations asidrv_fops = {
 	.owner		= THIS_MODULE,
+	.unlocked_ioctl	= asidrv_ioctl,
+	.compat_ioctl	= compat_ptr_ioctl,
 };
 
 static struct miscdevice asidrv_miscdev = {
diff --git a/drivers/staging/asi/asidrv.h b/drivers/staging/asi/asidrv.h
new file mode 100644
index 000000000000..33acb058c443
--- /dev/null
+++ b/drivers/staging/asi/asidrv.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
+
+#ifndef __ASIDRV_H__
+#define __ASIDRV_H__
+
+#include <linux/types.h>
+
+enum asidrv_seqnum {
+	ASIDRV_SEQ_NOP,		/* empty sequence */
+	ASIDRV_SEQ_PRINTK,	/* printk sequence */
+};
+
+enum asidrv_run_error {
+	ASIDRV_RUN_ERR_NONE,	/* no error */
+	ASIDRV_RUN_ERR_SEQUENCE, /* unknown sequence */
+	ASIDRV_RUN_ERR_MAP_STACK, /* failed to map current stack */
+	ASIDRV_RUN_ERR_MAP_TASK, /* failed to map current task */
+	ASIDRV_RUN_ERR_ENTER,	/* failed to enter ASI */
+	ASIDRV_RUN_ERR_ACTIVE,	/* ASI is not active after entering ASI */
+};
+
+#define ASIDRV_IOCTL_RUN_SEQUENCE	_IOWR('a', 1, struct asidrv_run_param)
+
+struct asidrv_run_param {
+	__u32 sequence;		/* sequence to run */
+	__u32 run_error;	/* result error after run */
+	__u32 asi_active;	/* ASI is active after run? */
+};
+#endif
-- 
2.18.2

