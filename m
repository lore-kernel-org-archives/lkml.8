Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6435C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 21:29:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4A6B2067D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 21:29:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z9qK0x3D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbgGOV3f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 17:29:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43126 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725917AbgGOV3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 17:29:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594848573;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MpbML4yMq945onzGFlPVUKaSeaPEo2c43J0f2h46uug=;
        b=Z9qK0x3DRQ9b7/hTTKRlbqq6ot9+XmtdQ0GkP6gFd+keOdjgsklhHzUmNOFtfEPXp5kGme
        wn5fZZMdblwtQ1FzVDi0SWaESYB5rH1BdcdkMnDmBc2GV3AgXESSckdQYSPZ1oHOyaaNVo
        5PReBkivWFg7+8Z8/187w2fvbR9akH4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-477-G_lthps0Mdy8k2zjFRnCQQ-1; Wed, 15 Jul 2020 17:29:29 -0400
X-MC-Unique: G_lthps0Mdy8k2zjFRnCQQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5817C18A1DE1;
        Wed, 15 Jul 2020 21:29:27 +0000 (UTC)
Received: from krava (unknown [10.40.194.44])
        by smtp.corp.redhat.com (Postfix) with SMTP id 693075D9C5;
        Wed, 15 Jul 2020 21:29:24 +0000 (UTC)
Date:   Wed, 15 Jul 2020 23:29:23 +0200
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
Subject: Re: [PATCH 16/18] perf metric: Add recursion check when processing
 nested metrics
Message-ID: <20200715212923.GT183694@krava>
References: <20200712132634.138901-1-jolsa@kernel.org>
 <20200712132634.138901-17-jolsa@kernel.org>
 <CAP-5=fUdUKmsGMxsyxxZCzmwRAumLmj6LgGrXWe7APPZRRC=WA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fUdUKmsGMxsyxxZCzmwRAumLmj6LgGrXWe7APPZRRC=WA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 15, 2020 at 10:40:41AM -0700, Ian Rogers wrote:
> On Sun, Jul 12, 2020 at 6:27 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Keeping the stack of nested metrics via 'struct expr_id' objecs
> 
> s/objecs/objects/
> 
> > and checking if we are in recursion via already processed metric.
> >
> > The stack is implemented as static array within the struct egroup
> > with 100 entries, which should be enough nesting depth for any
> > metric we have or plan to have at the moment.
> >
> > Adding test that simulates the recursion and checks we can
> > detect it.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/perf/tests/parse-metric.c |  27 ++++++++-
> >  tools/perf/util/expr.c          |   2 +
> >  tools/perf/util/expr.h          |   9 ++-
> >  tools/perf/util/metricgroup.c   | 101 +++++++++++++++++++++++++++++---
> >  4 files changed, 128 insertions(+), 11 deletions(-)
> >
> > diff --git a/tools/perf/tests/parse-metric.c b/tools/perf/tests/parse-metric.c
> > index b50e2a3f3b73..238a805edd55 100644
> > --- a/tools/perf/tests/parse-metric.c
> > +++ b/tools/perf/tests/parse-metric.c
> > @@ -57,6 +57,14 @@ static struct pmu_event pme_test[] = {
> >         .metric_expr    = "d_ratio(DCache_L2_All_Miss, DCache_L2_All)",
> >         .metric_name    = "DCache_L2_Misses",
> >  },
> > +{
> > +       .metric_expr    = "IPC + M2",
> > +       .metric_name    = "M1",
> > +},
> > +{
> > +       .metric_expr    = "IPC + M1",
> > +       .metric_name    = "M2",
> > +},
> >  };
> 
> Perhaps add a test on simple recursion too:
> {
>   .metric_expr = "1/M1",
>   .metric_name = "M1",
> }

ok, will add

SNIP

> > diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> > index 66f25362702d..69ec20dd737b 100644
> > --- a/tools/perf/util/metricgroup.c
> > +++ b/tools/perf/util/metricgroup.c
> > @@ -24,6 +24,7 @@
> >  #include <subcmd/parse-options.h>
> >  #include <api/fs/fs.h>
> >  #include "util.h"
> > +#include <asm/bug.h>
> >
> >  struct metric_event *metricgroup__lookup(struct rblist *metric_events,
> >                                          struct evsel *evsel,
> > @@ -109,6 +110,8 @@ struct metric_ref_node {
> >         struct list_head list;
> >  };
> >
> > +#define RECURSION_ID_MAX 100
> > +
> >  struct egroup {
> >         struct list_head nd;
> >         struct expr_parse_ctx pctx;
> > @@ -119,6 +122,11 @@ struct egroup {
> >         int refs_cnt;
> >         int runtime;
> >         bool has_constraint;
> > +
> > +       struct {
> > +               struct expr_id  id[RECURSION_ID_MAX];
> > +               int             cnt;
> > +       } recursion;
> >  };
> 
> Rather than place this in the egroup why not pass a "visited" array to
> add metric. This would be more in keeping with Tarjan's algorithm
> (although the SCC isn't needed in this case):
> https://en.wikipedia.org/wiki/Tarjan%27s_strongly_connected_components_algorithm

it's true that it's just source of the 'struct expr_id' objects and
one global array could be used in multiple metrics not event directly
nested ... seems good, will check

thanks,
jirka

