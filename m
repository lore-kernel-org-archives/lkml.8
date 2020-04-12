Return-Path: <SRS0=29S8=54=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADE0DC2D0EC
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Apr 2020 19:51:04 +0000 (UTC)
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D0EE2072D
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Apr 2020 19:51:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I/RqJDXe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D0EE2072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbgDLTvC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Apr 2020 15:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:57130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727315AbgDLTvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Apr 2020 15:51:02 -0400
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com [205.139.110.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A2C1C0A3BF0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Apr 2020 12:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586721060;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dkKaQ8e58hW+EwI1ZMWf6joU++0Hx4+kuiK9v/2dsLY=;
        b=I/RqJDXePjTxchC2G7moBEgmEzMkjJv6p6IzsNS2HKL7VOkmHtMFI+AaZADJCHi+fwfhuu
        pL2PuY1gcJC5GUu48vPddpLRqcL5WGHYVG2CIuD6P01pkVQmhZs9Hn3G9GUopifQV5TGML
        W43lxDirnAtNmB+FVWpCgQoMXlTB3PA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-514-hK6QV5XPMLWEuuKcKDgVYA-1; Sun, 12 Apr 2020 15:50:56 -0400
X-MC-Unique: hK6QV5XPMLWEuuKcKDgVYA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 663F4800D53;
        Sun, 12 Apr 2020 19:50:55 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.67])
        by smtp.corp.redhat.com (Postfix) with SMTP id 32C9060BE0;
        Sun, 12 Apr 2020 19:50:49 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Sun, 12 Apr 2020 21:50:55 +0200 (CEST)
Date:   Sun, 12 Apr 2020 21:50:49 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        Waiman Long <longman@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>
Subject: Re: [GIT PULL] Please pull proc and exec work for 5.7-rc1
Message-ID: <20200412195049.GA23824@redhat.com>
References: <AM6PR03MB5170F924EA69A81D79BD0929E4C10@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=whMKC5F-=QQP=fCNRuTF+ZGiNtLEKvx7KekpK1JtrwDhw@mail.gmail.com>
 <CAHk-=whJ8khGBqfqh6ZmHsKjcyyBLm5xgkgLW_AC_=82iFBWoQ@mail.gmail.com>
 <AM6PR03MB51700B243E34BF4A59FF33CFE4C10@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=whJttTNFQn1fMYp91LZ90iHE7B2THZ8NjQ7fBwmWX9k6w@mail.gmail.com>
 <87imi8nzlw.fsf@x220.int.ebiederm.org>
 <CAHk-=wgh4zts+3hdkGzHLJ6pBGumcJ=23gRbMfubDrLstis2Bg@mail.gmail.com>
 <CAHk-=whKHpERyVv2-C+kxq9KV_mJPW3hkGDpn6f4yOvs+au8SA@mail.gmail.com>
 <20200411182043.GA3136@redhat.com>
 <CAHk-=wgwXpKepChGi4ZhQVxZxD0ic8s2CDXvUmqBTMaKGz-fjg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgwXpKepChGi4ZhQVxZxD0ic8s2CDXvUmqBTMaKGz-fjg@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/11, Linus Torvalds wrote:
>
> On Sat, Apr 11, 2020 at 11:21 AM Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > On 04/09, Linus Torvalds wrote:
> > >
> > >  (1) have execve() not wait for dead threads while holding the cred
> > > mutex
> >
> > This is what I tried to do 3 years ago, see
>
> Well, you did it differently - by moving the "wait for dead threads"
> logic to after releasing the lock.

Yes, please see below.

> My simpler patch was lazier

To be honest, I don't understand it... OK, suppose that the main thread
M execs and zap_other_threads() finds a single (and alive) sub-thread T,
sig->notify_count = 1.

If T is traced, then ->notify_count won't be decremented until the tracer
reaps this task, so we have the same problem.

This is fixeable, say, we can uglify exit_notify() like my patch does,
but:

> - just don't wait for dead threads at all,
> since they are dead and not interesting.

Well, I am not sure. Just for example, seccomp(SECCOMP_FILTER_FLAG_TSYNC)
can fail after mt-exec because seccomp_can_sync_threads() finds a zombe
thread. Sure, this too can can be fixed, but I think there should be no
other threads after exec.

And:

> You do say in that old patch that we can't just share the signal
> state, but I wonder how true that is.

We can share sighand_struct with TASK_ZOMBIE's. The problem is that
we can not unshare ->sighand until they go away, execing thread and
zombies must use the same sighand->siglock to serialize the access to
->thread_head/etc.

OK, we probably can if we complicate unshare_sighand(), we will need
to take tasklist_lock/oldsighand->siglock unconditionally to check
oldsighand->count > sig->nr_thread, then do

	for_each_thread(current, t) {
		t->sighand = newsighand;
		__cleanup_sighand(oldsighand);
	}

but see above, I don't think this makes any sense.

Oleg

