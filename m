Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B31BC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 17:49:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14947206D5
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 17:49:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="nTm3P/4p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730312AbgFHRtN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 13:49:13 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:25909 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730247AbgFHRtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 13:49:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1591638551; x=1623174551;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   mime-version;
  bh=RrQlW9u3yz1uG+aS3Pnccyw7nqI12EiiyIfTXmHO7oM=;
  b=nTm3P/4ps504evNoB8DVZZKQOTp2hRzMiPCpJO2dvcu9psop9Ie6wJZz
   wC5eYjt1TNTdGOlEAUCnDPS0SyD/LBVXJVrEJXRsZlFN5UaRIMmoyN2jE
   xTdPPqZ5XgVIzJhQUIE+sshMbp25D/XVbYCjTVp2qeQDvueSSon+LaVlv
   Y=;
IronPort-SDR: lk/06JDJfipnDKz23035oixRv1+ial6X9Qc7qbzrgzY6P+DMOZ19qBQ0XQsROk46d6svcb8e3l
 0oqR1Y1oBd5w==
X-IronPort-AV: E=Sophos;i="5.73,487,1583193600"; 
   d="scan'208";a="42447105"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2b-55156cd4.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 08 Jun 2020 17:48:58 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2b-55156cd4.us-west-2.amazon.com (Postfix) with ESMTPS id 7F18FA18D2;
        Mon,  8 Jun 2020 17:48:55 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 8 Jun 2020 17:48:55 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.160.65) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 8 Jun 2020 17:48:37 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     Christoph Hellwig <hch@infradead.org>
CC:     David Hildenbrand <david@redhat.com>,
        SeongJae Park <sjpark@amazon.com>, <akpm@linux-foundation.org>,
        SeongJae Park <sjpark@amazon.de>,
        <Jonathan.Cameron@huawei.com>, <aarcange@redhat.com>,
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
        <linux-damon@amazon.com>, <linux-mm@kvack.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: Re: [PATCH v15 01/14] mm/page_ext: Export lookup_page_ext() to GPL modules
Date:   Mon, 8 Jun 2020 19:48:16 +0200
Message-ID: <20200608174816.19222-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200608154917.GA8408@infradead.org> (raw)
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.65]
X-ClientProxiedBy: EX13D31UWC001.ant.amazon.com (10.43.162.152) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Jun 2020 08:49:17 -0700 Christoph Hellwig <hch@infradead.org> wrote:

> On Mon, Jun 08, 2020 at 01:53:23PM +0200, David Hildenbrand wrote:
> > > @@ -131,6 +131,7 @@ struct page_ext *lookup_page_ext(const struct page *page)
> > >  					MAX_ORDER_NR_PAGES);
> > >  	return get_entry(base, index);
> > >  }
> > > +EXPORT_SYMBOL_GPL(lookup_page_ext);
> > >  
> > >  static int __init alloc_node_page_ext(int nid)
> > >  {
> > > 
> > 
> > I've been told to always smuggle new EXPORTs into the patch that
> > actually needs it (and cc relevant people on that patch instead).
> 
> A separate patch for anything remotely controversial really helps it
> to stick out, so I think keeping it separate is a very good practice.

I have no strong preference here.  So if no further comments are given, in the
next spin, I will keep this separate, but will mention exactly what future
commit needs this change, so that it can be easily squashed later, if
necessary.


Thanks,
SeongJae Park
