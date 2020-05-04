Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86084C47254
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 15:07:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65470206D7
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 15:07:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="a7NeuEIG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729587AbgEDPHX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 11:07:23 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:51932 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729531AbgEDPF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 11:05:26 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 044En9Cd024665;
        Mon, 4 May 2020 15:04:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=9e36+98PNoowCUHFPdVfiZTA22EJNaHCMNF8Hj+ZaN8=;
 b=a7NeuEIG5wIhjV7s42Ng1bXBB4WfyQL2JTHR26de2E7aeI+r7+xRe6P1mOq7cQ1g9YRx
 0THsLrZIdYzOXzJurJng8KPG9xCd5/ATvZTZzTPDjCiGWXKngKLfSspkGgqcnmaBUlNk
 UinL0di9n6odc5suJ6dQBkC7FeW22B74Yev8R1IZPeXrZnuPQykxAbyiCKDeH7ghndpU
 V7vrjvu7ibmv8vOCT1QqJiq3M2ojyyKi42ZR/z6CNXeo7yO3WgmrZNzSbE/6geuc/oOB
 BEdCLwEeeHV/sCCTj52hIonQ6P7ttbh4Gy4XC17aKRxJ7eh0bcgaKZPS6StcqnDYkQC6 bQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 30s0tm7euh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 May 2020 15:04:59 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 044EmVcH105622;
        Mon, 4 May 2020 15:04:59 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 30sjjw19k9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 May 2020 15:04:59 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 044F4vNG030629;
        Mon, 4 May 2020 15:04:57 GMT
Received: from linux-1.home.com (/10.175.9.166)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 04 May 2020 08:04:57 -0700
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        x86@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     pbonzini@redhat.com, konrad.wilk@oracle.com,
        jan.setjeeilers@oracle.com, liran.alon@oracle.com,
        junaids@google.com, graf@amazon.de, rppt@linux.vnet.ibm.com,
        kuzuno@gmail.com, mgross@linux.intel.com,
        alexandre.chartre@oracle.com
Subject: [RFC v4][PATCH part-3 13/14] asidrv/asicmd: Add options to manage ASI page faults
Date:   Mon,  4 May 2020 17:02:34 +0200
Message-Id: <20200504150235.12171-14-alexandre.chartre@oracle.com>
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

Add options to the asicmd CLI to list and clear ASI page faults. Also
add an option to enable/disable displaying stack trace on ASI page
fault.

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
---
 drivers/staging/asi/asicmd.c | 68 ++++++++++++++++++++++++++++++++++--
 1 file changed, 65 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/asi/asicmd.c b/drivers/staging/asi/asicmd.c
index 849fa09423e6..4d7bb9df0fcc 100644
--- a/drivers/staging/asi/asicmd.c
+++ b/drivers/staging/asi/asicmd.c
@@ -52,6 +52,10 @@ static void usage(void)
 	printf("\n");
 	printf("Commands:\n");
 	printf("  all      - run all tests\n");
+	printf("  fault    - list ASI faults\n");
+	printf("  fltclr   - clear ASI faults\n");
+	printf("  stkon    - show stack on ASI fault\n");
+	printf("  stkoff   - do not show stack on ASI fault\n");
 	printf("\n");
 	printf("Tests:\n");
 	for (i = 0; i < TEST_LIST_SIZE; i++)
@@ -91,10 +95,45 @@ static void asidrv_run_test(int fd, struct asidrv_test *test)
 		printf("TEST OK\n");
 }
 
+static int asidrv_fault_list(int fd)
+{
+	struct asidrv_fault_list *flist;
+	int i, rv;
+
+	flist = malloc(sizeof(*flist) +
+		       sizeof(struct asidrv_fault) * 10);
+	if (!flist) {
+		perror("malloc flist");
+		return -1;
+	}
+
+	flist->length = 10;
+	rv = ioctl(fd, ASIDRV_IOCTL_LIST_FAULT, flist);
+	if (rv < 0) {
+		perror("ioctl list fault");
+		return -1;
+	}
+
+	if (!flist->length) {
+		printf("ASI has no fault\n");
+		return 0;
+	}
+
+	printf("%-18s  %5s  %s\n", "ADDRESS", "COUNT", "SYMBOL");
+	for (i = 0; i < flist->length && i < 10; i++) {
+		printf("%#18llx  %5u  %s\n",
+		       flist->fault[i].addr,
+		       flist->fault[i].count,
+		       flist->fault[i].symbol);
+	}
+
+	return 0;
+}
+
 int main(int argc, char *argv[])
 {
 	bool run_all, run;
-	int i, j, fd;
+	int i, j, fd, err;
 	char *test;
 
 	if (argc <= 1) {
@@ -111,10 +150,33 @@ int main(int argc, char *argv[])
 	for (i = 1; i < argc; i++) {
 		test = argv[i];
 
-		if (!strcmp(test, "all"))
+		if (!strcmp(test, "fault")) {
+			asidrv_fault_list(fd);
+			continue;
+
+		} else if (!strcmp(test, "fltclr")) {
+			err = ioctl(fd, ASIDRV_IOCTL_CLEAR_FAULT);
+			if (err)
+				perror("ioctl clear fault");
+			continue;
+
+		} else if (!strcmp(test, "stkon")) {
+			err = ioctl(fd, ASIDRV_IOCTL_LOG_FAULT_STACK, true);
+			if (err)
+				perror("ioctl log fault stack");
+			continue;
+
+		} else if (!strcmp(test, "stkoff")) {
+			err = ioctl(fd, ASIDRV_IOCTL_LOG_FAULT_STACK, false);
+			if (err)
+				perror("ioctl log fault sstack");
+			continue;
+
+		} else if (!strcmp(test, "all")) {
 			run_all = true;
-		else
+		} else {
 			run_all = false;
+		}
 
 		run = false;
 		for (j = 0; j < TEST_LIST_SIZE; j++) {
-- 
2.18.2

