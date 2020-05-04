Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3783CC3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 15:05:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CBD32073B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 15:05:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="B5GJb3Fq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729462AbgEDPFR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 11:05:17 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:51766 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727815AbgEDPFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 11:05:17 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 044En9lQ024653;
        Mon, 4 May 2020 15:04:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=JmbDddsHqBPfeLl0EGXWiz374Cqp33W511n0wWVb8wQ=;
 b=B5GJb3FqGk9bP0FA6nIkeLtMd9CDArgqRCnOjmIA9b1lo/V6Hj99FbkHLb99E43PvBAr
 +ZmaijbdKCOG0ljzZ+OAFdqRu7nUXX3LNUgnNtHx4qY174aWJrchKJ/hl10pH3OS2/aH
 Iu8XX2RhtVlXCRMBmxp8XrVo+um8om+FFGJteVvIgAvHzZVODewVEy5K+PKCjnDrBF/F
 E5ewyIGnooxkh60WMltM1To+CnkPkd17cK5GOqOcQKflQYjt0DpdzwrQohTjWa5tbR9N
 +d6IpU6p49zt+5udYuB751ew2l6BB476hZDd4bpCVc4vPBHEANEmOOpqnQYWQzWvzenK lw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 30s0tm7et3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 May 2020 15:04:50 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 044EkeYs094682;
        Mon, 4 May 2020 15:04:50 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 30sjdqqqku-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 May 2020 15:04:50 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 044F4nc0004501;
        Mon, 4 May 2020 15:04:49 GMT
Received: from linux-1.home.com (/10.175.9.166)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 04 May 2020 08:04:49 -0700
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        x86@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     pbonzini@redhat.com, konrad.wilk@oracle.com,
        jan.setjeeilers@oracle.com, liran.alon@oracle.com,
        junaids@google.com, graf@amazon.de, rppt@linux.vnet.ibm.com,
        kuzuno@gmail.com, mgross@linux.intel.com,
        alexandre.chartre@oracle.com
Subject: [RFC v4][PATCH part-3 11/14] asidrv/asicmd: Introduce the asicmd command
Date:   Mon,  4 May 2020 17:02:32 +0200
Message-Id: <20200504150235.12171-12-alexandre.chartre@oracle.com>
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

The asicmd command is a userland CLI to interact with the ASI driver
(asidrv), in particular it provides an interface for running ASI
test sequences.

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
---
 drivers/staging/asi/Makefile |   6 ++
 drivers/staging/asi/asicmd.c | 120 +++++++++++++++++++++++++++++++++++
 2 files changed, 126 insertions(+)
 create mode 100644 drivers/staging/asi/asicmd.c

diff --git a/drivers/staging/asi/Makefile b/drivers/staging/asi/Makefile
index a48487e48d7c..847d4732c229 100644
--- a/drivers/staging/asi/Makefile
+++ b/drivers/staging/asi/Makefile
@@ -5,3 +5,9 @@
 #
 obj-m += asi.o
 asi-y := asidrv.o
+
+#
+# asicmd command
+#
+hostprogs-y := asicmd
+always := $(hostprogs-y)
diff --git a/drivers/staging/asi/asicmd.c b/drivers/staging/asi/asicmd.c
new file mode 100644
index 000000000000..4d6a347a6d29
--- /dev/null
+++ b/drivers/staging/asi/asicmd.c
@@ -0,0 +1,120 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2020, Oracle and/or its affiliates.
+ */
+
+#include <errno.h>
+#include <fcntl.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <sys/ioctl.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+
+#include "asidrv.h"
+
+struct asidrv_test {
+	char		*name;		/* test name */
+	enum asidrv_seqnum seqnum;	/* sequence */
+	bool		asi_active;	/* ASI active at the end of test? */
+	char		*desc;		/* test description */
+};
+
+struct asidrv_test test_list[] = {
+	{ "nop", ASIDRV_SEQ_NOP, true,
+	  "enter/exit ASI and nothing else" },
+};
+
+#define	TEST_LIST_SIZE	(sizeof(test_list) / sizeof(test_list[0]))
+
+static void usage(void)
+{
+	int i;
+
+	printf("Usage: asicmd (<cmd>|<test>...)\n");
+	printf("\n");
+	printf("Commands:\n");
+	printf("  all      - run all tests\n");
+	printf("\n");
+	printf("Tests:\n");
+	for (i = 0; i < TEST_LIST_SIZE; i++)
+		printf("  %-10s - %s\n", test_list[i].name, test_list[i].desc);
+}
+
+static void asidrv_run_test(int fd, struct asidrv_test *test)
+{
+	struct asidrv_run_param rparam;
+	int err;
+
+	printf("Test %s (sequence %d)\n", test->name, test->seqnum);
+
+	rparam.sequence = test->seqnum;
+
+	err = ioctl(fd, ASIDRV_IOCTL_RUN_SEQUENCE, &rparam);
+
+	printf("  - rv = %d ; ", err);
+	if (err < 0) {
+		printf("error %d\n", errno);
+	} else {
+		printf("result = %d ; ", rparam.run_error);
+		printf("%s\n",
+		       rparam.asi_active ? "asi active" : "asi inactive");
+	}
+
+	printf("  - expect = %s\n",
+	       test->asi_active ? "asi active" : "asi inactive");
+
+	if (err < 0)
+		printf("ERROR - error %d\n", errno);
+	else if (rparam.run_error != ASIDRV_RUN_ERR_NONE)
+		printf("TEST ERROR - error %d\n", rparam.run_error);
+	else if (test->asi_active != rparam.asi_active)
+		printf("TEST FAILED - unexpected ASI state\n");
+	else
+		printf("TEST OK\n");
+}
+
+int main(int argc, char *argv[])
+{
+	bool run_all, run;
+	int i, j, fd;
+	char *test;
+
+	if (argc <= 1) {
+		usage();
+		return 2;
+	}
+
+	fd = open("/dev/asi", O_RDONLY);
+	if (fd == -1) {
+		perror("open /dev/asi");
+		return 1;
+	}
+
+	for (i = 1; i < argc; i++) {
+		test = argv[i];
+
+		if (!strcmp(test, "all"))
+			run_all = true;
+		else
+			run_all = false;
+
+		run = false;
+		for (j = 0; j < TEST_LIST_SIZE; j++) {
+			if (run_all || !strcmp(test, test_list[j].name)) {
+				asidrv_run_test(fd, &test_list[j]);
+				run = true;
+			}
+		}
+
+		if (!run)
+			printf("Unknown test '%s'\n", test);
+	}
+
+	close(fd);
+
+	return 0;
+}
-- 
2.18.2

