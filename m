Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78483C18E5A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 08:54:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47DE3208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 08:54:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbgCJIyL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 04:54:11 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2530 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726466AbgCJIyK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 04:54:10 -0400
Received: from LHREML714-CAH.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 8B7DF2371FA65AEE872B;
        Tue, 10 Mar 2020 08:54:08 +0000 (GMT)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 LHREML714-CAH.china.huawei.com (10.201.108.37) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 10 Mar 2020 08:54:07 +0000
Received: from localhost (10.202.226.57) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 10 Mar
 2020 08:54:07 +0000
Date:   Tue, 10 Mar 2020 08:54:05 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     SeongJae Park <sjpark@amazon.com>
CC:     <akpm@linux-foundation.org>, SeongJae Park <sjpark@amazon.de>,
        <aarcange@redhat.com>, <yang.shi@linux.alibaba.com>,
        <acme@kernel.org>, <alexander.shishkin@linux.intel.com>,
        <amit@kernel.org>, <brendan.d.gregg@gmail.com>,
        <brendanhiggins@google.com>, <cai@lca.pw>,
        <colin.king@canonical.com>, <corbet@lwn.net>, <dwmw@amazon.com>,
        <jolsa@redhat.com>, <kirill@shutemov.name>, <mark.rutland@arm.com>,
        <mgorman@suse.de>, <minchan@kernel.org>, <mingo@redhat.com>,
        <namhyung@kernel.org>, <peterz@infradead.org>,
        <rdunlap@infradead.org>, <rientjes@google.com>,
        <rostedt@goodmis.org>, <shuah@kernel.org>, <sj38.park@gmail.com>,
        <vbabka@suse.cz>, <vdavydov.dev@gmail.com>, <linux-mm@kvack.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 01/14] mm: Introduce Data Access MONitor (DAMON)
Message-ID: <20200310085405.000061af@Huawei.com>
In-Reply-To: <20200224123047.32506-2-sjpark@amazon.com>
References: <20200224123047.32506-1-sjpark@amazon.com>
 <20200224123047.32506-2-sjpark@amazon.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.57]
X-ClientProxiedBy: lhreml715-chm.china.huawei.com (10.201.108.66) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Apologies if anyone gets these twice. I had an email server throttling
issue yesterday.

On Mon, 24 Feb 2020 13:30:34 +0100
SeongJae Park <sjpark@amazon.com> wrote:

> From: SeongJae Park <sjpark@amazon.de>
> 
> This commit introduces a kernel module named DAMON.  Note that this
> commit is implementing only the stub for the module load/unload, basic
> data structures, and simple manipulation functions of the structures to
> keep the size of commit small.  The core mechanisms of DAMON will be
> implemented one by one by following commits.

Interesting piece of work.  I'm reviewing this partly as an exercise in
understanding it, but I'll point out minor stuff on the basis I might
as well whilst I'm here. ;)  Note I review bottom up so some comments
won't make much sense read from the top.

> 
> Brief Introduction
> ==================

I'd keep this level of intro for the cover letter / docs.  It's not
particularly useful in commit message it git.

> 
> Memory management decisions can be improved if finer data access
> information is available.  However, because such finer information
> usually comes with higher overhead, most systems including Linux
> forgives the potential improvement and rely on only coarse information
> or some light-weight heuristics.  The pseudo-LRU and the aggressive THP
> promotions are such examples.
> 
> A number of experimental data access pattern awared memory management
> optimizations say the sacrifices are huge.  However, none of those has
> successfully adopted to Linux kernel mainly due to the absence of a
> scalable and efficient data access monitoring mechanism.
> 
> DAMON is a data access monitoring solution for the problem.  It is 1)
> accurate enough for the DRAM level memory management, 2) light-weight
> enough to be applied online, and 3) keeps predefined upper-bound
> overhead regardless of the size of target workloads (thus scalable).
> 
> DAMON is implemented as a standalone kernel module and provides several
> simple interfaces.  Owing to that, though it has mainly designed for the
> kernel's memory management mechanisms, it can be also used for a wide
> range of user space programs and people.
> 
> Frequently Asked Questions
> ==========================
> 
> Q: Why not integrated with perf?
> A: From the perspective of perf like profilers, DAMON can be thought of
> as a data source in kernel, like tracepoints, pressure stall information
> (psi), or idle page tracking.  Thus, it can be easily integrated with
> those.  However, this patchset doesn't provide a fancy perf integration
> because current step of DAMON development is focused on its core logic
> only.  That said, DAMON already provides two interfaces for user space
> programs, which based on debugfs and tracepoint, respectively.  Using
> the tracepoint interface, you can use DAMON with perf.  This patchset
> also provides the debugfs interface based user space tool for DAMON.  It
> can be used to record, visualize, and analyze data access pattern of
> target processes in a convenient way.
> 
> Q: Why a new module, instead of extending perf or other tools?
> A: First, DAMON aims to be used by other programs including the kernel.
> Therefore, having dependency to specific tools like perf is not
> desirable.  Second, because it need to be lightweight as much as
> possible so that it can be used online, any unnecessary overhead such as
> kernel - user space context switching cost should be avoided.  These are
> the two most biggest reasons why DAMON is implemented in the kernel
> space.  The idle page tracking subsystem would be the kernel module that
> most seems similar to DAMON.  However, it's own interface is not
> compatible with DAMON.  Also, the internal implementation of it has no
> common part to be reused by DAMON.
> 
> Q: Can 'perf mem' provide the data required for DAMON?
> A: On the systems supporting 'perf mem', yes.  DAMON is using the PTE
> Accessed bits in low level.  Other H/W or S/W features that can be used
> for the purpose could be used.  However, as explained with above
> question, DAMON need to be implemented in the kernel space.
> 
> Signed-off-by: SeongJae Park <sjpark@amazon.de>
> ---
>  mm/Kconfig  |  12 +++
>  mm/Makefile |   1 +
>  mm/damon.c  | 224 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 237 insertions(+)
>  create mode 100644 mm/damon.c
> 
> diff --git a/mm/Kconfig b/mm/Kconfig
> index ab80933be65f..387d469f40ec 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -739,4 +739,16 @@ config ARCH_HAS_HUGEPD
>  config MAPPING_DIRTY_HELPERS
>          bool
>  
> +config DAMON
> +	tristate "Data Access Monitor"
> +	depends on MMU
> +	default n

No need to specify a default of n.

> +	help
> +	  Provides data access monitoring.
> +
> +	  DAMON is a kernel module that allows users to monitor the actual
> +	  memory access pattern of specific user-space processes.  It aims to
> +	  be 1) accurate enough to be useful for performance-centric domains,
> +	  and 2) sufficiently light-weight so that it can be applied online.
> +
>  endmenu
> diff --git a/mm/Makefile b/mm/Makefile
> index 1937cc251883..2911b3832c90 100644
> --- a/mm/Makefile
> +++ b/mm/Makefile
> @@ -108,3 +108,4 @@ obj-$(CONFIG_ZONE_DEVICE) += memremap.o
>  obj-$(CONFIG_HMM_MIRROR) += hmm.o
>  obj-$(CONFIG_MEMFD_CREATE) += memfd.o
>  obj-$(CONFIG_MAPPING_DIRTY_HELPERS) += mapping_dirty_helpers.o
> +obj-$(CONFIG_DAMON) += damon.o
> diff --git a/mm/damon.c b/mm/damon.c
> new file mode 100644
> index 000000000000..aafdca35b7b8
> --- /dev/null
> +++ b/mm/damon.c
> @@ -0,0 +1,224 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Data Access Monitor
> + *
> + * Copyright 2019 Amazon.com, Inc. or its affiliates.  All rights reserved.
> + *
> + * Author: SeongJae Park <sjpark@amazon.de>
> + */
> +
> +#define pr_fmt(fmt) "damon: " fmt
> +
> +#include <linux/mm.h>
> +#include <linux/module.h>
> +#include <linux/random.h>
> +#include <linux/slab.h>
> +
> +#define damon_get_task_struct(t) \
> +	(get_pid_task(find_vpid(t->pid), PIDTYPE_PID))
> +
> +#define damon_next_region(r) \
> +	(container_of(r->list.next, struct damon_region, list))
> +
> +#define damon_prev_region(r) \
> +	(container_of(r->list.prev, struct damon_region, list))
> +
> +#define damon_for_each_region(r, t) \
> +	list_for_each_entry(r, &t->regions_list, list)
> +
> +#define damon_for_each_region_safe(r, next, t) \
> +	list_for_each_entry_safe(r, next, &t->regions_list, list)
> +
> +#define damon_for_each_task(ctx, t) \
> +	list_for_each_entry(t, &(ctx)->tasks_list, list)
> +
> +#define damon_for_each_task_safe(ctx, t, next) \
> +	list_for_each_entry_safe(t, next, &(ctx)->tasks_list, list)
> +
> +/* Represents a monitoring target region on the virtual address space */
> +struct damon_region {
> +	unsigned long vm_start;
> +	unsigned long vm_end;
> +	unsigned long sampling_addr;
> +	unsigned int nr_accesses;
> +	struct list_head list;
> +};
> +
> +/* Represents a monitoring target task */
> +struct damon_task {
> +	unsigned long pid;
> +	struct list_head regions_list;
> +	struct list_head list;
> +};
> +
> +struct damon_ctx {
> +	struct rnd_state rndseed;
> +
> +	struct list_head tasks_list;	/* 'damon_task' objects */
> +};
> +
> +/* Get a random number in [l, r) */
> +#define damon_rand(ctx, l, r) (l + prandom_u32_state(&ctx->rndseed) % (r - l))
> +
> +/*
> + * Construct a damon_region struct
> + *
> + * Returns the pointer to the new struct if success, or NULL otherwise
> + */
> +static struct damon_region *damon_new_region(struct damon_ctx *ctx,
> +				unsigned long vm_start, unsigned long vm_end)
> +{
> +	struct damon_region *ret;

I'd give this a different variable name.  Expectation in kernel is often
that ret is simply an magic handle to be passed on.  Don't normally expect
to set elements of it.  I'd go long hand and call it region.

> +
> +	ret = kmalloc(sizeof(struct damon_region), GFP_KERNEL);

sizeof(*ret)

> +	if (!ret)
> +		return NULL;

blank line.

> +	ret->vm_start = vm_start;
> +	ret->vm_end = vm_end;
> +	ret->nr_accesses = 0;
> +	ret->sampling_addr = damon_rand(ctx, vm_start, vm_end);
> +	INIT_LIST_HEAD(&ret->list);
> +
> +	return ret;
> +}
> +
> +/*
> + * Add a region between two other regions
Interestingly even the list.h comments for __list_add call this
function "insert".   No idea why it isn't simply called that..

Perhaps damon_insert_region would be clearer and avoid need
for comment?

> + */
> +static inline void damon_add_region(struct damon_region *r,
> +		struct damon_region *prev, struct damon_region *next)
> +{
> +	__list_add(&r->list, &prev->list, &next->list);
> +}
> +
> +/*
> + * Append a region to a task's list of regions

I'd argue the naming is sufficient that the comment adds little.

> + */
> +static void damon_add_region_tail(struct damon_region *r, struct damon_task *t)
> +{
> +	list_add_tail(&r->list, &t->regions_list);
> +}
> +
> +/*
> + * Delete a region from its list

The list is an implementation detail. I'd not mention that in the comments.

> + */
> +static void damon_del_region(struct damon_region *r)
> +{
> +	list_del(&r->list);
> +}
> +
> +/*
> + * De-allocate a region

Obvious comment - seem rot risk note below.

> + */
> +static void damon_free_region(struct damon_region *r)
> +{
> +	kfree(r);
> +}
> +
> +static void damon_destroy_region(struct damon_region *r)
> +{
> +	damon_del_region(r);
> +	damon_free_region(r);
> +}
> +
> +/*
> + * Construct a damon_task struct
> + *
> + * Returns the pointer to the new struct if success, or NULL otherwise
> + */
> +static struct damon_task *damon_new_task(unsigned long pid)
> +{
> +	struct damon_task *t;
> +
> +	t = kmalloc(sizeof(struct damon_task), GFP_KERNEL);

sizeof(*t) is probably less error prone if this code is maintained
in the long run.

> +	if (!t)
> +		return NULL;

blank line.

> +	t->pid = pid;
> +	INIT_LIST_HEAD(&t->regions_list);
> +
> +	return t;
> +}
> +
> +/* Returns n-th damon_region of the given task */
> +struct damon_region *damon_nth_region_of(struct damon_task *t, unsigned int n)
> +{
> +	struct damon_region *r;
> +	unsigned int i;
> +
> +	i = 0;
	unsigned int i = 0;

> +	damon_for_each_region(r, t) {
> +		if (i++ == n)
> +			return r;
> +	}

blank line helps readability a little.

> +	return NULL;
> +}
> +
> +static void damon_add_task_tail(struct damon_ctx *ctx, struct damon_task *t)

I'm curious, do we care that it's on the tail?  If not I'd look on that as an
implementation detail and just call this 

damon_add_task()

> +{
> +	list_add_tail(&t->list, &ctx->tasks_list);
> +}
> +
> +static void damon_del_task(struct damon_task *t)
> +{
> +	list_del(&t->list);
> +}
> +
> +static void damon_free_task(struct damon_task *t)
> +{
> +	struct damon_region *r, *next;
> +
> +	damon_for_each_region_safe(r, next, t)
> +		damon_free_region(r);
> +	kfree(t);
> +}
> +
> +static void damon_destroy_task(struct damon_task *t)
> +{
> +	damon_del_task(t);
> +	damon_free_task(t);
> +}
> +
> +/*
> + * Returns number of monitoring target tasks

As below, kind of obvious so just room for rot.

> + */
> +static unsigned int nr_damon_tasks(struct damon_ctx *ctx)
> +{
> +	struct damon_task *t;
> +	unsigned int ret = 0;
> +
> +	damon_for_each_task(ctx, t)
> +		ret++;
> +	return ret;
> +}
> +
> +/*
> + * Returns the number of target regions for a given target task

Always a trade off between useful comments and possibility of docs
rotting.  I'd drop this comment certainly.
The function name is self explanatory.

> + */
> +static unsigned int nr_damon_regions(struct damon_task *t)
> +{
> +	struct damon_region *r;
> +	unsigned int ret = 0;
> +
> +	damon_for_each_region(r, t)
> +		ret++;

Blank line here would help readability a tiny bit.
Same in other places where we have something followed by a nice
simple return statement.

> +	return ret;
> +}
> +
> +static int __init damon_init(void)
> +{
> +	pr_info("init\n");

Drop these. They are just noise.

> +
> +	return 0;
> +}
> +
> +static void __exit damon_exit(void)
> +{
> +	pr_info("exit\n");
> +}
> +
> +module_init(damon_init);
> +module_exit(damon_exit);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("SeongJae Park <sjpark@amazon.de>");
> +MODULE_DESCRIPTION("DAMON: Data Access MONitor");


