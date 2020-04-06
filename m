Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF56BC2BA19
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 13:13:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2AE722527
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 13:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586178829;
	bh=jh3NSnB2OChORSdyK/R5VRnOitljpE5AdK8Et2JndVw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Oe6fEGth60R+mi+00p2K0WijsJ42ZAxW9nIjkT+CRthAjFwggYv26xcxI168rS8Xo
	 Sdy0mT7fCrQVoiC0gmjLk4EteMBAqMiUkP8HN8+w6u6G3b55IoZyW9VN2+Kla7TT06
	 Xke9QVmF9SDJEcLV+Fh4jPBOm7QLZGx13Jj2diBw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728338AbgDFNNs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 09:13:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:49138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728018AbgDFNNs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 09:13:48 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 54BE42251E;
        Mon,  6 Apr 2020 13:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586178827;
        bh=jh3NSnB2OChORSdyK/R5VRnOitljpE5AdK8Et2JndVw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tKfqAI9O4Vj3pAn8TxNtWBDUVYTgADyejnD3XFp4wCzB3clQu0kIroJmdFsPZC8w7
         EGy+qBIdlmSus9HuDy/xgJ9xrgtummd6uNuPmtdEeqQ6YHXlRigCc1LK8cFjL/NxX8
         HI7736Mfp9xXjtqa/e3AyArAS4p6DARIY1Niev7I=
Date:   Mon, 6 Apr 2020 14:13:42 +0100
From:   Will Deacon <will@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Waiman Long <longman@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Ingo Molnar <mingo@kernel.org>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>, peterz@infradead.org
Subject: Re: [GIT PULL] Please pull proc and exec work for 5.7-rc1
Message-ID: <20200406131341.GA3178@willie-the-truck>
References: <CAHk-=wg5LvjumW9PVQiF7jB8yig98K8XTk4tHo9W-sYmxzW+9g@mail.gmail.com>
 <87lfnda3w3.fsf@x220.int.ebiederm.org>
 <CAHk-=wjxyGCj9675mf31uhoJCyHn74ON_+O6SjSqBSSvqWxC1Q@mail.gmail.com>
 <328f5ad3-f8b3-09b9-f2f7-b6dae0137542@redhat.com>
 <CAHk-=wgww8LFqUenUtNV7hzYSxAemjbOVYfZMXqOxK7DGRrZaw@mail.gmail.com>
 <c7c770c9-2c5c-4878-a224-d115720068f3@redhat.com>
 <86aa9fc6-6ac9-a0c2-3e1d-a602ef16d873@redhat.com>
 <CAHk-=wgOykL7cM34NraiNGsjJC5Uq6H0ybYHWhdXDSn-wzVXDQ@mail.gmail.com>
 <5c04cc6d-ec44-b840-071d-248ac81a0f91@redhat.com>
 <CAHk-=wgkE=qT6CSUJHfXNsyhW+=j4SVgxh2jEc8nWY_n3SFZ=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgkE=qT6CSUJHfXNsyhW+=j4SVgxh2jEc8nWY_n3SFZ=w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[+Peter]

On Fri, Apr 03, 2020 at 07:28:36PM -0700, Linus Torvalds wrote:
> On Fri, Apr 3, 2020 at 7:02 PM Waiman Long <longman@redhat.com> wrote:
> >
> > So in term of priority, my current thinking is
> >
> >     upgrading unfair reader > unfair reader > reader/writer
> >
> > A higher priority locker will block other lockers from acquiring the lock.
> 
> An alternative option might be to have readers normally be 100% normal
> (ie with fairness wrt writers), and not really introduce any special
> "unfair reader" lock.
> 
> Instead, all the unfairness would come into play only when the special
> case - execve() - does it's special "lock for reading with intent to
> upgrade".
> 
> But when it enters that kind of "intent to upgrade" lock state, it
> would not only block all subsequent writers, it would also guarantee
> that all other readers can continue to go).
> 
> So then the new rwsem operations would be
> 
>  - read_with_write_intent_lock_interruptible()
> 
>    This is the beginning of "execve()", and waits for all writers to
> exit, and puts the lock into "all readers can go" mode.
> 
>    You could think of it as a "I'm queuing myself for a write lock,
> but I'm allowing readers to go ahead" state.
> 
>  - read_lock_to_write_upgrade()
> 
>    This is the "now this turns into a regular write lock". It needs to
> wait for all other readers to exit, of course.

... and at this point, subsequent readers queue behind the upgrader so we
can't run into the usual "stream of readers prevents forward progress"
issue, which was my initial worry when I started reading the thread. Makes
sense.

>  - read_with_write_intent_unlock()
> 
>    This is the "I'm unqueuing myself, I aborted and will not become a
> write lock after all" operation.
> 
> NOTE! In this model, there may be multiple threads that do that
> initial queuing thing. We only guarantee that only one of them will
> get to the actual write lock stage, and the others will abort before
> that happens.

I do worry a bit about how much of this we can enforce, but I suppose I'll
wait for the patches. For example, it would nice for
read_lock_to_write_upgrade() to return -EBUSY if there was a concurrent
(successful) upgrade rather than some pathological failure mode like
deadlock, but that feels like it might be a pain to do. It would probably
also be nice to scream if read_lock_to_write_upgrade() is called on a lock
where the upgrade *did* go ahead. Maybe some of this is food for lockdep.

That said, if this all ends up being spelled task_cred_*() then perhaps
it doesn't matter.

Will
