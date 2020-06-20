Return-Path: <SRS0=B91b=AB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2CB0C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 06:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD49C238A1
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 06:47:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbgFTGqy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jun 2020 02:46:54 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:34348 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725969AbgFTGqx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jun 2020 02:46:53 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 2E6F5B81707DEAF42771;
        Sat, 20 Jun 2020 14:46:49 +0800 (CST)
Received: from euler.huawei.com (10.175.124.27) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.487.0; Sat, 20 Jun 2020 14:46:39 +0800
From:   Wei Li <liwei391@huawei.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        "Namhyung Kim" <namhyung@kernel.org>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, <guohanjun@huawei.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] perf list: Fix memleak in print_sdt_events()
Date:   Sat, 20 Jun 2020 14:46:20 +0800
Message-ID: <20200620064620.38144-1-liwei391@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.27]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Valgrind check info:
==30629== Command: ./perf list sdt
==30629==
==30629==
==30629== HEAP SUMMARY:
==30629==     in use at exit: 12,226 bytes in 195 blocks
==30629==   total heap usage: 3,239 allocs, 3,044 frees, 3,546,759 bytes allocated
==30629==
==30629== 8,028 bytes in 115 blocks are definitely lost in loss record 54 of 54
==30629==    at 0x4885E44: realloc (vg_replace_malloc.c:785)
==30629==    by 0x56468C3: __vasprintf_chk (in /usr/lib64/libc-2.28.so)
==30629==    by 0x5646723: __asprintf_chk (in /usr/lib64/libc-2.28.so)
==30629==    by 0x4E2C3F: asprintf (stdio2.h:181)
==30629==    by 0x4E2C3F: print_sdt_events (parse-events.c:2611)
==30629==    by 0x446587: cmd_list (builtin-list.c:87)
==30629==    by 0x4B8947: run_builtin (perf.c:312)
==30629==    by 0x4B8C13: handle_internal_command (perf.c:364)
==30629==    by 0x434717: run_argv (perf.c:408)
==30629==    by 0x434717: main (perf.c:538)
==30629==
==30629== LEAK SUMMARY:
==30629==    definitely lost: 8,028 bytes in 115 blocks
==30629==    indirectly lost: 0 bytes in 0 blocks
==30629==      possibly lost: 0 bytes in 0 blocks
==30629==    still reachable: 4,198 bytes in 80 blocks
==30629==         suppressed: 0 bytes in 0 blocks

Signed-off-by: Wei Li <liwei391@huawei.com>
---
 tools/perf/util/parse-events.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 3decbb203846..b2acacd5646e 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -2579,13 +2579,12 @@ void print_sdt_events(const char *subsys_glob, const char *event_glob,
 	struct probe_cache *pcache;
 	struct probe_cache_entry *ent;
 	struct strlist *bidlist, *sdtlist;
-	struct strlist_config cfg = {.dont_dupstr = true};
 	struct str_node *nd, *nd2;
 	char *buf, *path, *ptr = NULL;
 	bool show_detail = false;
 	int ret;
 
-	sdtlist = strlist__new(NULL, &cfg);
+	sdtlist = strlist__new(NULL, NULL);
 	if (!sdtlist) {
 		pr_debug("Failed to allocate new strlist for SDT\n");
 		return;
@@ -2610,8 +2609,10 @@ void print_sdt_events(const char *subsys_glob, const char *event_glob,
 				continue;
 			ret = asprintf(&buf, "%s:%s@%s", ent->pev.group,
 					ent->pev.event, nd->s);
-			if (ret > 0)
+			if (ret > 0) {
 				strlist__add(sdtlist, buf);
+				free(buf);
+			}
 		}
 		probe_cache__delete(pcache);
 	}
-- 
2.19.1

