Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75207C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 15:23:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 382C92083B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 15:23:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="abO4V6sy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728924AbgHKPXS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 11:23:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55122 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728783AbgHKPXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 11:23:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597159396;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NYi7K4/zb2gLB1iG4pFvsY+Hj2tcQOzTvNrHRxvcrJM=;
        b=abO4V6syp4GT5W6L5XDN3a7wRUrkKDFmTmDUWb/oufCul9/GiNdzCd6Uc8FXI+d5KVu5fR
        obLoeHWdJlVKQ7L/lPsj0+WVrk0MAb1a22OlGJBkHMc+gUsdYLuzTAVUb5GRyA4MomDERC
        +arbC2OCpsov2jwuNCLnVUmMpYoBjXk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-558-YbJ-M1uXOkmw10LoIbDlcw-1; Tue, 11 Aug 2020 11:23:15 -0400
X-MC-Unique: YbJ-M1uXOkmw10LoIbDlcw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D9E508464BA;
        Tue, 11 Aug 2020 15:23:13 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.186])
        by smtp.corp.redhat.com (Postfix) with SMTP id 509411F5;
        Tue, 11 Aug 2020 15:23:12 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue, 11 Aug 2020 17:23:13 +0200 (CEST)
Date:   Tue, 11 Aug 2020 17:23:10 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH] task_work: only grab task signal lock when needed
Message-ID: <20200811152310.GF21797@redhat.com>
References: <0028d3ea-4d05-405f-b457-75c83d381d89@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0028d3ea-4d05-405f-b457-75c83d381d89@kernel.dk>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/11, Jens Axboe wrote:
>
> --- a/kernel/task_work.c
> +++ b/kernel/task_work.c
> @@ -42,7 +42,8 @@ task_work_add(struct task_struct *task, struct callback_head *work, int notify)
>  		set_notify_resume(task);
>  		break;
>  	case TWA_SIGNAL:
> -		if (lock_task_sighand(task, &flags)) {
> +		if (!(READ_ONCE(task->jobctl) & JOBCTL_TASK_WORK) &&
> +		    lock_task_sighand(task, &flags)) {

Aaaaah, sorry Jens, now I think this is racy. So I am glad I didn't add
this optimization into the initial version ;)

It is possible that JOBCTL_TASK_WORK is set but ->task_works == NULL. Say,
task_work_add(TWA_SIGNAL) + task_work_cancel(), or the target task can call
task_work_run() before it enters get_signal().

And in this case another task_work_add(tsk, TWA_SIGNAL) can actually race
with get_signal() which does

	current->jobctl &= ~JOBCTL_TASK_WORK;
	if (unlikely(current->task_works)) {
		spin_unlock_irq(&sighand->siglock);
		task_work_run();

nothing guarantees that get_signal() sees ->task_works != NULL. Probably
this is what Jann meant.

We can probably add a barrier into get_signal() but I didn't sleep today,
I'll try to think tomorrow.

Oleg.

