Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B06C433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 11:18:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 716B1207D5
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 11:18:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="t3AEgxuD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727916AbgFDLSu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 07:18:50 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:42537 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbgFDLSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 07:18:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1591269529; x=1622805529;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   mime-version;
  bh=Qil4CHTe9zc+4qSWiwfHINBzR6yECNz+NaYOle+YSdE=;
  b=t3AEgxuDms8WwFRf4q+9WMN6S+xA0vXQJrBV3CJajjFpICkRdClqIQCU
   WcCjNWfpucWBhghoigUSpM3azQETuvDA2eExadOdyIsglCx8ZaLJtoKcD
   /p5gtrsdNf9A1QoEA0aLw6+EKlHj6fpaIvq7BjWJMROLIyFl/aKE9NYJf
   s=;
IronPort-SDR: 1V684L6BWiC3yvDiZT0UEWaWau9eDZ9TCdD43ZQNpdVhQb/dZZ31ltqHFAwFDK3kTgp7NAAy+l
 IXlqRIBf2HVw==
X-IronPort-AV: E=Sophos;i="5.73,472,1583193600"; 
   d="scan'208";a="49788679"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1d-9ec21598.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 04 Jun 2020 11:18:44 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1d-9ec21598.us-east-1.amazon.com (Postfix) with ESMTPS id 622C2A3941;
        Thu,  4 Jun 2020 11:18:33 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 4 Jun 2020 11:18:32 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.161.34) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 4 Jun 2020 11:18:16 +0000
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
Subject: Re: [RFC v9 4/8] mm/damon/schemes: Implement a debugfs interface
Date:   Thu, 4 Jun 2020 13:17:57 +0200
Message-ID: <20200604111757.7659-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200526075702.27339-5-sjpark@amazon.com> (raw)
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.34]
X-ClientProxiedBy: EX13D19UWC001.ant.amazon.com (10.43.162.64) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 May 2020 09:56:58 +0200 SeongJae Park <sjpark@amazon.com> wrote:

> From: SeongJae Park <sjpark@amazon.de>
> 
> This commit implements a debugfs interface for the data access
> monitoring oriented memory management schemes.  It is supposed to be
> used by administrators and/or privileged user space programs.  Users can
> read and update the rules using ``<debugfs>/damon/schemes`` file.  The
> format is::
> 
>     <min/max size> <min/max access frequency> <min/max age> <action>
> 
> Signed-off-by: SeongJae Park <sjpark@amazon.de>
> ---
>  mm/damon.c | 176 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 174 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/damon.c b/mm/damon.c
> index 6a07649d1f5d..bcc732e8735c 100644
> --- a/mm/damon.c
> +++ b/mm/damon.c
> @@ -173,6 +173,29 @@ static void damon_destroy_task(struct damon_task *t)
>  	damon_free_task(t);
>  }
> +
> +/*
> + * Converts a string into an array of struct damos pointers
> + *
> + * Returns an array of struct damos pointers that converted if the conversion
> + * success, or NULL otherwise.
> + */
> +static struct damos **str_to_schemes(const char *str, ssize_t len,
> +				ssize_t *nr_schemes)
> +{
> +	struct damos *scheme, **schemes;
> +	const int max_nr_schemes = 256;
> +	int pos = 0, parsed, ret;
> +	unsigned int min_sz, max_sz, min_nr_a, max_nr_a, min_age, max_age;
> +	unsigned int action;
> +
> +	schemes = kmalloc_array(max_nr_schemes, sizeof(scheme),
> +			GFP_KERNEL);
> +	if (!schemes)
> +		return NULL;
> +
> +	*nr_schemes = 0;
> +	while (pos < len && *nr_schemes < max_nr_schemes) {
> +		ret = sscanf(&str[pos], "%u %u %u %u %u %u %u%n",
> +				&min_sz, &max_sz, &min_nr_a, &max_nr_a,
> +				&min_age, &max_age, &action, &parsed);
> +		if (ret != 7)
> +			break;
> +		if (action >= DAMOS_ACTION_LEN) {
> +			pr_err("wrong action %d\n", action);
> +			goto fail;
> +		}
> +
> +		pos += parsed;
> +		scheme = damon_new_scheme(min_sz, max_sz, min_nr_a, max_nr_a,
> +				min_age, max_age, action);
> +		if (!scheme)
> +			goto fail;
> +
> +		schemes[*nr_schemes] = scheme;
> +		*nr_schemes += 1;
> +	}
> +	if (!*nr_schemes)
> +		goto fail;
> +	return schemes;
> +fail:
> +	free_schemes_arr(schemes, *nr_schemes);
> +	return NULL;
> +}
> +
> +static ssize_t debugfs_schemes_write(struct file *file, const char __user *buf,
> +		size_t count, loff_t *ppos)
> +{
> +	struct damon_ctx *ctx = &damon_user_ctx;
> +	char *kbuf;
> +	struct damos **schemes;
> +	ssize_t nr_schemes = 0, ret;
> +	int err;
> +
> +	if (*ppos)
> +		return -EINVAL;
> +
> +	kbuf = kmalloc(count, GFP_KERNEL);
> +	if (!kbuf)
> +		return -ENOMEM;
> +
> +	ret = simple_write_to_buffer(kbuf, count, ppos, buf, count);
> +	if (ret < 0)
> +		goto out;
> +
> +	schemes = str_to_schemes(kbuf, ret, &nr_schemes);

In case of wrong input, 'str_to_schemes()' could return NULL with non-zero
nr_schemes, but the case is not handled here.  I will properly handle the case
in the next spin.


Thanks,
SeongJae Park

> +
> +	mutex_lock(&ctx->kdamond_lock);
> +	if (ctx->kdamond) {
> +		ret = -EBUSY;
> +		goto unlock_out;
> +	}
> +
> +	err = damon_set_schemes(ctx, schemes, nr_schemes);
> +	if (err)
> +		ret = err;
> +	else
> +		nr_schemes = 0;
> +unlock_out:
> +	mutex_unlock(&ctx->kdamond_lock);
> +	free_schemes_arr(schemes, nr_schemes);
> +out:
> +	kfree(kbuf);
> +	return ret;
> +}
> +
