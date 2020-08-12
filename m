Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C099C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 07:00:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7870D204FD
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 07:00:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbgHLHAb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 03:00:31 -0400
Received: from mga14.intel.com ([192.55.52.115]:19560 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726430AbgHLHAT (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 03:00:19 -0400
IronPort-SDR: IBaa/VuVjyzLqfEzBc+/KKDSLWa2BwpfElKUXd8IxrmzwIr6IUYBfFg7bFTw12tfPOteu9iefK
 T0EHgwBS8pRg==
X-IronPort-AV: E=McAfee;i="6000,8403,9710"; a="153123237"
X-IronPort-AV: E=Sophos;i="5.76,303,1592895600"; 
   d="scan'208";a="153123237"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2020 00:00:18 -0700
IronPort-SDR: rkDGsL7AV1TKr1aeAiGEWGhM+jb9xINC8K3vDWH4vhPZkUIUvxQH7p9JDx/0atYOxUl5G69f04
 CCBnrBYnl68Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,303,1592895600"; 
   d="scan'208";a="494932590"
Received: from kbl-ppc.sh.intel.com ([10.239.159.55])
  by fmsmga006.fm.intel.com with ESMTP; 12 Aug 2020 00:00:16 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com, like.xu@linux.intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH] perf parse-events: Set exclude_guest for user-space counting
Date:   Wed, 12 Aug 2020 14:59:53 +0800
Message-Id: <20200812065953.22143-1-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently if we run 'perf record -e cycles:u', exclude_guest is 0.

But it doesn't make sense that we request for user-space counting
but we also get the guest report.

To keep perf semantics consistent and clear, this patch sets
exclude_guest for user-space counting.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/util/parse-events.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 9f7260e69113..4d809f1fe269 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1794,6 +1794,8 @@ static int get_event_modifier(struct event_modifier *mod, char *str,
 		if (*str == 'u') {
 			if (!exclude)
 				exclude = eu = ek = eh = 1;
+			if (!exclude_GH)
+				eG = 1;
 			eu = 0;
 		} else if (*str == 'k') {
 			if (!exclude)
-- 
2.17.1

