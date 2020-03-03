Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49BD7C3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 06:25:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2380F20828
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 06:25:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbgCCGZb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 01:25:31 -0500
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:60462 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727398AbgCCGZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 01:25:30 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R751e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04455;MF=teawaterz@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0TrXLIVw_1583216718;
Received: from localhost(mailfrom:teawaterz@linux.alibaba.com fp:SMTPD_---0TrXLIVw_1583216718)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 03 Mar 2020 14:25:26 +0800
From:   Hui Zhu <teawater@gmail.com>
To:     fengguang.wu@qq.com, linux-kernel@vger.kernel.org
Cc:     Hui Zhu <teawater@gmail.com>, Hui Zhu <teawaterz@linux.alibaba.com>
Subject: [PATCH for vm-scalability] usemem: Add new option --fragmentation for generating fragmented pages
Date:   Tue,  3 Mar 2020 14:25:15 +0800
Message-Id: <1583216715-29511-1-git-send-email-teawater@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds new option --fragmentation.  usemem will generate
size/2/pagesize fragmented pages with this option.
Its implementation is to use madvise to release a page every other page.
For example:
usemem --fragment -s -1 400m
Ideally, this command will generate 200m fragmented pages in the system.

This command can help test anti-fragmentation function and other features
that are affected by fragmentation issues of the Linux kernel.

Signed-off-by: Hui Zhu <teawaterz@linux.alibaba.com>
---
 usemem.c | 51 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 50 insertions(+), 1 deletion(-)

diff --git a/usemem.c b/usemem.c
index 9ac36e4..10e8874 100644
--- a/usemem.c
+++ b/usemem.c
@@ -95,6 +95,7 @@ int opt_sync_free = 0;
 int opt_bind_interval = 0;
 unsigned long opt_delay = 0;
 int opt_read_again = 0;
+int opt_fragmentation = 0;
 int nr_task;
 int nr_thread;
 int nr_cpu;
@@ -153,6 +154,7 @@ void usage(int ok)
 	"    -O|--anonymous      mmap with MAP_ANONYMOUS\n"
 	"    -U|--hugetlb        allocate hugetlbfs page\n"
 	"    -Z|--read-again     read memory again after access the memory\n"
+	"    --fragmentation     generate size/2/pagesize fragmented pages\n"
 	"    -h|--help           show this message\n"
 	,		ourname);
 
@@ -191,6 +193,7 @@ static const struct option opts[] = {
 	{ "delay"	, 1, NULL, 'e' },
 	{ "hugetlb"	, 0, NULL, 'U' },
 	{ "read-again"	, 0, NULL, 'Z' },
+	{ "fragmentation", 0, NULL, 0 },
 	{ "help"	, 0, NULL, 'h' },
 	{ NULL		, 0, NULL, 0 }
 };
@@ -655,6 +658,26 @@ static void timing_free(void *ptrs[], unsigned int nptr,
 
 static void wait_for_sigusr1(int signal) {}
 
+static void do_fragmentation(void *addr, unsigned long len)
+{
+	unsigned long offset;
+	int should_free = 1;
+
+	for (offset = 0; offset <= len - pagesize; offset += pagesize) {
+		if (should_free) {
+			if (madvise(addr + offset, pagesize,
+				MADV_DONTNEED) != 0) {
+				fprintf(stderr,
+					"msync failed with error %s\n",
+					strerror(errno));
+				exit(1);
+			}
+			should_free = 0;
+		} else
+			should_free = 1;
+	}
+}
+
 long do_units(void)
 {
 	struct drand48_data rand_data;
@@ -752,6 +775,15 @@ long do_units(void)
 		}
 	}
 
+	if (opt_fragmentation) {
+		if (prealloc)
+			do_fragmentation(prealloc, opt_bytes);
+		else {
+			for (i = 0; i < nptr; i++)
+				do_fragmentation(ptrs[i], lens[i]);
+		}
+	}
+
 	while (sleep_secs)
 		sleep_secs = sleep(sleep_secs);
 
@@ -896,6 +928,7 @@ int do_tasks(void)
 int main(int argc, char *argv[])
 {
 	int c;
+	int opt_index = 0;
 
 #ifdef DBG
 	/* print the command line parameters passed on to main */
@@ -910,9 +943,18 @@ int main(int argc, char *argv[])
 	pagesize = getpagesize();
 
 	while ((c = getopt_long(argc, argv,
-				"aAB:f:FPp:gqowRMm:n:t:b:ds:T:Sr:u:j:e:EHDNLWyxOUZh", opts, NULL)) != -1)
+				"aAB:f:FPp:gqowRMm:n:t:b:ds:T:Sr:u:j:e:EHDNLWyxOUZh",
+				opts, &opt_index)) != -1)
 		{
 		switch (c) {
+		case 0:
+			if (strcmp(opts[opt_index].name,
+				"fragmentation") == 0) {
+				opt_fragmentation = 1;
+			} else
+				usage(1);
+			break;
+
 		case 'a':
 			opt_malloc++;
 			break;
@@ -1045,6 +1087,13 @@ int main(int argc, char *argv[])
 		}
 	}
 
+	if (opt_fragmentation && opt_malloc) {
+		fprintf(stderr,
+			"%s: malloc options ignored for fragmentation\n",
+			ourname);
+		opt_malloc = 0;
+	}
+
 	if (opt_malloc) {
 		if (map_populate|map_anonymous|map_hugetlb)
 			fprintf(stderr,
-- 
2.7.4

