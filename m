Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1C03C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 12:28:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DF7C221E2
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 12:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596803325;
	bh=4lT86NQR8kJjxCA4MYBegfGyLTjd4esMQ95f2H74qH4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rN0fRfO+WBS8/EIpkauJ7uSb5tyIxjJoWw+WCNjYkFcIGsIAvW8RHg5kxmtcA0RPY
	 GlbOsCxDd3I4uwjkQ9QVGhHSYfFecQXH/DHpUcDxXvREIKnLd3E20UqlllF1g4QyFp
	 z5pSu3+w3zbohhBlgMGM/ZOQE2dTdyszaRRwxz3Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728491AbgHGM2o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 08:28:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:59932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728423AbgHGM2o (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 08:28:44 -0400
Received: from quaco.ghostprotocols.net (unknown [186.208.79.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4D14221E2;
        Fri,  7 Aug 2020 12:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596803323;
        bh=4lT86NQR8kJjxCA4MYBegfGyLTjd4esMQ95f2H74qH4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BcUdkDsdBXHxnb+2+SlGUoUla8ftBFHZaoz1eAvO749IikCr+DzGiyt9qlKpO6aM4
         pkCe45yEE+EHi23ChcnO6JbMikpBhjus30BoUV03txDWLi8j0lzilkwg37g6pvA0CO
         KXYRzQqgTf623gf3uRS8CDDtXVh005At6eHqG+Kw=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B801D40481; Fri,  7 Aug 2020 09:28:40 -0300 (-03)
Date:   Fri, 7 Aug 2020 09:28:40 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, jolsa@kernel.org,
        peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH] perf record: Skip side-band event setup if
 HAVE_LIBBPF_SUPPORT is not set
Message-ID: <20200807122840.GE2456573@kernel.org>
References: <20200805022937.29184-1-yao.jin@linux.intel.com>
 <20200806194357.GA539212@krava>
 <20200807120824.GA2456573@kernel.org>
 <20200807120956.GB2456573@kernel.org>
 <20200807121629.GC2456573@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200807121629.GC2456573@kernel.org>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Aug 07, 2020 at 09:16:29AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Fri, Aug 07, 2020 at 09:09:56AM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Fri, Aug 07, 2020 at 09:08:24AM -0300, Arnaldo Carvalho de Melo escreveu:
> > > Em Thu, Aug 06, 2020 at 09:43:57PM +0200, Jiri Olsa escreveu:
> > > > On Wed, Aug 05, 2020 at 10:29:37AM +0800, Jin Yao wrote:
> > > > > We received an error report that perf-record caused 'Segmentation fault'
> > > > > on a newly system (e.g. on the new installed ubuntu).
> > > > > 
> > > > >  (gdb) backtrace
> > > > >  #0  __read_once_size (size=4, res=<synthetic pointer>, p=0x14) at /root/0-jinyao/acme/tools/include/linux/compiler.h:139
> > > > >  #1  atomic_read (v=0x14) at /root/0-jinyao/acme/tools/include/asm/../../arch/x86/include/asm/atomic.h:28
> > > > >  #2  refcount_read (r=0x14) at /root/0-jinyao/acme/tools/include/linux/refcount.h:65
> > > > >  #3  perf_mmap__read_init (map=map@entry=0x0) at mmap.c:177
> > > > >  #4  0x0000561ce5c0de39 in perf_evlist__poll_thread (arg=0x561ce68584d0) at util/sideband_evlist.c:62
> > > > >  #5  0x00007fad78491609 in start_thread (arg=<optimized out>) at pthread_create.c:477
> > > > >  #6  0x00007fad7823c103 in clone () at ../sysdeps/unix/sysv/linux/x86_64/clone.S:95
> > > > 
> > > > hum, I recall discussing the same issue,
> > > > I thought it was already fixed :-\ in any case:
> > > > 
> > > > Acked-by: Jiri Olsa <jolsa@redhat.com>
> > > 
> > > I added this:
> > > 
> > > Fixes: 23cbb41c939a ("perf record: Move side band evlist setup to separate routine")
> > > 
> > > To help this fixe go back to a few stable kernels. Technically the
> > > problem was introduced much earlier, when the side band thread was
> > > added, but then this would require more cherry-picking of patches and
> > > since we have a workaround, i.e. build with libbpf, I think this is
> > > enough.
> > 
> > I backtrack on that, as the sideband event is not just for BPF... The
> > switch-output-event code uses it as well, so it can't be dependent on
> > LIBBPF being built...
> > 
> > I'll see what I can do
> 
> So this is the change I made, the side band thread is may have been
> already created by 
> 
> [acme@quaco ~]$ perf record -h switch-output-event
> 
>  Usage: perf record [<options>] [<command>]
>     or: perf record [<options>] -- <command> [<options>]
> 
>         --switch-output-event <switch output event>
>                           switch output event selector. use 'perf list' to list available events
> 
> [acme@quaco ~]$
> 
> I'm doing some extra checking now on your report, and the patch below
> has skews because it clashed with the clockid patches by Jiri so I had
> to resolve its merge.
 
Sorry, I resent your patch, doh, here is the end result, with my change,
its ok to call perf_evlist__start_sb_thread() with a NULL evlist, it'll
just return 0.

- Arnald


commit b13536a7e93680625094beb18cdce4ae47a3dbfb
Author: Jin Yao <yao.jin@linux.intel.com>
Date:   Wed Aug 5 10:29:37 2020 +0800

    perf record: Skip side-band event setup if HAVE_LIBBPF_SUPPORT is not set
    
    We received an error report that perf-record caused 'Segmentation fault'
    on a newly system (e.g. on the new installed ubuntu).
    
      (gdb) backtrace
      #0  __read_once_size (size=4, res=<synthetic pointer>, p=0x14) at /root/0-jinyao/acme/tools/include/linux/compiler.h:139
      #1  atomic_read (v=0x14) at /root/0-jinyao/acme/tools/include/asm/../../arch/x86/include/asm/atomic.h:28
      #2  refcount_read (r=0x14) at /root/0-jinyao/acme/tools/include/linux/refcount.h:65
      #3  perf_mmap__read_init (map=map@entry=0x0) at mmap.c:177
      #4  0x0000561ce5c0de39 in perf_evlist__poll_thread (arg=0x561ce68584d0) at util/sideband_evlist.c:62
      #5  0x00007fad78491609 in start_thread (arg=<optimized out>) at pthread_create.c:477
      #6  0x00007fad7823c103 in clone () at ../sysdeps/unix/sysv/linux/x86_64/clone.S:95
    
    The root cause is, evlist__add_bpf_sb_event() just returns 0 if
    HAVE_LIBBPF_SUPPORT is not defined (inline function path). So it will
    not create a valid evsel for side-band event.
    
    But perf-record still creates BPF side band thread to process the
    side-band event, then the error happpens.
    
    We can reproduce this issue by removing the libelf-dev. e.g.
    1. apt-get remove libelf-dev
    2. perf record -a -- sleep 1
    
      root@test:~# ./perf record -a -- sleep 1
      perf: Segmentation fault
      Obtained 6 stack frames.
      ./perf(+0x28eee8) [0x5562d6ef6ee8]
      /lib/x86_64-linux-gnu/libc.so.6(+0x46210) [0x7fbfdc65f210]
      ./perf(+0x342e74) [0x5562d6faae74]
      ./perf(+0x257e39) [0x5562d6ebfe39]
      /lib/x86_64-linux-gnu/libpthread.so.0(+0x9609) [0x7fbfdc990609]
      /lib/x86_64-linux-gnu/libc.so.6(clone+0x43) [0x7fbfdc73b103]
      Segmentation fault (core dumped)
    
    To fix this issue,
    
    1. We either install the missing libraries to let HAVE_LIBBPF_SUPPORT
       be defined.
       e.g. apt-get install libelf-dev and install other related libraries.
    
    2. Use this patch to skip the side-band event setup if HAVE_LIBBPF_SUPPORT
       is not set.
    
    Committer notes:
    
    The side band thread is not used just with BPF, it is also used with
    --switch-output-event, so narrow the ifdef to the BPF specific part.
    
    Fixes: 23cbb41c939a ("perf record: Move side band evlist setup to separate routine")
    Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
    Acked-by: Jiri Olsa <jolsa@kernel.org>
    Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
    Cc: Andi Kleen <ak@linux.intel.com>
    Cc: Jin Yao <yao.jin@intel.com>
    Cc: Kan Liang <kan.liang@linux.intel.com>
    Cc: Peter Zijlstra <peterz@infradead.org>
    Link: http://lore.kernel.org/lkml/20200805022937.29184-1-yao.jin@linux.intel.com
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 7d97c8e9f7f9..f91352f847c0 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1531,7 +1531,7 @@ static int record__setup_sb_evlist(struct record *rec)
 		evlist__set_cb(rec->sb_evlist, record__process_signal_event, rec);
 		rec->thread_id = pthread_self();
 	}
-
+#ifdef HAVE_LIBBPF_SUPPORT
 	if (!opts->no_bpf_event) {
 		if (rec->sb_evlist == NULL) {
 			rec->sb_evlist = evlist__new();
@@ -1547,7 +1547,7 @@ static int record__setup_sb_evlist(struct record *rec)
 			return -1;
 		}
 	}
-
+#endif
 	if (perf_evlist__start_sb_thread(rec->sb_evlist, &rec->opts.target)) {
 		pr_debug("Couldn't start the BPF side band thread:\nBPF programs starting from now on won't be annotatable\n");
 		opts->no_bpf_event = true;
