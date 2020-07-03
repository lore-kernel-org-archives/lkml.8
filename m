Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 546A9C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 07:41:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31C77206B6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 07:41:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726325AbgGCHlu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 03:41:50 -0400
Received: from mga03.intel.com ([134.134.136.65]:8825 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725786AbgGCHlt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 03:41:49 -0400
IronPort-SDR: bU0+kwTIat9b4Avwuey4i1aO5TZ/I5n/TAogPjMw4Si1DpVWWkBcBVXJtjhVJ814aP2L6tAnSY
 0DY8WRXKqObw==
X-IronPort-AV: E=McAfee;i="6000,8403,9670"; a="147120197"
X-IronPort-AV: E=Sophos;i="5.75,307,1589266800"; 
   d="scan'208";a="147120197"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2020 00:41:48 -0700
IronPort-SDR: O78VYPmxpF602VXDf236JWJbmnZ54EexIVgbyR0fhEvwo6bMYpscnN+FtsRLcTxu7oX4SmKBLe
 TsFE2ZyjlD0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,307,1589266800"; 
   d="scan'208";a="482290310"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga005.fm.intel.com with ESMTP; 03 Jul 2020 00:41:48 -0700
Received: from [10.249.231.67] (abudanko-mobl.ccr.corp.intel.com [10.249.231.67])
        by linux.intel.com (Postfix) with ESMTP id 43E7B580781;
        Fri,  3 Jul 2020 00:41:46 -0700 (PDT)
Subject: [PATCH v9 02/15] tools/libperf: add properties to struct pollfd
 *entries objects
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <a4d5db4a-f25c-38dc-1c41-321a886cb122@linux.intel.com>
Organization: Intel Corp.
Message-ID: <09bbbc85-7ef9-ff9f-9865-fce6a1a4e903@linux.intel.com>
Date:   Fri, 3 Jul 2020 10:41:45 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <a4d5db4a-f25c-38dc-1c41-321a886cb122@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Store boolean properties per struct pollfd *entries object in a
bitmap of int size. Implement fdarray_prop__nonfilterable property
to skip object from counting by fdarray_filter().

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 tools/lib/api/fd/array.c                 | 17 +++++++++--------
 tools/lib/api/fd/array.h                 | 18 +++++++++++++-----
 tools/lib/perf/evlist.c                  | 10 +++++-----
 tools/lib/perf/include/internal/evlist.h |  2 +-
 tools/perf/tests/fdarray.c               |  2 +-
 tools/perf/util/evlist.c                 |  2 +-
 6 files changed, 30 insertions(+), 21 deletions(-)

diff --git a/tools/lib/api/fd/array.c b/tools/lib/api/fd/array.c
index 89f9a2193c2d..a4223f8cb1ce 100644
--- a/tools/lib/api/fd/array.c
+++ b/tools/lib/api/fd/array.c
@@ -12,31 +12,31 @@
 void fdarray__init(struct fdarray *fda, int nr_autogrow)
 {
 	fda->entries	 = NULL;
-	fda->priv	 = NULL;
+	fda->prop	 = NULL;
 	fda->nr		 = fda->nr_alloc = 0;
 	fda->nr_autogrow = nr_autogrow;
 }
 
 int fdarray__grow(struct fdarray *fda, int nr)
 {
-	void *priv;
+	void *prop;
 	int nr_alloc = fda->nr_alloc + nr;
-	size_t psize = sizeof(fda->priv[0]) * nr_alloc;
+	size_t psize = sizeof(fda->prop[0]) * nr_alloc;
 	size_t size  = sizeof(struct pollfd) * nr_alloc;
 	struct pollfd *entries = realloc(fda->entries, size);
 
 	if (entries == NULL)
 		return -ENOMEM;
 
-	priv = realloc(fda->priv, psize);
-	if (priv == NULL) {
+	prop = realloc(fda->prop, psize);
+	if (prop == NULL) {
 		free(entries);
 		return -ENOMEM;
 	}
 
 	fda->nr_alloc = nr_alloc;
 	fda->entries  = entries;
-	fda->priv     = priv;
+	fda->prop     = prop;
 	return 0;
 }
 
@@ -59,7 +59,7 @@ struct fdarray *fdarray__new(int nr_alloc, int nr_autogrow)
 void fdarray__exit(struct fdarray *fda)
 {
 	free(fda->entries);
-	free(fda->priv);
+	free(fda->prop);
 	fdarray__init(fda, 0);
 }
 
@@ -69,7 +69,7 @@ void fdarray__delete(struct fdarray *fda)
 	free(fda);
 }
 
-int fdarray__add(struct fdarray *fda, int fd, short revents)
+int fdarray__add(struct fdarray *fda, int fd, short revents, enum fdarray_props props)
 {
 	int pos = fda->nr;
 
@@ -79,6 +79,7 @@ int fdarray__add(struct fdarray *fda, int fd, short revents)
 
 	fda->entries[fda->nr].fd     = fd;
 	fda->entries[fda->nr].events = revents;
+	fda->prop[fda->nr].bits = props;
 	fda->nr++;
 	return pos;
 }
diff --git a/tools/lib/api/fd/array.h b/tools/lib/api/fd/array.h
index b39557d1a88f..19b6a34aeea5 100644
--- a/tools/lib/api/fd/array.h
+++ b/tools/lib/api/fd/array.h
@@ -21,10 +21,18 @@ struct fdarray {
 	int	       nr_alloc;
 	int	       nr_autogrow;
 	struct pollfd *entries;
-	union {
-		int    idx;
-		void   *ptr;
-	} *priv;
+	struct {
+		union {
+			int    idx;
+			void   *ptr;
+		} priv;
+		int bits;
+	} *prop;
+};
+
+enum fdarray_props {
+	fdarray_prop__default	    = 0x00000000,
+	fdarray_prop__nonfilterable = 0x00000001
 };
 
 void fdarray__init(struct fdarray *fda, int nr_autogrow);
@@ -33,7 +41,7 @@ void fdarray__exit(struct fdarray *fda);
 struct fdarray *fdarray__new(int nr_alloc, int nr_autogrow);
 void fdarray__delete(struct fdarray *fda);
 
-int fdarray__add(struct fdarray *fda, int fd, short revents);
+int fdarray__add(struct fdarray *fda, int fd, short revents, enum fdarray_props props);
 int fdarray__poll(struct fdarray *fda, int timeout);
 int fdarray__filter(struct fdarray *fda, short revents,
 		    void (*entry_destructor)(struct fdarray *fda, int fd, void *arg),
diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
index 6a875a0f01bb..25e76e458afb 100644
--- a/tools/lib/perf/evlist.c
+++ b/tools/lib/perf/evlist.c
@@ -305,12 +305,12 @@ int perf_evlist__alloc_pollfd(struct perf_evlist *evlist)
 }
 
 int perf_evlist__add_pollfd(struct perf_evlist *evlist, int fd,
-			    void *ptr, short revent)
+			    void *ptr, short revent, enum fdarray_props props)
 {
-	int pos = fdarray__add(&evlist->pollfd, fd, revent | POLLERR | POLLHUP);
+	int pos = fdarray__add(&evlist->pollfd, fd, revent | POLLERR | POLLHUP, props);
 
 	if (pos >= 0) {
-		evlist->pollfd.priv[pos].ptr = ptr;
+		evlist->pollfd.prop[pos].priv.ptr = ptr;
 		fcntl(fd, F_SETFL, O_NONBLOCK);
 	}
 
@@ -320,7 +320,7 @@ int perf_evlist__add_pollfd(struct perf_evlist *evlist, int fd,
 static void perf_evlist__munmap_filtered(struct fdarray *fda, int fd,
 					 void *arg __maybe_unused)
 {
-	struct perf_mmap *map = fda->priv[fd].ptr;
+	struct perf_mmap *map = fda->prop[fd].priv.ptr;
 
 	if (map)
 		perf_mmap__put(map);
@@ -488,7 +488,7 @@ mmap_per_evsel(struct perf_evlist *evlist, struct perf_evlist_mmap_ops *ops,
 		revent = !overwrite ? POLLIN : 0;
 
 		if (!evsel->system_wide &&
-		    perf_evlist__add_pollfd(evlist, fd, map, revent) < 0) {
+		    perf_evlist__add_pollfd(evlist, fd, map, revent, fdarray_prop__default) < 0) {
 			perf_mmap__put(map);
 			return -1;
 		}
diff --git a/tools/lib/perf/include/internal/evlist.h b/tools/lib/perf/include/internal/evlist.h
index 74dc8c3f0b66..87bc0fa7293c 100644
--- a/tools/lib/perf/include/internal/evlist.h
+++ b/tools/lib/perf/include/internal/evlist.h
@@ -45,7 +45,7 @@ struct perf_evlist_mmap_ops {
 
 int perf_evlist__alloc_pollfd(struct perf_evlist *evlist);
 int perf_evlist__add_pollfd(struct perf_evlist *evlist, int fd,
-			    void *ptr, short revent);
+			    void *ptr, short revent, enum fdarray_props props);
 
 int perf_evlist__mmap_ops(struct perf_evlist *evlist,
 			  struct perf_evlist_mmap_ops *ops,
diff --git a/tools/perf/tests/fdarray.c b/tools/perf/tests/fdarray.c
index d0c8a05aab2f..b573f386ab2f 100644
--- a/tools/perf/tests/fdarray.c
+++ b/tools/perf/tests/fdarray.c
@@ -112,7 +112,7 @@ int test__fdarray__add(struct test *test __maybe_unused, int subtest __maybe_unu
 	}
 
 #define FDA_ADD(_idx, _fd, _revents, _nr)				   \
-	if (fdarray__add(fda, _fd, _revents) < 0) {			   \
+	if (fdarray__add(fda, _fd, _revents, fdarray_prop__default) < 0) { \
 		pr_debug("\n%d: fdarray__add(fda, %d, %d) failed!",	   \
 			 __LINE__,_fd, _revents);			   \
 		goto out_delete;					   \
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 1b884695b4d3..7b1beffec6a1 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -497,7 +497,7 @@ int perf_evlist__enable_event_idx(struct evlist *evlist,
 
 int evlist__add_pollfd(struct evlist *evlist, int fd)
 {
-	return perf_evlist__add_pollfd(&evlist->core, fd, NULL, POLLIN);
+	return perf_evlist__add_pollfd(&evlist->core, fd, NULL, POLLIN, fdarray_prop__default);
 }
 
 int evlist__filter_pollfd(struct evlist *evlist, short revents_and_mask)
-- 
2.24.1


