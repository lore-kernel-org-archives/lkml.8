Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF8C7C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:07:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC2EC2078B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:07:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730813AbgF2THR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:07:17 -0400
Received: from mga17.intel.com ([192.55.52.151]:62621 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729133AbgF2TGb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:06:31 -0400
IronPort-SDR: 4i7eTawkDIOs3AGNBStxrM3oxz+LqREuCtsY7KD4vpISHr/FEnTj/UPiV2Nxqy/0B0M7gFmhh2
 Zt0pHDlJYPgg==
X-IronPort-AV: E=McAfee;i="6000,8403,9666"; a="126075717"
X-IronPort-AV: E=Sophos;i="5.75,294,1589266800"; 
   d="scan'208";a="126075717"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2020 02:20:33 -0700
IronPort-SDR: uiLdCf2L2pE6F4RnaZaeC+XZf8qI1quWnfKOuEb9jHfPdtPy1AbDueIs9OvPFQGv4EqachjjhA
 t8MbLhKQtQlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,294,1589266800"; 
   d="scan'208";a="303001159"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.73])
  by fmsmga004.fm.intel.com with ESMTP; 29 Jun 2020 02:20:32 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] perf tools: Some Intel PT related fixes for v5.8
Date:   Mon, 29 Jun 2020 12:19:49 +0300
Message-Id: <20200629091955.17090-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Here are some Intel PT related fixes for v5.8.


Adrian Hunter (6):
      perf scripts python: export-to-postgresql.py: Fix struct.pack() int argument
      perf record: Fix duplicated sideband events with Intel PT system wide tracing
      perf scripts python: exported-sql-viewer.py: Fix unexpanded 'Find' result
      perf scripts python: exported-sql-viewer.py: Fix zero id in call graph 'Find' result
      perf scripts python: exported-sql-viewer.py: Fix zero id in call tree 'Find' result
      perf scripts python: exported-sql-viewer.py: Fix time chart call tree

 tools/perf/builtin-record.c                       | 18 +++++++++---------
 tools/perf/scripts/python/export-to-postgresql.py |  2 +-
 tools/perf/scripts/python/exported-sql-viewer.py  | 11 +++++++++--
 tools/perf/util/evlist.c                          | 12 ++++++++++++
 tools/perf/util/evlist.h                          |  1 +
 tools/perf/util/evsel.c                           |  8 +-------
 tools/perf/util/evsel.h                           |  6 ++++++
 7 files changed, 39 insertions(+), 19 deletions(-)


Regards
Adrian
