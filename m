Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34BE4C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:07:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23170207F9
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:07:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730653AbgF2THM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:07:12 -0400
Received: from mga17.intel.com ([192.55.52.151]:62624 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730752AbgF2TGc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:06:32 -0400
IronPort-SDR: AUWlgaVCG97hPzzYVPxWPhOJjNJ/FshjfmmxFasgw+3y1Okg7TpTcWdngRHPw7n1YRBPNNdbvX
 LeXHPqVrcIIQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9666"; a="126075741"
X-IronPort-AV: E=Sophos;i="5.75,294,1589266800"; 
   d="scan'208";a="126075741"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2020 02:20:45 -0700
IronPort-SDR: NMLhYEMSCaor3fmiTKY4DLeY2S9czCd0u1QDK/s0P0UzoaY3PzkXjXnU+sddJjszp0SxhTSfIH
 RE1Vx/02LIfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,294,1589266800"; 
   d="scan'208";a="303001198"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.73])
  by fmsmga004.fm.intel.com with ESMTP; 29 Jun 2020 02:20:43 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] perf scripts python: exported-sql-viewer.py: Fix time chart call tree
Date:   Mon, 29 Jun 2020 12:19:55 +0300
Message-Id: <20200629091955.17090-7-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200629091955.17090-1-adrian.hunter@intel.com>
References: <20200629091955.17090-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using Python version 3.8.2 and PySide2 version 5.14.0, time chart call tree
would not expand the tree to the result. Fix by using setExpanded().

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

 Select: Charts -> Time chart by CPU
 Move mouse over middle of chart
 Right-click and select Show Call Tree

 Before: displays Call Tree but not expanded to selected time
 After: displays Call Tree expanded to selected time

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Fixes: e69d5df75d74d ("perf scripts python: exported-sql-viewer.py: Add ability for Call tree to open at a specified task and time")
Cc: stable@vger.kernel.org
---
 tools/perf/scripts/python/exported-sql-viewer.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/scripts/python/exported-sql-viewer.py b/tools/perf/scripts/python/exported-sql-viewer.py
index 0f295055ac6b..7daa8bb70a5a 100755
--- a/tools/perf/scripts/python/exported-sql-viewer.py
+++ b/tools/perf/scripts/python/exported-sql-viewer.py
@@ -1130,6 +1130,7 @@ class CallTreeWindow(TreeWindowBase):
 				child = self.model.index(row, 0, parent)
 				if child.internalPointer().dbid == dbid:
 					found = True
+					self.view.setExpanded(parent, True)
 					self.view.setCurrentIndex(child)
 					parent = child
 					break
@@ -1142,6 +1143,7 @@ class CallTreeWindow(TreeWindowBase):
 				return
 			last_child = None
 			for row in xrange(n):
+				self.view.setExpanded(parent, True)
 				child = self.model.index(row, 0, parent)
 				child_call_time = child.internalPointer().call_time
 				if child_call_time < time:
@@ -1154,9 +1156,11 @@ class CallTreeWindow(TreeWindowBase):
 			if not last_child:
 				if not found:
 					child = self.model.index(0, 0, parent)
+					self.view.setExpanded(parent, True)
 					self.view.setCurrentIndex(child)
 				return
 			found = True
+			self.view.setExpanded(parent, True)
 			self.view.setCurrentIndex(last_child)
 			parent = last_child
 
-- 
2.17.1

