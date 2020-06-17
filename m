Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16DEDC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 08:35:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF15F2071A
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 08:35:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbgFQIfP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 04:35:15 -0400
Received: from mga09.intel.com ([134.134.136.24]:54407 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725967AbgFQIfP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 04:35:15 -0400
IronPort-SDR: qXqrtrXfFse8L5uWRcPTIcU8M6fviWNgYm//+Go/Wb8wUqBjTOHHrftrLOm9tKSRLVf33Gn0jj
 D18SQvKPflqQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2020 01:35:14 -0700
IronPort-SDR: CPl2CAlGSHear34zg8DRRs2qY4HgWSkP5KExPyafBurCQ2F9vlc6vK65blbeJgeng2Ekj631cJ
 krCOo1coEnMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,522,1583222400"; 
   d="scan'208";a="273449186"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga003.jf.intel.com with ESMTP; 17 Jun 2020 01:35:14 -0700
Received: from [10.249.225.191] (abudanko-mobl.ccr.corp.intel.com [10.249.225.191])
        by linux.intel.com (Postfix) with ESMTP id BE20B580223;
        Wed, 17 Jun 2020 01:35:12 -0700 (PDT)
Subject: [PATCH v8 01/13] tools/libperf: avoid moving of fds at
 fdarray__filter() call
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <0781a077-aa82-5b4a-273e-c17372a72b93@linux.intel.com>
Organization: Intel Corp.
Message-ID: <3d36dc7a-4249-096c-7554-80e6d290eac5@linux.intel.com>
Date:   Wed, 17 Jun 2020 11:35:11 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <0781a077-aa82-5b4a-273e-c17372a72b93@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Skip fds with zeroed revents field from count and avoid fds moving
at fdarray__filter() call so fds indices returned by fdarray__add()
call stay the same and can be used for direct access and processing
of fd revents status field at entries array of struct fdarray object.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 tools/lib/api/fd/array.c   | 11 +++++------
 tools/perf/tests/fdarray.c | 20 ++------------------
 2 files changed, 7 insertions(+), 24 deletions(-)

diff --git a/tools/lib/api/fd/array.c b/tools/lib/api/fd/array.c
index 58d44d5eee31..97843a837370 100644
--- a/tools/lib/api/fd/array.c
+++ b/tools/lib/api/fd/array.c
@@ -93,22 +93,21 @@ int fdarray__filter(struct fdarray *fda, short revents,
 		return 0;
 
 	for (fd = 0; fd < fda->nr; ++fd) {
+		if (!fda->entries[fd].revents)
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

