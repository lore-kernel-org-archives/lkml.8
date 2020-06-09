Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72693C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 09:18:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47A5F207ED
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 09:18:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="FdC6sM1S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728434AbgFIJSS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 05:18:18 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:50820 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726923AbgFIJSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 05:18:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1591694294; x=1623230294;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   mime-version;
  bh=exl4vfoj+rVOj20nvUHMYvhRB2IgKdPBd3fOicc2tBA=;
  b=FdC6sM1Sxa3f71KZPewLuY9Eh3ssJs5w8H3Zfxw0u4CualUK4E55H+fU
   lVo6gfv2mQ3zvMVHstwQtIgSkqpMoVdB+nMADfiZ/892bfbN3tfJ1IOXV
   6w2BRxpjeaYIND33FUCvzD6i9Zp+mA16YlhQMdTggz3/V/ED49orUpcC3
   Y=;
IronPort-SDR: l7FgCOW1uOUOCBtlDuJ60BwlAl1BMk1XDTlOgDe0mrU6MYyPQvHMiwZ4w5L6qf0rqq6uGQBUfj
 hd23/eTF6bgg==
X-IronPort-AV: E=Sophos;i="5.73,491,1583193600"; 
   d="scan'208";a="42604495"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1e-17c49630.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 09 Jun 2020 09:18:09 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1e-17c49630.us-east-1.amazon.com (Postfix) with ESMTPS id 22187A044E;
        Tue,  9 Jun 2020 09:17:58 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 9 Jun 2020 09:17:57 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.162.248) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 9 Jun 2020 09:17:41 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     David Hildenbrand <david@redhat.com>
CC:     SeongJae Park <sjpark@amazon.com>, <akpm@linux-foundation.org>,
        "SeongJae Park" <sjpark@amazon.de>, <Jonathan.Cameron@Huawei.com>,
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
Subject: Re: Re: [RFC v11 3/8] mm/damon: Implement data access monitoring-based operation schemes
Date:   Tue, 9 Jun 2020 11:17:25 +0200
Message-ID: <20200609091725.15859-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <ed4b0be0-34ad-511c-7817-e4506ed2f891@redhat.com> (raw)
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.248]
X-ClientProxiedBy: EX13D04UWA004.ant.amazon.com (10.43.160.234) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Jun 2020 10:47:45 +0200 David Hildenbrand <david@redhat.com> wrote:

> On 09.06.20 08:53, SeongJae Park wrote:
> > From: SeongJae Park <sjpark@amazon.de>
> > 
> > In many cases, users might use DAMON for simple data access aware
> > memory management optimizations such as applying an operation scheme to
> > a memory region of a specific size having a specific access frequency
> > for a specific time.  For example, "page out a memory region larger than
> > 100 MiB but having a low access frequency more than 10 minutes", or "Use
> > THP for a memory region larger than 2 MiB having a high access frequency
> > for more than 2 seconds".
> > 
> > To minimize users from spending their time for implementation of such
> > simple data access monitoring-based operation schemes, this commit makes
> > DAMON to handle such schemes directly.  With this commit, users can
> > simply specify their desired schemes to DAMON.
> 
> What would be the alternative? How would a solution where these policies
> are handled by user space (or inside an application?) look like?

Most simple form of the altermative solution would be doing offline data access
pattern profiling using DAMON and modifying the application source code or
system configuration based on the profiling results.

More automated alternative solution would be a daemon constructed with two
modules:

 - monitor: monitors the data access pattern of the workload via the DAMON
   debugfs interface
 - memory manager: based on the monitoring result, make appropriate memory
   management changes via mlock(), madvise(), sysctl, etc.

The daemon would be able to run inside the application process as a thread, or
outside as a standalone process.  If the daemon could not run inside the
application process, the memory management changes it could make would be
further limited, though, as mlock() and madvise() would not be available.  The
madvise_process(), which is already merged in the next tree, would be helpful
in this case.

> > 
> > Each of the schemes is composed with conditions for filtering of the
> > target memory regions and desired memory management action for the
> > target.  Specifically, the format is::
> > 
> >     <min/max size> <min/max access frequency> <min/max age> <action>
> > 
> > The filtering conditions are size of memory region, number of accesses
> > to the region monitored by DAMON, and the age of the region.  The age of
> > region is incremented periodically but reset when its addresses or
> > access frequency has significantly changed or the action of a scheme was
> > applied.  For the action, current implementation supports only a few of
> > madvise() hints, ``MADV_WILLNEED``, ``MADV_COLD``, ``MADV_PAGEOUT``,
> > ``MADV_HUGEPAGE``, and ``MADV_NOHUGEPAGE``.
> 
> I am missing some important information. Is this specified for *all*
> user space processes? Or how is this configured? What are examples?
> 
> E.g., messing with ``MADV_HUGEPAGE`` vs. ``MADV_NOHUGEPAGE`` of random
> applications can change the behavior/break these applications. (e.g., if
> userfaultfd is getting used and the applciation explicitly sets
> MADV_NOHUGEPAGE).

Only monitoring target processes will be applied.  The monitoring target
processes can be specified by writing the process ids to 'pids' debugfs file or
constructing the 'struct damon_ctx' via the programming interface.

I will refine the commit message to make the points clearer, in the next spin.

[...]
> 
> 
> -- 
> Thanks,
> 
> David / dhildenb
