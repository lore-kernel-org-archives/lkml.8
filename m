Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DC0FC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 12:08:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD85E221E2
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 12:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596802126;
	bh=eEhcuNeLHJDggqEK5tXlqaLcjee0OOEAJOloCYdDs7c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wQdQ+PYZxXmapVSd83jUV+So8QoabS2r88Rurzt5VWDFSYxq5KpAYnQ3w9tOCY4S+
	 Rh8uegL7b8cj0qbP94hB5F98bBuI1RMn7g9Sbs4zbzfMMdAfA4f74IuDAmn++gqmN8
	 v8HWjWd5LW6An5MDOCCK6SB8gqKy1A2x5kAMvfQA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728432AbgHGMIp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 08:08:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:46944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728423AbgHGMI2 (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 08:08:28 -0400
Received: from quaco.ghostprotocols.net (unknown [186.208.79.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E89420866;
        Fri,  7 Aug 2020 12:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596802107;
        bh=eEhcuNeLHJDggqEK5tXlqaLcjee0OOEAJOloCYdDs7c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tTnTTfWhEaWo4lDoSUlVedy5P9BRILkAbwp8aOhIPfRh4DI53leEYfeJYyrJM/Dcn
         dSOWan9zwzgKY7u/33/i85/AjyBQQnHVMQu05usTvNm0Jlxb42BMcT4TEE05XISuOP
         IBEupZXtSN2ZU+Vr9S3K1Bfa80j345KHQFyLxHSI=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 90A8140481; Fri,  7 Aug 2020 09:08:24 -0300 (-03)
Date:   Fri, 7 Aug 2020 09:08:24 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Jin Yao <yao.jin@linux.intel.com>, jolsa@kernel.org,
        peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH] perf record: Skip side-band event setup if
 HAVE_LIBBPF_SUPPORT is not set
Message-ID: <20200807120824.GA2456573@kernel.org>
References: <20200805022937.29184-1-yao.jin@linux.intel.com>
 <20200806194357.GA539212@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200806194357.GA539212@krava>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Aug 06, 2020 at 09:43:57PM +0200, Jiri Olsa escreveu:
> On Wed, Aug 05, 2020 at 10:29:37AM +0800, Jin Yao wrote:
> > We received an error report that perf-record caused 'Segmentation fault'
> > on a newly system (e.g. on the new installed ubuntu).
> > 
> >  (gdb) backtrace
> >  #0  __read_once_size (size=4, res=<synthetic pointer>, p=0x14) at /root/0-jinyao/acme/tools/include/linux/compiler.h:139
> >  #1  atomic_read (v=0x14) at /root/0-jinyao/acme/tools/include/asm/../../arch/x86/include/asm/atomic.h:28
> >  #2  refcount_read (r=0x14) at /root/0-jinyao/acme/tools/include/linux/refcount.h:65
> >  #3  perf_mmap__read_init (map=map@entry=0x0) at mmap.c:177
> >  #4  0x0000561ce5c0de39 in perf_evlist__poll_thread (arg=0x561ce68584d0) at util/sideband_evlist.c:62
> >  #5  0x00007fad78491609 in start_thread (arg=<optimized out>) at pthread_create.c:477
> >  #6  0x00007fad7823c103 in clone () at ../sysdeps/unix/sysv/linux/x86_64/clone.S:95
> 
> hum, I recall discussing the same issue,
> I thought it was already fixed :-\ in any case:
> 
> Acked-by: Jiri Olsa <jolsa@redhat.com>

I added this:

Fixes: 23cbb41c939a ("perf record: Move side band evlist setup to separate routine")

To help this fixe go back to a few stable kernels. Technically the
problem was introduced much earlier, when the side band thread was
added, but then this would require more cherry-picking of patches and
since we have a workaround, i.e. build with libbpf, I think this is
enough.

Applied,

- Arnaldo
 
> thanks,
> jirka
> 
> > 
> > The root cause is, evlist__add_bpf_sb_event() just returns 0 if
> > HAVE_LIBBPF_SUPPORT is not defined (inline function path). So it will
> > not create a valid evsel for side-band event.
> > 
> > But perf-record still creates BPF side band thread to process the
> > side-band event, then the error happpens.
> > 
> > We can reproduce this issue by removing the libelf-dev. e.g.
> > 1. apt-get remove libelf-dev
> > 2. perf record -a -- sleep 1
> > 
> > root@test:~# ./perf record -a -- sleep 1
> > perf: Segmentation fault
> > Obtained 6 stack frames.
> > ./perf(+0x28eee8) [0x5562d6ef6ee8]
> > /lib/x86_64-linux-gnu/libc.so.6(+0x46210) [0x7fbfdc65f210]
> > ./perf(+0x342e74) [0x5562d6faae74]
> > ./perf(+0x257e39) [0x5562d6ebfe39]
> > /lib/x86_64-linux-gnu/libpthread.so.0(+0x9609) [0x7fbfdc990609]
> > /lib/x86_64-linux-gnu/libc.so.6(clone+0x43) [0x7fbfdc73b103]
> > Segmentation fault (core dumped)
> > 
> > To fix this issue,
> > 
> > 1. We either install the missing libraries to let HAVE_LIBBPF_SUPPORT
> >    be defined.
> >    e.g. apt-get install libelf-dev and install other related libraries.
> > 
> > 2. Use this patch to skip the side-band event setup if HAVE_LIBBPF_SUPPORT
> >    is not set.
> > 
> > Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> > ---
> >  tools/perf/builtin-record.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> > index b6bdccd875bc..ae97f98e2753 100644
> > --- a/tools/perf/builtin-record.c
> > +++ b/tools/perf/builtin-record.c
> > @@ -1506,6 +1506,7 @@ static int record__synthesize(struct record *rec, bool tail)
> >  	return err;
> >  }
> >  
> > +#ifdef HAVE_LIBBPF_SUPPORT
> >  static int record__process_signal_event(union perf_event *event __maybe_unused, void *data)
> >  {
> >  	struct record *rec = data;
> > @@ -1550,6 +1551,12 @@ static int record__setup_sb_evlist(struct record *rec)
> >  
> >  	return 0;
> >  }
> > +#else
> > +static int record__setup_sb_evlist(struct record *rec __maybe_unused)
> > +{
> > +	return 0;
> > +}
> > +#endif
> >  
> >  static int __cmd_record(struct record *rec, int argc, const char **argv)
> >  {
> > -- 
> > 2.17.1
> > 
> 

-- 

- Arnaldo
