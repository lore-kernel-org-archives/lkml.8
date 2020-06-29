Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCE93C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:07:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A988420663
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:07:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730405AbgF2THP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:07:15 -0400
Received: from mga17.intel.com ([192.55.52.151]:62621 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729064AbgF2TGc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:06:32 -0400
IronPort-SDR: o4TYOTXhqg3RgA9L97IlRf6f3E9noCLc8rNkVbfrm23brw1ypOHL2pdW/F74vL1/Wg1u83RqFG
 PV4z0qVH8Phw==
X-IronPort-AV: E=McAfee;i="6000,8403,9666"; a="126075739"
X-IronPort-AV: E=Sophos;i="5.75,294,1589266800"; 
   d="scan'208";a="126075739"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2020 02:20:43 -0700
IronPort-SDR: cOzZ3MveNN8ZkbfE9/UZ7zDb6zrOiJ4QiAtskA+98Zcgjn20GDDQ8C0kndkJhIstM5YOhvkhfM
 Qw858FEfr2/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,294,1589266800"; 
   d="scan'208";a="303001190"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.73])
  by fmsmga004.fm.intel.com with ESMTP; 29 Jun 2020 02:20:42 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] perf scripts python: exported-sql-viewer.py: Fix zero id in call tree 'Find' result
Date:   Mon, 29 Jun 2020 12:19:54 +0300
Message-Id: <20200629091955.17090-6-adrian.hunter@intel.com>
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

 Select: Reports -> Call Tree
 Press: Ctrl-F
 Enter: unknown
 Press: Enter

 Before: displays 'unknown' not found
 After: tree is expanded to line showing 'unknown'

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Fixes: ae8b887c00d3f ("perf scripts python: exported-sql-viewer.py: Add call tree")
Cc: stable@vger.kernel.org
---
 tools/perf/scripts/python/exported-sql-viewer.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/scripts/python/exported-sql-viewer.py b/tools/perf/scripts/python/exported-sql-viewer.py
index e0c90aeff15e..0f295055ac6b 100755
--- a/tools/perf/scripts/python/exported-sql-viewer.py
+++ b/tools/perf/scripts/python/exported-sql-viewer.py
@@ -964,7 +964,8 @@ class CallTreeModel(CallGraphModelBase):
 						" FROM calls"
 						" INNER JOIN call_paths ON calls.call_path_id = call_paths.id"
 						" INNER JOIN symbols ON call_paths.symbol_id = symbols.id"
-						" WHERE symbols.name" + match +
+						" WHERE calls.id <> 0"
+						" AND symbols.name" + match +
 						" ORDER BY comm_id, thread_id, call_time, calls.id")
 
 	def FindPath(self, query):
-- 
2.17.1

