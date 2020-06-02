Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA72DC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 13:25:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC33E20757
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 13:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591104340;
	bh=/ot6KkkhG77B8zC3BQNhueVZZBjdlYBGN3Vpm55MFHc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Lfgt8Hr2R/rm1uIHqTzQmviT1XUms0JpApFaZ9OwJhm2RwuQAP3PZ4xcrRE2hhhva
	 5s799/ky0YTqMF1iTVMlkK9Vl4PBil13g5vMbTMpB9Lu3F0zPqE/D6AUrHmV6iYB8o
	 zw4CCqcRRqWAbDRYxxeKW7fLCjuL6BdkLlGYLkgQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbgFBNZj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 09:25:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:38522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725940AbgFBNZj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 09:25:39 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03AE3206E2;
        Tue,  2 Jun 2020 13:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591104338;
        bh=/ot6KkkhG77B8zC3BQNhueVZZBjdlYBGN3Vpm55MFHc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uOa9z3Dn6m8SHnpVqyXvSRtsAEDxm+ENn+iyiWk1jKlscnc7GvxSu7Fic34biu/7q
         277LuZ8vh6TyPWLDE+tWq+tl0tjuei/+5hFa2JUyS/pkmrcuysjTpWIcnUh+VW+pcg
         B6/k60GsmefavO8MyAceHwZdZ8XTKpu1CM/NSkO8=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 5153240AFD; Tue,  2 Jun 2020 10:25:35 -0300 (-03)
Date:   Tue, 2 Jun 2020 10:25:35 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
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
Message-ID: <20200602132535.GN31795@kernel.org>
References: <20200531162206.911168-1-jolsa@kernel.org>
 <CAP-5=fUk97P-ECojBya1CRE4SQoX2erNgFujEJFvSgOk6e6pdQ@mail.gmail.com>
 <20200601082027.GF881900@krava>
 <CAP-5=fWLp8qyVjwVuQCTEoz=SY5FFtEEZyH5=L-5cAEeN4_5uw@mail.gmail.com>
 <CAM9d7cgw+h9xC08hEErnQnqZjfN1bJWu8psGsUVicWoXWSWcLQ@mail.gmail.com>
 <20200602081551.GC1112120@krava>
 <CAM9d7cgZYjCkrFtpcKr=QHrLY6PkOx6CODBiH8fmoFqEcBXKeQ@mail.gmail.com>
 <20200602121017.GF1112120@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200602121017.GF1112120@krava>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jun 02, 2020 at 02:10:17PM +0200, Jiri Olsa escreveu:
> On Tue, Jun 02, 2020 at 08:50:17PM +0900, Namhyung Kim wrote:
> > Hi Jiri,
> > 
> > On Tue, Jun 2, 2020 at 5:16 PM Jiri Olsa <jolsa@redhat.com> wrote:
> > >
> > > On Tue, Jun 02, 2020 at 11:47:19AM +0900, Namhyung Kim wrote:
> > > > On Tue, Jun 2, 2020 at 1:21 AM Ian Rogers <irogers@google.com> wrote:
> > > > >
> > > > > On Mon, Jun 1, 2020 at 1:20 AM Jiri Olsa <jolsa@redhat.com> wrote:
> > > > > >
> > > > > > Jin Yao reported the issue (and posted first versions of this change)
> > > > > > with groups being defined over events with different cpu mask.
> > > > > >
> > > > > > This causes assert aborts in get_group_fd, like:
> > > > > >
> > > > > >   # perf stat -M "C2_Pkg_Residency" -a -- sleep 1
> > > > > >   perf: util/evsel.c:1464: get_group_fd: Assertion `!(fd == -1)' failed.
> > > > > >   Aborted
> > > > > >
> > > > > > All the events in the group have to be defined over the same
> > > > > > cpus so the group_fd can be found for every leader/member pair.
> > > > > >
> > > > > > Adding check to ensure this condition is met and removing the
> > > > > > group (with warning) if we detect mixed cpus, like:
> > > > > >
> > > > > >   $ sudo perf stat -e '{power/energy-cores/,cycles},{instructions,power/energy-cores/}'
> > > > > >   WARNING: event cpu maps do not match, disabling group:
> > > > > >     anon group { power/energy-cores/, cycles }
> > > > > >     anon group { instructions, power/energy-cores/ }
> > > > > >
> > > > > > Ian asked also for cpu maps details, it's displayed in verbose mode:
> > > > > >
> > > > > >   $ sudo perf stat -e '{cycles,power/energy-cores/}' -v
> > > > > >   WARNING: group events cpu maps do not match, disabling group:
> > > > > >     anon group { power/energy-cores/, cycles }
> > > > > >        power/energy-cores/: 0
> > > > > >        cycles: 0-7
> > > > > >     anon group { instructions, power/energy-cores/ }
> > > > > >        instructions: 0-7
> > > > > >        power/energy-cores/: 0
> > > > >
> > > > > This is great! A nit, would 'grouped events cpus do not match' read
> > > > > better? I think the cpu map is more of an internal naming convention.
> > > > Allowed cpus?
> > >
> > > hum, what you mean?
> > 
> > I mean that we can use 'allowed cpus' rather then 'cpu map' in the message.
> > Something like this?
> > 
> >   allowed cpus for events in a group do not match, disabling group:
> 
> hm, I like more the one Ian suggested.. anyway, leaving this to Arnaldo,
> he can change that before committing ;-)

I think its ok as-is, Ian, can I have your acked-by?

- Arnaldo
