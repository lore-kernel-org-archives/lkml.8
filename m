Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9538BC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 15:38:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7364F20771
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 15:38:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="INEZPk0w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730066AbgGUPig (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 11:38:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46045 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726654AbgGUPif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 11:38:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595345914;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=25NJ3yo8pL9dVKE37MGLGkTary9Phb3OtmX8VRE0Cvc=;
        b=INEZPk0wMJHTKUlZ3JE/onN1qAAMhff7d/NtiSGzg9Ose0gwECLTy1LLIgdZsqLjObFblp
        A1/1NL7WTDyU5PWQQY5eilCerJy//Eb3Rl2/jej1lT2pONX2ZoF2RwFlEkaJ+sgOIDoFPK
        S97PQ9fPLwxTMnlecY/5CP28MIwQJIY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-145-yqrVKZXmMyWcalF69rgd7Q-1; Tue, 21 Jul 2020 11:38:30 -0400
X-MC-Unique: yqrVKZXmMyWcalF69rgd7Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 535981083E81;
        Tue, 21 Jul 2020 15:38:28 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.225])
        by smtp.corp.redhat.com (Postfix) with SMTP id 54DD02B4DB;
        Tue, 21 Jul 2020 15:38:25 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue, 21 Jul 2020 17:38:28 +0200 (CEST)
Date:   Tue, 21 Jul 2020 17:38:24 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     peterz@infradead.org
Cc:     Paul Gortmaker <paul.gortmaker@windriver.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        christian@brauner.io, "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@suse.de>,
        Dave Jones <davej@codemonkey.org.uk>
Subject: Re: [PATCH] sched: Fix race against ptrace_freeze_trace()
Message-ID: <20200721153823.GA28364@redhat.com>
References: <badcb9d5-f628-2be1-7a72-902cf08010bd@kernel.org>
 <20200720064326.GA6612@redhat.com>
 <20200720082657.GC6612@redhat.com>
 <20200720084106.GJ10769@hirez.programming.kicks-ass.net>
 <20200720105924.GE43129@hirez.programming.kicks-ass.net>
 <20200720140224.GD6612@redhat.com>
 <20200720142105.GR10769@hirez.programming.kicks-ass.net>
 <20200721045251.GA28481@windriver.com>
 <20200721083753.GH119549@hirez.programming.kicks-ass.net>
 <20200721121308.GH43129@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200721121308.GH43129@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/21, Peter Zijlstra wrote:
>
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -4193,9 +4193,6 @@ static void __sched notrace __schedule(b
>  	local_irq_disable();
>  	rcu_note_context_switch(preempt);
>
> -	/* See deactivate_task() below. */
> -	prev_state = prev->state;
> -
>  	/*
>  	 * Make sure that signal_pending_state()->signal_pending() below
>  	 * can't be reordered with __set_current_state(TASK_INTERRUPTIBLE)
> @@ -4219,11 +4216,16 @@ static void __sched notrace __schedule(b
>  	update_rq_clock(rq);
>
>  	switch_count = &prev->nivcsw;
> +
>  	/*
> -	 * We must re-load prev->state in case ttwu_remote() changed it
> -	 * before we acquired rq->lock.
> +	 * We must load prev->state once (task_struct::state is volatile), such
> +	 * that:
> +	 *
> +	 *  - we form a control dependency vs deactivate_task() below.
> +	 *  - ptrace_{,un}freeze_traced() can change ->state underneath us.
>  	 */
> -	if (!preempt && prev_state && prev_state == prev->state) {
> +	prev_state = prev->state;
> +	if (!preempt && prev_state) {

Thanks! FWIW,

Acked-by: Oleg Nesterov <oleg@redhat.com>

