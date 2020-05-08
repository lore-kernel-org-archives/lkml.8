Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12AA4C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 10:12:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDC7020870
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 10:12:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IALsoFlb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbgEHKMd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 06:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbgEHKMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 06:12:32 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19C8AC05BD43
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 03:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=R9lBog4QwyyUN2dMY8gMVLm+VAmVFFjpkamhWWZmK+8=; b=IALsoFlbh7+AEmeiGBQPVqG+GV
        5MPENByL3nWip53KQ4DnR7YepgNA5wA+QW8lHqy1NanzfGQB1jNBWIyVIpTCqJXLa1F9BPZY1GmQc
        iau3/5yltWKj8j+JAjfJkVg9DXwMhHgJqcas2VexN8f+3I9vtHwi8NjU0tn7hmUjZaHuqKZmGfwg7
        4iTdMwOr0/Zg+fZYy7xG4wJGpbnOeyLbK/pajw7IbqwRAepurE3ai4Six1pKFCmzx/quVCT9I+fx5
        p5oSJRNWJ1+valpWQKyzoTO7dR2DLYJXJKxDodc3YGlqpLe9FoJeQRQzXRLl7hfjSnXGc+yChgimt
        7aok8oYQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jWzzI-0006Ff-3a; Fri, 08 May 2020 10:12:12 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 67322301DFC;
        Fri,  8 May 2020 12:12:09 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 52997201C228D; Fri,  8 May 2020 12:12:09 +0200 (CEST)
Date:   Fri, 8 May 2020 12:12:09 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, luto@kernel.org
Subject: Re: [RFC][PATCH 3/3] x86/entry, ORC: Teach objtool/unwind_orc about
 stack irq swizzles
Message-ID: <20200508101209.GY5298@hirez.programming.kicks-ass.net>
References: <20200507161020.783541450@infradead.org>
 <20200507161828.801097834@infradead.org>
 <20200507173809.GK5298@hirez.programming.kicks-ass.net>
 <20200507183048.rlf2bgj4cf2g4jy6@treble>
 <878si3e8v2.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878si3e8v2.fsf@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 07, 2020 at 11:24:49PM +0200, Thomas Gleixner wrote:
> But over our IRC conversation I came up with a 3rd variant:
> 
>   For most of the vectors the indirect call overhead is just noise, so
>   we can run them through the ASM switcher, but for the resched IPI
>   we can just use a separate direct call stub in ASM.

Are we sure the rat-poison crap is noise for all the other system
vectors? I suppose it is for most since they'll do indirect calls
themselves anyway, right?

> I can live with that. I might have to pay up for Peter's headaches to
> teach objtool, but that's a different story. Let me check how many beers
> he owes me first ...

We're going to be so massively drunk if we ever settle that :-) For now
I'll just have to live with knowing more about the unwinders.
