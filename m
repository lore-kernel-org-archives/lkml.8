Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B011CC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 22:47:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 876B9208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 22:47:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FwJFBIEe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbgGaWrt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 18:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbgGaWrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 18:47:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92EF1C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 15:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jo5zynVx6cBLfbI9yKog9Ac2IbuetzghuOBuscp79bQ=; b=FwJFBIEeg6oRwAvzEd7NnfgAYr
        sKIunvYAAhIk8aU16uUzyrxqkCttsBx44PLhKik97IFwVdPJwk2r4Jcb2O1FEAWk0VHYrWRvY+Zjd
        Q/50Sb31BS3i9h6v6KovOKtFUoPmeIbkxDyhUNehC9DLA32hMXswPmLQp//KzclfyIfyjcrSB3j8h
        stGyRR1O7ldZMG6CzPhqaK5DoI93ng3+KEMWG2QtI6FY0bw0ne7ur+5rO91VvlJzsQ6Y8y5tu77Zc
        veJGamWaTFkcCAVT99bywCfFssgWVkKTKd580mk0e4IO+BxhmDl8sRX92G/RY8D0m+NEXXiSTbox0
        n/nGvIhQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k1doQ-0007x7-GA; Fri, 31 Jul 2020 22:47:38 +0000
Date:   Fri, 31 Jul 2020 23:47:38 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        hannes@cmpxchg.org, urezki@gmail.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: Raw spinlocks and memory allocation
Message-ID: <20200731224738.GU23808@casper.infradead.org>
References: <20200730231205.GA11265@paulmck-ThinkPad-P72>
 <20200731133834.517fdfee99b7ed2239f576aa@linux-foundation.org>
 <20200731204855.GR9247@paulmck-ThinkPad-P72>
 <20200731205933.GT23808@casper.infradead.org>
 <20200731212457.GS9247@paulmck-ThinkPad-P72>
 <20200731142919.36c4c741189426db0f8b8514@linux-foundation.org>
 <20200731223016.GT9247@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200731223016.GT9247@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 31, 2020 at 03:30:16PM -0700, Paul E. McKenney wrote:
> On Fri, Jul 31, 2020 at 02:29:19PM -0700, Andrew Morton wrote:
> > On Fri, 31 Jul 2020 14:24:57 -0700 "Paul E. McKenney" <paulmck@kernel.org> wrote:
> > 
> > > The reason for this restriction is that in -rt, the spin_lock(&zone->lock)
> > > in rmqueue_bulk() can sleep.
> > 
> > So if there is runtime overhead, this overhead could be restricted to
> > -rt kernels with suitable ifdefs?
> 
> In theory, yes.  In practice, with CONFIG_PROVE_RAW_LOCK_NESTING=y,
> lockdep will complain regardless of -rt or not.

On non-RT, we could make that lock a raw spinlock.  On RT, we could
decline to take the lock.  We'd need to abstract the spin_lock() away
behind zone_lock(zone), but that should be OK.

But let's see if we need to do that.
