Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 336B2C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 10:48:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09F6B20936
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 10:48:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="F7sIKPJv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbgHaKsf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 06:48:35 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:40890 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725964AbgHaKs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 06:48:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1598870905; x=1630406905;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=Ek0EqDHH/iy5xCbjNpXp7HgyUsuNW6mKFdLMssZj/2o=;
  b=F7sIKPJvUnpwmG5arMxgpyy3y50lZ2QNWYFag3/xiamoNMiCvW701/c6
   CKUgrF55fi4678S1MPG7V1WtLhQsBYsOuW4WWVVgG7mSnesFU9Alg2QIw
   EBUZaNRWNdpUULBsKGKui2DVuNaAe2vyQn2HOtEvT+TGXvgo8DF4sIrWk
   Y=;
X-IronPort-AV: E=Sophos;i="5.76,375,1592870400"; 
   d="scan'208";a="50991266"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2a-69849ee2.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 31 Aug 2020 10:48:05 +0000
Received: from EX13D31EUB001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-69849ee2.us-west-2.amazon.com (Postfix) with ESMTPS id 0DE74A1DF2;
        Mon, 31 Aug 2020 10:48:02 +0000 (UTC)
Received: from u3f2cd687b01c55.ant.amazon.com (10.43.160.100) by
 EX13D31EUB001.ant.amazon.com (10.43.166.210) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 31 Aug 2020 10:47:45 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     <akpm@linux-foundation.org>
CC:     SeongJae Park <sjpark@amazon.de>, <Jonathan.Cameron@Huawei.com>,
        <aarcange@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <amit@kernel.org>,
        <benh@kernel.crashing.org>, <brendan.d.gregg@gmail.com>,
        <brendanhiggins@google.com>, <cai@lca.pw>,
        <colin.king@canonical.com>, <corbet@lwn.net>, <david@redhat.com>,
        <dwmw@amazon.com>, <fan.du@intel.com>, <foersleo@amazon.de>,
        <gthelen@google.com>, <irogers@google.com>, <jolsa@redhat.com>,
        <kirill@shutemov.name>, <mark.rutland@arm.com>, <mgorman@suse.de>,
        <minchan@kernel.org>, <mingo@redhat.com>, <namhyung@kernel.org>,
        <peterz@infradead.org>, <rdunlap@infradead.org>,
        <riel@surriel.com>, <rientjes@google.com>, <rostedt@goodmis.org>,
        <rppt@kernel.org>, <sblbir@amazon.com>, <shakeelb@google.com>,
        <shuah@kernel.org>, <sj38.park@gmail.com>, <snu@amazon.de>,
        <vbabka@suse.cz>, <vdavydov.dev@gmail.com>,
        <yang.shi@linux.alibaba.com>, <ying.huang@intel.com>,
        <zgf574564920@gmail.com>, <linux-damon@amazon.com>,
        <linux-mm@kvack.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [RFC v8 00/10] DAMON: Support Physical Memory Address Space Monitoring
Date:   Mon, 31 Aug 2020 12:47:20 +0200
Message-ID: <20200831104730.28970-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.100]
X-ClientProxiedBy: EX13D49UWB002.ant.amazon.com (10.43.163.68) To
 EX13D31EUB001.ant.amazon.com (10.43.166.210)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

Changes from Previous Version
=============================

- Add missed 'put_page()' calls
- Support unmapped LRU pages

Introduction
============

NOTE: This is only an RFC for future features of DAMON patchset[1], which is
not merged in the mainline yet.  The aim of this RFC is to show how DAMON would
be expanded once it is merged in.  So, if you have some interest in this RFC,
please consider reviewing DAMON, either.

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
page tracking feature.

[1] https://lore.kernel.org/linux-mm/20200817105137.19296-1-sjpark@amazon.com/

Baseline and Complete Git Trees
===============================

The patches are based on the v5.8 plus DAMON v20 patchset[1] and DAMOS RFC v14
patchset[2].  You can also clone the complete git tree:

    $ git clone git://github.com/sjp38/linux -b cdamon/rfc/v8

The web is also available:
https://github.com/sjp38/linux/releases/tag/cdamon/rfc/v8

[1] https://lore.kernel.org/linux-mm/20200817105137.19296-1-sjpark@amazon.com/
[2] https://lore.kernel.org/linux-mm/20200804142430.15384-1-sjpark@amazon.com/

Sequence of Patches
===================

The sequence of patches is as follow.

The first 5 patches allow the user space users manually set the monitoring
regions.  The 1st and 2nd patches implements the features in the debugfs
interface and the user space tool, respectively.  Following two patches update
unittests (the 3rd patch) and selftests (the 4th patch) for the new feature.
Finally, the 5th patch documents this new feature.

Following 5 patches implement the physical memory monitoring.  The 6th patch
implements the low level primitives.  The 7th and the 8th patches links the
primitives to the debugfs and the user space tool, respectively.  The 9th patch
further implement a handy NUMA specific memory monitoring feature on the user
space tool.  Finally, the 10th patch documents this new features.

Patch History
=============

Changes from RFC v7
(https://lore.kernel.org/linux-mm/20200818072501.30396-1-sjpark@amazon.com/)
- Add missed 'put_page()' calls
- Support unmapped LRU pages

Changes from RFC v6
(https://lore.kernel.org/linux-mm/20200805065951.18221-1-sjpark@amazon.com/)
- Use 42 as the fake target id for paddr instead of -1
- Fix typo

Changes from RFC v5
(https://lore.kernel.org/linux-mm/20200707144540.21216-1-sjpark@amazon.com/)
- Support nested iomem sections (Du Fan)
- Rebase on v5.8

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

SeongJae Park (10):
  mm/damon/debugfs: Allow users to set initial monitoring target regions
  tools/damon: Support init target regions specification
  mm/damon-test: Add more unit tests for 'init_regions'
  selftests/damon/_chk_record: Do not check number of gaps
  Docs/admin-guide/mm/damon: Document 'init_regions' feature
  mm/damon: Implement callbacks for physical memory monitoring
  mm/damon/debugfs: Support physical memory monitoring
  tools/damon/record: Support physical memory monitoring
  tools/damon/record: Support NUMA specific recording
  Docs/DAMON: Document physical memory monitoring support

 Documentation/admin-guide/mm/damon/usage.rst |  77 +++-
 Documentation/vm/damon/design.rst            |  29 +-
 Documentation/vm/damon/faq.rst               |   5 +-
 include/linux/damon.h                        |   6 +
 mm/damon-test.h                              |  53 +++
 mm/damon.c                                   | 396 ++++++++++++++++++-
 tools/damon/_damon.py                        |  41 ++
 tools/damon/_paddr_layout.py                 | 147 +++++++
 tools/damon/record.py                        |  57 ++-
 tools/damon/schemes.py                       |  12 +-
 tools/testing/selftests/damon/_chk_record.py |   6 -
 11 files changed, 784 insertions(+), 45 deletions(-)
 create mode 100644 tools/damon/_paddr_layout.py

-- 
2.17.1

