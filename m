Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E5B7C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 07:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3593822B40
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 07:57:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728037AbgHEH5G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 03:57:06 -0400
Received: from mga12.intel.com ([192.55.52.136]:41212 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726980AbgHEH5A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 03:57:00 -0400
IronPort-SDR: uds12QRwwSPT3JLfbFWOjajMo2QJAEOrWY94TLXF+8D6g/DBy1N81sHR9jsLiiBQ/4OkL6qt6C
 rs2Cm+HDi/1Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9703"; a="132047052"
X-IronPort-AV: E=Sophos;i="5.75,436,1589266800"; 
   d="scan'208";a="132047052"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2020 00:57:00 -0700
IronPort-SDR: j5lv7mJNN8SZ/0Y4oelgcCirF5HrweytE33Vc+SQFdp+JbwgQIbRAC7WzcU65IFRQLqitRleZ7
 B96+iMPaCdPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,436,1589266800"; 
   d="scan'208";a="396842529"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga001.fm.intel.com with ESMTP; 05 Aug 2020 00:57:00 -0700
Received: from [10.249.227.101] (abudanko-mobl.ccr.corp.intel.com [10.249.227.101])
        by linux.intel.com (Postfix) with ESMTP id 1C23A580713;
        Wed,  5 Aug 2020 00:56:57 -0700 (PDT)
To:     Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: [PATCH v1] perf/core: take over CAP_SYS_PTRACE creds to CAP_PERFMON
 cap
Organization: Intel Corp.
Message-ID: <6e8392ff-4732-0012-2949-e1587709f0f6@linux.intel.com>
Date:   Wed, 5 Aug 2020 10:56:56 +0300
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


Open access to per-process monitoring for CAP_PERFMON only
privileged processes [1]. Extend ptrace_may_access() check
in perf_events subsystem with perfmon_capable() to simplify
user experience and make monitoring more secure by reducing
attack surface.

[1] https://lore.kernel.org/lkml/7776fa40-6c65-2aa6-1322-eb3a01201000@linux.intel.com/

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 kernel/events/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 856d98c36f56..f50d528af444 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -11587,7 +11587,7 @@ SYSCALL_DEFINE5(perf_event_open,
 			goto err_task;
 
 		/*
-		 * Reuse ptrace permission checks for now.
+		 * Preserve ptrace permission check for backwards compatibility.
 		 *
 		 * We must hold exec_update_mutex across this and any potential
 		 * perf_install_in_context() call for this new event to
@@ -11595,7 +11595,7 @@ SYSCALL_DEFINE5(perf_event_open,
 		 * perf_event_exit_task() that could imply).
 		 */
 		err = -EACCES;
-		if (!ptrace_may_access(task, PTRACE_MODE_READ_REALCREDS))
+		if (!perfmon_capable() && !ptrace_may_access(task, PTRACE_MODE_READ_REALCREDS))
 			goto err_cred;
 	}
 
-- 
2.24.1

