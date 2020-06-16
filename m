Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9D22C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 14:09:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E9ED207E8
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 14:09:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="bo0gASOR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729381AbgFPOJF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 10:09:05 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:13177 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729018AbgFPOJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 10:09:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1592316540; x=1623852540;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=MmuZFPwPBDLhaP7FwfNffInG2RSQpYtwzmEjE5uPFU0=;
  b=bo0gASORRW284ZBr08cKffb9ElPy+dekWfK3VOxe7/rWeezOqZr7zAIW
   d7ANIvl1f1G+fXS91D6NKKDiDupHALHy3fWNqj94ggtRqFHZcmU+Qfrt6
   HAPx/lsV2YyHAmzbEYys+5uPj8BxrGN8Wb+fF9AMJsVZXKOGbh02ikgKj
   4=;
IronPort-SDR: N5wWK5h0RIZuayvMC3cb3HPjTqvl/HewIssTyVO/yfpF9QJQd8wNrWAcazRVRujk6TFViNRWid
 30JoxKocTZgQ==
X-IronPort-AV: E=Sophos;i="5.73,518,1583193600"; 
   d="scan'208";a="36584260"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2c-cc689b93.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 16 Jun 2020 14:08:56 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2c-cc689b93.us-west-2.amazon.com (Postfix) with ESMTPS id 683A3120E02;
        Tue, 16 Jun 2020 14:08:53 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 16 Jun 2020 14:08:52 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.162.109) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 16 Jun 2020 14:08:28 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     <akpm@linux-foundation.org>
CC:     SeongJae Park <sjpark@amazon.de>, <Jonathan.Cameron@Huawei.com>,
        <aarcange@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <amit@kernel.org>,
        <benh@kernel.crashing.org>, <brendan.d.gregg@gmail.com>,
        <brendanhiggins@google.com>, <cai@lca.pw>,
        <colin.king@canonical.com>, <corbet@lwn.net>, <dwmw@amazon.com>,
        <foersleo@amazon.de>, <irogers@google.com>, <jolsa@redhat.com>,
        <kirill@shutemov.name>, <mark.rutland@arm.com>, <mgorman@suse.de>,
        <minchan@kernel.org>, <mingo@redhat.com>, <namhyung@kernel.org>,
        <peterz@infradead.org>, <rdunlap@infradead.org>,
        <riel@surriel.com>, <rientjes@google.com>, <rostedt@goodmis.org>,
        <sblbir@amazon.com>, <shakeelb@google.com>, <shuah@kernel.org>,
        <sj38.park@gmail.com>, <snu@amazon.de>, <vbabka@suse.cz>,
        <vdavydov.dev@gmail.com>, <yang.shi@linux.alibaba.com>,
        <ying.huang@intel.com>, <david@redhat.com>,
        <linux-damon@amazon.com>, <linux-mm@kvack.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC v4 0/8] DAMON: Support Access Monitoring of Any Address Space Including Physical Memory
Date:   Tue, 16 Jun 2020 16:08:05 +0200
Message-ID: <20200616140813.17863-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.109]
X-ClientProxiedBy: EX13D01UWB004.ant.amazon.com (10.43.161.157) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

Currently, DAMON[1] supports only virtual memory address spaces because it
utilizes PTE Accessed bits as its low-level access check primitive and ``struct
vma`` as a way to address the monitoring target regions.  However, the core
idea of DAMON, which makes it able to provide the accurate, efficient, and
scalable monitoring, is in a separate higher layer.  Therefore, DAMON can be
extended for other various address spaces by changing the two low primitives to
others for the address spaces.

This patchset makes the DAMON's low level primitives configurable and provide
reference implementation of the primitives for the virtual memory address
spaces and the physical memory address space.  Therefore, users can monitor
both of the two address spaces by simply configuring the provided low level
primitives.  Note that only the user memory is supported, as same to the idle
page access tracking feature.

After this patchset, the programming interface users can implement the
primitives by themselves for their special use cases.  Clean/dirty/entire page
cache, NUMA nodes, specific files, or block devices would be examples of such
special use cases.

[1] https://lore.kernel.org/linux-mm/20200608114047.26589-1-sjpark@amazon.com/


Baseline and Complete Git Trees
===============================

The patches are based on the v5.7 plus DAMON v15 patchset[1] and DAMOS RFC v11
patchset[2].  You can also clone the complete git tree:

    $ git clone git://github.com/sjp38/linux -b cdamon/rfc/v3

The web is also available:
https://github.com/sjp38/linux/releases/tag/cdamon/rfc/v3

[1] https://lore.kernel.org/linux-mm/20200608114047.26589-1-sjpark@amazon.com/
[2] https://lore.kernel.org/linux-mm/20200609065320.12941-1-sjpark@amazon.com/


Sequence of Patches
===================

The sequence of patches is as follow.  The 1st patch defines the monitoring
region again based on pure address range abstraction so that no assumption of
virtual memory is in there.

The 2nd patch allows users to configure the low level pritimives for
initialization and dynamic update of the target address regions, which were
previously coupled with the virtual memory.  Then, the 3rd and 4th patches
allow user space to also be able to set the monitoring target regions via the
debugfs and the user space tool.  The 5th patch documents this feature.

The 6th patch makes the access check primitives, which were coupled with the
virtual memory address, freely configurable.  Now any address space can be
supported.  The 7th patch provides the reference implementations of the
configurable primitives for the physical memory monitoring.  The 8th and 9th
patch makes the user space to be able to use the physical memory monitoring via
debugfs and the user space tool, respectively.  Finally, the 10th patch
documents the physical memory monitoring support.


Patch History
=============

Changes from RFC v2
(https://lore.kernel.org/linux-mm/20200603141135.10575-1-sjpark@amazon.com/)
 - Support the physical memory monitoring with the user space tool
 - Use 'pfn_to_online_page()' (David Hildenbrand)
 - Document more detail on random 'pfn' and its safeness (David Hildenbrand)

Changes from RFC v1
(https://lore.kernel.org/linux-mm/20200409094232.29680-1-sjpark@amazon.com/)
 - Provide the reference primitive implementations for the physical memory
 - Connect the extensions with the debugfs interface

SeongJae Park (8):
  mm/damon/debugfs: Allow users to set initial monitoring target regions
  tools/damon: Implement init target regions feature
  Docs/damon: Document 'initial_regions' feature
  mm/rmap: Export essential functions for rmap_run
  mm/damon: Implement callbacks for physical memory monitoring
  mm/damon/debugfs: Support physical memory monitoring
  tools/damon/record: Support physical memory address spce
  Docs/damon: Document physical memory monitoring support

 Documentation/admin-guide/mm/damon/faq.rst   |   7 +-
 Documentation/admin-guide/mm/damon/index.rst |   1 -
 Documentation/admin-guide/mm/damon/plans.rst |   7 -
 Documentation/admin-guide/mm/damon/usage.rst |  73 +++-
 include/linux/damon.h                        |   5 +
 mm/damon.c                                   | 374 ++++++++++++++++++-
 mm/rmap.c                                    |   2 +
 mm/util.c                                    |   1 +
 tools/damon/_damon.py                        |  41 ++
 tools/damon/heats.py                         |   2 +-
 tools/damon/record.py                        |  41 +-
 tools/damon/schemes.py                       |  12 +-
 12 files changed, 532 insertions(+), 34 deletions(-)
 delete mode 100644 Documentation/admin-guide/mm/damon/plans.rst

-- 
2.17.1

