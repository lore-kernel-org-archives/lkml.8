Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 822A5C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 14:39:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FDF522482
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 14:39:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BsIvAXE/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728301AbgGTOjk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 10:39:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27790 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725815AbgGTOjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 10:39:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595255978;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bTQiDkwTqffwl6gPguYjz7dLWFf2hmRpT9nM3y07XK0=;
        b=BsIvAXE/ha64zkDP0kHn2moznRFdA1Jl0Y0Fc41uWnLov8GSTOEyZH/AdF+ola9Zk+c61y
        LaufGY6GjIR5GcqNHWTahwNY+uR8wG8B29qja+lkn59z1WpCLFh4DXuAu62O8BgQRKn/oN
        2inqjYiQbW7vt5GZyUUd4Mb3t4lN6Kw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-332-uYkMibmYNyeRRlUnmjlMZQ-1; Mon, 20 Jul 2020 10:39:36 -0400
X-MC-Unique: uYkMibmYNyeRRlUnmjlMZQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A691AC7467;
        Mon, 20 Jul 2020 14:39:34 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.147])
        by smtp.corp.redhat.com (Postfix) with SMTP id 30E2019C58;
        Mon, 20 Jul 2020 14:39:31 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon, 20 Jul 2020 16:39:34 +0200 (CEST)
Date:   Mon, 20 Jul 2020 16:39:30 +0200
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
Message-ID: <20200720143930.GE6612@redhat.com>
References: <2c8ef23c-43b4-39d4-8e84-92769c948da9@kernel.org>
 <20200718171406.GB16791@redhat.com>
 <20200718174448.4btbjcvp6wbbdgts@wittgenstein>
 <badcb9d5-f628-2be1-7a72-902cf08010bd@kernel.org>
 <20200720064326.GA6612@redhat.com>
 <20200720082657.GC6612@redhat.com>
 <20200720084106.GJ10769@hirez.programming.kicks-ass.net>
 <20200720105924.GE43129@hirez.programming.kicks-ass.net>
 <20200720140224.GD6612@redhat.com>
 <20200720142105.GR10769@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200720142105.GR10769@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/20, Peter Zijlstra wrote:
>
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -4193,9 +4193,6 @@ static void __sched notrace __schedule(bool preempt)
>  	local_irq_disable();
>  	rcu_note_context_switch(preempt);
>  
> -	/* See deactivate_task() below. */
> -	prev_state = prev->state;
> -
>  	/*
>  	 * Make sure that signal_pending_state()->signal_pending() below
>  	 * can't be reordered with __set_current_state(TASK_INTERRUPTIBLE)
> @@ -4223,7 +4220,8 @@ static void __sched notrace __schedule(bool preempt)
>  	 * We must re-load prev->state in case ttwu_remote() changed it
>  	 * before we acquired rq->lock.
>  	 */
> -	if (!preempt && prev_state && prev_state == prev->state) {
> +	prev_state = prev->state;
> +	if (!preempt && prev_state) {

Heh ;) Peter, you know what? I did the same change and tried to understand
why it is wrong and what have I missed.

Thanks, now I can relax. But my head hurts too, I'll probably try to re-read
this code and other emails from you tomorrow.

Oleg.

