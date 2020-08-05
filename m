Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1590C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 07:00:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FE4522B40
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 07:00:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="gGrFDsur"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727019AbgHEHAx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 03:00:53 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:33427 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbgHEHAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 03:00:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1596610843; x=1628146843;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=l/nJRe7iA+akBXXgqiPg+RaCyqyoglJRj9bQdmOpTrM=;
  b=gGrFDsurOU/pZSuvlLgc2rGzQ1Hn5MWrrxUD9ZqoZBtt/Pwh2HEk3o9r
   2xBSOzVjt6d5oNlG1ANq5rEfRQLlA/L+6dfMCrXddBUL/gdZNckHO242Z
   bmEEwS1pMnLWiAUbkRl3CUVLqX+IVnmv6p7Zx4wBqpzn9cm8cKxETdzLc
   s=;
IronPort-SDR: aUpeIfVG0CpI3d68MUl7HE7i9OcMKYkcvztlbVz8w1/RjSyyAThTCQTuTWkmnmMMBADVhHs6jg
 nZjj2AUmq2zg==
X-IronPort-AV: E=Sophos;i="5.75,436,1589241600"; 
   d="scan'208";a="57505559"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1a-807d4a99.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 05 Aug 2020 07:00:37 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1a-807d4a99.us-east-1.amazon.com (Postfix) with ESMTPS id 9DA5BA251D;
        Wed,  5 Aug 2020 07:00:25 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 5 Aug 2020 07:00:24 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.160.26) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 5 Aug 2020 07:00:07 +0000
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
        <linux-damon@amazon.com>, <linux-mm@kvack.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC v6 00/10] DAMON: Support Physical Memory Address Space Monitoring
Date:   Wed, 5 Aug 2020 08:59:41 +0200
Message-ID: <20200805065951.18221-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.26]
X-ClientProxiedBy: EX13D24UWB002.ant.amazon.com (10.43.161.159) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

Changes from Previous Version
=============================

- paddr: Support nested iomem sections (Du Fan)
- Rebase on v5.8

Introduction
============

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

The patches are based on the v5.8 plus DAMON v19 patchset[1] and DAMOS RFC v14
patchset[2].  You can also clone the complete git tree:

    $ git clone git://github.com/sjp38/linux -b cdamon/rfc/v6

The web is also available:
https://github.com/sjp38/linux/releases/tag/cdamon/rfc/v6

[1] https://lore.kernel.org/linux-mm/20200804091416.31039-1-sjpark@amazon.com/
[2] https://lore.kernel.org/linux-mm/20200804142430.15384-1-sjpark@amazon.com/

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
 mm/damon.c                                   | 380 ++++++++++++++++++-
 tools/damon/_damon.py                        |  41 ++
 tools/damon/_paddr_layout.py                 | 147 +++++++
 tools/damon/record.py                        |  57 ++-
 tools/damon/schemes.py                       |  12 +-
 tools/testing/selftests/damon/_chk_record.py |   6 -
 11 files changed, 768 insertions(+), 45 deletions(-)
 create mode 100644 tools/damon/_paddr_layout.py

-- 
2.17.1

