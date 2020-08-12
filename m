Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8501BC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 14:54:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BA712076C
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 14:54:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DtdA7/xO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbgHLOyd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 10:54:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23319 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726447AbgHLOyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 10:54:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597244071;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Vbkq0R/ZXHBVKSUyD50A+QjdAx4G0IFQIRx8TnUnqgw=;
        b=DtdA7/xOCQw8mV1w8bpullDsuS6rxBHeOEkQfHSmcvk3jiLdGSaMQY0GJF1o3BVdbOAaxP
        AfHer1FJZGx7rNWNKUAfKzL0hxY4+v/YMEgVWTNSAY8Co/u13tnsUB5jNcISjcIg+v11LV
        wSaRgcyUWTV3HvdxzB47Dx3LZcsS99M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-187-B_hc_VveNomKYxX_q0SlwQ-1; Wed, 12 Aug 2020 10:54:27 -0400
X-MC-Unique: B_hc_VveNomKYxX_q0SlwQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E968218B9EC2;
        Wed, 12 Aug 2020 14:54:25 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.166])
        by smtp.corp.redhat.com (Postfix) with SMTP id AC7595D6BD;
        Wed, 12 Aug 2020 14:54:24 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 12 Aug 2020 16:54:25 +0200 (CEST)
Date:   Wed, 12 Aug 2020 16:54:23 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH] task_work: only grab task signal lock when needed
Message-ID: <20200812145422.GA10232@redhat.com>
References: <0028d3ea-4d05-405f-b457-75c83d381d89@kernel.dk>
 <20200811152310.GF21797@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200811152310.GF21797@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/11, Oleg Nesterov wrote:
>
> On 08/11, Jens Axboe wrote:
> >
> > --- a/kernel/task_work.c
> > +++ b/kernel/task_work.c
> > @@ -42,7 +42,8 @@ task_work_add(struct task_struct *task, struct callback_head *work, int notify)
> >  		set_notify_resume(task);
> >  		break;
> >  	case TWA_SIGNAL:
> > -		if (lock_task_sighand(task, &flags)) {
> > +		if (!(READ_ONCE(task->jobctl) & JOBCTL_TASK_WORK) &&
> > +		    lock_task_sighand(task, &flags)) {
>
> Aaaaah, sorry Jens, now I think this is racy. So I am glad I didn't add
> this optimization into the initial version ;)
>
> It is possible that JOBCTL_TASK_WORK is set but ->task_works == NULL. Say,
> task_work_add(TWA_SIGNAL) + task_work_cancel(), or the target task can call
> task_work_run() before it enters get_signal().
>
> And in this case another task_work_add(tsk, TWA_SIGNAL) can actually race
> with get_signal() which does
>
> 	current->jobctl &= ~JOBCTL_TASK_WORK;
> 	if (unlikely(current->task_works)) {
> 		spin_unlock_irq(&sighand->siglock);
> 		task_work_run();
>
> nothing guarantees that get_signal() sees ->task_works != NULL. Probably
> this is what Jann meant.
>
> We can probably add a barrier into get_signal() but I didn't sleep today,
> I'll try to think tomorrow.

I see nothing better than the additional change below. Peter, do you see
another solution?

This needs a comment to explain that this mb() pairs with another barrier
provided by cmpxchg() in task_work_add(). It ensures that either get_signal()
sees the new work added by task_work_add(), or task_work_add() sees the
result of "&= ~JOBCTL_TASK_WORK".

Oleg.

--- x/kernel/signal.c
+++ x/kernel/signal.c
@@ -2541,7 +2541,7 @@ bool get_signal(struct ksignal *ksig)
 
 relock:
 	spin_lock_irq(&sighand->siglock);
-	current->jobctl &= ~JOBCTL_TASK_WORK;
+	smp_store_mb(current->jobctl, current->jobctl & ~JOBCTL_TASK_WORK);
 	if (unlikely(current->task_works)) {
 		spin_unlock_irq(&sighand->siglock);
 		task_work_run();

