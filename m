Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA5DFC1975A
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 02:18:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C69320754
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 02:18:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lvQTbFpY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727325AbgCRCSj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 22:18:39 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39213 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbgCRCSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 22:18:39 -0400
Received: by mail-pl1-f194.google.com with SMTP id m1so2278476pll.6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 19:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+Z0h+QjOixj3hV9EC2eSNbHBcxj6+7hCOJPal//2Lkk=;
        b=lvQTbFpYWjmZKws1NkP7DMAKRF4bfEuVIAbj6krRsXHCArMg1rGyvkkBuGsCHW2XzB
         SbcgGxUI+HVsetTxwukQj2npFVYTiRGyuapZL9aoP3zimlHvL71l7V2f4rh3e4FkJ4Hq
         KyETNaRMOr07oK98vtUzF77sRorCFZcBf+KRWkixyzxqozmFue/aV3G+iF45UY2er5+l
         8fNJwKcjuhi5p6CDViq9BHsPmkYSmVeq3nN69Kzgpi6oHm8Eff3dVaFU/IGDB2VUpTpy
         Sk5uKumFyz8RrlOrFH1S/CD0wzZWREW/YnmJ71I7NIFZTcWEBMQBJichX2OxHO1I+fLx
         WtNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+Z0h+QjOixj3hV9EC2eSNbHBcxj6+7hCOJPal//2Lkk=;
        b=Fcngn7MGdDdVL10YMx4yWC5nuDzxykL4JMFy9bBXMQl69TFNguJhPoMb5lDJoFLIE/
         UmLg9693LWv9laFgjhHMGB9n3XRVGl9XMgdGNNSsMvBYM81mX6dkXr28bMKNV7B/OYbt
         Yd5+3DtdRJo5RLyOljKlPvWmWUbgWqgBDFnyPGB3K9yrScragTi9cXlXug3wpeWnFW8z
         YUSa6iwDmZIdT9krOddTUeI4Y/Wdv+RzJw3ynESWQZwkJiIksXkHVR1jLX/2bRHzNjuI
         ctRUTya55xxxtGBdKXDaatuFLzYb9G9jDTUwejJ88KtxZ1uCictgJHFSZsg1u7NjCzZz
         u6SA==
X-Gm-Message-State: ANhLgQ0LZQQqrZ5oXQy6TjEquOmz0oqL8+4CxdZDRNBLNFysI1VH387K
        dl31FQKOCQNRlAg0vRaQvQMRYA==
X-Google-Smtp-Source: ADFU+vv9buM85Mq9YDKBuNN88jwdzKo931Rby8qSs6XYoiqHaWlrckdXgTenXFWL4fW2dMFfHPhTlw==
X-Received: by 2002:a17:90a:654a:: with SMTP id f10mr2275192pjs.50.1584497917196;
        Tue, 17 Mar 2020 19:18:37 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([2400:8902::f03c:91ff:fe3f:32da])
        by smtp.gmail.com with ESMTPSA id m18sm3621446pgd.39.2020.03.17.19.18.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Mar 2020 19:18:36 -0700 (PDT)
Date:   Wed, 18 Mar 2020 10:18:16 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Allison Randal <allison@lohutok.net>,
        John Garry <john.garry@huawei.com>,
        Enrico Weigelt <info@metux.net>, linux-kernel@vger.kernel.org,
        Mike Leach <mike.leach@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
        Thomas Richter <tmricht@linux.vnet.ibm.com>
Subject: Re: [PATCH v3] perf symbols: Consolidate symbol fixup issue
Message-ID: <20200318021816.GA19758@leoy-ThinkPad-X240s>
References: <20200306015759.10084-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200306015759.10084-1-leo.yan@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo, Jiri,

On Fri, Mar 06, 2020 at 09:57:58AM +0800, Leo Yan wrote:
> After copying Arm64's perf archive with object files and perf.data file
> to x86 laptop, the x86's perf kernel symbol resolution fails.  It
> outputs 'unknown' for all symbols parsing.
> 
> This issue is root caused by the function elf__needs_adjust_symbols(),
> x86 perf tool uses one weak version, Arm64 (and powerpc) has rewritten
> their own version.  elf__needs_adjust_symbols() decides if need to parse
> symbols with the relative offset address; but x86 building uses the weak
> function which misses to check for the elf type 'ET_DYN', so that it
> cannot parse symbols in Arm DSOs due to the wrong result from
> elf__needs_adjust_symbols().
> 
> The DSO parsing should not depend on any specific architecture perf
> building; e.g. x86 perf tool can parse Arm and Arm64 DSOs, vice versa.
> And confirmed by Naveen N. Rao that powerpc64 kernels are not being
> built as ET_DYN anymore and change to ET_EXEC.
> 
> This patch removes the arch specific functions for Arm64 and powerpc and
> changes elf__needs_adjust_symbols() as a common function.
> 
> In the common elf__needs_adjust_symbols(), it checks an extra condition
> 'ET_DYN' for elf header type.  With this fixing, the Arm64 DSO can be
> parsed properly with x86's perf tool.
> 
> Before:
> 
>   # perf script
>   main  3258          1          branches:                 0 [unknown] ([unknown]) => ffff800010c4665c [unknown] ([kernel.kallsyms])
>   main  3258          1          branches:  ffff800010c46670 [unknown] ([kernel.kallsyms]) => ffff800010c4eaec [unknown] ([kernel.kallsyms])
>   main  3258          1          branches:  ffff800010c4eaec [unknown] ([kernel.kallsyms]) => ffff800010c4eb00 [unknown] ([kernel.kallsyms])
>   main  3258          1          branches:  ffff800010c4eb08 [unknown] ([kernel.kallsyms]) => ffff800010c4e780 [unknown] ([kernel.kallsyms])
>   main  3258          1          branches:  ffff800010c4e7a0 [unknown] ([kernel.kallsyms]) => ffff800010c4eeac [unknown] ([kernel.kallsyms])
>   main  3258          1          branches:  ffff800010c4eebc [unknown] ([kernel.kallsyms]) => ffff800010c4ed80 [unknown] ([kernel.kallsyms])
> 
> After:
> 
>   # perf script
>   main  3258          1          branches:                 0 [unknown] ([unknown]) => ffff800010c4665c coresight_timeout+0x54 ([kernel.kallsyms])
>   main  3258          1          branches:  ffff800010c46670 coresight_timeout+0x68 ([kernel.kallsyms]) => ffff800010c4eaec etm4_enable_hw+0x3cc ([kernel.kallsyms])
>   main  3258          1          branches:  ffff800010c4eaec etm4_enable_hw+0x3cc ([kernel.kallsyms]) => ffff800010c4eb00 etm4_enable_hw+0x3e0 ([kernel.kallsyms])
>   main  3258          1          branches:  ffff800010c4eb08 etm4_enable_hw+0x3e8 ([kernel.kallsyms]) => ffff800010c4e780 etm4_enable_hw+0x60 ([kernel.kallsyms])
>   main  3258          1          branches:  ffff800010c4e7a0 etm4_enable_hw+0x80 ([kernel.kallsyms]) => ffff800010c4eeac etm4_enable+0x2d4 ([kernel.kallsyms])
>   main  3258          1          branches:  ffff800010c4eebc etm4_enable+0x2e4 ([kernel.kallsyms]) => ffff800010c4ed80 etm4_enable+0x1a8 ([kernel.kallsyms])
> 
> v3: Changed to check for ET_DYN across all architectures.
> 
> v2: Fixed Arm64 and powerpc native building.
> 
> Reported-by: Mike Leach <mike.leach@linaro.org>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> Reviewed-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

Could you help review this patch?

I'd like to sell this patch with two scenarios: either when work on Arm
embedded system or work on Arm server (but the server is located in
the remote lab), if we copy the related perf data to our local x86_64
PC, this patch can be useful for our development and cross analysis.

Thanks,
Leo

> ---
>  tools/perf/arch/arm64/util/Build            |  1 -
>  tools/perf/arch/arm64/util/sym-handling.c   | 19 -------------------
>  tools/perf/arch/powerpc/util/Build          |  1 -
>  tools/perf/arch/powerpc/util/sym-handling.c | 10 ----------
>  tools/perf/util/symbol-elf.c                | 10 ++++++++--
>  5 files changed, 8 insertions(+), 33 deletions(-)
>  delete mode 100644 tools/perf/arch/arm64/util/sym-handling.c
> 
> diff --git a/tools/perf/arch/arm64/util/Build b/tools/perf/arch/arm64/util/Build
> index 0a7782c61209..789956f76d85 100644
> --- a/tools/perf/arch/arm64/util/Build
> +++ b/tools/perf/arch/arm64/util/Build
> @@ -1,6 +1,5 @@
>  perf-y += header.o
>  perf-y += perf_regs.o
> -perf-y += sym-handling.o
>  perf-$(CONFIG_DWARF)     += dwarf-regs.o
>  perf-$(CONFIG_LOCAL_LIBUNWIND) += unwind-libunwind.o
>  perf-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
> diff --git a/tools/perf/arch/arm64/util/sym-handling.c b/tools/perf/arch/arm64/util/sym-handling.c
> deleted file mode 100644
> index 8dfa3e5229f1..000000000000
> --- a/tools/perf/arch/arm64/util/sym-handling.c
> +++ /dev/null
> @@ -1,19 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/*
> - *
> - * Copyright (C) 2015 Naveen N. Rao, IBM Corporation
> - */
> -
> -#include "symbol.h" // for the elf__needs_adjust_symbols() prototype
> -#include <stdbool.h>
> -
> -#ifdef HAVE_LIBELF_SUPPORT
> -#include <gelf.h>
> -
> -bool elf__needs_adjust_symbols(GElf_Ehdr ehdr)
> -{
> -	return ehdr.e_type == ET_EXEC ||
> -	       ehdr.e_type == ET_REL ||
> -	       ehdr.e_type == ET_DYN;
> -}
> -#endif
> diff --git a/tools/perf/arch/powerpc/util/Build b/tools/perf/arch/powerpc/util/Build
> index 7cf0b8803097..e5c9504f8586 100644
> --- a/tools/perf/arch/powerpc/util/Build
> +++ b/tools/perf/arch/powerpc/util/Build
> @@ -1,5 +1,4 @@
>  perf-y += header.o
> -perf-y += sym-handling.o
>  perf-y += kvm-stat.o
>  perf-y += perf_regs.o
>  perf-y += mem-events.o
> diff --git a/tools/perf/arch/powerpc/util/sym-handling.c b/tools/perf/arch/powerpc/util/sym-handling.c
> index abb7a12d8f93..0856b32f9e08 100644
> --- a/tools/perf/arch/powerpc/util/sym-handling.c
> +++ b/tools/perf/arch/powerpc/util/sym-handling.c
> @@ -10,16 +10,6 @@
>  #include "probe-event.h"
>  #include "probe-file.h"
>  
> -#ifdef HAVE_LIBELF_SUPPORT
> -bool elf__needs_adjust_symbols(GElf_Ehdr ehdr)
> -{
> -	return ehdr.e_type == ET_EXEC ||
> -	       ehdr.e_type == ET_REL ||
> -	       ehdr.e_type == ET_DYN;
> -}
> -
> -#endif
> -
>  int arch__choose_best_symbol(struct symbol *syma,
>  			     struct symbol *symb __maybe_unused)
>  {
> diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
> index 1965aefccb02..be5b493f8284 100644
> --- a/tools/perf/util/symbol-elf.c
> +++ b/tools/perf/util/symbol-elf.c
> @@ -704,9 +704,15 @@ void symsrc__destroy(struct symsrc *ss)
>  	close(ss->fd);
>  }
>  
> -bool __weak elf__needs_adjust_symbols(GElf_Ehdr ehdr)
> +bool elf__needs_adjust_symbols(GElf_Ehdr ehdr)
>  {
> -	return ehdr.e_type == ET_EXEC || ehdr.e_type == ET_REL;
> +	/*
> +	 * Usually vmlinux is an ELF file with type ET_EXEC for most
> +	 * architectures; except Arm64 kernel is linked with option
> +	 * '-share', so need to check type ET_DYN.
> +	 */
> +	return ehdr.e_type == ET_EXEC || ehdr.e_type == ET_REL ||
> +	       ehdr.e_type == ET_DYN;
>  }
>  
>  int symsrc__init(struct symsrc *ss, struct dso *dso, const char *name,
> -- 
> 2.17.1
> 
