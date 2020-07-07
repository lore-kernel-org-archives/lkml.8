Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A38DC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 08:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6614B206C3
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 08:07:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Qg1wgJga"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728169AbgGGIHq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 04:07:46 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:56120 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbgGGIHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 04:07:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1594109265; x=1625645265;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   mime-version;
  bh=MbzqrJxgSgCn69zBhdmVSCgY5Yx3uJ64kjMDImFx2cs=;
  b=Qg1wgJgamHG/T0jSildnaIi74UiyJaD5xm/p/uINpbh6U4wNEBpdWLuG
   g1REoZIOEXk4WEnGwV7tRITKC3Y097W00b+kkJEBcMCwc1qVNo+JSWTaB
   65UQNpKt9CU0Tfl5d/0QSG2vBION1nZixguLSXpbZFn4OR4dTV3rJKQpT
   E=;
IronPort-SDR: 1E4giAAWiUKz/ZEuxZnXbxYSujVdvK6YvqBnMyr509RtlXuRk3ysOshqJqehSyfvvBWOs4xb/H
 WtZ4W5z5yaCw==
X-IronPort-AV: E=Sophos;i="5.75,323,1589241600"; 
   d="scan'208";a="40557799"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2b-55156cd4.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 07 Jul 2020 08:07:41 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2b-55156cd4.us-west-2.amazon.com (Postfix) with ESMTPS id 0C5C3A18C7;
        Tue,  7 Jul 2020 08:07:38 +0000 (UTC)
Received: from EX13D31EUA004.ant.amazon.com (10.43.165.161) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 7 Jul 2020 08:07:37 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.161.214) by
 EX13D31EUA004.ant.amazon.com (10.43.165.161) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 7 Jul 2020 08:07:20 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     Mike Rapoport <rppt@kernel.org>
CC:     SeongJae Park <sjpark@amazon.com>, <akpm@linux-foundation.org>,
        "SeongJae Park" <sjpark@amazon.de>, <Jonathan.Cameron@huawei.com>,
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
Subject: Re: Re: [PATCH v17 12/15] Documentation/admin-guide/mm: Add a document for DAMON
Date:   Tue, 7 Jul 2020 10:07:02 +0200
Message-ID: <20200707080702.27222-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200707074906.GC9449@kernel.org> (raw)
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.214]
X-ClientProxiedBy: EX13D16UWC001.ant.amazon.com (10.43.162.117) To
 EX13D31EUA004.ant.amazon.com (10.43.165.161)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Jul 2020 10:49:06 +0300 Mike Rapoport <rppt@kernel.org> wrote:

> Hello SeongJae,
> 
> On Mon, Jul 06, 2020 at 01:53:19PM +0200, SeongJae Park wrote:
> > From: SeongJae Park <sjpark@amazon.de>
> > 
> > This commit adds a document for DAMON under
> > `Documentation/admin-guide/mm/damon/`.
> > 
> > Signed-off-by: SeongJae Park <sjpark@amazon.de>
> > ---
> >  Documentation/admin-guide/mm/damon/api.rst    |  20 ++
> >  .../admin-guide/mm/damon/damon_heatmap.png    | Bin 0 -> 8366 bytes
> >  .../admin-guide/mm/damon/damon_wss_change.png | Bin 0 -> 7211 bytes
> >  .../admin-guide/mm/damon/damon_wss_dist.png   | Bin 0 -> 6173 bytes
> >  Documentation/admin-guide/mm/damon/eval.rst   | 222 +++++++++++++
> >  Documentation/admin-guide/mm/damon/faq.rst    |  59 ++++
> >  .../admin-guide/mm/damon/freqmine_heatmap.png | Bin 0 -> 9999 bytes
> >  .../admin-guide/mm/damon/freqmine_wss_sz.png  | Bin 0 -> 5589 bytes
> >  .../mm/damon/freqmine_wss_time.png            | Bin 0 -> 6550 bytes
> >  Documentation/admin-guide/mm/damon/guide.rst  | 194 ++++++++++++
> >  Documentation/admin-guide/mm/damon/index.rst  |  35 +++
> >  .../admin-guide/mm/damon/mechanisms.rst       | 159 ++++++++++
> >  Documentation/admin-guide/mm/damon/plans.rst  |  29 ++
> >  Documentation/admin-guide/mm/damon/start.rst  | 117 +++++++
> >  .../mm/damon/streamcluster_heatmap.png        | Bin 0 -> 42210 bytes
> >  .../mm/damon/streamcluster_wss_sz.png         | Bin 0 -> 6327 bytes
> >  .../mm/damon/streamcluster_wss_time.png       | Bin 0 -> 8830 bytes
> >  Documentation/admin-guide/mm/damon/usage.rst  | 296 ++++++++++++++++++
> >  Documentation/admin-guide/mm/index.rst        |   1 +
> 
> It's really cool to see documentation along with the code!
> 
> I'd suggest to reorganize the DAMON docs to better match the current
> structure of Documentation/ directory.
> 
> The description of DAMON usage from the userspace and reference for the
> userland tools does belong to Documentation/admin-guide/mm. However, the
> kernel APIs are better to be placed in Documentation/core-api or even
> Documentation/dev-tools. As for the detailed description of the internal
> DAMON operation, this would naturally belong to Documentation/vm.
> 
> Another thing is that this patch is really hard to review because of the
> encoded png blobs. In general, we try to keep Documentation/ readable in
> plain text, but if you think that the images are essential and must be a
> part of DAMON in-tree docs rather than links to an external resource,
> please split them to a separate patch.

Totally agreed!  Thanks for the kind and wise comments.  I will try to remove
the blobs or at least separate those in the next spin.


Thanks,
SeongJae Park

> 
> -- 
> Sincerely yours,
> Mike.
> 
