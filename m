Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6845C2D0EA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 15:09:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC96920747
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 15:09:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pBKw32kg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729388AbgDHPJ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 11:09:57 -0400
Received: from merlin.infradead.org ([205.233.59.134]:43904 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728844AbgDHPJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 11:09:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=89Z6RxZbArgSbKPhvwh545xFzap5boKJNxHrWLE5c3c=; b=pBKw32kgXdu8+8BKvU+rZoryaH
        cxLwy66LF3zStA1uprQ8+vkAf4LfN1dDxufW0oN1Gd7Byp0QZ5vWV1PCIGbw2StameFanawUwPzA5
        7tTiQukMUs/MjmGABqLVbUUk6qPQPD0YQ8bDH7dFYxKOyXdABPWWXHQqxDH7nR0ZXXYuj14A4aQcR
        IQIMDuqAT15RzfeOMzLc32U8C6mK086NagAEpsPZl+VbS576oG/jZm1qgDHkHGrLwkZorutTwhdpu
        wVCQtafnKcHNz7mKZ8StbDannr2HcgTKSwLP7nOS4FW6JnU70V224+1BmasGmq/hNQPndB7QeXytO
        N/cCVSzQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jMCKl-0004s4-4q; Wed, 08 Apr 2020 15:09:44 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 97519300130;
        Wed,  8 Apr 2020 17:09:40 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7BF4D201C1CBC; Wed,  8 Apr 2020 17:09:40 +0200 (CEST)
Date:   Wed, 8 Apr 2020 17:09:40 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     syzbot <syzbot+a95c7753605c9d219466@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, bgeffon@google.com,
        dvhart@infradead.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, peterx@redhat.com,
        syzkaller-bugs@googlegroups.com, torvalds@linux-foundation.org
Subject: Re: general protection fault in get_futex_key
Message-ID: <20200408150940.GM20730@hirez.programming.kicks-ass.net>
References: <0000000000008250f105a2c4ade1@google.com>
 <87mu7mayky.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mu7mayky.fsf@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 08, 2020 at 03:36:45PM +0200, Thomas Gleixner wrote:

> This means that
> 
>      get_user_pages_fast(address, 1, FOLL_WRITE, &page)
> 
> returned 0, which is breaking the interface:
> 
>  * Returns number of pages pinned. This may be fewer than the number requested.
>  * If nr_pages is 0 or negative, returns 0. If no pages were pinned, returns
>  * -errno.
> 
> nr_pages is clearly 1. So if the call fails, the number of pinned pages
> is 0 and it should return a proper error number. It did before.
> 
> From a quick look at the commit in question I assume it's the
> 
> +               if (fatal_signal_pending(current))
> +                       break;
> 
> which can cause that to happen.

Yep, that's broken. It wants the below, just like all the other error
paths in that loop.

---
Subject: mm/gup: Fix broken fatal_signal_pending() test

Just like all the other error returns in this loop, we need to set
pages_done to the error value when it is zero.

Fixes: 4426e945df58 ("mm/gup: allow VM_FAULT_RETRY for multiple times")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
diff --git a/mm/gup.c b/mm/gup.c
index afce0bc47e70..14bce270b249 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1326,8 +1326,11 @@ static __always_inline long __get_user_pages_locked(struct task_struct *tsk,
 		 * start trying again otherwise it can loop forever.
 		 */
 
-		if (fatal_signal_pending(current))
+		if (fatal_signal_pending(current)) {
+			if (!pages_done)
+				pages_done = -ERESTARTSYS;
 			break;
+		}
 
 		ret = down_read_killable(&mm->mmap_sem);
 		if (ret) {
