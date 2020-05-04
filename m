Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC8EEC3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 15:05:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A71D2206D7
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 15:05:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RryTrC2i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729446AbgEDPFC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 11:05:02 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:40674 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727815AbgEDPFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 11:05:00 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 044Elis7024656;
        Mon, 4 May 2020 15:04:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=HlwbAlrpx3vJnc/cnvhjjhhjODFL/A8igwurSCDOi0E=;
 b=RryTrC2iKUzql/6iQwhgQEfato+6RYgoLKaBxF3C7xSU2LRYifSZ8jn5Z+gn9Ib1eLyG
 SZ+J7dyyfUrI1EvUiV0mJR5J4N3ku1CyiKV2HNcsMqKKDK/Q/XOIi4MDKTP7ua3ZawA5
 4GfyRU3CTGbQNkBBHHTWgO2FKVIlSI3/c/oxSf8TPkl8pbuRo7i+6CCh8zWhnXurx+zt
 1QjL1za2eyPvIOOncy7wxtu0V7NCnzYaHKm8hyFqfSWJlB3D++Egvruaj7XHrF0wlP4Z
 +txG1BSOep3Z3ziFMdkSgBDyta3kIe4vMQT5JEwk5GygVoYLz78b0S5XdeQRE7xcErAp jg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 30s1gmy9mg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 May 2020 15:04:36 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 044ElbZt053429;
        Mon, 4 May 2020 15:04:35 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 30t1r2f7eq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 May 2020 15:04:35 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 044F4XVp004344;
        Mon, 4 May 2020 15:04:33 GMT
Received: from linux-1.home.com (/10.175.9.166)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 04 May 2020 08:04:33 -0700
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        x86@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     pbonzini@redhat.com, konrad.wilk@oracle.com,
        jan.setjeeilers@oracle.com, liran.alon@oracle.com,
        junaids@google.com, graf@amazon.de, rppt@linux.vnet.ibm.com,
        kuzuno@gmail.com, mgross@linux.intel.com,
        alexandre.chartre@oracle.com
Subject: [RFC v4][PATCH part-3 07/14] asidrv: Sequence to test interrupt+NMI on ASI
Date:   Mon,  4 May 2020 17:02:28 +0200
Message-Id: <20200504150235.12171-8-alexandre.chartre@oracle.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20200504150235.12171-1-alexandre.chartre@oracle.com>
References: <20200504150235.12171-1-alexandre.chartre@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9610 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 suspectscore=0
 spamscore=0 mlxlogscore=999 malwarescore=0 phishscore=0 mlxscore=0
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

Add a sequence to test if an ASI remains active after receiving
an interrupt which is itself interrupted by an NMI.

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
---
 drivers/staging/asi/asidrv.c | 62 +++++++++++++++++++++++++++++++++++-
 drivers/staging/asi/asidrv.h |  1 +
 2 files changed, 62 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/asi/asidrv.c b/drivers/staging/asi/asidrv.c
index 8f964c9e0b14..e08f2a107e89 100644
--- a/drivers/staging/asi/asidrv.c
+++ b/drivers/staging/asi/asidrv.c
@@ -49,6 +49,7 @@ struct asidrv_test {
 	struct work_struct	work;	/* work for other cpu */
 	bool			work_set;
 	enum asidrv_run_error	run_error;
+	bool			intrnmi;
 };
 
 struct asidrv_sequence {
@@ -65,6 +66,7 @@ static void asidrv_test_destroy(struct asidrv_test *test);
 static void asidrv_run_fini(struct asidrv_test *test);
 static void asidrv_run_cleanup(struct asidrv_test *test,
 			       struct asidrv_sequence *sequence);
+static void asidrv_intrnmi_send(struct work_struct *work);
 
 static struct asidrv_test *asidrv_test_create(void)
 {
@@ -284,7 +286,10 @@ static enum asidrv_run_error asidrv_nmi_setup(struct asidrv_test *test)
 	}
 
 	/* set work to have another cpu to send us an NMI */
-	INIT_WORK(&test->work, asidrv_nmi_send);
+	if (test->intrnmi)
+		INIT_WORK(&test->work, asidrv_intrnmi_send);
+	else
+		INIT_WORK(&test->work, asidrv_nmi_send);
 
 	test->work_set = true;
 
@@ -336,6 +341,12 @@ static void asidrv_intr_handler(void *info)
 
 	pr_debug("Received interrupt\n");
 	atomic_set(&test->state, ASIDRV_STATE_INTR_RECEIVED);
+
+	if (!test->intrnmi)
+		return;
+
+	pr_debug("Waiting for NMI in interrupt\n");
+	asidrv_nmi_run(test);
 }
 
 static void asidrv_intr_send(struct work_struct *work)
@@ -383,6 +394,50 @@ static enum asidrv_run_error asidrv_intr_run(struct asidrv_test *test)
 	return err;
 }
 
+/*
+ * Interrupt+NMI Test Sequence
+ */
+
+static void asidrv_intrnmi_send(struct work_struct *work)
+{
+	/* send and interrupt and then send an NMI */
+	asidrv_intr_send(work);
+	asidrv_nmi_send(work);
+}
+
+static enum asidrv_run_error asidrv_intrnmi_setup(struct asidrv_test *test)
+{
+	test->intrnmi = true;
+	return asidrv_nmi_setup(test);
+}
+
+static enum asidrv_run_error asidrv_intrnmi_run(struct asidrv_test *test)
+{
+	enum asidrv_run_error err;
+	enum asidrv_state state;
+
+	/*
+	 * Wait for state changes indicating that an interrupt and
+	 * then an NMI were received.
+	 */
+	err = asidrv_wait_transition(test,
+				     ASIDRV_STATE_INTR_WAITING,
+				     ASIDRV_STATE_NMI_RECEIVED,
+				     ASIDRV_TIMEOUT_INTERRUPT);
+	if (err == ASIDRV_RUN_ERR_TIMEOUT) {
+		state = atomic_read(&test->state);
+		if (state == ASIDRV_STATE_INTR_WAITING) {
+			pr_debug("Interrupt wait timeout\n");
+			err = ASIDRV_RUN_ERR_INTR;
+		} else {
+			pr_debug("NMI wait timeout\n");
+			err = ASIDRV_RUN_ERR_NMI;
+		}
+	}
+
+	return err;
+}
+
 /*
  * Memory Buffer Access Test Sequences
  */
@@ -462,6 +517,10 @@ struct asidrv_sequence asidrv_sequences[] = {
 		"nmi",
 		asidrv_nmi_setup, asidrv_nmi_run, asidrv_nmi_cleanup,
 	},
+	[ASIDRV_SEQ_INTRNMI] = {
+		"intr+nmi",
+		asidrv_intrnmi_setup, asidrv_intrnmi_run, asidrv_nmi_cleanup,
+	},
 };
 
 static enum asidrv_run_error asidrv_run_init(struct asidrv_test *test)
@@ -509,6 +568,7 @@ static enum asidrv_run_error asidrv_run_setup(struct asidrv_test *test,
 	int run_err;
 
 	test->work_set = false;
+	test->intrnmi = false;
 
 	if (sequence->setup) {
 		run_err = sequence->setup(test);
diff --git a/drivers/staging/asi/asidrv.h b/drivers/staging/asi/asidrv.h
index 6fac32d56f6f..de9f7ad993e0 100644
--- a/drivers/staging/asi/asidrv.h
+++ b/drivers/staging/asi/asidrv.h
@@ -12,6 +12,7 @@ enum asidrv_seqnum {
 	ASIDRV_SEQ_MEMMAP,	/* access mapped memory */
 	ASIDRV_SEQ_INTERRUPT,	/* interrupt sequence */
 	ASIDRV_SEQ_NMI,		/* NMI interrupt sequence */
+	ASIDRV_SEQ_INTRNMI,	/* NMI in interrupt sequence */
 };
 
 enum asidrv_run_error {
-- 
2.18.2

