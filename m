Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC4ADC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 16:09:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8533C20674
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 16:09:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y2/XBl1A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728344AbgERQJ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 12:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728127AbgERQJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 12:09:57 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A7FCC061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 09:09:57 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id 190so10664486qki.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 09:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=owk2PlykZ6E5gqwRgJSgHsI/A8UuBzY2vDfcvHrqKh0=;
        b=Y2/XBl1At1PkKqgtXwvS0Z3mdWSTTkGS0a36lskqpwcsQEA6Tf47FKkhVTZ+4NRfrF
         JANQHy4pu7dq9mna3uo/HUclvmJgcvPd1Re3hSG4xEdQ43pRvPajDVvlyesWqjUeljok
         KGWA0c8Tk2h0XPEGOfEkHsSVd91kuGUxPKNGkfqGEC4YT0On5N4TlyAo2j7vlOZ2b8mJ
         bMVnP91oajt0/p2ahQM2PCSAdzYV/Ny+5ugcyKGxo59CZUIRvblmTxhxrunt1y7BuHtf
         gdCPIrjAwb9VuAuo0UjkI3nKI0D9QSILQzpN/kKIU+fJtLZax24n5DvhxhQba3443QJ6
         Os+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=owk2PlykZ6E5gqwRgJSgHsI/A8UuBzY2vDfcvHrqKh0=;
        b=V0lk1/rEdfzGGbF85dSXoHGzyjEqqgtIMHNuUy4l1blifYH4SJTiuDySmJ9eJwJsXM
         ePgGG2N4/jl3mvbaO6X7JiVDNgEP51fZA/KkiFut/AR+i2ristZEZcRpmaFTK19nEAnQ
         IzR6+nb2ekTXUgj1gg9QZrZP/iYMm1RA2zj5FezSK6jw1P7HXdHXZkyWriRgjEVcrpSx
         1cENMoLbevtGOXRU4GCULglCYHHgVQ0QXcYVWxbSUCXYeDW80BcMOT7p+Mt2wNHa5ILY
         O+P8i76/LfPIZknCIKuacTSwdcvjUPAyXG9KfhwTvqJeh8N2MEV1xE4FQuMaOOnm/YXo
         ketQ==
X-Gm-Message-State: AOAM531Yn3SPR/zRQIzDHYnBBm5gVp6y4SXllKV0+cjnZgIYnbjpF80t
        KIyw160TR2N4u8EMQRn4PzY=
X-Google-Smtp-Source: ABdhPJyz3d+MvD971p29dXhoYX12gJ3QiiOhShuL6GPuCjQUP7AOx9vstalAiXcteHbHExdKAJVlvQ==
X-Received: by 2002:a37:643:: with SMTP id 64mr14665013qkg.99.1589818196318;
        Mon, 18 May 2020 09:09:56 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id w22sm9659133qth.87.2020.05.18.09.09.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 09:09:55 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6D0A3410F5; Mon, 18 May 2020 13:09:53 -0300 (-03)
Date:   Mon, 18 May 2020 13:09:53 -0300
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: Re: [RFC] perf trace: Fix compilation error for make NO_LIBBPF=1
 DEBUG=1
Message-ID: <20200518160953.GJ24211@kernel.org>
References: <20200518141027.3765877-1-jolsa@kernel.org>
 <20200518141915.GA24211@kernel.org>
 <20200518143528.GA2809@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200518143528.GA2809@krava>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, May 18, 2020 at 04:35:28PM +0200, Jiri Olsa escreveu:
> On Mon, May 18, 2020 at 11:19:15AM -0300, Arnaldo Carvalho de Melo wrote:
> > Em Mon, May 18, 2020 at 04:10:27PM +0200, Jiri Olsa escreveu:
> > > I haven't tested if this breaks some perf trace functionality,
> > > hence RFC ;-)
> > 
> > Thanks for the patch, looks ok, applying, please let me know if you need
> > to do something else with it.
> 
> just wasn't sure the hook will work with NULL,
> so if you're ok with it, then it's ok ;-)
> 
> thanks,
> jirka

you forgot this, right?


diff --git a/tools/perf/tests/make b/tools/perf/tests/make
index c3c59def9f87..29ce0da7fca6 100644
--- a/tools/perf/tests/make
+++ b/tools/perf/tests/make
@@ -145,6 +145,7 @@ run += make_no_libaudit
 run += make_no_libbionic
 run += make_no_auxtrace
 run += make_no_libbpf
+run += make_no_libbpf_DEBUG
 run += make_with_babeltrace
 run += make_with_clangllvm
 run += make_help
 
> > 
> > - Arnaldo
> >  
> > > The perf compilation fails for NO_LIBBPF=1 DEBUG=1 with:
> > > 
> > >   $ make NO_LIBBPF=1 DEBUG=1
> > >     BUILD:   Doing 'make -j8' parallel build
> > >     CC       builtin-trace.o
> > >     LD       perf-in.o
> > >     LINK     perf
> > >   /usr/bin/ld: perf-in.o: in function `trace__find_bpf_map_by_name':
> > >   /home/jolsa/kernel/linux-perf/tools/perf/builtin-trace.c:4608: undefined reference to `bpf_object__find_map_by_name'
> > >   collect2: error: ld returned 1 exit status
> > >   make[2]: *** [Makefile.perf:631: perf] Error 1
> > >   make[1]: *** [Makefile.perf:225: sub-make] Error 2
> > >   make: *** [Makefile:70: all] Error 2
> > > 
> > > Moving trace__find_bpf_map_by_name calls under HAVE_LIBBPF_SUPPORT
> > > ifdef and add make test for this.
> > > 
> > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > ---
> > >  tools/perf/builtin-trace.c | 54 ++++++++++++++++++++++++--------------
> > >  tools/perf/tests/make      |  1 +
> > >  2 files changed, 35 insertions(+), 20 deletions(-)
> > > 
> > > diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> > > index 56bcf1ab19f8..61bafca1018a 100644
> > > --- a/tools/perf/builtin-trace.c
> > > +++ b/tools/perf/builtin-trace.c
> > > @@ -3174,6 +3174,26 @@ static int trace__set_ev_qualifier_tp_filter(struct trace *trace)
> > >  }
> > >  
> > >  #ifdef HAVE_LIBBPF_SUPPORT
> > > +static struct bpf_map *trace__find_bpf_map_by_name(struct trace *trace, const char *name)
> > > +{
> > > +	if (trace->bpf_obj == NULL)
> > > +		return NULL;
> > > +
> > > +	return bpf_object__find_map_by_name(trace->bpf_obj, name);
> > > +}
> > > +
> > > +static void trace__set_bpf_map_filtered_pids(struct trace *trace)
> > > +{
> > > +	trace->filter_pids.map = trace__find_bpf_map_by_name(trace, "pids_filtered");
> > > +}
> > > +
> > > +static void trace__set_bpf_map_syscalls(struct trace *trace)
> > > +{
> > > +	trace->syscalls.map = trace__find_bpf_map_by_name(trace, "syscalls");
> > > +	trace->syscalls.prog_array.sys_enter = trace__find_bpf_map_by_name(trace, "syscalls_sys_enter");
> > > +	trace->syscalls.prog_array.sys_exit  = trace__find_bpf_map_by_name(trace, "syscalls_sys_exit");
> > > +}
> > > +
> > >  static struct bpf_program *trace__find_bpf_program_by_title(struct trace *trace, const char *name)
> > >  {
> > >  	if (trace->bpf_obj == NULL)
> > > @@ -3512,6 +3532,20 @@ static void trace__delete_augmented_syscalls(struct trace *trace)
> > >  	trace->bpf_obj = NULL;
> > >  }
> > >  #else // HAVE_LIBBPF_SUPPORT
> > > +static struct bpf_map *trace__find_bpf_map_by_name(struct trace *trace __maybe_unused,
> > > +						   const char *name __maybe_unused)
> > > +{
> > > +	return NULL;
> > > +}
> > > +
> > > +static void trace__set_bpf_map_filtered_pids(struct trace *trace __maybe_unused)
> > > +{
> > > +}
> > > +
> > > +static void trace__set_bpf_map_syscalls(struct trace *trace __maybe_unused)
> > > +{
> > > +}
> > > +
> > >  static int trace__set_ev_qualifier_bpf_filter(struct trace *trace __maybe_unused)
> > >  {
> > >  	return 0;
> > > @@ -4600,26 +4634,6 @@ static int trace__parse_cgroups(const struct option *opt, const char *str, int u
> > >  	return 0;
> > >  }
> > >  
> > > -static struct bpf_map *trace__find_bpf_map_by_name(struct trace *trace, const char *name)
> > > -{
> > > -	if (trace->bpf_obj == NULL)
> > > -		return NULL;
> > > -
> > > -	return bpf_object__find_map_by_name(trace->bpf_obj, name);
> > > -}
> > > -
> > > -static void trace__set_bpf_map_filtered_pids(struct trace *trace)
> > > -{
> > > -	trace->filter_pids.map = trace__find_bpf_map_by_name(trace, "pids_filtered");
> > > -}
> > > -
> > > -static void trace__set_bpf_map_syscalls(struct trace *trace)
> > > -{
> > > -	trace->syscalls.map = trace__find_bpf_map_by_name(trace, "syscalls");
> > > -	trace->syscalls.prog_array.sys_enter = trace__find_bpf_map_by_name(trace, "syscalls_sys_enter");
> > > -	trace->syscalls.prog_array.sys_exit  = trace__find_bpf_map_by_name(trace, "syscalls_sys_exit");
> > > -}
> > > -
> > >  static int trace__config(const char *var, const char *value, void *arg)
> > >  {
> > >  	struct trace *trace = arg;
> > > diff --git a/tools/perf/tests/make b/tools/perf/tests/make
> > > index 5d0c3a9c47a1..c3c59def9f87 100644
> > > --- a/tools/perf/tests/make
> > > +++ b/tools/perf/tests/make
> > > @@ -84,6 +84,7 @@ make_no_libaudit    := NO_LIBAUDIT=1
> > >  make_no_libbionic   := NO_LIBBIONIC=1
> > >  make_no_auxtrace    := NO_AUXTRACE=1
> > >  make_no_libbpf	    := NO_LIBBPF=1
> > > +make_no_libbpf_DEBUG := NO_LIBBPF=1 DEBUG=1
> > >  make_no_libcrypto   := NO_LIBCRYPTO=1
> > >  make_with_babeltrace:= LIBBABELTRACE=1
> > >  make_no_sdt	    := NO_SDT=1
> > > -- 
> > > 2.25.4
> > > 
> > 
> > -- 
> > 
> > - Arnaldo
> > 
> 

-- 

- Arnaldo
