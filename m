Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D6EFC3F68F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 15:09:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 576872082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 15:09:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="eE8BM2rR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729150AbgBJPJv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 10:09:51 -0500
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:36633 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726809AbgBJPJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 10:09:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1581347390; x=1612883390;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=uz0PHbq7DEH/IUYLy7pPIh1qWdKpTQgKqzSb5AWn9T4=;
  b=eE8BM2rRkLdGU9DJMdu8QNzol1xpnnPmdTVDj8EQMnVXyQPd6aE6d4Ip
   OEgsp77cKZi9K9wa6eE/P/jxyu1QksMyYa2mzLZXdOTs0NJq9UK3oM0X/
   tZYDrHy8w0mBDus5jyy39oBxXh0ygGB73uts774lgYOWO6WziGu2KWlw5
   E=;
IronPort-SDR: sYvFWt3nq/N78/TWw0gmxAOkYtOGYnBHPYUgkIX1oLLq7I06B3AcWIEglic2qvGn60KQnMa2lj
 ypcYVEqOVxqQ==
X-IronPort-AV: E=Sophos;i="5.70,425,1574121600"; 
   d="scan'208";a="24101569"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2a-119b4f96.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 10 Feb 2020 15:09:49 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-119b4f96.us-west-2.amazon.com (Postfix) with ESMTPS id 981821A0B10;
        Mon, 10 Feb 2020 15:09:47 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Mon, 10 Feb 2020 15:09:47 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.162.69) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 10 Feb 2020 15:09:35 +0000
From:   <sjpark@amazon.com>
To:     <akpm@linux-foundation.org>
CC:     SeongJae Park <sjpark@amazon.de>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <amit@kernel.org>,
        <brendan.d.gregg@gmail.com>, <brendanhiggins@google.com>,
        <cai@lca.pw>, <colin.king@canonical.com>, <corbet@lwn.net>,
        <dwmw@amazon.com>, <jolsa@redhat.com>, <kirill@shutemov.name>,
        <mark.rutland@arm.com>, <mgorman@suse.de>, <minchan@kernel.org>,
        <mingo@redhat.com>, <namhyung@kernel.org>, <peterz@infradead.org>,
        <rdunlap@infradead.org>, <rostedt@goodmis.org>,
        <sj38.park@gmail.com>, <vdavydov.dev@gmail.com>,
        <linux-mm@kvack.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 0/3] DAMON: Implement The Data Access Pattern Awared Memory Management Rules
Date:   Mon, 10 Feb 2020 16:09:18 +0100
Message-ID: <20200210150921.32482-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.69]
X-ClientProxiedBy: EX13D17UWB002.ant.amazon.com (10.43.161.141) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

DAMON can make data access pattern awared memory management optimizations much
easier.  That said, users who want such optimizations should run DAMON, read
the monitoring results, analyze it, plan a new memory management scheme, and
apply the new scheme by themselves.  It would not be too hard, but still
require some level of efforts.  Such efforts will be really necessary in some
complicated cases.

However, in many other cases, the optimizations would have a simple and common
pattern.  For example, the users would just want the system to apply an actions
to a memory region of a specific size having a specific access frequency for a
specific time.  For example, "page out a memory region larger than 100 MiB but
having a low access frequency more than 10 minutes", or "Use THP for a memory
region larger than 2 MiB having a high access frequency for more than 2
seconds".

This RFC patchset makes DAMON to receive and do such simple optimizations.  All
the things users need to do for such simple cases is only to specify their
requests to DAMON in a form of rules.

For the actions, current implementation supports only a few of ``madvise()``
hints, ``MADV_WILLNEED``, ``MADV_COLD``, ``MADV_PAGEOUT``, ``MADV_HUGEPAGE``,
and ``MADV_NOHUGEPAGE``.


Sequence Of Patches
===================

The first patch allows DAMON to reuse ``madvise()`` code.  The second patch
implements the data access pattern awared memory management rules and its
kernel space programming interface.  Finally, the third patch implements a
debugfs interface for privileged user space people and programs.

The patches are based on the v5.5 plus v4 DAMON patchset[1] and Minchan's
``madvise()`` factoring out patch[2].  Minchan's patch was necessary for reuse
of ``madvise()`` code.  You can also clone the complete git tree:

    $ git clone git://github.com/sjp38/linux -b damon/rules/rfc/v1

The web is also available:
https://github.com/sjp38/linux/releases/tag/damon/rules/rfc/v1

[1] https://lore.kernel.org/linux-mm/20200210144812.26845-1-sjpark@amazon.com/
[2] https://lore.kernel.org/linux-mm/20200128001641.5086-2-minchan@kernel.org/
SeongJae Park (3):
  mm/madvise: Export madvise_common() to mm internal code
  mm/damon/rules: Implement access pattern based management rules
  mm/damon/rules: Implement a debugfs interface

 include/linux/damon.h |  28 ++++
 mm/damon.c            | 317 +++++++++++++++++++++++++++++++++++++++++-
 mm/internal.h         |   4 +
 mm/madvise.c          |   2 +-
 4 files changed, 346 insertions(+), 5 deletions(-)

-- 
2.17.1

