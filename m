Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EA77C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 13:51:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0812720717
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 13:51:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cJAfNtWM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbgGQNvu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 09:51:50 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55667 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726090AbgGQNvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 09:51:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594993909;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=m/G4zAIRHoRCp8WOkYaylIh+3if9/OZzz+wlm1M/WWU=;
        b=cJAfNtWMMTZ39VIAeHRuD2+ZSly+sNuGcZnuqgFKmfEXo78imQxAD7dlIK/liD1TEW3cXH
        lpyc8mtR4mP/SeN5HesbnPZdbTzS+FdUoLgAAqCSud165EV+zpGFPhpZ7T4MKirGooV6b8
        tt4gD7l57UcPezf+9/LLyhBNoxRSuVI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-227-T7X64FNCNKCzU8gf9rmcIw-1; Fri, 17 Jul 2020 09:51:44 -0400
X-MC-Unique: T7X64FNCNKCzU8gf9rmcIw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7396F8015CE;
        Fri, 17 Jul 2020 13:51:42 +0000 (UTC)
Received: from krava (unknown [10.40.192.81])
        by smtp.corp.redhat.com (Postfix) with SMTP id 6FF90724C2;
        Fri, 17 Jul 2020 13:51:39 +0000 (UTC)
Date:   Fri, 17 Jul 2020 15:51:38 +0200
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
Subject: Re: [PATCH 11/18] perf metric: Add referenced metrics to hash data
Message-ID: <20200717135138.GD528602@krava>
References: <20200712132634.138901-1-jolsa@kernel.org>
 <20200712132634.138901-12-jolsa@kernel.org>
 <CAP-5=fW2wknhCEQ8cPtmup6vQgWC45s9a0WJ+NsYt9Uu-Qm3Mw@mail.gmail.com>
 <20200715213609.GV183694@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200715213609.GV183694@krava>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 15, 2020 at 11:36:09PM +0200, Jiri Olsa wrote:
> On Wed, Jul 15, 2020 at 11:25:14AM -0700, Ian Rogers wrote:
> > On Sun, Jul 12, 2020 at 6:27 AM Jiri Olsa <jolsa@kernel.org> wrote:
> 
> SNIP
> 
> > > +int expr__add_ref(struct expr_parse_ctx *ctx, struct metric_ref *ref)
> > > +{
> > > +       struct expr_id_data *data_ptr = NULL, *old_data = NULL;
> > > +       char *old_key = NULL;
> > > +       char *name;
> > > +       int ret;
> > > +
> > > +       data_ptr = zalloc(sizeof(*data_ptr));
> > > +       if (!data_ptr)
> > > +               return -ENOMEM;
> > > +
> > > +       name = strdup(ref->metric_name);
> > > +       if (!name) {
> > > +               free(data_ptr);
> > > +               return -ENOMEM;
> > > +       }
> > > +
> > > +       data_ptr->ref.metric_name = ref->metric_name;
> > > +       data_ptr->ref.metric_expr = ref->metric_expr;
> > 
> > Having one owned string and one unowned makes the memory management
> > here somewhat complicated. Perhaps dupe both?
> 
> right, will check on this

actualy, both of them are pointers to const char strings from struct pmu_event,
so they don't need to be freed

the journey starts at __add_metric function, where we
get the struct pmu_event pointers:

	ref->metric_name = pe->metric_name;
	ref->metric_expr = pe->metric_expr;

then it's passed to struct metric_ref in metricgroup__setup_events:

	metric_refs[i].metric_name = ref->metric_name;
	metric_refs[i].metric_expr = ref->metric_expr;

still 'const char*'.. and ending up as part of the value in
expr__add_ref function:

	data_ptr->ref.metric_name = ref->metric_name;
	data_ptr->ref.metric_expr = ref->metric_expr;

I'll put comments in all those places so it's evident that it's intentional

jirka

