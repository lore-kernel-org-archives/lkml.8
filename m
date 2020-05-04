Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB25FC3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 15:07:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B564C206D7
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 15:07:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Zggz8WZz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729584AbgEDPHG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 11:07:06 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:57582 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726744AbgEDPHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 11:07:05 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 044ElifK116784;
        Mon, 4 May 2020 15:06:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=B2uXdxYJUzNl2lMjTTjR6bplmjpOhPo7Ihfe5K+yde8=;
 b=Zggz8WZz+a42F1eiz01QmaSd9xLe0dv3JE6HqFkChmCj+nZO5yZxG9zmKP3rO/ef7kGr
 zSbCInKO1qE6hfwwj6VVY9aFUMsqYpzHlkfYE362YQxqh+jJDmKV7BlQkik6Sw2aMyQ3
 mPcBi1pgi//3tNPB3yuxwH8gqm4A2Gk051CrFzKAATm2U1ft0/vReRqjUt+6jPlkmqPT
 GAbjsgqz6DJmXSvC5doQRDDzOTVbE2ZDN6oLGJ2SqptXQX/frCmloy2L5g3BPvzMortT
 ofRTaVS48mVDtociM/fhdV1QJyKRSxA9/WgyJpDGZeqynqeElH1TH1Q0ZfMxspamfJtk WA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 30s09qyhfx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 May 2020 15:06:43 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 044EmV46105699;
        Mon, 4 May 2020 15:04:43 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 30sjjw18dg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 May 2020 15:04:43 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 044F4fW2030429;
        Mon, 4 May 2020 15:04:41 GMT
Received: from linux-1.home.com (/10.175.9.166)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 04 May 2020 08:04:41 -0700
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        x86@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     pbonzini@redhat.com, konrad.wilk@oracle.com,
        jan.setjeeilers@oracle.com, liran.alon@oracle.com,
        junaids@google.com, graf@amazon.de, rppt@linux.vnet.ibm.com,
        kuzuno@gmail.com, mgross@linux.intel.com,
        alexandre.chartre@oracle.com
Subject: [RFC v4][PATCH part-3 09/14] asidrv: Add ioctls to manage ASI page faults
Date:   Mon,  4 May 2020 17:02:30 +0200
Message-Id: <20200504150235.12171-10-alexandre.chartre@oracle.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20200504150235.12171-1-alexandre.chartre@oracle.com>
References: <20200504150235.12171-1-alexandre.chartre@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9610 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 phishscore=0
 bulkscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005040123
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9610 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 malwarescore=0 mlxlogscore=999 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005040123
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ioctls to list and clear ASI page faults. Also add an ioctl to display
or not stack trace on ASI page fault.

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
---
 drivers/staging/asi/asidrv.c | 88 ++++++++++++++++++++++++++++++++++++
 drivers/staging/asi/asidrv.h | 32 +++++++++++++
 2 files changed, 120 insertions(+)

diff --git a/drivers/staging/asi/asidrv.c b/drivers/staging/asi/asidrv.c
index 9ca17e0b654e..e6edfbe5acea 100644
--- a/drivers/staging/asi/asidrv.c
+++ b/drivers/staging/asi/asidrv.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/fs.h>
+#include <linux/kallsyms.h>
 #include <linux/kthread.h>
 #include <linux/miscdevice.h>
 #include <linux/module.h>
@@ -790,12 +791,99 @@ static int asidrv_ioctl_run_sequence(struct asidrv_test *test,
 	return 0;
 }
 
+/*
+ * ASI fault ioctls
+ */
+
+static int asidrv_ioctl_list_fault(struct asi *asi, unsigned long arg)
+{
+	struct asidrv_fault_list __user *uflist;
+	struct asidrv_fault_list *flist;
+	size_t flist_size;
+	__u32 uflist_len;
+	int i;
+
+	uflist = (struct asidrv_fault_list __user *)arg;
+	if (copy_from_user(&uflist_len, &uflist->length, sizeof(uflist_len)))
+		return -EFAULT;
+
+	uflist_len = min_t(unsigned int, uflist_len, ASI_FAULT_LOG_SIZE);
+
+	flist_size = sizeof(*flist) + sizeof(struct asidrv_fault) * uflist_len;
+	flist = kzalloc(flist_size, GFP_KERNEL);
+	if (!flist)
+		return -ENOMEM;
+
+	for (i = 0; i < ASI_FAULT_LOG_SIZE; i++) {
+		if (!asi->fault_log[i].address)
+			break;
+		if (i < uflist_len) {
+			flist->fault[i].addr = asi->fault_log[i].address;
+			flist->fault[i].count = asi->fault_log[i].count;
+			sprint_symbol(flist->fault[i].symbol,
+				      asi->fault_log[i].address);
+		}
+	}
+	flist->length = i;
+
+	if (copy_to_user(uflist, flist, flist_size)) {
+		kfree(flist);
+		return -EFAULT;
+	}
+
+	if (i >= ASI_FAULT_LOG_SIZE)
+		pr_warn("ASI %p: fault log buffer is full [%d]\n", asi, i);
+
+	kfree(flist);
+
+	return 0;
+}
+
+static int asidrv_ioctl_clear_fault(struct asi *asi)
+{
+	int i;
+
+	for (i = 0; i < ASI_FAULT_LOG_SIZE; i++) {
+		if (!asi->fault_log[i].address)
+			break;
+		asi->fault_log[i].address = 0;
+	}
+
+	pr_debug("ASI %p: faults cleared\n", asi);
+	return 0;
+}
+
+static int asidrv_ioctl_log_fault_stack(struct asi *asi, bool log_stack)
+{
+	if (log_stack) {
+		asi->fault_log_policy |= ASI_FAULT_LOG_STACK;
+		pr_debug("ASI %p: setting fault stack\n", asi);
+	} else {
+		asi->fault_log_policy &= ~ASI_FAULT_LOG_STACK;
+		pr_debug("ASI %p: clearing fault stack\n", asi);
+	}
+
+	return 0;
+}
+
 static long asidrv_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 {
 	struct asidrv_test *test = asidrv_test;
+	struct asi *asi = test->asi;
 
 	switch (cmd) {
 
+	/* ASI fault ioctls */
+
+	case ASIDRV_IOCTL_LIST_FAULT:
+		return asidrv_ioctl_list_fault(asi, arg);
+
+	case ASIDRV_IOCTL_CLEAR_FAULT:
+		return asidrv_ioctl_clear_fault(asi);
+
+	case ASIDRV_IOCTL_LOG_FAULT_STACK:
+		return asidrv_ioctl_log_fault_stack(asi, arg);
+
 	/* Test ioctls */
 
 	case ASIDRV_IOCTL_RUN_SEQUENCE:
diff --git a/drivers/staging/asi/asidrv.h b/drivers/staging/asi/asidrv.h
index 9f540b119883..99ab9843e36b 100644
--- a/drivers/staging/asi/asidrv.h
+++ b/drivers/staging/asi/asidrv.h
@@ -36,9 +36,41 @@ enum asidrv_run_error {
 
 #define ASIDRV_IOCTL_RUN_SEQUENCE	_IOWR('a', 1, struct asidrv_run_param)
 
+/*
+ * ASIDRV_IOCTL_LIST_FAULT: return the list of ASI faults.
+ *
+ * User should set 'length' with the number of entries available in the
+ * 'fault' array. On return, 'length' is set to the number of ASI faults
+ * (which can be larger than the original 'length' value), and the 'fault'
+ * array is filled with the ASI faults.
+ */
+#define ASIDRV_IOCTL_LIST_FAULT		_IOWR('a', 2, struct asidrv_fault_list)
+#define ASIDRV_IOCTL_CLEAR_FAULT	_IO('a', 3)
+#define ASIDRV_IOCTL_LOG_FAULT_STACK	_IO('a', 4)
+
+#define ASIDRV_KSYM_NAME_LEN	128
+/*
+ * We need KSYM_SYMBOL_LEN to lookup symbol. However it's not part of
+ * userland include. So we use a reasonably large value (KSYM_SYMBOL_LEN
+ * is around 310).
+ */
+#define ASIDRV_KSYM_SYMBOL_LEN	512
+
 struct asidrv_run_param {
 	__u32 sequence;		/* sequence to run */
 	__u32 run_error;	/* result error after run */
 	__u32 asi_active;	/* ASI is active after run? */
 };
+
+struct asidrv_fault {
+	__u64 addr;
+	char  symbol[ASIDRV_KSYM_SYMBOL_LEN];
+	__u32 count;
+};
+
+struct asidrv_fault_list {
+	__u32 length;
+	struct asidrv_fault fault[0];
+};
+
 #endif
-- 
2.18.2

