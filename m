Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FF50C1975A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 05:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C65F820719
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 05:34:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726098AbgCYFez (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 01:34:55 -0400
Received: from mga17.intel.com ([192.55.52.151]:31776 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725781AbgCYFez (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 01:34:55 -0400
IronPort-SDR: JxbEXIDnckakKV/RHxArPXuUI8yhAV09tG+S0M4aUfS9Y4lBVMGnFCXzEZE6oLm9wp+ok0yPa4
 AEeYtr4HeCdg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2020 22:34:54 -0700
IronPort-SDR: KgXIXxHd6hCqqswj03w8UojJEtG51thf4npkJ51CKJPK5ncw3PyRB97lIVTgOaU2GsJ20SQ7Eo
 w6UVSuJxYRJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,303,1580803200"; 
   d="scan'208";a="393523090"
Received: from kbl-ppc.sh.intel.com ([10.239.159.24])
  by orsmga004.jf.intel.com with ESMTP; 24 Mar 2020 22:34:52 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v2 1/2] perf top: Support --group-sort-idx to change the sort order
Date:   Wed, 25 Mar 2020 06:07:10 +0800
Message-Id: <20200324220711.6025-1-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

perf report has supported the option --group-sort-idx, which
sorts the output by the event at the index n in event group.

For example,
perf record -e cycles,instructions,cache-misses
perf report --group --group-sort-idx 2 --stdio

The perf-report output is sorted by cache-misses.

This patch supports --group-sort-idx in perf-top.

For example,
perf top --group -e cycles,instructions,cache-misses --group-sort-idx 2

The perf-top output is sorted by cache-misses.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/Documentation/perf-top.txt | 5 +++++
 tools/perf/builtin-top.c              | 4 ++++
 2 files changed, 9 insertions(+)

diff --git a/tools/perf/Documentation/perf-top.txt b/tools/perf/Documentation/perf-top.txt
index 324b6b53c86b..0e97dcef794d 100644
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
index d2539b793f9d..494c7b9a1022 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1545,6 +1545,10 @@ int cmd_top(int argc, const char **argv)
 			"number of thread to run event synthesize"),
 	OPT_BOOLEAN(0, "namespaces", &opts->record_namespaces,
 		    "Record namespaces events"),
+	OPT_INTEGER(0, "group-sort-idx", &symbol_conf.group_sort_idx,
+		    "Sort the output by the event at the index n in group. "
+		    "If n is invalid, sort by the first event. "
+		    "WARNING: should be used on grouped events."),
 	OPTS_EVSWITCH(&top.evswitch),
 	OPT_END()
 	};
-- 
2.17.1

