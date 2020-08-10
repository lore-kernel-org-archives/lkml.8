Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 863C7C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 07:42:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 611D020678
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 07:42:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="gKB1xCO0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726529AbgHJHme (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 03:42:34 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:59683 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbgHJHmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 03:42:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1597045352; x=1628581352;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   mime-version;
  bh=q/p0Bl4Vk/aMQV5R0RuRd9iNljPfuhyjU+deoaPgFus=;
  b=gKB1xCO0uTgxFaHqRZfk0e76ef72kHjA/tsgAwhrRbRwrfPxLe5y2yvP
   IUgLXKABJF2WYtfd9Ep2wbjzKwTMi1/jYYU0LDmZdlFf0lZF1DSltTX1j
   j0yGVEPlfcu8fLi25qRO81nUDNBbxwUCAoJXecn9UPKP8N4qH29mR7hCu
   w=;
IronPort-SDR: Isl8z6UY0KpLTxS6jF5n1NSDuiRTpqJiDuBKR7FLfaxRKrl5b2afXK6vOVniDTuhyKJ6ahvX9v
 y24PXynPyJGA==
X-IronPort-AV: E=Sophos;i="5.75,456,1589241600"; 
   d="scan'208";a="66744338"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1a-821c648d.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 10 Aug 2020 07:42:26 +0000
Received: from EX13MTAUEB002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1a-821c648d.us-east-1.amazon.com (Postfix) with ESMTPS id B4329A1D54;
        Mon, 10 Aug 2020 07:42:14 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEB002.ant.amazon.com (10.43.60.12) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 10 Aug 2020 07:42:13 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.160.192) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 10 Aug 2020 07:41:57 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     SeongJae Park <sjpark@amazon.com>
CC:     <akpm@linux-foundation.org>, <Jonathan.Cameron@Huawei.com>,
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
        <linux-damon@amazon.com>, <linux-mm@kvack.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v19 09/15] mm/damon: Implement a debugfs interface
Date:   Mon, 10 Aug 2020 09:41:43 +0200
Message-ID: <20200810074143.26863-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200804091416.31039-10-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.192]
X-ClientProxiedBy: EX13D46UWB002.ant.amazon.com (10.43.161.70) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Aug 2020 11:14:10 +0200 SeongJae Park <sjpark@amazon.com> wrote:

> From: SeongJae Park <sjpark@amazon.de>
> 
> This commit implements a debugfs interface for DAMON.  It works for the
> virtual address spaces monitoring.
[...]
> +
> +#define targetid_is_pid(ctx)	\
> +	(ctx->target_valid == kdamond_vm_target_valid)
> +
[...]
> +
> +static ssize_t debugfs_target_ids_write(struct file *file,
> +		const char __user *buf, size_t count, loff_t *ppos)
> +{
> +	struct damon_ctx *ctx = &damon_user_ctx;
> +	char *kbuf;
> +	unsigned long *targets;
> +	ssize_t nr_targets;
> +	ssize_t ret = count;
> +	struct damon_target *target;
> +	int i;
> +	int err;
> +
> +	kbuf = user_input_str(buf, count, ppos);
> +	if (IS_ERR(kbuf))
> +		return PTR_ERR(kbuf);
> +
> +	targets = str_to_target_ids(kbuf, ret, &nr_targets);
> +	if (!targets) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +
> +	if (targetid_is_pid(ctx)) {
> +		for (i = 0; i < nr_targets; i++)
> +			targets[i] = (unsigned long)find_get_pid(
> +					(int)targets[i]);
> +	}
> +
> +	mutex_lock(&ctx->kdamond_lock);
> +	if (ctx->kdamond) {
> +		ret = -EINVAL;
> +		goto unlock_out;
> +	}
> +
> +	if (targetid_is_pid(ctx)) {
> +		damon_for_each_target(target, ctx)
> +			put_pid((struct pid *)target->id);

If non-pid target ids were set before by the kernel API, this will cause a
problem.  Therefore, the DAMON users should cleanup there target ids properly.
However, I found that this could be easily missed.  Indeed, my new test code
missed the cleanup.  Moreover, it would be hard to do that when concurrent
DAMON users exist.

One straightforward fix would be making 'damon_set_targets()' to remember last
target id type and do 'put_pid()' if the last target id type was pid, instead
of here.  This will work, but make the address space independent part to be
coupled with the dependent part.

Or, we could add another callback for cleanup and let debugfs code to register
a function doing 'put_pid()' and remove of the targets as the callback.  This
approach will allow the address space independent part to be remain
independent.

I will fix this problem with the second approach in the next spin.


Thanks,
SeongJae Park
