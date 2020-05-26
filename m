Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90115C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 15:29:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7957320723
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 15:29:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729631AbgEZP3o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 11:29:44 -0400
Received: from mga17.intel.com ([192.55.52.151]:38944 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728815AbgEZP3n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 11:29:43 -0400
IronPort-SDR: 62fzOH2BlnGAWZrnti9GuhyP/IzV6hLZ2hLhR3mTjZJ96MbAfJoIhBzHXy9qONtSY7Y+ynkg4z
 Fuzk2o/G+bTA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2020 08:29:42 -0700
IronPort-SDR: jnJRvTL9gukLkg7yEltBlxK2ScxlKlf09k/l7Httbex6BHUn1aMajFaYO62eTP+JZ2PmoaUr/a
 47RSaQbC3RIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,437,1583222400"; 
   d="scan'208";a="442121513"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.157])
  by orsmga005.jf.intel.com with ESMTP; 26 May 2020 08:29:40 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Travis Downs <travis.downs@gmail.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: [PATCH] perf tools: Fix debuginfo search for Ubuntu
Date:   Tue, 26 May 2020 18:29:10 +0300
Message-Id: <20200526152910.1587-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reportedly, from 19.10 Ubuntu has begun mixing up the location of some
debug symbol files, putting files expected to be in
/usr/lib/debug/usr/lib into /usr/lib/debug/lib instead. Fix by adding
another dso_binary_type.

Example on Ubuntu 20.04

  Before:

    $ perf record -e intel_pt//u uname
    Linux
    [ perf record: Woken up 1 times to write data ]
    [ perf record: Captured and wrote 0.030 MB perf.data ]
    $ perf script --call-trace | head -5
           uname 14003 [005] 15321.764958566:  cbr: 42 freq: 4219 MHz (156%)
           uname 14003 [005] 15321.764958566: (/usr/lib/x86_64-linux-gnu/ld-2.31.so              )          7f1e71cc4100
           uname 14003 [005] 15321.764961566: (/usr/lib/x86_64-linux-gnu/ld-2.31.so              )              7f1e71cc4df0
           uname 14003 [005] 15321.764961900: (/usr/lib/x86_64-linux-gnu/ld-2.31.so              )              7f1e71cc4e18
           uname 14003 [005] 15321.764963233: (/usr/lib/x86_64-linux-gnu/ld-2.31.so              )              7f1e71cc5128

  After:

    $ perf script --call-trace | head -5
           uname 14003 [005] 15321.764958566:  cbr: 42 freq: 4219 MHz (156%)
           uname 14003 [005] 15321.764958566: (/usr/lib/x86_64-linux-gnu/ld-2.31.so              )      _start
           uname 14003 [005] 15321.764961566: (/usr/lib/x86_64-linux-gnu/ld-2.31.so              )          _dl_start
           uname 14003 [005] 15321.764961900: (/usr/lib/x86_64-linux-gnu/ld-2.31.so              )          _dl_start
           uname 14003 [005] 15321.764963233: (/usr/lib/x86_64-linux-gnu/ld-2.31.so              )          _dl_start

Reported-by: Travis Downs <travis.downs@gmail.com>
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: stable@vger.kernel.org
---
 tools/perf/util/dso.c          | 14 ++++++++++++++
 tools/perf/util/dso.h          |  1 +
 tools/perf/util/probe-finder.c |  1 +
 tools/perf/util/symbol.c       |  2 ++
 4 files changed, 18 insertions(+)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index e68e1375e3c0..15b635d6c83c 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -47,6 +47,7 @@ char dso__symtab_origin(const struct dso *dso)
 		[DSO_BINARY_TYPE__BUILD_ID_CACHE_DEBUGINFO]	= 'D',
 		[DSO_BINARY_TYPE__FEDORA_DEBUGINFO]		= 'f',
 		[DSO_BINARY_TYPE__UBUNTU_DEBUGINFO]		= 'u',
+		[DSO_BINARY_TYPE__MIXEDUP_UBUNTU_DEBUGINFO]	= 'x',
 		[DSO_BINARY_TYPE__OPENEMBEDDED_DEBUGINFO]	= 'o',
 		[DSO_BINARY_TYPE__BUILDID_DEBUGINFO]		= 'b',
 		[DSO_BINARY_TYPE__SYSTEM_PATH_DSO]		= 'd',
@@ -129,6 +130,19 @@ int dso__read_binary_type_filename(const struct dso *dso,
 		snprintf(filename + len, size - len, "%s", dso->long_name);
 		break;
 
+	case DSO_BINARY_TYPE__MIXEDUP_UBUNTU_DEBUGINFO:
+		/*
+		 * Ubuntu can mixup /usr/lib with /lib, putting debuginfo in
+		 * /usr/lib/debug/lib when it is expected to be in
+		 * /usr/lib/debug/usr/lib
+		 */
+		if (strlen(dso->long_name) < 9 ||
+		    strncmp(dso->long_name, "/usr/lib/", 9))
+			ret = -1;
+		len = __symbol__join_symfs(filename, size, "/usr/lib/debug");
+		snprintf(filename + len, size - len, "%s", dso->long_name + 4);
+		break;
+
 	case DSO_BINARY_TYPE__OPENEMBEDDED_DEBUGINFO:
 	{
 		const char *last_slash;
diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index 42b3a278ac59..8b7958f02609 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -30,6 +30,7 @@ enum dso_binary_type {
 	DSO_BINARY_TYPE__BUILD_ID_CACHE_DEBUGINFO,
 	DSO_BINARY_TYPE__FEDORA_DEBUGINFO,
 	DSO_BINARY_TYPE__UBUNTU_DEBUGINFO,
+	DSO_BINARY_TYPE__MIXEDUP_UBUNTU_DEBUGINFO,
 	DSO_BINARY_TYPE__BUILDID_DEBUGINFO,
 	DSO_BINARY_TYPE__SYSTEM_PATH_DSO,
 	DSO_BINARY_TYPE__GUEST_KMODULE,
diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
index e4cff49384f4..55924255c535 100644
--- a/tools/perf/util/probe-finder.c
+++ b/tools/perf/util/probe-finder.c
@@ -101,6 +101,7 @@ enum dso_binary_type distro_dwarf_types[] = {
 	DSO_BINARY_TYPE__UBUNTU_DEBUGINFO,
 	DSO_BINARY_TYPE__OPENEMBEDDED_DEBUGINFO,
 	DSO_BINARY_TYPE__BUILDID_DEBUGINFO,
+	DSO_BINARY_TYPE__MIXEDUP_UBUNTU_DEBUGINFO,
 	DSO_BINARY_TYPE__NOT_FOUND,
 };
 
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 7725c83996f4..44d81f90b604 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -79,6 +79,7 @@ static enum dso_binary_type binary_type_symtab[] = {
 	DSO_BINARY_TYPE__SYSTEM_PATH_KMODULE,
 	DSO_BINARY_TYPE__SYSTEM_PATH_KMODULE_COMP,
 	DSO_BINARY_TYPE__OPENEMBEDDED_DEBUGINFO,
+	DSO_BINARY_TYPE__MIXEDUP_UBUNTU_DEBUGINFO,
 	DSO_BINARY_TYPE__NOT_FOUND,
 };
 
@@ -1529,6 +1530,7 @@ static bool dso__is_compatible_symtab_type(struct dso *dso, bool kmod,
 	case DSO_BINARY_TYPE__SYSTEM_PATH_DSO:
 	case DSO_BINARY_TYPE__FEDORA_DEBUGINFO:
 	case DSO_BINARY_TYPE__UBUNTU_DEBUGINFO:
+	case DSO_BINARY_TYPE__MIXEDUP_UBUNTU_DEBUGINFO:
 	case DSO_BINARY_TYPE__BUILDID_DEBUGINFO:
 	case DSO_BINARY_TYPE__OPENEMBEDDED_DEBUGINFO:
 		return !kmod && dso->kernel == DSO_TYPE_USER;
-- 
2.17.1

