Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A9E5C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 15:51:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6277A205CB
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 15:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589385092;
	bh=BxUNMUdGNrS5sYZao1wEjB4fqjRTEIy2mDfAs/GHhnM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=nAhy59WL1neibXBMagpMNpjivNiCRV5ncTq3omIQoMUZm72We5EZl+n8bF8EO8P2B
	 pe9zkp1KFHkXXioqDeK6rFyWPEEwDXyVORbM6+H3hBh0gG7BejtzQ/hxAc1DFcuGhN
	 Qa1MXFFTqvF0GNzfreEjZnFhr7a2bNeagu13KTs8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731910AbgEMPvb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 11:51:31 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:44200 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729467AbgEMPva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 11:51:30 -0400
Received: by mail-ot1-f68.google.com with SMTP id j4so13767537otr.11
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 08:51:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dAc2/p9/ye87n+oDzeojjYRRxgpdmDIY9Lqiy5g0GGQ=;
        b=sba5PDbZAVH+2kccsiBH3k2SS1V/JG6LJ1SOyhkKI5vv2i6u6+5B7EaCrvATF9XnKQ
         xVo9FfrbTNzbJzr+hP/trXvWKt9gWHcQ1AKkFWUHloEKGQliQSmLkONcPTn3gza9qccx
         UaywyhmDJCE3eLJKAOiDrP68+FDXf6g5GmhzBvDL1aKGxSxnkT3dGn1Inu3GOiRzOC7P
         3zvx+URRVKC+oPEonWma+21lKvJROaqENwtM8uCZt1CTHJCUWAwgP1fjFUfFvFhMCxZI
         yPm7sOfVjNM9EBR5JeCI5mDiM8pf70SnYaXNYoJSpdmG8B55j9eKUbQ04uXF6AnUvHhI
         B3YQ==
X-Gm-Message-State: AOAM531Sb5xFcLoDk8oBU/R36oapAwDprO2V61mhELn6e+LMwAvFLESi
        3cYJAQ0reSfODNIsoYTjANurvSGHs4KJFNiPf9o=
X-Google-Smtp-Source: ABdhPJwrnc+iD2Wdesi78Zg5BYnaqgwCv5dXh27FiLQYMIXUsJmPXAZstnE6lQn1FYPMaTFACuXNgsFsqKQu7JeIhYI=
X-Received: by 2002:a9d:6ac8:: with SMTP id m8mr79195otq.262.1589385089449;
 Wed, 13 May 2020 08:51:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200513151840.36400-1-heikki.krogerus@linux.intel.com> <20200513154228.GC1360420@kroah.com>
In-Reply-To: <20200513154228.GC1360420@kroah.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 13 May 2020 17:51:18 +0200
Message-ID: <CAJZ5v0jzF6HM41UBaWfuJ38TMg+jq+1pQAz0QHb9GwTDJV_F=Q@mail.gmail.com>
Subject: Re: [PATCH] kobject: Make sure the parent does not get released
 before its children
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        kernel test robot <rong.a.chen@intel.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 13, 2020 at 5:42 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, May 13, 2020 at 06:18:40PM +0300, Heikki Krogerus wrote:
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
> > Cc: Brendan Higgins <brendanhiggins@google.com>
> > Cc: Randy Dunlap <rdunlap@infradead.org>
> > Suggested-by: "Rafael J. Wysocki" <rafael@kernel.org>
> > Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > ---
> >  lib/kobject.c | 30 ++++++++++++++++++++----------
> >  1 file changed, 20 insertions(+), 10 deletions(-)
> >
> > diff --git a/lib/kobject.c b/lib/kobject.c
> > index 65fa7bf70c57..32432036bef8 100644
> > --- a/lib/kobject.c
> > +++ b/lib/kobject.c
> > @@ -599,14 +599,7 @@ int kobject_move(struct kobject *kobj, struct kobject *new_parent)
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
> > @@ -663,6 +670,7 @@ EXPORT_SYMBOL(kobject_get_unless_zero);
> >   */
> >  static void kobject_cleanup(struct kobject *kobj)
> >  {
> > +     struct kobject *parent = kobj->parent;
> >       struct kobj_type *t = get_ktype(kobj);
> >       const char *name = kobj->name;
> >
> > @@ -684,7 +692,7 @@ static void kobject_cleanup(struct kobject *kobj)
> >       if (kobj->state_in_sysfs) {
> >               pr_debug("kobject: '%s' (%p): auto cleanup kobject_del\n",
> >                        kobject_name(kobj), kobj);
> > -             kobject_del(kobj);
> > +             __kobject_del(kobj);
> >       }
> >
> >       if (t && t->release) {
> > @@ -698,6 +706,8 @@ static void kobject_cleanup(struct kobject *kobj)
> >               pr_debug("kobject: '%s': free name\n", name);
> >               kfree_const(name);
> >       }
> > +
> > +     kobject_put(parent);
> >  }
> >
> >  #ifdef CONFIG_DEBUG_KOBJECT_RELEASE
> > --
> > 2.26.2
> >
>
> Is this the older patch we talked about before, or something else?
>
> I can't remember how we left that thread...

This is an alternative that you said might work. :-)
