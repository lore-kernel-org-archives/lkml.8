Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A443C35DE1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 14:15:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 359F4218AC
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 14:15:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730602AbgBYOPi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 09:15:38 -0500
Received: from outbound-smtp09.blacknight.com ([46.22.139.14]:33927 "EHLO
        outbound-smtp09.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729065AbgBYOPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 09:15:37 -0500
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp09.blacknight.com (Postfix) with ESMTPS id EA0691C35F1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 14:15:35 +0000 (GMT)
Received: (qmail 1851 invoked from network); 25 Feb 2020 14:15:35 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.18.57])
  by 81.17.254.9 with ESMTPA; 25 Feb 2020 14:15:35 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@suse.com>, Vlastimil Babka <vbabka@suse.cz>,
        Ivan Babrou <ivan@cloudflare.com>,
        Rik van Riel <riel@surriel.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 0/3] Limit runaway reclaim due to watermark boosting
Date:   Tue, 25 Feb 2020 14:15:31 +0000
Message-Id: <20200225141534.5044-1-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ivan Babrou reported the following

	Commit 1c30844d2dfe ("mm: reclaim small amounts of memory when
	an external fragmentation event occurs") introduced undesired
	effects in our environment.

	  * NUMA with 2 x CPU
	  * 128GB of RAM
	  * THP disabled
	  * Upgraded from 4.19 to 5.4

	Before we saw free memory hover at around 1.4GB with no
	spikes. After the upgrade we saw some machines decide that they
	need a lot more than that, with frequent spikes above 10GB,
	often only on a single numa node.

There have been a few reports recently that might be watermark boost
related. Unfortunately, finding someone that can reproduce the problem
and test a patch has been problematic.  This series intends to limit
potential damage only.

Patch 1 disables boosting on small memory systems.

Patch 2 disables boosting by default if THP is disabled on the kernel
	command line on the basis that boosting primarily helps THP
	allocation latency. It is not touched at runtime to avoid
	overriding an explicit user request

Patch 3 disables boosting if kswapd priority is elevateed to avoid
	excessive reclaim.

 mm/huge_memory.c |  1 +
 mm/internal.h    |  6 +++++-
 mm/page_alloc.c  |  6 ++++--
 mm/vmscan.c      | 46 +++++++++++++++++++++++++++++++---------------
 4 files changed, 41 insertions(+), 18 deletions(-)

-- 
2.16.4

