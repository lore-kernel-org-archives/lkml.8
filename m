Return-Path: <SRS0=eufF=BE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCA99C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 16:58:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9C14206D7
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 16:58:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OEmj9sk3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbgGYQ6r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 12:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbgGYQ6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 12:58:46 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B80F8C08C5C0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jul 2020 09:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6ltveWQkhnBb6mzizvV/wAJDe13OC+WrI+RXwa5RzLM=; b=OEmj9sk3+aCTN1rhW4dLSnMDAZ
        KLE97gsN8PEKVIHUn2yVlrD+h8Im9y0R/2+gVRAO9/YCwybxS2sg8DGWM2LfmA0nhHYhVVx2Xp4y0
        C6hq8gYsRPEa0NSSIcioNlyU0bYlcFIAxXjthXYtBcXxGQxp3XkwYvU3wtMJ6Uu5ZPSyYUychh3NT
        5IcFpdSJaFULTa8PZo9cQ4uVMVkzdG0eAeemBCo9d7W8AXNNe6DpgcriEqY8zwR+laHp2efOxA623
        Pu2JWxoWWY+w1/ZUW9Ay+Os14zE8ZDIGUW6Na4sMgmOH82huASuOe99hU5NE8mATyC0/YipbWtBDw
        njQL/dbA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jzNV4-0000Hb-TV; Sat, 25 Jul 2020 16:58:19 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C34B23013E5;
        Sat, 25 Jul 2020 18:58:16 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5060A20104627; Sat, 25 Jul 2020 18:58:16 +0200 (CEST)
Date:   Sat, 25 Jul 2020 18:58:16 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Ingo Molnar <mingo@kernel.org>, sfr@canb.auug.org.au
Subject: Re: [PATCH v2] sched,tracing: Convert to sched_set_fifo()
Message-ID: <20200725165816.GE10769@hirez.programming.kicks-ass.net>
References: <202006192249.AYnVBGCH%lkp@intel.com>
 <20200709124505.GT597537@hirez.programming.kicks-ass.net>
 <20200709115818.36a956a4@oasis.local.home>
 <20200720214918.GM5523@worktop.programming.kicks-ass.net>
 <20200724213911.GX119549@hirez.programming.kicks-ass.net>
 <20200724174618.7487ee7c@oasis.local.home>
 <20200724215003.GY119549@hirez.programming.kicks-ass.net>
 <20200724181846.415bfd43@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200724181846.415bfd43@oasis.local.home>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 24, 2020 at 06:18:46PM -0400, Steven Rostedt wrote:
> On Fri, 24 Jul 2020 23:50:03 +0200
> peterz@infradead.org wrote:
> 
> > -	if (producer_fifo < 0)
> > +	if (producer_fifo)
> > +		trace_printk("Running Producer at SCHED_FIFO %s\n",
> > +			     consumer_fifo == 1 ? "low" : "high");
> 
> I'm going to take cut-and-paste away from you!

Well, yes, I said so, I also already have it fixed.

Aside from that, is the patch ok?
