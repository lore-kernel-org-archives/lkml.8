Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E252C4CECE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 10:44:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB28A2071C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 10:44:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="VWA7Nib7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbgCLKoe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 06:44:34 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:45611 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbgCLKoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 06:44:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1584009874; x=1615545874;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   mime-version;
  bh=JjVUVkyITKh6OnXxlF9voS+7ECWo+oagHMISZeb68n4=;
  b=VWA7Nib7v5txFk4Ebznxsd5t/8sX3UDrHhinTW/VM3cXXKjmlvBBDAO1
   sJgXHh6l1nm9HZWMc3ittp4WBzrzh02qJOu2JpSrmy8qzsEc3OIWnS4A+
   KcPZu2JWLl4ZNtpyMfMT9MaQ4xKxcxnGLvxyKhD1i50AJQw9m5878r8Es
   k=;
IronPort-SDR: /Fi5fDHbdGgFaeEVjGxuBCgt3uvjHvA06aECjECSM9gV2TCJT98Kim5T9TGOmaz7BBCuUl7Wyk
 oi8Pwii65PZA==
X-IronPort-AV: E=Sophos;i="5.70,544,1574121600"; 
   d="scan'208";a="20742458"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1d-37fd6b3d.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 12 Mar 2020 10:44:22 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1d-37fd6b3d.us-east-1.amazon.com (Postfix) with ESMTPS id E50F32820B7;
        Thu, 12 Mar 2020 10:44:19 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Thu, 12 Mar 2020 10:44:19 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.162.47) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 12 Mar 2020 10:44:06 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     SeongJae Park <sjpark@amazon.com>
CC:     Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        SeongJae Park <sjpark@amazon.de>,
        "Andrea Arcangeli" <aarcange@redhat.com>,
        Yang Shi <yang.shi@linux.alibaba.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <amit@kernel.org>,
        <brendan.d.gregg@gmail.com>, <brendanhiggins@google.com>,
        Qian Cai <cai@lca.pw>,
        Colin Ian King <colin.king@canonical.com>,
        Jonathan Corbet <corbet@lwn.net>, <dwmw@amazon.com>,
        <jolsa@redhat.com>, "Kirill A. Shutemov" <kirill@shutemov.name>,
        <mark.rutland@arm.com>, Mel Gorman <mgorman@suse.de>,
        Minchan Kim <minchan@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, <namhyung@kernel.org>,
        <peterz@infradead.org>, Randy Dunlap <rdunlap@infradead.org>,
        David Rientjes <rientjes@google.com>,
        Steven Rostedt <rostedt@goodmis.org>, <shuah@kernel.org>,
        <sj38.park@gmail.com>, "Vlastimil Babka" <vbabka@suse.cz>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Linux MM <linux-mm@kvack.org>, <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Re: Re: [PATCH v6 00/14] Introduce Data Access MONitor (DAMON)
Date:   Thu, 12 Mar 2020 11:43:45 +0100
Message-ID: <20200312104345.10032-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200312100759.20502-1-sjpark@amazon.com> (raw)
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.47]
X-ClientProxiedBy: EX13D16UWB001.ant.amazon.com (10.43.161.17) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Mar 2020 11:07:59 +0100 SeongJae Park <sjpark@amazon.com> wrote:

> On Tue, 10 Mar 2020 10:21:34 -0700 Shakeel Butt <shakeelb@google.com> wrote:
> 
> > On Mon, Feb 24, 2020 at 4:31 AM SeongJae Park <sjpark@amazon.com> wrote:
> > >
> > > From: SeongJae Park <sjpark@amazon.de>
> > >
> > > Introduction
> > > ============
> > >
[...]
> > 
> > I do want to question the actual motivation of the design followed by this work.
> > 
> > With the already present Page Idle Tracking feature in the kernel, I
> > can envision that the region sampling and adaptive region adjustments
> > can be done in the user space. Due to sampling, the additional
> > overhead will be very small and configurable.
> > 
> > Additionally the proposed mechanism has inherent assumption of the
> > presence of spatial locality (for virtual memory) in the monitored
> > processes which is very workload dependent.
> > 
> > Given that the the same mechanism can be implemented in the user space
> > within tolerable overhead and is workload dependent, why it should be
> > done in the kernel? What exactly is the advantage of implementing this
> > in kernel?
> 
> First of all, DAMON is not for only user space processes, but also for kernel
> space core mechanisms.  Many of the core mechanisms will be able to use DAMON
> for access pattern based optimizations, with light overhead and reasonable
> accuracy.
> 
> Implementing DAMON in user space is of course possible, but it will be
> inefficient.  Using it from kernel space would make no sense, and it would
> incur unnecessarily frequent kernel-user context switches, which is very
> expensive nowadays.

Forgot mentioning about the spatial locality.  Yes, it is workload dependant,
but still pervasive in many case.  Also, many core mechanisms in kernel such as
read-ahead or LRU are already using some similar assumptions.

If it is so problematic, you could set the maximum number of regions to the
number of pages in the system so that each region monitors each page.


Thanks,
SeongJae Park

> 
> 
> Thanks,
> SeongJae Park
> 
> 
> > 
> > thanks,
> > Shakeel
> 
