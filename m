Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D71BAC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 23:48:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C18FC20780
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 23:48:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727892AbgF2Xs3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 19:48:29 -0400
Received: from mga09.intel.com ([134.134.136.24]:22692 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726750AbgF2Xs2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 19:48:28 -0400
IronPort-SDR: 1ISjF8U1e3+VZtV9ofooc+fdY/Nz4zrsuU2ItNhvirimdsLVg9RCmB8/ejQNCjpAdGyBT6ADkx
 YmvH+mqVpnpA==
X-IronPort-AV: E=McAfee;i="6000,8403,9666"; a="147653424"
X-IronPort-AV: E=Sophos;i="5.75,296,1589266800"; 
   d="scan'208";a="147653424"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2020 16:48:28 -0700
IronPort-SDR: oVTVuftkIOwxt3/rKONa/WAgktlBs5S7lFl0aeQLbZHwD22qNFzck0p3Mk/bvCrABzf7t/BLOh
 Nnko91nBbidg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,296,1589266800"; 
   d="scan'208";a="480737975"
Received: from viggo.jf.intel.com (HELO localhost.localdomain) ([10.54.77.144])
  by fmsmga006.fm.intel.com with ESMTP; 29 Jun 2020 16:48:27 -0700
Subject: [RFC][PATCH 0/8] Migrate Pages in lieu of discard
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, Dave Hansen <dave.hansen@linux.intel.com>,
        yang.shi@linux.alibaba.com, rientjes@google.com,
        ying.huang@intel.com, dan.j.williams@intel.com
From:   Dave Hansen <dave.hansen@linux.intel.com>
Date:   Mon, 29 Jun 2020 16:45:03 -0700
Message-Id: <20200629234503.749E5340@viggo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've been sitting on these for too long.  Tha main purpose of this
post is to have a public discussion with the other folks who are
interested in this functionalty and converge on a single
implementation.

This set directly incorporates a statictics patch from Yang Shi and
also includes one to ensure good behavior with cgroup reclaim which
was very closely derived from this series:

	https://lore.kernel.org/linux-mm/1560468577-101178-1-git-send-email-yang.shi@linux.alibaba.com/

Since the last post, the major changes are:
 - Added patch to skip migration when doing cgroup reclaim
 - Added stats patch from Yang Shi

The full series is also available here:

	https://github.com/hansendc/linux/tree/automigrate-20200629

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

This is part of a larger patch set.  If you want to apply these or
play with them, I'd suggest using the tree from here.  It includes
autonuma-based hot page promotion back to DRAM:

	http://lkml.kernel.org/r/c3d6de4d-f7c3-b505-2e64-8ee5f70b2118@intel.com

This is also all based on an upstream mechanism that allows
persistent memory to be onlined and used as if it were volatile:

	http://lkml.kernel.org/r/20190124231441.37A4A305@viggo.jf.intel.com

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
