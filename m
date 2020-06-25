Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5C45C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 20:26:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FF6D2072E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 20:26:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fqYH5g3m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391093AbgFYU0f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 16:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389406AbgFYU0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 16:26:35 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8634C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 13:26:34 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id k15so3932428lfc.4
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 13:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B2e+9BhdyoZKBQhVVowF1SUb9GpWFGzrObUCYCRlOxI=;
        b=fqYH5g3mAVkK+2WZwIzFmrKkwPU74dZDdILGRzvB+EKLBaABufN13Q52U1KEYFzKlj
         sRQmu46b+/4Z7IIYH95+8ndxycal3l2WZaWAzv1qYuNYXsZrdU/Tyky1DvYzVBEKe0wm
         MvX7Y1VUeWO3u52ih53lEOPHSNh8KLDRr4V1o/Nn+bBdXlFu1J752jg2nNn2zKOknPJx
         d+4MSZBJabUhn6BgU7g+lIdJutoL8At5Oe/Tyjel9X7rUFLODAnFREzm/rsKPrqsAfel
         6DGSdkPRuo9UrS+Z6n8cXsu4m+GeRHSZLmdm+Exh6nSIOIhsGNsRikf1UFXXmum7wZ6v
         p4XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B2e+9BhdyoZKBQhVVowF1SUb9GpWFGzrObUCYCRlOxI=;
        b=PXrLcNNHWZHvu/n5cNqjn6kk+R+6lOWonQflUICK7qUEUz+FIfjqcGHeqws2U5ueaw
         Xp3GmflDDdhDM7nQfa0XvzMoIVRG9tSu9Sm8/tweUSp4Z5l0wT5UDqde3z1V81jugcMQ
         bI4fyoWB1O37qwnxkhVru8i96YrozDN7ruZIlhAWElMjEMcAPEwgwodN3lSAuUvb6Ga2
         rErpRHOC8DCzsd/iHUsfSIYxvelNJu6eExyZLkacQHGnBY68AJdl8cfz4KXgAMivSoBw
         nk94GWcS0Qkv2RTCG1fShoQx7JSBipMjHrGEymdcaG7QU5yRg7zbpyZZAA+uGMSxtdqU
         +rMw==
X-Gm-Message-State: AOAM531SFPCC1K+yDHoCAwF8exZ8pJoAbd7Vxj0IuSorxsjCsl3TtpRM
        LdGk+yQxW3m+kCyk1ckY8bcjtFoRz0GR7mGugox3KA==
X-Google-Smtp-Source: ABdhPJxqgKr3mQm8vcKHYSo6pKy0kpTyzuBP2A9M9qBVMIfGzh5iKZneV+1lijdcvCUqsar9qmFYOGds1GQdCVHg5wM=
X-Received: by 2002:ac2:41d9:: with SMTP id d25mr19290098lfi.76.1593116793108;
 Thu, 25 Jun 2020 13:26:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200618222225.102337-1-axelrasmussen@google.com>
 <20200618222225.102337-2-axelrasmussen@google.com> <20200619083023.GS576905@hirez.programming.kicks-ass.net>
 <CAJHvVciGnK9Ve7NeZ=LUbWT3PGhG7hRWh+J80ncR6Mgwk316fw@mail.gmail.com>
In-Reply-To: <CAJHvVciGnK9Ve7NeZ=LUbWT3PGhG7hRWh+J80ncR6Mgwk316fw@mail.gmail.com>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Thu, 25 Jun 2020 13:25:56 -0700
Message-ID: <CAJHvVch0py68FBc4sDfc+7xN7=oyfHXvM1gwun4hZrBdzrHr5Q@mail.gmail.com>
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

Peter, one additional question for you.

Would you accept this patch if:
- The rwsem.{h,c} and lockdep.h changes were reverted
- It was split up into 2-3 commits
?

Thanks!

On Fri, Jun 19, 2020 at 9:28 AM Axel Rasmussen <axelrasmussen@google.com> wrote:
>
> On Fri, Jun 19, 2020 at 1:30 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Thu, Jun 18, 2020 at 03:22:25PM -0700, Axel Rasmussen wrote:
> > > diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
> > > index f11b9bd3431d..6aabea1cbc5d 100644
> > > --- a/kernel/locking/rwsem.c
> > > +++ b/kernel/locking/rwsem.c
> > > @@ -1495,6 +1495,20 @@ void __sched down_read(struct rw_semaphore *sem)
> > >  }
> > >  EXPORT_SYMBOL(down_read);
> > >
> > > +/*
> > > + * lock for reading
> > > + */
> > > +void __sched down_read_contended_hook(struct rw_semaphore *sem,
> > > +                                   void (*pre)(void *),
> > > +                                   void (*post)(void *), void *arg)
> > > +{
> > > +     might_sleep();
> > > +     rwsem_acquire_read(&sem->dep_map, 0, 0, _RET_IP_);
> > > +     LOCK_CONTENDED_HOOK(sem, __down_read_trylock, __down_read, pre, post,
> > > +                         arg);
> > > +}
> > > +EXPORT_SYMBOL(down_read_contended_hook);
> > > +
> > >  int __sched down_read_killable(struct rw_semaphore *sem)
> > >  {
> > >       might_sleep();
> > > @@ -1509,6 +1523,24 @@ int __sched down_read_killable(struct rw_semaphore *sem)
> > >  }
> > >  EXPORT_SYMBOL(down_read_killable);
> > >
> > > +int __sched down_read_killable_contended_hook(struct rw_semaphore *sem,
> > > +                                           void (*pre)(void *),
> > > +                                           void (*post)(void *, int),
> > > +                                           void *arg)
> > > +{
> > > +     might_sleep();
> > > +     rwsem_acquire_read(&sem->dep_map, 0, 0, _RET_IP_);
> > > +
> > > +     if (LOCK_CONTENDED_HOOK_RETURN(sem, __down_read_trylock,
> > > +                                    __down_read_killable, pre, post, arg)) {
> > > +             rwsem_release(&sem->dep_map, _RET_IP_);
> > > +             return -EINTR;
> > > +     }
> > > +
> > > +     return 0;
> > > +}
> > > +EXPORT_SYMBOL(down_read_killable_contended_hook);
> > > +
> > >  /*
> > >   * trylock for reading -- returns 1 if successful, 0 if contention
> > >   */
> > > @@ -1533,6 +1565,20 @@ void __sched down_write(struct rw_semaphore *sem)
> > >  }
> > >  EXPORT_SYMBOL(down_write);
> > >
> > > +/*
> > > + * lock for writing
> > > + */
> > > +void __sched down_write_contended_hook(struct rw_semaphore *sem,
> > > +                                    void (*pre)(void *),
> > > +                                    void (*post)(void *), void *arg)
> > > +{
> > > +     might_sleep();
> > > +     rwsem_acquire(&sem->dep_map, 0, 0, _RET_IP_);
> > > +     LOCK_CONTENDED_HOOK(sem, __down_write_trylock, __down_write, pre, post,
> > > +                         arg);
> > > +}
> > > +EXPORT_SYMBOL(down_write_contended_hook);
> > > +
> > >  /*
> > >   * lock for writing
> > >   */
> > > @@ -1551,6 +1597,24 @@ int __sched down_write_killable(struct rw_semaphore *sem)
> > >  }
> > >  EXPORT_SYMBOL(down_write_killable);
> > >
> > > +int __sched down_write_killable_contended_hook(struct rw_semaphore *sem,
> > > +                                            void (*pre)(void *),
> > > +                                            void (*post)(void *, int),
> > > +                                            void *arg)
> > > +{
> > > +     might_sleep();
> > > +     rwsem_acquire_read(&sem->dep_map, 0, 0, _RET_IP_);
> > > +
> > > +     if (LOCK_CONTENDED_HOOK_RETURN(sem, __down_write_trylock,
> > > +                                    __down_write_killable, pre, post, arg)) {
> > > +             rwsem_release(&sem->dep_map, _RET_IP_);
> > > +             return -EINTR;
> > > +     }
> > > +
> > > +     return 0;
> > > +}
> > > +EXPORT_SYMBOL(down_write_killable_contended_hook);
> > > +
> > >  /*
> > >   * trylock for writing -- returns 1 if successful, 0 if contention
> > >   */
> >
> > NAK, absolutely not going to happen. This is an atrocious API to expose,
> > worse you're exporting.
>
> Ack about splitting this up.
>
> Thanks for taking a look. :)
