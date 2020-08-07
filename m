Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 226E3C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 12:16:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDC072224D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 12:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596802597;
	bh=VYEQ6WbWp7BWKAKdBuMp0fHupy9LP5Uskf1aDWDspJU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=K7A8JkB5evvDCRIMfXHBH2MUFSigXiJ9Ky3mVGoT7QhV2uCTW1VnBuliaNNyQ48cS
	 MZGwNrx5t9N40mcNe0kh0403IEfJLpx8bBkszUVjfkHZS6G7UG1Btf3QIUKy23HMFW
	 svw60sAcaiBE3dDzsidIZM1S9Ojgi5NbnKWy2Jzk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728414AbgHGMQf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 08:16:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:51528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727783AbgHGMQc (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 08:16:32 -0400
Received: from quaco.ghostprotocols.net (unknown [186.208.79.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8BE8B221E2;
        Fri,  7 Aug 2020 12:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596802591;
        bh=VYEQ6WbWp7BWKAKdBuMp0fHupy9LP5Uskf1aDWDspJU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J9ojc9Xwc9LhaKgi/lis0C7R9NnWxLg2fxKOzZV+9nNhiEnMOQi+x/Vw4sMH0U2ub
         IgEpYdRWbCv8EDCwKd8040b40Bx2Z9XAZvctueFZkhecCuo615KVgtjBg8G+F1azrq
         tNyLEkUCnQ3yz4dHwNe/xyPpSEv5XE46IoaY+Uj8=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 2F53340481; Fri,  7 Aug 2020 09:16:29 -0300 (-03)
Date:   Fri, 7 Aug 2020 09:16:29 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, jolsa@kernel.org,
        peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH] perf record: Skip side-band event setup if
 HAVE_LIBBPF_SUPPORT is not set
Message-ID: <20200807121629.GC2456573@kernel.org>
References: <20200805022937.29184-1-yao.jin@linux.intel.com>
 <20200806194357.GA539212@krava>
 <20200807120824.GA2456573@kernel.org>
 <20200807120956.GB2456573@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200807120956.GB2456573@kernel.org>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Aug 07, 2020 at 09:09:56AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Fri, Aug 07, 2020 at 09:08:24AM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Thu, Aug 06, 2020 at 09:43:57PM +0200, Jiri Olsa escreveu:
> > > On Wed, Aug 05, 2020 at 10:29:37AM +0800, Jin Yao wrote:
> > > > We received an error report that perf-record caused 'Segmentation fault'
> > > > on a newly system (e.g. on the new installed ubuntu).
> > > > 
> > > >  (gdb) backtrace
> > > >  #0  __read_once_size (size=4, res=<synthetic pointer>, p=0x14) at /root/0-jinyao/acme/tools/include/linux/compiler.h:139
> > > >  #1  atomic_read (v=0x14) at /root/0-jinyao/acme/tools/include/asm/../../arch/x86/include/asm/atomic.h:28
> > > >  #2  refcount_read (r=0x14) at /root/0-jinyao/acme/tools/include/linux/refcount.h:65
> > > >  #3  perf_mmap__read_init (map=map@entry=0x0) at mmap.c:177
> > > >  #4  0x0000561ce5c0de39 in perf_evlist__poll_thread (arg=0x561ce68584d0) at util/sideband_evlist.c:62
> > > >  #5  0x00007fad78491609 in start_thread (arg=<optimized out>) at pthread_create.c:477
> > > >  #6  0x00007fad7823c103 in clone () at ../sysdeps/unix/sysv/linux/x86_64/clone.S:95
> > > 
> > > hum, I recall discussing the same issue,
> > > I thought it was already fixed :-\ in any case:
> > > 
> > > Acked-by: Jiri Olsa <jolsa@redhat.com>
> > 
> > I added this:
> > 
> > Fixes: 23cbb41c939a ("perf record: Move side band evlist setup to separate routine")
> > 
> > To help this fixe go back to a few stable kernels. Technically the
> > problem was introduced much earlier, when the side band thread was
> > added, but then this would require more cherry-picking of patches and
> > since we have a workaround, i.e. build with libbpf, I think this is
> > enough.
> 
> I backtrack on that, as the sideband event is not just for BPF... The
> switch-output-event code uses it as well, so it can't be dependent on
> LIBBPF being built...
> 
> I'll see what I can do

So this is the change I made, the side band thread is may have been
already created by 

[acme@quaco ~]$ perf record -h switch-output-event

 Usage: perf record [<options>] [<command>]
    or: perf record [<options>] -- <command> [<options>]

        --switch-output-event <switch output event>
                          switch output event selector. use 'perf list' to list available events

[acme@quaco ~]$

I'm doing some extra checking now on your report, and the patch below
has skews because it clashed with the clockid patches by Jiri so I had
to resolve its merge.

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 7d97c8e9f7f9..c12b5b072519 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1511,6 +1511,7 @@ static int record__synthesize(struct record *rec, bool tail)
 	return err;
 }
 
+#ifdef HAVE_LIBBPF_SUPPORT
 static int record__process_signal_event(union perf_event *event __maybe_unused, void *data)
 {
 	struct record *rec = data;
@@ -1592,6 +1593,12 @@ static int record__init_clock(struct record *rec)
 	session->header.env.clock.clockid_ns = ref;
 	return 0;
 }
+#else
+static int record__setup_sb_evlist(struct record *rec __maybe_unused)
+{
+	return 0;
+}
+#endif
 
 static int __cmd_record(struct record *rec, int argc, const char **argv)
 {
