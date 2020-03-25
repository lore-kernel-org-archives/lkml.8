Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09423C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 12:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9E3120775
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 12:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585140366;
	bh=BQldbc+UNBgQMQ/39LgT5jf+uI9wLuFrEF8HoU+T2gE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=i2KKNn5ovvBNvZaBeYOYgx+I2ZMcEGEGizk8pcCcPsKYRxfAfrcj2rc7WDTuO4FyJ
	 4g3bhSesW258hZPbUUCFipEf0Geop6yq5Uw2wWEefqTtSZqL2/7AH+dKV/bkeDkKqp
	 vRrKL3fS6QtHZvvECV122Cc/f3vNy6SXdqPkKNVU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727600AbgCYMqF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 08:46:05 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:32853 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727560AbgCYMqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 08:46:04 -0400
Received: by mail-pg1-f196.google.com with SMTP id d17so1114675pgo.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 05:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MitQOQk2+X6QaTw6QLtHLiY7t6dhX7cXxKHKAvOYdX0=;
        b=rVix8qAdBe5Ryoj2TWaH0IB4o45qarwpgEfP4rJoFvfdql1iRoOsjl+ogzuXI5Z7oT
         0KUdtHDvpMXGNXctT2Eqgh3K1Qb/IaurIgNPbI6FNMIuw29o5ebsbuvJmbOFhv7ErW9G
         bT4d3nlkxq9vg+zDE+Bp0HaByLN8J6YErlcceBT50PoKJp/9FJP9uqx43nuqZBJxT8th
         ptlbzXQjV0UhxoTHDR4wExDNhR/q+pkkJMRxkrAUZSKmYL11wMQfRikmEZI/73lGCkPN
         WS0Ey90NdBe7mVVRlfUqLsL+dQyWP9pGzckK+xZO8SPFpeHdMLiN1UIqsdJ2xz0RUG4N
         Sppg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=MitQOQk2+X6QaTw6QLtHLiY7t6dhX7cXxKHKAvOYdX0=;
        b=ZdRB1U9FEpxQCTD3pTw7aeDJ2upcc0WiKwIcZtOkJcDoBy0kSaDNOOS7VBHmENSndM
         xiZWQhhtZ5cBOSixYZqFL59qmV+g3xqXUXpeyZEhPvhCaj17ResUszMbSF/DKle835/t
         pBjQXRkqgAXTdL7tTHx4ZEWFIAWUspNiGFSkKwNweZooIDCGsNXrFaQOXQmszb90ceQm
         o/IKPM4vnjbLAj+MVbgBywX/OK68JoZ8LbXtCNmWtkcXbaGIZDtglnYBVhjb0pbFNIL+
         YlpTctYcWRuHU1VwEjJC+DeXt+uFPa+DvghHXI6PY/1u5fZuuBU9kxclf/vJoKKgRj4l
         FhmQ==
X-Gm-Message-State: ANhLgQ1wB77Zh043T73mD5/67bfzvwxRck9qxLdVWmzhf7xUsMEcYBkC
        C9uCcTuBkUhU1YjBto2Rwo0=
X-Google-Smtp-Source: ADFU+vtlk3TVplChOsjlO22IDaHUraVHOJaV0cmfA+drS23LPE1I/OaSdLSj1+z1CNj3tllFGMxSQA==
X-Received: by 2002:a63:c546:: with SMTP id g6mr2895592pgd.243.1585140362180;
        Wed, 25 Mar 2020 05:46:02 -0700 (PDT)
Received: from gaurie.seo.corp.google.com ([2401:fa00:d:1:4eb0:a5ef:3975:7440])
        by smtp.gmail.com with ESMTPSA id h15sm18244648pfq.10.2020.03.25.05.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 05:46:01 -0700 (PDT)
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [PATCH 5/9] perf report: Add 'cgroup' sort key
Date:   Wed, 25 Mar 2020 21:45:32 +0900
Message-Id: <20200325124536.2800725-6-namhyung@kernel.org>
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
In-Reply-To: <20200325124536.2800725-1-namhyung@kernel.org>
References: <20200325124536.2800725-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cgroup sort key is to show cgroup membership of each task.
Currently it shows full path in the cgroupfs (not relative to the root
of cgroup namespace) since it'd be more intuitive IMHO.  Otherwise
root cgroup in different namespaces will all show same name - "/".

The cgroup sort key should come before cgroup_id otherwise
sort_dimension__add() will match it to cgroup_id as it only matches
with the given substring.

For example it will look like following.  Note that record patch
adding --all-cgroups patch will come later.

  $ perf record -a --namespace --all-cgroups  cgtest
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.208 MB perf.data (4090 samples) ]

  $ perf report -s cgroup_id,cgroup,pid
  ...
  # Overhead  cgroup id (dev/inode)  Cgroup          Pid:Command
  # ........  .....................  ..........  ...............
  #
      93.96%  0/0x0                  /                 0:swapper
       1.25%  3/0xeffffffb           /               278:looper0
       0.86%  3/0xf000015f           /sub/cgrp1      280:cgtest
       0.37%  3/0xf0000160           /sub/cgrp2      281:cgtest
       0.34%  3/0xf0000163           /sub/cgrp3      282:cgtest
       0.22%  3/0xeffffffb           /sub            278:looper0
       0.20%  3/0xeffffffb           /               280:cgtest
       0.15%  3/0xf0000163           /sub/cgrp3      285:looper3

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/Documentation/perf-report.txt |  1 +
 tools/perf/util/hist.c                   | 13 +++++++++
 tools/perf/util/hist.h                   |  1 +
 tools/perf/util/sort.c                   | 37 ++++++++++++++++++++++++
 tools/perf/util/sort.h                   |  2 ++
 5 files changed, 54 insertions(+)

diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
index e56e3f1344a7..f569b9ea4002 100644
--- a/tools/perf/Documentation/perf-report.txt
+++ b/tools/perf/Documentation/perf-report.txt
@@ -95,6 +95,7 @@ OPTIONS
 	abort cost. This is the global weight.
 	- local_weight: Local weight version of the weight above.
 	- cgroup_id: ID derived from cgroup namespace device and inode numbers.
+	- cgroup: cgroup pathname in the cgroupfs.
 	- transaction: Transaction abort flags.
 	- overhead: Overhead percentage of sample
 	- overhead_sys: Overhead percentage of sample running in system mode
diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index e74a5acf66d9..283a69ff6a3d 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -10,6 +10,7 @@
 #include "mem-events.h"
 #include "session.h"
 #include "namespaces.h"
+#include "cgroup.h"
 #include "sort.h"
 #include "units.h"
 #include "evlist.h"
@@ -194,6 +195,7 @@ void hists__calc_col_len(struct hists *hists, struct hist_entry *h)
 		hists__set_unres_dso_col_len(hists, HISTC_MEM_DADDR_DSO);
 	}
 
+	hists__new_col_len(hists, HISTC_CGROUP, 6);
 	hists__new_col_len(hists, HISTC_CGROUP_ID, 20);
 	hists__new_col_len(hists, HISTC_CPU, 3);
 	hists__new_col_len(hists, HISTC_SOCKET, 6);
@@ -222,6 +224,16 @@ void hists__calc_col_len(struct hists *hists, struct hist_entry *h)
 
 	if (h->trace_output)
 		hists__new_col_len(hists, HISTC_TRACE, strlen(h->trace_output));
+
+	if (h->cgroup) {
+		const char *cgrp_name = "unknown";
+		struct cgroup *cgrp = cgroup__find(h->ms.maps->machine->env,
+						   h->cgroup);
+		if (cgrp != NULL)
+			cgrp_name = cgrp->name;
+
+		hists__new_col_len(hists, HISTC_CGROUP, strlen(cgrp_name));
+	}
 }
 
 void hists__output_recalc_col_len(struct hists *hists, int max_rows)
@@ -691,6 +703,7 @@ __hists__add_entry(struct hists *hists,
 			.dev = ns ? ns->link_info[CGROUP_NS_INDEX].dev : 0,
 			.ino = ns ? ns->link_info[CGROUP_NS_INDEX].ino : 0,
 		},
+		.cgroup = sample->cgroup,
 		.ms = {
 			.maps	= al->maps,
 			.map	= al->map,
diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index bb994e030495..4141295a66fa 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -38,6 +38,7 @@ enum hist_column {
 	HISTC_THREAD,
 	HISTC_COMM,
 	HISTC_CGROUP_ID,
+	HISTC_CGROUP,
 	HISTC_PARENT,
 	HISTC_CPU,
 	HISTC_SOCKET,
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index e860595576c2..f14cc728c358 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -12,6 +12,7 @@
 #include "cacheline.h"
 #include "comm.h"
 #include "map.h"
+#include "maps.h"
 #include "symbol.h"
 #include "map_symbol.h"
 #include "branch.h"
@@ -25,6 +26,8 @@
 #include "mem-events.h"
 #include "annotate.h"
 #include "time-utils.h"
+#include "cgroup.h"
+#include "machine.h"
 #include <linux/kernel.h>
 #include <linux/string.h>
 
@@ -634,6 +637,39 @@ struct sort_entry sort_cgroup_id = {
 	.se_width_idx	= HISTC_CGROUP_ID,
 };
 
+/* --sort cgroup */
+
+static int64_t
+sort__cgroup_cmp(struct hist_entry *left, struct hist_entry *right)
+{
+	return right->cgroup - left->cgroup;
+}
+
+static int hist_entry__cgroup_snprintf(struct hist_entry *he,
+				       char *bf, size_t size,
+				       unsigned int width __maybe_unused)
+{
+	const char *cgrp_name = "N/A";
+
+	if (he->cgroup) {
+		struct cgroup *cgrp = cgroup__find(he->ms.maps->machine->env,
+						   he->cgroup);
+		if (cgrp != NULL)
+			cgrp_name = cgrp->name;
+		else
+			cgrp_name = "unknown";
+	}
+
+	return repsep_snprintf(bf, size, "%s", cgrp_name);
+}
+
+struct sort_entry sort_cgroup = {
+	.se_header      = "Cgroup",
+	.se_cmp	        = sort__cgroup_cmp,
+	.se_snprintf    = hist_entry__cgroup_snprintf,
+	.se_width_idx	= HISTC_CGROUP,
+};
+
 /* --sort socket */
 
 static int64_t
@@ -1660,6 +1696,7 @@ static struct sort_dimension common_sort_dimensions[] = {
 	DIM(SORT_TRACE, "trace", sort_trace),
 	DIM(SORT_SYM_SIZE, "symbol_size", sort_sym_size),
 	DIM(SORT_DSO_SIZE, "dso_size", sort_dso_size),
+	DIM(SORT_CGROUP, "cgroup", sort_cgroup),
 	DIM(SORT_CGROUP_ID, "cgroup_id", sort_cgroup_id),
 	DIM(SORT_SYM_IPC_NULL, "ipc_null", sort_sym_ipc_null),
 	DIM(SORT_TIME, "time", sort_time),
diff --git a/tools/perf/util/sort.h b/tools/perf/util/sort.h
index 6c862d62d052..cfa6ac6f7d06 100644
--- a/tools/perf/util/sort.h
+++ b/tools/perf/util/sort.h
@@ -101,6 +101,7 @@ struct hist_entry {
 	struct thread		*thread;
 	struct comm		*comm;
 	struct namespace_id	cgroup_id;
+	u64			cgroup;
 	u64			ip;
 	u64			transaction;
 	s32			socket;
@@ -224,6 +225,7 @@ enum sort_type {
 	SORT_TRACE,
 	SORT_SYM_SIZE,
 	SORT_DSO_SIZE,
+	SORT_CGROUP,
 	SORT_CGROUP_ID,
 	SORT_SYM_IPC_NULL,
 	SORT_TIME,
-- 
2.25.1.696.g5e7596f4ac-goog

