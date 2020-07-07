Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FF09C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 07:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76A3B20578
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 07:55:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="DlxxICUi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728299AbgGGHzl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 03:55:41 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:52640 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbgGGHzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 03:55:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1594108541; x=1625644541;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   mime-version;
  bh=lWXuOgdJzu7ZoftoY9ZfH+vhGyJSift1pumj8qTxMo8=;
  b=DlxxICUiS8asEbruiwPBK4ySfU2laqcE9rrvycGVPEFf98HxFPjTmpB5
   rgx8ih22jbHxat3oyj8SCxab7h6/+wbOmKxGgfUQ44nOyH1JYnvRQpL7X
   MKANeQphNFTH4Z+kysYv9CwjWJX46XTsBeRRJD1Ro/cgkwpdDsQB1mOqr
   Q=;
IronPort-SDR: IRl/32Dz3awjBrVXq3qQicAFvbbUbIPc/2bInKiQD/AYMiP27bWFxDIKfZCO3j/XBdtirzY2mj
 NwOQWyh5i2Gw==
X-IronPort-AV: E=Sophos;i="5.75,323,1589241600"; 
   d="scan'208";a="57882562"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1d-9ec21598.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 07 Jul 2020 07:55:35 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1d-9ec21598.us-east-1.amazon.com (Postfix) with ESMTPS id D4EDBA19EB;
        Tue,  7 Jul 2020 07:55:23 +0000 (UTC)
Received: from EX13D31EUA004.ant.amazon.com (10.43.165.161) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 7 Jul 2020 07:55:22 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.161.34) by
 EX13D31EUA004.ant.amazon.com (10.43.165.161) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 7 Jul 2020 07:55:06 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     SeongJae Park <sjpark@amazon.com>
CC:     <akpm@linux-foundation.org>, SeongJae Park <sjpark@amazon.de>,
        <Jonathan.Cameron@Huawei.com>, <aarcange@redhat.com>,
        <acme@kernel.org>, <alexander.shishkin@linux.intel.com>,
        <amit@kernel.org>, <benh@kernel.crashing.org>,
        <brendan.d.gregg@gmail.com>, <brendanhiggins@google.com>,
        <cai@lca.pw>, <colin.king@canonical.com>, <corbet@lwn.net>,
        <dwmw@amazon.com>, <foersleo@amazon.de>, <irogers@google.com>,
        <jolsa@redhat.com>, <kirill@shutemov.name>, <mark.rutland@arm.com>,
        <mgorman@suse.de>, <minchan@kernel.org>, <mingo@redhat.com>,
        <namhyung@kernel.org>, <peterz@infradead.org>,
        <rdunlap@infradead.org>, <riel@surriel.com>, <rientjes@google.com>,
        <rostedt@goodmis.org>, <sblbir@amazon.com>, <shakeelb@google.com>,
        <shuah@kernel.org>, <sj38.park@gmail.com>, <snu@amazon.de>,
        <vbabka@suse.cz>, <vdavydov.dev@gmail.com>,
        <yang.shi@linux.alibaba.com>, <ying.huang@intel.com>,
        <david@redhat.com>, <linux-damon@amazon.com>, <linux-mm@kvack.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v17 03/15] mm/damon: Implement region based sampling
Date:   Tue, 7 Jul 2020 09:54:51 +0200
Message-ID: <20200707075451.24606-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200706115322.29598-4-sjpark@amazon.com> (raw)
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.34]
X-ClientProxiedBy: EX13D40UWA003.ant.amazon.com (10.43.160.29) To
 EX13D31EUA004.ant.amazon.com (10.43.165.161)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Jul 2020 13:53:10 +0200 SeongJae Park <sjpark@amazon.com> wrote:

> From: SeongJae Park <sjpark@amazon.de>
> 
> This commit implements DAMON's target address space independent high
> level logics for basic access check and region based sampling.  This
> doesn't work alone, but needs the target address space specific low
> level pritimives implementation for the monitoring target address ranges
> construction and the access check, though.  A reference implementation
> of those will be provided by a later commit.  Nevertheless, users can
> implement and use their own versions for their specific use cases.
>
[...]
> +/**
> + * damon_start() - Starts monitoring with given context.
> + * @ctx:	monitoring context
> + *
> + * Return: 0 on success, negative error code otherwise.
> + */
> +int damon_start(struct damon_ctx *ctx)
> +{
> +	int err = -EBUSY;
> +
> +	mutex_lock(&ctx->kdamond_lock);
> +	if (!ctx->kdamond) {
> +		err = 0;
> +		ctx->kdamond_stop = false;
> +		ctx->kdamond = kthread_run(kdamond_fn, ctx, "kdamond");

Oops, this means 'kdamond_fn' could see the unset '->kdamond'.  I will use
'kthread_create()' and 'wake_up_process()' in the next spin.

> +		if (IS_ERR(ctx->kdamond))
> +			err = PTR_ERR(ctx->kdamond);
> +	}
> +	mutex_unlock(&ctx->kdamond_lock);
> +
> +	return err;
> +}

So, the change would be something like below:

--- a/mm/damon.c
+++ b/mm/damon.c
@@ -1464,9 +1464,11 @@ int damon_start(struct damon_ctx *ctx)
        if (!ctx->kdamond) {
                err = 0;
                ctx->kdamond_stop = false;
-               ctx->kdamond = kthread_run(kdamond_fn, ctx, "kdamond");
+               ctx->kdamond = kthread_create(kdamond_fn, ctx, "kdamond");
                if (IS_ERR(ctx->kdamond))
                        err = PTR_ERR(ctx->kdamond);
+               else
+                       wake_up_process(ctx->kdamond);
        }
        mutex_unlock(&ctx->kdamond_lock);


Thanks,
SeongJae Park
