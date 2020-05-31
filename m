Return-Path: <SRS0=AKQz=7N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D3F0C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 14:29:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC9152076B
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 14:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590935388;
	bh=x1CI4au0sWB36RSop+IPudYdUNyE0X/FWAvMAMQB2Ks=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=t+4RHt8cJTFsMK0xLBSMvHuC5cxO7FGJzGhIidsqcrzDoYC8B1nZUV8jOwjrMwHtB
	 Icq5gFMYoOIIfg2ShFKIexzs4cnvqrgEeNYn/+Y6AySz7pW2sem7gsq45oBDTIxuTT
	 jGQFrg3Gr4j6Z1lAAuIdbYG3FOuDitXFsqkAWajc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728216AbgEaO3r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 May 2020 10:29:47 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33921 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728145AbgEaO3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 10:29:46 -0400
Received: by mail-wr1-f68.google.com with SMTP id r7so8944991wro.1
        for <linux-kernel@vger.kernel.org>; Sun, 31 May 2020 07:29:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=po3dwygBk16goumRcE7NQvw4S9OPemwbeUTm4OkCx3Y=;
        b=Ax4jQ7C/YFeRLUuH9hiSAB0CFPkWwX2i2mWGsxIaMi7fExWixr0q44Nsf7myROkE87
         c7HLmkCVttXobmpD2TNBgtFo97ogV3P7tugh1zessJA0qt//jkwPlclkx5AJu1r1IqSq
         4vb3npWRiGKg8SO8V4y26l8AsGaZTCffZbpRMOpCiZ6FSCgKY6xKjUcuHcmQ3sBFGvw4
         zyNI14Gm/ye9y7Iz3G4Zw5TrtgQ8q8ZlniqJF1miRDocmSyEsp1QwQd9NUfW8CHKlw79
         wVyaXBfxIIPEUhZcu842y4bxWsHv6KHYVwJcqKr/LOS7SFPJhU9UYfFILnXW+EbdpV5f
         Fc1Q==
X-Gm-Message-State: AOAM530KlyhJMKq/qZgV0C/m/PIuOMedo14wA2XyJJii4gD/2TTinrwx
        Kkc6OvbTchEw6DLxGdj8I+sjqRgRPC2J+z0Wvds=
X-Google-Smtp-Source: ABdhPJwYIt4gm3Rn32+45gaVsRPmA35WtIS/UqsGhl+5/4dlIcdWIu+v5ELyoSbZw+6HbSFQRBq8bMIu6+3JqpMG2bw=
X-Received: by 2002:a05:6000:104f:: with SMTP id c15mr10902762wrx.391.1590935384694;
 Sun, 31 May 2020 07:29:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200529225232.207532-1-irogers@google.com>
In-Reply-To: <20200529225232.207532-1-irogers@google.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Sun, 31 May 2020 23:29:33 +0900
Message-ID: <CAM9d7chrW-zfq-9cjBq_n3ESpYv4jtbeDZFWy+DoEzyA2whrqQ@mail.gmail.com>
Subject: Re: [PATCH] perf libdw: Fix off-by 1 relative directory includes
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ian,

On Sat, May 30, 2020 at 7:53 AM Ian Rogers <irogers@google.com> wrote:
>
> This is currently working due to extra include paths in the build.
>
> Before:
> $ cd tools/perf/arch/arm64/util
> $ ls -la ../../util/unwind-libdw.h
> ls: cannot access '../../util/unwind-libdw.h': No such file or directory
>
> After:
> $ ls -la ../../../util/unwind-libdw.h
> -rw-r----- 1 irogers irogers 553 Apr 17 14:31 ../../../util/unwind-libdw.h

Missing sign-off, but otherwise looks good to me

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks
Namhyung


> ---
>  tools/perf/arch/arm64/util/unwind-libdw.c   | 6 +++---
>  tools/perf/arch/powerpc/util/unwind-libdw.c | 6 +++---
>  tools/perf/arch/x86/util/unwind-libdw.c     | 6 +++---
>  3 files changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/tools/perf/arch/arm64/util/unwind-libdw.c b/tools/perf/arch/arm64/util/unwind-libdw.c
> index 7623d85e77f3..a50941629649 100644
> --- a/tools/perf/arch/arm64/util/unwind-libdw.c
> +++ b/tools/perf/arch/arm64/util/unwind-libdw.c
> @@ -1,8 +1,8 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include <elfutils/libdwfl.h>
> -#include "../../util/unwind-libdw.h"
> -#include "../../util/perf_regs.h"
> -#include "../../util/event.h"
> +#include "../../../util/unwind-libdw.h"
> +#include "../../../util/perf_regs.h"
> +#include "../../../util/event.h"
>
>  bool libdw__arch_set_initial_registers(Dwfl_Thread *thread, void *arg)
>  {
> diff --git a/tools/perf/arch/powerpc/util/unwind-libdw.c b/tools/perf/arch/powerpc/util/unwind-libdw.c
> index abf2dbc7f829..7b2d96ec28e3 100644
> --- a/tools/perf/arch/powerpc/util/unwind-libdw.c
> +++ b/tools/perf/arch/powerpc/util/unwind-libdw.c
> @@ -1,9 +1,9 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include <elfutils/libdwfl.h>
>  #include <linux/kernel.h>
> -#include "../../util/unwind-libdw.h"
> -#include "../../util/perf_regs.h"
> -#include "../../util/event.h"
> +#include "../../../util/unwind-libdw.h"
> +#include "../../../util/perf_regs.h"
> +#include "../../../util/event.h"
>
>  /* See backends/ppc_initreg.c and backends/ppc_regs.c in elfutils.  */
>  static const int special_regs[3][2] = {
> diff --git a/tools/perf/arch/x86/util/unwind-libdw.c b/tools/perf/arch/x86/util/unwind-libdw.c
> index fda8f4206ee4..eea2bf87232b 100644
> --- a/tools/perf/arch/x86/util/unwind-libdw.c
> +++ b/tools/perf/arch/x86/util/unwind-libdw.c
> @@ -1,8 +1,8 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include <elfutils/libdwfl.h>
> -#include "../../util/unwind-libdw.h"
> -#include "../../util/perf_regs.h"
> -#include "../../util/event.h"
> +#include "../../../util/unwind-libdw.h"
> +#include "../../../util/perf_regs.h"
> +#include "../../../util/event.h"
>
>  bool libdw__arch_set_initial_registers(Dwfl_Thread *thread, void *arg)
>  {
> --
> 2.27.0.rc2.251.g90737beb825-goog
>
