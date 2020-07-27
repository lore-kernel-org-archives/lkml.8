Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BA31C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 15:28:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 030832073E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 15:28:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YS0RAus0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729629AbgG0P2s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 11:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727784AbgG0P2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 11:28:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EF59C061794;
        Mon, 27 Jul 2020 08:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=eT55c9MjBsQWKlmZyUWtYRtSFalE890lapak7aRvrio=; b=YS0RAus0uAL09mGmLyKM+UmK3G
        cM7eCiuFIgblwhtvrF27VT+qDmo+/fsBzbjOmzViqzeYARvksWzhW4FmhenThmhX2u+CjWVSA+odw
        DX+pvQRvoAQIkHo0BoTxVNztDOiPHROSUwoF1LZ9/tD7gupCMlod1ln9A1Bi4mriOT9EsShX89VYO
        +z+r7IW8Jz2HhI4cJ8zhCNtQClnGWUAQgPotOx8b0x8Z07Wy+C8+/VlQ/RgrI0el+YpzzbHBCwp+F
        QuuS9HC1qN/+T82n00YEWw7g4LryFgAGFBPCUk4xd44//Z0THr6V/aR/BvJQSmbqi59vnWcXAEkdM
        Tv0058ew==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k053E-0000pN-HU; Mon, 27 Jul 2020 15:28:28 +0000
Date:   Mon, 27 Jul 2020 16:28:27 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Eric Biggers <ebiggers@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org,
        "Paul E . McKenney" <paulmck@kernel.org>,
        linux-fsdevel@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH] tools/memory-model: document the "one-time init" pattern
Message-ID: <20200727152827.GM23808@casper.infradead.org>
References: <20200717044427.68747-1-ebiggers@kernel.org>
 <20200717174750.GQ12769@casper.infradead.org>
 <20200718013839.GD2183@sol.localdomain>
 <20200718021304.GS12769@casper.infradead.org>
 <20200718052818.GF2183@sol.localdomain>
 <20200727151746.GC1468275@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200727151746.GC1468275@rowland.harvard.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 27, 2020 at 11:17:46AM -0400, Alan Stern wrote:
> Given a type "T", an object x of type pointer-to-T, and a function
> "func" that takes various arguments and returns a pointer-to-T, the
> accepted API for calling func once would be to create once_func() as
> follows:
> 
> T *once_func(T **ppt, args...)
> {
> 	static DEFINE_MUTEX(mut);
> 	T *p;
> 
> 	p = smp_load_acquire(ppt);	/* Mild optimization */
> 	if (p)
> 		return p;
> 
> 	mutex_lock(mut);
> 	p = smp_load_acquire(ppt);
> 	if (!p) {
> 		p = func(args...);
> 		if (!IS_ERR_OR_NULL(p))
> 			smp_store_release(ppt, p);
> 	}
> 	mutex_unlock(mut);
> 	return p;
> }
> 
> Users then would have to call once_func(&x, args...) and check the
> result.  Different x objects would constitute different "once"
> domains.
[...]
> In fact, the only drawback I can think of is that because this relies
> on a single mutex for all the different possible x's, it might lead to
> locking conflicts (if func had to call once_func() recursively, for
> example).  In most reasonable situations such conflicts would not
> arise.

Another drawback for this approach relative to my get_foo() approach
upthread is that, because we don't have compiler support, there's no
enforcement that accesses to 'x' go through once_func().  My approach
wraps accesses in a deliberately-opaque struct so you have to write
some really ugly code to get at the raw value, and it's just easier to
call get_foo().
