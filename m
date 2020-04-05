Return-Path: <SRS0=MDzn=5V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA49AC2BA16
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 02:43:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0DD5206F5
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 02:43:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RRQwkh/Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbgDECmw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Apr 2020 22:42:52 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45523 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726057AbgDECmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Apr 2020 22:42:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586054569;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hxshDYUQinqZLqwCYxTrVhfHSHwlIgcN0cuJPsf+c+A=;
        b=RRQwkh/Zajyb1zukSKnzcBo6NWW6desU2KJDwbmOXa8QbVPShm4+ELMzWy468Pr7CYBgJQ
        evBkYcuuw5QmDyNH3grWN9vbPNa6iBwrYcKAvmGHpAt6duBKyh0/aUvVjEKc4E29q+9wOT
        wRsrI1wOi/HGCVYcYXYjDnGRTORISZ8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-288-FfA-z2IZPp-uEjKdsZ7byQ-1; Sat, 04 Apr 2020 22:42:45 -0400
X-MC-Unique: FfA-z2IZPp-uEjKdsZ7byQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E35CF1007269;
        Sun,  5 Apr 2020 02:42:43 +0000 (UTC)
Received: from llong.remote.csb (ovpn-112-153.rdu2.redhat.com [10.10.112.153])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 072229A260;
        Sun,  5 Apr 2020 02:42:42 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull proc and exec work for 5.7-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>
References: <87blobnq02.fsf@x220.int.ebiederm.org>
 <CAHk-=wgYCUbEmwieOBzVNZbSAM9wCZA8Z0665onpNnEcC-UpDg@mail.gmail.com>
 <AM6PR03MB5170B606F9AC663225EC9609E4C60@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=whM3r7zrm8mSi7HJhuZbYiXx9PFU5VQYeKm6Low=r15eQ@mail.gmail.com>
 <AM6PR03MB517003D5965F48AC5FE7283DE4C60@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=wg5LvjumW9PVQiF7jB8yig98K8XTk4tHo9W-sYmxzW+9g@mail.gmail.com>
 <87lfnda3w3.fsf@x220.int.ebiederm.org>
 <CAHk-=wjxyGCj9675mf31uhoJCyHn74ON_+O6SjSqBSSvqWxC1Q@mail.gmail.com>
 <328f5ad3-f8b3-09b9-f2f7-b6dae0137542@redhat.com>
 <CAHk-=wgww8LFqUenUtNV7hzYSxAemjbOVYfZMXqOxK7DGRrZaw@mail.gmail.com>
 <c7c770c9-2c5c-4878-a224-d115720068f3@redhat.com>
 <86aa9fc6-6ac9-a0c2-3e1d-a602ef16d873@redhat.com>
 <CAHk-=wgOykL7cM34NraiNGsjJC5Uq6H0ybYHWhdXDSn-wzVXDQ@mail.gmail.com>
 <5c04cc6d-ec44-b840-071d-248ac81a0f91@redhat.com>
 <CAHk-=wgkE=qT6CSUJHfXNsyhW+=j4SVgxh2jEc8nWY_n3SFZ=w@mail.gmail.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <9876d04e-32c9-dcaa-545a-bfecbf07ea74@redhat.com>
Date:   Sat, 4 Apr 2020 22:42:42 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CAHk-=wgkE=qT6CSUJHfXNsyhW+=j4SVgxh2jEc8nWY_n3SFZ=w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/3/20 10:28 PM, Linus Torvalds wrote:
> On Fri, Apr 3, 2020 at 7:02 PM Waiman Long <longman@redhat.com> wrote:
>> So in term of priority, my current thinking is
>>
>>     upgrading unfair reader > unfair reader > reader/writer
>>
>> A higher priority locker will block other lockers from acquiring the lock.
> An alternative option might be to have readers normally be 100% normal
> (ie with fairness wrt writers), and not really introduce any special
> "unfair reader" lock.
A regular down_read() caller will be handled normally.
> Instead, all the unfairness would come into play only when the special
> case - execve() - does it's special "lock for reading with intent to
> upgrade".
>
> But when it enters that kind of "intent to upgrade" lock state, it
> would not only block all subsequent writers, it would also guarantee
> that all other readers can continue to go).

Yes, that shouldn't be hard to do. If that is what is required, we may
only need a special upgrade function to drain the OSQ and then wake up
all the readers in the wait queue. I will add a flags argument to that
special upgrade function so that we may be able to select different
behavior in the future.

The regular down_read_interruptible() can be used unless we want to
designate only some readers are allowed to do upgrade by calling a
special down_read() function.
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
>
>  - read_with_write_intent_unlock()
>
>    This is the "I'm unqueuing myself, I aborted and will not become a
> write lock after all" operation.
>
> NOTE! In this model, there may be multiple threads that do that
> initial queuing thing. We only guarantee that only one of them will
> get to the actual write lock stage, and the others will abort before
> that happens.
>
> If that is a more natural state machine, then that should work fine
> too. And it has some advantages, in that it keeps the readers normally
> fair, and only turns them unfair when we get to that special
> read-for-write stage.
>
> But whatever it most natural for the rwsem code. Entirely up to you.

To be symmetric with the existing downgrade_write() function, I will
choose the name upgrade_read() for the upgrade function.

Will that work for you?

Cheers,
Longman

