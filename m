Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3EB3C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 13:46:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7098320734
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 13:46:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V0+wtc4K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729408AbgFJNqP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 09:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbgFJNqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 09:46:15 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45952C03E96B
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 06:46:15 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id g129so1264687vsc.4
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 06:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wq4HkLDYhFxsWD5nQyIgx+7jGgnzrBPIGkRKQngSF1s=;
        b=V0+wtc4K/4Ux2L9NNrTDWgSh2QKRubbs3948ITco0sgg4046M41Rk24pRlGvJEJmd3
         K7XllSF56Auh6Z03Bb0R9t8TRhJ0hlsIGqaSFjLQiwTsiKokJ2h7nvsTcRRirja2YSlz
         Ify+BpClRZoBO8uOzV60AvRPCD0OmlsR+3d17PovHGS1uDr5X98Y19s1UdFQtv3O+iWG
         bgQMkrdwfYNdOn1mb3/pKNs+sH7p4EvNmxUb6P34ZNQbtolrQjHytC9/SrWe0Ce5xDu/
         o7XK4+7U8Vsvli63sKk4pMKHN3Z7GRl/YYv4Bxyhyc7tQVsy8tmIatkolaaSLPuIH1gW
         OCmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wq4HkLDYhFxsWD5nQyIgx+7jGgnzrBPIGkRKQngSF1s=;
        b=WU1nHil50A462ylyFD8Lzq+w69MxuWpD9sYTqQSaT2uqYfczZQHSBmWCW4Ey1gkkCU
         ZYFD64CARylDbsLymSdeGbTX1XbJa600faDW0Wn6m0i7VGNzDLP3yyJOWux78xAN1EQF
         c+8Y3x92mTqcfgGfuv1XVlctcTWFkid4/9VG48SPkmAH+U9c3+mzr4UAiSDEu2YeqryS
         nZnchjT3BnL+8vnwSZnjk/Hw9KmeCA+NbaLoNrTLV6NIl9IV8CKxZ0VGl9pFpLZJ0kWh
         6ZqKmSqsab35mfVBs9bYI90C9BR9IbTbuo8/mykE6hsEcNenff2HLQyHqFi2QvkZDtlr
         C18A==
X-Gm-Message-State: AOAM5311kGGp6zP7NlbAFsp7+gPOax+kjgZGByBrakRdo2hBoS+HnDTo
        U0zoq4VpMQV3q1r5v5eSwOtxx2PSMjtGnCUieL4S2q9WFmA=
X-Google-Smtp-Source: ABdhPJymRN/uZanXwuboYo9+SvxxobaC//jKjmJCgsCmKNX6iZ+NCbmNSJNdtZjK95+yf4fyx7PloDr0G0RGGHpTRRY=
X-Received: by 2002:a67:fc17:: with SMTP id o23mr2437291vsq.92.1591796774104;
 Wed, 10 Jun 2020 06:46:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200605162645.289174-1-jim.cromie@gmail.com> <20200605162645.289174-4-jim.cromie@gmail.com>
 <20200608112150.7ohrax6pzpi7ss2l@holly.lan> <CAJfuBxwHOyvOcSB8005=z1G_-Hux1UxaLOutOX1SE2wYONSsrg@mail.gmail.com>
 <20200610111615.z6vukjsq2aprkug4@holly.lan>
In-Reply-To: <20200610111615.z6vukjsq2aprkug4@holly.lan>
From:   jim.cromie@gmail.com
Date:   Wed, 10 Jun 2020 07:45:47 -0600
Message-ID: <CAJfuBxxqc2qL+Ba=yqD_tWS5Ux3ggS4ouf1eAmeOqGOFrybvNg@mail.gmail.com>
Subject: Re: [PATCH 03/16] dyndbg: refine debug verbosity; 1 is basic, 2 more chatty
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Jason Baron <jbaron@akamai.com>,
        LKML <linux-kernel@vger.kernel.org>, akpm@linuxfoundation.org,
        Greg KH <gregkh@linuxfoundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 10, 2020 at 5:16 AM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> On Tue, Jun 09, 2020 at 01:59:41PM -0600, jim.cromie@gmail.com wrote:
> > On Mon, Jun 8, 2020 at 5:21 AM Daniel Thompson
> > <daniel.thompson@linaro.org> wrote:
> > >
> > > On Fri, Jun 05, 2020 at 10:26:32AM -0600, Jim Cromie wrote:
> > > > The verbose/debug logging done for `cat $MNT/dynamic_debug/control` is
> > > > voluminous (2 per control file entry + 2 per PAGE).  Moreover, it just
> > > > prints pointer and sequence, which is not useful to a dyndbg user.
> > > > So just drop them.
> > >
> > > I'd assumed these messages where to help the dyndbg implementer rather
> > > than the dyndbg user.
> >
> > So I thought I was guilty of adding those noisy pr_info()s in the
> > ddebug_proc_* functions,
> > but I have touched them, changing them to vpr_info().
> > In any case, I dont think theyre useful to the implementer either.
> >
> > If the verbose messages really are useful to help
> > > users who (mis)configure .../control then should the enable/disable
> > > control be shadowed in debugfs to make it easy to find?
> > >
> >
> > I would hesitate to change the API, even if this is just an add-on,
> > without changes to existing.
> > OTOH, I could see it added as /proc/dynamic_debug/verbose
>
> /proc ?
>
> I was assuming that if the verbose output of dynamic debug is useful to
> the person trying to *use* dynamic_debug then it should be in
> /sys/kernel/debug/dynamic_debug/verbose .

You are correct.
/proc/dynamic_debug/control does exist, so that debugfs isnt required,
but not verbose.  I conflated them while typing.

so, if debugfs isnt present, neither is dynamic_debug/verbose,
and run-time verbosity changes arent possible
but dynamic_debug.verbose=1 still works as boot arg
(I believe, I havent built an non-debugfs kernel myself)

>
> If they are only likely useful to the person trying to *implement*
> dynamic_debug itself (or to check that the infrastructure is not broken)
> then there is no reason to add them to debugfs.
>


>
> > with this patch, verbose=1 is better focused on showing the parsing process,
> > to give user more context as to what his query-command is doing
> > verbose=2 additionally shows callsites that match the query, including
> > any unchanged (iirc)
>
> I'm still a little confused by what benefit having two levels of
> verbosity really is. Why does a user need to turn on verbose mode to
> figure out what is happening? Why isn't reading back
> .../dynamic_debug/control (perhaps using grep and friends) sufficient?
>

verbose=2  prints quite a bit more,
during boot,  290 lines vs 16.
After you see it a dozen times, you dont need it anymore.
but I think its still worth keeping
It also is more chatty about callsites changed by ` echo $querycmd > control `

`cat control` shows complete callsite & flagstate,
it cant also show how commands are processed & changes are applied.


>
> Daniel.
