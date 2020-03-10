Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9455AC3F2D0
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 11:57:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61D2B24680
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 11:57:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="URxqH2rc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbgCJL5o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 07:57:44 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:9863 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbgCJL5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 07:57:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1583841463; x=1615377463;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   mime-version;
  bh=rvUgQi1RSZnWOcD+bSfiTnhYnySdlegrosLEYC9fUUY=;
  b=URxqH2rcfDy+1gRXUAss3vPLhWWML/mnepy1CrjZsRFrcwGmppQvzaFW
   rikLAhDbs9CsLoBxa04SfAauQMJ2bzlJ06MASWe/2h81QoN7uUAVaqnLH
   kY6Ul8X/rceHPxXaZeIMdPdoaZdTEE5E0JckVHuzPEHwfVOxQDnXdMUeN
   U=;
IronPort-SDR: 5nYFytLj2UvIzlSxHw1B4kO6bi6VWzxV80E6jVROjexrYtyj8ba+izZcDxMFVExK0r6c4Ry5zL
 NqiPIMkT3hmw==
X-IronPort-AV: E=Sophos;i="5.70,536,1574121600"; 
   d="scan'208";a="20395339"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1e-c7c08562.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 10 Mar 2020 11:57:31 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1e-c7c08562.us-east-1.amazon.com (Postfix) with ESMTPS id 407B72447AC;
        Tue, 10 Mar 2020 11:57:20 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Tue, 10 Mar 2020 11:57:20 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.161.152) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 10 Mar 2020 11:57:08 +0000
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
Subject: Re: Re: [PATCH v6 08/14] mm/damon: Add debugfs interface
Date:   Tue, 10 Mar 2020 12:56:54 +0100
Message-ID: <20200310115654.24999-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200310090209.00000d6b@Huawei.com> (raw)
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.152]
X-ClientProxiedBy: EX13D02UWB002.ant.amazon.com (10.43.161.160) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Mar 2020 09:02:09 +0000 Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> On Mon, 24 Feb 2020 13:30:41 +0100
> SeongJae Park <sjpark@amazon.com> wrote:
> 
> > From: SeongJae Park <sjpark@amazon.de>
> > 
> > This commit adds a debugfs interface for DAMON.
[...]
> > 
> > Signed-off-by: SeongJae Park <sjpark@amazon.de>
> 
> Some of the code in here seems a bit fragile and convoluted.

Indeed, it needs many fixes.

> 
> > ---
> >  mm/damon.c | 377 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 376 insertions(+), 1 deletion(-)
> > 
> > diff --git a/mm/damon.c b/mm/damon.c
> > index b3e9b9da5720..facb1d7f121b 100644
> > --- a/mm/damon.c
> > +++ b/mm/damon.c
> > @@ -10,6 +10,7 @@
[...]
> >  
> > +/*
> > + * debugfs functions
> 
> Seems unnecessary when their naming makes this clear.

Agreed, will remove it.

> 
[...]
> > +static ssize_t debugfs_pids_write(struct file *file,
> > +		const char __user *buf, size_t count, loff_t *ppos)
> > +{
> > +	struct damon_ctx *ctx = &damon_user_ctx;
> > +	char *kbuf;
> > +	unsigned long *targets;
> > +	ssize_t nr_targets;
> > +	ssize_t ret;
> > +
> > +	kbuf = kmalloc_array(count, sizeof(char), GFP_KERNEL);
> > +	if (!kbuf)
> > +		return -ENOMEM;
> > +
> > +	ret = simple_write_to_buffer(kbuf, 512, ppos, buf, count);
> 
> Why only 512?

I might lost my mind at that time :'(
Good catch, it should be 'count'.

> 
[...]
> > +
> > +static ssize_t debugfs_attrs_write(struct file *file,
> > +		const char __user *buf, size_t count, loff_t *ppos)
> > +{
> > +	struct damon_ctx *ctx = &damon_user_ctx;
> > +	unsigned long s, a, r, minr, maxr;
> > +	char *kbuf;
> > +	ssize_t ret;
> > +
> > +	kbuf = kmalloc_array(count, sizeof(char), GFP_KERNEL);
> 
> malloc fine for array of characters.   The checks on overflow etc cannot be
> relevant here.

You're right, will use 'kamlloc()' instead.

> 
> > +	if (!kbuf)
> > +		return -ENOMEM;
> > +
> > +	ret = simple_write_to_buffer(kbuf, count, ppos, buf, count);
> > +	if (ret < 0)
> > +		goto out;
> > +
> > +	if (sscanf(kbuf, "%lu %lu %lu %lu %lu",
> > +				&s, &a, &r, &minr, &maxr) != 5) {
> > +		ret = -EINVAL;
> > +		goto out;
> > +	}
> > +
> > +	spin_lock(&ctx->kdamond_lock);
> > +	if (ctx->kdamond)
> > +		goto monitor_running;
> > +
> > +	damon_set_attrs(ctx, s, a, r, minr, maxr);
> > +	spin_unlock(&ctx->kdamond_lock);
> > +
> > +	goto out;
> > +
> > +monitor_running:
> > +	spin_unlock(&ctx->kdamond_lock);
> > +	pr_err("%s: kdamond is running. Turn it off first.\n", __func__);
> > +	ret = -EINVAL;
> 
> This complex exit path is a bad idea from maintainability point of view...
> Just put the pr_err and spin_unlock in the error path above.

Agreed, will do so.

> 
> > +out:
> > +	kfree(kbuf);
> > +	return ret;
> > +}
> > +
> > +static const struct file_operations monitor_on_fops = {
> > +	.owner = THIS_MODULE,
> > +	.read = debugfs_monitor_on_read,
> > +	.write = debugfs_monitor_on_write,
> > +};
> > +
> > +static const struct file_operations pids_fops = {
> > +	.owner = THIS_MODULE,
> > +	.read = debugfs_pids_read,
> > +	.write = debugfs_pids_write,
> > +};
> > +
> > +static const struct file_operations record_fops = {
> > +	.owner = THIS_MODULE,
> > +	.read = debugfs_record_read,
> > +	.write = debugfs_record_write,
> > +};
> > +
> > +static const struct file_operations attrs_fops = {
> > +	.owner = THIS_MODULE,
> > +	.read = debugfs_attrs_read,
> > +	.write = debugfs_attrs_write,
> > +};
> > +
> > +static struct dentry *debugfs_root;
> > +
> > +static int __init debugfs_init(void)
> 
> Prefix this function.  Chances of sometime getting a header
> that includes debugfs_init feels rather too high!

That's right, I will rename it.

> 
> > +{
> > +	const char * const file_names[] = {"attrs", "record",
> > +		"pids", "monitor_on"};
> > +	const struct file_operations *fops[] = {&attrs_fops, &record_fops,
> > +		&pids_fops, &monitor_on_fops};
> > +	int i;
> > +
> > +	debugfs_root = debugfs_create_dir("damon", NULL);
> > +	if (!debugfs_root) {
> > +		pr_err("failed to create the debugfs dir\n");
> > +		return -ENOMEM;
> > +	}
> > +
> > +	for (i = 0; i < ARRAY_SIZE(file_names); i++) {
> > +		if (!debugfs_create_file(file_names[i], 0600, debugfs_root,
> > +					NULL, fops[i])) {
> > +			pr_err("failed to create %s file\n", file_names[i]);
> > +			return -ENOMEM;
> > +		}
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int __init damon_init_user_ctx(void)
> > +{
> > +	int rc;
> > +
> > +	struct damon_ctx *ctx = &damon_user_ctx;
> > +
> > +	ktime_get_coarse_ts64(&ctx->last_aggregation);
> > +	ctx->last_regions_update = ctx->last_aggregation;
> > +
> > +	ctx->rbuf_offset = 0;
> > +	rc = damon_set_recording(ctx, 1024 * 1024, "/damon.data");
> > +	if (rc)
> > +		return rc;
> > +
> > +	ctx->kdamond = NULL;
> > +	ctx->kdamond_stop = false;
> > +	spin_lock_init(&ctx->kdamond_lock);
> > +
> > +	prandom_seed_state(&ctx->rndseed, 42);
> 
> :)

You got the answer ;)

> 
> > +	INIT_LIST_HEAD(&ctx->tasks_list);
> > +
> > +	ctx->sample_cb = NULL;
> > +	ctx->aggregate_cb = NULL;
> 
> Should already be set to 0.

Oops, right!

> 
> > +
> > +	return 0;
> > +}
> > +
> >  static int __init damon_init(void)
> >  {
> > +	int rc;
> > +
> >  	pr_info("init\n");
> >  
> > -	return 0;
> > +	rc = damon_init_user_ctx();
> > +	if (rc)
> > +		return rc;
> > +
> > +	return debugfs_init();
> 
> In theory no code should ever be dependent on debugfs succeeding..
> There might be other daemon users so you should just eat the return
> code.

Right!  Thank you for catching this!


Thanks,
SeongJae Park

> 
> 
> >  }
> >  
> >  static void __exit damon_exit(void)
> >  {
> > +	damon_turn_kdamond(&damon_user_ctx, false);
> > +	debugfs_remove_recursive(debugfs_root);
> > +
> > +	kfree(damon_user_ctx.rbuf);
> > +	kfree(damon_user_ctx.rfile_path);
> > +
> >  	pr_info("exit\n");
> >  }
> >  
> 
