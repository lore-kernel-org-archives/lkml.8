Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07C0BC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 06:36:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D06F82087D
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 06:36:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="O6gR6NH0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbgIAGgc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 02:36:32 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:20656 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbgIAGgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 02:36:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1598942191; x=1630478191;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   mime-version;
  bh=sJPzQ3w3NJGcVjvcL8Xgt43HqNctNK4Z1JUvgEcgB8Q=;
  b=O6gR6NH0p4ABVuqjZwZ7eiydXwYv67WqCd5pDLtVe2cw8f4CRMxKK6C7
   eux0elqjgv737XcbLgMhGulMhx2j2SGO1Ad1VXVACOcfWYSzPc5+bfWUn
   FDIk68+MHSxLJIIEBzx4QhptcA4Se48EPrkMxZ4Lo317f1+uEd5gJYDVV
   A=;
X-IronPort-AV: E=Sophos;i="5.76,378,1592870400"; 
   d="scan'208";a="52696113"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1a-af6a10df.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 01 Sep 2020 06:36:29 +0000
Received: from EX13D31EUA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1a-af6a10df.us-east-1.amazon.com (Postfix) with ESMTPS id BEEC4A2394;
        Tue,  1 Sep 2020 06:36:17 +0000 (UTC)
Received: from u3f2cd687b01c55.ant.amazon.com (10.43.160.100) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 1 Sep 2020 06:35:59 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     Marco Elver <elver@google.com>
CC:     SeongJae Park <sjpark@amazon.com>, <akpm@linux-foundation.org>,
        "SeongJae Park" <sjpark@amazon.de>, <Jonathan.Cameron@Huawei.com>,
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
        <zgf574564920@gmail.com>, <linux-damon@amazon.com>,
        <linux-mm@kvack.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [RFC v8 01/10] mm/damon/debugfs: Allow users to set initial monitoring target regions
Date:   Tue, 1 Sep 2020 08:35:42 +0200
Message-ID: <20200901063542.1290-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200831180844.GA3992970@elver.google.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.100]
X-ClientProxiedBy: EX13D20UWA001.ant.amazon.com (10.43.160.34) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Aug 2020 20:08:44 +0200 Marco Elver <elver@google.com> wrote:

> On Mon, Aug 31, 2020 at 12:47PM +0200, SeongJae Park wrote:
> [...]
> > diff --git a/mm/damon.c b/mm/damon.c
> > index 7e3c8c82a010..9815d22fc4de 100644
> > --- a/mm/damon.c
> > +++ b/mm/damon.c
> > @@ -2001,6 +2001,147 @@ static ssize_t debugfs_record_write(struct file *file,
> >  	return ret;
> >  }
> >  
> > +static ssize_t sprint_init_regions(struct damon_ctx *c, char *buf, ssize_t len)
> > +{
> > +	struct damon_target *t;
> > +	struct damon_region *r;
> > +	int written = 0;
> > +	int rc;
> > +
> > +	damon_for_each_target(t, c) {
> > +		damon_for_each_region(r, t) {
> > +			rc = snprintf(&buf[written], len - written,
> > +					"%lu %lu %lu\n",
> > +					t->id, r->ar.start, r->ar.end);
> 
> This most likely will not work as intended, because snprintf() returns
> "[...] the number of characters which would be generated for the given
> input, excluding the trailing null [...]". Would scnprintf() -- which
> returns "[...] the number of characters written into @buf not including
> the trailing '\0' [...]" -- do what you intended?

Ah, you're right!  I will use 'scnprintf' instead, not only here but in other
relevant parts.


Thanks,
SeongJae Park

> 
> > +			if (!rc)
> > +				return -ENOMEM;
> > +			written += rc;
> > +		}
> > +	}
> > +	return written;
> > +}
> [...]
