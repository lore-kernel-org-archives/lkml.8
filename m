Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 150A0C47259
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 15:05:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE803206D7
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 15:04:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="0EvFlkon"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729437AbgEDPE7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 11:04:59 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:51362 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727815AbgEDPE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 11:04:57 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 044EnCpH024792;
        Mon, 4 May 2020 15:04:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=KMhLfUUORB4hr0fqDKVZeX4aBmENNBKC3TwFFkS0PTg=;
 b=0EvFlkonA6jrCdVIfhf8VpmuuPLKTUpLjp5GSHIitz1iWFZNCN/pbdfltSTbdM9g0Mz5
 FNH9CFTV63gUajXq3WqdiWAb1UOq8FQIch9Ub5zYB368gLh3ZfcX45nhJk8QjQ7eMoyM
 ykQ3uh5toR5OCGwP9/wyx/U47s59vietCsEscjl2Cbp0Yw9xHwQHJrXSJKhkyHycYNCp
 zAaMXRWF/rGnaPuwY8IGnnFtpcSXLi+1NynclpB0IZ6gEOURUvYVOsaOsn+qE1vVNjCa
 5jjzfNCyNejYqUoa1CYhWJhd6zkfhvz+38X0lAnUGx81jfXAGEQhTXl8Jd9EUe3s4zLA Ng== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 30s0tm7eq0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 May 2020 15:04:32 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 044EmUe7105604;
        Mon, 4 May 2020 15:04:32 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 30sjjw1780-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 May 2020 15:04:31 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 044F4Tie004322;
        Mon, 4 May 2020 15:04:29 GMT
Received: from linux-1.home.com (/10.175.9.166)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 04 May 2020 08:04:29 -0700
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        x86@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     pbonzini@redhat.com, konrad.wilk@oracle.com,
        jan.setjeeilers@oracle.com, liran.alon@oracle.com,
        junaids@google.com, graf@amazon.de, rppt@linux.vnet.ibm.com,
        kuzuno@gmail.com, mgross@linux.intel.com,
        alexandre.chartre@oracle.com
Subject: [RFC v4][PATCH part-3 06/14] asidrv: Sequence to test NMI on ASI
Date:   Mon,  4 May 2020 17:02:27 +0200
Message-Id: <20200504150235.12171-7-alexandre.chartre@oracle.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20200504150235.12171-1-alexandre.chartre@oracle.com>
References: <20200504150235.12171-1-alexandre.chartre@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9610 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 phishscore=0
 bulkscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 adultscore=0
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
an NMI.

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
---
 drivers/staging/asi/asidrv.c | 116 ++++++++++++++++++++++++++++++++++-
 drivers/staging/asi/asidrv.h |   4 ++
 2 files changed, 118 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/asi/asidrv.c b/drivers/staging/asi/asidrv.c
index a3c7da2bf16e..8f964c9e0b14 100644
--- a/drivers/staging/asi/asidrv.c
+++ b/drivers/staging/asi/asidrv.c
@@ -6,6 +6,7 @@
 #include <linux/fs.h>
 #include <linux/miscdevice.h>
 #include <linux/module.h>
+#include <linux/nmi.h>
 #include <linux/slab.h>
 #include <linux/workqueue.h>
 
@@ -20,16 +21,21 @@
 /* Number of read for mem/memmap test sequence */
 #define ASIDRV_MEM_READ_COUNT		1000
 
-/* Timeout for target to be ready to receive an interrupt */
+/* Timeout for target to be ready to receive an interrupt or NMI */
 #define ASIDRV_TIMEOUT_TARGET_READY	1
 
-/* Timeout for receiving an interrupt */
+/* Timeout for receiving an interrupt or NMI */
 #define ASIDRV_TIMEOUT_INTERRUPT	5
 
+/* NMI handler name used for testing */
+#define ASIDRV_NMI_HANDLER_NAME		"ASI Test"
+
 enum asidrv_state {
 	ASIDRV_STATE_NONE,
 	ASIDRV_STATE_INTR_WAITING,
 	ASIDRV_STATE_INTR_RECEIVED,
+	ASIDRV_STATE_NMI_WAITING,
+	ASIDRV_STATE_NMI_RECEIVED,
 };
 
 struct asidrv_test {
@@ -53,6 +59,7 @@ struct asidrv_sequence {
 };
 
 static struct asidrv_test *asidrv_test;
+static struct asidrv_test *asidrv_nmi_target;
 
 static void asidrv_test_destroy(struct asidrv_test *test);
 static void asidrv_run_fini(struct asidrv_test *test);
@@ -211,6 +218,107 @@ static enum asidrv_run_error asidrv_wait_transition(struct asidrv_test *test,
 	return asidrv_wait(test, final, timeout);
 }
 
+/*
+ * NMI Test Sequence
+ */
+
+static int asidrv_nmi_handler(unsigned int val, struct pt_regs *regs)
+{
+	struct asidrv_test *test = asidrv_nmi_target;
+
+	if (!test)
+		return NMI_DONE;
+
+	/* ASI should be interrupted by the NMI */
+	if (asidrv_asi_is_active(test->asi)) {
+		test->run_error = ASIDRV_RUN_ERR_NMI_ASI_ACTIVE;
+		atomic_set(&test->state, ASIDRV_STATE_NMI_RECEIVED);
+		return NMI_HANDLED;
+	}
+
+	pr_debug("Received NMI\n");
+	atomic_set(&test->state, ASIDRV_STATE_NMI_RECEIVED);
+	asidrv_nmi_target = NULL;
+
+	return NMI_HANDLED;
+}
+
+static void asidrv_nmi_send(struct work_struct *work)
+{
+	struct asidrv_test *test = container_of(work, struct asidrv_test, work);
+	cpumask_t mask = CPU_MASK_NONE;
+	enum asidrv_run_error err;
+
+	cpumask_set_cpu(test->cpu, &mask);
+
+	/* wait for cpu target to be ready, then send an NMI */
+	err = asidrv_wait(test,
+			  ASIDRV_STATE_NMI_WAITING,
+			  ASIDRV_TIMEOUT_TARGET_READY);
+	if (err) {
+		pr_debug("Target cpu %d not ready, NMI not sent: error %d\n",
+			 test->cpu, err);
+		return;
+	}
+
+	pr_debug("Sending NMI to cpu %d\n", test->cpu);
+	asidrv_nmi_target = test;
+	/*
+	 * The value of asidrv_nmi_target should be set and propagated
+	 * before sending the IPI.
+	 */
+	wmb();
+	apic->send_IPI_mask(&mask, NMI_VECTOR);
+}
+
+static enum asidrv_run_error asidrv_nmi_setup(struct asidrv_test *test)
+{
+	int err;
+
+	err = register_nmi_handler(NMI_LOCAL, asidrv_nmi_handler,
+				   NMI_FLAG_FIRST,
+				   ASIDRV_NMI_HANDLER_NAME);
+	if (err) {
+		pr_debug("Failed to register NMI handler\n");
+		return ASIDRV_RUN_ERR_NMI_REG;
+	}
+
+	/* set work to have another cpu to send us an NMI */
+	INIT_WORK(&test->work, asidrv_nmi_send);
+
+	test->work_set = true;
+
+	return ASIDRV_RUN_ERR_NONE;
+}
+
+static void asidrv_nmi_cleanup(struct asidrv_test *test)
+{
+	unregister_nmi_handler(NMI_LOCAL, ASIDRV_NMI_HANDLER_NAME);
+}
+
+static enum asidrv_run_error asidrv_nmi_run(struct asidrv_test *test)
+{
+	enum asidrv_run_error err;
+	unsigned long flags;
+
+	/* disable interrupts as we want to be interrupted by an NMI */
+	local_irq_save(flags);
+
+	/* wait for state changes indicating that an NMI was received */
+	err = asidrv_wait_transition(test,
+				     ASIDRV_STATE_NMI_WAITING,
+				     ASIDRV_STATE_NMI_RECEIVED,
+				     ASIDRV_TIMEOUT_INTERRUPT);
+	if (err == ASIDRV_RUN_ERR_TIMEOUT) {
+		pr_debug("NMI wait timeout\n");
+		err = ASIDRV_RUN_ERR_NMI;
+	}
+
+	local_irq_restore(flags);
+
+	return err;
+}
+
 /*
  * Interrupt Test Sequence
  */
@@ -350,6 +458,10 @@ struct asidrv_sequence asidrv_sequences[] = {
 		"interrupt",
 		asidrv_intr_setup, asidrv_intr_run, NULL,
 	},
+	[ASIDRV_SEQ_NMI] = {
+		"nmi",
+		asidrv_nmi_setup, asidrv_nmi_run, asidrv_nmi_cleanup,
+	},
 };
 
 static enum asidrv_run_error asidrv_run_init(struct asidrv_test *test)
diff --git a/drivers/staging/asi/asidrv.h b/drivers/staging/asi/asidrv.h
index 8055d96a0058..6fac32d56f6f 100644
--- a/drivers/staging/asi/asidrv.h
+++ b/drivers/staging/asi/asidrv.h
@@ -11,6 +11,7 @@ enum asidrv_seqnum {
 	ASIDRV_SEQ_MEM,		/* access unmapped memory */
 	ASIDRV_SEQ_MEMMAP,	/* access mapped memory */
 	ASIDRV_SEQ_INTERRUPT,	/* interrupt sequence */
+	ASIDRV_SEQ_NMI,		/* NMI interrupt sequence */
 };
 
 enum asidrv_run_error {
@@ -25,6 +26,9 @@ enum asidrv_run_error {
 	ASIDRV_RUN_ERR_INTR,	/* no interrupt received */
 	ASIDRV_RUN_ERR_INTR_ASI_ACTIVE, /* ASI active in interrupt handler */
 	ASIDRV_RUN_ERR_TIMEOUT,
+	ASIDRV_RUN_ERR_NMI,	/* no NMI received */
+	ASIDRV_RUN_ERR_NMI_REG,	/* failed to register NMI handler */
+	ASIDRV_RUN_ERR_NMI_ASI_ACTIVE, /* ASI active in NMI handler */
 };
 
 #define ASIDRV_IOCTL_RUN_SEQUENCE	_IOWR('a', 1, struct asidrv_run_param)
-- 
2.18.2

