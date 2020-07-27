Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A431FC433E5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 07:39:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B56F2072E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 07:39:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="ex/jfVq0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbgG0Hjn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 03:39:43 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:10339 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbgG0Hjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 03:39:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1595835582; x=1627371582;
  h=from:to:cc:subject:date:message-id:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=FJjAKma81/3e1UdMJPfy23qzvOyOf8SJmgiY8ZS3SwA=;
  b=ex/jfVq0nddF4SBLvR4zfmrMpPeA+YQSK6183G1WXwd1iCq4cWt3zlWA
   ka18EbWHvN7kphx3AyKrpQeL2EmUEkFBdrxzD5jdwVQn0lDbkF5mC01dL
   omxfjMa20CAwJWl9t7kC7sAfdiUDvK9ncZ5rjuhbFGWVdgfcCwG0/En4B
   4=;
IronPort-SDR: GtoPqIMqHLbnDdpFfyhmM3oVIKC3Lc1/KnaY7PBDZJxaLojcdz3M1DT24zbnD4ZVtrJfa9LKoq
 neDhI05BVRAA==
X-IronPort-AV: E=Sophos;i="5.75,401,1589241600"; 
   d="scan'208";a="54913381"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1e-27fb8269.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 27 Jul 2020 07:39:32 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1e-27fb8269.us-east-1.amazon.com (Postfix) with ESMTPS id 561E2A2A57;
        Mon, 27 Jul 2020 07:39:18 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 27 Jul 2020 07:39:17 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.161.145) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 27 Jul 2020 07:38:59 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     Greg Thelen <gthelen@google.com>
CC:     SeongJae Park <sjpark@amazon.com>, <akpm@linux-foundation.org>,
        "SeongJae Park" <sjpark@amazon.de>, <Jonathan.Cameron@Huawei.com>,
        <aarcange@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <amit@kernel.org>,
        <benh@kernel.crashing.org>, <brendan.d.gregg@gmail.com>,
        <brendanhiggins@google.com>, <cai@lca.pw>,
        <colin.king@canonical.com>, <corbet@lwn.net>, <david@redhat.com>,
        <dwmw@amazon.com>, <foersleo@amazon.de>, <irogers@google.com>,
        <jolsa@redhat.com>, <kirill@shutemov.name>, <mark.rutland@arm.com>,
        <mgorman@suse.de>, <minchan@kernel.org>, <mingo@redhat.com>,
        <namhyung@kernel.org>, <peterz@infradead.org>,
        <rdunlap@infradead.org>, <riel@surriel.com>, <rientjes@google.com>,
        <rostedt@goodmis.org>, <rppt@kernel.org>, <sblbir@amazon.com>,
        <shakeelb@google.com>, <shuah@kernel.org>, <sj38.park@gmail.com>,
        <snu@amazon.de>, <vbabka@suse.cz>, <vdavydov.dev@gmail.com>,
        <yang.shi@linux.alibaba.com>, <ying.huang@intel.com>,
        <linux-damon@amazon.com>, <linux-mm@kvack.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: Re: [PATCH v18 11/14] Documentation: Add documents for DAMON
Date:   Mon, 27 Jul 2020 09:38:42 +0200
Message-ID: <20200727073842.5328-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
In-Reply-To: <xr938sf577dn.fsf@gthelen.svl.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.43.161.145]
X-ClientProxiedBy: EX13D12UWC003.ant.amazon.com (10.43.162.12) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Jul 2020 00:19:00 -0700 Greg Thelen <gthelen@google.com> wrote:

> SeongJae Park <sjpark@amazon.com> wrote:
> 
> > From: SeongJae Park <sjpark@amazon.de>
> >
> > This commit adds documents for DAMON under
> > `Documentation/admin-guide/mm/damon/` and `Documentation/vm/damon/`.
> >
> > Signed-off-by: SeongJae Park <sjpark@amazon.de>
> > ---
> >  Documentation/admin-guide/mm/damon/guide.rst | 157 ++++++++++
> >  Documentation/admin-guide/mm/damon/index.rst |  15 +
> >  Documentation/admin-guide/mm/damon/plans.rst |  29 ++
> >  Documentation/admin-guide/mm/damon/start.rst |  98 ++++++
> >  Documentation/admin-guide/mm/damon/usage.rst | 298 +++++++++++++++++++
> >  Documentation/admin-guide/mm/index.rst       |   1 +
> >  Documentation/vm/damon/api.rst               |  20 ++
> >  Documentation/vm/damon/eval.rst              | 222 ++++++++++++++
> >  Documentation/vm/damon/faq.rst               |  59 ++++
> >  Documentation/vm/damon/index.rst             |  32 ++
> >  Documentation/vm/damon/mechanisms.rst        | 165 ++++++++++
> >  Documentation/vm/index.rst                   |   1 +
> >  12 files changed, 1097 insertions(+)
> >  create mode 100644 Documentation/admin-guide/mm/damon/guide.rst
> >  create mode 100644 Documentation/admin-guide/mm/damon/index.rst
> >  create mode 100644 Documentation/admin-guide/mm/damon/plans.rst
> >  create mode 100644 Documentation/admin-guide/mm/damon/start.rst
> >  create mode 100644 Documentation/admin-guide/mm/damon/usage.rst
> >  create mode 100644 Documentation/vm/damon/api.rst
> >  create mode 100644 Documentation/vm/damon/eval.rst
> >  create mode 100644 Documentation/vm/damon/faq.rst
> >  create mode 100644 Documentation/vm/damon/index.rst
> >  create mode 100644 Documentation/vm/damon/mechanisms.rst
> >+
[...]
> > +===============
> > +Detailed Usages
> > +===============
> > +
> > +DAMON provides below three interfaces for different users.
> > +
> > +- *DAMON user space tool.*
> > +  This is for privileged people such as system administrators who want a
> > +  just-working human-friendly interface.  Using this, users can use the DAMON’s
> > +  major features in a human-friendly way.  It may not be highly tuned for
> > +  special cases, though.  It supports only virtual address spaces monitoring.
> > +- *debugfs interface.*
> > +  This is for privileged user space programmers who want more optimized use of
> > +  DAMON.  Using this, users can use DAMON’s major features by reading
> > +  from and writing to special debugfs files.  Therefore, you can write and use
> > +  your personalized DAMON debugfs wrapper programs that reads/writes the
> > +  debugfs files instead of you.  The DAMON user space tool is also a reference
> > +  implementation of such programs.  It supports only virtual address spaces
> > +  monitoring.
> > +- *Kernel Space Programming Interface.*
> > +  This is for kernel space programmers.  Using this, users can utilize every
> > +  feature of DAMON most flexibly and efficiently by writing kernel space
> > +  DAMON application programs for you.  You can even extend DAMON for various
> > +  address spaces.
> > +
> > +This document does not describe the kernel space programming interface in
> > +detail.  For that, please refer to the :doc:`/vm/damon/api`.
> > +
> > +
> > +DAMON User Sapce Tool
> 
> Space

Right, thanks!

> 
[...]
> > +
> > +Can 'idle pages tracking' or 'perf mem' substitute DAMON?
> > +=========================================================
> > +
> > +Idle page tracking is a low level primitive for access check of the physical
> > +address space.  'perf mem' is similar, though it can use sampling to minimize
> > +the overhead.  On the other hand, DAMON is a higher-level framework for the
> > +monitoring of various address spaces.  It is focused on memory management
> > +optimization and provides sophisticated accuracy/overhead handling mechanisms.
> > +Therefore, 'idle pages tracking' and 'perf mem' could provide a subset of
> > +DAMON's output, but cannot substitute DAMON.  Rather than that, thouse could be
> 
> those?

Good eye!  I will fix both in the next spin.


Thanks,
SeongJae Park
