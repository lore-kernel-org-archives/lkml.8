Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 792F9C433E5
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 22:14:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FA6D2065F
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 22:14:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rSyT29QG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728022AbgGOWOz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 18:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727972AbgGOWOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 18:14:50 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28E19C061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 15:14:50 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id f7so4631823wrw.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 15:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mGOlP9G5CXJe9eB7XItn7CJnKM6Jix0dL12Y/lrDDZk=;
        b=rSyT29QGebga4yLdY0Ovq+pzg4H3/wyIXlF4UMurpsQ85dJIdahdklNIKcMrvA6gaT
         +HpJrxTaEoK89o2e2XMKyYPwjtG5A7pkJydGnEYVmq5kzaERiS5Yoat3OEjXYNOaBAZe
         Pz1ZBvm+xVToPjzlr5w5bRupLWA9AFoFoe/fdNVTw8cJUPyVE1Tl3Ax/B0hJ0pW6+S2c
         9NsokrYhLr2X0pJTX0rh/mkVU2SznCeQoIWNgETdObcp5ZsLmtOlX2zq5c8qxk6bcBKG
         XJT70GE0qez7Pu8L81Slq8wVbSa6RGruXP8fANFdKkEX3hWoJAb1Cbc7vzYa2Wpu+BW1
         9+yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mGOlP9G5CXJe9eB7XItn7CJnKM6Jix0dL12Y/lrDDZk=;
        b=G29vs75f0k67IbenN2orIavRRzlEMR8CoDg9ldeX4tMeRIhQ3aC+baxURRMsUoov8f
         Z+gFCwsavSnaYwKekjJQo654cZzBUehT2e2Zghg3cK7HYaDZGDt3LJlFeRDyzsUy7Yc2
         R6sEKM8kwxQ34YSnVmx2JKbLgAtEg0pl3gYOtMBFQLcqnyvMEFH5Vu7bOy/sl2fHltMB
         DUMMiQBW1iPhQlbWoI9CHXnG+i07j+1MH+BTYzXZADS21bykJG/+tlIsSEX4MN6GFrWM
         taoSXM9k8hSen+VObv1VnCtImNMTXBm6vAvM02Nq5lSC4WOOBnWRv9T17fqHH7yaMzvm
         /shA==
X-Gm-Message-State: AOAM533eEzSx1wgqwPzf6dyFSLN6qsXwlODYsbc+7kAAlesZFzmmKBbO
        oowzktDbddeS8Tc1QIzdd5ID4P3xcoTLYmvT6SCj0g==
X-Google-Smtp-Source: ABdhPJx9FEJ+aW22lQiTU/77KbFvqUqLIWRi8krNaoDW8bkuzCqQ9W4/adRfXqOKHusucCsOQkd0JY77DxhCk2oiYFU=
X-Received: by 2002:adf:e40e:: with SMTP id g14mr1828123wrm.271.1594851288721;
 Wed, 15 Jul 2020 15:14:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200712132634.138901-1-jolsa@kernel.org> <20200712132634.138901-14-jolsa@kernel.org>
 <CAP-5=fXHGGCFw_5zcXboFUYeNMMC5K0fbAXwPn0HRw91pt6A0A@mail.gmail.com> <20200715211908.GS183694@krava>
In-Reply-To: <20200715211908.GS183694@krava>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 15 Jul 2020 15:14:37 -0700
Message-ID: <CAP-5=fXdP+Km-RPchL-C0VbSiBhrOBveTTUoqTzx-Tvub6wYng@mail.gmail.com>
Subject: Re: [PATCH 13/18] perf metric: Add events for the current group
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.garry@huawei.com>,
        "Paul A. Clarke" <pc@us.ibm.com>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 15, 2020 at 2:19 PM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Wed, Jul 15, 2020 at 10:00:09AM -0700, Ian Rogers wrote:
> > On Sun, Jul 12, 2020 at 6:27 AM Jiri Olsa <jolsa@kernel.org> wrote:
> > >
> > > There's no need to iterate the whole list of groups,
> > > when adding new events. The currently created group
> > > is the one we want to add.
> > >
> > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > ---
> > >  tools/perf/util/metricgroup.c | 22 ++++++++++++----------
> > >  1 file changed, 12 insertions(+), 10 deletions(-)
> > >
> > > diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> > > index 8cbcc5e05fef..66f25362702d 100644
> > > --- a/tools/perf/util/metricgroup.c
> > > +++ b/tools/perf/util/metricgroup.c
> > > @@ -811,17 +811,19 @@ static int metricgroup__add_metric(const char *metric, bool metric_no_group,
> >
> > Could we add a function comment to describe the arguments here?
>
> ok
>
> > Currently events is an empty list out argument that is built up by
> > this code, now it will be incrementally updated. Except I don't think
> > I'm capturing the current state correctly, it is confusing that there
> > is the loop in the current code. It looks like events will be added
> > multiple times redundantly.
>
> oops, I meant to add the example of broken processing in here,
> but forgot.. will update
>
> >
> > >         if (ret)
> > >                 return ret;
> > >
> > > -       list_for_each_entry(eg, group_list, nd) {
> > > -               if (events->len > 0)
> > > -                       strbuf_addf(events, ",");
> > > +       if (events->len > 0)
> > > +               strbuf_addf(events, ",");
> > >
> > > -               if (eg->has_constraint) {
> > > -                       metricgroup__add_metric_non_group(events,
> > > -                                                         &eg->pctx);
> > > -               } else {
> > > -                       metricgroup__add_metric_weak_group(events,
> > > -                                                          &eg->pctx);
> > > -               }
> > > +       /*
> > > +        * Even if we add multiple groups through the runtime
> > > +        * param, they share same events.
> > > +        */
> >
> > I'm not clear what runtime param is here. Is it the \? arch runtime parameter?
>
> yes, that's that ppc quirk.. adding extra same metrics based
> on that runtime param.. for some reason ;-)

Do they share the same event? I thought the "?" was substituted in a
loop for a value 0...arch_runtime_value and so you got an event for
each of those values.

Thanks,
Ian

> thanks,
> jirka
>
