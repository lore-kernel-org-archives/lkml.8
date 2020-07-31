Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CAACC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 20:59:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF15522B42
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 20:59:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UMB5h2mn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728437AbgGaU7o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 16:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727053AbgGaU7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 16:59:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C69BBC061574
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 13:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Lf6Tsl2/eoEgie5skYyJMNmAvL2Bjr4XRRNee/YKgpA=; b=UMB5h2mnjeZ1NU4HpmUnHmv/Rd
        HlcVYUzWJqeRgQ7GmNTDwJKdfVWRmyOvoj2S2q7zuz2PR6kN+5ozMq2Qxr5jP2ervyaxpMjTbw+75
        5kfJUxiIIuEUqDIJ6DrYn3opeyfLlOEi40gxdA5EeSnbEjiTgPESdcm7Ppgakn9OsWgXRFCCOOSac
        dCwfMC7kRA/4TSef8vfpHayLwXM2/0VoUkRqT0y/aTraUF3glixnQNfDJCcC9YNvlAXFt08w4dPp+
        bTGtp3vu7Y9sciW02YGMVX9zXrW21edap9a2j/v8WtT3Bj7jI+d0MpZ1GRbITZms9maEJidP5XhI5
        qovR2ptw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k1c7p-0002RM-4g; Fri, 31 Jul 2020 20:59:33 +0000
Date:   Fri, 31 Jul 2020 21:59:33 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        hannes@cmpxchg.org, urezki@gmail.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: Raw spinlocks and memory allocation
Message-ID: <20200731205933.GT23808@casper.infradead.org>
References: <20200730231205.GA11265@paulmck-ThinkPad-P72>
 <20200731133834.517fdfee99b7ed2239f576aa@linux-foundation.org>
 <20200731204855.GR9247@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200731204855.GR9247@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 31, 2020 at 01:48:55PM -0700, Paul E. McKenney wrote:
> On Fri, Jul 31, 2020 at 01:38:34PM -0700, Andrew Morton wrote:
> > On Thu, 30 Jul 2020 16:12:05 -0700 "Paul E. McKenney" <paulmck@kernel.org> wrote:
> > 
> > > So, may we add a GFP_ flag that will cause kmalloc() and friends to return
> > > NULL when they would otherwise need to acquire their non-raw spinlock?
> > > This avoids adding any overhead to the slab-allocator fastpaths, but
> > > allows callback invocation to reduce cache misses without having to
> > > restructure some existing callers of call_rcu() and potential future
> > > callers of kfree_rcu().
> > 
> > We have eight free gfp_t bits so that isn't a problem.
> 
> Whew!!!  ;-)
> 
> > Adding a test-n-branch to the kmalloc() fastpath may well be a concern.
> > 
> > Which of mm/sl?b.c are affected?
> 
> None of them, it turns out.  The initial patch will instead directly
> invoke __get_free_page().  So we could just leave sl?b.c alone.

Isn't that spelled GFP_NOWAIT?
