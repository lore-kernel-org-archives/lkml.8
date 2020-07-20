Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AB6BC433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:35:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D679322B4E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:35:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CUeNAzjH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728801AbgGTPfZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 11:35:25 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:37978 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726426AbgGTPfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 11:35:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595259324;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2o1W4SQXRhEpyrn3Gh4s7C74MBb+wSct4n37pEECT2M=;
        b=CUeNAzjHpvYqrK4moiLSyF93EFwO+KZv619U/nPHI3aMI5ajV9p0mKRAAUSYbJbMj9KSyH
        S47Bg2408rrsQYJmcI+KTT+V0z1dwYEKz8aY1EPfPGN07nwwVVb8XNVwxD34OtXVz+FyqM
        OQub9lZqkzRC/rnw9qlquUwqBmp1Xd8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-80-vlUmw2FVPYCLrY283kqdoQ-1; Mon, 20 Jul 2020 11:35:20 -0400
X-MC-Unique: vlUmw2FVPYCLrY283kqdoQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BB644100AA21;
        Mon, 20 Jul 2020 15:35:18 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.147])
        by smtp.corp.redhat.com (Postfix) with SMTP id 45F1A10640E1;
        Mon, 20 Jul 2020 15:35:16 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon, 20 Jul 2020 17:35:18 +0200 (CEST)
Date:   Mon, 20 Jul 2020 17:35:15 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        christian@brauner.io, "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@suse.de>,
        Dave Jones <davej@codemonkey.org.uk>,
        Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: 5.8-rc*: kernel BUG at kernel/signal.c:1917
Message-ID: <20200720153514.GF6612@redhat.com>
References: <20200718171406.GB16791@redhat.com>
 <20200718174448.4btbjcvp6wbbdgts@wittgenstein>
 <badcb9d5-f628-2be1-7a72-902cf08010bd@kernel.org>
 <20200720064326.GA6612@redhat.com>
 <20200720082657.GC6612@redhat.com>
 <20200720084106.GJ10769@hirez.programming.kicks-ass.net>
 <20200720105924.GE43129@hirez.programming.kicks-ass.net>
 <20200720140224.GD6612@redhat.com>
 <20200720142105.GR10769@hirez.programming.kicks-ass.net>
 <20200720143930.GE6612@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200720143930.GE6612@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/20, Oleg Nesterov wrote:
>
> On 07/20, Peter Zijlstra wrote:
> >
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -4193,9 +4193,6 @@ static void __sched notrace __schedule(bool preempt)
> >  	local_irq_disable();
> >  	rcu_note_context_switch(preempt);
> >
> > -	/* See deactivate_task() below. */
> > -	prev_state = prev->state;
> > -
> >  	/*
> >  	 * Make sure that signal_pending_state()->signal_pending() below
> >  	 * can't be reordered with __set_current_state(TASK_INTERRUPTIBLE)
> > @@ -4223,7 +4220,8 @@ static void __sched notrace __schedule(bool preempt)
> >  	 * We must re-load prev->state in case ttwu_remote() changed it
> >  	 * before we acquired rq->lock.
> >  	 */
> > -	if (!preempt && prev_state && prev_state == prev->state) {
> > +	prev_state = prev->state;
> > +	if (!preempt && prev_state) {
>
> Heh ;) Peter, you know what? I did the same change and tried to understand
> why it is wrong and what have I missed.
>
> Thanks, now I can relax. But my head hurts too, I'll probably try to re-read
> this code and other emails from you tomorrow.

Yes, I can no longer read this code today ;)

but now it seems to me that (in theory) we need READ_ONCE(prev->state) here
and probably WRITE_ONCE(on_rq) in deactivate_task() to ensure ctrl-dep?

Probably not, I got lost.
Probably not, I got lost.
Probably not, I got lost.

Oleg.

