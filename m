Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BAB4C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:29:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 672DF218AC
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:29:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B/w9WI6c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394972AbgFSQ3V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 12:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394853AbgFSQ3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 12:29:05 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA011C06174E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 09:29:03 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id a9so12180500ljn.6
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 09:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/V/EEJuGfM3cwX7ubb4ViNyVH2RhhYxz5LHLfNXzhkM=;
        b=B/w9WI6cwkaKNiVZI/74T8mkbfDvQKda2PFwcG461AJl+Gf6uYMVSHq4gpulO8Ry+L
         8qGuQp5or3fxXwqYPSXsF7PbTNUas9uFLKTpxcFSJDk2fzA7L4QjvyQtCJGcqQCf1NGb
         r7M5175o1wb2hP868cNxoHI7udC1F3ZvHPxoHlWzfHnNjeWVeJ1LphNBc9gN3ms4J7FK
         RewOaHYWx3Z3gWld8GO3oojFfFMg4Mf3MoB9qvV10x9svpEHRwh/lGM+Wc5FBQjcMyK1
         u/uXYEmCvfoXlzhQXBTW8ZgKtQt16FRjDptA3n3UBSB8fTta2S2z1Z1e2o1zw6elE8Ny
         9qmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/V/EEJuGfM3cwX7ubb4ViNyVH2RhhYxz5LHLfNXzhkM=;
        b=IRYHxXIQPyEtuZwAXD+bbb1cSaxZI2Adarzt0+f/ppvjO8jLCnpV11qT8jEsOepWlw
         A+DMQn138zTNpz8Z2pQySdxSc4+md6f369pWa2lfHlTS8rO3TB+zigtm1EmZ4u9UEV5c
         TV9dhx6CgbF8ZxDiSrOfvVJpmHReJmAx6cB5qBFOf9FbtfZBzAsfQqvZcLc2LcbDEQqi
         wy7YPC5ARq0ygGVshEH/7y2uV0b14IiZbz73E43poVNc16J8AFVedZqLMWReOLUxmbiF
         JCSjKk3feap5UDzN6ayG6ueqJ5dt2VvgycnWvfbnBfJwkmx8IsfKyTALQ/YgiwwTVLRy
         48/Q==
X-Gm-Message-State: AOAM533Gh4tN0fzHwET6bOQBHzK7ZFn1BsJl4C6wg2GV3quGHEJEytFF
        guY/V8BacLbsSmrTAI2fF2aKALTqwWxE/DJkGMYRSg==
X-Google-Smtp-Source: ABdhPJyn3yaIiMt6831syIMHyWp/J+Qai964ORpX8fPeiKbLuy9BlJOQCTa0wVXzGV0An0hM3kXnQYBOBF/tgtfFMcI=
X-Received: by 2002:a2e:8e94:: with SMTP id z20mr2052818ljk.21.1592584141654;
 Fri, 19 Jun 2020 09:29:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200618222225.102337-1-axelrasmussen@google.com>
 <20200618222225.102337-2-axelrasmussen@google.com> <20200619083023.GS576905@hirez.programming.kicks-ass.net>
In-Reply-To: <20200619083023.GS576905@hirez.programming.kicks-ass.net>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Fri, 19 Jun 2020 09:28:24 -0700
Message-ID: <CAJHvVciGnK9Ve7NeZ=LUbWT3PGhG7hRWh+J80ncR6Mgwk316fw@mail.gmail.com>
Subject: Re: [RFC PATCH v3 1/1] mmap_lock: add tracepoints around mmap_lock acquisition
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Michel Lespinasse <walken@google.com>,
        David Howells <dhowells@redhat.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Jonathan Adams <jwadams@google.com>,
        David Rientjes <rientjes@google.com>,
        Ying Han <yinghan@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 19, 2020 at 1:30 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Jun 18, 2020 at 03:22:25PM -0700, Axel Rasmussen wrote:
> > diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
> > index f11b9bd3431d..6aabea1cbc5d 100644
> > --- a/kernel/locking/rwsem.c
> > +++ b/kernel/locking/rwsem.c
> > @@ -1495,6 +1495,20 @@ void __sched down_read(struct rw_semaphore *sem)
> >  }
> >  EXPORT_SYMBOL(down_read);
> >
> > +/*
> > + * lock for reading
> > + */
> > +void __sched down_read_contended_hook(struct rw_semaphore *sem,
> > +                                   void (*pre)(void *),
> > +                                   void (*post)(void *), void *arg)
> > +{
> > +     might_sleep();
> > +     rwsem_acquire_read(&sem->dep_map, 0, 0, _RET_IP_);
> > +     LOCK_CONTENDED_HOOK(sem, __down_read_trylock, __down_read, pre, post,
> > +                         arg);
> > +}
> > +EXPORT_SYMBOL(down_read_contended_hook);
> > +
> >  int __sched down_read_killable(struct rw_semaphore *sem)
> >  {
> >       might_sleep();
> > @@ -1509,6 +1523,24 @@ int __sched down_read_killable(struct rw_semaphore *sem)
> >  }
> >  EXPORT_SYMBOL(down_read_killable);
> >
> > +int __sched down_read_killable_contended_hook(struct rw_semaphore *sem,
> > +                                           void (*pre)(void *),
> > +                                           void (*post)(void *, int),
> > +                                           void *arg)
> > +{
> > +     might_sleep();
> > +     rwsem_acquire_read(&sem->dep_map, 0, 0, _RET_IP_);
> > +
> > +     if (LOCK_CONTENDED_HOOK_RETURN(sem, __down_read_trylock,
> > +                                    __down_read_killable, pre, post, arg)) {
> > +             rwsem_release(&sem->dep_map, _RET_IP_);
> > +             return -EINTR;
> > +     }
> > +
> > +     return 0;
> > +}
> > +EXPORT_SYMBOL(down_read_killable_contended_hook);
> > +
> >  /*
> >   * trylock for reading -- returns 1 if successful, 0 if contention
> >   */
> > @@ -1533,6 +1565,20 @@ void __sched down_write(struct rw_semaphore *sem)
> >  }
> >  EXPORT_SYMBOL(down_write);
> >
> > +/*
> > + * lock for writing
> > + */
> > +void __sched down_write_contended_hook(struct rw_semaphore *sem,
> > +                                    void (*pre)(void *),
> > +                                    void (*post)(void *), void *arg)
> > +{
> > +     might_sleep();
> > +     rwsem_acquire(&sem->dep_map, 0, 0, _RET_IP_);
> > +     LOCK_CONTENDED_HOOK(sem, __down_write_trylock, __down_write, pre, post,
> > +                         arg);
> > +}
> > +EXPORT_SYMBOL(down_write_contended_hook);
> > +
> >  /*
> >   * lock for writing
> >   */
> > @@ -1551,6 +1597,24 @@ int __sched down_write_killable(struct rw_semaphore *sem)
> >  }
> >  EXPORT_SYMBOL(down_write_killable);
> >
> > +int __sched down_write_killable_contended_hook(struct rw_semaphore *sem,
> > +                                            void (*pre)(void *),
> > +                                            void (*post)(void *, int),
> > +                                            void *arg)
> > +{
> > +     might_sleep();
> > +     rwsem_acquire_read(&sem->dep_map, 0, 0, _RET_IP_);
> > +
> > +     if (LOCK_CONTENDED_HOOK_RETURN(sem, __down_write_trylock,
> > +                                    __down_write_killable, pre, post, arg)) {
> > +             rwsem_release(&sem->dep_map, _RET_IP_);
> > +             return -EINTR;
> > +     }
> > +
> > +     return 0;
> > +}
> > +EXPORT_SYMBOL(down_write_killable_contended_hook);
> > +
> >  /*
> >   * trylock for writing -- returns 1 if successful, 0 if contention
> >   */
>
> NAK, absolutely not going to happen. This is an atrocious API to expose,
> worse you're exporting.

Ack about splitting this up.

Thanks for taking a look. :)
