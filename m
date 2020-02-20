Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5286FC5ACC4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 01:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32D5121D56
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 01:36:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727677AbgBTBg4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 20:36:56 -0500
Received: from mga02.intel.com ([134.134.136.20]:8059 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727135AbgBTBgz (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 20:36:55 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Feb 2020 17:36:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,462,1574150400"; 
   d="scan'208";a="259114739"
Received: from kbl.sh.intel.com ([10.239.159.24])
  by fmsmga004.fm.intel.com with ESMTP; 19 Feb 2020 17:36:52 -0800
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v7 0/3] perf report: Support sorting by a given event in group
Date:   Thu, 20 Feb 2020 09:36:13 +0800
Message-Id: <20200220013616.19916-1-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When performing "perf report --group", it shows the event group information
together. By default, the output is sorted by the first event in group.
It would be nice for user to select any event for sorting.

The patch 1/3 introduces a new option "--group-sort-idx" to sort the
output by the event at the index n in event group.

The patch 2/3 creates a new key K_RELOAD to reload the browser.

The patch 3/3 supports hotkeys in browser to select a event to
sort.

 v7:
 ---
 v6 was posted two months ago and all comments were fixed.

 v7 just rebases to perf/core, no other change.

Jin Yao (3):
  perf report: Change sort order by a specified event in group
  perf report: Support a new key to reload the browser
  perf report: support hotkey to let user select any event for sorting

 tools/perf/Documentation/perf-report.txt |   5 ++
 tools/perf/builtin-report.c              |  16 +++-
 tools/perf/ui/browsers/hists.c           |  29 ++++++-
 tools/perf/ui/hist.c                     | 104 +++++++++++++++++++----
 tools/perf/ui/keysyms.h                  |   1 +
 tools/perf/util/hist.h                   |   1 +
 tools/perf/util/symbol_conf.h            |   1 +
 7 files changed, 138 insertions(+), 19 deletions(-)

-- 
2.17.1

