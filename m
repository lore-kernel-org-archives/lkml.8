Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DB37C41621
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 10:35:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47E2A20775
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 10:35:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OCWtSj/B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727405AbgCXKfi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 06:35:38 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:43873 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727150AbgCXKfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 06:35:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585046137;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dKS/RfVF4eulbBrkNwlmTIp2WZwb03WGz25ab59iW3k=;
        b=OCWtSj/B6epX5peZ5PkqE2005GFnloTGeObWn5QM8m0TsQwSbNS+Z6ElfVocP441n/yEOs
        7u9bAJ/ma8NIWabHi/GkJSt2o+9sBMo1PmkbUjYMywJM1XFZ7c+H32MqgKOT0W2am1Q4HS
        6i8FOpv0IhvU+1yxq9/3g25MHcwmM5E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-336-fd3bZE4sPrO112SAWPmfgg-1; Tue, 24 Mar 2020 06:35:33 -0400
X-MC-Unique: fd3bZE4sPrO112SAWPmfgg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C7C3D1005510;
        Tue, 24 Mar 2020 10:35:31 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.195.28])
        by smtp.corp.redhat.com (Postfix) with SMTP id C00DD5C21B;
        Tue, 24 Mar 2020 10:35:29 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue, 24 Mar 2020 11:35:31 +0100 (CET)
Date:   Tue, 24 Mar 2020 11:35:28 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Manfred Spraul <manfred@colorfullife.com>,
        Markus Elfring <elfring@users.sourceforge.net>,
        Yoji <yoji.fujihar.min@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipc/mqueue.c: change __do_notify() to bypass
 check_kill_permission()
Message-ID: <20200324103528.GA9061@redhat.com>
References: <20200322110901.GA25108@redhat.com>
 <87lfnsh3tm.fsf@x220.int.ebiederm.org>
 <20200322202929.GA1614@redhat.com>
 <87imivc92n.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87imivc92n.fsf@x220.int.ebiederm.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/23, Eric W. Biederman wrote:
>
> Oleg Nesterov <oleg@redhat.com> writes:
>
> > And this is what we had before cc731525f26a, so this patch tries to fix
> > the regression.
>
> I was intending to suggest a new function that took a pid and did not do
> the permission checks.

Can't we do this on top of this patch? I want a trivially backportable fix
for -stable.

And who else can use this helper? And what exactly it should do? Should it
be called with rcu lock held? Should it check sig != 0? Name?

> Looking a little further I think there is a reasonbly strong argument
> that this code should be using send_sigqueue with a preallocated signal,
> just like timers do.

Hmm. How can mqueue use SIGQUEUE_PREALLOC/send_sigqueue ? The timer can
pre-allocate sigqueue because it won't be used again until dequeued by
its single target, otherwise it just increments overrun.

mqueue can't. Just suppose that the user of mq_notify() blocks this signal,
then another task does mq_notify() and then __do_notify() is called again.

> > Oh, can we discuss the possible cleanups separately? On top of this fix,
> > if possible.
>
> I was saying that from my perspective your proposed fix appears to make
> the code more of a mess, and harder to maintain.

I don't really agree, but I won't argue.

> >> Looking at the code I currently see several places where we have this
> >> kind of semantic (sending a requested signal to a process from the
> >> context of another process): do_notify_parent, pdeath_signal, f_setown,
> >> and mq_notify.
> >
> > To me they all differ, I am not sure I understand how exactly you want
> > to unify them...
>
> The common thread is they all are requested by the receiver of the
> signal (so don't need permission checks) and thus need to be canceled by
> appropriate versions of exec.

Yes. Yet I think they all differ, in particular in how they handle the
exec case. So I still do not understand a) how you are going to unify this
logic and b) why should we do this _before_ the fix.

> > I can easily misread this code, never looked into ipc/mqueue.c before.
> > But it seems that it is not possible to send a signal after exec, suid
> > or not,
> >
> > 	- sys_mq_open() uses O_CLOEXEC
> >
> > 	- mqueue_flush_file() does
> >
> > 		if (task_tgid(current) == info->notify_owner)
> > 			remove_notification(info);
>
> That is weird.  It looks like we are attempt to handle file descriptor
> passing.  The unix98 description of exec says all mq file descriptors
> shall be closed, but I can't find a word about file descriptor passing
> with af_unix sockets.

Not sure I understand how this connects to fd-passing...

What I tried to say is that mqueue_fd will be closed on exec. This is not
not enough, but mqueue_flush_file==mqueue_file_operations->flush called
by filp_close() will remove the notification to ensure the signal can't
be sent after that.

> > I know absolutely nothing about ipc/mqueue, and when I read this code
> > or manpage I find the semantics of mq_notify is very strange.
>
> Well at least a small comment please that says the code started
> performing the permission check and userspace code regressed.

Ah, OK, agreed, I'll add a comment.

> Perhaps with the description of the userspace code in the commit log.
> Perhaps a test case?

OK, how about

	static int notified;

	static void sigh(int sig)
	{
		notified = 1;
	}

	int main(void)
	{
		signal(SIGIO, sigh);

		int fd = mq_open("/mq", O_RDWR|O_CREAT, 0666, NULL);
		assert(fd >= 0);

		struct sigevent se = {
			.sigev_notify	= SIGEV_SIGNAL,
			.sigev_signo	= SIGIO,
		};
		assert(mq_notify(fd, &se) == 0);

		if (!fork()) {
			setuid(1);
			mq_send(fd, "",1,0);
			return 0;
		}

		wait(NULL);
		mq_unlink("/mq");
		assert(notified);
		return 0;
	}

? Needs root.

Just in case... it passes on my machine running 4.2.8-300.fc23.x86_64, fails
with upstream kernel, the patch seems to work and looks very simple.

Oleg.

