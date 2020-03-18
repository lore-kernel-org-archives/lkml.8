Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02E60C10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 15:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B127A20767
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 15:42:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nxTAYY5o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbgCRPmN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 11:42:13 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:32926 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726671AbgCRPmN (ORCPT
        <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 11:42:13 -0400
Received: by mail-qk1-f194.google.com with SMTP id p6so615880qkm.0
        for <Linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 08:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=uRNY37ILgtcqTPJARZJuWXXnK+VK10zzV5y4HyarmUY=;
        b=nxTAYY5oD2N5rOkPAIeTjxktMUwAtcjJ3qIBjOs62QhIbwG1z3KZ3MVX072mFK8GFU
         eo+JNei9PCklFwOsbBtQgbfkDcm4GpB8SrGdv2aecseL/j4lcXs8a59CKPsheu/qejeF
         LElCrCBMH2dYcqZ7WRRvquKic/5gn1VOOwMrNaUMOIM08diTdrMCr3ajNBuQTfntZZ3I
         qkGtsBT52FRKMRKPuMiG5PyfnJn9z9dLnWxyvoQ7v+uaa6XjF7BnNxu8g+o4ccV0Zpfu
         uw0CPK84/2uJ5AQ0HCnDjbtNXdH0lysddqXBitmcwsyAJNa5foFjZpKplp7p0su9n7t3
         LcKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=uRNY37ILgtcqTPJARZJuWXXnK+VK10zzV5y4HyarmUY=;
        b=Lih34dw7obaKHbpaMwBlkS2K488KnIY9NTK6JYa2I1JWmZYlvpS5c25ewg9YzcugmN
         bIVrr+VH+PAUgyDgTgMkBybbEc2/NfsXw1tMXD8EdI73zXgUl/2QP5bb57lCQMF1AGr5
         p9Zu/G37qWCpMLSEGotRtEqRPsXVJEYEEQ+PcnNnHF/lSxFOgdRv7T4sQm2SQtkAEb3V
         ch/tz9AJIJddosfkLv76Zuh/cOtXa/mpl3ga4mP9OPe4nnsJbkCNjt4eGQ19Ya69/pCn
         MIFHikyt8OGJwyP0OiAOlCdB7seeZ2pzDFGXacZ1pQJmMnxgkIRNboWI0jXefk85nQQW
         8Pmw==
X-Gm-Message-State: ANhLgQ2aZCVojJ5gCOJzMwBlRyheyNAKEMozrj151QxHoLwLtdV1/Vhm
        PsVMcXGs6u0np0uEml9NGMw=
X-Google-Smtp-Source: ADFU+vso62XZ15nscFiZP/5vb4b2+N2iQrcwdYtnSLA/GEH42mGQehwZ6l/YMZKxFSFtQuxU0kegtQ==
X-Received: by 2002:a37:494f:: with SMTP id w76mr4803751qka.309.1584546131149;
        Wed, 18 Mar 2020 08:42:11 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id q8sm4306767qkm.73.2020.03.18.08.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 08:42:09 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id CFB80404E4; Wed, 18 Mar 2020 12:42:06 -0300 (-03)
Date:   Wed, 18 Mar 2020 12:42:06 -0300
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v5 2/3] perf report: Support interactive annotation of
 code without symbols
Message-ID: <20200318154206.GG11531@kernel.org>
References: <20200227043939.4403-1-yao.jin@linux.intel.com>
 <20200227043939.4403-3-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200227043939.4403-3-yao.jin@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Feb 27, 2020 at 12:39:38PM +0800, Jin Yao escreveu:
> For perf report on stripped binaries it is currently impossible to do
> annotation. The annotation state is all tied to symbols, but there are
> either no symbols, or symbols are not covering all the code.
> 
> We should support the annotation functionality even without symbols.
> 
> This patch fakes a symbol and the symbol name is the string of address.
> After that, we just follow current annotation working flow.
> 
> For example,
> 
> 1. perf report
> 
> Overhead  Command  Shared Object     Symbol
>   20.67%  div      libc-2.27.so      [.] __random_r
>   17.29%  div      libc-2.27.so      [.] __random
>   10.59%  div      div               [.] 0x0000000000000628
>    9.25%  div      div               [.] 0x0000000000000612
>    6.11%  div      div               [.] 0x0000000000000645
> 
> 2. Select the line of "10.59%  div      div               [.] 0x0000000000000628" and ENTER.
> 
> Annotate 0x0000000000000628
> Zoom into div thread
> Zoom into div DSO (use the 'k' hotkey to zoom directly into the kernel)
> Browse map details
> Run scripts for samples of symbol [0x0000000000000628]
> Run scripts for all samples
> Switch to another data file in PWD
> Exit
> 
> 3. Select the "Annotate 0x0000000000000628" and ENTER.
> 
> Percent│
>        │
>        │
>        │     Disassembly of section .text:
>        │
>        │     0000000000000628 <.text+0x68>:
>        │       divsd %xmm4,%xmm0
>        │       divsd %xmm3,%xmm1
>        │       movsd (%rsp),%xmm2
>        │       addsd %xmm1,%xmm0
>        │       addsd %xmm2,%xmm0
>        │       movsd %xmm0,(%rsp)
> 
> Now we can see the dump of object starting from 0x628.

Testing this I noticed this discrepancy when using 'o' in the annotate
view to see the address columns:

Samples: 10K of event 'cycles', 4000 Hz, Event count (approx.): 7738221585
0x0000000000ea8b97  /usr/libexec/gcc/x86_64-redhat-linux/9/cc1 [Percent: local period]
Percent│                                                                                                                                                                                                                                                  ▒
       │                                                                                                                                                                                                                                                  ▒
       │                                                                                                                                                                                                                                                  ▒
       │        Disassembly of section .text:                                                                                                                                                                                                             ▒
       │                                                                                                                                                                                                                                                  ◆
       │        00000000012a8b97 <linemap_get_expansion_line@@Base+0x227>:                                                                                                                                                                                ▒
       │12a8b97:   cmp     %rax,(%rdi)                                                                                                                                                                                                                    ▒
       │12a8b9a: ↓ je      12a8ba0 <linemap_get_expansion_line@@Base+0x230>                                                                                                                                                                               ▒
       │12a8b9c:   xor     %eax,%eax                                                                                                                                                                                                                      ▒
       │12a8b9e: ← retq                                                                                                                                                                                                                                   ▒
       │12a8b9f:   nop                                                                                                                                                                                                                                    ▒
       │12a8ba0:   mov     0x8(%rsi),%edx



 See that 0x0000000000ea8b97 != 12a8b97

How can we explain that?

- Arnaldo
 
>  v5:
>  ---
>  Remove the hotkey 'a' implementation from this patch. It
>  will be moved to a separate patch.
> 
>  v4:
>  ---
>  1. Support the hotkey 'a'. When we press 'a' on address,
>     now it supports the annotation.
> 
>  2. Change the patch title from
>     "Support interactive annotation of code without symbols" to
>     "perf report: Support interactive annotation of code without symbols"
> 
>  v3:
>  ---
>  Keep just the ANNOTATION_DUMMY_LEN, and remove the
>  opts->annotate_dummy_len since it's the "maybe in future
>  we will provide" feature.
> 
>  v2:
>  ---
>  Fix a crash issue when annotating an address in "unknown" object.
> 
>  The steps to reproduce this issue:
> 
>  perf record -e cycles:u ls
>  perf report
> 
>     75.29%  ls       ld-2.27.so        [.] do_lookup_x
>     23.64%  ls       ld-2.27.so        [.] __GI___tunables_init
>      1.04%  ls       [unknown]         [k] 0xffffffff85c01210
>      0.03%  ls       ld-2.27.so        [.] _start
> 
>  When annotating 0xffffffff85c01210, the crash happens.
> 
>  v2 adds checking for ms->map in add_annotate_opt(). If the object is
>  "unknown", ms->map is NULL.
> 
> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> ---
>  tools/perf/ui/browsers/hists.c | 43 +++++++++++++++++++++++++++++-----
>  tools/perf/util/annotate.h     |  1 +
>  2 files changed, 38 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
> index f36dee499320..2f07680559c4 100644
> --- a/tools/perf/ui/browsers/hists.c
> +++ b/tools/perf/ui/browsers/hists.c
> @@ -2465,13 +2465,41 @@ do_annotate(struct hist_browser *browser, struct popup_action *act)
>  	return 0;
>  }
>  
> +static struct symbol *new_annotate_sym(u64 addr, struct map *map)
> +{
> +	struct symbol *sym;
> +	struct annotated_source *src;
> +	char name[64];
> +
> +	snprintf(name, sizeof(name), "%-#.*lx", BITS_PER_LONG / 4, addr);
> +
> +	sym = symbol__new(addr, ANNOTATION_DUMMY_LEN, 0, 0, name);
> +	if (sym) {
> +		src = symbol__hists(sym, 1);
> +		if (!src) {
> +			symbol__delete(sym);
> +			return NULL;
> +		}
> +
> +		dso__insert_symbol(map->dso, sym);
> +	}
> +
> +	return sym;
> +}
> +
>  static int
>  add_annotate_opt(struct hist_browser *browser __maybe_unused,
>  		 struct popup_action *act, char **optstr,
> -		 struct map_symbol *ms)
> +		 struct map_symbol *ms,
> +		 u64 addr)
>  {
> -	if (ms->sym == NULL || ms->map->dso->annotate_warned ||
> -	    symbol__annotation(ms->sym)->src == NULL)
> +	if (!ms->map || !ms->map->dso || ms->map->dso->annotate_warned)
> +		return 0;
> +
> +	if (!ms->sym)
> +		ms->sym = new_annotate_sym(addr, ms->map);
> +
> +	if (ms->sym == NULL || symbol__annotation(ms->sym)->src == NULL)
>  		return 0;
>  
>  	if (asprintf(optstr, "Annotate %s", ms->sym->name) < 0)
> @@ -3219,17 +3247,20 @@ static int perf_evsel__hists_browse(struct evsel *evsel, int nr_events,
>  			nr_options += add_annotate_opt(browser,
>  						       &actions[nr_options],
>  						       &options[nr_options],
> -						       &bi->from.ms);
> +						       &bi->from.ms,
> +						       bi->from.al_addr);
>  			if (bi->to.ms.sym != bi->from.ms.sym)
>  				nr_options += add_annotate_opt(browser,
>  							&actions[nr_options],
>  							&options[nr_options],
> -							&bi->to.ms);
> +							&bi->to.ms,
> +							bi->to.al_addr);
>  		} else {
>  			nr_options += add_annotate_opt(browser,
>  						       &actions[nr_options],
>  						       &options[nr_options],
> -						       browser->selection);
> +						       browser->selection,
> +						       browser->he_selection->ip);
>  		}
>  skip_annotation:
>  		nr_options += add_thread_opt(browser, &actions[nr_options],
> diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
> index 455403e8fede..c8463c48adf2 100644
> --- a/tools/perf/util/annotate.h
> +++ b/tools/perf/util/annotate.h
> @@ -74,6 +74,7 @@ bool ins__is_fused(struct arch *arch, const char *ins1, const char *ins2);
>  #define ANNOTATION__CYCLES_WIDTH 6
>  #define ANNOTATION__MINMAX_CYCLES_WIDTH 19
>  #define ANNOTATION__AVG_IPC_WIDTH 36
> +#define ANNOTATION_DUMMY_LEN	256
>  
>  struct annotation_options {
>  	bool hide_src_code,
> -- 
> 2.17.1
> 

-- 

- Arnaldo
