Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12A72C3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 12:07:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAE8B2073D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 12:07:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n+VKsdoJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbgCEMH5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 07:07:57 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44823 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgCEMH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 07:07:57 -0500
Received: by mail-pl1-f196.google.com with SMTP id d9so2548708plo.11
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 04:07:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UIbbEs41/Nl1YQgpb4EpsfEdoNW0JqlObDtghuhl7Fc=;
        b=n+VKsdoJb3+cZXqIxeIftUjiy1LsU8jHX48aYN4biT6csja2fMfMKMjk4FLUCsCnLB
         lvTg3ezPMaE+jE0AQBca9yUJzsbNnHnjenD4WJM9za8dejz17kBICftjrk6E/TsWSCe7
         ISF4T7ERPKwt2lRAsMkjwJqiWE/+WsRZmYON9XzR/EFevnQI7CsFc5DbORYHX6yxHXWm
         R+PSF+gHosab4EY+1OgWPKCfuEVAG//aYDqgyneN1ijh4yr+lfs4jXv4/8wtb/c0FeOk
         Nn/E0RN6/ezG+5JCaTypwvBsymCf4PwkSSCxY+gAc+M21G/uz7l3y6iICDywTJSp+Fhj
         6KLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UIbbEs41/Nl1YQgpb4EpsfEdoNW0JqlObDtghuhl7Fc=;
        b=eZmL3NBEYk/p8ihBBddPF4tDN1n2oX9y9LM4dxOI40I/T8G7Fok5pHOxW6Mshd+c/E
         h69dPg5n/aii/Kt1pghLJsRL09nBZfoXKXtyrrF0XGsWXhHsyrQJSdSJG7KxqBricpDI
         7hw6jJGCwDounVmfUOaKm6UQFgfFOYhZWxdGna5xlDVpSI9yZRyIZtJEMHg5Qkvvv5SJ
         ta9Wsra8KFR7dtZ2hULcAW7/nYhz3T3kBFL60dW/W1ubFwN+5jIapEUz5qL5XUlJXEbc
         k/RW++0VI8HPiJn5u2oIC2wy9p6GLsb5clFB9bOXK9kLdCzmxSMj9Ae2f8oCyYZydESj
         ppzw==
X-Gm-Message-State: ANhLgQ24eXk4PabXUpMptogWzWtO8+6jSe2HLmDKOy6y/eiIzH93GkuW
        JEfzpZVTILJmQnO/baICKRjW2Q==
X-Google-Smtp-Source: ADFU+vsc0FgLo79rXR3ZnZVbcftrNzKPKMzQZdMFRytebzjV9tfFDF+K0S5XzKqug3YC5FAJPSK7VA==
X-Received: by 2002:a17:902:c154:: with SMTP id 20mr7912464plj.112.1583410075977;
        Thu, 05 Mar 2020 04:07:55 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([2400:8902::f03c:91ff:fe3f:ee42])
        by smtp.gmail.com with ESMTPSA id y1sm28801517pgs.74.2020.03.05.04.07.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 05 Mar 2020 04:07:55 -0800 (PST)
Date:   Thu, 5 Mar 2020 20:07:38 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Allison Randal <allison@lohutok.net>,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Enrico Weigelt <info@metux.net>,
        John Garry <john.garry@huawei.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thomas Richter <tmricht@linux.vnet.ibm.com>
Subject: Re: [PATCH v2] perf symbols: Consolidate symbol fixup issue
Message-ID: <20200305120738.GA31049@leoy-ThinkPad-X240s>
References: <20200303110407.28162-1-leo.yan@linaro.org>
 <1583405831.eapbxpc3ni.naveen@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1583405831.eapbxpc3ni.naveen@linux.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Naveen,

On Thu, Mar 05, 2020 at 04:32:30PM +0530, Naveen N. Rao wrote:
> Leo Yan wrote:
> > After copying Arm64's perf archive with object files and perf.data file
> > to x86 laptop, the x86's perf kernel symbol resolution fails.  It
> > outputs 'unknown' for all symbols parsing.
> > 
> > This issue is root caused by the function elf__needs_adjust_symbols(),
> > x86 perf tool uses one weak version, Arm64 (and powerpc) has rewritten
> > their own version.  elf__needs_adjust_symbols() decides if need to parse
> > symbols with the relative offset address; but x86 building uses the weak
> > function which misses to check for the elf type 'ET_DYN', so that it
> > cannot parse symbols in Arm DSOs due to the wrong result from
> > elf__needs_adjust_symbols().
> > 
> > The DSO parsing should not depend on any specific architecture perf
> > building; e.g. x86 perf tool can parse Arm and Arm64 DSOs, vice versa.
> > So this patch changes elf__needs_adjust_symbols() as a common function
> > and removes the arch specific functions for Arm64 and powerpc.
> > 
> > In the common elf__needs_adjust_symbols(), it checks elf header and if
> > the machine type is one of Arm64/ppc/ppc64, it checks extra condition
> > for 'ET_DYN'.  Finally, the Arm64 DSO can be parsed properly with x86's
> > perf tool.
> > 
> > Before:
> > 
> >   # perf script
> >   main  3258          1          branches:                 0 [unknown] ([unknown]) => ffff800010c4665c [unknown] ([kernel.kallsyms])
> >   main  3258          1          branches:  ffff800010c46670 [unknown] ([kernel.kallsyms]) => ffff800010c4eaec [unknown] ([kernel.kallsyms])
> >   main  3258          1          branches:  ffff800010c4eaec [unknown] ([kernel.kallsyms]) => ffff800010c4eb00 [unknown] ([kernel.kallsyms])
> >   main  3258          1          branches:  ffff800010c4eb08 [unknown] ([kernel.kallsyms]) => ffff800010c4e780 [unknown] ([kernel.kallsyms])
> >   main  3258          1          branches:  ffff800010c4e7a0 [unknown] ([kernel.kallsyms]) => ffff800010c4eeac [unknown] ([kernel.kallsyms])
> >   main  3258          1          branches:  ffff800010c4eebc [unknown] ([kernel.kallsyms]) => ffff800010c4ed80 [unknown] ([kernel.kallsyms])
> > 
> > After:
> > 
> >   # perf script
> >   main  3258          1          branches:                 0 [unknown] ([unknown]) => ffff800010c4665c coresight_timeout+0x54 ([kernel.kallsyms])
> >   main  3258          1          branches:  ffff800010c46670 coresight_timeout+0x68 ([kernel.kallsyms]) => ffff800010c4eaec etm4_enable_hw+0x3cc ([kernel.kallsyms])
> >   main  3258          1          branches:  ffff800010c4eaec etm4_enable_hw+0x3cc ([kernel.kallsyms]) => ffff800010c4eb00 etm4_enable_hw+0x3e0 ([kernel.kallsyms])
> >   main  3258          1          branches:  ffff800010c4eb08 etm4_enable_hw+0x3e8 ([kernel.kallsyms]) => ffff800010c4e780 etm4_enable_hw+0x60 ([kernel.kallsyms])
> >   main  3258          1          branches:  ffff800010c4e7a0 etm4_enable_hw+0x80 ([kernel.kallsyms]) => ffff800010c4eeac etm4_enable+0x2d4 ([kernel.kallsyms])
> >   main  3258          1          branches:  ffff800010c4eebc etm4_enable+0x2e4 ([kernel.kallsyms]) => ffff800010c4ed80 etm4_enable+0x1a8 ([kernel.kallsyms])
> > 
> 
> I am not able to reproduce this since powerpc64 kernels are not being built
> as ET_EXEC anymore.

Thanks for reviewing!

Based on the context, I think you mean powerpc64 kernels are not being
built as ET_DYN anymore (and now change to ET_EXEC).

> > v2: Fixed Arm64 and powerpc native building.
> > 
> > Reported-by: Mike Leach <mike.leach@linaro.org>
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > ---
> >  tools/perf/arch/arm64/util/Build            |  1 -
> >  tools/perf/arch/arm64/util/sym-handling.c   | 19 -------------------
> >  tools/perf/arch/powerpc/util/Build          |  1 -
> >  tools/perf/arch/powerpc/util/sym-handling.c | 10 ----------
> >  tools/perf/util/symbol-elf.c                |  8 +++++++-
> >  5 files changed, 7 insertions(+), 32 deletions(-)
> >  delete mode 100644 tools/perf/arch/arm64/util/sym-handling.c
> > 
> > diff --git a/tools/perf/arch/arm64/util/Build b/tools/perf/arch/arm64/util/Build
> > index 0a7782c61209..789956f76d85 100644
> > --- a/tools/perf/arch/arm64/util/Build
> > +++ b/tools/perf/arch/arm64/util/Build
> > @@ -1,6 +1,5 @@
> >  perf-y += header.o
> >  perf-y += perf_regs.o
> > -perf-y += sym-handling.o
> >  perf-$(CONFIG_DWARF)     += dwarf-regs.o
> >  perf-$(CONFIG_LOCAL_LIBUNWIND) += unwind-libunwind.o
> >  perf-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
> > diff --git a/tools/perf/arch/arm64/util/sym-handling.c b/tools/perf/arch/arm64/util/sym-handling.c
> > deleted file mode 100644
> > index 8dfa3e5229f1..000000000000
> > --- a/tools/perf/arch/arm64/util/sym-handling.c
> > +++ /dev/null
> > @@ -1,19 +0,0 @@
> > -// SPDX-License-Identifier: GPL-2.0-only
> > -/*
> > - *
> > - * Copyright (C) 2015 Naveen N. Rao, IBM Corporation
> > - */
> > -
> > -#include "symbol.h" // for the elf__needs_adjust_symbols() prototype
> > -#include <stdbool.h>
> > -
> > -#ifdef HAVE_LIBELF_SUPPORT
> > -#include <gelf.h>
> > -
> > -bool elf__needs_adjust_symbols(GElf_Ehdr ehdr)
> > -{
> > -	return ehdr.e_type == ET_EXEC ||
> > -	       ehdr.e_type == ET_REL ||
> > -	       ehdr.e_type == ET_DYN;
> > -}
> > -#endif
> > diff --git a/tools/perf/arch/powerpc/util/Build b/tools/perf/arch/powerpc/util/Build
> > index 7cf0b8803097..e5c9504f8586 100644
> > --- a/tools/perf/arch/powerpc/util/Build
> > +++ b/tools/perf/arch/powerpc/util/Build
> > @@ -1,5 +1,4 @@
> >  perf-y += header.o
> > -perf-y += sym-handling.o
> >  perf-y += kvm-stat.o
> >  perf-y += perf_regs.o
> >  perf-y += mem-events.o
> > diff --git a/tools/perf/arch/powerpc/util/sym-handling.c b/tools/perf/arch/powerpc/util/sym-handling.c
> > index abb7a12d8f93..0856b32f9e08 100644
> > --- a/tools/perf/arch/powerpc/util/sym-handling.c
> > +++ b/tools/perf/arch/powerpc/util/sym-handling.c
> > @@ -10,16 +10,6 @@
> >  #include "probe-event.h"
> >  #include "probe-file.h"
> > 
> > -#ifdef HAVE_LIBELF_SUPPORT
> > -bool elf__needs_adjust_symbols(GElf_Ehdr ehdr)
> > -{
> > -	return ehdr.e_type == ET_EXEC ||
> > -	       ehdr.e_type == ET_REL ||
> > -	       ehdr.e_type == ET_DYN;
> > -}
> > -
> > -#endif
> > -
> >  int arch__choose_best_symbol(struct symbol *syma,
> >  			     struct symbol *symb __maybe_unused)
> >  {
> > diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
> > index 1965aefccb02..ee788ac67415 100644
> > --- a/tools/perf/util/symbol-elf.c
> > +++ b/tools/perf/util/symbol-elf.c
> > @@ -704,8 +704,14 @@ void symsrc__destroy(struct symsrc *ss)
> >  	close(ss->fd);
> >  }
> > 
> > -bool __weak elf__needs_adjust_symbols(GElf_Ehdr ehdr)
> > +bool elf__needs_adjust_symbols(GElf_Ehdr ehdr)
> >  {
> > +	if (ehdr.e_machine == EM_AARCH64 ||
> > +	    ehdr.e_machine == EM_PPC ||
> > +	    ehdr.e_machine == EM_PPC64)
> > +		return ehdr.e_type == ET_EXEC || ehdr.e_type == ET_REL ||
> > +		       ehdr.e_type == ET_DYN;
> > +
> >  	return ehdr.e_type == ET_EXEC || ehdr.e_type == ET_REL;
> 
> Patch looks good to me. However:

Can I add your review tag?

> This is only used for checking kernel, so I wonder if we can simply include
> check for ET_DYN across all architectures? This would only matter if there
> are architectures building their kernel as ET_DYN that _don't_ want to
> adjust symbols.

Seems only Arm64 enables the link option '-share' for LDFLAGS_vmlinux;
I confirmed with below command:

$ find arch -name 'Makefile' -exec grep -n '\-share' {} + | grep vmlinux
arch/arm64/Makefile:21:LDFLAGS_vmlinux          += -shared -Bsymbolic -z notext -z norelro \

Also reviewed the output for searching '\-share' for all Makefiles under
'arch' folder, many architectures use it for vdso but only Arm64 enables
'-share' for vmlinux linkage.  If so, your suggestion is valid and we
can simply include check for ET_DYN for all archs (and it's better to
add comment for this).

I'd like to wait a bit for anyone has other ideas, and if no objection
will send out new patch for this.

Thanks,
Leo
