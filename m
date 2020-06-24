Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E70AC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 07:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7596F2085B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 07:53:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uN0lL8PQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390127AbgFXHxT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 03:53:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387725AbgFXHxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 03:53:18 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A6C6C061573
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 00:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5T5TvBb+88tPNfoiiFDEVsZ66I1kFN8shpVe/RD6M+M=; b=uN0lL8PQ+8GTG0+fLRPlb8Pqgg
        e+5Yd861oZju3F8AdbboObnWMl4RWl8xhrYhHSZ6nXTJ0EQ8pnKWHrV3gu9O03EJKnSwNxgB4jycW
        Q3Vs0pJXT6jLlRTG7xEKfB1xQOCwUqCP7GOzfumjkkRUQzHaLctJjag6bJpJiLlJAvR6EXGVSnOPm
        nJUEG7CR0qrGjmAFe0vOhNdvwgCdIisgPtxzoQwdG8V3k3ApajpD9IBubDAeh47pVrFvz5eg5e4fM
        d/+uxlRfUeLK1WjRjqJytdJmcQL1jZpWTT5wN2KWKbSAzTwMFCD7spg6PhdziiJKu7LPNT9Oq+NaH
        OQlej4bg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jo0DE-0006vW-Cv; Wed, 24 Jun 2020 07:52:52 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CFA25300261;
        Wed, 24 Jun 2020 09:52:49 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BDCD129E7F8A0; Wed, 24 Jun 2020 09:52:49 +0200 (CEST)
Date:   Wed, 24 Jun 2020 09:52:49 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     tglx@linutronix.de, x86@kernel.org, elver@google.com,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        will@kernel.org, dvyukov@google.com, glider@google.com,
        andreyknvl@google.com
Subject: Re: [PATCH 2/9] rcu: Fixup noinstr warnings
Message-ID: <20200624075249.GC4800@hirez.programming.kicks-ass.net>
References: <20200603114014.152292216@infradead.org>
 <20200603114051.896465666@infradead.org>
 <20200615154905.GZ2531@hirez.programming.kicks-ass.net>
 <20200615155513.GG2554@hirez.programming.kicks-ass.net>
 <20200615162427.GI2554@hirez.programming.kicks-ass.net>
 <20200615171404.GI2723@paulmck-ThinkPad-P72>
 <20200619221555.GA12280@paulmck-ThinkPad-P72>
 <20200623204646.GF2483@worktop.programming.kicks-ass.net>
 <20200623214433.GX9247@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200623214433.GX9247@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 02:44:33PM -0700, Paul E. McKenney wrote:
> On Tue, Jun 23, 2020 at 10:46:46PM +0200, Peter Zijlstra wrote:
> > On Fri, Jun 19, 2020 at 03:15:55PM -0700, Paul E. McKenney wrote:
> > 
> > > Just following up because I don't see this anywhere.  If I am supposed
> > > to take this (which is more plausible now that v5.8-rc1 is out), please
> > > let me know.
> > 
> > Sorry, I got distracted by that NULL ptr thing, but that seems sorted
> > now. If you don't mind taking it through your rcu/urgent tree for -rc3
> > or so that would be awesome.
> 
> Will do!
> 
> Just to double-check, this is the patch from you with Message-ID
> 20200603114051.896465666@infradead.org, correct?
> 
> Or, if you prefer, this commit now on -rcu?
> 
> 	5fe289eccfe5 ("rcu: Fixup noinstr warnings")
> 
> If this is the correct commit, I will rebase it on top of v5.8-rc2,
> and if it passes tests, send it along via rcu/urgent.

Ah, I was thinking about:

  https://lore.kernel.org/lkml/20200615162427.GI2554@hirez.programming.kicks-ass.net/

seeing how I added that instrumentation you wanted :-), but either
version should work for now. KCSAN is sad without this.
