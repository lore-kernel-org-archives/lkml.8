Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEBCDC47257
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 15:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9A5720735
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 15:05:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="h4bL8Bul"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729455AbgEDPFH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 11:05:07 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:40750 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727815AbgEDPFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 11:05:05 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 044Elhhg024555;
        Mon, 4 May 2020 15:04:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=OTy8bFEepziAap9YJkk0SYeg/Bi8nvhGZOVavHSgpoA=;
 b=h4bL8BulIgg78eyOq3XCjR0Y17cD8h5dvBaIkIfEQvxPrpsafN/+zTpQppm+XXet/ZNm
 3y1rgnXZ0/QQZ49pjBq6XQWR5oIn+XoZxiR/HfTToSJ7Bt6Mj5TS1qRsNPykkQuhQuXW
 TSO3g9WD7yXJjviAj8aOqAhz8taVHKNt004Ma/NnMafYqk6pA6w+Yx+fKorymrG6Awz0
 6wMgVsZ9opuh3KzVTQ3RpQIQm3CYld65xqv9auT8pOJU1BtKRm4eJLYylOtlJOhbBcZ3
 vzNMtj9UGQlXNNH0+I2EMjg1jiORkHnwWfLwMdpgorkxxBxmU/H403Pk81dYS3XXioKW Lg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 30s1gmy9n0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 May 2020 15:04:40 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 044EkeFY094664;
        Mon, 4 May 2020 15:04:39 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 30sjdqqpwm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 May 2020 15:04:39 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 044F4bsX025389;
        Mon, 4 May 2020 15:04:37 GMT
Received: from linux-1.home.com (/10.175.9.166)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 04 May 2020 08:04:37 -0700
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        x86@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     pbonzini@redhat.com, konrad.wilk@oracle.com,
        jan.setjeeilers@oracle.com, liran.alon@oracle.com,
        junaids@google.com, graf@amazon.de, rppt@linux.vnet.ibm.com,
        kuzuno@gmail.com, mgross@linux.intel.com,
        alexandre.chartre@oracle.com
Subject: [RFC v4][PATCH part-3 08/14] asidrv: Sequence to test scheduling in/out with ASI
Date:   Mon,  4 May 2020 17:02:29 +0200
Message-Id: <20200504150235.12171-9-alexandre.chartre@oracle.com>
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

Add a sequence to test if an ASI remains active after it is
scheduled out and then scheduled back in.

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
---
 drivers/staging/asi/asidrv.c | 98 ++++++++++++++++++++++++++++++++++++
 drivers/staging/asi/asidrv.h |  2 +
 2 files changed, 100 insertions(+)

diff --git a/drivers/staging/asi/asidrv.c b/drivers/staging/asi/asidrv.c
index e08f2a107e89..9ca17e0b654e 100644
--- a/drivers/staging/asi/asidrv.c
+++ b/drivers/staging/asi/asidrv.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/fs.h>
+#include <linux/kthread.h>
 #include <linux/miscdevice.h>
 #include <linux/module.h>
 #include <linux/nmi.h>
@@ -21,17 +22,24 @@
 /* Number of read for mem/memmap test sequence */
 #define ASIDRV_MEM_READ_COUNT		1000
 
+/* Number of loop for the sched test sequence */
+#define ASIDRV_SCHED_LOOP_COUNT		20
+
 /* Timeout for target to be ready to receive an interrupt or NMI */
 #define ASIDRV_TIMEOUT_TARGET_READY	1
 
 /* Timeout for receiving an interrupt or NMI */
 #define ASIDRV_TIMEOUT_INTERRUPT	5
 
+/* Timeout before thread can start its job */
+#define ASIDRV_TIMEOUT_THREAD_START	5
+
 /* NMI handler name used for testing */
 #define ASIDRV_NMI_HANDLER_NAME		"ASI Test"
 
 enum asidrv_state {
 	ASIDRV_STATE_NONE,
+	ASIDRV_STATE_START,
 	ASIDRV_STATE_INTR_WAITING,
 	ASIDRV_STATE_INTR_RECEIVED,
 	ASIDRV_STATE_NMI_WAITING,
@@ -50,6 +58,8 @@ struct asidrv_test {
 	bool			work_set;
 	enum asidrv_run_error	run_error;
 	bool			intrnmi;
+	struct task_struct	*kthread; /* work on same cpu */
+	int			count;
 };
 
 struct asidrv_sequence {
@@ -438,6 +448,66 @@ static enum asidrv_run_error asidrv_intrnmi_run(struct asidrv_test *test)
 	return err;
 }
 
+/*
+ * Sched Test Sequence
+ */
+
+static void asidrv_sched_loop(struct asidrv_test *test)
+{
+	int last_count = 0;
+
+	while (test->count < ASIDRV_SCHED_LOOP_COUNT) {
+		test->count++;
+		last_count = test->count;
+		/*
+		 * Call into the scheduler, until it runs the other
+		 * asidrv_sched_loop() task. We know it has run when
+		 * test->count changes.
+		 */
+		while (last_count == test->count)
+			schedule();
+	}
+	test->count++;
+}
+
+static int asidrv_sched_kthread(void *data)
+{
+	struct asidrv_test *test = data;
+	enum asidrv_run_error err;
+
+	err = asidrv_wait(test, ASIDRV_STATE_START,
+			  ASIDRV_TIMEOUT_THREAD_START);
+	if (err) {
+		pr_debug("Error waiting for start state: error %d\n", err);
+		return err;
+	}
+	asidrv_sched_loop(test);
+
+	return 0;
+}
+
+static enum asidrv_run_error asidrv_sched_init(struct asidrv_test *test)
+{
+	test->kthread = kthread_create_on_node(asidrv_sched_kthread, test,
+					       cpu_to_node(test->cpu),
+					       "sched test");
+	if (!test->kthread)
+		return ASIDRV_RUN_ERR_KTHREAD;
+
+	kthread_bind(test->kthread, test->cpu);
+	test->count = 0;
+
+	return ASIDRV_RUN_ERR_NONE;
+}
+
+static enum asidrv_run_error asidrv_sched_run(struct asidrv_test *test)
+{
+	atomic_set(&test->state, ASIDRV_STATE_START);
+	asidrv_sched_loop(test);
+
+	return ASIDRV_RUN_ERR_NONE;
+}
+
 /*
  * Memory Buffer Access Test Sequences
  */
@@ -521,14 +591,28 @@ struct asidrv_sequence asidrv_sequences[] = {
 		"intr+nmi",
 		asidrv_intrnmi_setup, asidrv_intrnmi_run, asidrv_nmi_cleanup,
 	},
+	[ASIDRV_SEQ_SCHED] = {
+		"sched",
+		asidrv_sched_init, asidrv_sched_run, NULL,
+	},
 };
 
 static enum asidrv_run_error asidrv_run_init(struct asidrv_test *test)
 {
+	cpumask_t mask = CPU_MASK_NONE;
 	int err;
 
 	test->run_error = ASIDRV_RUN_ERR_NONE;
 
+	/*
+	 * Binding ourself to the current cpu but keep preemption
+	 * enabled.
+	 */
+	test->cpu = get_cpu();
+	cpumask_set_cpu(test->cpu, &mask);
+	set_cpus_allowed_ptr(current, &mask);
+	put_cpu();
+
 	/*
 	 * Map the current stack, we need it to enter ASI.
 	 */
@@ -589,12 +673,26 @@ static enum asidrv_run_error asidrv_run_setup(struct asidrv_test *test,
 		schedule_work_on(other_cpu, &test->work);
 	}
 
+	if (test->kthread)
+		wake_up_process(test->kthread);
+
 	return ASIDRV_RUN_ERR_NONE;
 }
 
 static void asidrv_run_cleanup(struct asidrv_test *test,
 			       struct asidrv_sequence *sequence)
 {
+	if (test->kthread) {
+		kthread_stop(test->kthread);
+		test->kthread = NULL;
+	}
+
+	if (test->work_set) {
+		/* ensure work has completed */
+		flush_work(&test->work);
+		test->work_set = false;
+	}
+
 	if (sequence->cleanup)
 		sequence->cleanup(test);
 }
diff --git a/drivers/staging/asi/asidrv.h b/drivers/staging/asi/asidrv.h
index de9f7ad993e0..9f540b119883 100644
--- a/drivers/staging/asi/asidrv.h
+++ b/drivers/staging/asi/asidrv.h
@@ -13,6 +13,7 @@ enum asidrv_seqnum {
 	ASIDRV_SEQ_INTERRUPT,	/* interrupt sequence */
 	ASIDRV_SEQ_NMI,		/* NMI interrupt sequence */
 	ASIDRV_SEQ_INTRNMI,	/* NMI in interrupt sequence */
+	ASIDRV_SEQ_SCHED,	/* schedule() sequence */
 };
 
 enum asidrv_run_error {
@@ -30,6 +31,7 @@ enum asidrv_run_error {
 	ASIDRV_RUN_ERR_NMI,	/* no NMI received */
 	ASIDRV_RUN_ERR_NMI_REG,	/* failed to register NMI handler */
 	ASIDRV_RUN_ERR_NMI_ASI_ACTIVE, /* ASI active in NMI handler */
+	ASIDRV_RUN_ERR_KTHREAD,	/* failed to create kernel thread */
 };
 
 #define ASIDRV_IOCTL_RUN_SEQUENCE	_IOWR('a', 1, struct asidrv_run_param)
-- 
2.18.2

