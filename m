Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0824C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 07:19:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DD652074B
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 07:19:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Qh2z0dkU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbgDUHTC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 03:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbgDUHTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 03:19:02 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47A2AC061A0F
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 00:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wB7dZFZ/Ju9Qvfbv82JrC+nwTQ54dwvrWz27hhZ8iSA=; b=Qh2z0dkU2bQ4vBWyoXby9G84uc
        W7RZETzPOwuLZJtla99+BsQZ6ysXh3IofFNE9SIQCsLiYlYZNp2MFnQaN0teJxPC+y3EfmUqFKYUi
        3Qw+x1FXojqOr59mtemnrUCSJglnqNRblUKzA1H+FS8ZkAzslciBPPkR6fNoQasGIqCIMGkAtWK5t
        HcVXHRAAYBnns8N4QLEYbHIocekZOyWxv60NaAT/uT1bxKj8phHcFUpOfogY6lc8yJa0kId8ZUv1f
        bVvZrX587Z1vQHM2i6naVNLrj2e2GZIqRk5mgVmL+neY3pasiKX9re0ZgpPx9FRTksrs1RmTlLh3U
        I8Ewv4yg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jQnBF-0000An-ER; Tue, 21 Apr 2020 07:18:53 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 039F6301AC6;
        Tue, 21 Apr 2020 09:18:50 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E53662BAC6A7F; Tue, 21 Apr 2020 09:18:50 +0200 (CEST)
Date:   Tue, 21 Apr 2020 09:18:50 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>, Tejun Heo <tj@kernel.org>,
        kernel test robot <rong.a.chen@intel.com>
Subject: Re: [PATCH v12] perf: Sharing PMU counters across compatible events
Message-ID: <20200421071850.GO20730@hirez.programming.kicks-ass.net>
References: <20200331075533.2347393-1-songliubraving@fb.com>
 <20200420230429.GT2483@worktop.programming.kicks-ass.net>
 <DD112BD6-F623-4039-A0E1-D395D705A528@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DD112BD6-F623-4039-A0E1-D395D705A528@fb.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 21, 2020 at 01:13:32AM +0000, Song Liu wrote:
> >> static inline u64 perf_event_count(struct perf_event *event)
> >> {
> >> -	return local64_read(&event->count) + atomic64_read(&event->child_count);
> >> +	u64 count;
> >> +
> >> +	if (likely(event->dup_master != event))
> >> +		count = local64_read(&event->count);
> >> +	else
> >> +		count = local64_read(&event->master_count);
> >> +
> >> +	return count + atomic64_read(&event->child_count);
> >> }
> > 
> > So lsat time I said something about SMP ordering here. Where did that
> > go?
> 
> I guess we will need something with EVENT_TOMBSTONE? That's not clean, I guess.
> 
> > 
> > Specifically, without ordering it is possible to observe dup_master and
> > dup_count out of order. So while we might then see dup_master, we might
> > then also see an old dup_count, which would give 'interesting' effects.
> > 
> > Granted, adding memory barriers all over this will suck :/
> 
> Can we somehow guarantee dup_master and the counts sits in the same 
> cache line? In that way, we can get rid of most of these barriers. 

I'm afraid memory ordering doesn't quite work that way. It is also very
much outside every architectural guarantee ever written.

In specific this does not consider store buffers and snoops.
