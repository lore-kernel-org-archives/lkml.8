Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F02DC433E4
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 09:30:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01ACD20639
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 09:30:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="t98AOgt6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbgHNJa4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 05:30:56 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:50486 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbgHNJaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 05:30:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1597397454; x=1628933454;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   mime-version;
  bh=DWYiNSJcpNwDZKN5Kuj5dAFDPbsEqJda5Km3YKwIhpI=;
  b=t98AOgt6QMfYp/X6McJc1Y4IdfZBXp1kb7MBYq7phWEzqEhHd2TGRA4h
   qgW5hrTjG0HW0vF/HOLsaXWnXxailjPl3s42UsYXk6GiJfV1555RfL3SH
   /PIBTLBlUCVGEVXo2P4Hp2k20NlYRHrvkV2pnGjHxiSxFnyAuAJAjqKk4
   o=;
X-IronPort-AV: E=Sophos;i="5.76,311,1592870400"; 
   d="scan'208";a="47821021"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2a-f14f4a47.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 14 Aug 2020 09:30:49 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-f14f4a47.us-west-2.amazon.com (Postfix) with ESMTPS id DA2DCA277C;
        Fri, 14 Aug 2020 09:30:46 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 14 Aug 2020 09:30:33 +0000
Received: from u3f2cd687b01c55.ant.amazon.com (10.43.161.34) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 14 Aug 2020 09:30:12 +0000
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
Subject: Re: [PATCH v19 02/15] mm/damon: Implement region based sampling
Date:   Fri, 14 Aug 2020 11:29:51 +0200
Message-ID: <20200814092951.13988-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200804091416.31039-3-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.34]
X-ClientProxiedBy: EX13D35UWC004.ant.amazon.com (10.43.162.180) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Aug 2020 11:14:03 +0200 SeongJae Park <sjpark@amazon.com> wrote:

> From: SeongJae Park <sjpark@amazon.de>
> 
> DAMON separates its monitoring target address space independent high
> level logics from the target space dependent low level primitives for
> flexible support of various address spaces.
> 
> This commit implements DAMON's target address space independent high
> level logics for basic access check and region based sampling.  Hence,
> without the target address space specific parts implementations, this
> doesn't work alone.  A reference implementation of those will be
> provided by a later commit.
[...]
> Signed-off-by: SeongJae Park <sjpark@amazon.de>
> Reviewed-by: Leonard Foerster <foersleo@amazon.de>
> ---
>  include/linux/damon.h |  89 ++++++++++++++-
>  mm/damon.c            | 256 +++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 342 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/damon.h b/include/linux/damon.h
> index a6e839a236f4..0b1153971e6d 100644
> --- a/include/linux/damon.h
> +++ b/include/linux/damon.h
> @@ -11,6 +11,8 @@
>  #define _DAMON_H_
>  
>  #include <linux/random.h>
> +#include <linux/mutex.h>
> +#include <linux/time64.h>
>  #include <linux/types.h>
>  
>  /**
> @@ -56,11 +58,96 @@ struct damon_target {
>  };
>  
>  /**
> - * struct damon_ctx - Represents a context for each monitoring.
> + * struct damon_ctx - Represents a context for each monitoring.  This is the
> + * main interface that allows users to set the attributes and get the results
> + * of the monitoring.
> + *
> + * @sample_interval:		The time between access samplings.
> + * @aggr_interval:		The time between monitor results aggregations.
> + * @nr_regions:			The number of monitoring regions.
> + *
> + * For each @sample_interval, DAMON checks whether each region is accessed or
> + * not.  It aggregates and keeps the access information (number of accesses to
> + * each region) for @aggr_interval time.  All time intervals are in
> + * micro-seconds.
> + *
> + * @kdamond:		Kernel thread who does the monitoring.
> + * @kdamond_stop:	Notifies whether kdamond should stop.
> + * @kdamond_lock:	Mutex for the synchronizations with @kdamond.
> + *
> + * For each monitoring request (damon_start()), a kernel thread for the
> + * monitoring is created.  The pointer to the thread is stored in @kdamond.

This means that multiple monitoring threads can concurrently run.  This is an
intended design to let users utilize multiple CPUs.  For example, let's suppose
the user need super high accuracy of the monitoring results which require
multiple CPU power.  If use of the multiple CPUs are allowed, the user can
split the monitoring target regions into multiple contexts and call
'damon_start()' for each of the context.

If multiple monitoring threads has conflicting target regions, they will
interfere each other.  Currently, avoidance of such conflict should be done by
'damon_start()' users.  The synchronization would be complicated.

To make the situation simple, I will make the 'damon_start()' receive a group
of 'damon_ctx' objects and creates a group of monitoring threads for the
objects at once.  This will only reduce number of 'damon_start()' calls
required to run multiple monitoring threads.  In addition to this, the groups
of monitoring threads will be mutual exclusive.  In other words,
'damon_start()' will fail if a group of monitoring threads that started by
other 'damon_start()' call is currently running.

This still ask the users to protect each monitoring threads by taking care in
their requests.  But, because the requests are made by the user on its own,
avoiding the conflict will be quite easy.  Further, intentional conflict is
also possible, though I'm unsure how the intentional conflict can be required.

The change will be made in the next spin.


Thanks,
SeongJae Park

[...]
