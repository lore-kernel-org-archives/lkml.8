Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67884C33C9E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 17:35:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F1712075B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 17:35:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HG+MAYPT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728852AbgANRfl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 12:35:41 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:46176 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbgANRfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 12:35:40 -0500
Received: by mail-qk1-f194.google.com with SMTP id r14so12853349qke.13
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 09:35:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ut9+vnBSIuJzv7XkkEuNe2Am0rm3vrZUmKhvNt9gJbc=;
        b=HG+MAYPTfFInCgQJvyWlysyzXYBvd7pUBCsssWlHd5pgV/hBuUihux4tnORHNwIdkq
         crW/0DlPftGI6aiMQYFEsqi8JVoZvHXgmhgKCtiBK8m7D2+AGVU+ngkTuMOxhul6CWdq
         ym5mdRyXo8JflLINN4FV2aNVys8WKzyN3haDklcQDUxGPNIWRwPRWD5yf7+zZB3hIm4c
         LUI1pEPLIeCJ3a9uUC/2BirAgHbN36B/S+66IRGepD03uQgrrLcIhl55pdsIyqeA9CzR
         J2/74xHIsGOC75zoN26cEPrGCOtK1CzKubdI/l1/TopKkLjnJMnU+Nttptegu+zUJ47s
         BZrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ut9+vnBSIuJzv7XkkEuNe2Am0rm3vrZUmKhvNt9gJbc=;
        b=tktWF7zjWVj/0QKs4jJlfN9HM/NIudMgK0E5XsHG2G0HXeBwABqhVzSbapzUaeLhRE
         6wPfwXQ1+0GWvkhe8YKiZfM69cxSO1cbS/MGn9vhJwtuZnr10ZhmFYa8fvXMB0JnhZ2F
         2+wJUkxo4mL0IHqVDQw13DOO1LXSC2gIaqjDkS0m4xcCrehaQRTp7YJJcgHXCsXb3Yel
         k1gGQj7sOZGaE8LfNE1VqcwUikZWUJkDJZDnZ9OiLRj5b4ORs0hNBqW7PX9WJKy8uvPY
         lBj4TDGu1r6U10sfey30i8ng/VYsYCvk3GYqORk1fY1DJdl7RPNnqFhuiIlAOQozauzy
         PGRw==
X-Gm-Message-State: APjAAAWVWG+53s8fRYXkvKugC/eWb+NbTSYMGj9G4B9nhz2ZpCqKei4A
        LCTPE4WUiiq4HpRipDv46ihp8lz6gm4=
X-Google-Smtp-Source: APXvYqzQ5aiYRbZTqAYPmAviPr3+Uy1Ecw8ZyIiKdqQQYxo+1JdpXOE4F1C4OIuBFde0nGUZkHRffA==
X-Received: by 2002:ae9:c104:: with SMTP id z4mr17866408qki.418.1579023338636;
        Tue, 14 Jan 2020 09:35:38 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id x27sm6898688qkx.81.2020.01.14.09.35.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 09:35:38 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 54DF940DFD; Tue, 14 Jan 2020 14:35:35 -0300 (-03)
Date:   Tue, 14 Jan 2020 14:35:35 -0300
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Namhyung Kim <namhyung@kernel.org>,
        Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <thoiland@redhat.com>,
        Jean-Tsung Hsiao <jhsiao@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tracing/uprobe: Fix double perf_event linking on
 multiprobe uprobe
Message-ID: <20200114173535.GA4769@kernel.org>
References: <157862073931.1800.3800576241181489174.stgit@devnote2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <157862073931.1800.3800576241181489174.stgit@devnote2>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Jan 10, 2020 at 10:45:39AM +0900, Masami Hiramatsu escreveu:
> Fix double perf_event linking to trace_uprobe_filter on
> multiple uprobe event by moving trace_uprobe_filter under
> trace_probe_event.
> 
> In uprobe perf event, trace_uprobe_filter data structure is
> managing target mm filters (in perf_event) related to each
> uprobe event.
> 
> Since commit 60d53e2c3b75 ("tracing/probe: Split trace_event
> related data from trace_probe") left the trace_uprobe_filter
> data structure in trace_uprobe, if a trace_probe_event has
> multiple trace_uprobe (multi-probe event), a perf_event is
> added to different trace_uprobe_filter on each trace_uprobe.
> This leads a linked list corruption.
> 
> To fix this issue, move trace_uprobe_filter to trace_probe_event
> and link it once on each event instead of each probe.
> 
> Fixes: 60d53e2c3b75 ("tracing/probe: Split trace_event related data from trace_probe")
> Reported-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> URL: https://lkml.kernel.org/r/20200108171611.GA8472@kernel.org
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>

Thanks, now it works as expected:

Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>

If you don't mind I can put it into my next perf/urgent pull req to
Ingo/Thomas,

And here is the sequence to check that libbpf routines linked statically
with perf are in fact being used when using 'perf trace' with one of its
events being a .c file, which gets interpreted as a bpf program, gets
compiled, and then the .o is handed over to libbpf on its way to the
kernel, in this specific case it'll collect, among other things, the
open, openat, open* pathnames, then we see that perf stat counts how
many times those routines were called:

[root@quaco ~]# perf probe -x ~/bin/perf bpf_[op]*__*
Added new events:
  probe_perf:bpf_output__fprintf (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_output__printer (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_program__bpil_offs_to_addr (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_program__bpil_addr_to_offs (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_program__get_prog_info_linear (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_program__attach_trace (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_program__attach_raw_tracepoint (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_program__attach_tracepoint (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_program__attach_uprobe (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_program__attach_kprobe (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_program__attach_perf_event (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_object__find_map_by_offset (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_object__find_map_fd_by_name (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_object__find_map_by_name (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_program__set_expected_attach_type (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_program__get_expected_attach_type (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_program__is_tracing (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_program__set_tracing (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_program__is_perf_event (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_program__set_perf_event (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_program__is_xdp (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_program__set_xdp (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_program__is_raw_tracepoint (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_program__set_raw_tracepoint (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_program__is_tracepoint (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_program__set_tracepoint (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_program__is_sched_act (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_program__set_sched_act (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_program__is_sched_cls (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_program__set_sched_cls (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_program__is_kprobe (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_program__set_kprobe (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_program__is_socket_filter (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_program__set_socket_filter (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_program__is_type (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_program__set_type (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_program__get_type (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_program__nth_fd (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_program__set_prep (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_program__size (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_program__fd (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_program__title (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_program__set_ifindex (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_program__priv (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_program__set_priv (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_program__prev (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_program__next (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_object__priv (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_object__set_priv (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_object__btf_fd (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_object__btf (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_object__kversion (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_object__name (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_object__next (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_object__close (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_object__pin (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_object__unpin_programs (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_object__pin_programs (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_object__unpin_maps (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_object__pin_maps (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_program__unpin (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_program__pin (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_program__unpin_instance (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_program__pin_instance (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_object__load (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_object__load_xattr (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_object__unload (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_object__open_buffer (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_object__open_mem (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_object__open_file (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_object__open (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_object__open_xattr (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_object__load_progs (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_program__is_function_storage (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_program__load (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_object__collect_reloc (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_object__relocate (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_program__relocate (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_program__reloc_text (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_object__relocate_core (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_object__create_maps (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_object__populate_internal_map (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_object__reuse_map (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_object__probe_caps (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_object__probe_array_mmap (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_object__probe_btf_datasec (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_object__probe_btf_func (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_object__probe_global_data (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_object__probe_name (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_program__collect_reloc (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_program__record_reloc (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_object__section_to_libbpf_map_type (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_object__shndx_is_maps (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_object__shndx_is_data (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_object__find_program_by_title (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_object__find_prog_by_idx (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_object__elf_collect (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_object__sanitize_and_load_btf (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_object__init_btf (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_object__is_btf_mandatory (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_object__sanitize_btf_ext (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_object__sanitize_btf (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_object__init_maps (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_object__init_user_btf_maps (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_object__init_user_btf_map (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_object__init_user_maps (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_object__init_global_data_maps (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_object__init_internal_map (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_object__add_map (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_object__variable_offset (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_object__section_size (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_object__init_kversion (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_object__init_license (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_object__check_endianness (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_object__elf_init (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_object__elf_finish (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_object__new (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_object__init_prog_names (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_object__add_program (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_program__init (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_program__exit (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_program__unload (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_prog_linfo__lfind (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_prog_linfo__lfind_addr_func (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_prog_linfo__new (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_prog_linfo__free (on bpf_[op]*__* in /home/acme/bin/perf)

You can now use it in all perf tools, such as:

	perf record -e probe_perf:bpf_prog_linfo__free -aR sleep 1

[root@quaco ~]# #perf stat -e probe_perf:bpf* perf trace
[root@quaco ~]# cat ~/.perfconfig.OFF
[llvm]
	dump-obj = true
	clang-opt = -g
[trace]
	add_events = /home/acme/git/perf/tools/perf/examples/bpf/augmented_raw_syscalls.o
	#add_events = /home/acme/augmented_raw_syscalls.c
	#add_events = /home/acme/git/perf/tools/perf/examples/bpf/augmented_raw_syscalls.c
	#add_events = /wb/augmented_raw_syscalls.o
	show_zeros = yes
	show_duration = no
	no_inherit = yes
	#show_timestamp = no
	#show_arg_names = no
	args_alignment = 40
	#show_prefix = yes

[annotate]

	hide_src_code = false
[root@quaco ~]# mv ~/.perfconfig ~/.perfconfig.OFF
mv: cannot stat '/root/.perfconfig': No such file or directory
[root@quaco ~]#
[root@quaco ~]# perf stat -e probe_perf:bpf* perf trace -e /home/acme/git/perf/tools/perf/examples/bpf/augmented_raw_syscalls.c,open* sleep 1
     0.000 ( 0.009 ms): sleep/16207 openat(dfd: CWD, filename: "/etc/ld.so.cache", flags: RDONLY|CLOEXEC) = 3
     0.031 ( 0.005 ms): sleep/16207 openat(dfd: CWD, filename: "/lib64/libc.so.6", flags: RDONLY|CLOEXEC) = 3
     0.308 ( 0.008 ms): sleep/16207 openat(dfd: CWD, filename: "", flags: RDONLY|CLOEXEC)                 = 3

 Performance counter stats for 'perf trace -e /home/acme/git/perf/tools/perf/examples/bpf/augmented_raw_syscalls.c,open* sleep 1':

                 0      probe_perf:bpf_prog_linfo__free
                 0      probe_perf:bpf_prog_linfo__new
                 0      probe_perf:bpf_prog_linfo__lfind_addr_func
                 0      probe_perf:bpf_prog_linfo__lfind
                18      probe_perf:bpf_program__unload
                 9      probe_perf:bpf_program__exit
                 9      probe_perf:bpf_program__init
                 9      probe_perf:bpf_object__add_program
                 1      probe_perf:bpf_object__init_prog_names
                 1      probe_perf:bpf_object__new
                 2      probe_perf:bpf_object__elf_finish
                 1      probe_perf:bpf_object__elf_init
                 1      probe_perf:bpf_object__check_endianness
                 1      probe_perf:bpf_object__init_license
                 1      probe_perf:bpf_object__init_kversion
                 0      probe_perf:bpf_object__section_size
                 0      probe_perf:bpf_object__variable_offset
                 6      probe_perf:bpf_object__add_map
                 0      probe_perf:bpf_object__init_internal_map
                 1      probe_perf:bpf_object__init_global_data_maps
                 1      probe_perf:bpf_object__init_user_maps
                 0      probe_perf:bpf_object__init_user_btf_map
                 1      probe_perf:bpf_object__init_user_btf_maps
                 1      probe_perf:bpf_object__init_maps
                 0      probe_perf:bpf_object__sanitize_btf
                 0      probe_perf:bpf_object__sanitize_btf_ext
                 1      probe_perf:bpf_object__is_btf_mandatory
                 1      probe_perf:bpf_object__init_btf
                 1      probe_perf:bpf_object__sanitize_and_load_btf
                 1      probe_perf:bpf_object__elf_collect
                 8      probe_perf:bpf_object__find_prog_by_idx
                15      probe_perf:bpf_object__find_program_by_title
                 0      probe_perf:bpf_object__shndx_is_data
                17      probe_perf:bpf_object__shndx_is_maps
                17      probe_perf:bpf_object__section_to_libbpf_map_type
                17      probe_perf:bpf_program__record_reloc
                 8      probe_perf:bpf_program__collect_reloc
                 1      probe_perf:bpf_object__probe_name
                 1      probe_perf:bpf_object__probe_global_data
                 1      probe_perf:bpf_object__probe_btf_func
                 1      probe_perf:bpf_object__probe_btf_datasec
                 1      probe_perf:bpf_object__probe_array_mmap
                 1      probe_perf:bpf_object__probe_caps
                 0      probe_perf:bpf_object__reuse_map
                 0      probe_perf:bpf_object__populate_internal_map
                 1      probe_perf:bpf_object__create_maps
                 0      probe_perf:bpf_object__relocate_core
                 0      probe_perf:bpf_program__reloc_text
                 9      probe_perf:bpf_program__relocate
                 1      probe_perf:bpf_object__relocate
                 1      probe_perf:bpf_object__collect_reloc
                 9      probe_perf:bpf_program__load
               154      probe_perf:bpf_program__is_function_storage
                 1      probe_perf:bpf_object__load_progs
                 0      probe_perf:bpf_object__open_xattr
                 0      probe_perf:bpf_object__open
                 0      probe_perf:bpf_object__open_file
                 1      probe_perf:bpf_object__open_mem
                 1      probe_perf:bpf_object__open_buffer
                 1      probe_perf:bpf_object__unload
                 1      probe_perf:bpf_object__load_xattr
                 1      probe_perf:bpf_object__load
                 0      probe_perf:bpf_program__pin_instance
                 0      probe_perf:bpf_program__unpin_instance
                 0      probe_perf:bpf_program__pin
                 0      probe_perf:bpf_program__unpin
                 0      probe_perf:bpf_object__pin_maps
                 0      probe_perf:bpf_object__unpin_maps
                 0      probe_perf:bpf_object__pin_programs
                 0      probe_perf:bpf_object__unpin_programs
                 0      probe_perf:bpf_object__pin
                 1      probe_perf:bpf_object__close
                17      probe_perf:bpf_object__next
                 0      probe_perf:bpf_object__name
                 0      probe_perf:bpf_object__kversion
                 0      probe_perf:bpf_object__btf
                 0      probe_perf:bpf_object__btf_fd
                 0      probe_perf:bpf_object__set_priv
                 0      probe_perf:bpf_object__priv
               159      probe_perf:bpf_program__next
                 0      probe_perf:bpf_program__prev
                 9      probe_perf:bpf_program__set_priv
                27      probe_perf:bpf_program__priv
                 0      probe_perf:bpf_program__set_ifindex
                 9      probe_perf:bpf_program__title
                15      probe_perf:bpf_program__fd
                 0      probe_perf:bpf_program__size
                 0      probe_perf:bpf_program__set_prep
                15      probe_perf:bpf_program__nth_fd
                 0      probe_perf:bpf_program__get_type
                 9      probe_perf:bpf_program__set_type
                 0      probe_perf:bpf_program__is_type
                 0      probe_perf:bpf_program__set_socket_filter
                 0      probe_perf:bpf_program__is_socket_filter
                 0      probe_perf:bpf_program__set_kprobe
                 0      probe_perf:bpf_program__is_kprobe
                 0      probe_perf:bpf_program__set_sched_cls
                 0      probe_perf:bpf_program__is_sched_cls
                 0      probe_perf:bpf_program__set_sched_act
                 0      probe_perf:bpf_program__is_sched_act
                 9      probe_perf:bpf_program__set_tracepoint
                 0      probe_perf:bpf_program__is_tracepoint
                 0      probe_perf:bpf_program__set_raw_tracepoint
                 0      probe_perf:bpf_program__is_raw_tracepoint
                 0      probe_perf:bpf_program__set_xdp
                 0      probe_perf:bpf_program__is_xdp
                 0      probe_perf:bpf_program__set_perf_event
                 0      probe_perf:bpf_program__is_perf_event
                 0      probe_perf:bpf_program__set_tracing
                 0      probe_perf:bpf_program__is_tracing
                 0      probe_perf:bpf_program__get_expected_attach_type
                 0      probe_perf:bpf_program__set_expected_attach_type
                 4      probe_perf:bpf_object__find_map_by_name
                 0      probe_perf:bpf_object__find_map_fd_by_name
                 0      probe_perf:bpf_object__find_map_by_offset
                 0      probe_perf:bpf_program__attach_perf_event
                 0      probe_perf:bpf_program__attach_kprobe
                 0      probe_perf:bpf_program__attach_uprobe
                 0      probe_perf:bpf_program__attach_tracepoint
                 0      probe_perf:bpf_program__attach_raw_tracepoint
                 0      probe_perf:bpf_program__attach_trace
                 0      probe_perf:bpf_program__get_prog_info_linear
                 0      probe_perf:bpf_program__bpil_addr_to_offs
                 0      probe_perf:bpf_program__bpil_offs_to_addr
                 0      probe_perf:bpf_output__printer
                 0      probe_perf:bpf_output__fprintf

       2.375277776 seconds time elapsed

       0.579446000 seconds user
       0.733851000 seconds sys


[root@quaco ~]#


Thanks,

- Arnaldo


>  kernel/trace/trace_kprobe.c |    2 -
>  kernel/trace/trace_probe.c  |    5 +-
>  kernel/trace/trace_probe.h  |    3 +
>  kernel/trace/trace_uprobe.c |  124 ++++++++++++++++++++++++++++---------------
>  4 files changed, 86 insertions(+), 48 deletions(-)
> 
> diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> index 7f890262c8a3..3e5f9c7d939c 100644
> --- a/kernel/trace/trace_kprobe.c
> +++ b/kernel/trace/trace_kprobe.c
> @@ -290,7 +290,7 @@ static struct trace_kprobe *alloc_trace_kprobe(const char *group,
>  	INIT_HLIST_NODE(&tk->rp.kp.hlist);
>  	INIT_LIST_HEAD(&tk->rp.kp.list);
>  
> -	ret = trace_probe_init(&tk->tp, event, group);
> +	ret = trace_probe_init(&tk->tp, event, group, 0);
>  	if (ret < 0)
>  		goto error;
>  
> diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
> index 905b10af5d5c..bba18cf44a30 100644
> --- a/kernel/trace/trace_probe.c
> +++ b/kernel/trace/trace_probe.c
> @@ -984,7 +984,7 @@ void trace_probe_cleanup(struct trace_probe *tp)
>  }
>  
>  int trace_probe_init(struct trace_probe *tp, const char *event,
> -		     const char *group)
> +		     const char *group, size_t event_data_size)
>  {
>  	struct trace_event_call *call;
>  	int ret = 0;
> @@ -992,7 +992,8 @@ int trace_probe_init(struct trace_probe *tp, const char *event,
>  	if (!event || !group)
>  		return -EINVAL;
>  
> -	tp->event = kzalloc(sizeof(struct trace_probe_event), GFP_KERNEL);
> +	tp->event = kzalloc(sizeof(struct trace_probe_event) + event_data_size,
> +			    GFP_KERNEL);
>  	if (!tp->event)
>  		return -ENOMEM;
>  
> diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
> index 4ee703728aec..03e4e180058d 100644
> --- a/kernel/trace/trace_probe.h
> +++ b/kernel/trace/trace_probe.h
> @@ -230,6 +230,7 @@ struct trace_probe_event {
>  	struct trace_event_call		call;
>  	struct list_head 		files;
>  	struct list_head		probes;
> +	char				data[0];
>  };
>  
>  struct trace_probe {
> @@ -322,7 +323,7 @@ static inline bool trace_probe_has_single_file(struct trace_probe *tp)
>  }
>  
>  int trace_probe_init(struct trace_probe *tp, const char *event,
> -		     const char *group);
> +		     const char *group, size_t event_data_size);
>  void trace_probe_cleanup(struct trace_probe *tp);
>  int trace_probe_append(struct trace_probe *tp, struct trace_probe *to);
>  void trace_probe_unlink(struct trace_probe *tp);
> diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
> index 352073d36585..f66e202fec13 100644
> --- a/kernel/trace/trace_uprobe.c
> +++ b/kernel/trace/trace_uprobe.c
> @@ -60,7 +60,6 @@ static struct dyn_event_operations trace_uprobe_ops = {
>   */
>  struct trace_uprobe {
>  	struct dyn_event		devent;
> -	struct trace_uprobe_filter	filter;
>  	struct uprobe_consumer		consumer;
>  	struct path			path;
>  	struct inode			*inode;
> @@ -264,6 +263,14 @@ process_fetch_insn(struct fetch_insn *code, struct pt_regs *regs, void *dest,
>  }
>  NOKPROBE_SYMBOL(process_fetch_insn)
>  
> +static struct trace_uprobe_filter *
> +trace_uprobe_get_filter(struct trace_uprobe *tu)
> +{
> +	struct trace_probe_event *event = tu->tp.event;
> +
> +	return (struct trace_uprobe_filter *)&event->data[0];
> +}
> +
>  static inline void init_trace_uprobe_filter(struct trace_uprobe_filter *filter)
>  {
>  	rwlock_init(&filter->rwlock);
> @@ -351,7 +358,8 @@ alloc_trace_uprobe(const char *group, const char *event, int nargs, bool is_ret)
>  	if (!tu)
>  		return ERR_PTR(-ENOMEM);
>  
> -	ret = trace_probe_init(&tu->tp, event, group);
> +	ret = trace_probe_init(&tu->tp, event, group,
> +				sizeof(struct trace_uprobe_filter));
>  	if (ret < 0)
>  		goto error;
>  
> @@ -359,7 +367,7 @@ alloc_trace_uprobe(const char *group, const char *event, int nargs, bool is_ret)
>  	tu->consumer.handler = uprobe_dispatcher;
>  	if (is_ret)
>  		tu->consumer.ret_handler = uretprobe_dispatcher;
> -	init_trace_uprobe_filter(&tu->filter);
> +	init_trace_uprobe_filter(trace_uprobe_get_filter(tu));
>  	return tu;
>  
>  error:
> @@ -1067,13 +1075,14 @@ static void __probe_event_disable(struct trace_probe *tp)
>  	struct trace_probe *pos;
>  	struct trace_uprobe *tu;
>  
> +	tu = container_of(tp, struct trace_uprobe, tp);
> +	WARN_ON(!uprobe_filter_is_empty(trace_uprobe_get_filter(tu)));
> +
>  	list_for_each_entry(pos, trace_probe_probe_list(tp), list) {
>  		tu = container_of(pos, struct trace_uprobe, tp);
>  		if (!tu->inode)
>  			continue;
>  
> -		WARN_ON(!uprobe_filter_is_empty(&tu->filter));
> -
>  		uprobe_unregister(tu->inode, tu->offset, &tu->consumer);
>  		tu->inode = NULL;
>  	}
> @@ -1108,7 +1117,7 @@ static int probe_event_enable(struct trace_event_call *call,
>  	}
>  
>  	tu = container_of(tp, struct trace_uprobe, tp);
> -	WARN_ON(!uprobe_filter_is_empty(&tu->filter));
> +	WARN_ON(!uprobe_filter_is_empty(trace_uprobe_get_filter(tu)));
>  
>  	if (enabled)
>  		return 0;
> @@ -1205,39 +1214,39 @@ __uprobe_perf_filter(struct trace_uprobe_filter *filter, struct mm_struct *mm)
>  }
>  
>  static inline bool
> -uprobe_filter_event(struct trace_uprobe *tu, struct perf_event *event)
> +trace_uprobe_filter_event(struct trace_uprobe_filter *filter,
> +			  struct perf_event *event)
>  {
> -	return __uprobe_perf_filter(&tu->filter, event->hw.target->mm);
> +	return __uprobe_perf_filter(filter, event->hw.target->mm);
>  }
>  
> -static int uprobe_perf_close(struct trace_uprobe *tu, struct perf_event *event)
> +static bool trace_uprobe_filter_remove(struct trace_uprobe_filter *filter,
> +				       struct perf_event *event)
>  {
>  	bool done;
>  
> -	write_lock(&tu->filter.rwlock);
> +	write_lock(&filter->rwlock);
>  	if (event->hw.target) {
>  		list_del(&event->hw.tp_list);
> -		done = tu->filter.nr_systemwide ||
> +		done = filter->nr_systemwide ||
>  			(event->hw.target->flags & PF_EXITING) ||
> -			uprobe_filter_event(tu, event);
> +			trace_uprobe_filter_event(filter, event);
>  	} else {
> -		tu->filter.nr_systemwide--;
> -		done = tu->filter.nr_systemwide;
> +		filter->nr_systemwide--;
> +		done = filter->nr_systemwide;
>  	}
> -	write_unlock(&tu->filter.rwlock);
> -
> -	if (!done)
> -		return uprobe_apply(tu->inode, tu->offset, &tu->consumer, false);
> +	write_unlock(&filter->rwlock);
>  
> -	return 0;
> +	return done;
>  }
>  
> -static int uprobe_perf_open(struct trace_uprobe *tu, struct perf_event *event)
> +/* This returns true if the filter always covers target mm */
> +static bool trace_uprobe_filter_add(struct trace_uprobe_filter *filter,
> +				    struct perf_event *event)
>  {
>  	bool done;
> -	int err;
>  
> -	write_lock(&tu->filter.rwlock);
> +	write_lock(&filter->rwlock);
>  	if (event->hw.target) {
>  		/*
>  		 * event->parent != NULL means copy_process(), we can avoid
> @@ -1247,28 +1256,21 @@ static int uprobe_perf_open(struct trace_uprobe *tu, struct perf_event *event)
>  		 * attr.enable_on_exec means that exec/mmap will install the
>  		 * breakpoints we need.
>  		 */
> -		done = tu->filter.nr_systemwide ||
> +		done = filter->nr_systemwide ||
>  			event->parent || event->attr.enable_on_exec ||
> -			uprobe_filter_event(tu, event);
> -		list_add(&event->hw.tp_list, &tu->filter.perf_events);
> +			trace_uprobe_filter_event(filter, event);
> +		list_add(&event->hw.tp_list, &filter->perf_events);
>  	} else {
> -		done = tu->filter.nr_systemwide;
> -		tu->filter.nr_systemwide++;
> +		done = filter->nr_systemwide;
> +		filter->nr_systemwide++;
>  	}
> -	write_unlock(&tu->filter.rwlock);
> +	write_unlock(&filter->rwlock);
>  
> -	err = 0;
> -	if (!done) {
> -		err = uprobe_apply(tu->inode, tu->offset, &tu->consumer, true);
> -		if (err)
> -			uprobe_perf_close(tu, event);
> -	}
> -	return err;
> +	return done;
>  }
>  
> -static int uprobe_perf_multi_call(struct trace_event_call *call,
> -				  struct perf_event *event,
> -		int (*op)(struct trace_uprobe *tu, struct perf_event *event))
> +static int uprobe_perf_close(struct trace_event_call *call,
> +			     struct perf_event *event)
>  {
>  	struct trace_probe *pos, *tp;
>  	struct trace_uprobe *tu;
> @@ -1278,25 +1280,59 @@ static int uprobe_perf_multi_call(struct trace_event_call *call,
>  	if (WARN_ON_ONCE(!tp))
>  		return -ENODEV;
>  
> +	tu = container_of(tp, struct trace_uprobe, tp);
> +	if (trace_uprobe_filter_remove(trace_uprobe_get_filter(tu), event))
> +		return 0;
> +
>  	list_for_each_entry(pos, trace_probe_probe_list(tp), list) {
>  		tu = container_of(pos, struct trace_uprobe, tp);
> -		ret = op(tu, event);
> +		ret = uprobe_apply(tu->inode, tu->offset, &tu->consumer, false);
>  		if (ret)
>  			break;
>  	}
>  
>  	return ret;
>  }
> +
> +static int uprobe_perf_open(struct trace_event_call *call,
> +			    struct perf_event *event)
> +{
> +	struct trace_probe *pos, *tp;
> +	struct trace_uprobe *tu;
> +	int err = 0;
> +
> +	tp = trace_probe_primary_from_call(call);
> +	if (WARN_ON_ONCE(!tp))
> +		return -ENODEV;
> +
> +	tu = container_of(tp, struct trace_uprobe, tp);
> +	if (trace_uprobe_filter_add(trace_uprobe_get_filter(tu), event))
> +		return 0;
> +
> +	list_for_each_entry(pos, trace_probe_probe_list(tp), list) {
> +		err = uprobe_apply(tu->inode, tu->offset, &tu->consumer, true);
> +		if (err) {
> +			uprobe_perf_close(call, event);
> +			break;
> +		}
> +	}
> +
> +	return err;
> +}
> +
>  static bool uprobe_perf_filter(struct uprobe_consumer *uc,
>  				enum uprobe_filter_ctx ctx, struct mm_struct *mm)
>  {
> +	struct trace_uprobe_filter *filter;
>  	struct trace_uprobe *tu;
>  	int ret;
>  
>  	tu = container_of(uc, struct trace_uprobe, consumer);
> -	read_lock(&tu->filter.rwlock);
> -	ret = __uprobe_perf_filter(&tu->filter, mm);
> -	read_unlock(&tu->filter.rwlock);
> +	filter = trace_uprobe_get_filter(tu);
> +
> +	read_lock(&filter->rwlock);
> +	ret = __uprobe_perf_filter(filter, mm);
> +	read_unlock(&filter->rwlock);
>  
>  	return ret;
>  }
> @@ -1419,10 +1455,10 @@ trace_uprobe_register(struct trace_event_call *event, enum trace_reg type,
>  		return 0;
>  
>  	case TRACE_REG_PERF_OPEN:
> -		return uprobe_perf_multi_call(event, data, uprobe_perf_open);
> +		return uprobe_perf_open(event, data);
>  
>  	case TRACE_REG_PERF_CLOSE:
> -		return uprobe_perf_multi_call(event, data, uprobe_perf_close);
> +		return uprobe_perf_close(event, data);
>  
>  #endif
>  	default:
> 

-- 

- Arnaldo
