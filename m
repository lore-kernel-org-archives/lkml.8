Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80119C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:07:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A99720663
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:07:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730762AbgF2TGd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:06:33 -0400
Received: from mga17.intel.com ([192.55.52.151]:62621 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730523AbgF2TG3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:06:29 -0400
IronPort-SDR: avHOxCyaMxH47z3257V8Qd/6fZ0BEtvTxD2IlF+DAUb9GSz91fbvjCh33rypwz0YX8MSynMu4q
 fvWODqqDLAQA==
X-IronPort-AV: E=McAfee;i="6000,8403,9666"; a="126075721"
X-IronPort-AV: E=Sophos;i="5.75,294,1589266800"; 
   d="scan'208";a="126075721"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2020 02:20:35 -0700
IronPort-SDR: nLpGrcumA+6GC498ABBr/dkx2dEJmkIN/APYDCN5/QDH/Zxi7OURf41G2yPvYoG5OkEQgOrQXE
 To5dQOC5ULFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,294,1589266800"; 
   d="scan'208";a="303001166"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.73])
  by fmsmga004.fm.intel.com with ESMTP; 29 Jun 2020 02:20:33 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] perf scripts python: export-to-postgresql.py: Fix struct.pack() int argument
Date:   Mon, 29 Jun 2020 12:19:50 +0300
Message-Id: <20200629091955.17090-2-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200629091955.17090-1-adrian.hunter@intel.com>
References: <20200629091955.17090-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Python 3.8 is requiring that arguments being packed as integers are
also integers.  Add int() accordingly.

 Before:

   $ perf record -e intel_pt//u uname
   $ perf script --itrace=bep -s ~/libexec/perf-core/scripts/python/export-to-postgresql.py perf_data_db branches calls
   2020-06-25 16:09:10.547256 Creating database...
   2020-06-25 16:09:10.733185 Writing to intermediate files...
   Traceback (most recent call last):
     File "/home/ahunter/libexec/perf-core/scripts/python/export-to-postgresql.py", line 1106, in synth_data
       cbr(id, raw_buf)
     File "/home/ahunter/libexec/perf-core/scripts/python/export-to-postgresql.py", line 1058, in cbr
       value = struct.pack("!hiqiiiiii", 4, 8, id, 4, cbr, 4, MHz, 4, percent)
   struct.error: required argument is not an integer
   Fatal Python error: problem in Python trace event handler
   Python runtime state: initialized

   Current thread 0x00007f35d3695780 (most recent call first):
   <no Python frame>
   Aborted (core dumped)

 After:

   $ dropdb perf_data_db
   $ rm -rf perf_data_db-perf-data
   $ perf script --itrace=bep -s ~/libexec/perf-core/scripts/python/export-to-postgresql.py perf_data_db branches calls
   2020-06-25 16:09:40.990267 Creating database...
   2020-06-25 16:09:41.207009 Writing to intermediate files...
   2020-06-25 16:09:41.270915 Copying to database...
   2020-06-25 16:09:41.382030 Removing intermediate files...
   2020-06-25 16:09:41.384630 Adding primary keys
   2020-06-25 16:09:41.541894 Adding foreign keys
   2020-06-25 16:09:41.677044 Dropping unused tables
   2020-06-25 16:09:41.703761 Done

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Fixes: aba44287a224 ("perf scripts python: export-to-postgresql.py: Export Intel PT power and ptwrite events")
Cc: stable@vger.kernel.org
---
 tools/perf/scripts/python/export-to-postgresql.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/scripts/python/export-to-postgresql.py b/tools/perf/scripts/python/export-to-postgresql.py
index 7bd73a904b4e..d187e46c2683 100644
--- a/tools/perf/scripts/python/export-to-postgresql.py
+++ b/tools/perf/scripts/python/export-to-postgresql.py
@@ -1055,7 +1055,7 @@ def cbr(id, raw_buf):
 	cbr = data[0]
 	MHz = (data[4] + 500) / 1000
 	percent = ((cbr * 1000 / data[2]) + 5) / 10
-	value = struct.pack("!hiqiiiiii", 4, 8, id, 4, cbr, 4, MHz, 4, percent)
+	value = struct.pack("!hiqiiiiii", 4, 8, id, 4, cbr, 4, int(MHz), 4, int(percent))
 	cbr_file.write(value)
 
 def mwait(id, raw_buf):
-- 
2.17.1

