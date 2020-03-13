Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D2CCC10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 08:31:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E288720724
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 08:31:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YR6QRrnO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbgCMIbi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 04:31:38 -0400
Received: from merlin.infradead.org ([205.233.59.134]:57026 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726420AbgCMIbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 04:31:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MAsAcM05mXkzCsPvayDcJZuYQVlAkvzdedkH1NlOMWc=; b=YR6QRrnO3fKBbY/PgCXjSBYL/i
        YFGw13odm0+qWLyhzR1u8l265TNuHgGhITEyT0bhvgbBK7bQTo1TfxZMt088AWymnNkSL6YQE2BnJ
        jk8gfR5ZC2CpEYpmf5N2D5pM8ZtawQO9LZL0rYjyJJX3VK5+Ali96Cg0pDeHKFRaUlJCFw6csHEdm
        dxdeo4abnRmhummAouzwAGbQPlApHpn8zWmtnwkZHWKPIGrKFDjU48/gA35hDyosCH6G0crLkD5MA
        DTSqTZrsHnEnDUC6FpVbffEji/uDTytVF8H7uDR9rzsUOEGZI2CQmv7IitOIY0uZQ+EJbzFRoI8Iz
        zX7TITsw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jCfip-0005FL-C7; Fri, 13 Mar 2020 08:31:11 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0BEC330275A;
        Fri, 13 Mar 2020 09:31:08 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E7C162BA3D056; Fri, 13 Mar 2020 09:31:07 +0100 (CET)
Date:   Fri, 13 Mar 2020 09:31:07 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Dmitry Vyukov <dvyukov@google.com>,
        Jiri Slaby <jslaby@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Garrett <mjg59@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] Add kernel config option for fuzz testing.
Message-ID: <20200313083107.GV12561@hirez.programming.kicks-ass.net>
References: <20200307135822.3894-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <6f2e27de-c820-7de3-447d-cd9f7c650add@suse.com>
 <20200308065258.GE3983392@kroah.com>
 <3e9f47f7-a6c1-7cec-a84f-e621ae5426be@suse.com>
 <CACT4Y+a6KExbggs4mg8pvoD554PcDqQNW4sM15X-tc=YONCzYw@mail.gmail.com>
 <20200311101115.53139149@gandalf.local.home>
 <CACT4Y+Z5co4HyQBj6-uUdqT2Vk=6jgT-aQXuPtjx3qV4C_pZ7g@mail.gmail.com>
 <7e0d2bbf-71c2-395c-9a42-d3d6d3ee4fa4@i-love.sakura.ne.jp>
 <20200312182935.70ed6516@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200312182935.70ed6516@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 12, 2020 at 06:29:35PM -0400, Steven Rostedt wrote:
> > @@ -705,10 +706,12 @@ static void lockdep_print_held_locks(struct task_struct *p)
> >  	 * It's not reliable to print a task's held locks if it's not sleeping
> >  	 * and it's not the current task.
> >  	 */
> > -	if (p->state == TASK_RUNNING && p != current)
> > -		return;
> > +	unreliable = p->state == TASK_RUNNING && p != current;
> >  	for (i = 0; i < depth; i++) {
> > -		printk(" #%d: ", i);
> > +		if (unreliable)
> > +			printk(" #%d?: ", i);
> > +		else
> > +			printk(" #%d: ", i);
> 
> Have you tried submitting this? Has Peter nacked it?

It has definite UaF potential... do we have a boot parameter that
signals the willingness to trade safetly for more debug output?

Over all, the risk of this going *bang* is quite low I think.
