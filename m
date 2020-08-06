Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0262FC49EBF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 11:05:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC21D22CAE
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 11:05:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="XJR8uEIm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728919AbgHFIcx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 04:32:53 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:40620 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728489AbgHFIcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 04:32:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1596702771; x=1628238771;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   mime-version;
  bh=1RpaG9RAAKpGNO6XXGwnZxtC9dDckxBzjSij3vpXkRQ=;
  b=XJR8uEImKlMpJ+RSLon5kXsS5rtTBWh3Tz1zfxeiDVAy2eICt6BBcMp3
   +SDalHY+U5uBWhyvexjl/M+5UOwOAxCTQL/6yeL7eqrN+zFKPtrUGrN7b
   9NUkVBWfZ+PilL0XiFYsv+MHzPNHl3Js5VQpbA8saD7ke88zaD7uoSSCl
   o=;
IronPort-SDR: vHtWfuUG4vEl+dprOaD9/qgSxVSLX1IHZn99fzlDMiWKhy2a3HBu/PPZYn9m5sSvdTB9gTO2P3
 b2dUGYeAXgWA==
X-IronPort-AV: E=Sophos;i="5.75,441,1589241600"; 
   d="scan'208";a="66001732"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1a-67b371d8.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 06 Aug 2020 08:32:38 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1a-67b371d8.us-east-1.amazon.com (Postfix) with ESMTPS id 81EBCA0601;
        Thu,  6 Aug 2020 08:32:35 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 6 Aug 2020 08:32:34 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.162.73) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 6 Aug 2020 08:32:16 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     SeongJae Park <sjpark@amazon.com>
CC:     <akpm@linux-foundation.org>, <Jonathan.Cameron@Huawei.com>,
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
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        SeongJae Park <sjpark@amazon.de>
Subject: Re: [RFC v6 00/10] DAMON: Support Physical Memory Address Space Monitoring
Date:   Thu, 6 Aug 2020 10:31:55 +0200
Message-ID: <20200806083155.31432-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200805065951.18221-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.73]
X-ClientProxiedBy: EX13D08UWC002.ant.amazon.com (10.43.162.168) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Aug 2020 08:59:41 +0200 SeongJae Park <sjpark@amazon.com> wrote:

> From: SeongJae Park <sjpark@amazon.de>
> 
> Changes from Previous Version
> =============================
> 
> - paddr: Support nested iomem sections (Du Fan)
> - Rebase on v5.8
> 
> Introduction
> ============
> 
> DAMON[1] programming interface users can extend DAMON for any address space by
> configuring the address-space specific low level primitives with appropriate
> ones including their own implementations.  However, because the implementation
> for the virtual address space is only available now, the users should implement
> their own for other address spaces.  Worse yet, the user space users who rely
> on the debugfs interface and user space tool, cannot implement their own.
> 
> This patchset implements another reference implementation of the low level
> primitives for the physical memory address space.  With this change, hence, the
> kernel space users can monitor both the virtual and the physical address spaces
> by simply changing the configuration in the runtime.  Further, this patchset
> links the implementation to the debugfs interface and the user space tool for
> the user space users.
> 
> Note that the implementation supports only the user memory, as same to the idle
> page access tracking feature.
> 
> [1] https://lore.kernel.org/linux-mm/20200706115322.29598-1-sjpark@amazon.com/

This patchset doesn't works for physical address monitoring because I forgot
below patch.  Sorry for missing it.  Please apply it before you test this
patchset.  Or, you can clone the patch applied complete git tree:

    $ git clone git://github.com/sjp38/linux -b cdamon/rfc/v6.1

The web is also available:
https://github.com/sjp38/linux/releases/tag/cdamon/rfc/v6.1

The patch will be split and squashed in appropriate patch in the next spin.

=============================== >8 ===========================================
From edf6b586f4ac3f8f4d61ebde56d644422bd93bee Mon Sep 17 00:00:00 2001
From: SeongJae Park <sjpark@amazon.de>
Date: Thu, 6 Aug 2020 08:18:49 +0000
Subject: [PATCH] mm/damon: Fix paddr target id problem

The target id for 'paddr' is meaningless, but we set it as '-1' for fun
and smooth interaction with the user space interfaces.  However, the
target ids are 'unsigned long' and thus using '-1' makes no sense.  This
commit changes the fake number to another funny but unsigned number,
'42'.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 Documentation/admin-guide/mm/damon/usage.rst | 4 ++--
 mm/damon.c                                   | 2 +-
 tools/damon/_damon.py                        | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index 88b8e9254a7e..3e2f1519c96a 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -334,12 +334,12 @@ check it again::
 Users can also monitor the physical memory address space of the system by
 writing a special keyword, "``paddr\n``" to the file.  Because physical address
 space monitoring doesn't support multiple targets, reading the file will show a
-fake value, ``-1``, as below::
+fake value, ``42``, as below::

     # cd <debugfs>/damon
     # echo paddr > target_ids
     # cat target_ids
-    -1
+    42

 Note that setting the target ids doesn't start the monitoring.

diff --git a/mm/damon.c b/mm/damon.c
index a9757a0e5cf7..66268cb45b51 100644
--- a/mm/damon.c
+++ b/mm/damon.c
@@ -2047,7 +2047,7 @@ static ssize_t debugfs_target_ids_write(struct file *file,
                ctx->target_valid = NULL;

                /* target id is meaningless here, but we set it just for fun */
-               snprintf(kbuf, count, "-1    ");
+               snprintf(kbuf, count, "42    ");
        } else {
                /* Configure the context for virtual memory monitoring */
                ctx->init_target_regions = kdamond_init_vm_regions;
diff --git a/tools/damon/_damon.py b/tools/damon/_damon.py
index cf14a0d59b94..6ff278117e84 100644
--- a/tools/damon/_damon.py
+++ b/tools/damon/_damon.py
@@ -28,7 +28,7 @@ def set_target(tid, init_regions=[]):
         return 0

     if tid == 'paddr':
-        tid = -1
+        tid = 42
     string = ' '.join(['%s %d %d' % (tid, r[0], r[1]) for r in init_regions])
     return subprocess.call('echo "%s" > %s' % (string, debugfs_init_regions),
             shell=True, executable='/bin/bash')
--
2.17.1

