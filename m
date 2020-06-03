Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14966C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 02:20:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0B6F207D8
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 02:20:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725926AbgFCCUk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 22:20:40 -0400
Received: from mga04.intel.com ([192.55.52.120]:56266 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725794AbgFCCUh (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 22:20:37 -0400
IronPort-SDR: D8qdFwugUyplzsf1d1sJQ017MUqdNTHXQm5dxYNlLgtjgO56ZS8iF8rGZ/uYafU7pc7VUdhdFs
 6CE1c8NRI5AQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2020 19:20:36 -0700
IronPort-SDR: qUWPpwL+GNS9ShkA8gnkiQ3wv6ZmVLaikZGSo7rEqFhPZnZ82QVlTSDQSvDRK/GlrHX8r4usEI
 8g0y+HU5QKMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,466,1583222400"; 
   d="scan'208";a="293792544"
Received: from kbl-ppc.sh.intel.com ([10.239.159.118])
  by fmsmga004.fm.intel.com with ESMTP; 02 Jun 2020 19:20:33 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH 0/2] Update CascadelakeX and SkylakeX events list
Date:   Wed,  3 Jun 2020 10:18:16 +0800
Message-Id: <20200603021818.27028-1-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset updates CascadelakeX events to v1.08 and
updates SkylakeX events to v1.21.

The events have been tested on CascadelakeX and SkylakeX
servers with latest perf/core branch.

Jin Yao (2):
  perf vendor events: Update CascadelakeX events to v1.08
  perf vendor events: Update SkylakeX events to v1.21

 .../arch/x86/cascadelakex/cache.json          |   28 +-
 .../arch/x86/cascadelakex/clx-metrics.json    |  153 +-
 .../arch/x86/cascadelakex/frontend.json       |   34 +
 .../arch/x86/cascadelakex/memory.json         |  704 ++---
 .../arch/x86/cascadelakex/other.json          | 1100 ++++----
 .../arch/x86/cascadelakex/pipeline.json       |   10 -
 .../arch/x86/cascadelakex/uncore-other.json   |   21 +
 .../pmu-events/arch/x86/skylakex/cache.json   | 2348 +++++++++--------
 .../arch/x86/skylakex/floating-point.json     |   96 +-
 .../arch/x86/skylakex/frontend.json           |  656 ++---
 .../pmu-events/arch/x86/skylakex/memory.json  | 1977 +++++++-------
 .../pmu-events/arch/x86/skylakex/other.json   |  172 +-
 .../arch/x86/skylakex/pipeline.json           | 1206 +++++----
 .../arch/x86/skylakex/skx-metrics.json        |  141 +-
 .../arch/x86/skylakex/uncore-memory.json      |   26 +-
 .../arch/x86/skylakex/uncore-other.json       |  730 ++++-
 .../arch/x86/skylakex/virtual-memory.json     |  358 +--
 17 files changed, 5198 insertions(+), 4562 deletions(-)

-- 
2.17.1

