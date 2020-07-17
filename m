Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37275C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 19:35:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECF2020768
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 19:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595014502;
	bh=lt93wsvY+lWqN5f0gfzdD/KXEx7blZ4ENI76shs8i5Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=M/mA5pMEhrt4dryAKEe19IptLndygP6rsIPHWE3Menn/9fnuTOwQGO7gZdYM9AGaF
	 LT1tbQWe4xoby1JxJbF5xDDGo11Is6jn100cxBPSXoYu+WADJd1KFDv30yNXPqEq0p
	 Z26d6fOrrSd/FgLkPnoTLz9v4xBlgGoTSCcX6Gmw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728511AbgGQTfA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 15:35:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:46426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727999AbgGQTfA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 15:35:00 -0400
Received: from quaco.ghostprotocols.net (unknown [177.158.142.153])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F21C2064C;
        Fri, 17 Jul 2020 19:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595014499;
        bh=lt93wsvY+lWqN5f0gfzdD/KXEx7blZ4ENI76shs8i5Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dtlMSoVc1bR0GEhpjnuCygyo9SPJl6quJq6k4uxFp6YjHZ0hyuX15ZXRM/Ess5iV9
         IAqpg2rGdGBWXXMpdYpWxupfCEcNAovC/XT8IWWrBG61YY3NPLSgd6P8zTxGFk2YWE
         zR40hW2RwfVubsPf/5uZb5CjcCFzFu0Kpvu03Rj8=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id BE80D40482; Fri, 17 Jul 2020 16:34:55 -0300 (-03)
Date:   Fri, 17 Jul 2020 16:34:55 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Changbin Du <changbin.du@gmail.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 03/17] perf ftrace: add option -t/--tid to filter by
 thread id
Message-ID: <20200717193455.GD77866@kernel.org>
References: <20200711124035.6513-1-changbin.du@gmail.com>
 <20200711124035.6513-4-changbin.du@gmail.com>
 <20200716153630.GD374956@kernel.org>
 <20200717132650.i32oovllal22b35i@mail.google.com>
 <20200717130124.54e85349@oasis.local.home>
 <20200717174053.GE712240@kernel.org>
 <20200717135351.5fb1ce95@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200717135351.5fb1ce95@oasis.local.home>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Jul 17, 2020 at 01:53:51PM -0400, Steven Rostedt escreveu:
> On Fri, 17 Jul 2020 14:40:53 -0300 Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
 
> > Say you use:

> > ^C[root@ssdandy ~]# cyclictest --smp -um -p95
> > # /dev/cpu_dma_latency set to 0us
> > policy: fifo: loadavg: 0.05 0.03 0.06 2/409 29072

> > T: 0 (29065) P:95 I:1000 C:    518 Min:      2 Act:    2 Avg:    2 Max:       6
> > T: 1 (29066) P:95 I:1500 C:    343 Min:      2 Act:    2 Avg:    2 Max:       5
> > T: 2 (29067) P:95 I:2000 C:    256 Min:      2 Act:    2 Avg:    2 Max:       7
> > T: 3 (29068) P:95 I:2500 C:    203 Min:      2 Act:    2 Avg:    2 Max:       5
> > T: 4 (29069) P:95 I:3000 C:    168 Min:      2 Act:    2 Avg:    3 Max:       6
> > T: 5 (29070) P:95 I:3500 C:    143 Min:      2 Act:    2 Avg:    2 Max:       6
> > T: 6 (29071) P:95 I:4000 C:    124 Min:      2 Act:    2 Avg:    2 Max:       7
> > T: 7 (29072) P:95 I:4500 C:    110 Min:      2 Act:    2 Avg:    2 Max:

> > Then we do:

> > # pidof cyclictest
> > 29064
> > #

> > If we use:

> > [root@ssdandy ~]# perf record --pid 29064
> > ^C[ perf record: Woken up 1 times to write data ]
> > [ perf record: Captured and wrote 0.052 MB perf.data (866 samples) ]

> > [root@ssdandy ~]# perf report --task
> > #      pid      tid     ppid  comm
> >          0        0       -1 |swapper
> >      29064    29064       -1 |cyclictest
> >      29064    29065       -1 |cyclictest
> >      29064    29066       -1 |cyclictest
> >      29064    29067       -1 |cyclictest
> >      29064    29068       -1 |cyclictest
> >      29064    29069       -1 |cyclictest
> >      29064    29070       -1 |cyclictest
> >      29064    29071       -1 |cyclictest
> >      29064    29072       -1 |cyclictest
> > [root@ssdandy ~]#

> "ftrace" is inside the kernel. But you could specify all those PIDs in
> the set_ftrace_pid and set_event_pid files, and they will be traced. If
> you want to trace the children of those PIDs, you would need to set the
> options function function-fork and event-fork respectively. And then
> any time a process with a pid in the set_ftrace_pid or set_event_pid
> file forks, its child will also be added to that file and it too will
> be traced. If the fork options are set, then when a task exits, its pid
> will be removed from the file.

>  echo 1 > options/function-fork
>  echo 1 > options/event-fork

cool, so its possible to have the same sort of behaviour one expects
using --pid or --tid and --inherit with perf record/trace/top/etc

Its just some confusion about what perf understands by --pid and --tid
and the jargon used by ftrace, we can make 'perf ftrace' use the knobs
you mentioned and achieve the expected results as with other perf
subcommands, good.
 
> > If we are interested only on the thread running on CPU3 we can do:
> > 
> > [root@ssdandy ~]# perf report --task
> > #      pid      tid     ppid  comm
> >          0        0       -1 |swapper
> >      29064    29064       -1 |cyclictest
> >      29064    29068       -1 |cyclictest
> > [root@ssdandy ~]#

> > The first 29064 is just to have info on who created 29068, i.e.:

> > Its just the synthesized info for 29068 creator:

> > [root@ssdandy ~]# perf report -D | grep -w 29064/29064
> > 0 0x4690 [0x30]: PERF_RECORD_COMM: cyclictest:29064/29064
> > 0 0x46c0 [0x70]: PERF_RECORD_MMAP2 29064/29064: [0x400000(0xa000) @ 0 fd:00 136246288 0]: r-xp /usr/bin/cyclictest
> > 0 0x4730 [0x80]: PERF_RECORD_MMAP2 29064/29064: [0x7f990f505000(0x15000) @ 0 fd:00 201479398 0]: r-xp /usr/lib64/libgcc_s-4.8.5-20150702.so.1
> > 0 0x47b0 [0x70]: PERF_RECORD_MMAP2 29064/29064: [0x7f990f71b000(0x1c3000) @ 0 fd:00 201334455 0]: r-xp /usr/lib64/libc-2.17.so
> > 0 0x4820 [0x78]: PERF_RECORD_MMAP2 29064/29064: [0x7f990fae9000(0xa000) @ 0 fd:00 204604380 0]: r-xp /usr/lib64/libnuma.so.1.0.0
> > 0 0x4898 [0x78]: PERF_RECORD_MMAP2 29064/29064: [0x7f990fcf5000(0x17000) @ 0 fd:00 201335636 0]: r-xp /usr/lib64/libpthread-2.17.so
> > 0 0x4910 [0x78]: PERF_RECORD_MMAP2 29064/29064: [0x7f990ff11000(0x7000) @ 0 fd:00 201335640 0]: r-xp /usr/lib64/librt-2.17.so
> > 0 0x4988 [0x70]: PERF_RECORD_MMAP2 29064/29064: [0x7f9910119000(0x22000) @ 0 fd:00 203595299 0]: r-xp /usr/lib64/ld-2.17.so
> > 0 0x49f8 [0x60]: PERF_RECORD_MMAP2 29064/29064: [0x7fff0b52d000(0x2000) @ 0 00:00 0 0]: r-xp [vdso]
> > 0 0x4a58 [0x68]: PERF_RECORD_MMAP2 29064/29064: [0xffffffffff600000(0x1000) @ 0 00:00 0 0]: r-xp [vsyscall]
> > [root@ssdandy ~]#

> > No PERF_RECORD_SAMPLEs.

> > Those are only for:

> > [root@ssdandy ~]# perf report -D | grep PERF_RECORD_SAMPLE | head -5
> > 147224656598815 0x4ac0 [0x28]: PERF_RECORD_SAMPLE(IP, 0x4001): 29064/29068: 0xffffffffa8e5b568 period: 1 addr: 0
> > 147224656606270 0x4ae8 [0x28]: PERF_RECORD_SAMPLE(IP, 0x4001): 29064/29068: 0xffffffffa8e5b568 period: 1 addr: 0
> > 147224656611284 0x4b10 [0x28]: PERF_RECORD_SAMPLE(IP, 0x4001): 29064/29068: 0xffffffffa8e5b568 period: 5 addr: 0
> > 147224656616225 0x4b38 [0x28]: PERF_RECORD_SAMPLE(IP, 0x4001): 29064/29068: 0xffffffffa8e5b568 period: 35 addr: 0
> > 147224656621152 0x4b60 [0x28]: PERF_RECORD_SAMPLE(IP, 0x4001): 29064/29068: 0xffffffffa8e5b568 period: 252 addr: 0
> > [root@ssdandy ~]#

> > [root@ssdandy ~]# perf report -D | grep PERF_RECORD_SAMPLE | cut -d: -f3 | sort -u
> >  29064/29068
 
> The above can somewhat be done in trace-cmd, but not fully. But that's
> all userspace commands, nothing with the kernel.
 
> > [root@ssdandy ~]#

> > Is there a way in ftrace to ask for a pid and its children? Pre-existing
> > and and new ones the --pid specified will create after we start
> > monitoring?
 
> As described above, yes. :-)

Changbin, you can take from here :-)

And to reiterate, for me the value of 'perf ftrace' is to allow people
used to perf to be able to switch to ftrace quickly, just changing:

   perf record/top/stat/trace/report/script/etc --pid 1234

by:

   perf ftrace --pid 1234

And have the tracefs ftrace knobs set up to have what is expected in
terms of targets to trace as the other perf tools.

And not just --pid and --tid, but --cgroup, --cpu, etc.

i.e., 'perf ftrace' being _a_ front-end aplication to ftrace.

:-)

- Arnaldo
