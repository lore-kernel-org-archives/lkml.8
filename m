Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6D51C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 14:35:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C426120776
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 14:35:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="You0RIaN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729097AbgFPOfe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 10:35:34 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:48125 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbgFPOfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 10:35:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1592318132; x=1623854132;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   mime-version;
  bh=JV50NVYH5FbnZDCF9Zoi0wtcAclFJx4TR+EWbcvdH2Q=;
  b=You0RIaNETfzOKDmyzm/FtcSEydQyPnDZDlGrLz80+mpDAntAk6U2iIi
   rIlxfCjWfvKRKrlZMXEXroaZZBym6lRQsB1XAq/thkeDtMcPdlA+nBztM
   v/wrXcS66K9uh+3zaFsdDtIqsyOXc7rLqsMcmbli3F2y+OBA7tOC55rfk
   c=;
IronPort-SDR: E4Y7r2fdDYJImPmPCELVSBrxf0obd1bVa+6oBUiArmaqkAqcaY1oNTC6xLDuSwV3WgN1PtaULY
 ASVY9CbqR/jg==
X-IronPort-AV: E=Sophos;i="5.73,518,1583193600"; 
   d="scan'208";a="37930998"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2a-1c1b5cdd.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 16 Jun 2020 14:35:28 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-1c1b5cdd.us-west-2.amazon.com (Postfix) with ESMTPS id 5B533A1B94;
        Tue, 16 Jun 2020 14:35:24 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 16 Jun 2020 14:35:23 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.161.34) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 16 Jun 2020 14:34:54 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     SeongJae Park <sjpark@amazon.com>
CC:     <akpm@linux-foundation.org>, SeongJae Park <sjpark@amazon.de>,
        <Jonathan.Cameron@Huawei.com>, <aarcange@redhat.com>,
        <acme@kernel.org>, <alexander.shishkin@linux.intel.com>,
        <amit@kernel.org>, <benh@kernel.crashing.org>,
        <brendan.d.gregg@gmail.com>, <brendanhiggins@google.com>,
        <cai@lca.pw>, <colin.king@canonical.com>, <corbet@lwn.net>,
        <dwmw@amazon.com>, <foersleo@amazon.de>, <irogers@google.com>,
        <jolsa@redhat.com>, <kirill@shutemov.name>, <mark.rutland@arm.com>,
        <mgorman@suse.de>, <minchan@kernel.org>, <mingo@redhat.com>,
        <namhyung@kernel.org>, <peterz@infradead.org>,
        <rdunlap@infradead.org>, <riel@surriel.com>, <rientjes@google.com>,
        <rostedt@goodmis.org>, <sblbir@amazon.com>, <shakeelb@google.com>,
        <shuah@kernel.org>, <sj38.park@gmail.com>, <snu@amazon.de>,
        <vbabka@suse.cz>, <vdavydov.dev@gmail.com>,
        <yang.shi@linux.alibaba.com>, <ying.huang@intel.com>,
        <david@redhat.com>, <linux-damon@amazon.com>, <linux-mm@kvack.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC v4 0/8] DAMON: Support Access Monitoring of Any Address Space Including Physical Memory
Date:   Tue, 16 Jun 2020 16:34:33 +0200
Message-ID: <20200616143433.23710-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200616140813.17863-1-sjpark@amazon.com> (raw)
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.34]
X-ClientProxiedBy: EX13D20UWC003.ant.amazon.com (10.43.162.18) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, the cover letter for previous version of the patchset was mistakenly
sent.  Below is the proper coverletter for this version.

================================ >8 ===========================================
Subject: [RFC v4 0/8] DAMON: Support Physical Memory Address Space Monitoring

DAMON[1] programming interface users can extend DAMON for any address space by
implementing and using their own address-space specific low level primitives.
However, the user space users who rely on the debugfs interface and user space
tool, can monitor the virtual address space only.  This is mainly due to DAMON
is providing the reference implementation of the low level primitives for the
virtual address space only.

This patchset implements another reference implementation of the low level
primitives for the physical memory address space.  Therefore, users can monitor
both of the virtual and the physical address spaces by simply configuring the
provided low level primitives.   Further, this patchset links the
implementation to the debugfs interface and the user space tool, so that user
space users can also use the features.

Note that the implementation supports only the user memory, as same to the idle
page access tracking feature.

[1] https://lore.kernel.org/linux-mm/20200615161927.12637-1-sjpark@amazon.com/


Baseline and Complete Git Trees
===============================

The patches are based on the v5.7 plus DAMON v16 patchset[1] and DAMOS RFC v12
patchset[2].  You can also clone the complete git tree:

    $ git clone git://github.com/sjp38/linux -b cdamon/rfc/v4

The web is also available:
https://github.com/sjp38/linux/releases/tag/cdamon/rfc/v4

[1] https://lore.kernel.org/linux-mm/20200615161927.12637-1-sjpark@amazon.com/
[2] https://lore.kernel.org/linux-mm/20200616073828.16509-1-sjpark@amazon.com/


Sequence of Patches
===================

The sequence of patches is as follow.

The 1st and 2nd patches allow the debugfs interface and the user space tool to
be able to set the monitoring target regions as they want, respectively.  The
3rd patch documents the feature.

The 4th patch exports rmap essential functions to GPL modules as those are
required from the DAMON's reference implementation of the low level primitives
for the physical memory address space.  The 5th patch provides the reference
implementations of the configurable primitives for the physical memory
monitoring.  The 6th and 7th patches make the user space to be able to use the
physical memory monitoring via debugfs and the user space tool, respectively.
Finally, the 8th patch documents the physical memory monitoring support.


Patch History
=============

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

