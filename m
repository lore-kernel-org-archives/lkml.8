Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A5BFC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 13:40:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 477DA206C0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 13:40:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387574AbgF3Nka (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 09:40:30 -0400
Received: from mga14.intel.com ([192.55.52.115]:31774 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733176AbgF3NkR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 09:40:17 -0400
IronPort-SDR: QZtyM2bXGqgEDinA5o2y5d3qkEbo1ZKQuNEfZBqyJzV15Hy4+VKxpx7xJBO5z9riJxKBREvWlv
 81lgXHivHG+w==
X-IronPort-AV: E=McAfee;i="6000,8403,9666"; a="145302182"
X-IronPort-AV: E=Sophos;i="5.75,297,1589266800"; 
   d="scan'208";a="145302182"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2020 06:40:17 -0700
IronPort-SDR: AhFVT77Ejx9Lv4q/n36aGKK2LfqKyxRrXlthuVayxDW4zLlemBfd+nbiKwcIhExxxX1IpkTPpm
 N6BLZvY9YsqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,297,1589266800"; 
   d="scan'208";a="425207203"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.73])
  by orsmga004.jf.intel.com with ESMTP; 30 Jun 2020 06:40:15 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        Luwei Kang <luwei.kang@intel.com>
Subject: [PATCH 2/3] perf intel-pt: Fix displaying PEBS-via-PT with registers
Date:   Tue, 30 Jun 2020 16:39:34 +0300
Message-Id: <20200630133935.11150-3-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200630133935.11150-1-adrian.hunter@intel.com>
References: <20200630133935.11150-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After recording PEBS-via-PT, perf script will not accept 'iregs' field e.g.

 # perf record -c 10000 -e '{intel_pt/branch=0/,branch-loads/aux-output/ppp}' -I -- ls -l
 ...
 [ perf record: Woken up 1 times to write data ]
 [ perf record: Captured and wrote 0.062 MB perf.data ]
 # ./perf script --itrace=eop -F+iregs
 Samples for 'dummy:u' event do not have IREGS attribute set. Cannot print 'iregs' field.

Fix by using allow_user_set, which is true when recording AUX area data.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Fixes: 9e64cefe4335b ("perf intel-pt: Process options for PEBS event synthesis")
---
 tools/perf/builtin-script.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 5da243676f12..31420baa1fb5 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -462,7 +462,7 @@ static int perf_evsel__check_attr(struct evsel *evsel, struct perf_session *sess
 		return -EINVAL;
 
 	if (PRINT_FIELD(IREGS) &&
-	    evsel__check_stype(evsel, PERF_SAMPLE_REGS_INTR, "IREGS", PERF_OUTPUT_IREGS))
+	    evsel__do_check_stype(evsel, PERF_SAMPLE_REGS_INTR, "IREGS", PERF_OUTPUT_IREGS, allow_user_set))
 		return -EINVAL;
 
 	if (PRINT_FIELD(UREGS) &&
-- 
2.17.1

