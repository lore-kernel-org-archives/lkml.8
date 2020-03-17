Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CD80C18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:33:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECB382071C
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:33:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="obg1DBEb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbgCQLdB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 07:33:01 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:1753 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbgCQLdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 07:33:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1584444780; x=1615980780;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   mime-version;
  bh=izxcm8ptiZiwrpRrcuuDqsQprWd3tUq31X/9MftT3K4=;
  b=obg1DBEb6VCQDkbsKhmUvKGoYki7wImSSCIYnlXKPi6CfgTZEaIH1Sh8
   0xqmeFIY8+K/CNIXPPGay6adRb5R0D3CXIfFS0V236rQJsc6607HlQcxb
   0DZndjQQeIsr3EAbfj5jvYjmrq7SeuG5+FHFom/z9yvOaRXC7JGHutHub
   c=;
IronPort-SDR: Y9SGIQ/bR4v2R4R5Sdk5N2uvzxJZQN0lgJyP1r3JPDm5T0n49s+tVsfwcvSOK4uvwD/BS6enOQ
 e1BxFaHR4dZA==
X-IronPort-AV: E=Sophos;i="5.70,564,1574121600"; 
   d="scan'208";a="21384006"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1d-f273de60.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 17 Mar 2020 11:32:48 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1d-f273de60.us-east-1.amazon.com (Postfix) with ESMTPS id CCB70A05F9;
        Tue, 17 Mar 2020 11:32:38 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Tue, 17 Mar 2020 11:32:38 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.162.167) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 17 Mar 2020 11:32:24 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     SeongJae Park <sj38.park@gmail.com>
CC:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        SeongJae Park <sjpark@amazon.com>, <akpm@linux-foundation.org>,
        SeongJae Park <sjpark@amazon.de>, <aarcange@redhat.com>,
        <yang.shi@linux.alibaba.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <amit@kernel.org>,
        <brendan.d.gregg@gmail.com>, <brendanhiggins@google.com>,
        <cai@lca.pw>, <colin.king@canonical.com>, <corbet@lwn.net>,
        <dwmw@amazon.com>, <jolsa@redhat.com>, <kirill@shutemov.name>,
        <mark.rutland@arm.com>, <mgorman@suse.de>, <minchan@kernel.org>,
        <mingo@redhat.com>, <namhyung@kernel.org>, <peterz@infradead.org>,
        <rdunlap@infradead.org>, <rientjes@google.com>,
        <rostedt@goodmis.org>, <shuah@kernel.org>, <vbabka@suse.cz>,
        <vdavydov.dev@gmail.com>, <linux-mm@kvack.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: Re: Re: [PATCH v6 02/14] mm/damon: Implement region based sampling
Date:   Tue, 17 Mar 2020 12:32:05 +0100
Message-ID: <20200317113205.3617-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200313201649.26646-1-sj38.park@gmail.com> (raw)
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.167]
X-ClientProxiedBy: EX13D31UWC004.ant.amazon.com (10.43.162.27) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Mar 2020 21:16:49 +0100 SeongJae Park <sj38.park@gmail.com> wrote:

> On Fri, 13 Mar 2020 17:29:54 +0000 Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
> 
> > On Mon, 24 Feb 2020 13:30:35 +0100
> > SeongJae Park <sjpark@amazon.com> wrote:
> > 
> > > From: SeongJae Park <sjpark@amazon.de>
> > > 
> > > This commit implements DAMON's basic access check and region based
> > > sampling mechanisms.  This change would seems make no sense, mainly
> > > because it is only a part of the DAMON's logics.  Following two commits
> > > will make more sense.
> > > 
> [...]
> > 
> > Came across a minor issue inline.  kthread_run calls kthread_create.
> > That gives a potential sleep while atomic issue given the spin lock.
> > 
> > Can probably be fixed by preallocating the thread then starting it later.
> > 
> > Jonathan
> [...]
> > > +/*
> > > + * Start or stop the kdamond
> > > + *
> > > + * Returns 0 if success, negative error code otherwise.
> > > + */
> > > +static int damon_turn_kdamond(struct damon_ctx *ctx, bool on)
> > > +{
> > > +	spin_lock(&ctx->kdamond_lock);
> > > +	ctx->kdamond_stop = !on;
> > > +	if (!ctx->kdamond && on) {
> > > +		ctx->kdamond = kthread_run(kdamond_fn, ctx, "kdamond");
> > 
> > Can't do this under a spin lock.
> 
> Good catch!  And, agree to your suggestion.  I will fix this in that way!

I changed my mind.  I would like to simply use mutex instead of spinlock, as
khugepaged also does.  If you have different opinion, please let me know.


Thanks,
SeongJae Park

> 
> 
> Thanks,
> SeongJae Park
