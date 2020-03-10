Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DFBDC18E5C
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 11:56:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7527524680
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 11:56:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="hwNIUsqU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbgCJL4A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 07:56:00 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:37654 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbgCJLz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 07:55:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1583841360; x=1615377360;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   mime-version;
  bh=42jpFvXj+e+5M6txGyfHb4+LbQzmZ+mgcwNH5FeGZuA=;
  b=hwNIUsqUoW8yR+Ph86kn366JaGALkwbKPQ/g+Q77YQ26F4JzmW9CFovM
   gfTFHWFg+sDXys8wiyKIN2UaJhzTNaHoGP3PwOZr88g9+sWkHfN5wn5UZ
   /UxGjSAgy4yWiZyvDfC3kpAf5ZZBlVCxymDaJqftXg5R7MH/yPY88tX6a
   Q=;
IronPort-SDR: rrJ4bs6Hva56wFJ9c+8BBKsIN4n5I/z68c4BJpFz5zfqrZls7viM7ZMCUEz/lFMGXY0tKc0Rus
 qdihhLb/JVxQ==
X-IronPort-AV: E=Sophos;i="5.70,536,1574121600"; 
   d="scan'208";a="21951063"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1e-c7c08562.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 10 Mar 2020 11:55:57 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1e-c7c08562.us-east-1.amazon.com (Postfix) with ESMTPS id C4526240EF9;
        Tue, 10 Mar 2020 11:55:46 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Tue, 10 Mar 2020 11:55:46 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.160.16) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 10 Mar 2020 11:55:34 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC:     SeongJae Park <sjpark@amazon.com>, <akpm@linux-foundation.org>,
        "SeongJae Park" <sjpark@amazon.de>, <aarcange@redhat.com>,
        <yang.shi@linux.alibaba.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <amit@kernel.org>,
        <brendan.d.gregg@gmail.com>, <brendanhiggins@google.com>,
        <cai@lca.pw>, <colin.king@canonical.com>, <corbet@lwn.net>,
        <dwmw@amazon.com>, <jolsa@redhat.com>, <kirill@shutemov.name>,
        <mark.rutland@arm.com>, <mgorman@suse.de>, <minchan@kernel.org>,
        <mingo@redhat.com>, <namhyung@kernel.org>, <peterz@infradead.org>,
        <rdunlap@infradead.org>, <rientjes@google.com>,
        <rostedt@goodmis.org>, <shuah@kernel.org>, <sj38.park@gmail.com>,
        <vbabka@suse.cz>, <vdavydov.dev@gmail.com>, <linux-mm@kvack.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: Re: [PATCH v6 05/14] mm/damon: Implement callbacks
Date:   Tue, 10 Mar 2020 12:55:19 +0100
Message-ID: <20200310115519.24554-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200310090116.0000723f@Huawei.com> (raw)
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.16]
X-ClientProxiedBy: EX13D07UWB003.ant.amazon.com (10.43.161.66) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Mar 2020 09:01:16 +0000 Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> On Mon, 24 Feb 2020 13:30:38 +0100
> SeongJae Park <sjpark@amazon.com> wrote:
> 
> > From: SeongJae Park <sjpark@amazon.de>
> > 
> > This commit implements callbacks for DAMON.  Using this, DAMON users can
> > install their callbacks for each step of the access monitoring so that
> > they can do something interesting with the monitored access pattrns
> 
> patterns

Thank you for finding!

> 
[...]
