Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FECAC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 12:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12411205CB
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 12:10:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I+be/FNt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbgFBMK3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 08:10:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37657 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725921AbgFBMK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 08:10:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591099827;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GgAQtcRmcsPNevHcltNyY72muKhk9ckb6skEMdrZOZc=;
        b=I+be/FNtSmUl7zyNx0iLNtBhmFyLYqmA6yOvcAXklQMffx0gN4TbKF+5LdI7L4VVUkC6Mn
        ycmqaI4hdhZkzq96zPamfaEAripzHdLl3hU1y20fQFPX+6DPU3xghXryxAZ6tAOngtC3Av
        mllVXW+PzG0/lcIu1WAYJAdiIJgQ9fg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-506-U5fyIVrFOxWt9BcQvw6X_w-1; Tue, 02 Jun 2020 08:10:23 -0400
X-MC-Unique: U5fyIVrFOxWt9BcQvw6X_w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7BD77107ACCA;
        Tue,  2 Jun 2020 12:10:21 +0000 (UTC)
Received: from krava (unknown [10.40.195.39])
        by smtp.corp.redhat.com (Postfix) with SMTP id 9688319D71;
        Tue,  2 Jun 2020 12:10:18 +0000 (UTC)
Date:   Tue, 2 Jun 2020 14:10:17 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCHv2] perf stat: Ensure group is defined on top of the same
 cpu mask
Message-ID: <20200602121017.GF1112120@krava>
References: <20200531162206.911168-1-jolsa@kernel.org>
 <CAP-5=fUk97P-ECojBya1CRE4SQoX2erNgFujEJFvSgOk6e6pdQ@mail.gmail.com>
 <20200601082027.GF881900@krava>
 <CAP-5=fWLp8qyVjwVuQCTEoz=SY5FFtEEZyH5=L-5cAEeN4_5uw@mail.gmail.com>
 <CAM9d7cgw+h9xC08hEErnQnqZjfN1bJWu8psGsUVicWoXWSWcLQ@mail.gmail.com>
 <20200602081551.GC1112120@krava>
 <CAM9d7cgZYjCkrFtpcKr=QHrLY6PkOx6CODBiH8fmoFqEcBXKeQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cgZYjCkrFtpcKr=QHrLY6PkOx6CODBiH8fmoFqEcBXKeQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 02, 2020 at 08:50:17PM +0900, Namhyung Kim wrote:
> Hi Jiri,
> 
> On Tue, Jun 2, 2020 at 5:16 PM Jiri Olsa <jolsa@redhat.com> wrote:
> >
> > On Tue, Jun 02, 2020 at 11:47:19AM +0900, Namhyung Kim wrote:
> > > On Tue, Jun 2, 2020 at 1:21 AM Ian Rogers <irogers@google.com> wrote:
> > > >
> > > > On Mon, Jun 1, 2020 at 1:20 AM Jiri Olsa <jolsa@redhat.com> wrote:
> > > > >
> > > > > Jin Yao reported the issue (and posted first versions of this change)
> > > > > with groups being defined over events with different cpu mask.
> > > > >
> > > > > This causes assert aborts in get_group_fd, like:
> > > > >
> > > > >   # perf stat -M "C2_Pkg_Residency" -a -- sleep 1
> > > > >   perf: util/evsel.c:1464: get_group_fd: Assertion `!(fd == -1)' failed.
> > > > >   Aborted
> > > > >
> > > > > All the events in the group have to be defined over the same
> > > > > cpus so the group_fd can be found for every leader/member pair.
> > > > >
> > > > > Adding check to ensure this condition is met and removing the
> > > > > group (with warning) if we detect mixed cpus, like:
> > > > >
> > > > >   $ sudo perf stat -e '{power/energy-cores/,cycles},{instructions,power/energy-cores/}'
> > > > >   WARNING: event cpu maps do not match, disabling group:
> > > > >     anon group { power/energy-cores/, cycles }
> > > > >     anon group { instructions, power/energy-cores/ }
> > > > >
> > > > > Ian asked also for cpu maps details, it's displayed in verbose mode:
> > > > >
> > > > >   $ sudo perf stat -e '{cycles,power/energy-cores/}' -v
> > > > >   WARNING: group events cpu maps do not match, disabling group:
> > > > >     anon group { power/energy-cores/, cycles }
> > > > >        power/energy-cores/: 0
> > > > >        cycles: 0-7
> > > > >     anon group { instructions, power/energy-cores/ }
> > > > >        instructions: 0-7
> > > > >        power/energy-cores/: 0
> > > >
> > > > This is great! A nit, would 'grouped events cpus do not match' read
> > > > better? I think the cpu map is more of an internal naming convention.
> > > Allowed cpus?
> >
> > hum, what you mean?
> 
> I mean that we can use 'allowed cpus' rather then 'cpu map' in the message.
> Something like this?
> 
>   allowed cpus for events in a group do not match, disabling group:

hm, I like more the one Ian suggested.. anyway, leaving this to Arnaldo,
he can change that before committing ;-)

thanks,
jirka

