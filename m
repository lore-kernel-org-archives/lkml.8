Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA554C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 14:17:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88A92207CB
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 14:17:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390929AbgEYORg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 10:17:36 -0400
Received: from mga18.intel.com ([134.134.136.126]:3129 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388714AbgEYORf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 10:17:35 -0400
IronPort-SDR: UQr3PVRi2FPn3/rM2nd9TcIWVka1m4EziacmAInFJvvFf+y9yzBn/04gGKUIAMs0MNTuFKoZOz
 RSwgkbMSq/5w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2020 07:17:34 -0700
IronPort-SDR: IfeJVgavZtejKtMOXAyajmTm6DPV/qoCPe5pCKn9/BqPKoQrl47/CuD8l+e9P6MhC/OwaeFe0c
 GWhzkWOXUMAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,433,1583222400"; 
   d="scan'208";a="269773665"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 25 May 2020 07:17:34 -0700
Received: from [10.249.227.191] (abudanko-mobl.ccr.corp.intel.com [10.249.227.191])
        by linux.intel.com (Postfix) with ESMTP id 6D2E5580101;
        Mon, 25 May 2020 07:17:32 -0700 (PDT)
Subject: [PATCH v4 01/10] tools/libperf: introduce static poll file
 descriptors
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <653fe5f3-c986-a841-1ed8-0a7d2fa24c00@linux.intel.com>
Organization: Intel Corp.
Message-ID: <024af6a7-8085-c28d-5067-6ab3225bdc82@linux.intel.com>
Date:   Mon, 25 May 2020 17:17:31 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <653fe5f3-c986-a841-1ed8-0a7d2fa24c00@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Implement adding of file descriptors to fixed size (currently 1)
storage at struct fdarray by the dedicated fdarray__add_stat().
Append the static descriptors to the array used by poll() syscall
at fdarray__poll(). Copy poll() result of the descriptors from the
array back to the storage for possible later analysis separately
from descriptors added by fdarray__add().

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 tools/lib/api/fd/array.c                 | 42 +++++++++++++++++++++++-
 tools/lib/api/fd/array.h                 |  7 ++++
 tools/lib/perf/evlist.c                  | 11 +++++++
 tools/lib/perf/include/internal/evlist.h |  2 ++
 4 files changed, 61 insertions(+), 1 deletion(-)

diff --git a/tools/lib/api/fd/array.c b/tools/lib/api/fd/array.c
index 58d44d5eee31..b0027f2169c7 100644
--- a/tools/lib/api/fd/array.c
+++ b/tools/lib/api/fd/array.c
@@ -11,10 +11,16 @@
 
 void fdarray__init(struct fdarray *fda, int nr_autogrow)
 {
+	int i;
+
 	fda->entries	 = NULL;
 	fda->priv	 = NULL;
 	fda->nr		 = fda->nr_alloc = 0;
 	fda->nr_autogrow = nr_autogrow;
+
+	fda->nr_stat = 0;
+	for (i = 0; i < FDARRAY__STAT_ENTRIES_MAX; i++)
+		fda->stat_entries[i].fd = -1;
 }
 
 int fdarray__grow(struct fdarray *fda, int nr)
@@ -83,6 +89,20 @@ int fdarray__add(struct fdarray *fda, int fd, short revents)
 	return pos;
 }
 
+int fdarray__add_stat(struct fdarray *fda, int fd, short revents)
+{
+	int pos = fda->nr_stat;
+
+	if (pos >= FDARRAY__STAT_ENTRIES_MAX)
+		return -1;
+
+	fda->stat_entries[pos].fd = fd;
+	fda->stat_entries[pos].events = revents;
+	fda->nr_stat++;
+
+	return pos;
+}
+
 int fdarray__filter(struct fdarray *fda, short revents,
 		    void (*entry_destructor)(struct fdarray *fda, int fd, void *arg),
 		    void *arg)
@@ -113,7 +133,27 @@ int fdarray__filter(struct fdarray *fda, short revents,
 
 int fdarray__poll(struct fdarray *fda, int timeout)
 {
-	return poll(fda->entries, fda->nr, timeout);
+	int nr, i, pos, res;
+
+	nr = fda->nr;
+
+	for (i = 0; i < fda->nr_stat; i++) {
+		if (fda->stat_entries[i].fd != -1) {
+			pos = fdarray__add(fda, fda->stat_entries[i].fd,
+					   fda->stat_entries[i].events);
+			if (pos >= 0)
+				fda->priv[pos].idx = i;
+		}
+	}
+
+	res = poll(fda->entries, fda->nr, timeout);
+
+	for (i = nr; i < fda->nr; i++)
+		fda->stat_entries[fda->priv[i].idx] = fda->entries[i];
+
+	fda->nr = nr;
+
+	return res;
 }
 
 int fdarray__fprintf(struct fdarray *fda, FILE *fp)
diff --git a/tools/lib/api/fd/array.h b/tools/lib/api/fd/array.h
index b39557d1a88f..9bca72e80b09 100644
--- a/tools/lib/api/fd/array.h
+++ b/tools/lib/api/fd/array.h
@@ -3,6 +3,7 @@
 #define __API_FD_ARRAY__
 
 #include <stdio.h>
+#include <poll.h>
 
 struct pollfd;
 
@@ -16,6 +17,9 @@ struct pollfd;
  *	  I.e. using 'fda->priv[N].idx = * value' where N < fda->nr is ok,
  *	  but doing 'fda->priv = malloc(M)' is not allowed.
  */
+
+#define FDARRAY__STAT_ENTRIES_MAX	1
+
 struct fdarray {
 	int	       nr;
 	int	       nr_alloc;
@@ -25,6 +29,8 @@ struct fdarray {
 		int    idx;
 		void   *ptr;
 	} *priv;
+	int	       nr_stat;
+	struct pollfd  stat_entries[FDARRAY__STAT_ENTRIES_MAX];
 };
 
 void fdarray__init(struct fdarray *fda, int nr_autogrow);
@@ -34,6 +40,7 @@ struct fdarray *fdarray__new(int nr_alloc, int nr_autogrow);
 void fdarray__delete(struct fdarray *fda);
 
 int fdarray__add(struct fdarray *fda, int fd, short revents);
+int fdarray__add_stat(struct fdarray *fda, int fd, short revents);
 int fdarray__poll(struct fdarray *fda, int timeout);
 int fdarray__filter(struct fdarray *fda, short revents,
 		    void (*entry_destructor)(struct fdarray *fda, int fd, void *arg),
diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
index 6a875a0f01bb..e68e4c08e7c2 100644
--- a/tools/lib/perf/evlist.c
+++ b/tools/lib/perf/evlist.c
@@ -317,6 +317,17 @@ int perf_evlist__add_pollfd(struct perf_evlist *evlist, int fd,
 	return pos;
 }
 
+int perf_evlist__add_pollfd_stat(struct perf_evlist *evlist, int fd,
+			         short revent)
+{
+	int pos = fdarray__add_stat(&evlist->pollfd, fd, revent | POLLERR | POLLHUP);
+
+	if (pos >= 0)
+		fcntl(fd, F_SETFL, O_NONBLOCK);
+
+	return pos;
+}
+
 static void perf_evlist__munmap_filtered(struct fdarray *fda, int fd,
 					 void *arg __maybe_unused)
 {
diff --git a/tools/lib/perf/include/internal/evlist.h b/tools/lib/perf/include/internal/evlist.h
index 74dc8c3f0b66..2b3b4518c05e 100644
--- a/tools/lib/perf/include/internal/evlist.h
+++ b/tools/lib/perf/include/internal/evlist.h
@@ -46,6 +46,8 @@ struct perf_evlist_mmap_ops {
 int perf_evlist__alloc_pollfd(struct perf_evlist *evlist);
 int perf_evlist__add_pollfd(struct perf_evlist *evlist, int fd,
 			    void *ptr, short revent);
+int perf_evlist__add_pollfd_stat(struct perf_evlist *evlist, int fd,
+			         short revent);
 
 int perf_evlist__mmap_ops(struct perf_evlist *evlist,
 			  struct perf_evlist_mmap_ops *ops,
-- 
2.24.1


