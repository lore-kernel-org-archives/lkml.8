Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AA91C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 18:57:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 267BB2067D
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 18:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593543477;
	bh=xUfGFgiLhy4seA0nl0JIC00G6EqWo71X4vbYy886H8Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ovKG0990cUlfQUyxf7qovxeCYhbwwisFgGq1zzFMiSviJRVqekIKlMdygm09aUu01
	 tPCghp8lkQUi+VLy3/mH9FZhZDUcIHiTi8VLeL6LdNzZY/IziAXSv2dyn/QtvcDKTl
	 QrA+kekaE6Z5RiWvcQ8pvYqfDxvdyZMQG105D3T4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbgF3S54 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 14:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbgF3S5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 14:57:55 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF070C061755
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 11:57:54 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id s1so23873256ljo.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 11:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ocZHzyECUMw2I95kHqyDzuRWomsz6Z9OK0jLOay8KIE=;
        b=BQtEH3qB2keufiVZixuQQEL6XIII3jdbnCaRFPB0c+GCjNeMJj+P8PKIga9iPdUH7L
         XRzFXrlrUmZ/JDWXwtBWZUXnh5wqOOfTW8dZngH9tRd+Xe720sSziOKVpJaveuWM9aEu
         Fwi6Kd1wtwzpKt5dp3R/u0mN1WdKElQEI9igo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ocZHzyECUMw2I95kHqyDzuRWomsz6Z9OK0jLOay8KIE=;
        b=q+84c1w5lQDB76WZD5GHTMajIV1vua6+pA/45lkMN2yGzfoL5t56InKP/XXsJKHpbh
         8mCp+jt8FT/8nDMu6aleMEii92Rzs3yXNQTDcq46wICbwfnVMYPr9U5Fum9O8WOUO+0p
         oZrKK/GckY/8gJmXYBu7pMqUTwF5wGwUWR6yMvNElP7vNjS3R9bY0Ha4+51W7r8qNRth
         fPh/wTB51c2d8SohehHTHuht5YqecaRlcqRbSjFqrMZII0625e+LUL5c5kkJdzW0dEzZ
         mI4dwB6SDF+9sEK01d45Qb6CU9xtILRr9zv1N+i7Ku5rI+M2EN10Onbv3wOLWat6ychU
         HZLg==
X-Gm-Message-State: AOAM531+hvwfSL3rWDhaVhoerUbqf4DRfGV6mLnzl9BNfsfmd2ARsLym
        XOTQSSAZpoaU4ByGMdN6ZLtW5bAUoOs=
X-Google-Smtp-Source: ABdhPJzyZGTvMWELY3KitdcfiBGMvkykp/dbUFAq917K8sV2Rnw24zo2Ov/Pp8fohuVXmfk6vjmiWw==
X-Received: by 2002:a2e:97d8:: with SMTP id m24mr11410253ljj.166.1593543472288;
        Tue, 30 Jun 2020 11:57:52 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id 132sm1100824lfl.37.2020.06.30.11.57.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2020 11:57:51 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id o4so12033156lfi.7
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 11:57:51 -0700 (PDT)
X-Received: by 2002:ac2:5093:: with SMTP id f19mr12831052lfm.10.1593543470696;
 Tue, 30 Jun 2020 11:57:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=whvVWNXPJq1k566zn4SfXAifXtiA7T+7JFweR3rQ0nc9A@mail.gmail.com>
 <1593396958.ydiznwsuu8.astroid@bobo.none> <20200629140245.GB20323@redhat.com>
 <1593482844.k3rh7s05o8.astroid@bobo.none> <20200630061708.GA21263@redhat.com>
 <1593505946.t0nxq8q8kj.astroid@bobo.none> <20200630105354.GB23871@redhat.com>
 <20200630113637.GC23871@redhat.com> <20200630115052.GD23871@redhat.com>
 <CAHk-=wgfjK_-Wfkb6yXYpB5WfOv5yP2NiFO68yQfBfnzRu4yYQ@mail.gmail.com> <20200630182933.GC26512@redhat.com>
In-Reply-To: <20200630182933.GC26512@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 30 Jun 2020 11:57:34 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj-ikJir+dgqAx9Hey=Pp6ZXfi37DJToNUY1nb9DN5ucw@mail.gmail.com>
Message-ID: <CAHk-=wj-ikJir+dgqAx9Hey=Pp6ZXfi37DJToNUY1nb9DN5ucw@mail.gmail.com>
Subject: Re: wait_on_page_bit_common(TASK_KILLABLE, EXCLUSIVE) can miss wakeup?
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>, Jan Kara <jack@suse.cz>,
        Lukas Czerner <lczerner@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 30, 2020 at 11:36 AM Oleg Nesterov <oleg@redhat.com> wrote:
>
> I swear, I too thought about changing wake_page_function() but got lost ;)
>
> The very fact it returns -1 if test_bit() is true suggests it can do more.

wake functions can indeed do more.

You can return -1 to say "stop traversing the list, nobody else on
this waitlist is relevant" (and that's separate from the "I did the
exclusive one".

Returning "0" is a success, but implies it shouldn't count as an
exclusive wakeup (generally because "try_to_wake_up()" didn't return
1, so the entry on the list wasn't actually sleeping and might already
have passed the critical region).

And returning "1" means that you _actually_ woke something up, so that
the exclusive counting triggers.

So that 0-vs-1 is very much exactly because of the race with "I'm an
exclusive waiter, and if an event comes in while I'm _actively_
waiting for it, then I promise I will take it". And the difference is
exactly about whether try_to_wake_up() actually changed the state of
the process or not.

But in addition to these "should I continue and/or count exclusive
waiters", wake functions can _do_ things too. The common one is
"autoremove", which is basically "if you actually woke something up,
then remove it from the list" (so that one generally goes along with a
successful try_to_wake_up() and returning 1.

Doing that can help scalability enormously, because if you stay on the
list and only remove yourself in the final "finish_waikt()", then if
there are lots of waiters and lots of wakeup events, the wakups will
traverse your entry over and over and over again. So autoremove is
generally a good thing.

An autoremove() thing can also be used at finish_wait() time to decide
whether you were actually woken up by that list or not (like the
WQ_FLAG_WOKEN, just implicitly). Remember: you can be on _many_ wait
lists, and you can be woken up by non-waitlist events like signals etc
too, so you can use WQ_FLAG_WOKEN (if you use woken_wake_function) or
the "am I still on the list" (if you use autoremove) to decide that
_that_ particular wakeup source triggered.

But some code wants to _stay_ on the list, because maybe they want to
be notified about multiple things and don't want to re-insert
themselves onto the list in between. That's the default behavior if
you don't do anything at all and just use the normal wake queue init
things. It's not generally the best thing to do, but it _can_ be
useful, and I think it's the default one purely for historical reasons
- ie that's how they all used to work, and the "autoremove" behavior
came in because of the scalability concerns.

But the waiting side is the one that decides which wakeup function it
wants for the wakeup event. So you can have the "please wake me up and
remove me from the wait list when you do". _and_ then add your own
logic as well, if you want to.

Yes, our wait queues are complicated. They are very powerful, though,
and they have been designed to easily avoid races many different ways
(and to also very naturally work with waiting for multiple very
different events, where select and poll are the obvious cases, but
even a single "read()" function _could_ decide to use multiple
wait-queues if there's another wait-queue for exceptional
circumstances, for example).

                  Linus
