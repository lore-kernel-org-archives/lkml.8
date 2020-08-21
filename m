Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6554C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 13:05:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80DB5207DA
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 13:05:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sYSpOdn5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728781AbgHUNFB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 09:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727966AbgHUNFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 09:05:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26539C061385
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 06:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/SNqsOUXmq1TmuBGZ8c3k7Bk2+J5mSEE9Ddwg1n/X/Y=; b=sYSpOdn5pZJondZQNuoWdp/ZQ/
        +bImFzDHoPYWbQmcNHdrwS+m2ZUbhxtp+eqMlCMZN0xR6Bx6IgENEMjr/vv2c+rcnX5P7fWn5awme
        YXSc032K8mX+TEcsfRhu8+XRkzlmKu3rvPvchMzwfW5H9spVOb2FnwqC8I5rSQwmzxNOunf3UnBY7
        /WArC20A3vjswKjzJY4Q/ztm+oQ2c2xs5n7GegpRXvwWJeHGCg2sxVDzmyUyOpuZIiGx1zhItmzOb
        4PDFIlrplJWIscydTsjYSbqyWEt2nok3oZZ77GV76fcmxi4jfOVfPLx6mPJmzsjJ7HNDZ/po07aaN
        M3NNqYHA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k96is-000491-39; Fri, 21 Aug 2020 13:04:46 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 42297301324;
        Fri, 21 Aug 2020 15:04:45 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2D0012C912D84; Fri, 21 Aug 2020 15:04:45 +0200 (CEST)
Date:   Fri, 21 Aug 2020 15:04:45 +0200
From:   peterz@infradead.org
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, luto@amacapital.net, axboe@kernel.dk,
        keescook@chromium.org, torvalds@linux-foundation.org,
        jannh@google.com, will@kernel.org, hch@lst.de, npiggin@gmail.com,
        mathieu.desnoyers@efficios.com
Subject: Re: [PATCH v3] mm: Fix kthread_use_mm() vs TLB invalidate
Message-ID: <20200821130445.GP1362448@hirez.programming.kicks-ass.net>
References: <20200721154106.GE10769@hirez.programming.kicks-ass.net>
 <87y2m8muag.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y2m8muag.fsf@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 21, 2020 at 11:09:51AM +0530, Aneesh Kumar K.V wrote:
> Peter Zijlstra <peterz@infradead.org> writes:
> 
> > For SMP systems using IPI based TLB invalidation, looking at
> > current->active_mm is entirely reasonable. This then presents the
> > following race condition:
> >
> >
> >   CPU0			CPU1
> >
> >   flush_tlb_mm(mm)	use_mm(mm)
> >     <send-IPI>
> > 			  tsk->active_mm = mm;
> > 			  <IPI>
> > 			    if (tsk->active_mm == mm)
> > 			      // flush TLBs
> > 			  </IPI>
> > 			  switch_mm(old_mm,mm,tsk);
> >
> >
> > Where it is possible the IPI flushed the TLBs for @old_mm, not @mm,
> > because the IPI lands before we actually switched.
> >
> > Avoid this by disabling IRQs across changing ->active_mm and
> > switch_mm().
> >
> > [ There are all sorts of reasons this might be harmless for various
> > architecture specific reasons, but best not leave the door open at
> > all. ]
> 
> 
> Do we have similar race with exec_mmap()? I am looking at exec_mmap()
> runnning parallel to do_exit_flush_lazy_tlb(). We can get
> 
> 	if (current->active_mm == mm) {
> 
> true and if we don't disable irq around updating tsk->mm/active_mm we
> can end up doing mmdrop on wrong mm?

exec_mmap() is called after de_thread(), there should not be any mm
specific invalidations around I think.

Then again, CLONE_VM without CLONE_THREAD might still be possible, so
yeah, we probably want IRQs disabled there too, just for consistency and
general paranoia if nothing else.

