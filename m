Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BBCFC33CA4
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 17:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BE4F2467A
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 17:53:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728924AbgAJRxn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 12:53:43 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:59215 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728860AbgAJRxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 12:53:37 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ipyTP-0001mG-Uv; Fri, 10 Jan 2020 18:53:28 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 2B3ED1C2D5F;
        Fri, 10 Jan 2020 18:53:18 +0100 (CET)
Date:   Fri, 10 Jan 2020 17:53:18 -0000
From:   "tip-bot2 for Alexey Budankov" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf record: Adapt affinity to machines with #CPUs > 1K
Cc:     Andi Kleen <ak@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <96d7e2ff-ce8b-c1e0-d52c-aa59ea96f0ea@linux.intel.com>
References: <96d7e2ff-ce8b-c1e0-d52c-aa59ea96f0ea@linux.intel.com>
MIME-Version: 1.0
Message-ID: <157867879803.30329.14199943602079781895.tip-bot2@tip-bot2>
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

Commit-ID:     8384a2600c7ddfc875f64e160d8b423aca4e203a
Gitweb:        https://git.kernel.org/tip/8384a2600c7ddfc875f64e160d8b423aca4e203a
Author:        Alexey Budankov <alexey.budankov@linux.intel.com>
AuthorDate:    Tue, 03 Dec 2019 14:45:27 +03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Mon, 06 Jan 2020 11:46:09 -03:00

perf record: Adapt affinity to machines with #CPUs > 1K

Use struct mmap_cpu_mask type for the tool's thread and mmap data
buffers to overcome current 1024 CPUs mask size limitation of cpu_set_t
type.

Currently glibc's cpu_set_t type has an internal mask size limit of 1024
CPUs.

Moving to the 'struct mmap_cpu_mask' type allows overcoming that limit.

The tools bitmap API is used to manipulate objects of 'struct mmap_cpu_mask'
type.

Committer notes:

To print the 'nbits' struct member we must use %zd, since it is a
size_t, this fixes the build in some toolchains/arches.

Reported-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/96d7e2ff-ce8b-c1e0-d52c-aa59ea96f0ea@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-record.c | 28 ++++++++++++++++++++++------
 tools/perf/util/mmap.c      | 28 ++++++++++++++++++++++------
 tools/perf/util/mmap.h      |  2 +-
 3 files changed, 45 insertions(+), 13 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index fb19ef6..4c30146 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -62,6 +62,7 @@
 #include <linux/string.h>
 #include <linux/time64.h>
 #include <linux/zalloc.h>
+#include <linux/bitmap.h>
 
 struct switch_output {
 	bool		 enabled;
@@ -93,7 +94,7 @@ struct record {
 	bool			timestamp_boundary;
 	struct switch_output	switch_output;
 	unsigned long long	samples;
-	cpu_set_t		affinity_mask;
+	struct mmap_cpu_mask	affinity_mask;
 	unsigned long		output_max_size;	/* = 0: unlimited */
 };
 
@@ -961,10 +962,15 @@ static struct perf_event_header finished_round_event = {
 static void record__adjust_affinity(struct record *rec, struct mmap *map)
 {
 	if (rec->opts.affinity != PERF_AFFINITY_SYS &&
-	    !CPU_EQUAL(&rec->affinity_mask, &map->affinity_mask)) {
-		CPU_ZERO(&rec->affinity_mask);
-		CPU_OR(&rec->affinity_mask, &rec->affinity_mask, &map->affinity_mask);
-		sched_setaffinity(0, sizeof(rec->affinity_mask), &rec->affinity_mask);
+	    !bitmap_equal(rec->affinity_mask.bits, map->affinity_mask.bits,
+			  rec->affinity_mask.nbits)) {
+		bitmap_zero(rec->affinity_mask.bits, rec->affinity_mask.nbits);
+		bitmap_or(rec->affinity_mask.bits, rec->affinity_mask.bits,
+			  map->affinity_mask.bits, rec->affinity_mask.nbits);
+		sched_setaffinity(0, MMAP_CPU_MASK_BYTES(&rec->affinity_mask),
+				  (cpu_set_t *)rec->affinity_mask.bits);
+		if (verbose == 2)
+			mmap_cpu_mask__scnprintf(&rec->affinity_mask, "thread");
 	}
 }
 
@@ -2433,7 +2439,6 @@ int cmd_record(int argc, const char **argv)
 # undef REASON
 #endif
 
-	CPU_ZERO(&rec->affinity_mask);
 	rec->opts.affinity = PERF_AFFINITY_SYS;
 
 	rec->evlist = evlist__new();
@@ -2499,6 +2504,16 @@ int cmd_record(int argc, const char **argv)
 
 	symbol__init(NULL);
 
+	if (rec->opts.affinity != PERF_AFFINITY_SYS) {
+		rec->affinity_mask.nbits = cpu__max_cpu();
+		rec->affinity_mask.bits = bitmap_alloc(rec->affinity_mask.nbits);
+		if (!rec->affinity_mask.bits) {
+			pr_err("Failed to allocate thread mask for %zd cpus\n", rec->affinity_mask.nbits);
+			return -ENOMEM;
+		}
+		pr_debug2("thread mask[%zd]: empty\n", rec->affinity_mask.nbits);
+	}
+
 	err = record__auxtrace_init(rec);
 	if (err)
 		goto out;
@@ -2613,6 +2628,7 @@ int cmd_record(int argc, const char **argv)
 
 	err = __cmd_record(&record, argc, argv);
 out:
+	bitmap_free(rec->affinity_mask.bits);
 	evlist__delete(rec->evlist);
 	symbol__exit();
 	auxtrace_record__free(rec->itr);
diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index 2ee4faa..3b664fa 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -219,6 +219,8 @@ static void perf_mmap__aio_munmap(struct mmap *map __maybe_unused)
 
 void mmap__munmap(struct mmap *map)
 {
+	bitmap_free(map->affinity_mask.bits);
+
 	perf_mmap__aio_munmap(map);
 	if (map->data != NULL) {
 		munmap(map->data, mmap__mmap_len(map));
@@ -227,7 +229,7 @@ void mmap__munmap(struct mmap *map)
 	auxtrace_mmap__munmap(&map->auxtrace_mmap);
 }
 
-static void build_node_mask(int node, cpu_set_t *mask)
+static void build_node_mask(int node, struct mmap_cpu_mask *mask)
 {
 	int c, cpu, nr_cpus;
 	const struct perf_cpu_map *cpu_map = NULL;
@@ -240,17 +242,23 @@ static void build_node_mask(int node, cpu_set_t *mask)
 	for (c = 0; c < nr_cpus; c++) {
 		cpu = cpu_map->map[c]; /* map c index to online cpu index */
 		if (cpu__get_node(cpu) == node)
-			CPU_SET(cpu, mask);
+			set_bit(cpu, mask->bits);
 	}
 }
 
-static void perf_mmap__setup_affinity_mask(struct mmap *map, struct mmap_params *mp)
+static int perf_mmap__setup_affinity_mask(struct mmap *map, struct mmap_params *mp)
 {
-	CPU_ZERO(&map->affinity_mask);
+	map->affinity_mask.nbits = cpu__max_cpu();
+	map->affinity_mask.bits = bitmap_alloc(map->affinity_mask.nbits);
+	if (!map->affinity_mask.bits)
+		return -1;
+
 	if (mp->affinity == PERF_AFFINITY_NODE && cpu__max_node() > 1)
 		build_node_mask(cpu__get_node(map->core.cpu), &map->affinity_mask);
 	else if (mp->affinity == PERF_AFFINITY_CPU)
-		CPU_SET(map->core.cpu, &map->affinity_mask);
+		set_bit(map->core.cpu, map->affinity_mask.bits);
+
+	return 0;
 }
 
 int mmap__mmap(struct mmap *map, struct mmap_params *mp, int fd, int cpu)
@@ -261,7 +269,15 @@ int mmap__mmap(struct mmap *map, struct mmap_params *mp, int fd, int cpu)
 		return -1;
 	}
 
-	perf_mmap__setup_affinity_mask(map, mp);
+	if (mp->affinity != PERF_AFFINITY_SYS &&
+		perf_mmap__setup_affinity_mask(map, mp)) {
+		pr_debug2("failed to alloc mmap affinity mask, error %d\n",
+			  errno);
+		return -1;
+	}
+
+	if (verbose == 2)
+		mmap_cpu_mask__scnprintf(&map->affinity_mask, "mmap");
 
 	map->core.flush = mp->flush;
 
diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
index ef51667..9d5f589 100644
--- a/tools/perf/util/mmap.h
+++ b/tools/perf/util/mmap.h
@@ -40,7 +40,7 @@ struct mmap {
 		int		 nr_cblocks;
 	} aio;
 #endif
-	cpu_set_t	affinity_mask;
+	struct mmap_cpu_mask	affinity_mask;
 	void		*data;
 	int		comp_level;
 };
