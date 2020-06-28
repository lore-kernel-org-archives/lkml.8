Return-Path: <SRS0=fM4p=AJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0CBEC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 13:18:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 898FA20708
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 13:18:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MkDMfaeO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726507AbgF1NSq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jun 2020 09:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbgF1NSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 09:18:46 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 989CDC061794
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jun 2020 06:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4FkqmwznxFHfXc9eXy8WGM1SAzAmqrth8n6MxSso8fM=; b=MkDMfaeOhuTr5CwvyU2BJQBJTV
        dD8Q8zNWys4ennaQ/pe6qolrA2n6+ge6UL9jx8qh7agLrvfLTnegOzrc4wzIys3OyRFYtcOhNOCDs
        pJiNPX3E3O1rsP6MpI5yW8yoB6ULfG5eWplj2jQqTtFgSNsBDsJALbDByxGWFL2CJrZUoNVmNN3kc
        wmdp4wnqIhf05ogwAI91RULsfQv904I6YxCi8DJe7FQPfiXt99jcpp3o7jaK3yI5X4n7q4J9dQ+WT
        /HH4u6RjQkZPbA2PfB1yYKR2rWnJJR825j07O70X00uOVsQuB+z5/rp3YkVP7Q60Qd7WUfomTJtW6
        kQW4maYA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jpXCK-0007rk-9K; Sun, 28 Jun 2020 13:18:17 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 334413013E5;
        Sun, 28 Jun 2020 15:18:13 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 20DD221390E43; Sun, 28 Jun 2020 15:18:13 +0200 (CEST)
Date:   Sun, 28 Jun 2020 15:18:13 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, Nick Piggin <npiggin@gmail.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Jan Kara <jack@suse.cz>, Davidlohr Bueso <dave@stgolabs.net>,
        Andi Kleen <ak@linux.intel.com>,
        Lukas Czerner <lczerner@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: wait_on_page_bit_common(TASK_KILLABLE, EXCLUSIVE) can miss
 wakeup?
Message-ID: <20200628131813.GM4817@hirez.programming.kicks-ass.net>
References: <20200624161142.GA12184@redhat.com>
 <20200624162042.GA12238@redhat.com>
 <CAHk-=wjJA2Z3kUFb-5s=6+n0qbTs8ELqKFt9B3pH85a8fGD73w@mail.gmail.com>
 <20200626154313.GI4817@hirez.programming.kicks-ass.net>
 <CAHk-=whvVWNXPJq1k566zn4SfXAifXtiA7T+7JFweR3rQ0nc9A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whvVWNXPJq1k566zn4SfXAifXtiA7T+7JFweR3rQ0nc9A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 27, 2020 at 10:39:20PM -0700, Linus Torvalds wrote:

> Ugh.

Heh, I was afraid of that..

> So how about the attached trivial two-liner? We solve the problem by
> simply marking ourselves TASK_RUNNING, which means that we won't be
> counted as an exclusive wakeup.
> 
> Ok, so the "one" line to do that is that is actually two lines:
> 
>         __set_current_state(TASK_RUNNING);
>         smp_mb__before_atomic();
> 
> and there's four lines of comments to go with it, but it really is
> very simple: if we do that before we do the test_and_set_bit_lock(),
> no wakeups will be lost, because we won't be sleeping for that wakeup.
> 
> I'm not entirely happy about that "smp_mb__before_atomic()". I think
> it's right in practice that test_and_set_bit_lock() (when it actually
> does a write) has at LEAST atomic seqmantics, so I think it's good.
> But it's not pretty.

Hurm... yes. I think I agree this solves it. However... the wait loop is
'weird'. It isn't shaped like our other loops.

On the one hand, who cares, that's just my OCD, on the other hand, it
does mean you have to think harder every time you look at this thing.
