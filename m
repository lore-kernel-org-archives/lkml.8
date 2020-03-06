Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1431FC10F00
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 19:12:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCDD620714
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 19:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583521922;
	bh=0brzviW2dYOg5GL5dKyfk0SiCXoOUz8EnoaLxh/ehkI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=I/utW/HvuIGi0rPhh3qoGiHtyNYsPj2hdzqDWurNzWSHaB47obgVHhr+DKRuSLeBL
	 h1iqOO/ouTrfzQxFh2aOObuxYTNga0AgYuhhfh37ZYqNz1ytbPrsJjFBPvODMpdJZ+
	 DIGQnRBrOQt6AGtihVOueJn/w6JVLI3pgE0IUuXg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbgCFTMB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 14:12:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:39088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726162AbgCFTL6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 14:11:58 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6C3F20684;
        Fri,  6 Mar 2020 19:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583521917;
        bh=0brzviW2dYOg5GL5dKyfk0SiCXoOUz8EnoaLxh/ehkI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AdeQPfMv30VMnWpv3eu9QEyqZHKlxolxDt9lSBWZW2wLZmbVWx77N2n/TAa0gUCsz
         qgv0HWTZ3LJqX0LWgxIIpGsdWOIvY00g7lziKrWLZ5E9Nxp79QHbX0voKK/ZoKdF0e
         IBdHELhWVGr7hlF+TIwviD/CHXHNz+3kCc2kObm8=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Nick Desaulniers <nick.desaulniers@gmail.com>,
        Ian Rogers <irogers@google.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Changbin Du <changbin.du@intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, John Keeping <john@metanate.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Song Liu <songliubraving@fb.com>,
        clang-built-linux@googlegroups.com,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 1/6] perf diff: Fix undefined string comparision spotted by clang's -Wstring-compare
Date:   Fri,  6 Mar 2020 16:11:34 -0300
Message-Id: <20200306191144.12762-2-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200306191144.12762-1-acme@kernel.org>
References: <20200306191144.12762-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Desaulniers <nick.desaulniers@gmail.com>

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
index f8b6ae557d8b..c03c36fde7e2 100644
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
index c4b030bf6ec2..fbbb6d640dad 100644
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
index a08ca276098e..95428511300d 100644
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
-- 
2.21.1

