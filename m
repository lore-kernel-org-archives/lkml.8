Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CB1CC28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 13:42:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01290206D5
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 13:42:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="RQFg+vmy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728617AbgEFNmx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 09:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725801AbgEFNmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 09:42:52 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8418FC061A0F
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 06:42:52 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id pg17so1352748ejb.9
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 06:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AwZ2HXOkXwEq2HHbm/ldWJ+Ha7wxQpNmEACUbIV+REs=;
        b=RQFg+vmyVowvlJJtYxI8xLKEKN+HKIvRTQbar5Cl4LErlFvZ3mIbhfXLRF1mUyGt5m
         8OyHNqcxGA2e7Gz6VNBUqX9yGPaPsgzcBE/Q7qkxymnHHDqkiWHCKhc7cJ31nMLj1ipu
         kKhG+x8gvS9pgH19iPX8gfH69E5+FNUf8W33YzfULpbDs5B000Y5f0LIUXhskCI2/fId
         gtBby9KluUmRz5JwBUxDZcY2T1osgi2ZIbTZX78IrtygX6nUNLf2BMITOTPqObEFkpRa
         uYJEHd/Ezu0QbsdLGP4IvYnPkez4cVb1QoZhW3sdgYPqjhXt/bzW5Z5EM9VJTQuPYDK5
         ZiJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AwZ2HXOkXwEq2HHbm/ldWJ+Ha7wxQpNmEACUbIV+REs=;
        b=tWuJx7VTpEumahRqqJVbhvea0cHcSP2ISfgZgP229CAzahw6E5JZKN8jG9yAWOnR3U
         XM5lgO87TmMJUhOsDazyw7Rqthsxc8FNDwUWFuyAPoJBRRP8/r2kwN93yfCew4LITTdz
         FmR4WVBdFdgxMDPRP80txc4/YU3W3w3tlW+CDUck1Q5F37phAPh6HKXx29D7XUJ9ElKU
         +lDvEUnaxEAVPbpmXc163DHuFHAJeyw+zSPSAPIDLPZsQCMWZyR6emqnYwjAefFxn9Dj
         LYtFsPa+ImPzwVN30Ys8DInr44BmpLHzgjmtXzlI/0VlLJ4XtAAoHQWuWOg/NGr4qQAn
         3DWQ==
X-Gm-Message-State: AGi0Puba3LZ/KoVKQ1OJMnyCYXzRYFfucnriQwh3dNUWPIBVWfHiarF3
        y78mB5XAFKyIW89yhb+vJEenVmzZFkvZBEvUP2oPuC2jPjc=
X-Google-Smtp-Source: APiQypK7Y5o9dE58DnHy5mYwilyI2yZDqALVkpJZUJ66bjBNcdPU+/tCFN7JjLeC6p2qTfgJyocFjoOfYcUNpe6AXL8=
X-Received: by 2002:a17:906:841a:: with SMTP id n26mr7668693ejx.43.1588772571094;
 Wed, 06 May 2020 06:42:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200505154510.93506-1-pasha.tatashin@soleen.com>
 <20200505154510.93506-4-pasha.tatashin@soleen.com> <202005051559.946100505D@keescook>
In-Reply-To: <202005051559.946100505D@keescook>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Wed, 6 May 2020 09:42:15 -0400
Message-ID: <CA+CK2bBa=v0CrTYgugrJ+SvWocdQs5BsBZmd_n9+r-_c9BeriA@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] pstore/ram: in ramoops_platform_data convert
 dump_oops to max_reason
To:     Kees Cook <keescook@chromium.org>
Cc:     James Morris <jmorris@namei.org>, Sasha Levin <sashal@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>, anton@enomsg.org,
        ccross@android.com, Tony Luck <tony.luck@intel.com>,
        robh+dt@kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Remove filtering logic from ramoops_pstore_write(), as that is not needed
> > anymore, only dmesges specified by max_reason are passed to
> > ramoops_pstore_write(). Also, because of this, we can remove
> > cxt->dump_oops.
>
> This is all looking good. I think I'd like to see patch 3 and 4 merged,
> though. I'd like to make the dump_oops/max_reason conversion in one
> patch. Noted below...

Sure, I can do it.

>
> >
> > Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
> > ---
> >  Documentation/admin-guide/ramoops.rst     | 11 ++++++----
> >  drivers/platform/chrome/chromeos_pstore.c |  2 +-
> >  fs/pstore/ram.c                           | 26 +++++++----------------
> >  include/linux/pstore_ram.h                |  2 +-
> >  4 files changed, 17 insertions(+), 24 deletions(-)
> >
> > diff --git a/Documentation/admin-guide/ramoops.rst b/Documentation/admin-guide/ramoops.rst
> > index 6dbcc5481000..a296e1aa1617 100644
> > --- a/Documentation/admin-guide/ramoops.rst
> > +++ b/Documentation/admin-guide/ramoops.rst
> > @@ -32,11 +32,14 @@ memory to be mapped strongly ordered, and atomic operations on strongly ordered
> >  memory are implementation defined, and won't work on many ARMs such as omaps.
> >
> >  The memory area is divided into ``record_size`` chunks (also rounded down to
> > -power of two) and each oops/panic writes a ``record_size`` chunk of
> > +power of two) and each kmesg dump writes a ``record_size`` chunk of
> >  information.
> >
> > -Dumping both oopses and panics can be done by setting 1 in the ``dump_oops``
> > -variable while setting 0 in that variable dumps only the panics.
> > +Dumping reasons can be set via max_reason value, as defined in
> > +include/linux/kmsg_dump.h: kmsg_dump_reason. For example, to
> > +dump for both oopses and panics reasons, max_reason should be set to 2
> > +(KMSG_DUMP_OOPS), to dump panics only max_reason should be set to 1
> > +(KMSG_DUMP_PANIC).
> >
> >  The module uses a counter to record multiple dumps but the counter gets reset
> >  on restart (i.e. new dumps after the restart will overwrite old ones).
> > @@ -90,7 +93,7 @@ Setting the ramoops parameters can be done in several different manners:
> >          .mem_address            = <...>,
> >          .mem_type               = <...>,
> >          .record_size            = <...>,
> > -        .dump_oops              = <...>,
> > +        .max_reason             = <...>,
> >          .ecc                    = <...>,
> >    };
>
> Good, yes, dump_oops should be removed from the platform data structure
> since that's an entirely internal API.
>
> >
> > diff --git a/drivers/platform/chrome/chromeos_pstore.c b/drivers/platform/chrome/chromeos_pstore.c
> > index d13770785fb5..fa51153688b4 100644
> > --- a/drivers/platform/chrome/chromeos_pstore.c
> > +++ b/drivers/platform/chrome/chromeos_pstore.c
> > @@ -57,7 +57,7 @@ static struct ramoops_platform_data chromeos_ramoops_data = {
> >       .record_size    = 0x40000,
> >       .console_size   = 0x20000,
> >       .ftrace_size    = 0x20000,
> > -     .dump_oops      = 1,
> > +     .max_reason     = KMSG_DUMP_OOPS,
> >  };
> >
> >  static struct platform_device chromeos_ramoops = {
> > diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
> > index 795622190c01..223581aeea96 100644
> > --- a/fs/pstore/ram.c
> > +++ b/fs/pstore/ram.c
> > @@ -81,7 +81,6 @@ struct ramoops_context {
> >       size_t console_size;
> >       size_t ftrace_size;
> >       size_t pmsg_size;
> > -     int dump_oops;
> >       u32 flags;
> >       struct persistent_ram_ecc_info ecc_info;
> >       unsigned int max_dump_cnt;
> > @@ -381,18 +380,6 @@ static int notrace ramoops_pstore_write(struct pstore_record *record)
> >       if (record->type != PSTORE_TYPE_DMESG)
> >               return -EINVAL;
> >
> > -     /*
> > -      * Out of the various dmesg dump types, ramoops is currently designed
> > -      * to only store crash logs, rather than storing general kernel logs.
> > -      */
> > -     if (record->reason != KMSG_DUMP_OOPS &&
> > -         record->reason != KMSG_DUMP_PANIC)
> > -             return -EINVAL;
> > -
> > -     /* Skip Oopes when configured to do so. */
> > -     if (record->reason == KMSG_DUMP_OOPS && !cxt->dump_oops)
> > -             return -EINVAL;
> > -
> >       /*
> >        * Explicitly only take the first part of any new crash.
> >        * If our buffer is larger than kmsg_bytes, this can never happen,
> > @@ -687,7 +674,7 @@ static int ramoops_parse_dt(struct platform_device *pdev,
> >       pdata->mem_size = resource_size(res);
> >       pdata->mem_address = res->start;
> >       pdata->mem_type = of_property_read_bool(of_node, "unbuffered");
> > -     pdata->dump_oops = !of_property_read_bool(of_node, "no-dump-oops");
> > +     dump_oops = !of_property_read_bool(of_node, "no-dump-oops");
> :
> Is this setting the module param variable? That shouldn't happen here --
> we may fail the DT and overwrite the user-configured setting for a
> different backend. This should be a local variable and the "final"
> max_reason should be calculated in this function, I think.

Hm, interesting, not sure if this is a realistic scenario. If I
understand the code correctly, dummy is the only device that can
pick-up dump_oops parameter, and it is registered before the DT based
backend:

ramoops_init(void)
   ramoops_register_dummy();  -> register dummy if mem_size is provided
   platform_driver_register(&ramoops_driver); -> register DT based node.

dummy is registered only if mem_size parameter is provided. Deprecated
dump_oops if provided by the user is converted to max_reason and
discarded after that. The value of dump_oops becomes meaningless in
/sys/module/ramoops/parameters/, as it does not really carry any
information about kmsg dumps anymore. max_reason is what carries that
information.

After the dummy backend is registered, even if DT changes dump_oops,
and still fails to register, it does not matter, as the dummy will
keep operating correctly with the set max_reason.

>
> >
> >  #define parse_size(name, field) {                                    \
> >               ret = ramoops_parse_dt_size(pdev, name, &value);        \
> > @@ -785,7 +772,6 @@ static int ramoops_probe(struct platform_device *pdev)
> >       cxt->console_size = pdata->console_size;
> >       cxt->ftrace_size = pdata->ftrace_size;
> >       cxt->pmsg_size = pdata->pmsg_size;
> > -     cxt->dump_oops = pdata->dump_oops;
> >       cxt->flags = pdata->flags;
> >       cxt->ecc_info = pdata->ecc_info;
> >
> > @@ -828,8 +814,14 @@ static int ramoops_probe(struct platform_device *pdev)
> >        * the single region size is how to check.
> >        */
> >       cxt->pstore.flags = 0;
> > -     if (cxt->max_dump_cnt)
> > +     if (cxt->max_dump_cnt) {
> >               cxt->pstore.flags |= PSTORE_FLAGS_DMESG;
> > +             if (pdata->max_reason <= 0) {
> > +                     pdata->max_reason = dump_oops ? KMSG_DUMP_OOPS :
> > +                                                     KMSG_DUMP_PANIC;
> > +             }
> > +             cxt->pstore.max_reason = pdata->max_reason;
> > +     }
>
> I'm going to take a stab at reorganizing the DT, platform data, and
> module args to have default handling done in a way that I like. I'm
> having a hard time making specific suggestions here. :)

Sure, unfortunatly I do not think we can simply remove "no-dump-oops"
from DT, and I also looked through the kernel and did not find any DTs
that use "no-dump-oops" in the kernel.

>
> >       if (cxt->console_size)
> >               cxt->pstore.flags |= PSTORE_FLAGS_CONSOLE;
> >       if (cxt->max_ftrace_cnt)
> > @@ -865,7 +857,6 @@ static int ramoops_probe(struct platform_device *pdev)
> >       mem_size = pdata->mem_size;
> >       mem_address = pdata->mem_address;
> >       record_size = pdata->record_size;
> > -     dump_oops = pdata->dump_oops;
> >       ramoops_console_size = pdata->console_size;
> >       ramoops_pmsg_size = pdata->pmsg_size;
> >       ramoops_ftrace_size = pdata->ftrace_size;
> > @@ -948,7 +939,6 @@ static void __init ramoops_register_dummy(void)
> >       pdata.console_size = ramoops_console_size;
> >       pdata.ftrace_size = ramoops_ftrace_size;
> >       pdata.pmsg_size = ramoops_pmsg_size;
> > -     pdata.dump_oops = dump_oops;
> >       pdata.flags = RAMOOPS_FLAG_FTRACE_PER_CPU;
> >
> >       /*
> > diff --git a/include/linux/pstore_ram.h b/include/linux/pstore_ram.h
> > index 9cb9b9067298..9f16afec7290 100644
> > --- a/include/linux/pstore_ram.h
> > +++ b/include/linux/pstore_ram.h
> > @@ -133,7 +133,7 @@ struct ramoops_platform_data {
> >       unsigned long   console_size;
> >       unsigned long   ftrace_size;
> >       unsigned long   pmsg_size;
> > -     int             dump_oops;
> > +     int             max_reason;
> >       u32             flags;
> >       struct persistent_ram_ecc_info ecc_info;
> >  };
> > --
> > 2.25.1
> >
>
> So, hold off on a v3, and I'll send a series tomorrow, based on what
> you've got here for v2. I like the refactoring; it's much cleaner to
> have max_reason than dump_oops! :)

Sure, I will wait for your changes.

Thank you,
Pasha

>
> --
> Kees Cook
