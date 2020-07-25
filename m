Return-Path: <SRS0=eufF=BE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA1A0C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 19:52:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 952C720773
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 19:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595706731;
	bh=5jNCa/6li+GAfQ+2ygDosg8AIYnGKLrUCC6dRyDk4BI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=AIGK/9RmXSekE77zA4tURzFVZtmdnGS/F5cv2q2+brxERH+NhOlxf6Sq5167deUJK
	 KbRW42pnaPhwMAIIA0NhLBcYE7AGt+4EB5haiSz8gvXi/93pOG05LhuxraRGG2uz1y
	 hJjs1HmQRh4T3c39gsM4kXa5LTGsosOyd/qd8iiE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728036AbgGYTwK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 15:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727929AbgGYTwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 15:52:09 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A195DC08C5C0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jul 2020 12:52:08 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id t6so341259ljk.9
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jul 2020 12:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wl5O80oi/Kt/8fZrQY34GOq/Z5L129JRgfrldDVSyAU=;
        b=cxrfqdzllM3VDmJvOgE1o7/Ek14r9LdBvxRMahxlJhHW+QB9pagkd9nAIyEMLNILPh
         zCA4q9ToZ5ZsiZa12hEmLeH4toTVybbo9HDx3r8ngRndexI/92KurLTWfsgSFlOmt7pP
         whwRb+gytczc3CSOdmLWyRx2FIFh5HiYPnlpI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wl5O80oi/Kt/8fZrQY34GOq/Z5L129JRgfrldDVSyAU=;
        b=eIKOyDQEEL+h+TWcFdfbWP8alHbdcFFKiG8hi3cTcQLqVmTjzye3bIy+g0/DSo6C29
         aY4oZfUwfEbgvbog82vSOzXwAtyVR9w9CiIaIcdEYYhsQQaIuop8B4WxI1Rl9/WVjFBF
         5xT9FBvyM/EJZU7fq5SFezu+py8D81J1/UyJewvpgxA/yWlTKRb8tIwV6Q/hBkhkdGmQ
         IMJ4i4lu9Kf9j97pjhyDHntoyGqWGpi2LwLExiFXYhM3Bel83NB9dyGeYU37DZ75yebj
         ZiP2JI63v8zPOfgaWu43i7yKjFb180Np8Wy+I9R27BvGxa5IPxUcUD1vUsH4bZI+bOGY
         81Dg==
X-Gm-Message-State: AOAM533r+mc9wAeBGIwPCRFGXV60wC8+Q/HoQ5jkTUokpmFcW3+fe23D
        rYxUPyMh+zYtWmwcnACQQ8HE/leH46g=
X-Google-Smtp-Source: ABdhPJz4k5oHXdcLZNAzAtFKuOS+nM49+Kz6x4/3q8+Su37ITC+W3VqncHrQl+c/AE1kH6QHlqtHMA==
X-Received: by 2002:a2e:9594:: with SMTP id w20mr6283564ljh.26.1595706726727;
        Sat, 25 Jul 2020 12:52:06 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id 204sm1611535lfm.86.2020.07.25.12.52.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Jul 2020 12:52:06 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id i19so6953560lfj.8
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jul 2020 12:52:05 -0700 (PDT)
X-Received: by 2002:a05:6512:2082:: with SMTP id t2mr8290886lfr.142.1595706725545;
 Sat, 25 Jul 2020 12:52:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200723124749.GA7428@redhat.com> <CAHk-=wgyc7en4=HddEYiz_RKJXfqe1JYv3BzHc=+_wYq9ti+LQ@mail.gmail.com>
 <CAHk-=whQK3OGwExTzCrwwvuuVaQAgs8KsR-Yv8m1BmXoNZZ=jQ@mail.gmail.com>
 <alpine.LSU.2.11.2007231549540.1016@eggly.anvils> <CAHk-=wgvGOnMF0ePU4xS236bOsP8jouj3rps+ysCaGXvCjh2Dg@mail.gmail.com>
 <20200724152424.GC17209@redhat.com> <CAHk-=whuG+5pUeUqdiW4gk0prvqu7GZSMo-6oWv5PdDC5dBr=A@mail.gmail.com>
 <CAHk-=wjYHvbOs9i39EnUsC6VEJiuJ2e_5gZB5-J5CRKxq80B_Q@mail.gmail.com>
 <20200725101445.GB3870@redhat.com> <CAHk-=whSJbODMVmxxDs64f7BaESKWuMqOxWGpjUSDn6Jzqa71g@mail.gmail.com>
 <20200725192753.GA21962@redhat.com>
In-Reply-To: <20200725192753.GA21962@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 25 Jul 2020 12:51:49 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgpdbxaWWxOeVeA-eTex6QcSZLK9S2=eSv6KbQdPapfug@mail.gmail.com>
Message-ID: <CAHk-=wgpdbxaWWxOeVeA-eTex6QcSZLK9S2=eSv6KbQdPapfug@mail.gmail.com>
Subject: Re: [RFC PATCH] mm: silence soft lockups from unlock_page
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Hugh Dickins <hughd@google.com>, Michal Hocko <mhocko@kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 25, 2020 at 12:28 PM Oleg Nesterov <oleg@redhat.com> wrote:
>
> What I tried to say. AFAICS before that commit we had (almost) the same
> behaviour you propose now: unlock_page/etc wakes all the non-exclusive
> waiters up.
>
> No?

Yes, but no.

We'd wake them _up_ fairly aggressively, but then they'd be caught on
the bit being set again by the exclusive locker (that we also woke
up).

So they'd get woken up, and then go to sleep again.

So the new behavior wakes things up more aggressively (but a different
way), but not by letting them go out of order and early, but simply by
not going back to sleep again.

So the "wake up more" is very different - now it's about not going to
sleep again, rather than by ordering the wakeup queue.

We _could_ order the wakeup queue too, and put all non-exclusive
weiters at the head again. And make it *really* aggressive.

But since one of ourissues has been "latency of walking the wait
queue", I'm not sure we want that. interspesing any blocking waiters -
and stopping the waitqueue walking as a result - might be better under
load.

Wild handwaving. We could try it, but IO think that really would be a
separate "try this out" patch.

Right now, I think my patch will likely make for _better_ latencies
for everything.

Lower latency of non-exclusive waiters (because not going back to
sleep), but also lower latency of walking the wait queue (because
fewer entries, hopefully, and also less contention due to the "not
going back to sleep" noise)

           Linus
