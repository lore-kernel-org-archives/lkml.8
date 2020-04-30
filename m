Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B2EBC83000
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 01:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7222320787
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 01:36:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbgD3Bg4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 21:36:56 -0400
Received: from mga17.intel.com ([192.55.52.151]:45049 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726309AbgD3Bg4 (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 21:36:56 -0400
IronPort-SDR: zOmC+KVZ8Nmkshj8bHa6nAMjRR7ASKnr7M2/xr+BuDn7zt/u27aEimDeUA0fqc4HIgDqJEk5Vy
 V7HQX/TF+cSw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2020 18:36:55 -0700
IronPort-SDR: B83ExK5vhkoLNMcksEGoIH/EyVRhpTqScxZhsbbMWPwm1cY7DNAhAIzjODyKLI8UrATU1gqZk+
 ghzjcU5+c/kg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,333,1583222400"; 
   d="scan'208";a="249609124"
Received: from kbl-ppc.sh.intel.com ([10.239.159.118])
  by fmsmga008.fm.intel.com with ESMTP; 29 Apr 2020 18:36:53 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH] perf evsel: Get group fd from CPU0 for system wide event
Date:   Thu, 30 Apr 2020 09:34:51 +0800
Message-Id: <20200430013451.17196-1-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A metric may consist of system wide event and non system-wide event.
The event group leader may be the system wide event.

For example, the metric "C2_Pkg_Residency" consists of
"cstate_pkg/c2-residency" and "msr/tsc". The former counts on the first
CPU of socket (tagged system-wide) and the latter is per CPU.

But "C2_Pkg_Residency" hits assertion failure on cascadelakex.

 # perf stat -M "C2_Pkg_Residency" -a -- sleep 1
 perf: util/evsel.c:1464: get_group_fd: Assertion `!(fd == -1)' failed.
 Aborted

get_group_fd(evsel, cpu, thread)
{
	leader = evsel->leader;
	fd = FD(leader, cpu, thread);
	BUG_ON(fd == -1);
}

Considering this case, leader is "cstate_pkg/c2-residency", evsel is
"msr/tsc" and cpu is 1. Because "cstate_pkg/c2-residency" is a system-wide
event and it's processed on CPU0, so FD(leader, 1, thread) must return an
invalid fd, then BUG_ON() may be triggered.

This patch gets group fd from CPU0 for system wide event if
FD(leader, cpu, thread) returns invalid fd.

With this patch,

 # perf stat -M "C2_Pkg_Residency" -a -- sleep 1

 Performance counter stats for 'system wide':

        1000850802      cstate_pkg/c2-residency/  #      0.5 C2_Pkg_Residency
      201446161592      msr/tsc/

       1.010637051 seconds time elapsed

Fixes: 6a4bb04caacc ("perf tools: Enable grouping logic for parsed events")
Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/util/evsel.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 6a571d322bb2..cd6470f63d6f 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1461,6 +1461,9 @@ static int get_group_fd(struct evsel *evsel, int cpu, int thread)
 	BUG_ON(!leader->core.fd);
 
 	fd = FD(leader, cpu, thread);
+	if (fd == -1 && leader->core.system_wide)
+		fd = FD(leader, 0, thread);
+
 	BUG_ON(fd == -1);
 
 	return fd;
-- 
2.17.1

