Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5D4AC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 20:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAD53207CB
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 20:02:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RuZlvMn8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390626AbgEZUCo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 16:02:44 -0400
Received: from merlin.infradead.org ([205.233.59.134]:58926 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728113AbgEZUCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 16:02:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vLR9eBAiLYEUKwprcJXh81uedkl9DNMlOvuRu7LvBis=; b=RuZlvMn80VurInOVh3nLd0nRe3
        Y7yAHKOXTj4q11Y0AFuKtwl092FpvUOO9mwUoSSfDX+dMPSUSj8eAoaCfP84b/7/fv0YN1+xUVyjd
        U1lK99hA6Tm/nCbZWgti+CRELnvAfK9exDx5pugAJnPVEGxhsPoU1+EQ2sGhpA6WYhYanlTAbkYLq
        ZpVTVSDXS+M0wg0YjPAnxFDUkANX4qCvPcfM8qhv97vPPF2TMXyle/a1SiIJ5sPi4cGZ/R90OICNq
        47zv+pR8c+cxTXlekgr09/00Sve2tZasrWS1AYmE1QlbvuH2IdleD11LgwySpzlAXKp8axG6DSjJ1
        rxH5lnSQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jdfkN-00059M-CD; Tue, 26 May 2020 20:00:23 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1FFEB3079B8;
        Tue, 26 May 2020 22:00:15 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D5BA32B975366; Tue, 26 May 2020 22:00:15 +0200 (CEST)
Date:   Tue, 26 May 2020 22:00:15 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Ingo Molnar <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH] sched/fair: don't NUMA balance for kthreads
Message-ID: <20200526200015.GG325280@hirez.programming.kicks-ass.net>
References: <865de121-8190-5d30-ece5-3b097dc74431@kernel.dk>
 <jhjpnaqtztl.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jhjpnaqtztl.mognet@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 26, 2020 at 05:40:06PM +0100, Valentin Schneider wrote:

> > Change the task_tick_numa() check to exclude kernel threads in general,
> > as it doesn't make sense to attempt ot balance for kthreads anyway.
> >
> 
> Does it? (this isn't a rethorical question)
> 
> Suppose a given kthread ends up doing more accesses to some pages
> (via use_mm()) than the other threads that access them, wouldn't it make
> sense to take that into account when it comes to NUMA balancing?

Well, task_tick_numa() tries and farm off a bunch of actual work to
task_work_add(), and there's so very little userspace for a kernel
thread to return to... :-)


