Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B728C2D0CE
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:16:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 507902071A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:16:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ktJyqCX5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730103AbgAXJQJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 04:16:09 -0500
Received: from merlin.infradead.org ([205.233.59.134]:39998 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729384AbgAXJQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 04:16:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=hmixrUXurqOegKNhzF9h4CdZ3dMfH0LOWEyJXzMjgjo=; b=ktJyqCX5GLB6FKAUL/9nirdsj
        qztnJToZqMYplKB5b94b5BVmWplOxoxCW39NC8wNC+MeS6bmkzzQWQQ0RQZ5OTQcRxEHx1y0YZ4na
        tgk5wsycMLzp0OwcB/JKd8vWOA62Axk2UBwOQZJk+hzyq/NsP65vYQFQWmcnvfjvzCrAl+iILNJ/F
        ZJwzD3wf0/sc1SzRm0kgCgJFbKQC3iM8eKyN5CweoKY0eBQ20rczMvDoiGqjnoqvxj+Z12OcRWuzY
        WGpr1iE2Ne45kfRE7FAkfq1R8ZE7OtXxHT/VcYWcxnwTmxHNz6Vl1iz6HcCfUoUcm7LKIbPQx02eu
        s1EqYTmOw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iuv4G-0002ZI-Ah; Fri, 24 Jan 2020 09:15:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 63336300677;
        Fri, 24 Jan 2020 10:14:12 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D5C7B2B715B6B; Fri, 24 Jan 2020 10:15:52 +0100 (CET)
Date:   Fri, 24 Jan 2020 10:15:52 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Andi Kleen <andi@firstfloor.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2] perf/core: install cgroup events to correct cpuctx
Message-ID: <20200124091552.GB14914@hirez.programming.kicks-ass.net>
References: <20200122195027.2112449-1-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200122195027.2112449-1-songliubraving@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 22, 2020 at 11:50:27AM -0800, Song Liu wrote:
> cgroup events are always installed in the cpuctx. However, when it is not
> installed via IPI, list_update_cgroup_event() adds it to cpuctx of current
> CPU, which triggers the following with CONFIG_DEBUG_LIST:
> 

> [   31.777570] list_add double add: new=ffff888ff7cf0db0, prev=ffff888ff7ce82f0, next=ffff888ff7cf0db0.

> To reproduce this, we can simply run:
>   perf stat -e cs -a &
>   perf stat -e cs -G anycgroup
> 
> Fix this by installing it to cpuctx that contains event->ctx, and the
> proper cgrp_cpuctx_list.
> 
> Fixes: db0503e4f675 ("perf/core: Optimize perf_install_in_event()")
> Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Cc: Andi Kleen <andi@firstfloor.org>
> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Song Liu <songliubraving@fb.com>

Thanks!
