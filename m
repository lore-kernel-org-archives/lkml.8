Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC55CC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 14:20:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97DB3206D5
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 14:20:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="gfzRCHQI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730428AbgFIOUg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 10:20:36 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:55751 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726967AbgFIOUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 10:20:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1591712433; x=1623248433;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=zamFGhILMXXgTSQng1759ZxsRtt1vLQ8ujhImLih0+4=;
  b=gfzRCHQIiS5P0oxzRDkNVBhKeMXcLQFzCtfdQNtsxrE09gGPPVrn9Ga+
   KCVw2/j9HIiPEo6aq29eoATwcEFB+RgaDAVGe22Tmhei3f+CAXvc/EpqY
   ldeHuYP7tSxg8rIKZGxHDn+KaTnjQ/fLMCaDd3R8nfMTLasJVsIs2iS5h
   g=;
IronPort-SDR: 6YBcpF3s/Glx9uj5aQV4vEWC/puqikLHM1Z2XSU57pA6uYkTzBc3GlGZIfuARpAULM/ViXnljh
 K4wYTtPlvU4Q==
X-IronPort-AV: E=Sophos;i="5.73,492,1583193600"; 
   d="scan'208";a="42677583"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1e-a70de69e.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 09 Jun 2020 14:20:28 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1e-a70de69e.us-east-1.amazon.com (Postfix) with ESMTPS id 1AEB2A2091;
        Tue,  9 Jun 2020 14:20:16 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 9 Jun 2020 14:20:16 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.162.109) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 9 Jun 2020 14:19:59 +0000
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
Subject: [RFC v3 00/10] DAMON: Support Access Monitoring of Any Address Space Including Physical Memory
Date:   Tue, 9 Jun 2020 16:19:31 +0200
Message-ID: <20200609141941.19184-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.109]
X-ClientProxiedBy: EX13D30UWC004.ant.amazon.com (10.43.162.4) To
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

SeongJae Park (10):
  mm/damon: Use vm-independent address range concept
  mm/damon: Make monitoring target regions init/update configurable
  mm/damon/debugfs: Allow users to set initial monitoring target regions
  tools/damon: Implement init target regions feature
  Docs/damon: Document 'initial_regions' feature
  mm/damon: Make access check primitive configurable
  mm/damon: Implement callbacks for physical memory monitoring
  mm/damon/debugfs: Support physical memory monitoring
  tools/damon/record: Support physical memory address spce
  Docs/damon: Document physical memory monitoring support

 Documentation/admin-guide/mm/damon/faq.rst    |  16 +-
 Documentation/admin-guide/mm/damon/index.rst  |   1 -
 .../admin-guide/mm/damon/mechanisms.rst       |   4 +-
 Documentation/admin-guide/mm/damon/plans.rst  |  29 -
 Documentation/admin-guide/mm/damon/usage.rst  |  73 ++-
 include/linux/damon.h                         |  47 +-
 include/trace/events/damon.h                  |   4 +-
 mm/damon-test.h                               |  78 +--
 mm/damon.c                                    | 518 +++++++++++++++---
 tools/damon/_damon.py                         |  41 ++
 tools/damon/heats.py                          |   2 +-
 tools/damon/record.py                         |  41 +-
 tools/damon/schemes.py                        |  12 +-
 13 files changed, 690 insertions(+), 176 deletions(-)
 delete mode 100644 Documentation/admin-guide/mm/damon/plans.rst

-- 
2.17.1

