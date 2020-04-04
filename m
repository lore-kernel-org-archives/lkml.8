Return-Path: <SRS0=bQGS=5U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9BE7C2BA18
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 08:44:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C89F62072B
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 08:44:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbgDDIoT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Apr 2020 04:44:19 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41522 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726371AbgDDImA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Apr 2020 04:42:00 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jKeN5-0000xv-TT; Sat, 04 Apr 2020 10:41:44 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 819031C0243;
        Sat,  4 Apr 2020 10:41:43 +0200 (CEST)
Date:   Sat, 04 Apr 2020 08:41:43 -0000
From:   "tip-bot2 for Jin Yao" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf top: Support --group-sort-idx to change the
 sort order
Cc:     Jin Yao <yao.jin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jin Yao <yao.jin@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200324220711.6025-1-yao.jin@linux.intel.com>
References: <20200324220711.6025-1-yao.jin@linux.intel.com>
MIME-Version: 1.0
Message-ID: <158598970316.28353.17958323669353267634.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     df7deb2cceef0546ab2115702da3421b7c61a8c0
Gitweb:        https://git.kernel.org/tip/df7deb2cceef0546ab2115702da3421b7c61a8c0
Author:        Jin Yao <yao.jin@linux.intel.com>
AuthorDate:    Wed, 25 Mar 2020 06:07:10 +08:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Fri, 03 Apr 2020 09:37:55 -03:00

perf top: Support --group-sort-idx to change the sort order

'perf report' supports the option --group-sort-idx, which sorts the
output by the event at the index n in event group.

For example:

  perf record -e cycles,instructions,cache-misses
  perf report --group --group-sort-idx 2 --stdio

The perf-report output is sorted by cache-misses.

This patch supports --group-sort-idx in perf-top.

For example:

  perf top --group -e cycles,instructions,cache-misses --group-sort-idx 2

The perf-top output is sorted by cache-misses.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
Suggested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jin Yao <yao.jin@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20200324220711.6025-1-yao.jin@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-top.txt | 5 +++++
 tools/perf/builtin-top.c              | 4 ++++
 2 files changed, 9 insertions(+)

diff --git a/tools/perf/Documentation/perf-top.txt b/tools/perf/Documentation/perf-top.txt
index ddab103..487737a 100644
--- a/tools/perf/Documentation/perf-top.txt
+++ b/tools/perf/Documentation/perf-top.txt
@@ -53,6 +53,11 @@ Default is to monitor all CPUS.
 --group::
         Put the counters into a counter group.
 
+--group-sort-idx::
+	Sort the output by the event at the index n in group. If n is invalid,
+	sort by the first event. It can support multiple groups with different
+	amount of events. WARNING: This should be used on grouped events.
+
 -F <freq>::
 --freq=<freq>::
 	Profile at this frequency. Use 'max' to use the currently maximum
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 02ea2cf..9ff7943 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1560,6 +1560,10 @@ int cmd_top(int argc, const char **argv)
 		    "Record namespaces events"),
 	OPT_BOOLEAN(0, "all-cgroups", &opts->record_cgroup,
 		    "Record cgroup events"),
+	OPT_INTEGER(0, "group-sort-idx", &symbol_conf.group_sort_idx,
+		    "Sort the output by the event at the index n in group. "
+		    "If n is invalid, sort by the first event. "
+		    "WARNING: should be used on grouped events."),
 	OPTS_EVSWITCH(&top.evswitch),
 	OPT_END()
 	};
