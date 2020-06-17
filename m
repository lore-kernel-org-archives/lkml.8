Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05EB0C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 13:24:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C31182098B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 13:24:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gHmMFn2S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbgFQNYE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 09:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbgFQNYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 09:24:02 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BAA3C06174E
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 06:24:01 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id t132so1371363vst.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 06:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VdTZzLtW2iKuFC91SF90hDv9y1aJtkbtqqJFPpLAmH4=;
        b=gHmMFn2S12MX19ERkR/LUs7kke9tZ+mSdV+/DUIA//beJgJ2eArdBCWZ50BLKWrdSE
         w2wlKZSFvDKxLiN57gSA/mzU/kkPquA3+Gu6a9FhNyykUGzO7/PeJYh5Nkpy+6lUrxBS
         KXTv8sFILFxRyDPN/0uVUqRd8gX7AFcCeOYWOgaEZ17edySgPLo9mybw8Om0b6EghCzB
         x9amJVPI5XEWI5n7YcvaahLp9BCvx6vaQKXCQ9gwoHopAidel7OuVqgrghsGQ6RKeyn/
         SRUI8WNB3vTQLFQxDizAClZuaamRuKB4oppD3jULSt6WLU1WgK0rDlz5x9btxrBZK4sD
         +UcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VdTZzLtW2iKuFC91SF90hDv9y1aJtkbtqqJFPpLAmH4=;
        b=jdb6wu5gu41WLRaVV5miU9AnRmsHuUMKOlmwG/krerHPNRqG89rc4+g9TUjsLP+Mse
         ysCFhSyuPt2EIytyI3m9T0U2LtNwV3niB8FMxOv3hsh9uQdVSvHnbj52qHtUiXI+6WBn
         wHF8fnLi6oYOI7QcV14xF6CPgM35mmafS1mVr6rZLaE2MhUNESJnuTaQj4Nk/QfZ55pg
         XK/IU8tcUc964x9FDcWekZZb6rL38F083XgxK8EVIhaM3DOSYmkki70gbeW3SlqMFzSl
         5HjyBujOrO7wLyGBIMBD6hIpZB4MTN/lyMGWxBJ1W/MPKwxOln4fOHhU0znB9NYk75cT
         rgUQ==
X-Gm-Message-State: AOAM530wGG4kM62zIhT3RiB7Y5ADpkoNvKULWuKWSuAUUJvJTPZ9Vt/N
        wkEX3CBRS304yHwVRRN+0229hocFJlEph6P6+7Oh60pT
X-Google-Smtp-Source: ABdhPJxx51W7l1h9GA0YrG2y8QRb2dNnsIlGIVDSgOgZVQOxxpd35wWbS7+Lnf89ljRVa31ebv2UhV++bWWi9Hd8CTA=
X-Received: by 2002:a67:5cc1:: with SMTP id q184mr5660414vsb.78.1592400240371;
 Wed, 17 Jun 2020 06:24:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200613155738.2249399-1-jim.cromie@gmail.com>
 <20200613155738.2249399-21-jim.cromie@gmail.com> <20200616134507.GO31238@alley>
 <5b0fade06c46da0a469266738c684ba55d8e39f0.camel@perches.com>
 <20200617093154.v7mf5355faa4c7ob@holly.lan> <20200617095255.GU31238@alley>
In-Reply-To: <20200617095255.GU31238@alley>
From:   jim.cromie@gmail.com
Date:   Wed, 17 Jun 2020 07:23:34 -0600
Message-ID: <CAJfuBxzDvW-nD51Zayv9K6mUuRGh5iR_+NzO4Hwf7UQEs5z28g@mail.gmail.com>
Subject: Re: [PATCH v2 20/24] dyndbg: WIP towards debug-print-class based
 callsite controls
To:     Petr Mladek <pmladek@suse.com>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Joe Perches <joe@perches.com>, Jason Baron <jbaron@akamai.com>,
        LKML <linux-kernel@vger.kernel.org>, akpm@linuxfoundation.org,
        Greg KH <gregkh@linuxfoundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 17, 2020 at 3:52 AM Petr Mladek <pmladek@suse.com> wrote:
>
> On Wed 2020-06-17 10:31:54, Daniel Thompson wrote:
> > On Tue, Jun 16, 2020 at 02:05:27PM -0700, Joe Perches wrote:
> > > On Tue, 2020-06-16 at 15:45 +0200, Petr Mladek wrote:
> > > > On Sat 2020-06-13 09:57:34, Jim Cromie wrote:
> > > > > There are *lots* of ad-hoc debug printing solutions in kernel,
> > > > > this is a 1st attempt at providing a common mechanism for many of them.
> > > >
> > > > I agree that it might make sense to provide some common mechanism.
> > > []
> > > > My problem with this approach is that it is too generic. Each class
> > > > would have different meaning in each subsystem.
> > > >
> > > > It might help to replace any existing variants. But it would be hard
> > > > for developers debugging the code. They would need to study/remember
> > > > the meaning of these groups for particular subsystems. They would
> > > > need to set different values for different messages.
> > > >
> > > > Could you please provide more details about the potential users?
> > > > Would be possible to find some common patterns and common
> > > > meaning of the groups?
> > >
> > > I doubt the utility of common patterns.
> > > Verbosity is common but groupings are not.
> > >
> > > Look at the DRM patterns vs other groups.
> >
> > I've seen drm.debug mentioned a couple of times but the comments about
> > it seem to only learn part of what is shows us.
> >
> > drm.debug is a form of common grouping but it acts at a sub-system level
> > rather then whole system (and gives a whole sub-system enable/disable).
> > This is where grouping makes most sense.
> >
> > The result is that drm.debug is easy to document, both in official
> > kernel docs and in other resources (like the arch distro documentation).
> > Having controls that are easy to document makes them easy to find and
> > thus sub-system grouping leads directly to higher quality bug reports.
>
> Thanks a lot for explanation.
>
> Now, could anyone please tell me how this new dynamic debug feature
> would allow to replace drm.debug option?
>
> I mean what steps/commands will be needed instead of, for example
> drm.debug=0x3 command line option?
>
> Best Regards,
> Petr


[jimc@frodo linux.git]$ git log -1
commit 12a67ffb3e63c40027e251b44b2abc77463dc2da (HEAD -> dd-v3)
Author: Jim Cromie <jim.cromie@gmail.com>
Date:   Tue Jun 16 15:36:37 2020 -0600

    dyndbg: export ddebug_exec_queries

    Exporting ddebug_exec_queries will allow module authors using dynamic
    debug to actually control/enable/disable their own pr-debug callsites
    dynamically.

    With it, module authors can tie any update of their internal debug
    variables to a corresponding ddebug_exec_queries invocation, which
    will modify all their selected callsites accordingly.

    Generally, authors would exec +p or -p on some subsets of their set of
    callsites, and leave fmlt flags for user to choose the appropriate
    amount of structural context desired in the logs.

    Depending upon the user needs, the module might be known, and
    therefore a waste of screen width, function would be valuable, file
    would be long and familiar to the author, etc..  That said, author
    could harness the message-prefix facility if they saw fit to do so.
    Any author preferences can be overridden with echo >control

    Is it safe ?

    ddebug_exec_queries() is currently 'exposed' to user space in
    several limited ways;

    1 it is called from module-load callback, where it implements the
      $modname.dyndbg=+p "fake" parameter provided to all modules.

    2 it handles query input from >control directly

    IOW, it is "fully" exposed to local root user; exposing the same
    functionality to other kernel modules is no additional risk.

    The other big issue to check is locking:

    dyndbg has a single mutex, taken by ddebug_change to handle >control,
    and by ddebug_proc_(start|stop) to span `cat control`.  ISTM this
    proposed export presents no locking problems.

    drm use case:

    drm.debug=0x03 appears to be a kernel boot-arg example, setting 2
    internal debug flags.  Each bit is probably controlling a separate
    subset of all debug-prints, they may be overlapping subsets.

    Those subsets are *definitely* expressible as a few dyndbg queries
    each.  Any arbitrary subset is.

       drm.dyndbg='file drm_gem_* +p'       # gem debug
       drm.dyndbg='file *_gem_* +p'         # *gem debug

    With this proposed export, drm authors could exec these examples, most
    likely in the callback that handles updates to the drm.debug variable.
(END)

I should note that none of this needs the WIP patch
