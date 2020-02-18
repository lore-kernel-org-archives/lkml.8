Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50F9AC34033
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 08:54:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2917924655
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 08:54:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="jbcW526j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbgBRIyI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 03:54:08 -0500
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:54565 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbgBRIyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 03:54:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1582016047; x=1613552047;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=NnW2Xr8n2sakcn0GkM6yWrfHpG7o7KnOOXlAkm455jQ=;
  b=jbcW526jyUKrYooZLiAUc5vtKdqCXacswRQNmqygXS7OU+k9djj1u0Nt
   zik1PCSIUbRnqEoDWne1vJAXS0VTvKjEQhg2w/ibkxnuGq1bi1mIfchIz
   LcRzXpqTFLUo1Rgfl3Oa8Q0OyrCiOEI87CyyABroqRhaod3MgM1/7U6Sf
   s=;
IronPort-SDR: FmDtL19JW7d/b3j2oxTQxS8bXSA147s6EJaknLC5r+QsXeNCFkOIvfTlVRqyctoKFo3Dodlsbx
 3rEYBVmnz57g==
X-IronPort-AV: E=Sophos;i="5.70,455,1574121600"; 
   d="scan'208";a="17440540"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1d-9ec21598.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 18 Feb 2020 08:53:54 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1d-9ec21598.us-east-1.amazon.com (Postfix) with ESMTPS id 0A533A2103;
        Tue, 18 Feb 2020 08:53:46 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Tue, 18 Feb 2020 08:53:46 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.160.108) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 18 Feb 2020 08:53:35 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     <akpm@linux-foundation.org>
CC:     SeongJae Park <sjpark@amazon.de>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <amit@kernel.org>,
        <brendan.d.gregg@gmail.com>, <brendanhiggins@google.com>,
        <cai@lca.pw>, <colin.king@canonical.com>, <corbet@lwn.net>,
        <dwmw@amazon.com>, <jolsa@redhat.com>, <kirill@shutemov.name>,
        <mark.rutland@arm.com>, <mgorman@suse.de>, <minchan@kernel.org>,
        <mingo@redhat.com>, <namhyung@kernel.org>, <peterz@infradead.org>,
        <rdunlap@infradead.org>, <rostedt@goodmis.org>, <shuah@kernel.org>,
        <sj38.park@gmail.com>, <vdavydov.dev@gmail.com>,
        <linux-mm@kvack.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [RFC v2 0/4] Implement Data Access Monitoring-based Memory Operation Schemes
Date:   Tue, 18 Feb 2020 09:53:05 +0100
Message-ID: <20200218085309.18346-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.108]
X-ClientProxiedBy: EX13D10UWB004.ant.amazon.com (10.43.161.121) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

DAMON[1] can be used as a primitive for data access awared memory management
optimizations.  That said, users who want such optimizations should run DAMON,
read the monitoring results, analyze it, plan a new memory management scheme,
and apply the new scheme by themselves.  Such efforts will be inevitable for
some complicated optimizations.

However, in many other cases, the users would just want the system to apply an
memory management action to a memory region of a specific size having a
specific access frequency for a specific time.  For example, "page out a memory
region larger than 100 MiB keeping only rare accesses more than 10 minutes", or
"Use THP for a memory region larger than 2 MiB maintaing frequent accesses for
more than 5 seconds".

This RFC patchset makes DAMON to handle such data access monitoring-based
operation schemes.  With this change, users can do the data access awared
optimizations by simply specifying their schemes to DAMON.


Sequence Of Patches
===================

The patches are based on the v5.5 plus v5 DAMON patchset[1] and Minchan's
``madvise()`` factor-out patch[2].  Minchan's patch was necessary for reuse of
``madvise()`` code in DAMON.  You can also clone the complete git tree:

    $ git clone git://github.com/sjp38/linux -b damos/rfc/v2

The web is also available:
https://github.com/sjp38/linux/releases/tag/damos/rfc/v2

The first patch allows DAMON to reuse ``madvise()`` code for the actions.  The
second patch accounts age of each region.  Third patch implements the handling
of the schemes in DAMON and exports a kernel space programming interface for
it.  Finally, the fourth patch implements a debugfs interface for privileged
people and programs.

[1] https://lore.kernel.org/linux-mm/20200217103110.30817-1-sjpark@amazon.com/
[2] https://lore.kernel.org/linux-mm/20200128001641.5086-2-minchan@kernel.org/


Patch History
=============

Changes from RFC v1
(https://lore.kernel.org/linux-mm/20200210150921.32482-1-sjpark@amazon.com/)
 - Properly adjust age accounting related properties after splitting, merging,
   and action applying

SeongJae Park (4):
  mm/madvise: Export madvise_common() to mm internal code
  mm/damon: Account age of target regions
  mm/damon: Implement data access monitoring-based operation schemes
  mm/damon/schemes: Implement a debugfs interface

 include/linux/damon.h |  29 ++++
 mm/damon.c            | 360 +++++++++++++++++++++++++++++++++++++++++-
 mm/internal.h         |   4 +
 mm/madvise.c          |   3 +-
 4 files changed, 388 insertions(+), 8 deletions(-)

-- 
2.17.1

