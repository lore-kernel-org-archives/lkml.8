Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D9D8C2BB85
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 09:43:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6B45221EB
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 09:43:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="IxjUOPF2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbgDIJnK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 05:43:10 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:34683 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbgDIJnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 05:43:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1586425390; x=1617961390;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=A3o7iwNYKZ7O2kghXsLkm2MqLsk9mCv8wiHQj4pLUK8=;
  b=IxjUOPF2lOfppCOPNOeYcy83ZKs65nW/7eJ7JckTdikwYBzlHTd3lbtq
   e0liv2uPaVFN8xT7CzNuwYDBifunJJQRvENVYdQdOpyDq0YJ8WmogQkwM
   6q+YB69jyUcmmDDFUNUBegbumkF+XofIzHPBxu2SqCgn2EbjLORBVEhDO
   o=;
IronPort-SDR: v3D4vMoCWVdOhLTBHJE/sCYO8YnRcak74zexDsowtMi2dnxT5bknVRPyMtc2mZRRyW0dvlPHs7
 /G4kT01Gsc8Q==
X-IronPort-AV: E=Sophos;i="5.72,362,1580774400"; 
   d="scan'208";a="27833870"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2c-2225282c.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 09 Apr 2020 09:43:07 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2c-2225282c.us-west-2.amazon.com (Postfix) with ESMTPS id 244A8A2426;
        Thu,  9 Apr 2020 09:43:05 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 9 Apr 2020 09:43:04 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.161.115) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 9 Apr 2020 09:42:50 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     <akpm@linux-foundation.org>
CC:     SeongJae Park <sjpark@amazon.de>, <Jonathan.Cameron@Huawei.com>,
        <aarcange@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <amit@kernel.org>,
        <brendan.d.gregg@gmail.com>, <brendanhiggins@google.com>,
        <cai@lca.pw>, <colin.king@canonical.com>, <corbet@lwn.net>,
        <dwmw@amazon.com>, <irogers@google.com>, <jolsa@redhat.com>,
        <kirill@shutemov.name>, <mark.rutland@arm.com>, <mgorman@suse.de>,
        <minchan@kernel.org>, <mingo@redhat.com>, <namhyung@kernel.org>,
        <peterz@infradead.org>, <rdunlap@infradead.org>,
        <riel@surriel.com>, <rientjes@google.com>, <rostedt@goodmis.org>,
        <shakeelb@google.com>, <shuah@kernel.org>, <sj38.park@gmail.com>,
        <vbabka@suse.cz>, <vdavydov.dev@gmail.com>,
        <yang.shi@linux.alibaba.com>, <ying.huang@intel.com>,
        <linux-mm@kvack.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 0/4] DAMON: Make Configurable for Various Address Spaces Including Physical Memory
Date:   Thu, 9 Apr 2020 11:42:28 +0200
Message-ID: <20200409094232.29680-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.115]
X-ClientProxiedBy: EX13D15UWB003.ant.amazon.com (10.43.161.138) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

DAMON[1] is currently supporing only virtual memory address spaces of several
target processes.  Therefore, the user of DAMON should first select the target
processes.  This could be cumbersome in some cases and even makes no sense if
the user want to monitor non-virtual address spaces.  Especially, there were
many requests and questions for support of physical memory monitoring.

There were also many questions about use of different access check mechanisms
such as dedicated H/W features[2], idle page tracking, or perf-mem, instead of
the PTE Accessed bit checking, which is currently used by DAMON.  Supporting
various access check mechanisms will make DAMON to be highly tunable for
specific cases.

Fortunately, the core mechanisms of DAMON, the region-based sampling and
adaptive regions adjustment, are not coupled with the virtual memory spaces and
Accessed bit based access check.  As long as there is a way to 1) address every
region in the space and 2) check access to specific address, the core
mechanisms could be applied.  Nonetheless, current implementation of DAMON is
highly coupled with the virtual memory address spaces.

[1] https://lore.kernel.org/linux-mm/20200406130938.14066-1-sjpark@amazon.com/
[2] https://images.anandtech.com/doci/10591/HC28.AMD.Mike%20Clark.final-page-016.jpg


Baseline and Complete Git Trees
===============================

The patches are based on the v5.6 plus DAMON v8 patchset[1] and DAMOS RFC v6[2]
patchset.  You can also clone the complete git tree:

    $ git clone git://github.com/sjp38/linux -b cdamon/rfc/v1

The web is also available:
https://github.com/sjp38/linux/releases/tag/cdamon/rfc/v1

This patchset breaks the couplings and allows the target region definition and
the access check to be configurable by users so that it can support various
types of address spaces and use cases.  Based on this patchset, you can
configure DAMON to monitor physical memory or other special address spaces with
your preferred access check mechanism.

[1] https://lore.kernel.org/linux-mm/20200406130938.14066-1-sjpark@amazon.com/
[2] https://lore.kernel.org/linux-mm/20200407100007.3894-1-sjpark@amazon.com/


Sequence of Patches
===================

The sequence of patches is as follow.  The first patch defines the monitoring
region again based on pure address range abstraction so that there is no
assumption of virtual memory in there.  The following patch cleans up code
using the new abstraction.  The third patch allows users to configure the
initialization and dynamic update of the target address regions, which were
highly coupled with virtual memory area, with their own things.  Finally, the
fourth patch further make the access check mechanism, which were based on PTE
Accessed bit, configurable.

SeongJae Park (4):
  mm/damon: Use vm-independent address range concept
  mm/damon: Clean up code using 'struct damon_addr_range'
  mm/damon: Make monitoring target regions init/update configurable
  mm/damon: Make access check configurable

 include/linux/damon.h |  15 +++-
 mm/damon-test.h       |  82 ++++++++++----------
 mm/damon.c            | 174 ++++++++++++++++++++----------------------
 3 files changed, 136 insertions(+), 135 deletions(-)

-- 
2.17.1

