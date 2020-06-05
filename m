Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 305DFC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 10:56:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BCDE206E6
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 10:56:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="J5ozC2eX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbgFEK4e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 06:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726918AbgFEK4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 06:56:34 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED333C08C5C2
        for <linux-kernel@vger.kernel.org>; Fri,  5 Jun 2020 03:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=saGaZrcjpuLsokLkuqJY11c916jNr+yTKHM09OZCpIc=; b=J5ozC2eXJq+fpphcd4SqmfXiJz
        vBzmZyc7ZssHqW2l0FCvAOWyq+6cbPhGK0DZjGLrIf4ErqGZoStVRFt3E7WmxNyby66uGpWuMnSzv
        HCi5pXg6ko573as95hZ3EUWvUkjhT7svfA7OPpax2FbE8llrGbxrEXKzXZZzZUApJr3Zk/A6t2a5p
        cFvS6CCexzuWvt2WMwD3MniDTPFbwjaPyE4ORWFn4sJcGAZ71op6mlAyMtdNa2rKgc3wfkTjG/OQ4
        dK9xBTXfqd+NzPjkv1ad70OtR++h1LT+GIaqUkV3qYkPTtclCKDS9v0rBVYWMHXkuzvo0Y8HdbGw1
        ZSiSjfNg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jhA1I-0000u5-Ny; Fri, 05 Jun 2020 10:56:18 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DBEE230280D;
        Fri,  5 Jun 2020 12:56:14 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A062121A74B27; Fri,  5 Jun 2020 12:56:14 +0200 (CEST)
Date:   Fri, 5 Jun 2020 12:56:14 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        tglx@linutronix.de, linux-kernel@vger.kernel.org
Subject: Re: BUG: kernel NULL pointer dereference from check_preempt_wakeup()
Message-ID: <20200605105614.GC2948@hirez.programming.kicks-ass.net>
References: <20200604225445.GA32319@paulmck-ThinkPad-P72>
 <20200605103859.GI3976@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200605103859.GI3976@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 05, 2020 at 12:38:59PM +0200, Peter Zijlstra wrote:
> On Thu, Jun 04, 2020 at 03:54:45PM -0700, Paul E. McKenney wrote:
> > Hello!
> > 
> > I get the splat below at a rate of roughly two per thirty hours when
> > running rcutorture scenario TREE03 on x86 at the June 3rd mainline commit:
> > 
> > cb8e59cc8720 ("Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next")
> > 
> > Running 140 hours of this same scenario at the following June 2nd mainline
> > commit shows no errors:
> > 
> > d9afbb350990 ("Merge branch 'next-general' of git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security")
> > 
> > I have started a bisection, but it is likely to take several days to
> > complete.  I am looking at ways of speeding this up, but in the meantime,
> > I figured that I should check to see if others are also encountering this.
> > 
> > Thoughts?
> 
> I think this shows there's a boo-boo with the IPI patches. I've not
> managed to reproduce, but I'll give them another hard look.
> 
> Would you have a .config for me? My compiler's check_preempt_wakeup
> isn't anywhere near 0x180 bytes long. I'm thiknig you have
> instrumentation enabled, KCSAN?

n/m, I was looking at the wrong function.. let me go puzzle.
