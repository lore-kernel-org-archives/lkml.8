Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E4BAC2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 12:56:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59B4D24683
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 12:56:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbgA1M40 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 07:56:26 -0500
Received: from mga03.intel.com ([134.134.136.65]:39253 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725283AbgA1M40 (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 07:56:26 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Jan 2020 04:56:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,373,1574150400"; 
   d="scan'208";a="309073684"
Received: from kbl.sh.intel.com ([10.239.159.24])
  by orsmga001.jf.intel.com with ESMTP; 28 Jan 2020 04:56:23 -0800
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v5 0/4] perf: Refactor the block info implementation
Date:   Tue, 28 Jan 2020 20:55:52 +0800
Message-Id: <20200128125556.25498-1-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series refactors the block info functionalities to let them
be used by other builtins and allow setting the output fmts flexibly.

It also supports the 'Sampled Cycles%' and 'Avg Cycles%' printed in
colors.

 v5:
 ---
 Only change the patch "perf util: Flexible to set block info output formats".
 Other patches are not changed.

Jin Yao (4):
  perf util: Move block_pair_cmp to block-info
  perf util: Validate map/dso/sym before comparing blocks
  perf util: Flexible to set block info output formats
  perf util: Support color ops to print block percents in color

 tools/perf/builtin-diff.c    | 17 -------
 tools/perf/builtin-report.c  | 21 ++++++--
 tools/perf/util/block-info.c | 99 ++++++++++++++++++++++++++----------
 tools/perf/util/block-info.h |  9 +++-
 4 files changed, 99 insertions(+), 47 deletions(-)

-- 
2.17.1

