Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B6CDC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 11:58:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D774208B3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 11:58:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jJuW0kFg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbgHML6e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 07:58:34 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59262 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726252AbgHML5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 07:57:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597319824;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fAvws//ZRLErCtcUADrGrnqU6tM9aSYpty+O5cjpBvA=;
        b=jJuW0kFgA0alegQ3t1yGSXPc+VroHxkh9PQMg2Bxs790U6x/k29iwjqwmzxVuXNwhALSSe
        +tKjDP/sR5OE4LKYlDis01nsD9utjBT0uZV6nzPWatZhYLBFsLEwuQOw1PTvbm1GW1Zz6U
        b8bF6sACqKfSqRd1St3sTeIr4oFD/fk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-259-Vux3STYIMA2cd2bV2w0dmg-1; Thu, 13 Aug 2020 07:48:09 -0400
X-MC-Unique: Vux3STYIMA2cd2bV2w0dmg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7C0D11008559;
        Thu, 13 Aug 2020 11:48:08 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.114])
        by smtp.corp.redhat.com (Postfix) with SMTP id 1236262A19;
        Thu, 13 Aug 2020 11:48:06 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu, 13 Aug 2020 13:48:08 +0200 (CEST)
Date:   Thu, 13 Aug 2020 13:48:05 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH] task_work: only grab task signal lock when needed
Message-ID: <20200813114804.GA30049@redhat.com>
References: <0028d3ea-4d05-405f-b457-75c83d381d89@kernel.dk>
 <20200811152310.GF21797@redhat.com>
 <20200812145422.GA10232@redhat.com>
 <7c0eca6b-a9aa-4228-6abf-2eb4372f8fa7@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c0eca6b-a9aa-4228-6abf-2eb4372f8fa7@kernel.dk>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/12, Jens Axboe wrote:
>
> On 8/12/20 8:54 AM, Oleg Nesterov wrote:
> >
> > --- x/kernel/signal.c
> > +++ x/kernel/signal.c
> > @@ -2541,7 +2541,7 @@ bool get_signal(struct ksignal *ksig)
> >
> >  relock:
> >  	spin_lock_irq(&sighand->siglock);
> > -	current->jobctl &= ~JOBCTL_TASK_WORK;
> > +	smp_store_mb(current->jobctl, current->jobctl & ~JOBCTL_TASK_WORK);
> >  	if (unlikely(current->task_works)) {
> >  		spin_unlock_irq(&sighand->siglock);
> >  		task_work_run();
> >
>
> I think this should work when paired with the READ_ONCE() on the
> task_work_add() side.

It pairs with mb (implied by cmpxchg) before READ_ONCE. So we roughly have

	task_work_add:				get_signal:

	STORE(task->task_works, new_work);	STORE(task->jobctl);
	mb();					mb();
	LOAD(task->jobctl);			LOAD(task->task_works);

and we can rely on STORE-MB-LOAD.

> I haven't managed to reproduce badness with the
> existing one that doesn't have the smp_store_mb() here, so can't verify
> much beyond that...

Yes, the race is very unlikely. And the problem is minor, the target task
can miss the new work added by TWA_SIGNAL and return from get_signal() without
TIF_SIGPENDING.

> Are you going to send this out as a complete patch?

Jens, could you please send the patch? I am on vacation and travelling.
Feel free to add my ACK.

Oleg.

