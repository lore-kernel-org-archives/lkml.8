Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A6FBC18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 09:01:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB99520663
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 09:01:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbgCJJB4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 05:01:56 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2536 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726389AbgCJJBz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 05:01:55 -0400
Received: from LHREML713-CAH.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 7C36B3821EE36C01EB43;
        Tue, 10 Mar 2020 09:01:54 +0000 (GMT)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 LHREML713-CAH.china.huawei.com (10.201.108.36) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 10 Mar 2020 09:01:54 +0000
Received: from localhost (10.202.226.57) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 10 Mar
 2020 09:01:53 +0000
Date:   Tue, 10 Mar 2020 09:01:52 +0000
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
Subject: Re: [PATCH v6 07/14] mm/damon: Implement kernel space API
Message-ID: <20200310090152.00002c6e@Huawei.com>
In-Reply-To: <20200224123047.32506-8-sjpark@amazon.com>
References: <20200224123047.32506-1-sjpark@amazon.com>
 <20200224123047.32506-8-sjpark@amazon.com>
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

On Mon, 24 Feb 2020 13:30:40 +0100
SeongJae Park <sjpark@amazon.com> wrote:

> From: SeongJae Park <sjpark@amazon.de>
> 
> This commit implements the DAMON api for the kernel.  Other kernel code
> can use DAMON by calling damon_start() and damon_stop() with their own
> 'struct damon_ctx'.
> 
> Signed-off-by: SeongJae Park <sjpark@amazon.de>

Seems like it would have been easier to create the header as you went along
and avoid the need to have the bits here dropping static.

Or the moves for that matter.

Also, ideally have full kernel-doc for anything that forms part of an
interface that is intended for use by others.

Jonathan

> ---
>  include/linux/damon.h | 71 +++++++++++++++++++++++++++++++++++++++++++
>  mm/damon.c            | 71 +++++++++----------------------------------
>  2 files changed, 85 insertions(+), 57 deletions(-)
>  create mode 100644 include/linux/damon.h
> 
> diff --git a/include/linux/damon.h b/include/linux/damon.h
> new file mode 100644
> index 000000000000..78785cb88d42
> --- /dev/null
> +++ b/include/linux/damon.h
> @@ -0,0 +1,71 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * DAMON api
> + *
> + * Copyright 2019 Amazon.com, Inc. or its affiliates.  All rights reserved.
> + *
> + * Author: SeongJae Park <sjpark@amazon.de>
> + */
> +
> +#ifndef _DAMON_H_
> +#define _DAMON_H_
> +
> +#include <linux/random.h>
> +#include <linux/spinlock_types.h>
> +#include <linux/time64.h>
> +#include <linux/types.h>
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
> +	unsigned long sample_interval;
> +	unsigned long aggr_interval;
> +	unsigned long regions_update_interval;
> +	unsigned long min_nr_regions;
> +	unsigned long max_nr_regions;
> +
> +	struct timespec64 last_aggregation;
> +	struct timespec64 last_regions_update;
> +
> +	unsigned char *rbuf;
> +	unsigned int rbuf_len;
> +	unsigned int rbuf_offset;
> +	char *rfile_path;
> +
> +	struct task_struct *kdamond;
> +	bool kdamond_stop;
> +	spinlock_t kdamond_lock;
> +
> +	struct rnd_state rndseed;
> +
> +	struct list_head tasks_list;	/* 'damon_task' objects */
> +
> +	/* callbacks */
> +	void (*sample_cb)(struct damon_ctx *context);
> +	void (*aggregate_cb)(struct damon_ctx *context);
> +};
> +
> +int damon_set_pids(struct damon_ctx *ctx,
> +			unsigned long *pids, ssize_t nr_pids);
> +int damon_set_recording(struct damon_ctx *ctx,
> +			unsigned int rbuf_len, char *rfile_path);
> +int damon_set_attrs(struct damon_ctx *ctx, unsigned long s, unsigned long a,
> +			unsigned long r, unsigned long min, unsigned long max);
> +int damon_start(struct damon_ctx *ctx);
> +int damon_stop(struct damon_ctx *ctx);
> +
> +#endif
> diff --git a/mm/damon.c b/mm/damon.c
> index a7edb2dfa700..b3e9b9da5720 100644
> --- a/mm/damon.c
> +++ b/mm/damon.c
> @@ -9,6 +9,7 @@
>  
>  #define pr_fmt(fmt) "damon: " fmt
>  
> +#include <linux/damon.h>
>  #include <linux/delay.h>
>  #include <linux/kthread.h>
>  #include <linux/mm.h>
> @@ -40,60 +41,6 @@
>  #define damon_for_each_task_safe(ctx, t, next) \
>  	list_for_each_entry_safe(t, next, &(ctx)->tasks_list, list)
>  
> -/* Represents a monitoring target region on the virtual address space */
> -struct damon_region {
> -	unsigned long vm_start;
> -	unsigned long vm_end;
> -	unsigned long sampling_addr;
> -	unsigned int nr_accesses;
> -	struct list_head list;
> -};
> -
> -/* Represents a monitoring target task */
> -struct damon_task {
> -	unsigned long pid;
> -	struct list_head regions_list;
> -	struct list_head list;
> -};
> -
> -/*
> - * For each 'sample_interval', DAMON checks whether each region is accessed or
> - * not.  It aggregates and keeps the access information (number of accesses to
> - * each region) for each 'aggr_interval' time.  And for each
> - * 'regions_update_interval', damon checks whether the memory mapping of the
> - * target tasks has changed (e.g., by mmap() calls from the applications) and
> - * applies the changes.
> - *
> - * All time intervals are in micro-seconds.
> - */
> -struct damon_ctx {
> -	unsigned long sample_interval;
> -	unsigned long aggr_interval;
> -	unsigned long regions_update_interval;
> -	unsigned long min_nr_regions;
> -	unsigned long max_nr_regions;
> -
> -	struct timespec64 last_aggregation;
> -	struct timespec64 last_regions_update;
> -
> -	unsigned char *rbuf;
> -	unsigned int rbuf_len;
> -	unsigned int rbuf_offset;
> -	char *rfile_path;
> -
> -	struct task_struct *kdamond;
> -	bool kdamond_stop;
> -	spinlock_t kdamond_lock;
> -
> -	struct rnd_state rndseed;
> -
> -	struct list_head tasks_list;	/* 'damon_task' objects */
> -
> -	/* callbacks */
> -	void (*sample_cb)(struct damon_ctx *context);
> -	void (*aggregate_cb)(struct damon_ctx *context);
> -};
> -
>  #define MAX_RFILE_PATH_LEN	256
>  
>  /* Get a random number in [l, r) */
> @@ -961,10 +908,20 @@ static int damon_turn_kdamond(struct damon_ctx *ctx, bool on)
>  	return 0;
>  }
>  
> +int damon_start(struct damon_ctx *ctx)
> +{
> +	return damon_turn_kdamond(ctx, true);
> +}
> +
> +int damon_stop(struct damon_ctx *ctx)
> +{
> +	return damon_turn_kdamond(ctx, false);
> +}
> +
>  /*
>   * This function should not be called while the kdamond is running.
>   */
> -static int damon_set_pids(struct damon_ctx *ctx,
> +int damon_set_pids(struct damon_ctx *ctx,
>  			unsigned long *pids, ssize_t nr_pids)
>  {
>  	ssize_t i;
> @@ -998,7 +955,7 @@ static int damon_set_pids(struct damon_ctx *ctx,
>   *
>   * Returns 0 on success, negative error code otherwise.
>   */
> -static int damon_set_recording(struct damon_ctx *ctx,
> +int damon_set_recording(struct damon_ctx *ctx,
>  				unsigned int rbuf_len, char *rfile_path)
>  {
>  	size_t rfile_path_len;
> @@ -1046,7 +1003,7 @@ static int damon_set_recording(struct damon_ctx *ctx,
>   *
>   * Returns 0 on success, negative error code otherwise.
>   */
> -static int damon_set_attrs(struct damon_ctx *ctx, unsigned long sample_int,
> +int damon_set_attrs(struct damon_ctx *ctx, unsigned long sample_int,
>  		unsigned long aggr_int, unsigned long regions_update_int,
>  		unsigned long min_nr_reg, unsigned long max_nr_reg)
>  {


