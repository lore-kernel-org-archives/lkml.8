Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47D13C433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 14:12:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22BF320738
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 14:12:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="aNasTH6H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726103AbgFCOMb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 10:12:31 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:36119 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbgFCOMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 10:12:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1591193549; x=1622729549;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=VSSWvrN/6ooCF8jN2b2oKAZsBnPFQ1RB7gDwHK0r5D4=;
  b=aNasTH6HaEjK8tTVsGuQvODTnVcuBQe0IENjrHWtqp2CWi9eD265D7cF
   Na5seeJB0guAHBqU6dSgW2Uos9wzU/9q2Knu42B20zvul+uftQvq9sjqy
   5ZawGcgxfB0CvoYq1PwqmId3mjIuaGW2T6FfS7/khclk5G7Mj8y5nE5H8
   E=;
IronPort-SDR: yCKBXwgrtQgb/fi7ejpvwX8zGmhPIgPob1X0YePWNE2rKJke1i0rPsb1y5UjPcmOq9TMn+Nxdz
 Vsg8FwzHCUzQ==
X-IronPort-AV: E=Sophos;i="5.73,467,1583193600"; 
   d="scan'208";a="35572869"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2a-1c1b5cdd.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 03 Jun 2020 14:12:13 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-1c1b5cdd.us-west-2.amazon.com (Postfix) with ESMTPS id 47D09A22AA;
        Wed,  3 Jun 2020 14:12:10 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 3 Jun 2020 14:12:09 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.160.90) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 3 Jun 2020 14:11:52 +0000
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
        <ying.huang@intel.com>, <linux-damon@amazon.com>,
        <linux-mm@kvack.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [RFC v2 0/9] DAMON: Support Access Monitoring of Any Address Space Including Physical Memory
Date:   Wed, 3 Jun 2020 16:11:26 +0200
Message-ID: <20200603141135.10575-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.90]
X-ClientProxiedBy: EX13D45UWB002.ant.amazon.com (10.43.161.78) To
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
primitives.

Kernel space users can also implement the primitives by themselves for their
special use cases.  Clean/dirty/entire page cache, NUMA nodes, specific files,
or block devices would be examples of such special use cases.

[1] https://lore.kernel.org/linux-mm/20200602130125.20467-1-sjpark@amazon.com/


Baseline and Complete Git Trees
===============================

The patches are based on the v5.7 plus DAMON v14 patchset and DAMOS RFC v10
patchset.  You can also clone the complete git tree:

    $ git clone git://github.com/sjp38/linux -b cdamon/rfc/v2

The web is also available:
https://github.com/sjp38/linux/releases/tag/cdamon/rfc/v2

[1] https://lore.kernel.org/linux-mm/20200602130125.20467-1-sjpark@amazon.com/
[2] https://lore.kernel.org/linux-mm/20200603071138.8152-1-sjpark@amazon.com/


Sequence of Patches
===================

The sequence of patches is as follow.  The 1st patch defines the monitoring
region again based on pure address range abstraction so that no assumption of
virtual memory is in there.  The following 2nd patch cleans up code using the
new abstraction.

The 3rd patch allows users to configure the low level pritimives for
initialization and dynamic update of the target address regions, which were
previously coupled with virtual memory area.  Then, the 4th patch allow user
space to also be able to set the monitoring target regions and document it in
the 5th patch.

The 6th patch further makes the access check primitives, which were based on
PTE Accessed bit, configurable.  Now any address space can be supported.  The
7th patch provides the reference implementations of the configurable primitives
for physical memory monitoring.  The 8th patch makes the debugfs interface to
be able to use the physical memory monitoring, and finally the 9th patch
documents this.


Patch History
=============

Changes from RFC v1
(https://lore.kernel.org/linux-mm/20200409094232.29680-1-sjpark@amazon.com/)
 - Provide the reference primitive implementations for the physical memory
 - Connect the extensions with the debugfs interface

SeongJae Park (9):
  mm/damon: Use vm-independent address range concept
  mm/damon: Clean up code using 'struct damon_addr_range'
  mm/damon: Make monitoring target regions init/update configurable
  mm/damon/debugfs: Allow users to set initial monitoring target regions
  Docs/damon: Document 'initial_regions' feature
  mm/damon: Make access check primitive configurable
  mm/damon: Implement callbacks for physical memory monitoring
  mm/damon/debugfs: Support physical memory monitoring
  Docs/damon: Document physical memory monitoring support

 Documentation/admin-guide/mm/damon/usage.rst |  56 ++-
 include/linux/damon.h                        |  47 +-
 mm/damon-test.h                              |  78 +--
 mm/damon.c                                   | 504 ++++++++++++++++---
 4 files changed, 564 insertions(+), 121 deletions(-)

-- 
2.17.1

