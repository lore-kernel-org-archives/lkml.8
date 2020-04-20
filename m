Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC671C55182
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 22:03:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85F53206D9
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 22:03:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RLT9hDOh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbgDTWDy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 18:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbgDTWDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 18:03:54 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 865CDC061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 15:03:53 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id d184so1233128pfd.4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 15:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GkO5OPMfjblm2nsbFSt6vLqg6Y5q/RvWe2WQ/AkzzSw=;
        b=RLT9hDOhYDaVrOb3NQXEzKxLHu29Fry2nuuaORCMrniqJ6qFBrzkqExYtQsHcw+PV3
         7O6N4Js3skiA85xYqwa4OXyxNXaoSVywnwsyGIBQPrrbuM+9qedw62FvSYonGlzH53Vp
         1ZRz9H3HA+v1LH386c5pUp+6yQc6fYgdisIlUJGHsnvepCqAHnzS4jBNtwViMFUv8EW4
         j5IxVqiUy04j74GBYjPPr3O8I8HZonBfK2NKdS4ew22JAAKHNLOE0aAsC1XkNJ1z2jbh
         cgvOnISKLT1x4FXcUcTTYnqEbZpOq81T25jZLx2CWYni87ck/VIgHgmrqSacW5pVV4Oh
         aJLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GkO5OPMfjblm2nsbFSt6vLqg6Y5q/RvWe2WQ/AkzzSw=;
        b=s/NQlbcecip6gc4scCyggv5KP83m65IRin6guB904jpK7S5IsBFbSSo/TpRt57BEme
         vjODvQZMOSIwgRMJ1LLTvo9vy+YbwdAiMIPmHzGmYRB8lkhRKeL4tfm8uUbsc53NiKjV
         XhjmDSQlE3gavoZlbV7mHxBfkUcPhrryegYHBYNEZyk+vVw4FWEvVcX3mU4ouNJd3Nh/
         jIvWHfmmuUqUn9rrM1R/TWPhl8fTWIOerwndqKFg3ocZZ/wgI6dWVOO77KpvI6moLpQC
         e23JPrpDVv+93/fTVohdX/AtoKmsGwKr3ZXLUzlzpjKMeiBWb91wN8ZyguRpYA7n8tWT
         81wg==
X-Gm-Message-State: AGi0PubnoSavJwE3UG5Eu8rMWoa9JA/mYVDn2nbkP7DeY+/EMuIzlLtm
        G9/kWF6T+TjF2FLgO8JoYHag7WGSmi2+tmqfTw5XOw==
X-Google-Smtp-Source: APiQypJGQucPtvq3CfgTMf+OFHwpcjA3gKWb5P46VJ8NpuN6PgcSGXR/Vs8ghz34ahJqfBcHm2ZuGC6xF+srQY+GuVo=
X-Received: by 2002:a63:cf10:: with SMTP id j16mr18229361pgg.201.1587420232829;
 Mon, 20 Apr 2020 15:03:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200414204240.186377-1-brendanhiggins@google.com>
 <20200415061154.GA2496263@kroah.com> <20200415084653.GM2828150@kuha.fi.intel.com>
 <CAJZ5v0hNemTDVa_S-FfVMbrKjM-RWYoHh88asnUvTNxZinY2cw@mail.gmail.com>
 <20200415131018.GO2828150@kuha.fi.intel.com> <20200415133122.GB3461248@kroah.com>
 <20200417113956.GA3728594@kuha.fi.intel.com> <e946febc-a1d6-6392-bb00-bc6a65d93c5a@infradead.org>
In-Reply-To: <e946febc-a1d6-6392-bb00-bc6a65d93c5a@infradead.org>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 20 Apr 2020 15:03:41 -0700
Message-ID: <CAFd5g46AVqzQN+7eFQZV64vcZtJOS1V9QUX2zh74e=RtEmOLZg@mail.gmail.com>
Subject: Re: [PATCH v1] kobject: make sure parent is not released before children
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        lkft-triage@lists.linaro.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 17, 2020 at 9:08 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 4/17/20 4:39 AM, Heikki Krogerus wrote:
> > Hi,
> >
> >>>> An alternative might be to define something like __kobject_del() doing
> >>>> everything that kobject_del() does *without* the
> >>>> kobject_put(kobj->parent).
> >>>>
> >>>> Then, kobject_del() could be defined as something like (pseudocode):
> >>>>
> >>>> kobject_del(kobj)
> >>>> {
> >>>>     kobject *perent = kobj->parent;
> >>>>
> >>>>     __kobject_del(kobj);
> >>>>     kobject_put(parent);
> >>>> }
> >>>>
> >>>> and kobject_cleanup() could call __kobject_del() instead of
> >>>> kobject_del() and then do the last kobject_put(parent) when it is done
> >>>> with the child.
> >>>>
> >>>> Would that work?
> >>>
> >>> I think so. Greg, what do you think?
> >>
> >> Hm, maybe.  Can someone test it out with the reproducer?
> >
> > Brendan, or Randy! Can you guys test Rafael's proposal? I think it
> > would look like this:
>
> patch is whitespace-damaged. did you copy-paste it from a screen?
>
>
> Anyway, it works for me. I loaded & unloaded test_printf.ko 5 times
> without a problem.

I just tried it as well. I also noticed some whitespace corruption,
but it otherwise worked against the KUnit reproducer I wrote:

https://lore.kernel.org/patchwork/patch/1224002/

Thanks!

> Thanks.
>
> > diff --git a/lib/kobject.c b/lib/kobject.c
> > index 83198cb37d8d..2bd631460e18 100644
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
> >         struct kernfs_node *sd;
> >         const struct kobj_type *ktype;
> > @@ -625,9 +618,23 @@ void kobject_del(struct kobject *kobj)
> >
> >         kobj->state_in_sysfs = 0;
> >         kobj_kset_leave(kobj);
> > -       kobject_put(kobj->parent);
> >         kobj->parent = NULL;
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
> > +       struct kobject *parent = kobj->parent;
> > +
> > +       __kobject_del(kobj);
> > +       kobject_put(parent);
> > +}
> >  EXPORT_SYMBOL(kobject_del);
> >
> >  /**
> > @@ -663,6 +670,7 @@ EXPORT_SYMBOL(kobject_get_unless_zero);
> >   */
> >  static void kobject_cleanup(struct kobject *kobj)
> >  {
> > +       struct kobject *parent = kobj->parent;
> >         struct kobj_type *t = get_ktype(kobj);
> >         const char *name = kobj->name;
> >
> > @@ -684,7 +692,7 @@ static void kobject_cleanup(struct kobject *kobj)
> >         if (kobj->state_in_sysfs) {
> >                 pr_debug("kobject: '%s' (%p): auto cleanup kobject_del\n",
> >                          kobject_name(kobj), kobj);
> > -               kobject_del(kobj);
> > +               __kobject_del(kobj);
> >         }
> >
> >         if (t && t->release) {
> > @@ -698,6 +706,8 @@ static void kobject_cleanup(struct kobject *kobj)
> >                 pr_debug("kobject: '%s': free name\n", name);
> >                 kfree_const(name);
> >         }
> > +
> > +       kobject_put(parent);
> >  }
> >
> >  #ifdef CONFIG_DEBUG_KOBJECT_RELEASE
> >
> >
> > thanks,
> >
>
>
> --
> ~Randy
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
