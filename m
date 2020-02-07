Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 712B0C35242
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 15:23:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F3332253D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 15:23:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727478AbgBGPXE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 10:23:04 -0500
Received: from foss.arm.com ([217.140.110.172]:41136 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727114AbgBGPXD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 10:23:03 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4B08E1063;
        Fri,  7 Feb 2020 07:23:03 -0800 (PST)
Received: from e121896.default (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2AD4B3F6CF;
        Fri,  7 Feb 2020 07:23:00 -0800 (PST)
From:   James Clark <james.clark@arm.com>
To:     jolsa@redhat.com, liwei391@huawei.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     nd@arm.com, Tan Xiaojun <tanxiaojun@huawei.com>,
        James Clark <james.clark@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Al Grant <al.grant@arm.com>, Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH v3 3/4] perf report: Add SPE options to --itrace argument
Date:   Fri,  7 Feb 2020 15:21:41 +0000
Message-Id: <20200207152142.28662-4-james.clark@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200207152142.28662-1-james.clark@arm.com>
References: <20200127123108.GC1114818@krava>
 <20200207152142.28662-1-james.clark@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tan Xiaojun <tanxiaojun@huawei.com>

The previous patch added support in "perf report" for some arm-spe
events(llc-miss, tlb-miss, branch-miss, remote_access). This patch
adds their help instructions.

Signed-off-by: Tan Xiaojun <tanxiaojun@huawei.com>
Tested-by: Qi Liu <liuqi115@hisilicon.com>
Signed-off-by: James Clark <james.clark@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Tan Xiaojun <tanxiaojun@huawei.com>
Cc: Al Grant <al.grant@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/Documentation/itrace.txt | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/itrace.txt b/tools/perf/Documentation/itrace.txt
index 82ff7dad40c2..8e1488de1fb3 100644
--- a/tools/perf/Documentation/itrace.txt
+++ b/tools/perf/Documentation/itrace.txt
@@ -1,5 +1,5 @@
 		i	synthesize instructions events
-		b	synthesize branches events
+		b	synthesize branches events (branch misses on Arm)
 		c	synthesize branches events (calls only)
 		r	synthesize branches events (returns only)
 		x	synthesize transactions events
@@ -12,6 +12,9 @@
 		g	synthesize a call chain (use with i or x)
 		l	synthesize last branch entries (use with i or x)
 		s       skip initial number of events
+		m	synthesize LLC miss events
+		t	synthesize TLB miss events
+		a	synthesize remote access events
 
 	The default is all events i.e. the same as --itrace=ibxwpe,
 	except for perf script where it is --itrace=ce
-- 
2.17.1

