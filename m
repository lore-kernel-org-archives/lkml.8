Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C635C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 19:11:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01584207E8
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 19:11:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rr6cMp+p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730423AbgFRTLf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 15:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726928AbgFRTLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 15:11:34 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05B18C06174E;
        Thu, 18 Jun 2020 12:11:34 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id o2so4216951vsr.0;
        Thu, 18 Jun 2020 12:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZebGe6fqq69ecoKcHg2KRDEus71g/owyxo+6JyLDc4U=;
        b=rr6cMp+pYDtd4jF17C/I6V7kfgSVTq4cdZ/GB7s7gw4Hwg9E1B0la+rvwIQKwK8bBh
         LnoKqunFza8A2j6BNl3uLB4aE3CWkBS7VE7HpK+HNGAE0ufrkKUE0Q6DJxQBiwqNww1Q
         M38qW8SOB5VmpInpmiCul+FUoia7qiHSguPd7tFCv1rz+PRgD19X6kX4Y1Xsj/Af63Fg
         2l30QGfOr3kDbeg713cc0PllSSV9FsApFXu/+W5sXpimHSGuT9ifajYUNtqdFeLQcHXJ
         PErLniO4aTq+CQ317k9OcLWssw+ImkjGYNeOjW/4IsvYJNrBrPkvBYnaTYSVhFhDG7+E
         JTiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZebGe6fqq69ecoKcHg2KRDEus71g/owyxo+6JyLDc4U=;
        b=PkMqAQFsxz4JUZzsMRimMRcuFH7ae2uWjZ4O2TWUVSV0yeWQQ0E2MzEr7ylZoFyCBc
         RX7+QGHYyObD/1QOjO2kgLjYJsdKpO1Pnd5ZNj3p6FO9e2CMit/wXmNy/YQd34o0UMrv
         wSvXsgzSYRW/P5OO3nPgzDhsVvP+YvLO8W3jZZT3dI0TLBsnEEPTi7rnxCBfGlNGI6es
         wDh2lS8D6Mjoc4TEXNKW1LMbyyOWCjX1wDf58nCGmZY4dwQlirKEGqYKFacrx8zhto9r
         FQq63ZQ8CdDPLmgh5bkaE6QgGpsqSgyh/t1h2HO/9UQlsoCkwJtXUA6LHYMkvfUvFAoL
         zjGQ==
X-Gm-Message-State: AOAM5339+5P2Zp2464LxHaAB1WfFYqhDi66vuyoPPYnLulHX6uTp8zOn
        DpXZeYCp3Yn8JmU1pryIWv5sp3/eYWZDNdgLKj4=
X-Google-Smtp-Source: ABdhPJzJXLg5SLsVat7yfN8dxV6pjokZWmuV33W6ZhYfPvmPSYDuvYmxfMAoMg+oGmyngU6tgQ9cQBxEg0cSTUYvv4s=
X-Received: by 2002:a67:f918:: with SMTP id t24mr4847378vsq.18.1592507491557;
 Thu, 18 Jun 2020 12:11:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200617162536.611386-1-jim.cromie@gmail.com> <20200617162536.611386-23-jim.cromie@gmail.com>
 <20200618161912.GD3617@alley> <20200618174058.GE3617@alley> <746984fb-00ee-9079-efac-50167f3c3e40@akamai.com>
In-Reply-To: <746984fb-00ee-9079-efac-50167f3c3e40@akamai.com>
From:   jim.cromie@gmail.com
Date:   Thu, 18 Jun 2020 13:11:05 -0600
Message-ID: <CAJfuBxwLKDSx6RA_ZOk=eEHw0P3FeAcT=PCr-aHjUFKDS2p8cQ@mail.gmail.com>
Subject: Re: [PATCH v3 20/21] dyndbg: add user-flag, negating-flags, and
 filtering on flags
To:     Jason Baron <jbaron@akamai.com>
Cc:     Petr Mladek <pmladek@suse.com>,
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

On Thu, Jun 18, 2020 at 12:17 PM Jason Baron <jbaron@akamai.com> wrote:
>
>
>
> On 6/18/20 1:40 PM, Petr Mladek wrote:
> > On Thu 2020-06-18 18:19:12, Petr Mladek wrote:
> >> On Wed 2020-06-17 10:25:35, Jim Cromie wrote:
> >>> 1. Add a user-flag [u] which works like the [pfmlt] flags, but has no
> >>> effect on callsite behavior; it allows incremental marking of
> >>> arbitrary sets of callsites.
> >>>
> >>> 2. Add [PFMLTU] flags, which negate their counterparts; P===!p etc.
> >>> And in ddebug_read_flags():
> >>>    current code does:       [pfmltu_] -> flags
> >>>    copy it to:              [PFMLTU_] -> mask
> >>>
> >>> also disallow both of a pair: ie no 'pP', no true & false.
> >>>
> >>> 3. Add filtering ops into ddebug_change(), right after all the
> >>> callsite-property selections are complete.  These filter on the
> >>> callsite's current flagstate before applying modflags.
> >>>
> >>> Why ?
> >>>
> >>> The u-flag & filter flags
> >>>
> >>> The 'u' flag lets the user assemble an arbitary set of callsites.
> >>> Then using filter flags, user can activate the 'u' callsite set.
> >>>
> >>>   #> echo 'file foo.c +u; file bar.c +u' > control   # and repeat
> >>>   #> echo 'u+p' > control
> >>>
> >>> Of course, you can continue to just activate your set without ever
> >>> marking it 1st, but you could trivially add the markup as you go, then
> >>> be able to use it as a constraint later, to undo or modify your set.
> >>>
> >>>   #> echo 'file foo.c +up' >control
> >>>   .. monitor, debug, finish ..
> >>>   #> echo 'u-p' >control
> >>>
> >>>   # then later resume
> >>>   #> echo 'u+p' >control
> >>>
> >>>   # disable some cluttering messages, and remove from u-set
> >>>   #> echo 'file noisy.c function:jabber_* u-pu' >control
> >>>
> >>>   # for doc, recollection
> >>>   grep =pu control > my-favorite-callsites
> >>>
> >>> Note:
> >>>
> >>> Your flagstate after boot is generally not all =_. -DDEBUG will arm
> >>> compiled callsites by default, $builtinmod.dyndbg=+p bootargs can
> >>> enable them early, and $module.dyndbg=+p bootargs will arm them when
> >>> the module is loaded.  But you could manage them with u-flags:
> >>>
> >>>   #> echo '-t' >control             # clear t-flag to use it as 2ndary markup
> >>>   #> echo 'p+ut' >control   # mark the boot-enabled set of callsites
> >>>   #> echo '-p' >control             # clean your dmesg -w stream
> >>>
> >>>   ... monitor, debug ..
> >>>   #> echo 'module of_interest $qterms +pu' >control # build your set of useful debugs
> >>>   #> echo 'module of_interest $qterms UT+pu' >control       # same, but dont alter ut marked set
> >>
> >> Does anyone requested this feature, please?
> >>
> >> For me, it is really hard to imagine people using these complex and hacky
> >> steps.
> >
> > I think that all this is motivated by adding support for module
> > specific groups.
> >
> > What about storing the group as yet another information for each
> > message? I mean the same way as we store module name, file, line,
> > function name.
> >
> > Then we could add API to define group for a given message:
> >
> >    pr_debug_group(group_id, fmt, ...);
> >
> > the interface for the control file might be via new keyword "group".
> > You could then do something like:
> >
> >    echo module=drm group=0x3 +p >control
> >
> > But more importantly you should add functions that might be called
> > when the drm.debug parameter is changes. I have already mentioned
> > it is another reply:
> >
> >     dd_enable_module_group(module_name, group_id);
> >     dd_disable_module_group(module_name, group_id);
> >
> >
> > It will _not_ need any new flag or flag filtering.
> >
> > Best Regards,
> > Petr
> >
>
> Yes, I'm wondering as well if people are really going to use the
> new flags and filter flags - I mentioned that here:
> https://lkml.org/lkml/2020/6/12/732
>

yes, I saw, and replied there.
but since that was v1, and we're on v3, we should refresh.

the central use-case is above, 1-liner version summarized here:

1- enable sites as you chase a problem with +up
2- examine them with grep =pu
3- change the set to suit, either by adding or subtracting callsites.
4- continue debugging, and changing callsites to suit
5- grep =pu control > ~/debugging-session-task1-callsites
6- echo up-p >control   # disable for now, leave u-set for later
7- do other stuff
8 echo uP+p >control # reactivate useful debug-state and resume


> The grouping stuff is already being used by lots of modules so
> that seems useful.

I now dont see the need.

given N debug callsites, any group can be defined by <N queries,
probably a lot less
if module authors can use ddebug_exec_queries(), cuz its exported, (15/21)
then they can act (+p or -p) on those sets defined by <N queries.

and now any callsite can be in any number of groups, not just one.
It would be prudent to evaluate such groupings case by case,
because the intersecting callsites are subject to "last manipulator wins"
but its unnecessary to insist that all sets are disjoint.
Unlike pr_debug_n, however its spelled.

>
> Thanks,
>
> -Jason
