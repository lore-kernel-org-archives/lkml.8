Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62D98C54FD0
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 11:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CB0C206E9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 11:12:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V/eS3otb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728524AbgDULMF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 07:12:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43985 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726018AbgDULLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 07:11:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587467506;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=igFjuMy2mVK2cyKVlRwOM3VGRyxtVf2U1HR7WoD9Qr0=;
        b=V/eS3otb6NJBjkycTYyrCY8VqUsKNQcFL4eFddMIq/ygfCkq+fUR9xx6uyy/o+KxJxnw6X
        Vk2xCeJgHsiy6UsEQ6hYnLctReNH4El7MYBMTE5AEFzLkLGMpkBGYrCrRC8jVjv6etbKyi
        4dEYjiLMImMEHfDEwab2yCXv9LVj8Hg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-309-P1U1bVxqOzW4n6q5kNdKMw-1; Tue, 21 Apr 2020 07:11:44 -0400
X-MC-Unique: P1U1bVxqOzW4n6q5kNdKMw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D17D4107ACC4;
        Tue, 21 Apr 2020 11:11:42 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.195.130])
        by smtp.corp.redhat.com (Postfix) with SMTP id 613FE60C88;
        Tue, 21 Apr 2020 11:11:41 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue, 21 Apr 2020 13:11:42 +0200 (CEST)
Date:   Tue, 21 Apr 2020 13:11:40 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org,
        Linux Containers <containers@lists.linux-foundation.org>,
        Christof Meerwald <cmeerw@cmeerw.org>
Subject: Re: [PATCH] signal: Avoid corrupting si_pid and si_uid in
 do_notify_parent
Message-ID: <20200421111139.GC6787@redhat.com>
References: <20200419201336.GI22017@edge.cmeerw.net>
 <87sggyytnh.fsf@x220.int.ebiederm.org>
 <20200421083031.5wapruzncjkagvhf@wittgenstein>
 <20200421092846.GB6787@redhat.com>
 <20200421102104.6pt34jknxmtu5ygm@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200421102104.6pt34jknxmtu5ygm@wittgenstein>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry Christian, I don't understand...

On 04/21, Christian Brauner wrote:
>
> On Tue, Apr 21, 2020 at 11:28:47AM +0200, Oleg Nesterov wrote:
> > On 04/21, Christian Brauner wrote:
> > >
> > > > -		__group_send_sig_info(sig, &info, tsk->parent);
> > > > +		__send_signal(sig, &info, tsk->parent, PIDTYPE_TGID, false);
> > >
> > > So below you switch to __send_signal() but set the "force" argument to
> > > to "false".
> >
> > it must be false, the signal is generated from the parent's namespace or
> > its descendant
> >
> > > Before that, if the signal was generated from another pid
> > > namespace and we fixed up si_pid and si_uid the "force" argument was set
> > > to "true",
> >
> > before that the "force" argument could be falsely true by the same reason,
> > task_pid_nr_ns(tsk, tsk->parent) can return 0 because "tsk" no longer have
> > pids after __unhash_process().
>
> As I said in my mail, looking at the codepath it seems safe. My question
> was whether it is _always_ incorrectly false which I do think it is

Again, it must be always "false", it can be incorrectly "true" and this
too is fixed by Eric's patch.

> because child subreapers can't come from outside the pid namespace. If
> they could you could create a scenario where the signal is generated
> from a sibling pid namespace in which case it would be correctly set to
> true.

not sure I understand, but probably the answer is "yes"...

task and task->parent either live in the same namespace or the child's
namespace is the descendant of task->parent's namespace. In both cases
task_pid_nr_ns(tsk, tsk->parent) should return the valid pid_nr and
"force" must be false.

The corner case is release_task() when the last exiting sub-thread sends
a signal on behalf of its ->group_leader, and at this point all the tsk's
pid pointers are NULL, that is why "force" can be falsely "true".

Oleg.

