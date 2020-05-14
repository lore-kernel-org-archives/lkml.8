Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CF72C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 19:11:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73926206DC
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 19:11:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t/Yi1mfa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730357AbgENTLn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 15:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728653AbgENTLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 15:11:37 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A131C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 12:11:37 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id z1so1778835pfn.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 12:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bL+5kEGRnbjLCbw4uwEC87Mowvuaf4yCMcaxogqbFfI=;
        b=t/Yi1mfa6GwVKuRE/g5RK/qViOZdBVoSNTRQGXQYtnmACJjQz/hngYa8oPaPm5i04H
         kUTGjHYv3Niltkv8XQgfA6LXzQGYmw5Y/ldWSLgqI11ZFG//CelBClfjMXZ720diwD9c
         kmLrrd0dKwCmKRd/YeVdDqm5YR0Jqy8Q2LvUTVityXMmTdJDKooO0TVuU2rXx8Z6DsCc
         tsKeYi21IdbIBItdW+J3+zHBV2JIkN/oFNWTGrJithMnRMFcAYqx4NOhTbMK9SQrP+0d
         87S8xn/AA8UkNawRfSr8SfrtEqmoSj9p8AKQl9XLZ9ZNcF1uqBVFpR+Y8+6ZrNQcmy5O
         nogA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bL+5kEGRnbjLCbw4uwEC87Mowvuaf4yCMcaxogqbFfI=;
        b=gpy4CTVaH139YnkeXlKwaZy3sKZEqUtwKaPG8bmKZTe6X/JlMLJ5ZZVaVHCdhPTc4T
         EgFujeaCotq7ErmS0nOTY0GQgei++TqFrM9g6SvbAZGLWol1PzYrD92kcac3YSjjk4Aa
         fsGQR4m+UO2ik65AuNw09ddqRvc8MBIkdYu6Hp6HwVDt8Cg3lr4jEhoWjPZtNsy2tx1q
         l9+mZ8xtn0DJkIVGr1+DzrLwOoEDXpXXof+punKNRBlbBi35sBoTBmLQT08Zju4dyjS+
         34MTWp79/U5t2syrXH7EjmxQv4z8t4iNWC4GWx4MnqaWaZzd7s26XDuYko0abAoCY/wN
         C1tw==
X-Gm-Message-State: AOAM5314zytGSwI7BA8HWlaUo+sZ80bjMQxJP02u565qfWLOwthfLNBv
        b1n7mhHXpm/989pvTNUJHf/HK17FYrs58QO/PlA=
X-Google-Smtp-Source: ABdhPJyGX3uST6YQLo2ay7I8Xvmz5lCenWsT1QfXq9Y6g1mqqLGTMoOb5SnU/13dOIx7wEtJWDdIrwmSUHN4f+X7Jc8=
X-Received: by 2002:a63:1c1:: with SMTP id 184mr5437931pgb.203.1589483496366;
 Thu, 14 May 2020 12:11:36 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1588808537.git.reinette.chatre@intel.com>
 <a99e4de3dc3f0e60281de1274ccb064071200fd9.1588808538.git.reinette.chatre@intel.com>
 <9c7a011c-2946-102c-5cdd-9dc5155533ec@amd.com>
In-Reply-To: <9c7a011c-2946-102c-5cdd-9dc5155533ec@amd.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 14 May 2020 22:11:29 +0300
Message-ID: <CAHp75VfSERa3W3u-yAYUVdx3U7FDMwzQFBL4utmYvqKWa-1w_A@mail.gmail.com>
Subject: Re: [PATCH V3 4/4] x86/resctrl: Use appropriate API for strings
 terminated by newline
To:     Babu Moger <babu.moger@amd.com>
Cc:     Reinette Chatre <reinette.chatre@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "kuo-lang.tseng@intel.com" <kuo-lang.tseng@intel.com>,
        "ravi.v.shankar@intel.com" <ravi.v.shankar@intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 14, 2020 at 10:08 PM Babu Moger <babu.moger@amd.com> wrote:
> > -----Original Message-----
> > From: Reinette Chatre <reinette.chatre@intel.com>
> > Sent: Wednesday, May 6, 2020 6:50 PM
> > To: tglx@linutronix.de; fenghua.yu@intel.com; bp@alien8.de;
> > tony.luck@intel.com
> > Cc: kuo-lang.tseng@intel.com; ravi.v.shankar@intel.com; mingo@redhat.com;
> > Moger, Babu <Babu.Moger@amd.com>; hpa@zytor.com; x86@kernel.org;
> > linux-kernel@vger.kernel.org; Reinette Chatre <reinette.chatre@intel.com>;
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Subject: [PATCH V3 4/4] x86/resctrl: Use appropriate API for strings terminated
> > by newline
> >
> > The user input to files in the resctrl filesystem are expected to be
> > terminated with a newline. Testing the user input includes a test for
> > the presence of a newline and then replacing the newline with NUL
> > byte followed by comparison using strcmp().
> >
> > sysfs_streq() exists to test if strings are equal, treating both NUL and
> > newline-then-NUL as equivalent string terminations. Even more,
> > sysfs_match_string() exists to match a given string in an array using
> > sysfs_streq().
> >
> > Replace existing strcmp() comparisons of strings that are terminated
> > with a newline with more appropriate sysfs_streq() via the
> > sysfs_match_string() API that can perform the match across the different
> > mode strings that are already maintained in an array.
> >
> > Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
> > ---
> >  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 32 ++++++++++++++------------
> >  1 file changed, 17 insertions(+), 15 deletions(-)
> >
> > diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> > b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> > index c60a3b307f7d..e70694892c02 100644
> > --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> > +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> > @@ -1408,12 +1408,11 @@ static ssize_t rdtgroup_mode_write(struct
> > kernfs_open_file *of,
> >  {
> >       struct rdtgroup *rdtgrp;
> >       enum rdtgrp_mode mode;
> > -     int ret = 0;
> > +     int user_m;
> > +     int ret;
>
> This is bit confusing here. Mode and user_m should have been of same type.

It can't. If you compare enum to int you will need the explicit (weird) casting.

> You can define user_m to user_mode to be very clear.

> You can completely remove "mode" and directly use rdtgrp->mode instead. It
> is left to you.
>
> > > -   /* Valid input requires a trailing newline */
> > -     if (nbytes == 0 || buf[nbytes - 1] != '\n')
> > +     if (nbytes == 0)
> >               return -EINVAL;
> > -     buf[nbytes - 1] = '\0';
> >
> >       rdtgrp = rdtgroup_kn_lock_live(of->kn);
> >       if (!rdtgrp) {
> > @@ -1425,11 +1424,17 @@ static ssize_t rdtgroup_mode_write(struct
> > kernfs_open_file *of,
> >
> >       mode = rdtgrp->mode;
> >
> > -     if ((!strcmp(buf, "shareable") && mode == RDT_MODE_SHAREABLE) ||
> > -         (!strcmp(buf, "exclusive") && mode == RDT_MODE_EXCLUSIVE) ||
> > -         (!strcmp(buf, "pseudo-locksetup") &&
> > -          mode == RDT_MODE_PSEUDO_LOCKSETUP) ||
> > -         (!strcmp(buf, "pseudo-locked") && mode ==
> > RDT_MODE_PSEUDO_LOCKED))
> > +     ret = sysfs_match_string(rdt_mode_str, buf);
> > +     if (ret < 0) {
> > +             rdt_last_cmd_puts("Unknown or unsupported mode\n");
> > +             goto out;
> > +     }
> > +
> > +     user_m = ret;
> > +     ret = 0;
> > +
> > +     /* Do nothing and return success if user asks for current mode */
> > +     if (user_m == mode)
> >               goto out;
> >
> >       if (mode == RDT_MODE_PSEUDO_LOCKED) {
> > @@ -1438,14 +1443,14 @@ static ssize_t rdtgroup_mode_write(struct
> > kernfs_open_file *of,
> >               goto out;
> >       }
> >
> > -     if (!strcmp(buf, "shareable")) {
> > +     if (user_m == RDT_MODE_SHAREABLE) {
> >               if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP) {
> >                       ret = rdtgroup_locksetup_exit(rdtgrp);
> >                       if (ret)
> >                               goto out;
> >               }
> >               rdtgrp->mode = RDT_MODE_SHAREABLE;
> > -     } else if (!strcmp(buf, "exclusive")) {
> > +     } else if (user_m == RDT_MODE_EXCLUSIVE) {
> >               if (!rdtgroup_mode_test_exclusive(rdtgrp)) {
> >                       ret = -EINVAL;
> >                       goto out;
> > @@ -1456,14 +1461,11 @@ static ssize_t rdtgroup_mode_write(struct
> > kernfs_open_file *of,
> >                               goto out;
> >               }
> >               rdtgrp->mode = RDT_MODE_EXCLUSIVE;
> > -     } else if (!strcmp(buf, "pseudo-locksetup")) {
> > +     } else if (user_m == RDT_MODE_PSEUDO_LOCKSETUP) {
> >               ret = rdtgroup_locksetup_enter(rdtgrp);
> >               if (ret)
> >                       goto out;
> >               rdtgrp->mode = RDT_MODE_PSEUDO_LOCKSETUP;
> > -     } else {
> > -             rdt_last_cmd_puts("Unknown or unsupported mode\n");
> > -             ret = -EINVAL;
> >       }
> >
> >  out:
> > --
> > 2.21.0
>


-- 
With Best Regards,
Andy Shevchenko
