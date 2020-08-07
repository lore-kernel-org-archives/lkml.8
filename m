Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50AA8C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 23:05:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 176F12224D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 23:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596841522;
	bh=9nphb8TYAU6NLMJkkh08e9GuAyQ/JxQQAM0QbjmbOiY=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=KqR/MtfWb2F6JiqFSTfILzwweEqd7Xu67Ib84h5Bc9it71ohmd012RpoZ1hsHY/Ok
	 d2na9Gh8Z0ETICVB1vGc4z8znlLRQlC8+jjt45G/QyTATMfqiT5aupiGP+GnI7nj6N
	 I+S8jtcEeYoGC0agekeYifD1OYZKxi2V+cjZBE2w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbgHGXFU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 19:05:20 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:33787 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbgHGXFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 19:05:20 -0400
Received: by mail-io1-f66.google.com with SMTP id g14so3518886iom.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Aug 2020 16:05:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QjKaA9oVN0qV5FZyfWlyD/SG7gBIJgXP7Xm8fixv++o=;
        b=rBc0FQgm4YifAa4X63yBhHAq1If6NvGdM2XATDgYHGn84FpTu4L5qVR0IMZaTfCqgB
         mcJhvb57OVoIRSieTkehN5zieyCaSH4zDEtZjrW47HgGUupjvJWuafI/8ujFY/c/Aye8
         pSfjMuERbh77nlSYxdXHZDX98VVyFfNFbQP5i9dXfJL6WDSclRnefZP+eaVTBIc/3ed5
         bmKY/i96jC3+8/USr4G/uwI9FR93fCk8EYY9vbn5vEsY3Sqa+A0DiCdu6EgXNtSsw+fL
         rWsKEj2WscyDqYw5BsTNQb+ny1nsag5LS4cj+xXUUtbmrzsQ6/8zz5gsCvLo4QdijjMx
         AM5Q==
X-Gm-Message-State: AOAM532Vmf60XwHYEKPGEuMHzCOlH0WzcnhhoCTTzHv2RwLhXz6MvXcC
        E7Rb6109zS52vxCxp6jNt48zOwU=
X-Google-Smtp-Source: ABdhPJyfF0KOJZHI8z0BmcrrkG03n6k8BD310xwjzhaQkq+bA1VxrSOY4Kq9Y2vCJCqs+qxkSCa6qw==
X-Received: by 2002:a02:2407:: with SMTP id f7mr7674191jaa.130.1596841518708;
        Fri, 07 Aug 2020 16:05:18 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.252])
        by smtp.googlemail.com with ESMTPSA id 25sm7575075ilv.85.2020.08.07.16.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2020 16:05:17 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [RFC] libperf: Add support for user space counter access
Date:   Fri,  7 Aug 2020 17:05:17 -0600
Message-Id: <20200807230517.57114-1-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

x86 and arm64 can both support direct access of event counters in
userspace. The access sequence is less than trivial and currently exists
in perf test code (tools/perf/arch/x86/tests/rdpmc.c) with copies in
projects such as PAPI and libpfm4.

Patches to add arm64 userspace support are pending[1].

For this RFC, looking for a yes, seems like a good idea, or no, go away we
don't want this in libperf.

TODO:
- Handle userspace access not enabled.
- Handle pmc_width and cap_user_time_short in read loop.
- Move existing rdpmc test to libperf based test?
- Abstract out rdtsc/rdpmc (currently only builds on x86 and need to add
  Arm versions)

[1] https://lore.kernel.org/r/20200707205333.624938-1-robh@kernel.org/

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../perf/Documentation/examples/user_read.c   | 103 ++++++++++++++++++
 tools/lib/perf/include/perf/mmap.h            |   2 +
 tools/lib/perf/libperf.map                    |   1 +
 tools/lib/perf/mmap.c                         |  72 ++++++++++++
 4 files changed, 178 insertions(+)
 create mode 100644 tools/lib/perf/Documentation/examples/user_read.c

diff --git a/tools/lib/perf/Documentation/examples/user_read.c b/tools/lib/perf/Documentation/examples/user_read.c
new file mode 100644
index 000000000000..47d5f1935861
--- /dev/null
+++ b/tools/lib/perf/Documentation/examples/user_read.c
@@ -0,0 +1,103 @@
+#include <linux/perf_event.h>
+#include <perf/evlist.h>
+#include <perf/evsel.h>
+#include <perf/cpumap.h>
+#include <perf/threadmap.h>
+#include <perf/mmap.h>
+#include <perf/core.h>
+#include <perf/event.h>
+#include <stdio.h>
+#include <unistd.h>
+
+static int libperf_print(enum libperf_print_level level,
+			 const char *fmt, va_list ap)
+{
+	return vfprintf(stderr, fmt, ap);
+}
+
+static unsigned long long read_counter(struct perf_evlist *evlist)
+{
+	struct perf_mmap *map;
+	unsigned long long cnt;
+
+	perf_evlist__for_each_mmap(evlist, map, false) {
+		while ((cnt = perf_mmap__read_self(map)) == ~0ULL) ;
+		return cnt;
+	}
+	return 0;
+}
+
+int main(int argc, char **argv)
+{
+	int count = 100000, err = 0;
+	unsigned long long start, end;
+	struct perf_evlist *evlist;
+	struct perf_evsel *evsel;
+	struct perf_thread_map *threads;
+	struct perf_cpu_map *cpus;
+	struct perf_counts_values counts;
+
+	struct perf_event_attr attr1 = {
+		.type        = PERF_TYPE_HARDWARE,
+		.config      = PERF_COUNT_HW_CPU_CYCLES,
+		.disabled    = 1,
+		.exclude_kernel = 1,
+	};
+
+	libperf_init(libperf_print);
+
+	evlist = perf_evlist__new();
+	if (!evlist) {
+		fprintf(stderr, "failed to create evlist\n");
+		goto out_threads;
+	}
+	evsel = perf_evsel__new(&attr1);
+	if (!evsel) {
+		fprintf(stderr, "failed to create evsel1\n");
+		goto out_evlist;
+	}
+	perf_evlist__add(evlist, evsel);
+
+	threads = perf_thread_map__new_dummy();
+	if (!threads) {
+		fprintf(stderr, "failed to create threads\n");
+		return -1;
+	}
+	perf_thread_map__set_pid(threads, 0, 0);
+	cpus = perf_cpu_map__dummy_new();
+	if (!cpus) {
+		fprintf(stderr, "failed to create cpus\n");
+		return -1;
+	}
+	perf_evlist__set_maps(evlist, cpus, threads);
+
+	err = perf_evlist__open(evlist);
+	if (err) {
+		fprintf(stderr, "failed to open evsel\n");
+		goto out_evlist;
+	}
+
+	err = perf_evlist__mmap(evlist, 0);
+	if (err) {
+		fprintf(stderr, "failed to mmap evlist\n");
+		goto out_evlist;
+	}
+
+	perf_evlist__enable(evlist);
+
+	start = read_counter(evlist);
+	while (count--);
+	end = read_counter(evlist);
+
+	perf_evlist__disable(evlist);
+
+	fprintf(stdout, "start %llu, end %llu, delta %llu\n",
+			start, end, end-start);
+
+	perf_evlist__close(evlist);
+out_evlist:
+	perf_evlist__delete(evlist);
+out_threads:
+	perf_thread_map__put(threads);
+	return err;
+}
diff --git a/tools/lib/perf/include/perf/mmap.h b/tools/lib/perf/include/perf/mmap.h
index 9508ad90d8b9..2d0a7e8b13db 100644
--- a/tools/lib/perf/include/perf/mmap.h
+++ b/tools/lib/perf/include/perf/mmap.h
@@ -12,4 +12,6 @@ LIBPERF_API int perf_mmap__read_init(struct perf_mmap *map);
 LIBPERF_API void perf_mmap__read_done(struct perf_mmap *map);
 LIBPERF_API union perf_event *perf_mmap__read_event(struct perf_mmap *map);
 
+LIBPERF_API __u64 perf_mmap__read_self(struct perf_mmap *map);
+
 #endif /* __LIBPERF_MMAP_H */
diff --git a/tools/lib/perf/libperf.map b/tools/lib/perf/libperf.map
index 7be1af8a546c..676a73300add 100644
--- a/tools/lib/perf/libperf.map
+++ b/tools/lib/perf/libperf.map
@@ -46,6 +46,7 @@ LIBPERF_0.0.1 {
 		perf_mmap__read_init;
 		perf_mmap__read_done;
 		perf_mmap__read_event;
+		perf_mmap__read_self;
 	local:
 		*;
 };
diff --git a/tools/lib/perf/mmap.c b/tools/lib/perf/mmap.c
index 79d5ed6c38cc..5a167618f4c5 100644
--- a/tools/lib/perf/mmap.c
+++ b/tools/lib/perf/mmap.c
@@ -273,3 +273,75 @@ union perf_event *perf_mmap__read_event(struct perf_mmap *map)
 
 	return event;
 }
+
+static u64 rdpmc(unsigned int counter)
+{
+	unsigned int low, high;
+
+	asm volatile("rdpmc" : "=a" (low), "=d" (high) : "c" (counter));
+
+	return low | ((u64)high) << 32;
+}
+
+static u64 rdtsc(void)
+{
+	unsigned int low, high;
+
+	asm volatile("rdtsc" : "=a" (low), "=d" (high));
+
+	return low | ((u64)high) << 32;
+}
+
+__u64 perf_mmap__read_self(struct perf_mmap *map)
+{
+	struct perf_event_mmap_page *pc = map->base;
+	u32 seq, idx, time_mult = 0, time_shift = 0;
+	u64 count, cyc = 0, time_offset = 0, enabled, running, delta;
+
+	/*
+	 * Check if event was unmapped due to a POLLHUP/POLLERR.
+	 */
+	if (!refcount_read(&map->refcnt))
+		return ~0;
+
+	do {
+		seq = pc->lock;
+		barrier();
+
+		enabled = pc->time_enabled;
+		running = pc->time_running;
+
+		if (enabled != running) {
+			cyc = rdtsc();
+			time_mult = pc->time_mult;
+			time_shift = pc->time_shift;
+			time_offset = pc->time_offset;
+		}
+
+		idx = pc->index;
+		count = pc->offset;
+		if (idx)
+			count += rdpmc(idx - 1);
+
+		barrier();
+	} while (pc->lock != seq);
+
+	if (enabled != running) {
+		u64 quot, rem;
+
+		quot = (cyc >> time_shift);
+		rem = cyc & (((u64)1 << time_shift) - 1);
+		delta = time_offset + quot * time_mult +
+			((rem * time_mult) >> time_shift);
+
+		enabled += delta;
+		if (idx)
+			running += delta;
+
+		quot = count / running;
+		rem = count % running;
+		count = quot * enabled + (rem * enabled) / running;
+	}
+
+	return count;
+}
-- 
2.25.1

