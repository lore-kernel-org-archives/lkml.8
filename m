Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91281C18E5A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 11:51:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FFF62464B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 11:51:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="EfJDB/YP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbgCJLvo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 07:51:44 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:36944 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbgCJLvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 07:51:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1583841103; x=1615377103;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   mime-version;
  bh=QvNs1X7gKJs6PKCVvsd9lF/RMXQloNFCJCkTdzItMqI=;
  b=EfJDB/YPxjj42qAUqJdOHJq6zY6itIGYyMnsqwpmfPNuFvw+6781BxEB
   tsIn7wksCRyK5JDLZJhtTVxn5R6/qzNDaNnUvoMcRFpPO8jx0NwivHheA
   ECSVEI4IqhBRsTE20QuXZRm9PTESIDggNlCFuas/bF5ltNsGkRGQRcZuT
   Q=;
IronPort-SDR: EJZjgMY1z4JO4meBWbMtPFhhohLkgKyE4FrzhbW7JJeLnTfjpaufc8GwDNRQhYioSC1c9LtcTI
 hhki5B93VJBw==
X-IronPort-AV: E=Sophos;i="5.70,536,1574121600"; 
   d="scan'208";a="21950597"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1a-af6a10df.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 10 Mar 2020 11:51:38 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1a-af6a10df.us-east-1.amazon.com (Postfix) with ESMTPS id 473CCA06F9;
        Tue, 10 Mar 2020 11:51:27 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Tue, 10 Mar 2020 11:51:27 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.161.152) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 10 Mar 2020 11:51:15 +0000
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
Subject: Re: Re: [PATCH v6 01/14] mm: Introduce Data Access MONitor (DAMON)
Date:   Tue, 10 Mar 2020 12:50:59 +0100
Message-ID: <20200310115059.22831-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200310085405.000061af@Huawei.com> (raw)
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.152]
X-ClientProxiedBy: EX13D04UWB004.ant.amazon.com (10.43.161.103) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Mar 2020 08:54:05 +0000 Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> Apologies if anyone gets these twice. I had an email server throttling
> issue yesterday.
> 
> On Mon, 24 Feb 2020 13:30:34 +0100
> SeongJae Park <sjpark@amazon.com> wrote:
> 
> > From: SeongJae Park <sjpark@amazon.de>
> > 
> > This commit introduces a kernel module named DAMON.  Note that this
> > commit is implementing only the stub for the module load/unload, basic
> > data structures, and simple manipulation functions of the structures to
> > keep the size of commit small.  The core mechanisms of DAMON will be
> > implemented one by one by following commits.
> 
> Interesting piece of work.  I'm reviewing this partly as an exercise in
> understanding it, but I'll point out minor stuff on the basis I might
> as well whilst I'm here. ;)  Note I review bottom up so some comments
> won't make much sense read from the top.

Thanks for review, Jonathan :)  I added reply in line below, but agree to your
whole suggestion.  Will apply those in next spin.

> 
> > 
> > Brief Introduction
> > ==================
> 
> I'd keep this level of intro for the cover letter / docs.  It's not
> particularly useful in commit message it git.

Agreed.

> 
> > 
[...]
> >  
> > +config DAMON
> > +	tristate "Data Access Monitor"
> > +	depends on MMU
> > +	default n
> 
> No need to specify a default of n.

Got it.

> 
> > +	help
> > +	  Provides data access monitoring.
> > +
> > +	  DAMON is a kernel module that allows users to monitor the actual
> > +	  memory access pattern of specific user-space processes.  It aims to
> > +	  be 1) accurate enough to be useful for performance-centric domains,
> > +	  and 2) sufficiently light-weight so that it can be applied online.
> > +
> >  endmenu
[...]
> > +/*
> > + * Construct a damon_region struct
> > + *
> > + * Returns the pointer to the new struct if success, or NULL otherwise
> > + */
> > +static struct damon_region *damon_new_region(struct damon_ctx *ctx,
> > +				unsigned long vm_start, unsigned long vm_end)
> > +{
> > +	struct damon_region *ret;
> 
> I'd give this a different variable name.  Expectation in kernel is often
> that ret is simply an magic handle to be passed on.  Don't normally expect
> to set elements of it.  I'd go long hand and call it region.

Nice point, will change the name to 'region'.

> 
> > +
> > +	ret = kmalloc(sizeof(struct damon_region), GFP_KERNEL);
> 
> sizeof(*ret)

Thanks for catching it!  Will apply to other similar cases.

> 
> > +	if (!ret)
> > +		return NULL;
> 
> blank line.

Good suggestion.

> 
> > +	ret->vm_start = vm_start;
> > +	ret->vm_end = vm_end;
> > +	ret->nr_accesses = 0;
> > +	ret->sampling_addr = damon_rand(ctx, vm_start, vm_end);
> > +	INIT_LIST_HEAD(&ret->list);
> > +
> > +	return ret;
> > +}
> > +
> > +/*
> > + * Add a region between two other regions
> Interestingly even the list.h comments for __list_add call this
> function "insert".   No idea why it isn't simply called that..
> 
> Perhaps damon_insert_region would be clearer and avoid need
> for comment?

I just wanted to make the name consistent with the 'list.h' file, but your
suggestion sounds better.  Will change so.

> 
> > + */
> > +static inline void damon_add_region(struct damon_region *r,
> > +		struct damon_region *prev, struct damon_region *next)
> > +{
> > +	__list_add(&r->list, &prev->list, &next->list);
> > +}
> > +
> > +/*
> > + * Append a region to a task's list of regions
> 
> I'd argue the naming is sufficient that the comment adds little.

Yes, will delete it.

> 
> > + */
> > +static void damon_add_region_tail(struct damon_region *r, struct damon_task *t)
> > +{
> > +	list_add_tail(&r->list, &t->regions_list);
> > +}
> > +
> > +/*
> > + * Delete a region from its list
> 
> The list is an implementation detail. I'd not mention that in the comments.

Nice suggestion.

> 
> > + */
> > +static void damon_del_region(struct damon_region *r)
> > +{
> > +	list_del(&r->list);
> > +}
> > +
> > +/*
> > + * De-allocate a region
> 
> Obvious comment - seem rot risk note below.

Agreed.

> 
> > + */
> > +static void damon_free_region(struct damon_region *r)
> > +{
> > +	kfree(r);
> > +}
> > +
> > +static void damon_destroy_region(struct damon_region *r)
> > +{
> > +	damon_del_region(r);
> > +	damon_free_region(r);
> > +}
> > +
> > +/*
> > + * Construct a damon_task struct
> > + *
> > + * Returns the pointer to the new struct if success, or NULL otherwise
> > + */
> > +static struct damon_task *damon_new_task(unsigned long pid)
> > +{
> > +	struct damon_task *t;
> > +
> > +	t = kmalloc(sizeof(struct damon_task), GFP_KERNEL);
> 
> sizeof(*t) is probably less error prone if this code is maintained
> in the long run.

Good point, will apply to other cases, either.

> 
> > +	if (!t)
> > +		return NULL;
> 
> blank line.

Will add it.

> 
> > +	t->pid = pid;
> > +	INIT_LIST_HEAD(&t->regions_list);
> > +
> > +	return t;
> > +}
> > +
> > +/* Returns n-th damon_region of the given task */
> > +struct damon_region *damon_nth_region_of(struct damon_task *t, unsigned int n)
> > +{
> > +	struct damon_region *r;
> > +	unsigned int i;
> > +
> > +	i = 0;
> 	unsigned int i = 0;

Yes, it must be much better.

> 
> > +	damon_for_each_region(r, t) {
> > +		if (i++ == n)
> > +			return r;
> > +	}
> 
> blank line helps readability a little.

Yes, indeed.

> 
> > +	return NULL;
> > +}
> > +
> > +static void damon_add_task_tail(struct damon_ctx *ctx, struct damon_task *t)
> 
> I'm curious, do we care that it's on the tail?  If not I'd look on that as an
> implementation detail and just call this 
> 
> damon_add_task()

I named it to be consistent with 'damon_add_region[_tail]()' functions, but as
you suggested renaming 'damon_add_region()', it doesn't need to.  Will change
the name.

> 
> > +{
> > +	list_add_tail(&t->list, &ctx->tasks_list);
> > +}
> > +
> > +static void damon_del_task(struct damon_task *t)
> > +{
> > +	list_del(&t->list);
> > +}
> > +
> > +static void damon_free_task(struct damon_task *t)
> > +{
> > +	struct damon_region *r, *next;
> > +
> > +	damon_for_each_region_safe(r, next, t)
> > +		damon_free_region(r);
> > +	kfree(t);
> > +}
> > +
> > +static void damon_destroy_task(struct damon_task *t)
> > +{
> > +	damon_del_task(t);
> > +	damon_free_task(t);
> > +}
> > +
> > +/*
> > + * Returns number of monitoring target tasks
> 
> As below, kind of obvious so just room for rot.

Agreed.

> 
> > + */
> > +static unsigned int nr_damon_tasks(struct damon_ctx *ctx)
> > +{
> > +	struct damon_task *t;
> > +	unsigned int ret = 0;
> > +
> > +	damon_for_each_task(ctx, t)
> > +		ret++;
> > +	return ret;
> > +}
> > +
> > +/*
> > + * Returns the number of target regions for a given target task
> 
> Always a trade off between useful comments and possibility of docs
> rotting.  I'd drop this comment certainly.
> The function name is self explanatory.

Agreed!

> 
> > + */
> > +static unsigned int nr_damon_regions(struct damon_task *t)
> > +{
> > +	struct damon_region *r;
> > +	unsigned int ret = 0;
> > +
> > +	damon_for_each_region(r, t)
> > +		ret++;
> 
> Blank line here would help readability a tiny bit.
> Same in other places where we have something followed by a nice
> simple return statement.

Yes, indeed.

> 
> > +	return ret;
> > +}
> > +
> > +static int __init damon_init(void)
> > +{
> > +	pr_info("init\n");
> 
> Drop these. They are just noise.

Right, it's just noise, will remove.


Thank you again for kind review, Jonathan!


Thanks,
SeongJae Park

> 
> > +
> > +	return 0;
> > +}
> > +
> > +static void __exit damon_exit(void)
> > +{
> > +	pr_info("exit\n");
> > +}
> > +
> > +module_init(damon_init);
> > +module_exit(damon_exit);
> > +
> > +MODULE_LICENSE("GPL");
> > +MODULE_AUTHOR("SeongJae Park <sjpark@amazon.de>");
> > +MODULE_DESCRIPTION("DAMON: Data Access MONitor");
> 
