Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79EDAC433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 12:23:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5483420773
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 12:23:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="oxMYpFiX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729788AbgGMMXD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 08:23:03 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:18062 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbgGMMXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 08:23:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1594642983; x=1626178983;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   mime-version;
  bh=TwoQ8bDC2XXe2mOguI1vCZOlb/uARXgWALhiWYIJob0=;
  b=oxMYpFiXp+a6PMcba4654bKBdZd2uOq8blBEdDz6OK2bx5Sl9lkCbiPN
   P6TnxTpimqkOKdEryqEklHz1dH6MhnatZlS+YwcbpGzPOKPzbZXvBBnFx
   /YCqrKlYOShY3bSS/nlkJRHcgyB4wUAVUmwYsnwDVeG+hrOr7MuqFQ2n+
   g=;
IronPort-SDR: +PigRIvLE03mwAyDt7JldlA+KMu5Cs8Tlez+JFwI3u3KzRMYY5FIriCJixMJRrTFgRcJ0OKGGU
 Mb4S/MyhrDvg==
X-IronPort-AV: E=Sophos;i="5.75,347,1589241600"; 
   d="scan'208";a="42967769"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1d-f273de60.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 13 Jul 2020 12:23:02 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1d-f273de60.us-east-1.amazon.com (Postfix) with ESMTPS id 52AADA237C;
        Mon, 13 Jul 2020 12:22:50 +0000 (UTC)
Received: from EX13D31EUA004.ant.amazon.com (10.43.165.161) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 13 Jul 2020 12:22:50 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.160.65) by
 EX13D31EUA004.ant.amazon.com (10.43.165.161) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 13 Jul 2020 12:22:33 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     Mike Rapoport <rppt@kernel.org>
CC:     SeongJae Park <sjpark@amazon.com>, <akpm@linux-foundation.org>,
        "SeongJae Park" <sjpark@amazon.de>, <Jonathan.Cameron@huawei.com>,
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
        <rostedt@goodmis.org>, <sblbir@amazon.com>, <shakeelb@google.com>,
        <shuah@kernel.org>, <sj38.park@gmail.com>, <snu@amazon.de>,
        <vbabka@suse.cz>, <vdavydov.dev@gmail.com>,
        <yang.shi@linux.alibaba.com>, <ying.huang@intel.com>,
        <linux-damon@amazon.com>, <linux-mm@kvack.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: Re: [PATCH v18 01/14] mm/page_ext: Export lookup_page_ext() to GPL modules
Date:   Mon, 13 Jul 2020 14:21:43 +0200
Message-ID: <20200713122143.25493-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200713120842.GA707159@kernel.org> (raw)
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.65]
X-ClientProxiedBy: EX13D41UWC001.ant.amazon.com (10.43.162.107) To
 EX13D31EUA004.ant.amazon.com (10.43.165.161)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Jul 2020 15:08:42 +0300 Mike Rapoport <rppt@kernel.org> wrote:

> Hi,
> 
> On Mon, Jul 13, 2020 at 10:41:31AM +0200, SeongJae Park wrote:
> > From: SeongJae Park <sjpark@amazon.de>
> > 
> > This commit exports 'lookup_page_ext()' to GPL modules.  It will be used
> > by DAMON in following commit for the implementation of the region based
> > sampling.
> 
> Maybe I'm missing something, but why is DAMON a module?

I made it loadable just for easier adoption from downstream kernels.  I could
drop the module build support if asked.


Thanks,
SeongJae Park

> 
> > Signed-off-by: SeongJae Park <sjpark@amazon.de>
> > Reviewed-by: Leonard Foerster <foersleo@amazon.de>
> > Reviewed-by: Varad Gautam <vrd@amazon.de>
> > ---
> >  mm/page_ext.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/mm/page_ext.c b/mm/page_ext.c
> > index a3616f7a0e9e..9d802d01fcb5 100644
> > --- a/mm/page_ext.c
> > +++ b/mm/page_ext.c
> > @@ -131,6 +131,7 @@ struct page_ext *lookup_page_ext(const struct page *page)
> >  					MAX_ORDER_NR_PAGES);
> >  	return get_entry(base, index);
> >  }
> > +EXPORT_SYMBOL_GPL(lookup_page_ext);
> >  
> >  static int __init alloc_node_page_ext(int nid)
> >  {
> > -- 
> > 2.17.1
> > 
> 
> -- 
> Sincerely yours,
> Mike.
