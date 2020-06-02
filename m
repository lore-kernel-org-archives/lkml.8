Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A667C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 15:03:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7E6020757
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 15:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591110238;
	bh=flcx16Cn2mjUytR6i6DMY/HguEKna2+UVmRmQRv7Kg8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fGozDhH+lyzgj8zMHCRogs177PBKsoXzJxkjmK9jOUWDe/2zUFOmdOfbZ4RBmqovz
	 FAezzLI+HXrEqqGNyEmaUyi5bgqLzM4pJ5UwWdi8B50AivDHLgaV/Bo/2MIBkwJ+wm
	 hAjUC4kRRiWiQyHbs1FB9K9XT0q7FuVZh0sJeD4k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728174AbgFBPD6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 11:03:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:59676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726217AbgFBPD5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 11:03:57 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1744E2074B;
        Tue,  2 Jun 2020 15:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591110236;
        bh=flcx16Cn2mjUytR6i6DMY/HguEKna2+UVmRmQRv7Kg8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wO4He56VHVJliH4yKcpbrAR49UGiVE093heAtTWWry4iWWuPzQEyH0Y5+HVDY/7u/
         88osmtEaLC1kgWofWXuyIjWbNKI071TnPtQqm+ZXINc1f6nXFCpzlsszmC37HotxGI
         Q5wEFTnSsuw8Y1nUr3o/JGEGOlzf0+eOqEPeJj3E=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C7E2140AFD; Tue,  2 Jun 2020 12:03:52 -0300 (-03)
Date:   Tue, 2 Jun 2020 12:03:52 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCHv3] perf stat: Ensure group is defined on top of the same
 cpu mask
Message-ID: <20200602150352.GS31795@kernel.org>
References: <20200531162206.911168-1-jolsa@kernel.org>
 <CAP-5=fUk97P-ECojBya1CRE4SQoX2erNgFujEJFvSgOk6e6pdQ@mail.gmail.com>
 <20200601082027.GF881900@krava>
 <CAP-5=fWLp8qyVjwVuQCTEoz=SY5FFtEEZyH5=L-5cAEeN4_5uw@mail.gmail.com>
 <20200602101736.GE1112120@krava>
 <20200602134256.GO31795@kernel.org>
 <20200602140508.GA1169993@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200602140508.GA1169993@krava>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jun 02, 2020 at 04:05:08PM +0200, Jiri Olsa escreveu:
> On Tue, Jun 02, 2020 at 10:42:56AM -0300, Arnaldo Carvalho de Melo wrote:
> > Em Tue, Jun 02, 2020 at 12:17:36PM +0200, Jiri Olsa escreveu:
> > > Jin Yao reported the issue (and posted first versions of this change)
> > > with groups being defined over events with different cpu mask.
> >
> > > This causes assert aborts in get_group_fd, like:
> >
> > >   # perf stat -M "C2_Pkg_Residency" -a -- sleep 1
> > >   perf: util/evsel.c:1464: get_group_fd: Assertion `!(fd == -1)' failed.
> > >   Aborted
> >
> > > All the events in the group have to be defined over the same
> > > cpus so the group_fd can be found for every leader/member pair.
> >
> > > Adding check to ensure this condition is met and removing the
> > > group (with warning) if we detect mixed cpus, like:
> >
> > >   $ sudo perf stat -e '{power/energy-cores/,cycles},{instructions,power/energy-cores/}'
> > >   WARNING: event cpu maps do not match, disabling group:
> > >     anon group { power/energy-cores/, cycles }
> > >     anon group { instructions, power/energy-cores/ }
> >
> > So it doesn't disable the 'group', it disables the 'grouping' of those
> > events, right? I.e. reading the WARNING, I thought that it would count
> > nothing, since it lists both groups as being disabled, but when I tested
> > I noticed that:
> >
> >   [root@seventh ~]# perf stat -e '{power/energy-cores/,cycles},{instructions,power/energy-cores/}'
> >   WARNING: grouped events cpus do not match, disabling group:
> >     anon group { power/energy-cores/, cycles }
> >     anon group { instructions, power/energy-cores/ }
> >   ^C
> >    Performance counter stats for 'system wide':
> >
> >                12.62 Joules power/energy-cores/
> >          106,920,637        cycles
> >           80,228,899        instructions              #    0.75  insn per cycle
> >                12.62 Joules power/energy-cores/
> >
> >         14.514476987 seconds time elapsed
> >
> >
> >   [root@seventh ~]#
> >
> >   I.e. it counted the events, ungrouped, or am I missing something?
>
> right, it disables 'grouping', events are scheduled/counted individualy

Ok, I applied this already, we can fix this in the next cycle.

> this way we will not hit the issue when looking for group_fd FD
> and there's not any, because of different cpu maps

> > If I do:

> >   [root@seventh ~]# perf stat -e '{power/energy-cores/,power/energy-ram/},{instructions,cycles}' -a sleep 2

> >    Performance counter stats for 'system wide':

> >                 1.73 Joules power/energy-cores/
> >                 0.92 Joules power/energy-ram/
> >           12,191,658        instructions              #    0.67  insn per cycles/
> >           18,275,233        cycles

> >          2.001272492 seconds time elapsed

> >   [root@seventh ~]#
> >
> > It works, grouped. One observation, shouldn't we somehow show in the
> > output that the first two were indeed grouped, ditto for the second two?

> yea, we don't display groups in output.. also there's no number
> for the group, it's still separate events numbers in output
> grouping is only used when creating events

perhaps if we just add a blank line to separate groups? I.e. the above
would be:

[root@seventh ~]# perf stat -e '{power/energy-cores/,power/energy-ram/},{instructions,cycles}' -a sleep 2

 Performance counter stats for 'system wide':

              1.73 Joules power/energy-cores/
              0.92 Joules power/energy-ram/

        12,191,658        instructions              #    0.67  insn per cycle
        18,275,233        cycles

       2.001272492 seconds time elapsed

[root@seventh ~]#

Humm, in the presence of at least one group, any ungrouped events would
have to be also separated, i.e.:

[root@seventh ~]# perf stat -e '{power/energy-cores/,power/energy-ram/},instructions,cycles' -a sleep 2

 Performance counter stats for 'system wide':

              1.73 Joules power/energy-cores/
              0.92 Joules power/energy-ram/

        12,191,658        instructions              #    0.67  insn per cycle

        18,275,233        cycles

       2.001272492 seconds time elapsed

[root@seventh ~]#

wdyt?

> > Also, this needs improvement:

> >   [root@seventh ~]# perf stat -e '{power/energy-cores/,power/energy-ram/},{instructions,cycles}' sleep 2
> >   Error:
> >   The sys_perf_event_open() syscall returned with 22 (Invalid argument) for event (power/energy-cores/).
> >   /bin/dmesg | grep -i perf may provide additional information.

> yes, power events don't work with events without cpu being defined,
> which is what we do for 'workload' session.. we should either check
> for that and display some sensible error for power events

> or perhaps check if we could monitor like perf record does with creating
> events for task and every cpu in the system

- Arnaldo
