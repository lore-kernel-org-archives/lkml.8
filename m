Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE038C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 14:03:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DA30207FB
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 14:03:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="HfkCYvgM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728978AbgESODA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 10:03:00 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:43849 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727057AbgESOC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 10:02:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1589896978; x=1621432978;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   mime-version;
  bh=AQl+dr9nZ3Mk+ejEyAqg6iIyzMLzrKoY1gkMdRpI11g=;
  b=HfkCYvgMk9cCvsvM4GV15pZxVhtmE+VszxlA8+7IjEvMnO2xWgqcjYIQ
   0Sx0i9dsWtrMA3UsrWcCVkTl5i3rw11ujQ1cE0JGFxRkJGhvW6eNh0+xN
   zNKkumQIMX3zzXIHYeVjsv5NFLauJuJstOidkqZ6NbBYOrtZJmUBs/KPQ
   0=;
IronPort-SDR: AGJKKvdzcGhHJPjMXj32XQsUiZNiP5za3svdJ3d3DXZHiZKSrwvPTLIVC7YMQy2zGQGyYcehA2
 ACS257MS1gAQ==
X-IronPort-AV: E=Sophos;i="5.73,410,1583193600"; 
   d="scan'208";a="44391322"
Received: from sea32-co-svc-lb4-vlan2.sea.corp.amazon.com (HELO email-inbound-relay-2a-e7be2041.us-west-2.amazon.com) ([10.47.23.34])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 19 May 2020 14:02:56 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-e7be2041.us-west-2.amazon.com (Postfix) with ESMTPS id 470D4A227C;
        Tue, 19 May 2020 14:02:54 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 19 May 2020 14:02:53 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.160.65) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 19 May 2020 14:02:38 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     SeongJae Park <sjpark@amazon.com>
CC:     <akpm@linux-foundation.org>, SeongJae Park <sjpark@amazon.de>,
        <Jonathan.Cameron@Huawei.com>, <aarcange@redhat.com>,
        <acme@kernel.org>, <alexander.shishkin@linux.intel.com>,
        <amit@kernel.org>, <benh@kernel.crashing.org>,
        <brendan.d.gregg@gmail.com>, <brendanhiggins@google.com>,
        <cai@lca.pw>, <colin.king@canonical.com>, <corbet@lwn.net>,
        <dwmw@amazon.com>, <irogers@google.com>, <jolsa@redhat.com>,
        <kirill@shutemov.name>, <mark.rutland@arm.com>, <mgorman@suse.de>,
        <minchan@kernel.org>, <mingo@redhat.com>, <namhyung@kernel.org>,
        <peterz@infradead.org>, <rdunlap@infradead.org>,
        <riel@surriel.com>, <rientjes@google.com>, <rostedt@goodmis.org>,
        <sblbir@amazon.com>, <shakeelb@google.com>, <shuah@kernel.org>,
        <sj38.park@gmail.com>, <snu@amazon.de>, <vbabka@suse.cz>,
        <vdavydov.dev@gmail.com>, <yang.shi@linux.alibaba.com>,
        <ying.huang@intel.com>, <linux-damon@amazon.com>,
        <linux-mm@kvack.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v12 10/16] mm/damon: Add debugfs interface
Date:   Tue, 19 May 2020 16:02:21 +0200
Message-ID: <20200519140221.4038-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200518100018.2293-11-sjpark@amazon.com> (raw)
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.65]
X-ClientProxiedBy: EX13D10UWA002.ant.amazon.com (10.43.160.228) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 May 2020 12:00:12 +0200 SeongJae Park <sjpark@amazon.com> wrote:

> From: SeongJae Park <sjpark@amazon.de>
> 
> This commit adds a debugfs interface for DAMON.
[...]
> diff --git a/mm/damon.c b/mm/damon.c
> index ddd78843f79a..f31310536c79 100644
> --- a/mm/damon.c
> +++ b/mm/damon.c
> @@ -10,6 +10,7 @@
>  #define pr_fmt(fmt) "damon: " fmt
>  
[...]
> +
> +static ssize_t damon_sprint_pids(struct damon_ctx *ctx, char *buf, ssize_t len)
> +{
> +	struct damon_task *t;
> +	int written = 0;
> +	int rc;
> +
> +	damon_for_each_task(t, ctx) {
> +		rc = snprintf(&buf[written], len - written, "%d ", t->pid);
> +		if (!rc)
> +			return -ENOMEM;
> +		written += rc;
> +	}
> +	if (written)
> +		written -= 1;
> +	written += snprintf(&buf[written], len - written, "\n");
> +	return written;
> +}
> +
> +static ssize_t debugfs_pids_read(struct file *file,
> +		char __user *buf, size_t count, loff_t *ppos)
> +{
> +	struct damon_ctx *ctx = &damon_user_ctx;
> +	ssize_t len;
> +	char pids_buf[320];
> +
> +	len = damon_sprint_pids(ctx, pids_buf, 320);

This could race with concurrent pids debugfs file writers.  Should be
synchronized.  Same to other debugfs files except 'monitor_on', which is
already synchronized with corresponding writers.

I will enclose this function call with the context mutex in next revision.


Thanks,
SeongJae Park

> +	if (len < 0)
> +		return len;
> +
> +	return simple_read_from_buffer(buf, count, ppos, pids_buf, len);
> +}
> +
> +/*
> + * Converts a string into an array of unsigned long integers
> + *
> + * Returns an array of unsigned long integers if the conversion success, or
> + * NULL otherwise.
> + */
> +static int *str_to_pids(const char *str, ssize_t len, ssize_t *nr_pids)
> +{
> +	int *pids;
> +	const int max_nr_pids = 32;
> +	int pid;
> +	int pos = 0, parsed, ret;
> +
> +	*nr_pids = 0;
> +	pids = kmalloc_array(max_nr_pids, sizeof(pid), GFP_KERNEL);
> +	if (!pids)
> +		return NULL;
> +	while (*nr_pids < max_nr_pids && pos < len) {
> +		ret = sscanf(&str[pos], "%d%n", &pid, &parsed);
> +		pos += parsed;
> +		if (ret != 1)
> +			break;
> +		pids[*nr_pids] = pid;
> +		*nr_pids += 1;
> +	}
> +	if (*nr_pids == 0) {
> +		kfree(pids);
> +		pids = NULL;
> +	}
> +
> +	return pids;
> +}
> +
> +static ssize_t debugfs_pids_write(struct file *file,
> +		const char __user *buf, size_t count, loff_t *ppos)
> +{
> +	struct damon_ctx *ctx = &damon_user_ctx;
> +	char *kbuf;
> +	int *targets;
> +	ssize_t nr_targets;
> +	ssize_t ret;
> +	int err;
> +
> +	kbuf = kmalloc(count, GFP_KERNEL);
> +	if (!kbuf)
> +		return -ENOMEM;
> +
> +	ret = simple_write_to_buffer(kbuf, count, ppos, buf, count);
> +	if (ret < 0)
> +		goto out;
> +
> +	targets = str_to_pids(kbuf, ret, &nr_targets);
> +	if (!targets) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +
> +	mutex_lock(&ctx->kdamond_lock);
> +	if (ctx->kdamond) {
> +		ret = -EINVAL;
> +		goto unlock_out;
> +	}
> +
> +	err = damon_set_pids(ctx, targets, nr_targets);
> +	if (err)
> +		ret = err;
> +unlock_out:
> +	mutex_unlock(&ctx->kdamond_lock);
> +	kfree(targets);
> +out:
> +	kfree(kbuf);
> +	return ret;
> +}
[...]
