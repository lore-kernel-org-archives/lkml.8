Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52764C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 10:57:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25FAC20888
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 10:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590663479;
	bh=+s3iQbU50oMyjWLA4SvDT7injikcxGDv7jfjesepKU8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=rmf/NDzI/TB7yNyF87FXIHN2Y3UW7p/7VN/kQdERowco5Bu+/a8K7iQe4uuU5UyP9
	 mluvJXItO0Fgtf0U3ihOfp2PZOzY2OP1iDoSa81VoWlxWoJLgtEEiOqqj6/6CQJby6
	 5IHiJLGq/FVOyLah6xNo5rF9ykmUDqCmGe7lFgmU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388041AbgE1K56 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 06:57:58 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:45061 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387926AbgE1K55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 06:57:57 -0400
Received: by mail-ot1-f66.google.com with SMTP id c3so1994581otr.12
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 03:57:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FagLwjO9/oUcuTnUK3r+oVdBaE/5DDFSwRBmyKi9WoA=;
        b=hrXeYXeYd1y0egy88E8LoOJRGFDQX7X8LrxhRo+o1XFrYNZnIUWLWXE9LJ1HqA3yoZ
         GCjA+0uZ37Gr5L3XocUpP2o/blTnJXnBdo/EIgvSkUg/WxjiuXSVV4v2cmz/szMGXM8I
         N+YjHnBcknBWnP4DvYWM6acIqCfI5pZkFbtZkr9KydZwwVeR35Xrc1+Y0kxdLbgB6Mcx
         URjXdPRnbb8D2xABjlDPr4QFXZXHKFU4aBatONLJSWZEmrpWFKuNSt5BkGF6HKrjJ/7u
         Sq8SIHnDdOEnHUWj0dSbyZUGsHFnTrL47kluG8t+6sbfPPw3vxd/foUI7py7jjDouFAz
         pgAw==
X-Gm-Message-State: AOAM530go9Jqkcb3XpDMOeB8jQS1+22ymTmlmD82q1pboQntNo7uHvvd
        BhDrwvIeimNECfkqyLqO3XNnai6JWnZkMLPW7DY=
X-Google-Smtp-Source: ABdhPJzUyNQmJNPkY78iRbBaFzZTP/huSbYm3BIX72A2C8e+rMkaltPXGh3QTh8yd/rugcntC4rYj6GhUw6meG4Lepw=
X-Received: by 2002:a9d:6c0f:: with SMTP id f15mr1755562otq.118.1590663475733;
 Thu, 28 May 2020 03:57:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200524153041.2361-1-gregkh@linuxfoundation.org>
 <20200527075048.GD3284396@kuha.fi.intel.com> <CAJZ5v0h0Xjovm-eVyiOG+j7kNEPxB=PZF4rLVEgwUW+H+61DFg@mail.gmail.com>
 <2407984.idRd5kzSG0@kreacher> <20200527222515.GA89212@roeck-us.net>
In-Reply-To: <20200527222515.GA89212@roeck-us.net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 28 May 2020 12:57:42 +0200
Message-ID: <CAJZ5v0jPoi+5d+jv0iAuKkObSr=EDxmMhNqMTvLQNUEc_i9zcg@mail.gmail.com>
Subject: Re: [PATCH 2/2] kobject: send KOBJ_REMOVE uevent when the object is
 removed from sysfs
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 12:25 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Wed, May 27, 2020 at 11:01:16AM +0200, Rafael J. Wysocki wrote:
> >
> > So Guenter, can you please test the patch below to see if it still introduces
> > the problems seen by you on ARM?
> >
>
> arm64 and arm64be boot tests pass with the patch below.

Great, thanks!

> Some arm boot tests fail, but I think that is due to some other problem with -next.
> Hard to say for sure at this point because -next is pretty badly broken
> overall. I'll need to run some bisects to see what is going on.

I see.

Thanks for giving this one a go.

> > ---
> > From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > Subject: [PATCH] kobject: Make sure the parent does not get released before its children
> >
> > In the function kobject_cleanup(), kobject_del(kobj) is
> > called before the kobj->release(). That makes it possible to
> > release the parent of the kobject before the kobject itself.
> >
> > To fix that, adding function __kboject_del() that does
> > everything that kobject_del() does except release the parent
> > reference. kobject_cleanup() then calls __kobject_del()
> > instead of kobject_del(), and separately decrements the
> > reference count of the parent kobject after kobj->release()
> > has been called.
> >
> > Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> > Reported-by: kernel test robot <rong.a.chen@intel.com>
> > Fixes: 7589238a8cf3 ("Revert "software node: Simplify software_node_release() function"")
> > Suggested-by: "Rafael J. Wysocki" <rafael@kernel.org>
> > Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > [ rjw: Drop parent reference only when called __kobject_del() ]
> > Signed-off-by: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> > ---
> >  lib/kobject.c |   34 +++++++++++++++++++++++-----------
> >  1 file changed, 23 insertions(+), 11 deletions(-)
> >
> > Index: linux-pm/lib/kobject.c
> > ===================================================================
> > --- linux-pm.orig/lib/kobject.c
> > +++ linux-pm/lib/kobject.c
> > @@ -599,14 +599,7 @@ out:
> >  }
> >  EXPORT_SYMBOL_GPL(kobject_move);
> >
> > -/**
> > - * kobject_del() - Unlink kobject from hierarchy.
> > - * @kobj: object.
> > - *
> > - * This is the function that should be called to delete an object
> > - * successfully added via kobject_add().
> > - */
> > -void kobject_del(struct kobject *kobj)
> > +static void __kobject_del(struct kobject *kobj)
> >  {
> >       struct kernfs_node *sd;
> >       const struct kobj_type *ktype;
> > @@ -625,9 +618,23 @@ void kobject_del(struct kobject *kobj)
> >
> >       kobj->state_in_sysfs = 0;
> >       kobj_kset_leave(kobj);
> > -     kobject_put(kobj->parent);
> >       kobj->parent = NULL;
> >  }
> > +
> > +/**
> > + * kobject_del() - Unlink kobject from hierarchy.
> > + * @kobj: object.
> > + *
> > + * This is the function that should be called to delete an object
> > + * successfully added via kobject_add().
> > + */
> > +void kobject_del(struct kobject *kobj)
> > +{
> > +     struct kobject *parent = kobj->parent;
> > +
> > +     __kobject_del(kobj);
> > +     kobject_put(parent);
> > +}
> >  EXPORT_SYMBOL(kobject_del);
> >
> >  /**
> > @@ -663,7 +670,9 @@ EXPORT_SYMBOL(kobject_get_unless_zero);
> >   */
> >  static void kobject_cleanup(struct kobject *kobj)
> >  {
> > +     struct kobject *parent = kobj->parent;
> >       struct kobj_type *t = get_ktype(kobj);
> > +     bool state_in_sysfs = kobj->state_in_sysfs;
> >       const char *name = kobj->name;
> >
> >       pr_debug("kobject: '%s' (%p): %s, parent %p\n",
> > @@ -681,10 +690,10 @@ static void kobject_cleanup(struct kobje
> >       }
> >
> >       /* remove from sysfs if the caller did not do it */
> > -     if (kobj->state_in_sysfs) {
> > +     if (state_in_sysfs) {
> >               pr_debug("kobject: '%s' (%p): auto cleanup kobject_del\n",
> >                        kobject_name(kobj), kobj);
> > -             kobject_del(kobj);
> > +             __kobject_del(kobj);
> >       }
> >
> >       if (t && t->release) {
> > @@ -698,6 +707,9 @@ static void kobject_cleanup(struct kobje
> >               pr_debug("kobject: '%s': free name\n", name);
> >               kfree_const(name);
> >       }
> > +
> > +     if (state_in_sysfs)
> > +             kobject_put(parent);
> >  }
> >
> >  #ifdef CONFIG_DEBUG_KOBJECT_RELEASE
> >
> >
> >
