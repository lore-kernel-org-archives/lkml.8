Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 867B1C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 11:41:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5229220848
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 11:41:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f4TdTEpo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbgCFLl4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 06:41:56 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:42476 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725827AbgCFLlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 06:41:55 -0500
Received: by mail-qv1-f67.google.com with SMTP id e7so751285qvy.9
        for <linux-kernel@vger.kernel.org>; Fri, 06 Mar 2020 03:41:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NxKBglN22dxNeygeTAxLcXn70pOsnpKuHcHrm+HOXS4=;
        b=f4TdTEpofdf/2ZhSeCexl/iFfw79+DOE6XZm/BV115MC/FAmDH5g4OopX4WW6gXbbU
         HAbg+Xg4OG/axW6Zpcxv0+1Migl2xAyL1doYo9wBf9Jf6uoUme7QHQl3geptKDq84aoH
         kxQhq6vwkuKyErWZeydbeCfhXsYRFi19CBTX63ixueM9S/2dkf3ZOfArJaQ/R+fzlI4B
         XWSvocQGNP2rZEXC+1eRXGHQfIvUSur5+dfYIHCMEmRn5XpeN4fyd+8Yx2jXV/dFUTuM
         ATkw0Vb7c2F4Wm/eVZmD+FCUopOOOc31C+47wd19gbeEZmn1CBK4A3BAWzT7tJGhL1pc
         J56A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NxKBglN22dxNeygeTAxLcXn70pOsnpKuHcHrm+HOXS4=;
        b=dcbqogyR0ex/RfdlMrxtBSG//e1B+DRuMQ+vgyNpPJa0xmIuCE52UgPy4xSCMlsmRA
         GaZXVv4FQ4cWRMFI4oyXyPbEqGtGQTlrp3NSaGfY3UuLICvfhVfY20nP+v/sC/Nfq4vy
         rpG8F3HxES3LFCI/hG6s4RJRCvRzXbuwmL+ezgnzbA88JOW5YZzT7zVXITuC1YCByjbg
         QQqvUBD+PTieuA/ODDCUW4Zkm99d0BsxT83GGDmI7vZTrqbAs0jQ4eYmq26zriRMp7Jo
         PnTwEonAYr66xL2UE36DKlVseg8PdUQTBHZfr4kErcOnABFlrfj7iS6PmHYhn9piRvBY
         KxMg==
X-Gm-Message-State: ANhLgQ3O1ywndP++IOqoNaOihGCB7ggPDOk8Mi6zyLKwdTM5ryh82JDO
        0vxlyqPXxo7x7DaOpmgn6uM=
X-Google-Smtp-Source: ADFU+vsSBfZwmC6RdldjGVXTQOMPY1BHHLCMUmbgDAtKOuyhIfo871ohAGEADWE4TbfxYL8Ie7/e5A==
X-Received: by 2002:ad4:4f94:: with SMTP id em20mr2340647qvb.41.1583494914199;
        Fri, 06 Mar 2020 03:41:54 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id y25sm4299070qki.33.2020.03.06.03.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2020 03:41:53 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id BE0C1403AD; Fri,  6 Mar 2020 08:41:51 -0300 (-03)
Date:   Fri, 6 Mar 2020 08:41:51 -0300
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Igor Lubashev <ilubashe@akamai.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wei Li <liwei391@huawei.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH 1/3] tools: fix off-by 1 relative directory includes
Message-ID: <20200306114151.GC27494@kernel.org>
References: <20200306071110.130202-1-irogers@google.com>
 <20200306071110.130202-2-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200306071110.130202-2-irogers@google.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Mar 05, 2020 at 11:11:08PM -0800, Ian Rogers escreveu:
> This is currently working due to extra include paths in the build.

Thanks, applied and added this to the cset commit log:

    Committer testing:
    
      $ cd tools/include/uapi/asm/
    
    Before this patch:
    
      $ ls -la ../../arch/x86/include/uapi/asm/errno.h
      ls: cannot access '../../arch/x86/include/uapi/asm/errno.h': No such file or directory
      $
    
    After this patch;
    
      $ ls -la ../../../arch/x86/include/uapi/asm/errno.h
      -rw-rw-r--. 1 acme acme 31 Feb 20 12:42 ../../../arch/x86/include/uapi/asm/errno.h
      $
    
    Check that that is still under tools/, i.e. hasn't escaped into the main
    kernel sources:
    
      $ cd ../../../arch/x86/include/uapi/asm/
      $ pwd
      /home/acme/git/perf/tools/arch/x86/include/uapi/asm
      $
    
    Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>

 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/include/uapi/asm/errno.h           | 14 +++++------
>  tools/perf/arch/arm64/util/arm-spe.c     | 20 ++++++++--------
>  tools/perf/arch/arm64/util/perf_regs.c   |  2 +-
>  tools/perf/arch/powerpc/util/perf_regs.c |  4 ++--
>  tools/perf/arch/x86/util/auxtrace.c      | 14 +++++------
>  tools/perf/arch/x86/util/event.c         | 12 +++++-----
>  tools/perf/arch/x86/util/header.c        |  4 ++--
>  tools/perf/arch/x86/util/intel-bts.c     | 24 +++++++++----------
>  tools/perf/arch/x86/util/intel-pt.c      | 30 ++++++++++++------------
>  tools/perf/arch/x86/util/machine.c       |  6 ++---
>  tools/perf/arch/x86/util/perf_regs.c     |  8 +++----
>  tools/perf/arch/x86/util/pmu.c           |  6 ++---
>  12 files changed, 72 insertions(+), 72 deletions(-)
> 
> diff --git a/tools/include/uapi/asm/errno.h b/tools/include/uapi/asm/errno.h
> index ce3c5945a1c4..637189ec1ab9 100644
> --- a/tools/include/uapi/asm/errno.h
> +++ b/tools/include/uapi/asm/errno.h
> @@ -1,18 +1,18 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
>  #if defined(__i386__) || defined(__x86_64__)
> -#include "../../arch/x86/include/uapi/asm/errno.h"
> +#include "../../../arch/x86/include/uapi/asm/errno.h"
>  #elif defined(__powerpc__)
> -#include "../../arch/powerpc/include/uapi/asm/errno.h"
> +#include "../../../arch/powerpc/include/uapi/asm/errno.h"
>  #elif defined(__sparc__)
> -#include "../../arch/sparc/include/uapi/asm/errno.h"
> +#include "../../../arch/sparc/include/uapi/asm/errno.h"
>  #elif defined(__alpha__)
> -#include "../../arch/alpha/include/uapi/asm/errno.h"
> +#include "../../../arch/alpha/include/uapi/asm/errno.h"
>  #elif defined(__mips__)
> -#include "../../arch/mips/include/uapi/asm/errno.h"
> +#include "../../../arch/mips/include/uapi/asm/errno.h"
>  #elif defined(__ia64__)
> -#include "../../arch/ia64/include/uapi/asm/errno.h"
> +#include "../../../arch/ia64/include/uapi/asm/errno.h"
>  #elif defined(__xtensa__)
> -#include "../../arch/xtensa/include/uapi/asm/errno.h"
> +#include "../../../arch/xtensa/include/uapi/asm/errno.h"
>  #else
>  #include <asm-generic/errno.h>
>  #endif
> diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/arm64/util/arm-spe.c
> index 8d6821d9c3f6..27653be24447 100644
> --- a/tools/perf/arch/arm64/util/arm-spe.c
> +++ b/tools/perf/arch/arm64/util/arm-spe.c
> @@ -11,17 +11,17 @@
>  #include <linux/zalloc.h>
>  #include <time.h>
>  
> -#include "../../util/cpumap.h"
> -#include "../../util/event.h"
> -#include "../../util/evsel.h"
> -#include "../../util/evlist.h"
> -#include "../../util/session.h"
> +#include "../../../util/cpumap.h"
> +#include "../../../util/event.h"
> +#include "../../../util/evsel.h"
> +#include "../../../util/evlist.h"
> +#include "../../../util/session.h"
>  #include <internal/lib.h> // page_size
> -#include "../../util/pmu.h"
> -#include "../../util/debug.h"
> -#include "../../util/auxtrace.h"
> -#include "../../util/record.h"
> -#include "../../util/arm-spe.h"
> +#include "../../../util/pmu.h"
> +#include "../../../util/debug.h"
> +#include "../../../util/auxtrace.h"
> +#include "../../../util/record.h"
> +#include "../../../util/arm-spe.h"
>  
>  #define KiB(x) ((x) * 1024)
>  #define MiB(x) ((x) * 1024 * 1024)
> diff --git a/tools/perf/arch/arm64/util/perf_regs.c b/tools/perf/arch/arm64/util/perf_regs.c
> index 2864e2e3776d..2833e101a7c6 100644
> --- a/tools/perf/arch/arm64/util/perf_regs.c
> +++ b/tools/perf/arch/arm64/util/perf_regs.c
> @@ -1,5 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0
> -#include "../../util/perf_regs.h"
> +#include "../../../util/perf_regs.h"
>  
>  const struct sample_reg sample_reg_masks[] = {
>  	SMPL_REG_END
> diff --git a/tools/perf/arch/powerpc/util/perf_regs.c b/tools/perf/arch/powerpc/util/perf_regs.c
> index e9c436eeffc9..0a5242900248 100644
> --- a/tools/perf/arch/powerpc/util/perf_regs.c
> +++ b/tools/perf/arch/powerpc/util/perf_regs.c
> @@ -4,8 +4,8 @@
>  #include <regex.h>
>  #include <linux/zalloc.h>
>  
> -#include "../../util/perf_regs.h"
> -#include "../../util/debug.h"
> +#include "../../../util/perf_regs.h"
> +#include "../../../util/debug.h"
>  
>  #include <linux/kernel.h>
>  
> diff --git a/tools/perf/arch/x86/util/auxtrace.c b/tools/perf/arch/x86/util/auxtrace.c
> index 7abc9fd4cbec..3da506e13f49 100644
> --- a/tools/perf/arch/x86/util/auxtrace.c
> +++ b/tools/perf/arch/x86/util/auxtrace.c
> @@ -7,13 +7,13 @@
>  #include <errno.h>
>  #include <stdbool.h>
>  
> -#include "../../util/header.h"
> -#include "../../util/debug.h"
> -#include "../../util/pmu.h"
> -#include "../../util/auxtrace.h"
> -#include "../../util/intel-pt.h"
> -#include "../../util/intel-bts.h"
> -#include "../../util/evlist.h"
> +#include "../../../util/header.h"
> +#include "../../../util/debug.h"
> +#include "../../../util/pmu.h"
> +#include "../../../util/auxtrace.h"
> +#include "../../../util/intel-pt.h"
> +#include "../../../util/intel-bts.h"
> +#include "../../../util/evlist.h"
>  
>  static
>  struct auxtrace_record *auxtrace_record__init_intel(struct evlist *evlist,
> diff --git a/tools/perf/arch/x86/util/event.c b/tools/perf/arch/x86/util/event.c
> index ac45015cc6ba..047dc00eafa6 100644
> --- a/tools/perf/arch/x86/util/event.c
> +++ b/tools/perf/arch/x86/util/event.c
> @@ -3,12 +3,12 @@
>  #include <linux/string.h>
>  #include <linux/zalloc.h>
>  
> -#include "../../util/event.h"
> -#include "../../util/synthetic-events.h"
> -#include "../../util/machine.h"
> -#include "../../util/tool.h"
> -#include "../../util/map.h"
> -#include "../../util/debug.h"
> +#include "../../../util/event.h"
> +#include "../../../util/synthetic-events.h"
> +#include "../../../util/machine.h"
> +#include "../../../util/tool.h"
> +#include "../../../util/map.h"
> +#include "../../../util/debug.h"
>  
>  #if defined(__x86_64__)
>  
> diff --git a/tools/perf/arch/x86/util/header.c b/tools/perf/arch/x86/util/header.c
> index aa6deb463bf3..578c8c568ffd 100644
> --- a/tools/perf/arch/x86/util/header.c
> +++ b/tools/perf/arch/x86/util/header.c
> @@ -7,8 +7,8 @@
>  #include <string.h>
>  #include <regex.h>
>  
> -#include "../../util/debug.h"
> -#include "../../util/header.h"
> +#include "../../../util/debug.h"
> +#include "../../../util/header.h"
>  
>  static inline void
>  cpuid(unsigned int op, unsigned int *a, unsigned int *b, unsigned int *c,
> diff --git a/tools/perf/arch/x86/util/intel-bts.c b/tools/perf/arch/x86/util/intel-bts.c
> index 26cee1052179..09f93800bffd 100644
> --- a/tools/perf/arch/x86/util/intel-bts.c
> +++ b/tools/perf/arch/x86/util/intel-bts.c
> @@ -11,18 +11,18 @@
>  #include <linux/log2.h>
>  #include <linux/zalloc.h>
>  
> -#include "../../util/cpumap.h"
> -#include "../../util/event.h"
> -#include "../../util/evsel.h"
> -#include "../../util/evlist.h"
> -#include "../../util/mmap.h"
> -#include "../../util/session.h"
> -#include "../../util/pmu.h"
> -#include "../../util/debug.h"
> -#include "../../util/record.h"
> -#include "../../util/tsc.h"
> -#include "../../util/auxtrace.h"
> -#include "../../util/intel-bts.h"
> +#include "../../../util/cpumap.h"
> +#include "../../../util/event.h"
> +#include "../../../util/evsel.h"
> +#include "../../../util/evlist.h"
> +#include "../../../util/mmap.h"
> +#include "../../../util/session.h"
> +#include "../../../util/pmu.h"
> +#include "../../../util/debug.h"
> +#include "../../../util/record.h"
> +#include "../../../util/tsc.h"
> +#include "../../../util/auxtrace.h"
> +#include "../../../util/intel-bts.h"
>  #include <internal/lib.h> // page_size
>  
>  #define KiB(x) ((x) * 1024)
> diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
> index 7eea4fd7ce58..1643aed8c4c8 100644
> --- a/tools/perf/arch/x86/util/intel-pt.c
> +++ b/tools/perf/arch/x86/util/intel-pt.c
> @@ -13,23 +13,23 @@
>  #include <linux/zalloc.h>
>  #include <cpuid.h>
>  
> -#include "../../util/session.h"
> -#include "../../util/event.h"
> -#include "../../util/evlist.h"
> -#include "../../util/evsel.h"
> -#include "../../util/evsel_config.h"
> -#include "../../util/cpumap.h"
> -#include "../../util/mmap.h"
> +#include "../../../util/session.h"
> +#include "../../../util/event.h"
> +#include "../../../util/evlist.h"
> +#include "../../../util/evsel.h"
> +#include "../../../util/evsel_config.h"
> +#include "../../../util/cpumap.h"
> +#include "../../../util/mmap.h"
>  #include <subcmd/parse-options.h>
> -#include "../../util/parse-events.h"
> -#include "../../util/pmu.h"
> -#include "../../util/debug.h"
> -#include "../../util/auxtrace.h"
> -#include "../../util/record.h"
> -#include "../../util/target.h"
> -#include "../../util/tsc.h"
> +#include "../../../util/parse-events.h"
> +#include "../../../util/pmu.h"
> +#include "../../../util/debug.h"
> +#include "../../../util/auxtrace.h"
> +#include "../../../util/record.h"
> +#include "../../../util/target.h"
> +#include "../../../util/tsc.h"
>  #include <internal/lib.h> // page_size
> -#include "../../util/intel-pt.h"
> +#include "../../../util/intel-pt.h"
>  
>  #define KiB(x) ((x) * 1024)
>  #define MiB(x) ((x) * 1024 * 1024)
> diff --git a/tools/perf/arch/x86/util/machine.c b/tools/perf/arch/x86/util/machine.c
> index e17e080e76f4..31679c35d493 100644
> --- a/tools/perf/arch/x86/util/machine.c
> +++ b/tools/perf/arch/x86/util/machine.c
> @@ -5,9 +5,9 @@
>  #include <stdlib.h>
>  
>  #include <internal/lib.h> // page_size
> -#include "../../util/machine.h"
> -#include "../../util/map.h"
> -#include "../../util/symbol.h"
> +#include "../../../util/machine.h"
> +#include "../../../util/map.h"
> +#include "../../../util/symbol.h"
>  #include <linux/ctype.h>
>  
>  #include <symbol/kallsyms.h>
> diff --git a/tools/perf/arch/x86/util/perf_regs.c b/tools/perf/arch/x86/util/perf_regs.c
> index c218b83e063b..fca81b39b09f 100644
> --- a/tools/perf/arch/x86/util/perf_regs.c
> +++ b/tools/perf/arch/x86/util/perf_regs.c
> @@ -5,10 +5,10 @@
>  #include <linux/kernel.h>
>  #include <linux/zalloc.h>
>  
> -#include "../../perf-sys.h"
> -#include "../../util/perf_regs.h"
> -#include "../../util/debug.h"
> -#include "../../util/event.h"
> +#include "../../../perf-sys.h"
> +#include "../../../util/perf_regs.h"
> +#include "../../../util/debug.h"
> +#include "../../../util/event.h"
>  
>  const struct sample_reg sample_reg_masks[] = {
>  	SMPL_REG(AX, PERF_REG_X86_AX),
> diff --git a/tools/perf/arch/x86/util/pmu.c b/tools/perf/arch/x86/util/pmu.c
> index e33ef5bc31c5..d48d608517fd 100644
> --- a/tools/perf/arch/x86/util/pmu.c
> +++ b/tools/perf/arch/x86/util/pmu.c
> @@ -4,9 +4,9 @@
>  #include <linux/stddef.h>
>  #include <linux/perf_event.h>
>  
> -#include "../../util/intel-pt.h"
> -#include "../../util/intel-bts.h"
> -#include "../../util/pmu.h"
> +#include "../../../util/intel-pt.h"
> +#include "../../../util/intel-bts.h"
> +#include "../../../util/pmu.h"
>  
>  struct perf_event_attr *perf_pmu__get_default_config(struct perf_pmu *pmu __maybe_unused)
>  {
> -- 
> 2.25.1.481.gfbce0eb801-goog
> 

-- 

- Arnaldo
