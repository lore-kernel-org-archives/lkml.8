Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8007C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 15:51:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 878EE20734
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 15:51:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728101AbgFAPvR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 11:51:17 -0400
Received: from mga02.intel.com ([134.134.136.20]:23530 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726075AbgFAPvR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 11:51:17 -0400
IronPort-SDR: Tdj5veA2PQt+OK9dS2Z1KhbbYeoNTV2mcVPVri5/lUiWWwSfFETVpxEh3gl940YeWg6LeBX6IS
 qgE4IDhTNk+w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2020 08:51:16 -0700
IronPort-SDR: 60sJaF7RUIbsa+HaoaR7zNkPzYTZqEH1ExGot0gj+eDE5D6A4BsnPLBBBQ6XdQBThtGTjIG6Q0
 DgzYfyNp7HPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,461,1583222400"; 
   d="scan'208";a="257297535"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga007.jf.intel.com with ESMTP; 01 Jun 2020 08:51:16 -0700
Received: from [10.249.230.65] (abudanko-mobl.ccr.corp.intel.com [10.249.230.65])
        by linux.intel.com (Postfix) with ESMTP id 93875580646;
        Mon,  1 Jun 2020 08:51:14 -0700 (PDT)
Subject: [PATCH v5 01/13] tools/libperf: introduce static poll file
 descriptors
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <e5cac8dd-7aa4-ec7c-671c-07756907acba@linux.intel.com>
Organization: Intel Corp.
Message-ID: <c8fc7d8c-c901-d41e-63da-45666f8a17b2@linux.intel.com>
Date:   Mon, 1 Jun 2020 18:51:13 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <e5cac8dd-7aa4-ec7c-671c-07756907acba@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Implement adding of file descriptors to fixed size (currently 1)
storage at struct fdarray by the dedicated fdarray__add_stat().
Index returned by fdarray__add_stat() is allocated once and unique
thus can safely be used to directly access entry at stat_entries.
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


