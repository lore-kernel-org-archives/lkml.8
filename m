Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83921C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 15:06:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58F9E20721
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 15:06:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="b3WfzdZM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729541AbgEDPGp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 11:06:45 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:53364 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729055AbgEDPGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 11:06:45 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 044En9fS024718;
        Mon, 4 May 2020 15:06:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=GdpSgFkEZ+Ur+ACfjLTgXfvY2O4IFXjjIbm/9Da3I/U=;
 b=b3WfzdZMrbDnbmyd5xFgV2+BKRnWt5HgHioOzu3QHzViYK85ZAPRmsyfspWC8h6K4I0p
 KK8P43R8WJg+ECSwDg1e2Jggg8+Zph7kmTJQ9qLwLmMN0GBV2DpHDaZRsk9gFIxpqvjI
 YlD1HnMjYvQvyHkNZEtcnygNDw+Ni6GaSvIWwvW+OKxEdQCVJsJIluAjc4Qe2bWSUsEi
 1BrhbiIQGpQt4bIGmnbc60+ravI29lRgjTA7U7B0YSDiY5EJX5ltLDsrw8gW5yhC33nC
 7pGoBevJMsXbtID7LfM8j08e/aKEhzi3ql9IXOwZ96DBwPTLRM5ckNXdeoMUVLd39cag Mw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 30s0tm7f8a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 May 2020 15:06:23 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 044Ekfvq094713;
        Mon, 4 May 2020 15:04:23 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 30sjdqqnra-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 May 2020 15:04:23 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 044F4LKe025185;
        Mon, 4 May 2020 15:04:21 GMT
Received: from linux-1.home.com (/10.175.9.166)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 04 May 2020 08:04:20 -0700
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        x86@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     pbonzini@redhat.com, konrad.wilk@oracle.com,
        jan.setjeeilers@oracle.com, liran.alon@oracle.com,
        junaids@google.com, graf@amazon.de, rppt@linux.vnet.ibm.com,
        kuzuno@gmail.com, mgross@linux.intel.com,
        alexandre.chartre@oracle.com
Subject: [RFC v4][PATCH part-3 04/14] asidrv: Sequence to test ASI access to mapped/unmapped memory
Date:   Mon,  4 May 2020 17:02:25 +0200
Message-Id: <20200504150235.12171-5-alexandre.chartre@oracle.com>
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

Add a sequence to test if ASI exit or not when accessing a mapped
or unmapped memory buffer.

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
---
 drivers/staging/asi/asidrv.c | 70 ++++++++++++++++++++++++++++++++++++
 drivers/staging/asi/asidrv.h |  3 ++
 2 files changed, 73 insertions(+)

diff --git a/drivers/staging/asi/asidrv.c b/drivers/staging/asi/asidrv.c
index 4f0548edb2f9..4231b56db167 100644
--- a/drivers/staging/asi/asidrv.c
+++ b/drivers/staging/asi/asidrv.c
@@ -14,9 +14,21 @@
 
 #include "asidrv.h"
 
+#define ASIDRV_TEST_BUFFER_SIZE	PAGE_SIZE
+
+/* Number of read for mem/memmap test sequence */
+#define ASIDRV_MEM_READ_COUNT		1000
+
+enum asidrv_state {
+	ASIDRV_STATE_NONE,
+	ASIDRV_STATE_INTR_WAITING,
+	ASIDRV_STATE_INTR_RECEIVED,
+};
+
 struct asidrv_test {
 	struct asi		*asi;	/* ASI for testing */
 	struct dpt		*dpt;	/* ASI decorated page-table */
+	char			*buffer; /* buffer for testing */
 };
 
 struct asidrv_sequence {
@@ -42,6 +54,10 @@ static struct asidrv_test *asidrv_test_create(void)
 	if (!test)
 		return NULL;
 
+	test->buffer = kzalloc(ASIDRV_TEST_BUFFER_SIZE, GFP_KERNEL);
+	if (!test->buffer)
+		goto error;
+
 	/*
 	 * Create and fill a decorator page-table to be used with the ASI.
 	 */
@@ -96,6 +112,7 @@ static void asidrv_test_destroy(struct asidrv_test *test)
 	if (test->asi)
 		asi_destroy(test->asi);
 
+	kfree(test->buffer);
 	kfree(test);
 }
 
@@ -143,6 +160,51 @@ static int asidrv_asi_is_active(struct asi *asi)
 	return false;
 }
 
+/*
+ * Memory Buffer Access Test Sequences
+ */
+
+#define OPTNONE __attribute__((optimize(0)))
+
+static enum asidrv_run_error OPTNONE asidrv_mem_run(struct asidrv_test *test)
+{
+	char c;
+	int i, index;
+
+	/*
+	 * Do random reads in the test buffer, and return if the ASI
+	 * becomes inactive.
+	 */
+	for (i = 0; i < ASIDRV_MEM_READ_COUNT; i++) {
+		index = get_cycles() % ASIDRV_TEST_BUFFER_SIZE;
+		c = test->buffer[index];
+		if (!asidrv_asi_is_active(test->asi)) {
+			pr_warn("ASI inactive after reading byte %d at %d\n",
+				i + 1, index);
+			break;
+		}
+	}
+
+	return ASIDRV_RUN_ERR_NONE;
+}
+
+static enum asidrv_run_error asidrv_memmap_setup(struct asidrv_test *test)
+{
+	int err;
+
+	pr_debug("mapping test buffer %px\n", test->buffer);
+	err = dpt_map(test->dpt, test->buffer, ASIDRV_TEST_BUFFER_SIZE);
+	if (err)
+		return ASIDRV_RUN_ERR_MAP_BUFFER;
+
+	return ASIDRV_RUN_ERR_NONE;
+}
+
+static void asidrv_memmap_cleanup(struct asidrv_test *test)
+{
+	dpt_unmap(test->dpt, test->buffer);
+}
+
 /*
  * Printk Test Sequence
  */
@@ -161,6 +223,14 @@ struct asidrv_sequence asidrv_sequences[] = {
 		"printk",
 		NULL, asidrv_printk_run, NULL,
 	},
+	[ASIDRV_SEQ_MEM] = {
+		"mem",
+		NULL, asidrv_mem_run, NULL,
+	},
+	[ASIDRV_SEQ_MEMMAP] = {
+		"memmap",
+		asidrv_memmap_setup, asidrv_mem_run, asidrv_memmap_cleanup,
+	},
 };
 
 static enum asidrv_run_error asidrv_run_init(struct asidrv_test *test)
diff --git a/drivers/staging/asi/asidrv.h b/drivers/staging/asi/asidrv.h
index 33acb058c443..1e820cc64f13 100644
--- a/drivers/staging/asi/asidrv.h
+++ b/drivers/staging/asi/asidrv.h
@@ -8,6 +8,8 @@
 enum asidrv_seqnum {
 	ASIDRV_SEQ_NOP,		/* empty sequence */
 	ASIDRV_SEQ_PRINTK,	/* printk sequence */
+	ASIDRV_SEQ_MEM,		/* access unmapped memory */
+	ASIDRV_SEQ_MEMMAP,	/* access mapped memory */
 };
 
 enum asidrv_run_error {
@@ -17,6 +19,7 @@ enum asidrv_run_error {
 	ASIDRV_RUN_ERR_MAP_TASK, /* failed to map current task */
 	ASIDRV_RUN_ERR_ENTER,	/* failed to enter ASI */
 	ASIDRV_RUN_ERR_ACTIVE,	/* ASI is not active after entering ASI */
+	ASIDRV_RUN_ERR_MAP_BUFFER, /* failed to map buffer */
 };
 
 #define ASIDRV_IOCTL_RUN_SEQUENCE	_IOWR('a', 1, struct asidrv_run_param)
-- 
2.18.2

