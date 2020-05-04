Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC0FEC3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 15:04:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A227206D7
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 15:04:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FTt900j8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728968AbgEDPEj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 11:04:39 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:54870 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727815AbgEDPEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 11:04:39 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 044ElfaX116691;
        Mon, 4 May 2020 15:04:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=9ZTqvJjjLyxOtbSJqAkDSETOKDWWKvJ7dBdIIE9LUGI=;
 b=FTt900j8w4nSYYb8kx7FGWna/5R7g+FIVCzUgqKfgT/XXDX9lMqzsYFuXOMaWatWCgBZ
 hDnIB9nuFQYpeYqVbwQXMrb2NjLzMgK6sMnbW0G0pscgfYjszfp2gN3g8q5Kb/Beo48r
 aDjq7Gq53nAw4Ndvbdef7LM9lMI4myGgTwkpeODx06op+/yW25dLZC8r6yNbeYX7iNj7
 G3VejSC7IIwkMlKxmy6ue1UUTNGKTT+9JbeOY2akQHTpe2FtScu9gw4uBEncVhBlW7Tk
 jIFwbQuh+oDRTgZ8ZRqh/NUKSItafILU06RbLIDSL/oU+BbQ5iobRGSU1I9v4JK4i0GQ Qw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 30s09qygt2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 May 2020 15:04:15 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 044EmVKi105667;
        Mon, 4 May 2020 15:04:14 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 30sjjw15mf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 May 2020 15:04:14 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 044F4CLS028449;
        Mon, 4 May 2020 15:04:12 GMT
Received: from linux-1.home.com (/10.175.9.166)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 04 May 2020 08:04:12 -0700
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        x86@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     pbonzini@redhat.com, konrad.wilk@oracle.com,
        jan.setjeeilers@oracle.com, liran.alon@oracle.com,
        junaids@google.com, graf@amazon.de, rppt@linux.vnet.ibm.com,
        kuzuno@gmail.com, mgross@linux.intel.com,
        alexandre.chartre@oracle.com
Subject: [RFC v4][PATCH part-3 02/14] asidrv: Introduce the ASI driver
Date:   Mon,  4 May 2020 17:02:23 +0200
Message-Id: <20200504150235.12171-3-alexandre.chartre@oracle.com>
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

Introduce the infrastructure for the ASI driver. This driver is meant
for testing ASI. It creates a test ASI, and will allow to run some
test sequences on this ASI.

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
---
 drivers/staging/asi/Makefile |   7 ++
 drivers/staging/asi/asidrv.c | 129 +++++++++++++++++++++++++++++++++++
 2 files changed, 136 insertions(+)
 create mode 100644 drivers/staging/asi/Makefile
 create mode 100644 drivers/staging/asi/asidrv.c

diff --git a/drivers/staging/asi/Makefile b/drivers/staging/asi/Makefile
new file mode 100644
index 000000000000..a48487e48d7c
--- /dev/null
+++ b/drivers/staging/asi/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0
+
+#
+# Address Space Isolation (ASI) driver
+#
+obj-m += asi.o
+asi-y := asidrv.o
diff --git a/drivers/staging/asi/asidrv.c b/drivers/staging/asi/asidrv.c
new file mode 100644
index 000000000000..c06e4734e0e5
--- /dev/null
+++ b/drivers/staging/asi/asidrv.c
@@ -0,0 +1,129 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2020, Oracle and/or its affiliates.
+ */
+
+#include <linux/fs.h>
+#include <linux/miscdevice.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+
+#include <asm/asi.h>
+#include <asm/dpt.h>
+
+struct asidrv_test {
+	struct asi		*asi;	/* ASI for testing */
+	struct dpt		*dpt;	/* ASI decorated page-table */
+};
+
+static struct asidrv_test *asidrv_test;
+
+static void asidrv_test_destroy(struct asidrv_test *test);
+
+static struct asidrv_test *asidrv_test_create(void)
+{
+	struct asidrv_test *test;
+	int err;
+
+	test = kzalloc(sizeof(*test), GFP_KERNEL);
+	if (!test)
+		return NULL;
+
+	/*
+	 * Create and fill a decorator page-table to be used with the ASI.
+	 */
+	test->dpt = dpt_create(ASI_PGTABLE_MASK);
+	if (!test->dpt)
+		goto error;
+
+	err = asi_init_dpt(test->dpt);
+	if (err)
+		goto error;
+
+	err = DPT_MAP_THIS_MODULE(test->dpt);
+	if (err)
+		goto error;
+
+	/* map the asidrv_test as we will access it during the test */
+	err = dpt_map(test->dpt, test, sizeof(*test));
+	if (err)
+		goto error;
+
+	test->asi = asi_create_test();
+	if (!test->asi)
+		goto error;
+
+	/*
+	 * By default, the ASI structure is not mapped into the ASI. We
+	 * map it so that we can access it and verify the consistency
+	 * of some values (for example the CR3 value).
+	 */
+	err = dpt_map(test->dpt, test->asi, sizeof(*test->asi));
+	if (err)
+		goto error;
+
+	asi_set_pagetable(test->asi, test->dpt->pagetable);
+
+	return test;
+
+error:
+	pr_debug("Failed to create ASI Test\n");
+	asidrv_test_destroy(test);
+	return NULL;
+}
+
+static void asidrv_test_destroy(struct asidrv_test *test)
+{
+	if (!test)
+		return;
+
+	if (test->dpt)
+		dpt_destroy(test->dpt);
+
+	if (test->asi)
+		asi_destroy(test->asi);
+
+	kfree(test);
+}
+
+static const struct file_operations asidrv_fops = {
+	.owner		= THIS_MODULE,
+};
+
+static struct miscdevice asidrv_miscdev = {
+	.minor = MISC_DYNAMIC_MINOR,
+	.name = KBUILD_MODNAME,
+	.fops = &asidrv_fops,
+};
+
+static int __init asidrv_init(void)
+{
+	int err;
+
+	asidrv_test = asidrv_test_create();
+	if (!asidrv_test)
+		return -ENOMEM;
+
+	err = misc_register(&asidrv_miscdev);
+	if (err) {
+		asidrv_test_destroy(asidrv_test);
+		asidrv_test = NULL;
+	}
+
+	return err;
+}
+
+static void __exit asidrv_exit(void)
+{
+	asidrv_test_destroy(asidrv_test);
+	asidrv_test = NULL;
+	misc_deregister(&asidrv_miscdev);
+}
+
+module_init(asidrv_init);
+module_exit(asidrv_exit);
+
+MODULE_AUTHOR("Alexandre Chartre <alexandre.chartre@oracle.com>");
+MODULE_DESCRIPTION("Privileged interface to ASI");
+MODULE_VERSION("1.0");
+MODULE_LICENSE("GPL v2");
-- 
2.18.2

