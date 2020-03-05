Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47026C3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 10:47:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23FF62073D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 10:47:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbgCEKrd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 05:47:33 -0500
Received: from mail.windriver.com ([147.11.1.11]:52070 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbgCEKrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 05:47:32 -0500
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail.windriver.com (8.15.2/8.15.2) with ESMTPS id 025AlMc0007664
        (version=TLSv1 cipher=AES256-SHA bits=256 verify=FAIL);
        Thu, 5 Mar 2020 02:47:22 -0800 (PST)
Received: from pek-lpg-core2.corp.ad.wrs.com (128.224.153.41) by
 ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
 14.3.487.0; Thu, 5 Mar 2020 02:47:21 -0800
From:   <zhe.he@windriver.com>
To:     <acme@redhat.com>, <jolsa@kernel.org>, <ak@linux.intel.com>,
        <meyerk@hpe.com>, <linux-kernel@vger.kernel.org>,
        <zhe.he@windriver.com>
Subject: [PATCH] perf: Fix crash due to null pointer dereference when iterating cpu map
Date:   Thu, 5 Mar 2020 18:47:19 +0800
Message-ID: <1583405239-352868-1-git-send-email-zhe.he@windriver.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: He Zhe <zhe.he@windriver.com>

NULL pointer may be passed to perf_cpu_map__cpu and then cause the
following crash.

perf ftrace -G start_kernel ls
failed to set tracing filters
[  208.710716] perf[341]: segfault at 4 ip 00000000567c7c98
               sp 00000000ff937ae0 error 4 in perf[56630000+1b2000]
[  208.724778] Code: fc ff ff e8 aa 9b 01 00 8d b4 26 00 00 00 00 8d
                     76 00 55 89 e5 83 ec 18 65 8b 0d 14 00 00 00 89
                     4d f4 31 c9 8b 45 08 8b9
Segmentation fault

Program received signal SIGSEGV, Segmentation fault.
0x5677dc98 in perf_cpu_map__cpu (cpus=0x0, idx=0) at cpumap.c:250
250     cpumap.c: No such file or directory.
(gdb) bt
0  0x5677dc98 in perf_cpu_map__cpu (cpus=0x0, idx=0) at cpumap.c:250
1  0x566790bd in evlist__close (evlist=0x56a6f470) at util/evlist.c:1222
2  0x566792aa in evlist__delete (evlist=evlist@entry=0x56a6f470)
   at util/evlist.c:152
3  0x5667936b in evlist__delete (evlist=0x56a6f470) at util/evlist.c:148
4  0x565efd39 in cmd_ftrace (argc=1, argv=0xffffdd18) at builtin-ftrace.c:520
5  0x56660ee7 in run_builtin (p=0x56993004 <commands+324>, argc=4,
   argv=0xffffdd18) at perf.c:312
6  0x565e7fae in handle_internal_command (argv=<optimized out>,
   argc=<optimized out>) at perf.c:364
7  run_argv (argcp=<optimized out>, argv=<optimized out>) at perf.c:408
8  main (argc=<optimized out>, argv=<optimized out>) at perf.c:538

Add null pointer check for iteration and NULL assignment for all_cpus.
And there is no need to iterate if there is no cpus.

Signed-off-by: He Zhe <zhe.he@windriver.com>
---
 tools/lib/perf/cpumap.c | 4 ++--
 tools/lib/perf/evlist.c | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/lib/perf/cpumap.c b/tools/lib/perf/cpumap.c
index f93f4e703e4c..128386647ac0 100644
--- a/tools/lib/perf/cpumap.c
+++ b/tools/lib/perf/cpumap.c
@@ -247,7 +247,7 @@ struct perf_cpu_map *perf_cpu_map__new(const char *cpu_list)
 
 int perf_cpu_map__cpu(const struct perf_cpu_map *cpus, int idx)
 {
-	if (idx < cpus->nr)
+	if (cpus && idx < cpus->nr)
 		return cpus->map[idx];
 
 	return -1;
@@ -255,7 +255,7 @@ int perf_cpu_map__cpu(const struct perf_cpu_map *cpus, int idx)
 
 int perf_cpu_map__nr(const struct perf_cpu_map *cpus)
 {
-	return cpus ? cpus->nr : 1;
+	return cpus ? cpus->nr : 0;
 }
 
 bool perf_cpu_map__empty(const struct perf_cpu_map *map)
diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
index ae9e65aa2491..d57adf3020fe 100644
--- a/tools/lib/perf/evlist.c
+++ b/tools/lib/perf/evlist.c
@@ -127,6 +127,7 @@ void perf_evlist__exit(struct perf_evlist *evlist)
 	perf_cpu_map__put(evlist->cpus);
 	perf_thread_map__put(evlist->threads);
 	evlist->cpus = NULL;
+	evlist->all_cpus = NULL;
 	evlist->threads = NULL;
 	fdarray__exit(&evlist->pollfd);
 }
-- 
2.24.1

