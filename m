Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E337C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 07:31:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EADE22B40
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 07:31:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbgHEHb1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 03:31:27 -0400
Received: from mga17.intel.com ([192.55.52.151]:23079 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725904AbgHEHb0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 03:31:26 -0400
IronPort-SDR: kkKBkG0LDbmPQoVVAimg56fJANCVICRSQJq1iuSblLaU6tr6W0JTpZLmJ7o/2/tMI5kI0BOUIh
 nqLixw8DmIQg==
X-IronPort-AV: E=McAfee;i="6000,8403,9703"; a="132561504"
X-IronPort-AV: E=Sophos;i="5.75,436,1589266800"; 
   d="scan'208";a="132561504"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2020 00:31:25 -0700
IronPort-SDR: GW4Anxi1f/NU8WEZADz/uH7qx5hIpJ+P5gGguB4kYG/RLCNX+BvfeZ0JT2gA9HtRfKpz8qrZtB
 OFJWMmtfDV6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,436,1589266800"; 
   d="scan'208";a="274701390"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga007.fm.intel.com with ESMTP; 05 Aug 2020 00:31:26 -0700
Received: from [10.249.227.101] (abudanko-mobl.ccr.corp.intel.com [10.249.227.101])
        by linux.intel.com (Postfix) with ESMTP id A5A4C580713;
        Wed,  5 Aug 2020 00:31:22 -0700 (PDT)
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: [PATCH v1] perf: extend message to mention CAP_SYS_PTRACE and perf
 security doc link
Organization: Intel Corp.
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <6f8a7425-6e7d-19aa-1605-e59836b9e2a6@linux.intel.com>
Date:   Wed, 5 Aug 2020 10:31:20 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Adjust limited access message to mention CAP_SYS_PTRACE capability
for processes of unprivileged users. Add link to perf security
document in the end of the section about capabilities.
The change has been inspired by this discussion:
https://lore.kernel.org/lkml/20200722113007.GI77866@kernel.org/

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 tools/perf/util/evsel.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 9aa51a65593d..e241ee773ccb 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2500,8 +2500,10 @@ int evsel__open_strerror(struct evsel *evsel, struct target *target,
 
 		return scnprintf(msg + printed, size - printed,
 		 "Consider adjusting /proc/sys/kernel/perf_event_paranoid setting to open\n"
-		 "access to performance monitoring and observability operations for users\n"
-		 "without CAP_PERFMON or CAP_SYS_ADMIN Linux capability.\n"
+		 "access to performance monitoring and observability operations for processes\n"
+		 "without CAP_PERFMON, CAP_SYS_PTRACE or CAP_SYS_ADMIN Linux capability.\n"
+		 "More information can be found at 'Perf events and tool security' document:\n"
+		 "https://www.kernel.org/doc/html/latest/admin-guide/perf-security.html\n"
 		 "perf_event_paranoid setting is %d:\n"
 		 "  -1: Allow use of (almost) all events by all users\n"
 		 "      Ignore mlock limit after perf_event_mlock_kb without CAP_IPC_LOCK\n"
-- 
2.24.1
