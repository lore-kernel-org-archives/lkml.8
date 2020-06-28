Return-Path: <SRS0=fM4p=AJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C414C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 22:00:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 396992074F
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 22:00:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WDaF/wXb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbgF1WAI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jun 2020 18:00:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20080 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726080AbgF1WAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 18:00:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593381605;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3+kqHrF5IVEZWKjxO7T2nqUedq6/nP/FcOlUEuYV78M=;
        b=WDaF/wXbbtsbA+a/mglWPCH4gamrmq3+GeDF4Nxlu7zKZ00YsLdi34e51PDuobo8+e9y5Q
        ePFJpWGowyODAUpHAi9x4/enHdXCQcZLttyIwr180+QyfMY0hK/GGWx9TzeDf46+Iu5MI9
        WVUeenEh4zIJhsAd1XMF+96zwoZKpx8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-325-PI5KVIZdNJOybjvvC1XHWA-1; Sun, 28 Jun 2020 18:00:03 -0400
X-MC-Unique: PI5KVIZdNJOybjvvC1XHWA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3144B1005512;
        Sun, 28 Jun 2020 22:00:01 +0000 (UTC)
Received: from krava (unknown [10.40.192.56])
        by smtp.corp.redhat.com (Postfix) with SMTP id 5C1C6121B73;
        Sun, 28 Jun 2020 21:59:58 +0000 (UTC)
Date:   Sun, 28 Jun 2020 23:59:57 +0200
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
Subject: Re: [PATCH 09/10] perf tools: Compute other metrics
Message-ID: <20200628215957.GO2988321@krava>
References: <20200626194720.2915044-1-jolsa@kernel.org>
 <20200626194720.2915044-10-jolsa@kernel.org>
 <CAP-5=fUODuF+LY6cbU4BPEcxu_YXDYg42pgRYU=yY5e47z05=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fUODuF+LY6cbU4BPEcxu_YXDYg42pgRYU=yY5e47z05=g@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 26, 2020 at 02:24:38PM -0700, Ian Rogers wrote:

SNIP

> > +
> > +                                       if (expr__get_id(ctx, lookup, &data) || !data) {
> >                                                 pr_debug("%s not found\n", $1);
> >                                                 free($1);
> >                                                 YYABORT;
> >                                         }
> > +
> > +                                       pr_debug2("lookup: is_other %d, counted %d: %s\n",
> > +                                                 data->is_other, data->other.counted, lookup);
> > +
> > +                                       if (data->is_other && !data->other.counted) {
> > +                                               data->other.counted = true;
> > +                                               if (expr__parse(&data->val, ctx, data->other.metric_expr, 1)) {
> 
> Ah, so this handles the problem the referenced metric isn't calculated
> and calculates it - with the sharing of events this doesn't impose
> extra pmu cost. Do we need to worry about detecting recursion? For
> example:
> 
> "MetricName": "Foo",
> "MetricExpr": "1/metric:Foo",

right, we should add some recursion check,
I'll lcheck on it

> 
> It seems unfortunate to have the MetricExpr calculated twice, but it

hum, not sure what you mean by twice.. we do that just once for
each involved metric and store the value.. the metric is also
processed before for 'other' metrics

jirka

> is understandable. Is it also a property that referenced/other metrics
> won't be reported individually? Perhaps these are sub-metrics?

> 
> Thanks,
> Ian
> 
> > +                                                       pr_debug("%s failed to count\n", $1);
> > +                                                       free($1);
> > +                                                       YYABORT;
> > +                                               }
> > +                                       }
> > +
> >                                         $$ = data->val;
> >                                         free($1);
> >                                 }
> > --
> > 2.25.4
> >
> 

