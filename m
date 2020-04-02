Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12BD7C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 19:05:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA29420719
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 19:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585854301;
	bh=K9uruu5QLXAUSdGxtEgdQE3UiBbpvJwYii53IUL/fbQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=o54h7mtrv6vA6vKR8VIlX9CG6Z1YLPbctaOIyL4uT/Re0I4iJiwFj5JhdJ3PAuS1r
	 GBmzhY+POYLuy41KisDWNHokx3HRNZqQ1wmyvtBJkbiGAWrWPP6rv8PzaQmAeq8r3Q
	 Z9env81x7lcQ171edbVxIQk2seTkb1RO1BaNPb9E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389916AbgDBTFA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 15:05:00 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42641 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731715AbgDBTFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 15:05:00 -0400
Received: by mail-lf1-f68.google.com with SMTP id s13so3663859lfb.9
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 12:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NAVPeSq9DvyCnnULUdYg1UKNlLeynSptkjCtMfU+YO4=;
        b=PDOYB19tl0R/qSHJMsVSKCPIn+QbVP2dcFk7SuiZ5HDheZU7jxtchi028JYyuoufiT
         wDCyhOEjYd/BWubosz/o8ESqCvA/7Wy+YgBhiWqwe/rCw0PoB3whed+cGtUozSBoz1bz
         wdDyV6eJ2YIlByIyvRqqh7IuTKmEvT/pWJjRc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NAVPeSq9DvyCnnULUdYg1UKNlLeynSptkjCtMfU+YO4=;
        b=TUdMIJZ9Dr1vY+UNPTWTHme7wN9E8a83vtJlRdf7fAwdyFna8lidUu6pK6pr02l8Xs
         Go/L15QUClT3fUoDfPfO7wgQ+A+HaQfHYx1gGMQ2X8i3goTV8D6/7RlJKZaZ62M3u01n
         pR9FaqGPY2QJJz9iQ8kcRyiEKLYWoerOmpBDGRu8mLJ0xhFtyI4MYiYqBzfd3V7NooAH
         csF8o2gF8UI8FULd48i4+TJGhDXfcvzRV4BkrJhT5X/l9i7Vzw7vvnB46nIEFof/NTKA
         o66QMs8N8Ih3MppGmuM2t9CvlYtlCPy6WMQTQOuBfuXU0qfhGgd+FLgg2rkleqssg7PO
         JjOw==
X-Gm-Message-State: AGi0PuZejKlTZARWUEPl1lGPaPWj9FSsBmO4Uj2s3TFczh+D+ws/r3uH
        tqUs1VU9dX1/KHjGYNv0czVH2e+wGbA=
X-Google-Smtp-Source: APiQypKrr+5OqexNAu1Ez7Ir5biBOdynSTu2tAe1UAYS/FfjJzWUpupeiWoUYE9Iq5lTkj8fv1z83Q==
X-Received: by 2002:a05:6512:3127:: with SMTP id p7mr3040761lfd.108.1585854296505;
        Thu, 02 Apr 2020 12:04:56 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id c4sm548019ljd.30.2020.04.02.12.04.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Apr 2020 12:04:55 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id r7so4371558ljg.13
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 12:04:54 -0700 (PDT)
X-Received: by 2002:a2e:8911:: with SMTP id d17mr2888851lji.16.1585854294457;
 Thu, 02 Apr 2020 12:04:54 -0700 (PDT)
MIME-Version: 1.0
References: <87blobnq02.fsf@x220.int.ebiederm.org>
In-Reply-To: <87blobnq02.fsf@x220.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 2 Apr 2020 12:04:38 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgYCUbEmwieOBzVNZbSAM9wCZA8Z0665onpNnEcC-UpDg@mail.gmail.com>
Message-ID: <CAHk-=wgYCUbEmwieOBzVNZbSAM9wCZA8Z0665onpNnEcC-UpDg@mail.gmail.com>
Subject: Re: [GIT PULL] Please pull proc and exec work for 5.7-rc1
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        Alexey Gladkov <gladkov.alexey@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 1, 2020 at 9:16 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> The work on exec starts solving a long standing issue with exec that
> it takes mutexes of blocking userspace applications, which makes exec
> extremely deadlock prone.  For the moment this adds a second mutex
> with a narrower scope that handles all of the easy cases.  Which
> makes the tricky cases easy to spot.  With a little luck the code to
> solve those deadlocks will be ready by next merge window.

So this worries me.

I've pulled it, but I'm not entirely happy about some of it.

For example, the "rationale" for some of the changes is

    This should be safe, as the credentials are only used for reading.

which is just nonsensical. "Only used for reading" is immaterial, and
there's no explanation for why that would matter at all. Most of the
credentials are ever used for reading, and the worry about execve() is
that the credentials can change, and people race with them and use the
new 'suid' credentials and allow things that shouldn't be allowed. So
the rationale makes no sense at all.

Btw, if "this only takes it for reading" is such a big deal, why is
that mutex not an rw-semaphore?

The pidfd change at least has a rationale that makes sense:

    This should be safe, as the credentials do not change
    before exec_update_mutex is locked.  Therefore whatever
    file access is possible with holding the cred_guard_mutex
    here is also possbile with the exec_update_mutex.

so now you at least have an explanation of why that particular lock
makes sense and works and is equivalent.

It's still not a *great* explanation for why it would be equivalent,
because cred_guard_mutex ends up not just guarding the write of the
credentials, but makes it atomic wrt *other* data. That's the same
problem as "I'm only reading".

Locking is not about *one* value being consistent - if that was the
case, then you could just do a "get refcount on the credentials, now I
have a stable set of creds I can read forever". No lock needed.

So locking is about *multiple* values being consistent, which is why
that "I'm only reading" is not an explanation for why you can change
the lock.

It's also why that second one is questionable: it's a _better_ attempt
at explaining things, but the point is really that cred_guard_mutex
protects *other* things too.

A real explanation would have absolutely *nothing* to do with
"reading" or "same value of credentials". Both of those are entirely
immaterial, since - as mentioned - you could just get a snapshot of
the creds instead.

A real explanation would be about how there is no other state that
cred_guard_mutex protects that matters.

See what I'm saying?

This code is subtle as h*ll, and we've had bugs in it, and it has a
series of tens of patches to fix them. But that also means that the
explanations for the patches should take the subtleties into account,
and not gloss over them with things like this.

Ok, enough about the explanations. The actual _code_ is kind of odd
too. For example, you have that "bprm->called_exec_mmap" flag to say
"I've taken the exec_update_mutex, and need to drop it".

But that flag is not set anywhere _near_ actually taking the lock.
Sure, it is taken after exec_mmap() returns successfully, and that
makes sense from a naming standpoint, but wouldn't it have been a
_lot_ more obvious if you just set the flag when you took that lock,
and instead of naming it by some magical code sequence, you named it
for what it does?

Again, this looks all technically correct, but it's written in a way
that doesn't seem to make a lot of sense. Why is the code literally
written with a magical assumption of "calling exec_mmap takes this
lock, so if the flag named called_exec_mmap is set, I have to free
that lock that is not named that at all".

I hate conditional locking in the first place, but if it has to exist,
then the conditional should be named after the lock, and the lock
getting should be very very explicitly tied to it.

Wouldn't it have been much clearer if you called that flag
"exec_update_mutex_taken", and set it WHEN YOU TAKE IT?

In fact, then you could drop the

                        mutex_unlock(&tsk->signal->exec_update_mutex);

in the error case of exec_mmap(), because now the error handling in
free_bprm() would do the cleanup automatically.

See what I'm saying? You've made the locking more complex and subtle
than it needed to be. And since the whole point of the *new* lock is
that it should replace an old lock that was really complex and subtle,
that's a problem.

                   Linus
