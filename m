Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92ECFC47254
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 15:06:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C67320721
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 15:06:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Wovy85Nu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729571AbgEDPGx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 11:06:53 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:53526 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729055AbgEDPGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 11:06:53 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 044En94t024657;
        Mon, 4 May 2020 15:06:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=TsfNA6aorPpafB8fClYecJanumAnNS8Ljhz97+DWLfM=;
 b=Wovy85NuyHmmWJoauriI36ih1f7o8Ert7+xdsH6Zch/sMmwRlCbUOvbMDctNouZ17f0H
 cv+14keFS1whMe9xfLtUT8dzbcSfDsRMIxC5CWik/kzekWxcKQn3YVzEI0rEaOQAZZWL
 4TaI0pY3Rvj0b6/yHtSh9OoN1KtWFf+8Y/8mvom+FGkeWbWf1asMuafQUhkQfG7pKWCV
 g26cawiO9uaiA5zq5d9HGMVhl7oX8O8QUPiI4iFf5Mw03lIdaFoR+tgCOhVzqMpELeiK
 RvSZSi0ps9aY/skd/1ZftQtyKFnFmaKG8QXvW3da01F5sRObIURqM3OvSvoWncOBnCaG SQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 30s0tm7f91-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 May 2020 15:06:28 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 044Eke6u094674;
        Mon, 4 May 2020 15:04:28 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 30sjdqqp38-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 May 2020 15:04:28 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 044F4PfF025248;
        Mon, 4 May 2020 15:04:26 GMT
Received: from linux-1.home.com (/10.175.9.166)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 04 May 2020 08:04:25 -0700
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        x86@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     pbonzini@redhat.com, konrad.wilk@oracle.com,
        jan.setjeeilers@oracle.com, liran.alon@oracle.com,
        junaids@google.com, graf@amazon.de, rppt@linux.vnet.ibm.com,
        kuzuno@gmail.com, mgross@linux.intel.com,
        alexandre.chartre@oracle.com
Subject: [RFC v4][PATCH part-3 05/14] asidrv: Sequence to test interrupt on ASI
Date:   Mon,  4 May 2020 17:02:26 +0200
Message-Id: <20200504150235.12171-6-alexandre.chartre@oracle.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20200504150235.12171-1-alexandre.chartre@oracle.com>
References: <20200504150235.12171-1-alexandre.chartre@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9610 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 mlxscore=0
 bulkscore=0 adultscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005040123
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9610 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 suspectscore=0
 phishscore=0 clxscore=1015 bulkscore=0 mlxlogscore=999 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005040123
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a sequence to test if an ASI remains active after receiving
an interrupt.

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
---
 drivers/staging/asi/asidrv.c | 144 +++++++++++++++++++++++++++++++++--
 drivers/staging/asi/asidrv.h |   5 ++
 2 files changed, 144 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/asi/asidrv.c b/drivers/staging/asi/asidrv.c
index 4231b56db167..a3c7da2bf16e 100644
--- a/drivers/staging/asi/asidrv.c
+++ b/drivers/staging/asi/asidrv.c
@@ -7,6 +7,7 @@
 #include <linux/miscdevice.h>
 #include <linux/module.h>
 #include <linux/slab.h>
+#include <linux/workqueue.h>
 
 #include <asm/asi.h>
 #include <asm/dpt.h>
@@ -19,6 +20,12 @@
 /* Number of read for mem/memmap test sequence */
 #define ASIDRV_MEM_READ_COUNT		1000
 
+/* Timeout for target to be ready to receive an interrupt */
+#define ASIDRV_TIMEOUT_TARGET_READY	1
+
+/* Timeout for receiving an interrupt */
+#define ASIDRV_TIMEOUT_INTERRUPT	5
+
 enum asidrv_state {
 	ASIDRV_STATE_NONE,
 	ASIDRV_STATE_INTR_WAITING,
@@ -29,6 +36,13 @@ struct asidrv_test {
 	struct asi		*asi;	/* ASI for testing */
 	struct dpt		*dpt;	/* ASI decorated page-table */
 	char			*buffer; /* buffer for testing */
+
+	/* runtime */
+	atomic_t		state;	/* runtime state */
+	int			cpu;	/* cpu the test is running on */
+	struct work_struct	work;	/* work for other cpu */
+	bool			work_set;
+	enum asidrv_run_error	run_error;
 };
 
 struct asidrv_sequence {
@@ -160,6 +174,107 @@ static int asidrv_asi_is_active(struct asi *asi)
 	return false;
 }
 
+/*
+ * Wait for an atomic value to be set or the timeout to expire.
+ * Return 0 if the value is set, or -1 if the timeout expires.
+ */
+static enum asidrv_run_error asidrv_wait(struct asidrv_test *test,
+					 int value, unsigned int timeout)
+{
+	cycles_t start = get_cycles();
+	cycles_t stop = start + timeout * tsc_khz * 1000;
+
+	while (get_cycles() < stop) {
+		if (atomic_read(&test->state) == value ||
+		    test->run_error != ASIDRV_RUN_ERR_NONE)
+			return test->run_error;
+		cpu_relax();
+	}
+
+	/* timeout reached */
+	return ASIDRV_RUN_ERR_TIMEOUT;
+}
+
+/*
+ * Wait for an atomic value to transition from the initial value (set
+ * on entry) to the final value, or to timeout. Return 0 if the transition
+ * was done, or -1 if the timeout expires.
+ */
+static enum asidrv_run_error asidrv_wait_transition(struct asidrv_test *test,
+						    int initial, int final,
+						    unsigned int timeout)
+{
+	/* set the initial state value */
+	atomic_set(&test->state, initial);
+
+	/* do an active wait for the state changes */
+	return asidrv_wait(test, final, timeout);
+}
+
+/*
+ * Interrupt Test Sequence
+ */
+
+static void asidrv_intr_handler(void *info)
+{
+	struct asidrv_test *test = info;
+
+	/* ASI should be interrupted by the interrupt */
+	if (asidrv_asi_is_active(test->asi)) {
+		test->run_error = ASIDRV_RUN_ERR_INTR_ASI_ACTIVE;
+		atomic_set(&test->state, ASIDRV_STATE_INTR_RECEIVED);
+		return;
+	}
+
+	pr_debug("Received interrupt\n");
+	atomic_set(&test->state, ASIDRV_STATE_INTR_RECEIVED);
+}
+
+static void asidrv_intr_send(struct work_struct *work)
+{
+	struct asidrv_test *test = container_of(work, struct asidrv_test, work);
+	enum asidrv_run_error err;
+
+	/* wait for cpu target to be ready, then send an interrupt */
+	err = asidrv_wait(test,
+			  ASIDRV_STATE_INTR_WAITING,
+			  ASIDRV_TIMEOUT_TARGET_READY);
+	if (err) {
+		pr_debug("Target cpu %d not ready, interrupt not sent: error %d\n",
+			 test->cpu, err);
+		return;
+	}
+
+	pr_debug("Sending interrupt to cpu %d\n", test->cpu);
+	smp_call_function_single(test->cpu, asidrv_intr_handler,
+				 test, false);
+}
+
+static enum asidrv_run_error asidrv_intr_setup(struct asidrv_test *test)
+{
+	/* set work to have another cpu to send us an interrupt */
+	INIT_WORK(&test->work, asidrv_intr_send);
+	test->work_set = true;
+	return ASIDRV_RUN_ERR_NONE;
+}
+
+static enum asidrv_run_error asidrv_intr_run(struct asidrv_test *test)
+{
+	enum asidrv_run_error err;
+
+	/* wait for state changes indicating that an interrupt was received */
+	err = asidrv_wait_transition(test,
+				     ASIDRV_STATE_INTR_WAITING,
+				     ASIDRV_STATE_INTR_RECEIVED,
+				     ASIDRV_TIMEOUT_INTERRUPT);
+	if (err == ASIDRV_RUN_ERR_TIMEOUT) {
+		pr_debug("Interrupt wait timeout\n");
+		err = ASIDRV_RUN_ERR_INTR;
+	}
+
+	return err;
+}
+
 /*
  * Memory Buffer Access Test Sequences
  */
@@ -231,12 +346,18 @@ struct asidrv_sequence asidrv_sequences[] = {
 		"memmap",
 		asidrv_memmap_setup, asidrv_mem_run, asidrv_memmap_cleanup,
 	},
+	[ASIDRV_SEQ_INTERRUPT] = {
+		"interrupt",
+		asidrv_intr_setup, asidrv_intr_run, NULL,
+	},
 };
 
 static enum asidrv_run_error asidrv_run_init(struct asidrv_test *test)
 {
 	int err;
 
+	test->run_error = ASIDRV_RUN_ERR_NONE;
+
 	/*
 	 * Map the current stack, we need it to enter ASI.
 	 */
@@ -272,18 +393,31 @@ static void asidrv_run_fini(struct asidrv_test *test)
 static enum asidrv_run_error asidrv_run_setup(struct asidrv_test *test,
 					      struct asidrv_sequence *sequence)
 {
-	int run_err = ASIDRV_RUN_ERR_NONE;
+	unsigned int other_cpu;
+	int run_err;
+
+	test->work_set = false;
 
 	if (sequence->setup) {
 		run_err = sequence->setup(test);
 		if (run_err)
-			goto failed;
+			return run_err;
 	}
 
-	return ASIDRV_RUN_ERR_NONE;
+	if (test->work_set) {
+		other_cpu = cpumask_any_but(cpu_online_mask, test->cpu);
+		if (other_cpu == test->cpu) {
+			pr_debug("Sequence %s requires an extra online cpu\n",
+				 sequence->name);
+			asidrv_run_cleanup(test, sequence);
+			return ASIDRV_RUN_ERR_NCPUS;
+		}
 
-failed:
-	return run_err;
+		atomic_set(&test->state, ASIDRV_STATE_NONE);
+		schedule_work_on(other_cpu, &test->work);
+	}
+
+	return ASIDRV_RUN_ERR_NONE;
 }
 
 static void asidrv_run_cleanup(struct asidrv_test *test,
diff --git a/drivers/staging/asi/asidrv.h b/drivers/staging/asi/asidrv.h
index 1e820cc64f13..8055d96a0058 100644
--- a/drivers/staging/asi/asidrv.h
+++ b/drivers/staging/asi/asidrv.h
@@ -10,6 +10,7 @@ enum asidrv_seqnum {
 	ASIDRV_SEQ_PRINTK,	/* printk sequence */
 	ASIDRV_SEQ_MEM,		/* access unmapped memory */
 	ASIDRV_SEQ_MEMMAP,	/* access mapped memory */
+	ASIDRV_SEQ_INTERRUPT,	/* interrupt sequence */
 };
 
 enum asidrv_run_error {
@@ -20,6 +21,10 @@ enum asidrv_run_error {
 	ASIDRV_RUN_ERR_ENTER,	/* failed to enter ASI */
 	ASIDRV_RUN_ERR_ACTIVE,	/* ASI is not active after entering ASI */
 	ASIDRV_RUN_ERR_MAP_BUFFER, /* failed to map buffer */
+	ASIDRV_RUN_ERR_NCPUS,	/* not enough active cpus */
+	ASIDRV_RUN_ERR_INTR,	/* no interrupt received */
+	ASIDRV_RUN_ERR_INTR_ASI_ACTIVE, /* ASI active in interrupt handler */
+	ASIDRV_RUN_ERR_TIMEOUT,
 };
 
 #define ASIDRV_IOCTL_RUN_SEQUENCE	_IOWR('a', 1, struct asidrv_run_param)
-- 
2.18.2

