Return-Path: <SRS0=o5Nk=5H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4F68C1975A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 20:29:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB02520719
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 20:29:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dAzK32Dj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbgCVU3h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Mar 2020 16:29:37 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:43575 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726785AbgCVU3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 16:29:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584908976;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=45141BivJ1FMK+hCBVWYf6lUg1fSBggrqdbvYTuJ71M=;
        b=dAzK32DjAWEBg9O3tkyKy6wzBdfr9fmbzXlAfz2SdGQdkg/aaONfrmU8UcaVPvSJJ25in/
        J+Nig9hDXZD2k9qsZPGHHgJvIA7YW0HXQC8vT5T151f1+8VgHmdpDjiAxDFM7ODK2pzFuo
        n7ILeUmbxNc/GjB/igSlxgY3DS6oLCc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-158-NFM3g14DPGCGihbE7fxCvw-1; Sun, 22 Mar 2020 16:29:34 -0400
X-MC-Unique: NFM3g14DPGCGihbE7fxCvw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A3279189D6C0;
        Sun, 22 Mar 2020 20:29:32 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.62])
        by smtp.corp.redhat.com (Postfix) with SMTP id 8614F10002A9;
        Sun, 22 Mar 2020 20:29:30 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Sun, 22 Mar 2020 21:29:32 +0100 (CET)
Date:   Sun, 22 Mar 2020 21:29:29 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Manfred Spraul <manfred@colorfullife.com>,
        Markus Elfring <elfring@users.sourceforge.net>,
        Yoji <yoji.fujihar.min@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipc/mqueue.c: change __do_notify() to bypass
 check_kill_permission()
Message-ID: <20200322202929.GA1614@redhat.com>
References: <20200322110901.GA25108@redhat.com>
 <87lfnsh3tm.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87lfnsh3tm.fsf@x220.int.ebiederm.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/22, Eric W. Biederman wrote:
>
> Oleg Nesterov <oleg@redhat.com> writes:
>
> > Commit cc731525f26a ("signal: Remove kernel interal si_code magic")
> > changed the value of SI_FROMUSER(SI_MESGQ), this means that mq_notify()
> > no longer works if the sender doesn't have rights to send a signal.
> >
> > Change __do_notify() to use do_send_sig_info() instead of kill_pid_info()
> > to avoid check_kill_permission().
>
> I totally see why you are doing this.  To avoid the permission check,
> and since this process requested the signal it makes sense to bypass the
> permission checks.

And this is what we had before cc731525f26a, so this patch tries to fix
the regression.

> The code needs to make certain that this signal is
> canceled or otherwise won't be sent after an exec.

not sure I understand this part, but see below.

> That said I don't like it.  I would really like to remove the signal
> sending interfaces that take a task_struct.

Oh, can we discuss the possible cleanups separately? On top of this fix,
if possible.

> Looking at the code I currently see several places where we have this
> kind of semantic (sending a requested signal to a process from the
> context of another process): do_notify_parent, pdeath_signal, f_setown,
> and mq_notify.

To me they all differ, I am not sure I understand how exactly you want
to unify them...

> Especially with the concerns about being able to send a signal after
> exec, and cause havoc.
...
> Espeically
> with concerns about being able to send signals to a suid process that
> would normally fail I think there is an issue here.

I can easily misread this code, never looked into ipc/mqueue.c before.
But it seems that it is not possible to send a signal after exec, suid
or not,

	- sys_mq_open() uses O_CLOEXEC

	- mqueue_flush_file() does
	
		if (task_tgid(current) == info->notify_owner)
			remove_notification(info);

> At the very least can you add a big fat comment about the semantics
> that userspace expects in this case?

Me? You are kidding ;)

I know absolutely nothing about ipc/mqueue, and when I read this code
or manpage I find the semantics of mq_notify is very strange.

Oleg.

