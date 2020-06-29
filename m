Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF910C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:07:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5A79206E2
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:07:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730688AbgF2THN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:07:13 -0400
Received: from mga17.intel.com ([192.55.52.151]:62624 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730747AbgF2TGb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:06:31 -0400
IronPort-SDR: nDZAJXTGs8YDnpkZuWwEyX8liZUwtFgYIBvKZQBU/vLJzG6Io084Dm8Rf7avhZyp/M7HkRfSPh
 T/Smze7tyEcA==
X-IronPort-AV: E=McAfee;i="6000,8403,9666"; a="126075735"
X-IronPort-AV: E=Sophos;i="5.75,294,1589266800"; 
   d="scan'208";a="126075735"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2020 02:20:42 -0700
IronPort-SDR: WkTPs9khza8W+fPOqa6OvMgTsbmQqG18xd/ECRJgOyDqD6Fm2LkalLuHIh6ezNR0M5pKNmKB63
 Ws1mPxUqJ6Mw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,294,1589266800"; 
   d="scan'208";a="303001182"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.73])
  by fmsmga004.fm.intel.com with ESMTP; 29 Jun 2020 02:20:40 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] perf scripts python: exported-sql-viewer.py: Fix zero id in call graph 'Find' result
Date:   Mon, 29 Jun 2020 12:19:53 +0300
Message-Id: <20200629091955.17090-5-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200629091955.17090-1-adrian.hunter@intel.com>
References: <20200629091955.17090-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using ctrl-F ('Find') would not find 'unknown' because it matches id zero.
Fix by excluding id zero from selection.

Example:
 $ perf record -e intel_pt//u uname
 Linux
 [ perf record: Woken up 1 times to write data ]
 [ perf record: Captured and wrote 0.034 MB perf.data ]
 $ perf script --itrace=bep -s ~/libexec/perf-core/scripts/python/export-to-sqlite.py perf.data.db branches calls
 2020-06-26 15:32:14.928997 Creating database ...
 2020-06-26 15:32:14.933971 Writing records...
 2020-06-26 15:32:15.535251 Adding indexes
 2020-06-26 15:32:15.542993 Dropping unused tables
 2020-06-26 15:32:15.549716 Done
 $ python3 ~/libexec/perf-core/scripts/python/exported-sql-viewer.py perf.data.db

 Select: Reports -> Context-Sensitive Call Graph
 Press: Ctrl-F
 Enter: unknown
 Press: Enter

 Before: gets stuck
 After: tree is expanded to line showing 'unknown'

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Fixes: 254c0d820b86d ("perf scripts python: exported-sql-viewer.py: Factor out CallGraphModelBase")
Cc: stable@vger.kernel.org
---
 tools/perf/scripts/python/exported-sql-viewer.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/scripts/python/exported-sql-viewer.py b/tools/perf/scripts/python/exported-sql-viewer.py
index 4be7cb68c8bb..e0c90aeff15e 100755
--- a/tools/perf/scripts/python/exported-sql-viewer.py
+++ b/tools/perf/scripts/python/exported-sql-viewer.py
@@ -768,7 +768,8 @@ class CallGraphModel(CallGraphModelBase):
 						" FROM calls"
 						" INNER JOIN call_paths ON calls.call_path_id = call_paths.id"
 						" INNER JOIN symbols ON call_paths.symbol_id = symbols.id"
-						" WHERE symbols.name" + match +
+						" WHERE calls.id <> 0"
+						" AND symbols.name" + match +
 						" GROUP BY comm_id, thread_id, call_path_id"
 						" ORDER BY comm_id, thread_id, call_path_id")
 
-- 
2.17.1

