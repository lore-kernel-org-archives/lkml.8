Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F2D0C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 07:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDF2620760
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 07:45:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbgGHHp4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 03:45:56 -0400
Received: from mga17.intel.com ([192.55.52.151]:22902 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726960AbgGHHpw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 03:45:52 -0400
IronPort-SDR: gyncesLDQNQUlKfkLjzz1vIrcbO0A1ATVwICYT9GX/WVSbA4esFUIjPqM07Bny/LtueUVTfOyb
 zo5AHr3aZLKA==
X-IronPort-AV: E=McAfee;i="6000,8403,9675"; a="127835199"
X-IronPort-AV: E=Sophos;i="5.75,327,1589266800"; 
   d="scan'208";a="127835199"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2020 00:45:51 -0700
IronPort-SDR: cWSZwShA7qgJnfyHmpjgGuuvwT3qVgNmZj7ozdWzWQf/mhmk+Ncm/Wo8R/qwZMjunXb6o63wPa
 W7vM2uIJsEZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,327,1589266800"; 
   d="scan'208";a="279872988"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga003.jf.intel.com with ESMTP; 08 Jul 2020 00:45:51 -0700
Received: from [10.249.226.44] (abudanko-mobl.ccr.corp.intel.com [10.249.226.44])
        by linux.intel.com (Postfix) with ESMTP id 74DD85807FC;
        Wed,  8 Jul 2020 00:45:49 -0700 (PDT)
Subject: [PATCH v10 01/15] tools/libperf: avoid internal moving of fdarray fds
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <4af50c95-36f6-7a61-5a22-2949970fe7a5@linux.intel.com>
Organization: Intel Corp.
Message-ID: <37154731-eb32-56cf-ecf0-34fcf34eea37@linux.intel.com>
Date:   Wed, 8 Jul 2020 10:45:48 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <4af50c95-36f6-7a61-5a22-2949970fe7a5@linux.intel.com>
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

