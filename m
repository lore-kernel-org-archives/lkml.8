Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 327EFC35656
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 15:29:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F379D208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 15:29:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zmpq/G2G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729288AbgBUP3p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 10:29:45 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35542 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727053AbgBUP3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 10:29:45 -0500
Received: by mail-pf1-f193.google.com with SMTP id i19so1397467pfa.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 07:29:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nbVYkFoN0sJ+I2FUooWO9pwNnNtgPmlbc857RSYkSMI=;
        b=zmpq/G2G/WSdTO0fePtw0amnGiJEca4m6R1dOf1ra3oij697B523LEWAZe6svpwAth
         CsDDMMxF9k9ZET+mRNiltGGBZOtghgXXJAu0QXpTE+PeoC9ImVVGly5b03XxAU8JoTUT
         GUyevVFuEClNTvCoSQyUFWjWJPRttR6d2TqF94m2/WY2+FhKEud3hVNfLMBNeomchr5i
         Fx3jrQRzhQXNtORvn14K9oNKXncUl+l9aCM65choH7LPuBpQzBnjGXM4XruwM28Fr8Sx
         6fg1VDdCgihMz2kDDTvcg/RThu6pjpW0Q42BudAtQXQYfnCikRI2B9f219LyB5wf30SX
         AHqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nbVYkFoN0sJ+I2FUooWO9pwNnNtgPmlbc857RSYkSMI=;
        b=T/P2/5iT1OyVyTUbYzVXR6aGGkf59wdxyxATPsFziYkp2H/CluMt53xeVjKFh5sj5i
         S2axCSidb6HohaqPo4zIsUCs6g8KiQvyBIbk6gkYigPvKrmoZKnPvYQbF2vI3d4CUl9t
         j4Z/uhBxyjrqyvGklyM1vtZGDqU+B/lZfr4viT8aqSBXJDk7d1/kAlpwMKVSNfcaSilw
         yHU50IhPn9rejVm+8NC0OBRpYsTTqCX1pwEowuDfGj1lrYDGW8FRgrpGpLpNgtbsOyWL
         Aqx4OjxZk4SP4Tlr8fXsMwP/PB7/9YF2VHTWFYKhSa1atDC8jFyoPIlc5262Pf7oTq0/
         TCMA==
X-Gm-Message-State: APjAAAWfpbN5iq36yUKmaFQhtIUgmoK6RXorDwz99tYNvEysgEe2PmPD
        zHMB+AWwXLqRGuwAEchT/YSFmcK1x5ee6i+C
X-Google-Smtp-Source: APXvYqwq+q7J+Md+zS6zi/Nc1irj9//EpPBYrypt7IaBdMyx7KYCtN6gHGN5uOqDJ2IkA5i6Q6PqYw==
X-Received: by 2002:aa7:8101:: with SMTP id b1mr38558716pfi.105.1582298984615;
        Fri, 21 Feb 2020 07:29:44 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([2400:8904::f03c:91ff:fe8a:bbb8])
        by smtp.gmail.com with ESMTPSA id t8sm2910258pjy.20.2020.02.21.07.29.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Feb 2020 07:29:44 -0800 (PST)
Date:   Fri, 21 Feb 2020 23:29:22 +0800
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
Subject: Re: [PATCH] perf symbols: Consolidate symbol fixup issue
Message-ID: <20200221152922.GA23282@leoy-ThinkPad-X240s>
References: <20200221152324.22018-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200221152324.22018-1-leo.yan@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Looping PowerPC developers.

On Fri, Feb 21, 2020 at 11:23:24PM +0800, Leo Yan wrote:
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
> So this patch changes elf__needs_adjust_symbols() as a common function
> and removes the arch specific functions for Arm64 and powerpc.
> 
> In the common elf__needs_adjust_symbols(), it checks elf header and if
> the machine type is one of Arm64/ppc/ppc64, it checks extra condition
> for 'ET_DYN'.  Finally, the Arm64 DSO can be parsed properly with x86's
> perf tool.
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
> Reported-by: Mike Leach <mike.leach@linaro.org>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  tools/perf/arch/arm64/util/sym-handling.c   | 19 -------------------
>  tools/perf/arch/powerpc/util/sym-handling.c | 10 ----------
>  tools/perf/util/symbol-elf.c                |  8 +++++++-
>  3 files changed, 7 insertions(+), 30 deletions(-)
>  delete mode 100644 tools/perf/arch/arm64/util/sym-handling.c
> 
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
> index 1965aefccb02..ee788ac67415 100644
> --- a/tools/perf/util/symbol-elf.c
> +++ b/tools/perf/util/symbol-elf.c
> @@ -704,8 +704,14 @@ void symsrc__destroy(struct symsrc *ss)
>  	close(ss->fd);
>  }
>  
> -bool __weak elf__needs_adjust_symbols(GElf_Ehdr ehdr)
> +bool elf__needs_adjust_symbols(GElf_Ehdr ehdr)
>  {
> +	if (ehdr.e_machine == EM_AARCH64 ||
> +	    ehdr.e_machine == EM_PPC ||
> +	    ehdr.e_machine == EM_PPC64)
> +		return ehdr.e_type == ET_EXEC || ehdr.e_type == ET_REL ||
> +		       ehdr.e_type == ET_DYN;
> +
>  	return ehdr.e_type == ET_EXEC || ehdr.e_type == ET_REL;
>  }
>  
> -- 
> 2.17.1
> 
