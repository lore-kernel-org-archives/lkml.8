Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DE33C4332B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 07:24:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D753020767
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 07:24:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbgCTHYw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 03:24:52 -0400
Received: from mga09.intel.com ([134.134.136.24]:41360 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725802AbgCTHYw (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 03:24:52 -0400
IronPort-SDR: VJIS0SJPrFoUbdRfyKvEWqFG5qGqFkK2j4xNICRYJ6SIB4421UmUqt2F5LZUjbCnj8ILS3sliu
 0k9cACBRXkOQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2020 00:24:51 -0700
IronPort-SDR: 5z5V2JgRyYBBsMkF7ISBsYsoBodK4MkjON1v5LCQjWc04obM/zttsd/18cgEjsHenFgzlxvjUl
 hFNqZu1w+lqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,283,1580803200"; 
   d="scan'208";a="269004837"
Received: from kbl.sh.intel.com ([10.239.159.24])
  by fmsmga004.fm.intel.com with ESMTP; 20 Mar 2020 00:24:48 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH 1/2] perf top: Support --group-sort-idx to change the sort order
Date:   Fri, 20 Mar 2020 15:24:13 +0800
Message-Id: <20200320072414.25551-1-yao.jin@linux.intel.com>
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
index f6dd1a63f159..144043637cec 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1543,6 +1543,10 @@ int cmd_top(int argc, const char **argv)
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

