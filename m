Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56ABAC47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 15:48:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29191206A3
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 15:48:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CZx6hgl9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729614AbgEKPsS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 11:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727994AbgEKPsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 11:48:17 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45238C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 08:48:17 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id n14so10210119qke.8
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 08:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=y7Fp3yPTgkwYJSLUmTMlCjq+JgDCEGaVcqNWduDNVMc=;
        b=CZx6hgl95i69YKZq+gibVa10c4MXKsXd0Hpn7z48CDRXCWuaSsJvrzx8LAVDwUgeFK
         tEA58COmwOXtjSL+LIVQoGTT4u5Lzt6TEJlZyrzOn/l39tarehnNdcCec0bUSVlvgZbM
         4L0S05nJ6HfOYWw5+F6iLSAv3Q7TUMKxUk+oZY0G1sGiUJwWrQUyNAa97uyPh1FML3xG
         yfx/dxfiS7zPs75OzqHHgp5Et7yF68VhsJasGEzQdkaDFRP8lZHgm6iAhQ4aL53g/bj3
         aAXO3Vsgneg86BLEVCwpA0uixmnDsRaIbUi0h/CqYKsNx2dSkAm+DNStA7i5lVEna7o3
         W7Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=y7Fp3yPTgkwYJSLUmTMlCjq+JgDCEGaVcqNWduDNVMc=;
        b=DshH0UfDPbT3+hiDWnsNzpZ+SwXb9FfXCvLGX3GVXIxZhVlm0TDKQuKUD7l02mVgiz
         HTD6sN4O2u0Q3UatRJ/+rKNE4yVfIzQBx4GpnsWuuVRD+6P2Ak8Ns6LpoAf0BoSxTYWl
         PQSnu9H2a14GwMXKQseU3h7L9l4HowD2tsM8ej504XWj+JfVKtwr4iusPRcr+0XwPDY3
         H3KnEOwuBi0HwE3C0fbiobw9f+VNlbtGyMT7VRr9u11rRLU7sudpOm6hCOIG55yL1TQB
         /6ik4GLusU6RlN/UH4DhgpmahmaHcOSkDOHfRhBIrqXLetin1nnz0bffS7rcJQp9aboW
         cLkA==
X-Gm-Message-State: AGi0PuanwKLY73eJ/JnXh6arYRCF0p8tzTLIAw86qFvFNHL4rd0pV9SR
        L2Lz47RZL4i7k7vkW2A7M58=
X-Google-Smtp-Source: APiQypKq4XJ5bvI889aP6TXWaoNbyNCnwzdC1doJ63ez1XUVON9Day16z/NNSzBu3sPvHDU8I6nZwQ==
X-Received: by 2002:a37:4c93:: with SMTP id z141mr16134363qka.143.1589212095998;
        Mon, 11 May 2020 08:48:15 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id u56sm1131136qtb.91.2020.05.11.08.48.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 08:48:15 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 06D8940AFD; Mon, 11 May 2020 12:48:12 -0300 (-03)
Date:   Mon, 11 May 2020 12:48:12 -0300
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf script: Replace zero-length array with
 flexible-array
Message-ID: <20200511154812.GD5377@kernel.org>
References: <20200507190615.GA15677@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507190615.GA15677@embeddedor>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, May 07, 2020 at 02:06:15PM -0500, Gustavo A. R. Silva escreveu:
> The current codebase makes use of the zero-length array language
> extension to the C90 standard, but the preferred mechanism to declare
> variable-length types such as these ones is a flexible array member[1][2],
> introduced in C99:
> 
> struct foo {
>         int stuff;
>         struct boo array[];
> };

Can you split this into a kernel part and tools/ one? Also this is not
really just for "perf script", so please adjust the subject line too :-)

- Arnaldo
 
> By making use of the mechanism above, we will get a compiler warning
> in case the flexible array does not occur last in the structure, which
> will help us prevent some kind of undefined behavior bugs from being
> inadvertently introduced[3] to the codebase from now on.
> 
> Also, notice that, dynamic memory allocations won't be affected by
> this change:
> 
> "Flexible array members have incomplete type, and so the sizeof operator
> may not be applied. As a quirk of the original implementation of
> zero-length arrays, sizeof evaluates to zero."[1]
> 
> sizeof(flexible-array-member) triggers a warning because flexible array
> members have incomplete type[1]. There are some instances of code in
> which the sizeof operator is being incorrectly/erroneously applied to
> zero-length arrays and the result is zero. Such instances may be hiding
> some bugs. So, this work (flexible-array member conversions) will also
> help to get completely rid of those sorts of issues.
> 
> This issue was found with the help of Coccinelle.
> 
> [1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> [2] https://github.com/KSPP/linux/issues/21
> [3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  arch/x86/events/intel/bts.c              |    2 +-
>  arch/x86/events/intel/uncore.h           |    2 +-
>  include/linux/perf_event.h               |    4 ++--
>  kernel/events/callchain.c                |    2 +-
>  kernel/events/internal.h                 |    2 +-
>  tools/perf/bench/sched-messaging.c       |    2 +-
>  tools/perf/builtin-inject.c              |    2 +-
>  tools/perf/builtin-script.c              |    2 +-
>  tools/perf/builtin-timechart.c           |    2 +-
>  tools/perf/util/annotate.h               |    4 ++--
>  tools/perf/util/branch.h                 |    2 +-
>  tools/perf/util/cputopo.h                |    2 +-
>  tools/perf/util/dso.h                    |    4 ++--
>  tools/perf/util/event.h                  |    2 +-
>  tools/perf/util/jitdump.c                |    2 +-
>  tools/perf/util/jitdump.h                |    6 +++---
>  tools/perf/util/ordered-events.h         |    2 +-
>  tools/perf/util/pstack.c                 |    2 +-
>  tools/perf/util/symbol.h                 |    2 +-
>  tools/perf/util/unwind-libunwind-local.c |    2 +-
>  20 files changed, 25 insertions(+), 25 deletions(-)
> 
> diff --git a/arch/x86/events/intel/bts.c b/arch/x86/events/intel/bts.c
> index 6a3b599ee0fe..731dd8d0dbb1 100644
> --- a/arch/x86/events/intel/bts.c
> +++ b/arch/x86/events/intel/bts.c
> @@ -58,7 +58,7 @@ struct bts_buffer {
>  	local_t		head;
>  	unsigned long	end;
>  	void		**data_pages;
> -	struct bts_phys	buf[0];
> +	struct bts_phys	buf[];
>  };
>  
>  static struct pmu bts_pmu;
> diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
> index 0da4a4605536..b469ddd45515 100644
> --- a/arch/x86/events/intel/uncore.h
> +++ b/arch/x86/events/intel/uncore.h
> @@ -130,7 +130,7 @@ struct intel_uncore_box {
>  	struct list_head list;
>  	struct list_head active_list;
>  	void __iomem *io_addr;
> -	struct intel_uncore_extra_reg shared_regs[0];
> +	struct intel_uncore_extra_reg shared_regs[];
>  };
>  
>  /* CFL uncore 8th cbox MSRs */
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index 9c3e7619c929..306b07b56cc6 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -61,7 +61,7 @@ struct perf_guest_info_callbacks {
>  
>  struct perf_callchain_entry {
>  	__u64				nr;
> -	__u64				ip[0]; /* /proc/sys/kernel/perf_event_max_stack */
> +	__u64				ip[]; /* /proc/sys/kernel/perf_event_max_stack */
>  };
>  
>  struct perf_callchain_entry_ctx {
> @@ -113,7 +113,7 @@ struct perf_raw_record {
>  struct perf_branch_stack {
>  	__u64				nr;
>  	__u64				hw_idx;
> -	struct perf_branch_entry	entries[0];
> +	struct perf_branch_entry	entries[];
>  };
>  
>  struct task_struct;
> diff --git a/kernel/events/callchain.c b/kernel/events/callchain.c
> index c2b41a263166..b1991043b7d8 100644
> --- a/kernel/events/callchain.c
> +++ b/kernel/events/callchain.c
> @@ -16,7 +16,7 @@
>  
>  struct callchain_cpus_entries {
>  	struct rcu_head			rcu_head;
> -	struct perf_callchain_entry	*cpu_entries[0];
> +	struct perf_callchain_entry	*cpu_entries[];
>  };
>  
>  int sysctl_perf_event_max_stack __read_mostly = PERF_MAX_STACK_DEPTH;
> diff --git a/kernel/events/internal.h b/kernel/events/internal.h
> index f16f66b6b655..fcbf5616a441 100644
> --- a/kernel/events/internal.h
> +++ b/kernel/events/internal.h
> @@ -55,7 +55,7 @@ struct perf_buffer {
>  	void				*aux_priv;
>  
>  	struct perf_event_mmap_page	*user_page;
> -	void				*data_pages[0];
> +	void				*data_pages[];
>  };
>  
>  extern void rb_free(struct perf_buffer *rb);
> diff --git a/tools/perf/bench/sched-messaging.c b/tools/perf/bench/sched-messaging.c
> index 97e4a4fb3362..71d830d7b923 100644
> --- a/tools/perf/bench/sched-messaging.c
> +++ b/tools/perf/bench/sched-messaging.c
> @@ -40,7 +40,7 @@ struct sender_context {
>  	unsigned int num_fds;
>  	int ready_out;
>  	int wakefd;
> -	int out_fds[0];
> +	int out_fds[];
>  };
>  
>  struct receiver_context {
> diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
> index 7e124a7b8bfd..8f983877c42d 100644
> --- a/tools/perf/builtin-inject.c
> +++ b/tools/perf/builtin-inject.c
> @@ -51,7 +51,7 @@ struct perf_inject {
>  struct event_entry {
>  	struct list_head node;
>  	u32		 tid;
> -	union perf_event event[0];
> +	union perf_event event[];
>  };
>  
>  static int output_bytes(struct perf_inject *inject, void *buf, size_t sz)
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index 1f57a7ecdf3d..02d64a9c6f64 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -2619,7 +2619,7 @@ static int __cmd_script(struct perf_script *script)
>  struct script_spec {
>  	struct list_head	node;
>  	struct scripting_ops	*ops;
> -	char			spec[0];
> +	char			spec[];
>  };
>  
>  static LIST_HEAD(script_specs);
> diff --git a/tools/perf/builtin-timechart.c b/tools/perf/builtin-timechart.c
> index 9e84fae9b096..0ba568efa939 100644
> --- a/tools/perf/builtin-timechart.c
> +++ b/tools/perf/builtin-timechart.c
> @@ -128,7 +128,7 @@ struct sample_wrapper {
>  	struct sample_wrapper *next;
>  
>  	u64		timestamp;
> -	unsigned char	data[0];
> +	unsigned char	data[];
>  };
>  
>  #define TYPE_NONE	0
> diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
> index 2d88069d6428..0a0cd4f32175 100644
> --- a/tools/perf/util/annotate.h
> +++ b/tools/perf/util/annotate.h
> @@ -144,7 +144,7 @@ struct annotation_line {
>  	u32			 idx;
>  	int			 idx_asm;
>  	int			 data_nr;
> -	struct annotation_data	 data[0];
> +	struct annotation_data	 data[];
>  };
>  
>  struct disasm_line {
> @@ -227,7 +227,7 @@ void symbol__calc_percent(struct symbol *sym, struct evsel *evsel);
>  struct sym_hist {
>  	u64		      nr_samples;
>  	u64		      period;
> -	struct sym_hist_entry addr[0];
> +	struct sym_hist_entry addr[];
>  };
>  
>  struct cyc_hist {
> diff --git a/tools/perf/util/branch.h b/tools/perf/util/branch.h
> index 154a05cd03af..748f1d23a5c4 100644
> --- a/tools/perf/util/branch.h
> +++ b/tools/perf/util/branch.h
> @@ -41,7 +41,7 @@ struct branch_entry {
>  struct branch_stack {
>  	u64			nr;
>  	u64			hw_idx;
> -	struct branch_entry	entries[0];
> +	struct branch_entry	entries[];
>  };
>  
>  /*
> diff --git a/tools/perf/util/cputopo.h b/tools/perf/util/cputopo.h
> index 7bf6b811f715..6201c3790d86 100644
> --- a/tools/perf/util/cputopo.h
> +++ b/tools/perf/util/cputopo.h
> @@ -22,7 +22,7 @@ struct numa_topology_node {
>  
>  struct numa_topology {
>  	u32				nr;
> -	struct numa_topology_node	nodes[0];
> +	struct numa_topology_node	nodes[];
>  };
>  
>  struct cpu_topology *cpu_topology__new(void);
> diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
> index 2db64b79617a..d7ba29ad19ff 100644
> --- a/tools/perf/util/dso.h
> +++ b/tools/perf/util/dso.h
> @@ -136,7 +136,7 @@ struct dso_cache {
>  	struct rb_node	rb_node;
>  	u64 offset;
>  	u64 size;
> -	char data[0];
> +	char data[];
>  };
>  
>  struct auxtrace_cache;
> @@ -208,7 +208,7 @@ struct dso {
>  	struct nsinfo	*nsinfo;
>  	struct dso_id	 id;
>  	refcount_t	 refcnt;
> -	char		 name[0];
> +	char		 name[];
>  };
>  
>  /* dso__for_each_symbol - iterate over the symbols of given type
> diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
> index b8289f160f07..6ae01c3c2ffa 100644
> --- a/tools/perf/util/event.h
> +++ b/tools/perf/util/event.h
> @@ -79,7 +79,7 @@ struct sample_read {
>  
>  struct ip_callchain {
>  	u64 nr;
> -	u64 ips[0];
> +	u64 ips[];
>  };
>  
>  struct branch_stack;
> diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
> index e3ccb0ce1938..32bb05e03fb2 100644
> --- a/tools/perf/util/jitdump.c
> +++ b/tools/perf/util/jitdump.c
> @@ -57,7 +57,7 @@ struct debug_line_info {
>  	unsigned long vma;
>  	unsigned int lineno;
>  	/* The filename format is unspecified, absolute path, relative etc. */
> -	char const filename[0];
> +	char const filename[];
>  };
>  
>  struct jit_tool {
> diff --git a/tools/perf/util/jitdump.h b/tools/perf/util/jitdump.h
> index f2c3823cc81a..ab2842def83d 100644
> --- a/tools/perf/util/jitdump.h
> +++ b/tools/perf/util/jitdump.h
> @@ -93,7 +93,7 @@ struct debug_entry {
>  	uint64_t addr;
>  	int lineno;	    /* source line number starting at 1 */
>  	int discrim;	    /* column discriminator, 0 is default */
> -	const char name[0]; /* null terminated filename, \xff\0 if same as previous entry */
> +	const char name[]; /* null terminated filename, \xff\0 if same as previous entry */
>  };
>  
>  struct jr_code_debug_info {
> @@ -101,7 +101,7 @@ struct jr_code_debug_info {
>  
>  	uint64_t code_addr;
>  	uint64_t nr_entry;
> -	struct debug_entry entries[0];
> +	struct debug_entry entries[];
>  };
>  
>  struct jr_code_unwinding_info {
> @@ -110,7 +110,7 @@ struct jr_code_unwinding_info {
>  	uint64_t unwinding_size;
>  	uint64_t eh_frame_hdr_size;
>  	uint64_t mapped_size;
> -	const char unwinding_data[0];
> +	const char unwinding_data[];
>  };
>  
>  union jr_entry {
> diff --git a/tools/perf/util/ordered-events.h b/tools/perf/util/ordered-events.h
> index 0920fb0ec6cc..75345946c4b9 100644
> --- a/tools/perf/util/ordered-events.h
> +++ b/tools/perf/util/ordered-events.h
> @@ -29,7 +29,7 @@ typedef int (*ordered_events__deliver_t)(struct ordered_events *oe,
>  
>  struct ordered_events_buffer {
>  	struct list_head	list;
> -	struct ordered_event	event[0];
> +	struct ordered_event	event[];
>  };
>  
>  struct ordered_events {
> diff --git a/tools/perf/util/pstack.c b/tools/perf/util/pstack.c
> index 80ff41fc45be..a1d1e4ef6257 100644
> --- a/tools/perf/util/pstack.c
> +++ b/tools/perf/util/pstack.c
> @@ -15,7 +15,7 @@
>  struct pstack {
>  	unsigned short	top;
>  	unsigned short	max_nr_entries;
> -	void		*entries[0];
> +	void		*entries[];
>  };
>  
>  struct pstack *pstack__new(unsigned short max_nr_entries)
> diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
> index 93fc43db1be3..ff4f4c47e148 100644
> --- a/tools/perf/util/symbol.h
> +++ b/tools/perf/util/symbol.h
> @@ -55,7 +55,7 @@ struct symbol {
>  	u8		inlined:1;
>  	u8		arch_sym;
>  	bool		annotate2;
> -	char		name[0];
> +	char		name[];
>  };
>  
>  void symbol__delete(struct symbol *sym);
> diff --git a/tools/perf/util/unwind-libunwind-local.c b/tools/perf/util/unwind-libunwind-local.c
> index b4649f5a0c2f..9aededc0bc06 100644
> --- a/tools/perf/util/unwind-libunwind-local.c
> +++ b/tools/perf/util/unwind-libunwind-local.c
> @@ -243,7 +243,7 @@ struct eh_frame_hdr {
>  	 *    encoded_t fde_addr;
>  	 * } binary_search_table[fde_count];
>  	 */
> -	char data[0];
> +	char data[];
>  } __packed;
>  
>  static int unwind_spec_ehframe(struct dso *dso, struct machine *machine,
> 

-- 

- Arnaldo
