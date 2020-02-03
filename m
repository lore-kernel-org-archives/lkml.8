Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC2FDC35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 15:09:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F30D2080D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 15:09:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TToOhRG5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728654AbgBCPJm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 10:09:42 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:34746 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727746AbgBCPJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 10:09:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TJi8QtHhsWGCVxRxV46Sl0UBAWvTaJeS0BMr3/1JOes=; b=TToOhRG5H7Rm8TDoz517bEYPm8
        nPt5NZQXnCIbLuCeR7m40vM9GHtN3KF1O1nSSraj8KYSpPmeyF1jzlLltrR1xQLxN/RPadva3gFxf
        y+ArOzdoieP3eJlXPNpAC1F2XX04DLn4VmavCMn+qfjCXsAkSwxohO7URvL7k1a92Haa6XgWqAUHk
        ZVfcogpqnHoH24VD3fNPerCMdeio5DDwxK2H+AkWS3JJP4zIkrDm1zJ4cWGX+ao+AXuy7AWjbdS+c
        olOQn9D4GBsxFGSLb1G2BPoGj5Ye1UrRVppUvW3yP+9lrckQ1vEPAWLVRNBbsFgoSye1nG7FtDfEZ
        s+n1hz6Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iydM0-0001a3-Lc; Mon, 03 Feb 2020 15:09:36 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AA04F3011E0;
        Mon,  3 Feb 2020 16:07:48 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CB5F92014711E; Mon,  3 Feb 2020 16:09:33 +0100 (CET)
Date:   Mon, 3 Feb 2020 16:09:33 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     mingo@kernel.org, will@kernel.org, oleg@redhat.com,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        bigeasy@linutronix.de, juri.lelli@redhat.com, williams@redhat.com,
        bristot@redhat.com, longman@redhat.com, dave@stgolabs.net,
        jack@suse.com
Subject: Re: [PATCH -v2 5/7] locking/percpu-rwsem: Remove the embedded rwsem
Message-ID: <20200203150933.GJ14914@hirez.programming.kicks-ass.net>
References: <20200131150703.194229898@infradead.org>
 <20200131151540.155211856@infradead.org>
 <20200203142050.GA28595@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200203142050.GA28595@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 03, 2020 at 06:20:50AM -0800, Christoph Hellwig wrote:
> On Fri, Jan 31, 2020 at 04:07:08PM +0100, Peter Zijlstra wrote:
> > @@ -53,12 +53,6 @@ struct rw_semaphore {
> >  #endif
> >  };
> >  
> > -/*
> > - * Setting all bits of the owner field except bit 0 will indicate
> > - * that the rwsem is writer-owned with an unknown owner.
> > - */
> > -#define RWSEM_OWNER_UNKNOWN	(-2L)
> 
> Can you split the removal of the non-owned resem support into a separate
> patch?  I still think keeping this one and moving aio to that scheme is
> a better idea than the current ad-hoc locking scheme that has all kinds
> of issues.

That's basically 2 lines of code and a comment, surely we can ressurect
that if/when it's needed again?

---
diff --git a/include/linux/rwsem.h b/include/linux/rwsem.h
index 00d6054687dd..8a418d9eeb7a 100644
--- a/include/linux/rwsem.h
+++ b/include/linux/rwsem.h
@@ -53,12 +53,6 @@ struct rw_semaphore {
 #endif
 };
 
-/*
- * Setting all bits of the owner field except bit 0 will indicate
- * that the rwsem is writer-owned with an unknown owner.
- */
-#define RWSEM_OWNER_UNKNOWN	(-2L)
-
 /* In all implementations count != 0 means locked */
 static inline int rwsem_is_locked(struct rw_semaphore *sem)
 {
diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index 44e68761f432..5449ab33f89e 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -660,8 +659,6 @@ static inline bool rwsem_can_spin_on_owner(struct rw_semaphore *sem,
 	unsigned long flags;
 	bool ret = true;
 
-	BUILD_BUG_ON(!(RWSEM_OWNER_UNKNOWN & RWSEM_NONSPINNABLE));
-
 	if (need_resched()) {
 		lockevent_inc(rwsem_opt_fail);
 		return false;


