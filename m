Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DC7AC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 21:32:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55A62206F1
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 21:32:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VRGICagI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731173AbgFRVcH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 17:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbgFRVcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 17:32:06 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C05EC06174E;
        Thu, 18 Jun 2020 14:32:06 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id j13so4433353vsn.3;
        Thu, 18 Jun 2020 14:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ml/D3zjI+8qfOnOiKPuwIHCYBzZ+9lwSZaJY7CLHjbE=;
        b=VRGICagIWOw7ZQ0eVULB6xnXZk1399+vr+8Y8x+F9GUi9jJfVfXaSYqo8IRfFUDn76
         6nxLtgLTn9mwC3Py1zjDfeaL36JW8BroNZ84eTV9CoXaPwjkHSu40L0279elFFPnMEID
         GqLuxTiLPr8aVOUv7ePQcFujd8HJ3jOk8ZCqmBhWC7yzEL7Cl2kq4E2Css1TwFig7RyC
         DxQivceQILKIBE4mI3iFsPNSDJF0GyBLt68kO0ILMvDYW7xPUQjs2FDEXfFNksdAQaHZ
         o+2DJygheoYJ305k2iamugT9FnHm4mlfzZ8pmqUtmxi2RACNayStJTHysObiDigtdErr
         ln1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ml/D3zjI+8qfOnOiKPuwIHCYBzZ+9lwSZaJY7CLHjbE=;
        b=QrHSLHiCd8h9pKqPrChD3IwIy7y04d43VH612sJmtOIQRM/8cbjHvMY+0s7pJXrmY5
         0sh7n9RB8b3+mnAvCzSwKWz7+RzTga/Wz86vMgx0I7VLOTzvEyRJ+qiCRj1EcimhMaow
         /Xclrslblg8699Au7/2nuEcdCxuBUwumkyEkBasYAazc51U048AC+DoWesNumOLRS95M
         ui1ln8/K0LxsfijiVsMCqadMB9HZsk8cfDFkN+lhmA8P71OEsLEfWN8XLTcJpmylsqVS
         PWDeA/KqwP1jdNYW0z7k1hveQpzm3glhxWsXUiku2rJo5MU4QHlOLJlVh7d1Rg3q+kJ3
         mQbQ==
X-Gm-Message-State: AOAM533ja4KzIeLTLQ9pLoDuPSw51CfAkBHT7bf4v4gQEIKQgLX8LYaK
        t4TskZhDa31pOtMZLhJPCDPW9KzMu6aTTix/MgM=
X-Google-Smtp-Source: ABdhPJzvObaTORVySDSQhln3Qcmj6oDxudu3J7iyvlHWsS4eBK2g8KLV/pSHVqEqDUauAaygd6fDuwFQSBmcsO6OHQg=
X-Received: by 2002:a67:c511:: with SMTP id e17mr5019876vsk.210.1592515925149;
 Thu, 18 Jun 2020 14:32:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200617162536.611386-1-jim.cromie@gmail.com> <20200617162536.611386-23-jim.cromie@gmail.com>
 <20200618161912.GD3617@alley> <20200618174058.GE3617@alley>
 <746984fb-00ee-9079-efac-50167f3c3e40@akamai.com> <CAJfuBxwLKDSx6RA_ZOk=eEHw0P3FeAcT=PCr-aHjUFKDS2p8cQ@mail.gmail.com>
 <172c0580-279f-aa3e-817a-4216067bea10@akamai.com>
In-Reply-To: <172c0580-279f-aa3e-817a-4216067bea10@akamai.com>
From:   jim.cromie@gmail.com
Date:   Thu, 18 Jun 2020 15:31:38 -0600
Message-ID: <CAJfuBxzXbYHPcLiw9skN-4pehE3M_ztOr3i3YT7dd=HojP2i2w@mail.gmail.com>
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
        Linux Documentation List <linux-doc@vger.kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 18, 2020 at 1:40 PM Jason Baron <jbaron@akamai.com> wrote:
>
>
>
> On 6/18/20 3:11 PM, jim.cromie@gmail.com wrote:
> > On Thu, Jun 18, 2020 at 12:17 PM Jason Baron <jbaron@akamai.com> wrote:
> >>

> >
> >> The grouping stuff is already being used by lots of modules so
> >> that seems useful.
> >
> > I now dont see the need.
> >
> > given N debug callsites, any group can be defined by <N queries,
> > probably a lot less
> > if module authors can use ddebug_exec_queries(), cuz its exported, (15/21)
> > then they can act (+p or -p) on those sets defined by <N queries.
> >
> > and now any callsite can be in any number of groups, not just one.
> > It would be prudent to evaluate such groupings case by case,
> > because the intersecting callsites are subject to "last manipulator wins"
> > but its unnecessary to insist that all sets are disjoint.
> > Unlike pr_debug_n, however its spelled.
> >
>
> hmm - so I think you are saying there is then no need to change the
> calling functions themselves - its still 'pr_debug()'. You could even
> use the 'format' qualifier for example to implement your groups that
> way.
>
> For example:
>
> pr_debug("failure type1: blah");
> pr_debug("failure type2: blah blah");
>
> and then do: ddebug_exec_queries("format type1 +p", module);

Exactly

and using format, which always have user relevant info,
and often some severity indication (forex warn info err)
are a workable classification scheme already in use at least informally

So Id expect that this classification can often be done in 1 query.
define the set of callsites in 1 query-string, add +p or -p to it, and
manipulate away.

Amplifying,
this is the only user interface of consequence in dyndbg.
/sys/.../verbose doesnt count

Letting module authors use it is the full-featured way,
everything else is crap (movie reference)
and would require far more maintenance

>
> I would be curious to see what Stanimir thinks of this proposal
> and whether it would work for his venus driver, which is what
> prompted this module group discussion.
>

Indeed.
Id also like to hear from drm folks

./drm/amd/display/include/logger_types.h:#define DC_LOG_SURFACE(...)
pr_debug("[SURFACE]:"__VA_ARGS__)
./drm/amd/display/include/logger_types.h:#define
DC_LOG_HW_LINK_TRAINING(...)
pr_debug("[HW_LINK_TRAINING]:"__VA_ARGS__)
./drm/amd/display/include/logger_types.h:#define DC_LOG_HW_AUDIO(...)
pr_debug("[HW_AUDIO]:"__VA_ARGS__)
./drm/amd/display/include/logger_types.h:#define DC_LOG_SCALER(...)
pr_debug("[SCALER]:"__VA_ARGS__)
./drm/amd/display/include/logger_types.h:#define DC_LOG_BIOS(...)
pr_debug("[BIOS]:"__VA_ARGS__)
./drm/amd/display/include/logger_types.h:#define
DC_LOG_BANDWIDTH_CALCS(...) pr_debug("[BANDWIDTH_CALCS]:"__VA_ARGS__)
./drm/amd/display/include/logger_types.h:#define DC_LOG_DML(...)
pr_debug("[DML]:"__VA_ARGS__)
./drm/amd/display/include/logger_types.h:#define DC_LOG_IF_TRACE(...)
pr_debug("[IF_TRACE]:"__VA_ARGS__)
./drm/amd/display/include/logger_types.h:#define DC_LOG_GAMMA(...)
pr_debug("[GAMMA]:"__VA_ARGS__)
./drm/amd/display/include/logger_types.h:#define DC_LOG_ALL_GAMMA(...)
pr_debug("[GAMMA]:"__VA_ARGS__)
./drm/amd/display/include/logger_types.h:#define
DC_LOG_ALL_TF_CHANNELS(...) pr_debug("[GAMMA]:"__VA_ARGS__)

those defines suggest that they are already doing this with existing formats
with the export,
they can implement this group control using dyndbg with little effort.
including the tie-in to the __debug var if thats useful

and of course, user can add or subtract from that set ad-hoc.

> Thanks,
>
> -Jason

thanks
jimc
