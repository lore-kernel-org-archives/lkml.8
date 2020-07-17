Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D247FC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 06:59:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B73E62071A
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 06:59:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728009AbgGQG7R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 02:59:17 -0400
Received: from mga05.intel.com ([192.55.52.43]:9062 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726426AbgGQG7R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 02:59:17 -0400
IronPort-SDR: A7IlkHLH33zEGOVSU90kNRjJd2T4UjmjYr/7Bv4R/OZb4k5UjlmyWFb5fiNySog3yo6uBos3Fi
 xg9UFAiDboPA==
X-IronPort-AV: E=McAfee;i="6000,8403,9684"; a="234398719"
X-IronPort-AV: E=Sophos;i="5.75,362,1589266800"; 
   d="scan'208";a="234398719"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2020 23:59:16 -0700
IronPort-SDR: LXjEkZzjSWdCEohMwXBZny+7QYC/vz/DYcs3tVmMOm2M9j2roo2ro3yTb/t6rgao10EiISXbk9
 wF3JobaPmZLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,362,1589266800"; 
   d="scan'208";a="486378432"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga006.fm.intel.com with ESMTP; 16 Jul 2020 23:59:16 -0700
Received: from [10.249.224.34] (abudanko-mobl.ccr.corp.intel.com [10.249.224.34])
        by linux.intel.com (Postfix) with ESMTP id 242AE580100;
        Thu, 16 Jul 2020 23:59:13 -0700 (PDT)
Subject: [PATCH v12 01/15] tools/libperf: avoid internal moving of fdarray fds
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <8d91c3a0-3db4-0a7a-ae13-299adb444bd6@linux.intel.com>
Organization: Intel Corp.
Message-ID: <676844f8-55d3-c628-23db-aa163a81519e@linux.intel.com>
Date:   Fri, 17 Jul 2020 09:59:12 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <8d91c3a0-3db4-0a7a-ae13-299adb444bd6@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Avoid moving of fds by fdarray__filter() so fds indices returned
by fdarray__add() can be used for access and processing of
objects at struct pollfd *entries.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/lib/api/fd/array.c   | 11 +++++------
 tools/perf/tests/fdarray.c | 20 ++------------------
 2 files changed, 7 insertions(+), 24 deletions(-)

diff --git a/tools/lib/api/fd/array.c b/tools/lib/api/fd/array.c
index 58d44d5eee31..89f9a2193c2d 100644
--- a/tools/lib/api/fd/array.c
+++ b/tools/lib/api/fd/array.c
@@ -93,22 +93,21 @@ int fdarray__filter(struct fdarray *fda, short revents,
 		return 0;
 
 	for (fd = 0; fd < fda->nr; ++fd) {
+		if (!fda->entries[fd].events)
+			continue;
+
 		if (fda->entries[fd].revents & revents) {
 			if (entry_destructor)
 				entry_destructor(fda, fd, arg);
 
+			fda->entries[fd].revents = fda->entries[fd].events = 0;
 			continue;
 		}
 
-		if (fd != nr) {
-			fda->entries[nr] = fda->entries[fd];
-			fda->priv[nr]	 = fda->priv[fd];
-		}
-
 		++nr;
 	}
 
-	return fda->nr = nr;
+	return nr;
 }
 
 int fdarray__poll(struct fdarray *fda, int timeout)
diff --git a/tools/perf/tests/fdarray.c b/tools/perf/tests/fdarray.c
index c7c81c4a5b2b..d0c8a05aab2f 100644
--- a/tools/perf/tests/fdarray.c
+++ b/tools/perf/tests/fdarray.c
@@ -12,6 +12,7 @@ static void fdarray__init_revents(struct fdarray *fda, short revents)
 
 	for (fd = 0; fd < fda->nr; ++fd) {
 		fda->entries[fd].fd	 = fda->nr - fd;
+		fda->entries[fd].events  = revents;
 		fda->entries[fd].revents = revents;
 	}
 }
@@ -29,7 +30,7 @@ static int fdarray__fprintf_prefix(struct fdarray *fda, const char *prefix, FILE
 
 int test__fdarray__filter(struct test *test __maybe_unused, int subtest __maybe_unused)
 {
-	int nr_fds, expected_fd[2], fd, err = TEST_FAIL;
+	int nr_fds, err = TEST_FAIL;
 	struct fdarray *fda = fdarray__new(5, 5);
 
 	if (fda == NULL) {
@@ -55,7 +56,6 @@ int test__fdarray__filter(struct test *test __maybe_unused, int subtest __maybe_
 
 	fdarray__init_revents(fda, POLLHUP);
 	fda->entries[2].revents = POLLIN;
-	expected_fd[0] = fda->entries[2].fd;
 
 	pr_debug("\nfiltering all but fda->entries[2]:");
 	fdarray__fprintf_prefix(fda, "before", stderr);
@@ -66,17 +66,9 @@ int test__fdarray__filter(struct test *test __maybe_unused, int subtest __maybe_
 		goto out_delete;
 	}
 
-	if (fda->entries[0].fd != expected_fd[0]) {
-		pr_debug("\nfda->entries[0].fd=%d != %d\n",
-			 fda->entries[0].fd, expected_fd[0]);
-		goto out_delete;
-	}
-
 	fdarray__init_revents(fda, POLLHUP);
 	fda->entries[0].revents = POLLIN;
-	expected_fd[0] = fda->entries[0].fd;
 	fda->entries[3].revents = POLLIN;
-	expected_fd[1] = fda->entries[3].fd;
 
 	pr_debug("\nfiltering all but (fda->entries[0], fda->entries[3]):");
 	fdarray__fprintf_prefix(fda, "before", stderr);
@@ -88,14 +80,6 @@ int test__fdarray__filter(struct test *test __maybe_unused, int subtest __maybe_
 		goto out_delete;
 	}
 
-	for (fd = 0; fd < 2; ++fd) {
-		if (fda->entries[fd].fd != expected_fd[fd]) {
-			pr_debug("\nfda->entries[%d].fd=%d != %d\n", fd,
-				 fda->entries[fd].fd, expected_fd[fd]);
-			goto out_delete;
-		}
-	}
-
 	pr_debug("\n");
 
 	err = 0;
-- 
2.24.1


