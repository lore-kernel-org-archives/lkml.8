Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 069C2C18E5C
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 09:01:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2E6E20663
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 09:01:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbgCJJBi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 05:01:38 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2535 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726389AbgCJJBh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 05:01:37 -0400
Received: from lhreml704-cah.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 7416A3F7CDEB21F6EF8A;
        Tue, 10 Mar 2020 09:01:36 +0000 (GMT)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 lhreml704-cah.china.huawei.com (10.201.108.45) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 10 Mar 2020 09:01:36 +0000
Received: from localhost (10.202.226.57) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 10 Mar
 2020 09:01:35 +0000
Date:   Tue, 10 Mar 2020 09:01:34 +0000
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
Subject: Re: [PATCH v6 06/14] mm/damon: Implement access pattern recording
Message-ID: <20200310090134.000052fb@Huawei.com>
In-Reply-To: <20200224123047.32506-7-sjpark@amazon.com>
References: <20200224123047.32506-1-sjpark@amazon.com>
 <20200224123047.32506-7-sjpark@amazon.com>
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

On Mon, 24 Feb 2020 13:30:39 +0100
SeongJae Park <sjpark@amazon.com> wrote:

> From: SeongJae Park <sjpark@amazon.de>
> 
> This commit implements the recording feature of DAMON. If this feature
> is enabled, DAMON writes the monitored access patterns in its binary
> format into a file which specified by the user. This is already able to
> be implemented by each user using the callbacks.  However, as the
> recording is expected to be used widely, this commit implements the
> feature in the DAMON, for more convenience and efficiency.
> 
> Signed-off-by: SeongJae Park <sjpark@amazon.de>

I guess this work whilst you are still developing, but I'm not convinced
writing to a file should be a standard feature...

> ---
>  mm/damon.c | 126 +++++++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 123 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/damon.c b/mm/damon.c
> index 554720778e8a..a7edb2dfa700 100644
> --- a/mm/damon.c
> +++ b/mm/damon.c
> @@ -76,6 +76,11 @@ struct damon_ctx {
>  	struct timespec64 last_aggregation;
>  	struct timespec64 last_regions_update;
>  
> +	unsigned char *rbuf;
> +	unsigned int rbuf_len;
> +	unsigned int rbuf_offset;
> +	char *rfile_path;
> +
>  	struct task_struct *kdamond;
>  	bool kdamond_stop;
>  	spinlock_t kdamond_lock;
> @@ -89,6 +94,8 @@ struct damon_ctx {
>  	void (*aggregate_cb)(struct damon_ctx *context);
>  };
>  
> +#define MAX_RFILE_PATH_LEN	256
> +
>  /* Get a random number in [l, r) */
>  #define damon_rand(ctx, l, r) (l + prandom_u32_state(&ctx->rndseed) % (r - l))
>  
> @@ -550,16 +557,81 @@ static bool kdamond_aggregate_interval_passed(struct damon_ctx *ctx)
>  }
>  
>  /*
> - * Reset the aggregated monitoring results
> + * Flush the content in the result buffer to the result file
> + */
> +static void damon_flush_rbuffer(struct damon_ctx *ctx)
> +{
> +	ssize_t sz;
> +	loff_t pos;
> +	struct file *rfile;
> +
> +	while (ctx->rbuf_offset) {
> +		pos = 0;
> +		rfile = filp_open(ctx->rfile_path, O_CREAT | O_RDWR | O_APPEND,
> +				0644);
> +		if (IS_ERR(rfile)) {
> +			pr_err("Cannot open the result file %s\n",
> +					ctx->rfile_path);
> +			return;
> +		}
> +
> +		sz = kernel_write(rfile, ctx->rbuf, ctx->rbuf_offset, &pos);
> +		filp_close(rfile, NULL);
> +
> +		ctx->rbuf_offset -= sz;
> +	}
> +}
> +
> +/*
> + * Write a data into the result buffer
> + */
> +static void damon_write_rbuf(struct damon_ctx *ctx, void *data, ssize_t size)
> +{
> +	if (!ctx->rbuf_len || !ctx->rbuf)
> +		return;
> +	if (ctx->rbuf_offset + size > ctx->rbuf_len)
> +		damon_flush_rbuffer(ctx);
> +
> +	memcpy(&ctx->rbuf[ctx->rbuf_offset], data, size);
> +	ctx->rbuf_offset += size;
> +}
> +
> +/*
> + * Flush the aggregated monitoring results to the result buffer
> + *
> + * Stores current tracking results to the result buffer and reset 'nr_accesses'
> + * of each regions.  The format for the result buffer is as below:
> + *
> + *   <time> <number of tasks> <array of task infos>
> + *
> + *   task info: <pid> <number of regions> <array of region infos>
> + *   region info: <start address> <end address> <nr_accesses>
>   */
>  static void kdamond_flush_aggregated(struct damon_ctx *c)
>  {
>  	struct damon_task *t;
> -	struct damon_region *r;
> +	struct timespec64 now;
> +	unsigned int nr;
> +
> +	ktime_get_coarse_ts64(&now);
> +
> +	damon_write_rbuf(c, &now, sizeof(struct timespec64));
> +	nr = nr_damon_tasks(c);
> +	damon_write_rbuf(c, &nr, sizeof(nr));
>  
>  	damon_for_each_task(c, t) {
> -		damon_for_each_region(r, t)
> +		struct damon_region *r;
> +
> +		damon_write_rbuf(c, &t->pid, sizeof(t->pid));
> +		nr = nr_damon_regions(t);
> +		damon_write_rbuf(c, &nr, sizeof(nr));
> +		damon_for_each_region(r, t) {
> +			damon_write_rbuf(c, &r->vm_start, sizeof(r->vm_start));
> +			damon_write_rbuf(c, &r->vm_end, sizeof(r->vm_end));
> +			damon_write_rbuf(c, &r->nr_accesses,
> +					sizeof(r->nr_accesses));
>  			r->nr_accesses = 0;
> +		}
>  	}
>  }
>  
> @@ -834,6 +906,7 @@ static int kdamond_fn(void *data)
>  
>  		usleep_range(ctx->sample_interval, ctx->sample_interval + 1);
>  	}
> +	damon_flush_rbuffer(ctx);
>  	damon_for_each_task(ctx, t) {
>  		damon_for_each_region_safe(r, next, t)
>  			damon_destroy_region(r);
> @@ -912,6 +985,53 @@ static int damon_set_pids(struct damon_ctx *ctx,
>  	return 0;
>  }
>  
> +/*
> + * Set attributes for the recording
> + *
> + * ctx		target kdamond context
> + * rbuf_len	length of the result buffer
> + * rfile_path	path to the monitor result files
> + *
> + * Setting 'rbuf_len' 0 disables recording.
> + *
> + * This function should not be called while the kdamond is running.
> + *
> + * Returns 0 on success, negative error code otherwise.
> + */
> +static int damon_set_recording(struct damon_ctx *ctx,
> +				unsigned int rbuf_len, char *rfile_path)
> +{
> +	size_t rfile_path_len;
> +
> +	if (rbuf_len > 4 * 1024 * 1024) {
> +		pr_err("too long (>%d) result buffer length\n",
> +				4 * 1024 * 1024);
> +		return -EINVAL;
> +	}
> +	rfile_path_len = strnlen(rfile_path, MAX_RFILE_PATH_LEN);
> +	if (rfile_path_len >= MAX_RFILE_PATH_LEN) {
> +		pr_err("too long (>%d) result file path %s\n",
> +				MAX_RFILE_PATH_LEN, rfile_path);
> +		return -EINVAL;
> +	}
> +	ctx->rbuf_len = rbuf_len;
> +	kfree(ctx->rbuf);
> +	kfree(ctx->rfile_path);
> +	ctx->rfile_path = NULL;
> +	if (!rbuf_len) {
> +		ctx->rbuf = NULL;
> +	} else {
> +		ctx->rbuf = kvmalloc(rbuf_len, GFP_KERNEL);
> +		if (!ctx->rbuf)
> +			return -ENOMEM;
> +	}
> +	ctx->rfile_path = kmalloc(rfile_path_len + 1, GFP_KERNEL);
> +	if (!ctx->rfile_path)
> +		return -ENOMEM;
> +	strncpy(ctx->rfile_path, rfile_path, rfile_path_len + 1);
> +	return 0;
> +}
> +
>  /*
>   * Set attributes for the monitoring
>   *


