Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17963C3F2D1
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 09:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D62BA2469F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 09:46:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QrtA3kDp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbgB1Jqd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 04:46:33 -0500
Received: from merlin.infradead.org ([205.233.59.134]:37510 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726413AbgB1Jqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 04:46:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WELOIkFCb7XQpb6aApmicRMS2C5BbtqNYoR+RZ2JyvQ=; b=QrtA3kDpmRV3k1jtMytqSfXUVK
        R/5XGfUL7TyzV2er04uDplMjeLtcuKuAgSZaYFqGL2H4SUvTtmZh8sDjE7ZrD4S8NJsHa6JJCuMd8
        bFSwvpCvkqNOFEEcYeL5VbYx66UDHp3gOcXtuP93I2koJ418csKtTHVZBt7/e+SOA+axxt8pS3sDs
        RBx5QoYPMYJ7iRzDvOA2qRIvwxY7o3PCDvu283nrgE3PFbfo/OnI1Z6WFoOgZiOkhu9t2Fk3lHIZy
        ynYCIsdD167vozBAmbGuGF59McYnVogcdMjfjVSabEa7WrKtL9qmKOcCYDPZBtNnMRbCDgUrXDNuN
        5idq1ygg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j7cDz-0000zO-Qo; Fri, 28 Feb 2020 09:46:28 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id EE3E6300478;
        Fri, 28 Feb 2020 10:44:29 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3C08E2B9DC304; Fri, 28 Feb 2020 10:46:26 +0100 (CET)
Date:   Fri, 28 Feb 2020 10:46:26 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v10] perf: Sharing PMU counters across compatible events
Message-ID: <20200228094626.GN14946@hirez.programming.kicks-ass.net>
References: <20200123083127.446105-1-songliubraving@fb.com>
 <20200228093604.GH18400@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200228093604.GH18400@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 28, 2020 at 10:36:04AM +0100, Peter Zijlstra wrote:
> +
> +		/*
> +		 * Flip an active event to a new master; this is tricky because
> +		 * for an active event event_pmu_read() can be called at any
> +		 * time from NMI context.
> +		 *
> +		 * This means we need to have ->dup_master and
> +		 * ->dup_count consistent at all times. Of course we cannot do
> +		 * two writes at once :/
> +		 *
> +		 * Instead, flip ->dup_master to EVENT_TOMBSTONE, this will
> +		 * make event_pmu_read_dup() NOP. Then we can set
> +		 * ->dup_count and finally set ->dup_master to the new_master
> +		 * to let event_pmu_read_dup() rip.
> +		 */
> +		WRITE_ONCE(tmp->dup_master, EVENT_TOMBSTONE);
> +		barrier();
> +
> +		count = local64_read(&new_master->count);
> +		local64_set(&tmp->dup_count, count);
> +
> +		if (tmp == new_master)
> +			local64_set(&tmp->master_count, count);
> +
> +		barrier();
> +		WRITE_ONCE(tmp->dup_master, new_master);
>  		dup_count++;

> @@ -4453,12 +4484,14 @@ static void __perf_event_read(void *info
>  
>  static inline u64 perf_event_count(struct perf_event *event)
>  {
> -	if (event->dup_master == event) {
> -		return local64_read(&event->master_count) +
> -			atomic64_read(&event->master_child_count);
> -	}
> +	u64 count;
>  
> -	return local64_read(&event->count) + atomic64_read(&event->child_count);
> +	if (likely(event->dup_master != event))
> +		count = local64_read(&event->count);
> +	else
> +		count = local64_read(&event->master_count);
> +
> +	return count + atomic64_read(&event->child_count);
>  }
>  
>  /*

One thing that I've failed to mention so far (but has sorta been implied
if you thought carefully) is that ->dup_master and ->master_count also
need to be consistent at all times. Even !ACTIVE events can have
perf_event_count() called on them.

Worse; I just realize that perf_event_count() is called remotely, so we
need SMP ordering between reading ->dup_master and ->master_count
*groan*....
