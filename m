Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0049C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 20:42:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1664207FF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 20:42:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AYkKd9mu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728164AbgDCUl7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 16:41:59 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:31432 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726368AbgDCUl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 16:41:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585946518;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9W4ERNpDc97NCwFIYXreAgn7Lw6lJhCk4ENzF6ZX0o8=;
        b=AYkKd9muiXzWUgqmlflffREKmGdm07TzsAGAQsmk+/4e6s2XdQs9fOvtBn1a3PLJ9eA2Ne
        EPERjfUbo3LmtuUF6UAL1L9HcOejKZibWKqwKrf4wz6e6RESjFyDd9xyV/x9IR2xIWhplz
        M6wjURInKx1HFq5AG+LaYJ2uoOy3MbY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-385-se2pBvTZNHSbW6RRzF7z6A-1; Fri, 03 Apr 2020 16:41:54 -0400
X-MC-Unique: se2pBvTZNHSbW6RRzF7z6A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7F748100550D;
        Fri,  3 Apr 2020 20:41:52 +0000 (UTC)
Received: from llong.remote.csb (ovpn-118-94.rdu2.redhat.com [10.10.118.94])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2CBF560BF3;
        Fri,  3 Apr 2020 20:41:51 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull proc and exec work for 5.7-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>
Cc:     Bernd Edlinger <bernd.edlinger@hotmail.de>,
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
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <328f5ad3-f8b3-09b9-f2f7-b6dae0137542@redhat.com>
Date:   Fri, 3 Apr 2020 16:41:50 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CAHk-=wjxyGCj9675mf31uhoJCyHn74ON_+O6SjSqBSSvqWxC1Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/3/20 3:26 PM, Linus Torvalds wrote:
> I'm including some locking people here because of these issues, so
> that they can maybe verify my thinking.
>
>  (a) our rwsem's are fair
>
>      So the whole "execve takes it for reading, so now others can take
> it for reading too without deadlocks" is simply not true - if you use
> the existing rwsem.
>
>      Because a concurrent (blocked) writer will then block other
> readers for fairness reasons, and holding it for reading doesn't
> guarantee that others can get it for reading.
>
>      So clearly, the above doesn't even *fix* the deadlocks - unless
> we have an unfair mode (or just a special lock for just this that is
> not our standard rwsem, but a special unfair one).
>
>      So I'm suggesting we use a special unfair rwsem here (we can make
> a simple spinlock-based one - it doesn't need to be as clever or
> optimized as the real rwsems are)
>
>  (b) similarly, our rwsem's don't actually have a "upgrade from read
> to write", because that's also a fundamentally deadlocky operation.
>
>      Again, that's true. Except execve() is special, and we know
> there's only _one_ execve() at a time that will complete, since we're
> serializing them. So for this particular use, "upgrade to write" would
> be possible without the general-case deadlock issues.
>
>  (c) I didn't think things through, and even with these special
> semantics, my idea is complete garbage
>
>      Ok, this may well be true.
>
> Anyway, the advantage of this (if it works) is that it would allow us
> to go back to the _really_ simple original model of just taking this
> lock for reading at the beginning of execve(), and not worrying so
> much about complex nesting or very complex rules for exactly when we
> got the lock and error handling.
>
> The final part when we actually update the credentials and dumpability
> and stuff in execve() is actually fairly simple. So the "upgrade to a
> write lock" phase doesn't worry me too much.  It's the interaction
> with all the previous parts (which happen with it held just for
> reading) that tend to be the nastier ones.
>
> And ptrace_attach() really is special, and I think it would be the
> only one that really needs that write lock.

Making an unfair rwsem that prefer readers (like the original rwlock
semantics) is certainly doable. I don't think that is hard to do. I can
think of 2 possible ways to do that. We=C2=A0 could make the unfairness
globally applies to all the readers of a rwsem by defining the fairness
state at init time. That will require keeping the state in the rwsem
structure increasing its size.

Another alternative is to add new functions like down_read_unfair() that
perform unfair read locking for its callers. That will require less code
change, but the calling functions have to make the right choice.

Cheers,
Longman


