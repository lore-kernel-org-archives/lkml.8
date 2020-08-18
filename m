Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEB2FC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 18:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86BDC206B5
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 18:48:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbgHRSsC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 14:48:02 -0400
Received: from mga06.intel.com ([134.134.136.31]:36697 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726576AbgHRSsB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 14:48:01 -0400
IronPort-SDR: IVDYX5Rb3CRXEL/nbryLP52dYXl5H6A4Jf0dzueeCWW9GkaQzyal3M06dhAB4el/zYBVoIowDG
 vwbj/ObYelqw==
X-IronPort-AV: E=McAfee;i="6000,8403,9717"; a="216512912"
X-IronPort-AV: E=Sophos;i="5.76,328,1592895600"; 
   d="scan'208";a="216512912"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2020 11:48:01 -0700
IronPort-SDR: WIa7X/9iStEAYLjxD5dyLJm8cBF40k5hzdTqkxY+uoT8BBhOhJ645QlDpnn5hdNZBWEpEBzXpO
 MdV2IyLkKL9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,328,1592895600"; 
   d="scan'208";a="370983290"
Received: from viggo.jf.intel.com (HELO localhost.localdomain) ([10.54.77.144])
  by orsmga001.jf.intel.com with ESMTP; 18 Aug 2020 11:48:01 -0700
Subject: [RFC][PATCH 0/9] [v3] Migrate Pages in lieu of discard
To:     linux-kernel@vger.kernel.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        yang.shi@linux.alibaba.com, rientjes@google.com,
        ying.huang@intel.com, dan.j.williams@intel.com
From:   Dave Hansen <dave.hansen@linux.intel.com>
Date:   Tue, 18 Aug 2020 11:41:22 -0700
Message-Id: <20200818184122.29C415DF@viggo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

todo:
Changes since (https://lwn.net/Articles/824830/):
 * Use higher-level migrate_pages() API approach from Yang Shi's
   earlier patches.
 * made sure to actually check node_reclaim_mode's new bit
 * disabled migration entirely before introducing RECLAIM_MIGRATE
 * Replace GFP_NOWAIT with explicit __GFP_KSWAPD_RECLAIM and
   comment why we want that.
 * Comment on effects of that keep multiple source nodes from
   sharing target nodes

The full series is also available here:

	https://github.com/hansendc/linux/tree/automigrate-20200818

--

We're starting to see systems with more and more kinds of memory such
as Intel's implementation of persistent memory.

Let's say you have a system with some DRAM and some persistent memory.
Today, once DRAM fills up, reclaim will start and some of the DRAM
contents will be thrown out.  Allocations will, at some point, start
falling over to the slower persistent memory.

That has two nasty properties.  First, the newer allocations can end
up in the slower persistent memory.  Second, reclaimed data in DRAM
are just discarded even if there are gobs of space in persistent
memory that could be used.

This set implements a solution to these problems.  At the end of the
reclaim process in shrink_page_list() just before the last page
refcount is dropped, the page is migrated to persistent memory instead
of being dropped.

While I've talked about a DRAM/PMEM pairing, this approach would
function in any environment where memory tiers exist.

This is not perfect.  It "strands" pages in slower memory and never
brings them back to fast DRAM.  Other things need to be built to
promote hot pages back to DRAM.

This is also all based on an upstream mechanism that allows
persistent memory to be onlined and used as if it were volatile:

	http://lkml.kernel.org/r/20190124231441.37A4A305@viggo.jf.intel.com

== Open Issues ==

 * For cpusets and memory policies that restrict allocations
   to PMEM, is it OK to demote to PMEM?  Do we need a cgroup-
   level API to opt-in or opt-out of these migrations?
 * Migration failures will result in pages being unreclaimable.
   Need to be able to fall back to normal reclaim.


Cc: Yang Shi <yang.shi@linux.alibaba.com>
Cc: David Rientjes <rientjes@google.com>
Cc: Huang Ying <ying.huang@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>

--

Dave Hansen (5):
      mm/numa: node demotion data structure and lookup
      mm/vmscan: Attempt to migrate page in lieu of discard
      mm/numa: automatically generate node migration order
      mm/vmscan: never demote for memcg reclaim
      mm/numa: new reclaim mode to enable reclaim-based migration

Keith Busch (2):
      mm/migrate: Defer allocating new page until needed
      mm/vmscan: Consider anonymous pages without swap

Yang Shi (1):
      mm/vmscan: add page demotion counter

 Documentation/admin-guide/sysctl/vm.rst |    9
 include/linux/migrate.h                 |    6
 include/linux/node.h                    |    9
 include/linux/vm_event_item.h           |    2
 include/trace/events/migrate.h          |    3
 mm/debug.c                              |    1
 mm/internal.h                           |    1
 mm/migrate.c                            |  400 ++++++++++++++++++++++++++------
 mm/page_alloc.c                         |    2
 mm/vmscan.c                             |   88 ++++++-
 mm/vmstat.c                             |    2
 11 files changed, 439 insertions(+), 84 deletions(-)
