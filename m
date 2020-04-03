Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1081C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 19:27:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 755AB20675
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 19:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585942033;
	bh=nDsiUp3xCN1quxJARzWU6z2zUvQkA7r4VqLtUduZJPg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=T+TnZpoWWfxDOgRLt/m5YNG8854QSHFAjWyB41PDzF/gmgDAg+4/U5Ry3FDxV4EBZ
	 gx6qzSkVxfhF15nobqxjPr/fN07g/bKJo2ZSmwgmHTp5qG9JDByQTeELPnoWLxF8rn
	 Cvix2lqMAxoLWioUCGnpqMgH5KuYreMAJ+d/1xrM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390900AbgDCT1M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 15:27:12 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39299 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728288AbgDCT1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 15:27:12 -0400
Received: by mail-lj1-f193.google.com with SMTP id i20so8124984ljn.6
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 12:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MIK9E+nNxRyxi/S8zbmiCFNW/N4clmaRNsapSTJyCVA=;
        b=dAtNuE2Qapg9anSlir7YSxVBhOfENs5fr72GmEEvjVZFoRd3K+rTBbVf8pjGp5y+rG
         i1VXmIJwyYNEtA2PuX6uRnNUxwkbWjArhtk+qldFXALehEFE5rziDdhvqJ4f6YoHnDbO
         YsxRreUMmkzNwG75syldd+XXahihORUSRlrR8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MIK9E+nNxRyxi/S8zbmiCFNW/N4clmaRNsapSTJyCVA=;
        b=sKi6ExvEnIBpjot/s6X/92VDf0lltgQNBpN077Jvz7eTmwZDzl9X5nMwCUQFSSyDmJ
         jdicIYYgeFDvEIuKhLZnVs/yVgsLko8OsI3OOSH94nr6VRBWmQe15iA0Edbx78nPAu3B
         75KxooGCiDwMdWfyp1UtnaC3L95cN5WC5fWWSgsEh0BnBr5Yt5+dsATsOWtTbdRJamZl
         uwrZzsI+KuwcI+yq0j01wH6zfnTbU9OC/3wLsx7uHBA25C1ggP70PatkvEKScNK0x8/J
         oh1lku2M37yqjQlZ2bn9wfkZYpFZnIcwchI+AEufQ3Jk/0mXUPYWHrEmQAqeZzpd+vVS
         JXXw==
X-Gm-Message-State: AGi0PuaG/vf2FLm76+9UKfUqOLGOwbYbAIv5jj9jauzjoAAxb5hii2Xp
        Ros79eGM3XfT+Y50c2j28JC3mZbTZNA=
X-Google-Smtp-Source: APiQypK/YqZ37cvGUPNF/QUqLPuRA6xJIqOe5iBloJroDD3Q9YizkEHMvVKZgmI91kxRuLpIX6sqxQ==
X-Received: by 2002:a2e:b804:: with SMTP id u4mr5590023ljo.159.1585942028677;
        Fri, 03 Apr 2020 12:27:08 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id 5sm6401271lfq.20.2020.04.03.12.27.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Apr 2020 12:27:07 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id k21so8186671ljh.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 12:27:07 -0700 (PDT)
X-Received: by 2002:a2e:8911:: with SMTP id d17mr5862737lji.16.1585942027228;
 Fri, 03 Apr 2020 12:27:07 -0700 (PDT)
MIME-Version: 1.0
References: <87blobnq02.fsf@x220.int.ebiederm.org> <CAHk-=wgYCUbEmwieOBzVNZbSAM9wCZA8Z0665onpNnEcC-UpDg@mail.gmail.com>
 <AM6PR03MB5170B606F9AC663225EC9609E4C60@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=whM3r7zrm8mSi7HJhuZbYiXx9PFU5VQYeKm6Low=r15eQ@mail.gmail.com>
 <AM6PR03MB517003D5965F48AC5FE7283DE4C60@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=wg5LvjumW9PVQiF7jB8yig98K8XTk4tHo9W-sYmxzW+9g@mail.gmail.com> <87lfnda3w3.fsf@x220.int.ebiederm.org>
In-Reply-To: <87lfnda3w3.fsf@x220.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 3 Apr 2020 12:26:51 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjxyGCj9675mf31uhoJCyHn74ON_+O6SjSqBSSvqWxC1Q@mail.gmail.com>
Message-ID: <CAHk-=wjxyGCj9675mf31uhoJCyHn74ON_+O6SjSqBSSvqWxC1Q@mail.gmail.com>
Subject: Re: [GIT PULL] Please pull proc and exec work for 5.7-rc1
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Waiman Long <longman@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>
Cc:     Bernd Edlinger <bernd.edlinger@hotmail.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ For Waiman & co - the problem is that the current cred_guard_mutex
is horrendous and has problems with execve() deadlocking against
various users. We've had this bug before, there's a new one, it's just
nasty ]

On Thu, Apr 2, 2020 at 4:04 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> That is not the direction I intend to take either.
>
> I was hoping I could put off replying to this thread for a bit because
> I only managed to get 4 hours of sleep last night and I am not as alert
> to technical details as I would like to be.

Hmm.. So I've been looking at this cred_guard_mutex, and I wonder...

This is a bit hand-wavy, because I haven't walker through all the
paths, but could we perhaps work around a lot of the problems a
different way., namely:

 - make the "cred_guard_mutex" an rwsem-like thing instead of being a mutex.

 - make the ptrace_attach() case get it for writing - not because
ptrace changes the creds, but because ptrace changes 'task->ptrace'
and depends on dumpability etc.

 - change the *name* of that damn thing. Not because it's now
rwsem'ish rather than a mutex, but because it was never really about
just "creds". It was about creds+ptrace+dumpable flags etc.

 - make all the ones that read the creds to just take it for reading
(IOW, the cases that were basically switched over to
exec_update_mutex).

 - and finally: make "execve()" take it just for reading too, but
introduce a "upgrade to write" at the very end (when it actually is
all done and then finally changes the creds and dumpability)

Wouldn't that solve all problems? We wouldn't get deadlocks wrt
execve(), simply because execve() doesn't need it to be writable, and
the things execve() does and can deadlock all only want readability.

But hear me out, because the above is fundamentally broken in a couple
of ways, so let me address that brokenness before you tell me I'm a
complete nincompoop and an idiot.

I'm including some locking people here because of these issues, so
that they can maybe verify my thinking.

 (a) our rwsem's are fair

     So the whole "execve takes it for reading, so now others can take
it for reading too without deadlocks" is simply not true - if you use
the existing rwsem.

     Because a concurrent (blocked) writer will then block other
readers for fairness reasons, and holding it for reading doesn't
guarantee that others can get it for reading.

     So clearly, the above doesn't even *fix* the deadlocks - unless
we have an unfair mode (or just a special lock for just this that is
not our standard rwsem, but a special unfair one).

     So I'm suggesting we use a special unfair rwsem here (we can make
a simple spinlock-based one - it doesn't need to be as clever or
optimized as the real rwsems are)

 (b) similarly, our rwsem's don't actually have a "upgrade from read
to write", because that's also a fundamentally deadlocky operation.

     Again, that's true. Except execve() is special, and we know
there's only _one_ execve() at a time that will complete, since we're
serializing them. So for this particular use, "upgrade to write" would
be possible without the general-case deadlock issues.

 (c) I didn't think things through, and even with these special
semantics, my idea is complete garbage

     Ok, this may well be true.

Anyway, the advantage of this (if it works) is that it would allow us
to go back to the _really_ simple original model of just taking this
lock for reading at the beginning of execve(), and not worrying so
much about complex nesting or very complex rules for exactly when we
got the lock and error handling.

The final part when we actually update the credentials and dumpability
and stuff in execve() is actually fairly simple. So the "upgrade to a
write lock" phase doesn't worry me too much.  It's the interaction
with all the previous parts (which happen with it held just for
reading) that tend to be the nastier ones.

And ptrace_attach() really is special, and I think it would be the
only one that really needs that write lock.

The disadvantage, of course, is that it would require that
special-case lock semantic, and I might also be missing some thing
that makes it not work anyway.

Comments? Am I just dreaming of a simpler model without my medications again?

             Linus
