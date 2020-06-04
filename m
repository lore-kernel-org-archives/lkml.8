Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 791FAC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 13:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B67C20772
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 13:12:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="b8fLI7+y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728507AbgFDNMl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 09:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726003AbgFDNMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 09:12:40 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34314C08C5C0
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 06:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VJmCTAmIJ+Mke6r+81wUkrD9bLIEsCYV5dQZXCoe/TY=; b=b8fLI7+ywmCl+VL6x6NvG6ddwU
        MqyZDLzajvrRaFdBamwMfkUi4LjFzDcuD217RMQ8N7pPoAE9hvOlTg/8I+U01S45VbdS+pO70FQMq
        ZjjOncvvGqrQWO6gTG4+iIwTFSY7Q1a3PYjRiTRHCNZGQc0OoeAkWHecqa4iYiNpa1Y5zG8VSnAbt
        y6i1xZT/aYsdvL147ZUZXJhXQIIzbtm2r+dtoMP1pj5J5j/WZCfjJ1NYuO8aJgED46FO8xnYERa3f
        3rwx4bGiI4HeAL7AnpK5Gi8FTQZwLvTjjtfC+e96wLvJdMEKVmsS9nbPczkNex9LSyfANi2VSx0XZ
        77+8pBCQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jgpfN-000499-Uj; Thu, 04 Jun 2020 13:12:18 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6F9CA30581E;
        Thu,  4 Jun 2020 15:12:15 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4D7C120E0606A; Thu,  4 Jun 2020 15:12:15 +0200 (CEST)
Date:   Thu, 4 Jun 2020 15:12:15 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     mingo@redhat.com, hannes@cmpxchg.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        shakeelb@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH 1/1] psi: eliminate kthread_worker from psi trigger
 scheduling mechanism
Message-ID: <20200604131215.GB4117@hirez.programming.kicks-ass.net>
References: <20200528195442.190116-1-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528195442.190116-1-surenb@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 12:54:42PM -0700, Suren Baghdasaryan wrote:
> Each psi group requires a dedicated kthread_delayed_work and
> kthread_worker. Since no other work can be performed using psi_group's
> kthread_worker, the same result can be obtained using a task_struct and
> a timer directly. This makes psi triggering simpler by removing lists
> and locks involved with kthread_worker usage and eliminates the need for
> poll_scheduled atomic use in the hot path.
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> ---
> This patch is meant to address Peter's request in [1] to pull
> kthread_queue_delayed_work() out from under rq->lock. This should also address
> the lockdep warning about possibility of a circular dependency described in [2]

I think you could've just fixed kthread_queue_delayed_work(), that code
is sub-optimal.

But I suppose this works too.
