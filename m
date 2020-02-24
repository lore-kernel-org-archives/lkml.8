Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B6E7C35641
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 04:38:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0805C20675
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 04:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582519105;
	bh=EKO7q5/njMrZ8sc0J5/3j8ky1STd7+9j6r5h9xwEWGo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=A0VXXNqZ8F98K0ObzO1b5wUHaeZo1Y+cThe91n9+Zvl/gqfl6JM2w+5A5wleYCmd6
	 3AtKAwyowS9iMZ6pc7XYCRZNETYghJ7Dbfdg+b1k8n+E93UUF7/j6Yny7qQrbj1Ltf
	 TnrbEQ/Ka04c/mZx2jdzKZTfRmCcjhdJaHw+bRF0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727552AbgBXEiX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 23:38:23 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36678 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727497AbgBXEiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 23:38:21 -0500
Received: by mail-pl1-f194.google.com with SMTP id a6so3528483plm.3;
        Sun, 23 Feb 2020 20:38:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AKCdgNgX/JDCTYsSbd3TrQaS+bj2+mpHeHcoZZJsHAQ=;
        b=IOKhmOZSTEOsqbQZO0lMDwrl3mJTiOBrHNrbBemAOlvGXNdTcvU/p/ndlip8pi8TTm
         4tt6uD4AAnFHkCfaplh009WBYa6PQuGs70hJ6a0woScWb+aAz/Nv477ZA2L1QMouaAEI
         Ib9ju3PpCSsCFS8NGrkevQ6boxR5C8kUYimtSOUKR7F22g4d5z9vCq52tjRnMlDbs5BL
         gvUUumcnyDF8q1lwezrqFePJamhHLiqwNlQ7mGeWUfNRwZV5JkWvZ/nMeJRdYWURjK01
         MRD9s5gBykE2zsnWHBDJsDvTuMPhz9Hw2cja5GJ6QY7wIuWLNCYELdeOzjamTCb+dZ/e
         G91w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=AKCdgNgX/JDCTYsSbd3TrQaS+bj2+mpHeHcoZZJsHAQ=;
        b=VMBPiPZKA0mMyNjl8aiBU5kQ/gZN+y+Wi7sygDfSnOXf73w5cP7ok1neSllh7Ec0tP
         tVxSzmvZVZqZGPS39nL92u/DojgFC8jW8OkVvt0WJHZU6dEkWvfDgniR0r4oa6pzh5OB
         tpTuEalywbobnFDSWjYYCgmG4ldrcKiLGa4XmfvCUk0YPDN0HXKdj5ksU5N7jx1u3imU
         Z/5LqEKSnn8qpvos34vWpcocaM0qsQkRaZOL1BBKhDf6YRT8ma/cV4dWN9kfSsCknSTb
         57P+3rhCchVG5EXuammr39dyTxnXIIa1A2WZYQGYR8PNi1EXAKC54uiqLffMsjtI4eKT
         NTuQ==
X-Gm-Message-State: APjAAAWB980BXb+nVc8NRguHp6Pd8Ik07k2ShJ6LPbG83K8qJmBulTsY
        ht9vZiGkw2folnAAEYkA+y4=
X-Google-Smtp-Source: APXvYqxlV0sRX/XZ8ypfzFaIO4DIqlM+xVF7Otjerr3C7GMo6s2F5c8Q0WjzJJuotjBvVYJEmY0TEw==
X-Received: by 2002:a17:90a:da03:: with SMTP id e3mr18361678pjv.100.1582519100381;
        Sun, 23 Feb 2020 20:38:20 -0800 (PST)
Received: from gaurie.seo.corp.google.com ([2401:fa00:d:1:4eb0:a5ef:3975:7440])
        by smtp.gmail.com with ESMTPSA id g16sm10914060pgb.54.2020.02.23.20.38.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2020 20:38:19 -0800 (PST)
From:   Namhyung Kim <namhyung@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 06/10] perf report: Add 'cgroup' sort key
Date:   Mon, 24 Feb 2020 13:37:45 +0900
Message-Id: <20200224043749.69466-7-namhyung@kernel.org>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
In-Reply-To: <20200224043749.69466-1-namhyung@kernel.org>
References: <20200224043749.69466-1-namhyung@kernel.org>
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
  # Overhead  cgroup id (dev/inode)  cgroup          Pid:Command
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
 tools/perf/util/hist.c                   | 12 ++++++++
 tools/perf/util/hist.h                   |  1 +
 tools/perf/util/sort.c                   | 37 ++++++++++++++++++++++++
 tools/perf/util/sort.h                   |  2 ++
 5 files changed, 53 insertions(+)

diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
index db61f16ffa56..f6bb82752a5c 100644
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
index ca5a8f4d007e..e0275d8808bd 100644
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
@@ -222,6 +223,16 @@ void hists__calc_col_len(struct hists *hists, struct hist_entry *h)
 
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
@@ -691,6 +702,7 @@ __hists__add_entry(struct hists *hists,
 			.dev = ns ? ns->link_info[CGROUP_NS_INDEX].dev : 0,
 			.ino = ns ? ns->link_info[CGROUP_NS_INDEX].ino : 0,
 		},
+		.cgroup = sample->cgroup,
 		.ms = {
 			.maps	= al->maps,
 			.map	= al->map,
diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index 0aa63aeb58ec..f7fb9c32dda5 100644
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
index ab0cfd790ad0..8bc8e55dd65e 100644
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
+	.se_header      = "cgroup",
+	.se_cmp	        = sort__cgroup_cmp,
+	.se_snprintf    = hist_entry__cgroup_snprintf,
+	.se_width_idx	= HISTC_CGROUP,
+};
+
 /* --sort socket */
 
 static int64_t
@@ -1658,6 +1694,7 @@ static struct sort_dimension common_sort_dimensions[] = {
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
2.25.0.265.gbab2e86ba0-goog

