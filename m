Return-Path: <SRS0=bQGS=5U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3650DC2BA1A
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 08:43:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FCD320CC7
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 08:43:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbgDDImT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Apr 2020 04:42:19 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41686 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726414AbgDDImN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Apr 2020 04:42:13 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jKeNL-00019e-Gq; Sat, 04 Apr 2020 10:41:59 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id D6C461C047B;
        Sat,  4 Apr 2020 10:41:54 +0200 (CEST)
Date:   Sat, 04 Apr 2020 08:41:54 -0000
From:   "tip-bot2 for John Garry" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf pmu: Make pmu_uncore_alias_match() public
Cc:     John Garry <john.garry@huawei.com>, Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, linuxarm@huawei.com,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1584442939-8911-7-git-send-email-john.garry@huawei.com>
References: <1584442939-8911-7-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Message-ID: <158598971452.28353.7605551568012483577.tip-bot2@tip-bot2>
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

Commit-ID:     5b9a50001b2c23f90f2a21db4763f3a9599588c4
Gitweb:        https://git.kernel.org/tip/5b9a50001b2c23f90f2a21db4763f3a9599588c4
Author:        John Garry <john.garry@huawei.com>
AuthorDate:    Tue, 17 Mar 2020 19:02:18 +08:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Tue, 24 Mar 2020 10:35:59 -03:00

perf pmu: Make pmu_uncore_alias_match() public

The perf pmu-events test will want to use pmu_uncore_alias_match(), so
make it public.

Signed-off-by: John Garry <john.garry@huawei.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: James Clark <james.clark@arm.com>
Cc: Joakim Zhang <qiangqing.zhang@nxp.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>
Cc: linuxarm@huawei.com
Link: http://lore.kernel.org/lkml/1584442939-8911-7-git-send-email-john.garry@huawei.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/pmu.c | 2 +-
 tools/perf/util/pmu.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 55129d0..616fbda 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -698,7 +698,7 @@ struct pmu_events_map *perf_pmu__find_map(struct perf_pmu *pmu)
 	return map;
 }
 
-static bool pmu_uncore_alias_match(const char *pmu_name, const char *name)
+bool pmu_uncore_alias_match(const char *pmu_name, const char *name)
 {
 	char *tmp = NULL, *tok, *str;
 	bool res;
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index b756946..5fb3f16 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -103,6 +103,7 @@ void pmu_add_cpu_aliases_map(struct list_head *head, struct perf_pmu *pmu,
 			     struct pmu_events_map *map);
 
 struct pmu_events_map *perf_pmu__find_map(struct perf_pmu *pmu);
+bool pmu_uncore_alias_match(const char *pmu_name, const char *name);
 
 int perf_pmu__convert_scale(const char *scale, char **end, double *sval);
 
