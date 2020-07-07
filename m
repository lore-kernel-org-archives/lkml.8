Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B57CFC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 14:46:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 943E1206DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 14:46:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="bBfIegz+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728184AbgGGOqj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 10:46:39 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:14063 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726805AbgGGOqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 10:46:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1594133200; x=1625669200;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=lXfPh1cIq2OX1oePMsmgXGjuzMq12soLCAiX+ykF0N8=;
  b=bBfIegz+I3wbqhc6egBYWnq3wVF0lJXsrV2ivXUDsl+ZsLcy/apv/gN9
   Re5X8AavG/Q7mvEOiEkVegRbZgrLi+XElbOKXFqlBVkxbCQ0LsVMnxgXN
   kg4VCkFjW0Pyi5EunstFFbnPW779+cxFzDIWBwdlemHsvF5FqAju6v9HU
   E=;
IronPort-SDR: aOSU1x9erEaGD6R9Jbjwon6LvaU8Q11pczIrtEFRU7M22h/wSdrAKPmX2dliSByZGfodw+vuOk
 uk6Oz041Y5OQ==
X-IronPort-AV: E=Sophos;i="5.75,324,1589241600"; 
   d="scan'208";a="40469771"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2c-579b7f5b.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 07 Jul 2020 14:46:35 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2c-579b7f5b.us-west-2.amazon.com (Postfix) with ESMTPS id 04473A1FF6;
        Tue,  7 Jul 2020 14:46:31 +0000 (UTC)
Received: from EX13D31EUA004.ant.amazon.com (10.43.165.161) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 7 Jul 2020 14:46:31 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.161.214) by
 EX13D31EUA004.ant.amazon.com (10.43.165.161) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 7 Jul 2020 14:46:13 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     <akpm@linux-foundation.org>
CC:     SeongJae Park <sjpark@amazon.de>, <Jonathan.Cameron@Huawei.com>,
        <aarcange@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <amit@kernel.org>,
        <benh@kernel.crashing.org>, <brendan.d.gregg@gmail.com>,
        <brendanhiggins@google.com>, <cai@lca.pw>,
        <colin.king@canonical.com>, <corbet@lwn.net>, <david@redhat.com>,
        <dwmw@amazon.com>, <foersleo@amazon.de>, <irogers@google.com>,
        <jolsa@redhat.com>, <kirill@shutemov.name>, <mark.rutland@arm.com>,
        <mgorman@suse.de>, <minchan@kernel.org>, <mingo@redhat.com>,
        <namhyung@kernel.org>, <peterz@infradead.org>,
        <rdunlap@infradead.org>, <riel@surriel.com>, <rientjes@google.com>,
        <rostedt@goodmis.org>, <rppt@kernel.org>, <sblbir@amazon.com>,
        <shakeelb@google.com>, <shuah@kernel.org>, <sj38.park@gmail.com>,
        <snu@amazon.de>, <vbabka@suse.cz>, <vdavydov.dev@gmail.com>,
        <yang.shi@linux.alibaba.com>, <ying.huang@intel.com>,
        <linux-damon@amazon.com>, <linux-mm@kvack.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC v5 00/11] DAMON: Support Physical Memory Address Space Monitoring
Date:   Tue, 7 Jul 2020 16:45:29 +0200
Message-ID: <20200707144540.21216-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.214]
X-ClientProxiedBy: EX13D35UWC001.ant.amazon.com (10.43.162.197) To
 EX13D31EUA004.ant.amazon.com (10.43.165.161)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

DAMON[1] programming interface users can extend DAMON for any address space by
configuring the address-space specific low level primitives with appropriate
ones including their own implementations.  However, because the implementation
for the virtual address space is only available now, the users should implement
their own for other address spaces.  Worse yet, the user space users who rely
on the debugfs interface and user space tool, cannot implement their own.

This patchset implements another reference implementation of the low level
primitives for the physical memory address space.  With this change, hence, the
kernel space users can monitor both the virtual and the physical address spaces
by simply changing the configuration in the runtime.  Further, this patchset
links the implementation to the debugfs interface and the user space tool for
the user space users.

Note that the implementation supports only the user memory, as same to the idle
page access tracking feature.

[1] https://lore.kernel.org/linux-mm/20200706115322.29598-1-sjpark@amazon.com/

Baseline and Complete Git Trees
===============================

The patches are based on the v5.7 plus DAMON v17 patchset[1] and DAMOS RFC v13
patchset[2].  You can also clone the complete git tree:

    $ git clone git://github.com/sjp38/linux -b cdamon/rfc/v5

The web is also available:
https://github.com/sjp38/linux/releases/tag/cdamon/rfc/v5

[1] https://lore.kernel.org/linux-mm/20200706115322.29598-1-sjpark@amazon.com/
[2] https://lore.kernel.org/linux-mm/20200707093805.4775-1-sjpark@amazon.com/

Sequence of Patches
===================

The sequence of patches is as follow.

The first 5 patches allow the user space users manually set the monitoring
regions.  The 1st and 2nd patches implements the features in the debugfs
interface and the user space tool .  Following two patches each implement
unittests (the 3rd patch) and selftests (the 4th patch) for the new feature.
Finally, the 5th patch documents this new feature.

Following 6 patches implement the physical memory monitoring.  The 6th patch
exports rmap essential functions to GPL modules as those will be used by the
DAMON's implementation of the low level primitives for the physical memory
address space.  The 7th patch implements the low level primitives.  The 8th and
the 9th patches links the feature to the debugfs and the user space tool,
respectively.  The 10th patch further implement a handy NUMA specific memory
monitoring feature on the user space tool.  Finally, the 11th patch documents
this new features.

Patch History
=============

Changes from RFC v4
(https://lore.kernel.org/linux-mm/20200616140813.17863-1-sjpark@amazon.com/)
 - Support NUMA specific physical memory monitoring

Changes from RFC v3
(https://lore.kernel.org/linux-mm/20200609141941.19184-1-sjpark@amazon.com/)
 - Export rmap functions
 - Reorganize for physical memory monitoring support only
 - Clean up debugfs code

Changes from RFC v2
(https://lore.kernel.org/linux-mm/20200603141135.10575-1-sjpark@amazon.com/)
 - Support the physical memory monitoring with the user space tool
 - Use 'pfn_to_online_page()' (David Hildenbrand)
 - Document more detail on random 'pfn' and its safeness (David Hildenbrand)

Changes from RFC v1
(https://lore.kernel.org/linux-mm/20200409094232.29680-1-sjpark@amazon.com/)
 - Provide the reference primitive implementations for the physical memory
 - Connect the extensions with the debugfs interface

SeongJae Park (11):
  mm/damon/debugfs: Allow users to set initial monitoring target regions
  tools/damon: Support init target regions specification
  mm/damon-test: Add more unit tests for 'init_regions'
  selftests/damon/_chk_record: Do not check number of gaps
  Docs/damon: Document 'initial_regions' feature
  mm/rmap: Export essential functions for rmap_run
  mm/damon: Implement callbacks for physical memory monitoring
  mm/damon/debugfs: Support physical memory monitoring
  tools/damon/record: Support physical memory monitoring
  tools/damon/record: Support NUMA specific recording
  Docs/damon: Document physical memory monitoring support

 Documentation/admin-guide/mm/damon/faq.rst    |   7 +-
 Documentation/admin-guide/mm/damon/index.rst  |   1 -
 .../admin-guide/mm/damon/mechanisms.rst       |  29 +-
 Documentation/admin-guide/mm/damon/plans.rst  |   7 -
 Documentation/admin-guide/mm/damon/usage.rst  |  80 +++-
 include/linux/damon.h                         |   5 +
 mm/damon-test.h                               |  53 +++
 mm/damon.c                                    | 374 +++++++++++++++++-
 mm/rmap.c                                     |   2 +
 mm/util.c                                     |   1 +
 tools/damon/_damon.py                         |  41 ++
 tools/damon/_paddr_layout.py                  | 158 ++++++++
 tools/damon/heats.py                          |   2 +-
 tools/damon/record.py                         |  60 ++-
 tools/damon/schemes.py                        |  12 +-
 tools/testing/selftests/damon/_chk_record.py  |   6 -
 16 files changed, 783 insertions(+), 55 deletions(-)
 delete mode 100644 Documentation/admin-guide/mm/damon/plans.rst
 create mode 100644 tools/damon/_paddr_layout.py

-- 
2.17.1

