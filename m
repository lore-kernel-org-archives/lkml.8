Return-Path: <SRS0=fM4p=AJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E135C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 22:04:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03DDC20672
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 22:04:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JofmlLCl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbgF1WEQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jun 2020 18:04:16 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:52687 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726080AbgF1WEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 18:04:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593381854;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SpuS39ZHyysAFTXqQFaKXgrz4rR7/fTFWJI3d8tjYg4=;
        b=JofmlLCl37WXPo1SgcFHNlrLbT/drLcALD2etIPbvnkgJ1qbUZn6DbRQtgrV5Oy6RaUWPc
        DQnFV9w45raGjRytOb/P0042xVxyim3yQvlhW1Jp/KFpluGVrS+ZXcjyWzJmj5yYKBkpDo
        VhxBfED3SWjIOLPRLaJKSlmE/YbUH1Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-313-y_UC1SkyOOqW8X_3a75xOg-1; Sun, 28 Jun 2020 18:04:12 -0400
X-MC-Unique: y_UC1SkyOOqW8X_3a75xOg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C5F368015CB;
        Sun, 28 Jun 2020 22:04:10 +0000 (UTC)
Received: from krava (unknown [10.40.192.56])
        by smtp.corp.redhat.com (Postfix) with SMTP id 03067121B6B;
        Sun, 28 Jun 2020 22:04:07 +0000 (UTC)
Date:   Mon, 29 Jun 2020 00:04:07 +0200
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
Subject: Re: [PATCH 06/10] perf tools: Collect other metrics in struct egroup
Message-ID: <20200628220407.GQ2988321@krava>
References: <20200626194720.2915044-1-jolsa@kernel.org>
 <20200626194720.2915044-7-jolsa@kernel.org>
 <CAP-5=fW8Jhajhtt=kvinA=0+qiineG-yt11RN7w=X0yWCxprZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fW8Jhajhtt=kvinA=0+qiineG-yt11RN7w=X0yWCxprZA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 26, 2020 at 02:06:47PM -0700, Ian Rogers wrote:

SNIP

> > diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> > index 85e7fa2e2707..f88fd667cc78 100644
> > --- a/tools/perf/util/metricgroup.c
> > +++ b/tools/perf/util/metricgroup.c
> > @@ -102,12 +102,20 @@ void metricgroup__rblist_exit(struct rblist *metric_events)
> >         rblist__exit(metric_events);
> >  }
> >
> > +struct eother {
> > +       const char *metric_name;
> > +       const char *metric_expr;
> > +       struct list_head list;
> > +};
> > +
> >  struct egroup {
> >         struct list_head nd;
> >         struct expr_parse_ctx pctx;
> >         const char *metric_name;
> >         const char *metric_expr;
> >         const char *metric_unit;
> > +       struct list_head other;
> > +       int other_cnt;
> >         int runtime;
> >         bool has_constraint;
> >  };
> 
> Nit, could we do better than egroup and eother for struct names?
> egroup are nodes within the metric group with their associated values,
> so would metric_group_node be more intention revealing? eother and
> other are metrics referred to by the metric_group_node. Presumably the
> metrics are on the same list as egroup? Perhaps eother could be
> referenced_metrics?

ok, how about:

struct metric_group_node
struct metric_ref

jirka

