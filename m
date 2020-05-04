Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6629BC3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 15:05:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35C1420721
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 15:05:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FyGhYMm8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729467AbgEDPFg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 11:05:36 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:55910 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726551AbgEDPFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 11:05:35 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 044ElbOC116459;
        Mon, 4 May 2020 15:05:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=HpLop/q6lU72RED2M2+GV24t44M/xn1HonNpo3nMWgU=;
 b=FyGhYMm8VAft9HHCv0GOjD0jRw7lTwOx0r+xP7qPCr1zVyHsNwtDMFSSGUj/xLBHVsNa
 RC3IQtUYa646xMlbSozveJI/Jx5A7lIFn9dHnzm20i916PMMA+47ILesv3oV/gJKn/9V
 bCpiHn6JIF2D7x34SXOuY7gZtTzzjXxSlLP0NmvXrBHta/9mleqwO0vmp519mffuwxsG
 yah9mPj0rq3NXoP3cuw2q3W91aZxqxzN8FpX8PpAXsvS3v2Xly4RbngLuE3bKY5OaPM2
 SjVcbYT5jBd/jog3TpJQPJe6+GTrTE+DOSIQr0gC2c0Ytf1BpuD8KzKM+Quk+Dwwp6wm rw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 30s09qyh0x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 May 2020 15:05:03 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 044ElaIM053343;
        Mon, 4 May 2020 15:05:03 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 30t1r2f99h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 May 2020 15:05:03 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 044F51Zt028984;
        Mon, 4 May 2020 15:05:01 GMT
Received: from linux-1.home.com (/10.175.9.166)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 04 May 2020 08:05:01 -0700
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        x86@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     pbonzini@redhat.com, konrad.wilk@oracle.com,
        jan.setjeeilers@oracle.com, liran.alon@oracle.com,
        junaids@google.com, graf@amazon.de, rppt@linux.vnet.ibm.com,
        kuzuno@gmail.com, mgross@linux.intel.com,
        alexandre.chartre@oracle.com
Subject: [RFC v4][PATCH part-3 14/14] asidrv/asicmd: Add options to manage ASI mapped VA ranges
Date:   Mon,  4 May 2020 17:02:35 +0200
Message-Id: <20200504150235.12171-15-alexandre.chartre@oracle.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20200504150235.12171-1-alexandre.chartre@oracle.com>
References: <20200504150235.12171-1-alexandre.chartre@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9610 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 suspectscore=2
 spamscore=0 mlxlogscore=999 malwarescore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005040123
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9610 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 clxscore=1015 suspectscore=2
 priorityscore=1501 malwarescore=0 mlxlogscore=999 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005040123
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add options to the asicmd CLI to list, add and clear ASI mapped
VA ranges.

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
---
 drivers/staging/asi/asicmd.c | 243 +++++++++++++++++++++++++++++++++++
 1 file changed, 243 insertions(+)

diff --git a/drivers/staging/asi/asicmd.c b/drivers/staging/asi/asicmd.c
index 4d7bb9df0fcc..974a3147a313 100644
--- a/drivers/staging/asi/asicmd.c
+++ b/drivers/staging/asi/asicmd.c
@@ -16,6 +16,10 @@
 
 #include "asidrv.h"
 
+static const char * const page_table_level[] = {
+	"PTE", "PMD", "PUD", "P4D", "PGD"
+};
+
 struct asidrv_test {
 	char		*name;		/* test name */
 	enum asidrv_seqnum seqnum;	/* sequence */
@@ -56,12 +60,25 @@ static void usage(void)
 	printf("  fltclr   - clear ASI faults\n");
 	printf("  stkon    - show stack on ASI fault\n");
 	printf("  stkoff   - do not show stack on ASI fault\n");
+	printf("  map      - list ASI mappings\n");
+	printf("  mapadd   - add ASI mappings\n");
+	printf("  mapclr   - clear ASI mapping\n");
 	printf("\n");
 	printf("Tests:\n");
 	for (i = 0; i < TEST_LIST_SIZE; i++)
 		printf("  %-10s - %s\n", test_list[i].name, test_list[i].desc);
 }
 
+static void usage_mapadd(void)
+{
+	printf("usage: asicmd mapadd [percpu:]<addr>:<size>[:<level>]\n");
+}
+
+static void usage_mapclr(void)
+{
+	printf("usage: asicmd mapclr [percpu:]<addr>\n");
+}
+
 static void asidrv_run_test(int fd, struct asidrv_test *test)
 {
 	struct asidrv_run_param rparam;
@@ -130,6 +147,210 @@ static int asidrv_fault_list(int fd)
 	return 0;
 }
 
+static int asidrv_map_list(int fd)
+{
+	struct asidrv_mapping_list *mlist;
+	int level;
+	int i, rv, len = 64;
+
+	mlist = malloc(sizeof(*mlist) +
+		       sizeof(struct asidrv_mapping) * len);
+	if (!mlist) {
+		perror("malloc mlist");
+		return -1;
+	}
+
+	mlist->length = len;
+	rv = ioctl(fd, ASIDRV_IOCTL_LIST_MAPPING, mlist);
+	if (rv < 0) {
+		perror("ioctl list mapping");
+		return -1;
+	}
+
+	if (!mlist->length) {
+		printf("ASI has no mapping\n");
+		return 0;
+	}
+
+	printf("%-18s  %18s  %s\n", "ADDRESS", "SIZE", "LEVEL");
+	for (i = 0; i < mlist->length && i < len; i++) {
+		printf("%#18llx  %#18llx  ",
+		       mlist->mapping[i].addr,
+		       mlist->mapping[i].size);
+		level = mlist->mapping[i].level;
+		if (level < 5)
+			printf("%5s\n", page_table_level[level]);
+		else
+			printf("%5d\n", level);
+	}
+	printf("Mapping List: %d/%d\n", i, mlist->length);
+
+	return 0;
+}
+
+static char *asidrv_skip_percpu(char *str, bool *percpup)
+{
+	int len = sizeof("percpu:") - 1;
+
+	if (!strncmp(str, "percpu:", len)) {
+		str += len;
+		*percpup = true;
+	} else {
+		*percpup = false;
+	}
+
+	return str;
+}
+
+static int asidrv_parse_mapping_clear(char *arg, struct asidrv_mapping *mapping)
+{
+	char  *s, *end;
+	bool percpu;
+	__u64 addr;
+
+	s = asidrv_skip_percpu(arg, &percpu);
+
+	addr = strtoull(s, &end, 0);
+	if (*end != 0) {
+		printf("invalid mapping address '%s'\n", s);
+		return -1;
+	}
+
+	printf("mapclr %llx%s\n", addr, percpu ? " percpu" : "");
+
+	mapping->addr = addr;
+	mapping->size = 0;
+	mapping->level = 0;
+	mapping->percpu = percpu;
+
+	return 0;
+}
+
+static int asidrv_parse_mapping_add(char *arg, struct asidrv_mapping *mapping)
+{
+	char *s, *end;
+	__u64 addr, size;
+	__u32 level;
+	bool percpu;
+	int i;
+
+	s = asidrv_skip_percpu(arg, &percpu);
+
+	s = strtok(s, ":");
+	if (!s) {
+		printf("mapadd: <addr> not found\n");
+		return -1;
+	}
+
+	addr = strtoull(s, &end, 0);
+	if (*end != 0) {
+		printf("invalid mapping address '%s'\n", s);
+		return -1;
+	}
+
+	s = strtok(NULL, ":");
+	if (!s) {
+		printf("mapadd: <size> not found\n");
+		return -1;
+	}
+	size = strtoull(s, &end, 0);
+	if (*end != 0) {
+		printf("mapadd: invalid size %s\n", s);
+		return -1;
+	}
+
+	s = strtok(NULL, ":");
+	if (!s) {
+		level = 0;
+	} else {
+		/* lookup page table level name */
+		level = -1;
+		for (i = 0; i < 5; i++) {
+			if (!strcasecmp(s, page_table_level[i])) {
+				level = i;
+				break;
+			}
+		}
+		if (level == -1) {
+			level = strtoul(s, &end, 0);
+			if (*end != 0 || level >= 5) {
+				printf("mapadd: invalid level %s\n", s);
+				return -1;
+			}
+		}
+	}
+
+	printf("mapadd %llx/%llx/%u%s\n", addr, size, level,
+	       percpu ? " percpu" : "");
+
+	mapping->addr = addr;
+	mapping->size = size;
+	mapping->level = level;
+	mapping->percpu = percpu;
+
+	return 0;
+}
+
+static int asidrv_map_change(int fd, unsigned long cmd, char *arg)
+{
+	struct asidrv_mapping_list *mlist;
+	int i, count, err;
+	char *s;
+
+	count = 0;
+	for (s = arg; s; s = strchr(s + 1, ','))
+		count++;
+
+	mlist = malloc(sizeof(mlist) + sizeof(struct asidrv_mapping) * count);
+	if (!mlist) {
+		perror("malloc mapping list");
+		return -ENOMEM;
+	}
+
+	for (i = 0; i < count; i++) {
+		s = strchr(arg, ',');
+		if (s)
+			s[0] = '\0';
+
+		if (cmd == ASIDRV_IOCTL_ADD_MAPPING) {
+			err = asidrv_parse_mapping_add(arg,
+						       &mlist->mapping[i]);
+		} else {
+			err = asidrv_parse_mapping_clear(arg,
+							 &mlist->mapping[i]);
+		}
+		if (err)
+			goto done;
+		arg = s + 1;
+	}
+
+	mlist->length = count;
+	err = ioctl(fd, cmd, mlist);
+	if (err < 0) {
+		perror("ioctl mapping");
+		err = errno;
+	} else if (err > 0) {
+		/* partial error */
+		printf("ioctl mapping: partial failure (%d/%d)\n",
+		       err, count);
+		for (i = 0; i < count; i++) {
+			printf("  %#llx: ", mlist->mapping[i].addr);
+			if (i < err)
+				printf("done\n");
+			else if (i == err)
+				printf("failed\n");
+			else
+				printf("not done\n");
+		}
+		err = -1;
+	}
+
+done:
+	free(mlist);
+
+	return err;
+}
+
 int main(int argc, char *argv[])
 {
 	bool run_all, run;
@@ -172,6 +393,28 @@ int main(int argc, char *argv[])
 				perror("ioctl log fault sstack");
 			continue;
 
+		} else if (!strcmp(test, "map")) {
+			asidrv_map_list(fd);
+			continue;
+
+		} else if (!strcmp(test, "mapadd")) {
+			if (++i >= argc) {
+				usage_mapadd();
+				return 2;
+			}
+			asidrv_map_change(fd, ASIDRV_IOCTL_ADD_MAPPING,
+					  argv[i]);
+			continue;
+
+		} else if (!strcmp(test, "mapclr")) {
+			if (++i >= argc) {
+				usage_mapclr();
+				return 2;
+			}
+			asidrv_map_change(fd, ASIDRV_IOCTL_CLEAR_MAPPING,
+					  argv[i]);
+			continue;
+
 		} else if (!strcmp(test, "all")) {
 			run_all = true;
 		} else {
-- 
2.18.2

