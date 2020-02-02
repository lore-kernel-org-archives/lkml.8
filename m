Return-Path: <SRS0=NZ9A=3W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4FB5C3524A
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Feb 2020 14:17:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2B1420838
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Feb 2020 14:17:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726940AbgBBORZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Feb 2020 09:17:25 -0500
Received: from mga18.intel.com ([134.134.136.126]:6183 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726758AbgBBORY (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Sun, 2 Feb 2020 09:17:24 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Feb 2020 06:17:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,394,1574150400"; 
   d="scan'208";a="253811052"
Received: from kbl.sh.intel.com ([10.239.159.24])
  by fmsmga004.fm.intel.com with ESMTP; 02 Feb 2020 06:17:20 -0800
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v6 0/4] perf: Refactor the block info implementation
Date:   Sun,  2 Feb 2020 22:16:51 +0800
Message-Id: <20200202141655.32053-1-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series refactors the block info functionalities to let them
be used by other builtins and allow setting the output fmts flexibly.

It also supports the 'Sampled Cycles%' and 'Avg Cycles%' printed in
colors.

 v6:
 ---
 Use __block_info__cmp to replace block_pair_cmp according to Arnaldo's
 suggestions. Fix some issues found in block_info__cmp.

 New patches:
 ------------
 perf util: Fix wrong block address comparison in block_info__cmp
 perf util: Use __block_info__cmp to replace block_pair_cmp

 Unchanged patches:
 ------------------
 perf util: Flexible to set block info output formats
 perf util: Support color ops to print block percents in color

 v5:
 ---
 Only change the patch "perf util: Flexible to set block info output formats".
 Other patches are not changed.

Jin Yao (4):
  perf util: Fix wrong block address comparison in block_info__cmp
  perf util: Use __block_info__cmp to replace block_pair_cmp
  perf util: Flexible to set block info output formats
  perf util: Support color ops to print block percents in color

 tools/perf/builtin-diff.c    |  21 +------
 tools/perf/builtin-report.c  |  21 ++++++-
 tools/perf/util/block-info.c | 106 +++++++++++++++++++++--------------
 tools/perf/util/block-info.h |   9 ++-
 4 files changed, 91 insertions(+), 66 deletions(-)

-- 
2.17.1

