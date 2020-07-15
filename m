Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B53C4C433E5
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 21:19:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B2E7207BC
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 21:19:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZG1zi7bL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbgGOVTT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 17:19:19 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:20902 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725917AbgGOVTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 17:19:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594847956;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0pIO/CyK9TUBNUHGP+XxCwmCDqMIbTL/hRitVCQDSjQ=;
        b=ZG1zi7bLz5pTOulrtyhx9No48Cb9/kPsuDLeRgKH3TARgO+AtF6v7bcx72+8Y06ycu0vli
        JT2pp6L9Pm9RkEueDVEAL6nq59w8eSagJHMiuQe41Pa9wNoa9r+b3xNiRZx5ZEew6hGY7q
        EtASz+cKzB7RUZOFKJ0o7SHRkpIkO9g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-485-894-qe1GP7y-jGgegK0VSw-1; Wed, 15 Jul 2020 17:19:14 -0400
X-MC-Unique: 894-qe1GP7y-jGgegK0VSw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 842561B18BC1;
        Wed, 15 Jul 2020 21:19:12 +0000 (UTC)
Received: from krava (unknown [10.40.194.44])
        by smtp.corp.redhat.com (Postfix) with SMTP id A99B01757A;
        Wed, 15 Jul 2020 21:19:09 +0000 (UTC)
Date:   Wed, 15 Jul 2020 23:19:08 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>
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
Subject: Re: [PATCH 13/18] perf metric: Add events for the current group
Message-ID: <20200715211908.GS183694@krava>
References: <20200712132634.138901-1-jolsa@kernel.org>
 <20200712132634.138901-14-jolsa@kernel.org>
 <CAP-5=fXHGGCFw_5zcXboFUYeNMMC5K0fbAXwPn0HRw91pt6A0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fXHGGCFw_5zcXboFUYeNMMC5K0fbAXwPn0HRw91pt6A0A@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 15, 2020 at 10:00:09AM -0700, Ian Rogers wrote:
> On Sun, Jul 12, 2020 at 6:27 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > There's no need to iterate the whole list of groups,
> > when adding new events. The currently created group
> > is the one we want to add.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/perf/util/metricgroup.c | 22 ++++++++++++----------
> >  1 file changed, 12 insertions(+), 10 deletions(-)
> >
> > diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> > index 8cbcc5e05fef..66f25362702d 100644
> > --- a/tools/perf/util/metricgroup.c
> > +++ b/tools/perf/util/metricgroup.c
> > @@ -811,17 +811,19 @@ static int metricgroup__add_metric(const char *metric, bool metric_no_group,
> 
> Could we add a function comment to describe the arguments here?

ok

> Currently events is an empty list out argument that is built up by
> this code, now it will be incrementally updated. Except I don't think
> I'm capturing the current state correctly, it is confusing that there
> is the loop in the current code. It looks like events will be added
> multiple times redundantly.

oops, I meant to add the example of broken processing in here,
but forgot.. will update

> 
> >         if (ret)
> >                 return ret;
> >
> > -       list_for_each_entry(eg, group_list, nd) {
> > -               if (events->len > 0)
> > -                       strbuf_addf(events, ",");
> > +       if (events->len > 0)
> > +               strbuf_addf(events, ",");
> >
> > -               if (eg->has_constraint) {
> > -                       metricgroup__add_metric_non_group(events,
> > -                                                         &eg->pctx);
> > -               } else {
> > -                       metricgroup__add_metric_weak_group(events,
> > -                                                          &eg->pctx);
> > -               }
> > +       /*
> > +        * Even if we add multiple groups through the runtime
> > +        * param, they share same events.
> > +        */
> 
> I'm not clear what runtime param is here. Is it the \? arch runtime parameter?

yes, that's that ppc quirk.. adding extra same metrics based
on that runtime param.. for some reason ;-)

thanks,
jirka

