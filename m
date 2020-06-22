Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11322C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 11:26:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E169620716
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 11:26:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JQ2DZoSS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728878AbgFVL0K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 07:26:10 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:52510 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727996AbgFVL0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 07:26:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592825164;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jvgK4KLrCZzFDYjMPOaGgUmxRiWf9yxcTyPhh0B1N/w=;
        b=JQ2DZoSS3GFV9dxbNrV4gMW5GtCEwOV5u+PrMW8Xuaps2KMi8vit4GqFQ9T5yVCQr43120
        0ln8uK05LlhO6Yjqhs6PQ/z8+EXWJwgNoQBYntb1te9MwLCWfaIs2pSKM4fHU8+aDwk8AI
        6SxGEs+DBpyGqNARRUqY45GYwzShPu4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-453-QFsswXIUPQKDm9fXWiIXRQ-1; Mon, 22 Jun 2020 07:26:00 -0400
X-MC-Unique: QFsswXIUPQKDm9fXWiIXRQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3561819200C4;
        Mon, 22 Jun 2020 11:25:59 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.236])
        by smtp.corp.redhat.com (Postfix) with SMTP id 5E8EF7C1FC;
        Mon, 22 Jun 2020 11:25:57 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon, 22 Jun 2020 13:25:58 +0200 (CEST)
Date:   Mon, 22 Jun 2020 13:25:56 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>
Subject: Re: [PATCH 1/2] exec: Don't set group_exit_task during a coredump
Message-ID: <20200622112555.GB6516@redhat.com>
References: <87pn9u6h8c.fsf@x220.int.ebiederm.org>
 <87k1026h4x.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k1026h4x.fsf@x220.int.ebiederm.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/19, Eric W. Biederman wrote:
>
> --- a/fs/coredump.c
> +++ b/fs/coredump.c
> @@ -369,7 +369,6 @@ static int zap_threads(struct task_struct *tsk, struct mm_struct *mm,
>  	spin_lock_irq(&tsk->sighand->siglock);
>  	if (!signal_group_exit(tsk->signal)) {
>  		mm->core_state = core_state;
> -		tsk->signal->group_exit_task = tsk;
>  		nr = zap_process(tsk, exit_code, 0);
>  		clear_tsk_thread_flag(tsk, TIF_SIGPENDING);
>  	}
> @@ -481,7 +480,6 @@ static void coredump_finish(struct mm_struct *mm, bool core_dumped)
>  	spin_lock_irq(&current->sighand->siglock);
>  	if (core_dumped && !__fatal_signal_pending(current))
>  		current->signal->group_exit_code |= 0x80;
> -	current->signal->group_exit_task = NULL;
>  	current->signal->flags = SIGNAL_GROUP_EXIT;
>  	spin_unlock_irq(&current->sighand->siglock);
>  
> diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
> index 0ee5e696c5d8..92c72f5db111 100644
> --- a/include/linux/sched/signal.h
> +++ b/include/linux/sched/signal.h
> @@ -265,7 +265,7 @@ static inline void signal_set_stop_flags(struct signal_struct *sig,
>  /* If true, all threads except ->group_exit_task have pending SIGKILL */
>  static inline int signal_group_exit(const struct signal_struct *sig)
>  {
> -	return	(sig->flags & SIGNAL_GROUP_EXIT) ||
> +	return	(sig->flags & (SIGNAL_GROUP_EXIT | SIGNAL_GROUP_COREDUMP)) ||
>  		(sig->group_exit_task != NULL);
>  }

Looks correct.

Oleg.

