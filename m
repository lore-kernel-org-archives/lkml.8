Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CD90C4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 14:11:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 547C022200
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 14:11:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728137AbgCSOLe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 10:11:34 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:32888 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727966AbgCSOLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 10:11:20 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jEvt4-0002NJ-KD; Thu, 19 Mar 2020 15:11:06 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id EA4E01C22A8;
        Thu, 19 Mar 2020 15:10:56 +0100 (CET)
Date:   Thu, 19 Mar 2020 14:10:56 -0000
From:   "tip-bot2 for Nick Desaulniers" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf diff: Fix undefined string comparison spotted
 by clang's -Wstring-compare
Cc:     Nick Desaulniers <nick.desaulniers@gmail.com>,
        Ian Rogers <irogers@google.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Changbin Du <changbin.du@intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, John Keeping <john@metanate.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Song Liu <songliubraving@fb.com>,
        clang-built-linux@googlegroups.com,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200223193456.25291-1-nick.desaulniers@gmail.com>
References: <20200223193456.25291-1-nick.desaulniers@gmail.com>
MIME-Version: 1.0
Message-ID: <158462705662.28353.6097630422293165073.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     c395c3553d6870541f1c283479aea2a6f26364d5
Gitweb:        https://git.kernel.org/tip/c395c3553d6870541f1c283479aea2a6f26364d5
Author:        Nick Desaulniers <nick.desaulniers@gmail.com>
AuthorDate:    Sun, 23 Feb 2020 11:34:49 -08:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Wed, 04 Mar 2020 10:28:08 -03:00

perf diff: Fix undefined string comparison spotted by clang's -Wstring-compare

clang warns:

  util/block-info.c:298:18: error: result of comparison against a string
  literal is unspecified (use an explicit string comparison function
  instead) [-Werror,-Wstring-compare]
          if ((start_line != SRCLINE_UNKNOWN) && (end_line != SRCLINE_UNKNOWN)) {
                          ^  ~~~~~~~~~~~~~~~
  util/block-info.c:298:51: error: result of comparison against a string
  literal is unspecified (use an explicit string comparison function
  instead) [-Werror,-Wstring-compare]
          if ((start_line != SRCLINE_UNKNOWN) && (end_line != SRCLINE_UNKNOWN)) {
                                                           ^  ~~~~~~~~~~~~~~~
  util/block-info.c:298:18: error: result of comparison against a string
  literal is unspecified (use an explicit string
  comparison function instead) [-Werror,-Wstring-compare]
          if ((start_line != SRCLINE_UNKNOWN) && (end_line != SRCLINE_UNKNOWN)) {
                          ^  ~~~~~~~~~~~~~~~
  util/block-info.c:298:51: error: result of comparison against a string
  literal is unspecified (use an explicit string comparison function
  instead) [-Werror,-Wstring-compare]
          if ((start_line != SRCLINE_UNKNOWN) && (end_line != SRCLINE_UNKNOWN)) {
                                                           ^  ~~~~~~~~~~~~~~~
  util/map.c:434:15: error: result of comparison against a string literal
  is unspecified (use an explicit string comparison function instead)
  [-Werror,-Wstring-compare]
                  if (srcline != SRCLINE_UNKNOWN)
                              ^  ~~~~~~~~~~~~~~~

Reviewer Notes:

Looks good to me. Some more context:
https://clang.llvm.org/docs/DiagnosticsReference.html#wstring-compare
The spec says:
J.1 Unspecified behavior
The following are unspecified:
.. Whether two string literals result in distinct arrays (6.4.5).

Signed-off-by: Nick Desaulniers <nick.desaulniers@gmail.com>
Reviewed-by: Ian Rogers <irogers@google.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Changbin Du <changbin.du@intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: John Keeping <john@metanate.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Song Liu <songliubraving@fb.com>
Cc: clang-built-linux@googlegroups.com
Link: https://github.com/ClangBuiltLinux/linux/issues/900
Link: http://lore.kernel.org/lkml/20200223193456.25291-1-nick.desaulniers@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-diff.c    | 3 ++-
 tools/perf/util/block-info.c | 3 ++-
 tools/perf/util/map.c        | 2 +-
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
index f8b6ae5..c03c36f 100644
--- a/tools/perf/builtin-diff.c
+++ b/tools/perf/builtin-diff.c
@@ -1312,7 +1312,8 @@ static int cycles_printf(struct hist_entry *he, struct hist_entry *pair,
 	end_line = map__srcline(he->ms.map, bi->sym->start + bi->end,
 				he->ms.sym);
 
-	if ((start_line != SRCLINE_UNKNOWN) && (end_line != SRCLINE_UNKNOWN)) {
+	if ((strncmp(start_line, SRCLINE_UNKNOWN, strlen(SRCLINE_UNKNOWN)) != 0) &&
+	    (strncmp(end_line, SRCLINE_UNKNOWN, strlen(SRCLINE_UNKNOWN)) != 0)) {
 		scnprintf(buf, sizeof(buf), "[%s -> %s] %4ld",
 			  start_line, end_line, block_he->diff.cycles);
 	} else {
diff --git a/tools/perf/util/block-info.c b/tools/perf/util/block-info.c
index c4b030b..fbbb6d6 100644
--- a/tools/perf/util/block-info.c
+++ b/tools/perf/util/block-info.c
@@ -295,7 +295,8 @@ static int block_range_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
 	end_line = map__srcline(he->ms.map, bi->sym->start + bi->end,
 				he->ms.sym);
 
-	if ((start_line != SRCLINE_UNKNOWN) && (end_line != SRCLINE_UNKNOWN)) {
+	if ((strncmp(start_line, SRCLINE_UNKNOWN, strlen(SRCLINE_UNKNOWN)) != 0) &&
+	    (strncmp(end_line, SRCLINE_UNKNOWN, strlen(SRCLINE_UNKNOWN)) != 0)) {
 		scnprintf(buf, sizeof(buf), "[%s -> %s]",
 			  start_line, end_line);
 	} else {
diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index a08ca27..9542851 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -431,7 +431,7 @@ int map__fprintf_srcline(struct map *map, u64 addr, const char *prefix,
 
 	if (map && map->dso) {
 		char *srcline = map__srcline(map, addr, NULL);
-		if (srcline != SRCLINE_UNKNOWN)
+		if (strncmp(srcline, SRCLINE_UNKNOWN, strlen(SRCLINE_UNKNOWN)) != 0)
 			ret = fprintf(fp, "%s%s", prefix, srcline);
 		free_srcline(srcline);
 	}
