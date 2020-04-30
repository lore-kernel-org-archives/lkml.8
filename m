Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AA17C8300A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 08:46:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 003C420787
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 08:46:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="U/3U3Omg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727809AbgD3Iqq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 04:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727797AbgD3Iqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 04:46:45 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B8ACC035494
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 01:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dJibi8+9gpWgPsI5bkF0DP5RYKeyq8ferFIx7QxKLW4=; b=U/3U3Omg0pqfzoiow9jRIKGb7a
        AtjRvjxjP4aL5yIszZQyuH37VD8/vONbuTi+GOl7rnGLllTYZR9FGljCZFw6u57WvSoj1mUxZm1Si
        eWZCJWj4vimJp0Ly94Tyccm0HAqynZacSxnK8yebQGa3JHSwO1UKa5+RXchfdFWbCBHO5oHkQYV/0
        9WMEGsNpKx+PI645x1jn1mwm3ztDZEyCCdgclHIRYtqn4FGe7Q6bRHlvdfiXQkSdDHt9JddAjvXgH
        H8gjBDRu6+E9+kpykwFZ6xpLb0OAnfO3/mDoiHW3NXXeXiEj2WCVVDfnBfjZ2tFZeOQ3/ZPs1zHmJ
        2OTrVlfQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jU4pn-0000wj-VB; Thu, 30 Apr 2020 08:46:20 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8F430307487;
        Thu, 30 Apr 2020 10:46:17 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 727B720BD9001; Thu, 30 Apr 2020 10:46:17 +0200 (CEST)
Date:   Thu, 30 Apr 2020 10:46:17 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Michel Lespinasse <walken@google.com>
Cc:     linux-kernel@vger.kernel.org, dave@stgolabs.net, mingo@kernel.org,
        tglx@linutronix.de, oleg@redhat.com, irogers@google.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org
Subject: Re: [RFC][PATCH 1/7] rbtree: Add generic add and find helpers
Message-ID: <20200430084617.GQ13592@hirez.programming.kicks-ass.net>
References: <20200429153258.563269446@infradead.org>
 <20200429153549.006661686@infradead.org>
 <20200430010405.GA237715@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200430010405.GA237715@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 29, 2020 at 06:04:05PM -0700, Michel Lespinasse wrote:
> Hi Peter,
> 
> On Wed, Apr 29, 2020 at 05:32:59PM +0200, Peter Zijlstra wrote:
> > I've always been bothered by the endless (fragile) boilerplate for
> > rbtree, and I recently wrote some rbtree helpers for objtool and
> > figured I should lift them into the kernel and use them more widely.
> > 
> > Provide:
> > 
> > partial-order; less() based:
> >  - rb_add(): add a new entry to the rbtree
> >  - rb_add_cached(): like rb_add(), but for a rb_root_cached
> > 
> > total-order; cmp() based:
> >  - rb_find(): find an entry in an rbtree
> >  - rb_find_first(): find the first (leftmost) matching entry
> >  - rb_next_match(): continue from rb_find_first()
> >  - rb_for_each(): for loop with rb_find_first() / rb_next_match()

I appear to have failed to mention rb_find_add(), which is a bit of a
specialty, but I could imagine there being more like it the many rbtree
users out there (I count 300+ rb_link_node occurences).

> > 
> > Also make rb_add_cached() / rb_erase_cached() return true when
> > leftmost.
> > 
> > Inlining and constant propagation should see the compiler inline the
> > whole thing, including the various compare functions.
> 
> I really like the idea of this change. Also,I think it opens avenues
> for converting some users which had previously been avoiding raw rbtrees
> seemingly only because they didn't want to write this boilerplate.

Yeah; our current interface mandates you _understand_ binary trees, I
can imagine that's a step too far for some (sadly).

> Few questions:
> 
> - Adding the rb_add_cached() / rb_erase_cached() return value looks
>   like it almost belongs to a separate patch. Is this only used in
>   patch 3/7 (sched/deadline) or did I miss other uses ? Not objecting
>   to it, but it wasn't obvious to me when reading the patch what the
>   return value was for.

I can certainly add it in a separate patch; as might be evident from the
(lack) of changelogs on the whole, I basically split and posted the
thing the moment it booted. I figured I shouldn't sink more time into it
if people were going to hate it ;-)

> - Have you considered passing a cmp() function to rb_add() and
>   rb_add_cached(), and having these test cmp() < 0 rather than less() ?
>   I figure every user will need to have a cmp() function, so it'd be
>   nicer if they didn't also need a less() function, if the generated
>   code is similar (if you checked and rejected it because of bad code,
>   please just say so).

I did consider it; in fact I my original helpers had that.

The reaosn I went with less() over cmp() is that the add() vs find()
function signatures:

  bool (*less)(struct rb_node *, const struct rb_node *);
  int (*cmp)(const void *, const struct rb_node *);

differ anyway in the left-hand argument; this is 'fixable' when you
use an (on-stack) dummy object for find (as uprobes does), but that
doesn't always work, esp. when the object is big. And given you need two
functions anyway, I figured it was useful to name them differently.

If you've looked at the other patches a bit, you'll see I've implemented
both functions as 'trivial' wrappers around a single compare function in
many cases.

> Reviewed-by: Michel Lespinasse <walken@google.com>

Thanks, I suppose I'll go brush this up a bit more then.
