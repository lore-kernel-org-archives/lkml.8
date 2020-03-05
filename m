Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D719C3F2CD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 11:02:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0510D2073B
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 11:02:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727349AbgCELCn convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 06:02:43 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:30212 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725903AbgCELCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 06:02:42 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 025Apfa6103254
        for <linux-kernel@vger.kernel.org>; Thu, 5 Mar 2020 06:02:41 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2yhr4k3x9x-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 06:02:40 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <naveen.n.rao@linux.vnet.ibm.com>;
        Thu, 5 Mar 2020 11:02:38 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 5 Mar 2020 11:02:32 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 025B2WdM58720390
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 5 Mar 2020 11:02:32 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E96F04203F;
        Thu,  5 Mar 2020 11:02:31 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8822742045;
        Thu,  5 Mar 2020 11:02:31 +0000 (GMT)
Received: from localhost (unknown [9.199.53.44])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  5 Mar 2020 11:02:31 +0000 (GMT)
Date:   Thu, 05 Mar 2020 16:32:30 +0530
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH v2] perf symbols: Consolidate symbol fixup issue
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Allison Randal <allison@lohutok.net>,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Enrico Weigelt <info@metux.net>,
        John Garry <john.garry@huawei.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thomas Richter <tmricht@linux.vnet.ibm.com>
Cc:     Jiri Olsa <jolsa@redhat.com>
References: <20200303110407.28162-1-leo.yan@linaro.org>
In-Reply-To: <20200303110407.28162-1-leo.yan@linaro.org>
MIME-Version: 1.0
User-Agent: astroid/v0.15-13-gb675b421
 (https://github.com/astroidmail/astroid)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT
X-TM-AS-GCONF: 00
x-cbid: 20030511-0008-0000-0000-00000359903A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20030511-0009-0000-0000-00004A7AC710
Message-Id: <1583405831.eapbxpc3ni.naveen@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-05_03:2020-03-05,2020-03-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 mlxscore=0 phishscore=0 mlxlogscore=999 suspectscore=0 lowpriorityscore=0
 impostorscore=0 bulkscore=0 spamscore=0 adultscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003050069
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Leo Yan wrote:
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

I am not able to reproduce this since powerpc64 kernels are not being 
built as ET_EXEC anymore.

> v2: Fixed Arm64 and powerpc native building.
> 
> Reported-by: Mike Leach <mike.leach@linaro.org>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  tools/perf/arch/arm64/util/Build            |  1 -
>  tools/perf/arch/arm64/util/sym-handling.c   | 19 -------------------
>  tools/perf/arch/powerpc/util/Build          |  1 -
>  tools/perf/arch/powerpc/util/sym-handling.c | 10 ----------
>  tools/perf/util/symbol-elf.c                |  8 +++++++-
>  5 files changed, 7 insertions(+), 32 deletions(-)
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

Patch looks good to me. However:

This is only used for checking kernel, so I wonder if we can simply 
include check for ET_DYN across all architectures? This would only 
matter if there are architectures building their kernel as ET_DYN that 
_don't_ want to adjust symbols.


- Naveen

