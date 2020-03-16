Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76917C18E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 18:57:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 438F9206E2
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 18:57:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="S2q3zWjF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732388AbgCPS5b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 14:57:31 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:35860 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732330AbgCPS5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 14:57:30 -0400
Received: by mail-il1-f194.google.com with SMTP id h3so17657688ils.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 11:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qpWTaUSi6v0noh8eXI8lxQn+nN2Hg8Fm3JarhKjNCVQ=;
        b=S2q3zWjFSql68wKbxgm+z6Jm1ZtnKdmewCiM7m1MFbWPR+rsJMp34nOtUhRfH7qcrr
         SI+iAy8IAdsVDNBsL591WUGfMpxNVfcvb2ndcKnCIFqbe7hyvJp8SUlWO1558ansEw1w
         lyPP36N64p2FXv+ytKdFv04K7SdB4j8uBfkhE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qpWTaUSi6v0noh8eXI8lxQn+nN2Hg8Fm3JarhKjNCVQ=;
        b=tc+fAih044vM67Vp5O+jJWrbztNAtBQG5L6QZ81tapFEhnK5Boh1oqdeVWpzm/JJVe
         9FCivzWlEVst0+6cvHMPZ2gF+d7Ncz+JfHhbmly88SWjrY85tsXwFQeLnRxuMr5GMiiv
         Y6Lw7RCSYK2PcBW9kddZS2xXQX+TsdhXsHje1vg1ZmAssHWr9toQRpFY48qETRY3tJrd
         rCudqMUga1oRGKbrMjaJR+9gqipD9fQc7DLcCsdyw35SRqi1vQwSvbcvUHkfGxIlzyw4
         qSK3ILtwivyQhAhfutx7B6apq5i0TnItEetQ6zd0j4nLR8SfL8bU4OfbIFUhDMkyic+I
         2Bcg==
X-Gm-Message-State: ANhLgQ0M9EAHhIUbza2A27BxuuvskPn0l71dauJf5P5bYrVBLaAU5bs4
        939tNFxPdlWQitLcpFOW/PaG4hIeVEQs9/snVYvIrZnR
X-Google-Smtp-Source: ADFU+vsTMCdMbf/TW3u1G71bFbKTUZLeeWWRHJx+0Uwb7v9fs+ZLX8dI0FbujMMNMydD9Bp0yCAmReFZ5uMpaLSZHlQ=
X-Received: by 2002:a05:6e02:bc7:: with SMTP id c7mr1354868ilu.78.1584385049631;
 Mon, 16 Mar 2020 11:57:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200315181840.6966-1-urezki@gmail.com> <20200315181840.6966-3-urezki@gmail.com>
 <20200316154539.GE190951@google.com> <20200316185519.GA10577@pc636>
In-Reply-To: <20200316185519.GA10577@pc636>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Mon, 16 Mar 2020 14:57:18 -0400
Message-ID: <CAEXW_YQGtgBpzuQqGMfWObxKr-MtK==caoLyw8TtU_79PX4JhQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/6] rcu: introduce kvfree_rcu() interface
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        RCU <rcu@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 16, 2020 at 2:55 PM Uladzislau Rezki <urezki@gmail.com> wrote:
>
> On Mon, Mar 16, 2020 at 11:45:39AM -0400, Joel Fernandes wrote:
> > On Sun, Mar 15, 2020 at 07:18:36PM +0100, Uladzislau Rezki (Sony) wrote:
> > > kvfree_rcu() can deal with an allocated memory that is obtained
> > > via kvmalloc(). It can return two types of allocated memory or
> > > "pointers", one can belong to regular SLAB allocator and another
> > > one can be vmalloc one. It depends on requested size and memory
> > > pressure.
> > >
> > > Based on that, two streams are split, thus if a pointer belongs
> > > to vmalloc allocator it is queued to the list, otherwise SLAB
> > > one is queued into "bulk array" for further processing.
> > >
> > > The main reason of such splitting is:
> > >     a) to distinguish kmalloc()/vmalloc() ptrs;
> > >     b) there is no vmalloc_bulk() interface.
> > >
> > > As of now we have list_lru.c user that needs such interface,
> > > also there will be new comers. Apart of that it is preparation
> > > to have a head-less variant later.
> > >
> > > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > > ---
> > >  include/linux/rcupdate.h |  9 +++++++++
> > >  kernel/rcu/tiny.c        |  3 ++-
> > >  kernel/rcu/tree.c        | 17 ++++++++++++-----
> > >  3 files changed, 23 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> > > index 2be97a83f266..bb270221dbdc 100644
> > > --- a/include/linux/rcupdate.h
> > > +++ b/include/linux/rcupdate.h
> > > @@ -845,6 +845,15 @@ do {                                                                   \
> > >             __kfree_rcu(&((___p)->rhf), offsetof(typeof(*(ptr)), rhf)); \
> > >  } while (0)
> > >
> > > +/**
> > > + * kvfree_rcu() - kvfree an object after a grace period.
> > > + * @ptr:   pointer to kvfree
> > > + * @rhf:   the name of the struct rcu_head within the type of @ptr.
> > > + *
> > > + * Same as kfree_rcu(), just simple alias.
> > > + */
> > > +#define kvfree_rcu(ptr, rhf) kfree_rcu(ptr, rhf)
> > > +
> > >  /*
> > >   * Place this after a lock-acquisition primitive to guarantee that
> > >   * an UNLOCK+LOCK pair acts as a full barrier.  This guarantee applies
> > > diff --git a/kernel/rcu/tiny.c b/kernel/rcu/tiny.c
> > > index dd572ce7c747..4b99f7b88bee 100644
> > > --- a/kernel/rcu/tiny.c
> > > +++ b/kernel/rcu/tiny.c
> > > @@ -23,6 +23,7 @@
> > >  #include <linux/cpu.h>
> > >  #include <linux/prefetch.h>
> > >  #include <linux/slab.h>
> > > +#include <linux/mm.h>
> > >
> > >  #include "rcu.h"
> > >
> > > @@ -86,7 +87,7 @@ static inline bool rcu_reclaim_tiny(struct rcu_head *head)
> > >     rcu_lock_acquire(&rcu_callback_map);
> > >     if (__is_kfree_rcu_offset(offset)) {
> > >             trace_rcu_invoke_kfree_callback("", head, offset);
> > > -           kfree((void *)head - offset);
> > > +           kvfree((void *)head - offset);
> > >             rcu_lock_release(&rcu_callback_map);
> > >             return true;
> > >     }
> > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > index 2f4c91a3713a..1c0a73616872 100644
> > > --- a/kernel/rcu/tree.c
> > > +++ b/kernel/rcu/tree.c
> > > @@ -2899,9 +2899,9 @@ static void kfree_rcu_work(struct work_struct *work)
> > >     }
> > >
> > >     /*
> > > -    * Emergency case only. It can happen under low memory
> > > -    * condition when an allocation gets failed, so the "bulk"
> > > -    * path can not be temporary maintained.
> > > +    * vmalloc() pointers end up here also emergency case. It can
> >
> > Suggest rephrase for clarity:
> >
> > nit: We can end up here either with 1) vmalloc() pointers or 2) low on memory
> > and could not allocate a bulk array.
> >
> Let's go with your suggestion. I see that you took patches to your tree.
> Could you please update it on your own? Otherwise i can send out V2, so
> please let me know.

I updated it, "patch -p1" resolved the issue. No need to resend unless
something in my tree looks odd to you :)

> Thanks for the comments!

Thanks!

- Joel
