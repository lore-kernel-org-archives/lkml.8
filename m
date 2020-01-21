Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 338BCC2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 09:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0776A2253D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 09:43:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="COv6U9Q8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729225AbgAUJm7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 04:42:59 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:53576 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725789AbgAUJm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 04:42:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579599777;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=K987eRXStBj7o6ahrrhqOlaQjkmh1rp+yWaYe+czY78=;
        b=COv6U9Q8ph5GqeHEfO0dK7E1wpO3bVD02qLuXqFFmdehh18YVMlqVQGQj8y5gS1OUd1a+y
        BmU42SKmOVC7aZDr4EA0Fv+BuhfAGtIIyf+2dyVmoGDYjEtz/5o9G9DvOA1UjUkyntrhO5
        vakXazo9mc9G1nIVXGGq/D4I3mv+5YA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-149-mJf7OJNLMKWa2WvGcmEVzQ-1; Tue, 21 Jan 2020 04:42:52 -0500
X-MC-Unique: mJf7OJNLMKWa2WvGcmEVzQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E41C28010C5;
        Tue, 21 Jan 2020 09:42:50 +0000 (UTC)
Received: from krava (unknown [10.43.17.48])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DAC935C1BB;
        Tue, 21 Jan 2020 09:42:48 +0000 (UTC)
Date:   Tue, 21 Jan 2020 10:42:46 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>
Subject: Re: [PATCH 4/9] perf tools: Maintain cgroup hierarchy
Message-ID: <20200121094246.GA707582@krava>
References: <20200107133501.327117-1-namhyung@kernel.org>
 <20200107133501.327117-5-namhyung@kernel.org>
 <20200108215235.GA12995@krava>
 <CAM9d7cifgLKbu5KM+QF6ZK9DGbN=8g1oj+vzU3HcTfrUQHP5jg@mail.gmail.com>
 <CAM9d7chWNyFx6vBNZZea7exiwKhU+cwTY-Yaf2_cSXoJ1jSgcQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7chWNyFx6vBNZZea7exiwKhU+cwTY-Yaf2_cSXoJ1jSgcQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 20, 2020 at 10:57:47PM +0900, Namhyung Kim wrote:
> Hi Jiri,
> 
> On Thu, Jan 9, 2020 at 9:51 AM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > Hi Jiri,
> >
> > On Thu, Jan 9, 2020 at 6:52 AM Jiri Olsa <jolsa@redhat.com> wrote:
> > >
> > > On Tue, Jan 07, 2020 at 10:34:56PM +0900, Namhyung Kim wrote:
> > > > Each cgroup is kept in the global cgroup_tree sorted by the cgroup id.
> > > > Hist entries have cgroup id can compare it directly and later it can
> > > > be used to find a group name using this tree.
> > > >
> > > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > > > ---
> > > >  tools/perf/util/cgroup.c  | 72 +++++++++++++++++++++++++++++++++++++++
> > > >  tools/perf/util/cgroup.h  | 15 +++++---
> > > >  tools/perf/util/machine.c |  7 ++++
> > > >  tools/perf/util/session.c |  4 +++
> > > >  4 files changed, 94 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/tools/perf/util/cgroup.c b/tools/perf/util/cgroup.c
> > > > index 4881d4af3381..4e8ef1db0c94 100644
> > > > --- a/tools/perf/util/cgroup.c
> > > > +++ b/tools/perf/util/cgroup.c
> > > > @@ -13,6 +13,8 @@
> > > >
> > > >  int nr_cgroups;
> > > >
> > > > +static struct rb_root cgroup_tree = RB_ROOT;
> > >
> > > I think we shoud carry that in 'struct perf_env'
> >
> > OK, will move.
> 
> So I tried this but then realized that it's hard to get the perf_env later
> when it needs to convert a cgroup id to name (ie. in sort_entry.se_snprintf).
> I also checked maybe I can resolve it when a hist entry is added,
> but it doesn't have the pointer there too.

looks like there might be a path for standard report where hists
are part of evsel object:

  'struct hist_entry' via ->hists to  'struct hists'
  hists_to_evsel(hists) to 'struct evsel'
  'struct evsel' via ->evlist to 'struct evlist'
  and there you have evlist->env ;-)

however I was wondering if we could add 'machine' pointer
to the hist object, that would make that simpler ;-)

not sure about the way.. would be nice if that'd work for
both evsel hists and standalone ones like in c2c

but maybe just some init helper that sets the pointer early on
might do the job

jirka

