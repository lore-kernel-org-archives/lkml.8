Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FB17C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 06:59:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A8B420704
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 06:59:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728042AbgGQG7v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 02:59:51 -0400
Received: from mga17.intel.com ([192.55.52.151]:17320 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726166AbgGQG7u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 02:59:50 -0400
IronPort-SDR: A+IR1kih0wDa3HCcOJKzadX8r85b7nk0/mLO2DXuE/Haf4HRTPDI32P9HnDz2eVQ7YpaG1gqoO
 K2zawTKORwGQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9684"; a="129630715"
X-IronPort-AV: E=Sophos;i="5.75,362,1589266800"; 
   d="scan'208";a="129630715"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2020 23:59:49 -0700
IronPort-SDR: GnPs/Ylni2lzkCyXvsCxlWvF8fPvWMhsb9pTOVFll9cKB4kxpJKfmscoJllM2zwRds/bOMRd4a
 1L6bUHG5RMsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,362,1589266800"; 
   d="scan'208";a="318685440"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga002.fm.intel.com with ESMTP; 16 Jul 2020 23:59:48 -0700
Received: from [10.249.224.34] (abudanko-mobl.ccr.corp.intel.com [10.249.224.34])
        by linux.intel.com (Postfix) with ESMTP id A08115801CF;
        Thu, 16 Jul 2020 23:59:46 -0700 (PDT)
Subject: [PATCH v12 02/15] tools/libperf: add flags to fdarray fds objects
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
Message-ID: <6b7d43ff-0801-d5dd-4e90-fcd86b17c1c8@linux.intel.com>
Date:   Fri, 17 Jul 2020 09:59:45 +0300
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


Store flags per struct pollfd *entries object in a bitmap of int size.
Implement fdarray_flag__nonfilterable flag to skip object from counting
by fdarray__filter(). Fixed fdarray test issue reported by kernel test
robot.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Reported-by: kernel test robot <rong.a.chen@intel.com>
---
 tools/lib/api/fd/array.c                 |  9 +++++++--
 tools/lib/api/fd/array.h                 | 16 ++++++++++++----
 tools/lib/perf/evlist.c                  |  6 +++---
 tools/lib/perf/include/internal/evlist.h |  2 +-
 tools/perf/tests/fdarray.c               |  2 +-
 tools/perf/util/evlist.c                 |  2 +-
 6 files changed, 25 insertions(+), 12 deletions(-)

diff --git a/tools/lib/api/fd/array.c b/tools/lib/api/fd/array.c
index 89f9a2193c2d..01b3b89f9797 100644
--- a/tools/lib/api/fd/array.c
+++ b/tools/lib/api/fd/array.c
@@ -8,6 +8,7 @@
 #include <poll.h>
 #include <stdlib.h>
 #include <unistd.h>
+#include <string.h>
 
 void fdarray__init(struct fdarray *fda, int nr_autogrow)
 {
@@ -19,7 +20,7 @@ void fdarray__init(struct fdarray *fda, int nr_autogrow)
 
 int fdarray__grow(struct fdarray *fda, int nr)
 {
-	void *priv;
+	struct priv *priv;
 	int nr_alloc = fda->nr_alloc + nr;
 	size_t psize = sizeof(fda->priv[0]) * nr_alloc;
 	size_t size  = sizeof(struct pollfd) * nr_alloc;
@@ -34,6 +35,9 @@ int fdarray__grow(struct fdarray *fda, int nr)
 		return -ENOMEM;
 	}
 
+	memset(&entries[fda->nr_alloc], 0, sizeof(struct pollfd) * nr);
+	memset(&priv[fda->nr_alloc], 0, sizeof(fda->priv[0]) * nr);
+
 	fda->nr_alloc = nr_alloc;
 	fda->entries  = entries;
 	fda->priv     = priv;
@@ -69,7 +73,7 @@ void fdarray__delete(struct fdarray *fda)
 	free(fda);
 }
 
-int fdarray__add(struct fdarray *fda, int fd, short revents)
+int fdarray__add(struct fdarray *fda, int fd, short revents, enum fdarray_flags flags)
 {
 	int pos = fda->nr;
 
@@ -79,6 +83,7 @@ int fdarray__add(struct fdarray *fda, int fd, short revents)
 
 	fda->entries[fda->nr].fd     = fd;
 	fda->entries[fda->nr].events = revents;
+	fda->priv[fda->nr].flags = flags;
 	fda->nr++;
 	return pos;
 }
diff --git a/tools/lib/api/fd/array.h b/tools/lib/api/fd/array.h
index b39557d1a88f..7fcf21a33c0c 100644
--- a/tools/lib/api/fd/array.h
+++ b/tools/lib/api/fd/array.h
@@ -21,19 +21,27 @@ struct fdarray {
 	int	       nr_alloc;
 	int	       nr_autogrow;
 	struct pollfd *entries;
-	union {
-		int    idx;
-		void   *ptr;
+	struct priv {
+		union {
+			int    idx;
+			void   *ptr;
+		};
+		unsigned int flags;
 	} *priv;
 };
 
+enum fdarray_flags {
+	fdarray_flag__default	    = 0x00000000,
+	fdarray_flag__nonfilterable = 0x00000001
+};
+
 void fdarray__init(struct fdarray *fda, int nr_autogrow);
 void fdarray__exit(struct fdarray *fda);
 
 struct fdarray *fdarray__new(int nr_alloc, int nr_autogrow);
 void fdarray__delete(struct fdarray *fda);
 
-int fdarray__add(struct fdarray *fda, int fd, short revents);
+int fdarray__add(struct fdarray *fda, int fd, short revents, enum fdarray_flags flags);
 int fdarray__poll(struct fdarray *fda, int timeout);
 int fdarray__filter(struct fdarray *fda, short revents,
 		    void (*entry_destructor)(struct fdarray *fda, int fd, void *arg),
diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
index 6a875a0f01bb..2208444ecb44 100644
--- a/tools/lib/perf/evlist.c
+++ b/tools/lib/perf/evlist.c
@@ -305,9 +305,9 @@ int perf_evlist__alloc_pollfd(struct perf_evlist *evlist)
 }
 
 int perf_evlist__add_pollfd(struct perf_evlist *evlist, int fd,
-			    void *ptr, short revent)
+			    void *ptr, short revent, enum fdarray_flags flags)
 {
-	int pos = fdarray__add(&evlist->pollfd, fd, revent | POLLERR | POLLHUP);
+	int pos = fdarray__add(&evlist->pollfd, fd, revent | POLLERR | POLLHUP, flags);
 
 	if (pos >= 0) {
 		evlist->pollfd.priv[pos].ptr = ptr;
@@ -488,7 +488,7 @@ mmap_per_evsel(struct perf_evlist *evlist, struct perf_evlist_mmap_ops *ops,
 		revent = !overwrite ? POLLIN : 0;
 
 		if (!evsel->system_wide &&
-		    perf_evlist__add_pollfd(evlist, fd, map, revent) < 0) {
+		    perf_evlist__add_pollfd(evlist, fd, map, revent, fdarray_flag__default) < 0) {
 			perf_mmap__put(map);
 			return -1;
 		}
diff --git a/tools/lib/perf/include/internal/evlist.h b/tools/lib/perf/include/internal/evlist.h
index 74dc8c3f0b66..2d0fa02b036f 100644
--- a/tools/lib/perf/include/internal/evlist.h
+++ b/tools/lib/perf/include/internal/evlist.h
@@ -45,7 +45,7 @@ struct perf_evlist_mmap_ops {
 
 int perf_evlist__alloc_pollfd(struct perf_evlist *evlist);
 int perf_evlist__add_pollfd(struct perf_evlist *evlist, int fd,
-			    void *ptr, short revent);
+			    void *ptr, short revent, enum fdarray_flags flags);
 
 int perf_evlist__mmap_ops(struct perf_evlist *evlist,
 			  struct perf_evlist_mmap_ops *ops,
diff --git a/tools/perf/tests/fdarray.c b/tools/perf/tests/fdarray.c
index d0c8a05aab2f..d9eca8e86a6b 100644
--- a/tools/perf/tests/fdarray.c
+++ b/tools/perf/tests/fdarray.c
@@ -112,7 +112,7 @@ int test__fdarray__add(struct test *test __maybe_unused, int subtest __maybe_unu
 	}
 
 #define FDA_ADD(_idx, _fd, _revents, _nr)				   \
-	if (fdarray__add(fda, _fd, _revents) < 0) {			   \
+	if (fdarray__add(fda, _fd, _revents, fdarray_flag__default) < 0) { \
 		pr_debug("\n%d: fdarray__add(fda, %d, %d) failed!",	   \
 			 __LINE__,_fd, _revents);			   \
 		goto out_delete;					   \
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 1b884695b4d3..bcbe0cb8482e 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -497,7 +497,7 @@ int perf_evlist__enable_event_idx(struct evlist *evlist,
 
 int evlist__add_pollfd(struct evlist *evlist, int fd)
 {
-	return perf_evlist__add_pollfd(&evlist->core, fd, NULL, POLLIN);
+	return perf_evlist__add_pollfd(&evlist->core, fd, NULL, POLLIN, fdarray_flag__default);
 }
 
 int evlist__filter_pollfd(struct evlist *evlist, short revents_and_mask)
-- 
2.24.1


