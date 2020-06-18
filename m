Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 535A4C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 18:15:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32217207DD
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 18:15:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cVEC93Si"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730151AbgFRSPr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 14:15:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727929AbgFRSPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 14:15:43 -0400
Received: from mail-ua1-x943.google.com (mail-ua1-x943.google.com [IPv6:2607:f8b0:4864:20::943])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F16FC0613ED;
        Thu, 18 Jun 2020 11:15:43 -0700 (PDT)
Received: by mail-ua1-x943.google.com with SMTP id x14so2313090uao.7;
        Thu, 18 Jun 2020 11:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5gXUAQeHbErOV5ynbvpo9o+w8PM8zAlucaxTRG/q2Z4=;
        b=cVEC93SiNSUmUhGgNZnWbKW4cVsINB2cNtZt5hhTEvjvKX4a2J6jkB1Hq7zyvO16E8
         tM//w/FgiOU7VH5bZc2+M5AxtJeQy2xrVk/sTdnht4e9xsDzXgxs5JE8dmB7gVYWqK2v
         2zGbbeSmsI7BzTHs842eO4KTA7PhKCCq8bkCCph/M2ldHlQozQ4yFga4RQYFyxvIJROt
         woJmwqTuC40+zQlvWIGCJ08708yxkKDFwWZ7kLC5tKPOE8ynt0Yt3XcWJUdkFFRi83Zo
         Pml5kILn2FMzmnRgzqudR22MDGE4p/9eK/RerNuYHlYdELc+pbObvg+ZJ3+vFfQRBKsK
         HzSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5gXUAQeHbErOV5ynbvpo9o+w8PM8zAlucaxTRG/q2Z4=;
        b=EuCxAlX246W6KOUK+JWr+heCavHkT5Vgpd9AlpObRbjknQZFWEyBWF6F/Z5JoGDHOR
         HIcdwaVrzs69HY9713UrgTlZuX7bJfC2I4eWAapc3yBvD5IZQiBnaan7Meirydpz1IWI
         /6CaPrb5QB4wgp0Z+O9Zud1+GqCDpnfjL5RVlbhOt14b1AcIbkf7YG/ndy5HQk7QoG2/
         kozbtigUooV/037zd+q72sudtlhyZRaYxhDQ/Ar0M7ryz6yvxDNbkDjwqEhUyxvs0gT9
         13+YAdpTyZtMsR7D4JYWBuz3YzTovhAUETJ+BTGOV0umdc8Bvu7MI0ochvZuWBJTwlpc
         vf0g==
X-Gm-Message-State: AOAM530EYLjq3CCjPFG/Vd94XhZYmeHdE/R60ti9M9I55ciI+7Plilxp
        VLjrK2Qy6kjJ/gyMSYl9IpTRvQZvVU9Ydl5rdUA=
X-Google-Smtp-Source: ABdhPJypdV4Gy5l+nhq1JZN1sASE6dTwOCLFYjEI4jMaxSPJlir/ebzuTirDkk6cQHoJjDj+inyxlbfGiv3FYIwJTkE=
X-Received: by 2002:ab0:61d3:: with SMTP id m19mr4534962uan.23.1592504142300;
 Thu, 18 Jun 2020 11:15:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200617162536.611386-1-jim.cromie@gmail.com> <20200617162536.611386-23-jim.cromie@gmail.com>
 <20200618161912.GD3617@alley>
In-Reply-To: <20200618161912.GD3617@alley>
From:   jim.cromie@gmail.com
Date:   Thu, 18 Jun 2020 12:15:16 -0600
Message-ID: <CAJfuBxzrOinpvkYYPZ5fCMSRwTggYGRs0VxMhrm=AO-L5fuMRg@mail.gmail.com>
Subject: Re: [PATCH v3 20/21] dyndbg: add user-flag, negating-flags, and
 filtering on flags
To:     Petr Mladek <pmladek@suse.com>
Cc:     Jason Baron <jbaron@akamai.com>,
        LKML <linux-kernel@vger.kernel.org>, akpm@linuxfoundation.org,
        Greg KH <gregkh@linuxfoundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Orson Zhai <orson.zhai@unisoc.com>,
        Linux Documentation List <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 18, 2020 at 10:19 AM Petr Mladek <pmladek@suse.com> wrote:
>
> On Wed 2020-06-17 10:25:35, Jim Cromie wrote:


OK.
Please tell me how this chunk of prose fails to explain a use case for
the u-flag
we can differ on how useful it looks.

if u-flag is useful, then filtering on flags is also needed,
to use the flag to enable/disable an arbitrary set of callsites

all the other "flag abuse" you disliked in last patch is avoidable,
unless 2 people are chasing 2 separate problems,
and need to keep their sets distinct

> > Why ?
> >
> > The u-flag & filter flags
> >
> > The 'u' flag lets the user assemble an arbitary set of callsites.
> > Then using filter flags, user can activate the 'u' callsite set.
> >
> >   #> echo 'file foo.c +u; file bar.c +u' > control   # and repeat
> >   #> echo 'u+p' > control
> >
> > Of course, you can continue to just activate your set without ever
> > marking it 1st, but you could trivially add the markup as you go, then
> > be able to use it as a constraint later, to undo or modify your set.
> >
> >   #> echo 'file foo.c +up' >control
> >   .. monitor, debug, finish ..
> >   #> echo 'u-p' >control
> >
> >   # then later resume
> >   #> echo 'u+p' >control
> >
> >   # disable some cluttering messages, and remove from u-set
> >   #> echo 'file noisy.c function:jabber_* u-pu' >control
> >
> >   # for doc, recollection
> >   grep =pu control > my-favorite-callsites
> >
> > Note:
> >
> > Your flagstate after boot is generally not all =_. -DDEBUG will arm
> > compiled callsites by default, $builtinmod.dyndbg=+p bootargs can
> > enable them early, and $module.dyndbg=+p bootargs will arm them when
> > the module is loaded.  But you could manage them with u-flags:
> >
> >   #> echo '-t' >control               # clear t-flag to use it as 2ndary markup
> >   #> echo 'p+ut' >control     # mark the boot-enabled set of callsites
> >   #> echo '-p' >control               # clean your dmesg -w stream
> >
> >   ... monitor, debug ..
> >   #> echo 'module of_interest $qterms +pu' >control   # build your set of useful debugs
> >   #> echo 'module of_interest $qterms UT+pu' >control # same, but dont alter ut marked set
>
> Does anyone requested this feature, please?
>
> For me, it is really hard to imagine people using these complex and hacky
> steps.
>
> Not to say that using t-flag as a markup looks like a real hack.
> People either always need the line number in the kernel log or
> they do not need it at all.
>
> Let me repeat. Please, stop this non-sense.
>
> Best Regards,
> Petr
