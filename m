Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C31CC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 00:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 711BB206C3
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 00:06:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Snk2c/9C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728477AbgFAAGW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 May 2020 20:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727098AbgFAAGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 20:06:22 -0400
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB685C061A0E
        for <linux-kernel@vger.kernel.org>; Sun, 31 May 2020 17:06:20 -0700 (PDT)
Received: by mail-yb1-xb42.google.com with SMTP id r18so1813551ybl.5
        for <linux-kernel@vger.kernel.org>; Sun, 31 May 2020 17:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WP0VwW6HlOyyyfh6A1NTvlb2QwsaXuAwRLzhKtRoj0c=;
        b=Snk2c/9Cn5fmexkPUUiD2DU2s4qfmBQT1DmfpYX4/Z7x4s4631VyULW+3naScchO/W
         Y3VZEe6rEYL9tzqGcRYPD9ddgmFNLEIB7pJZw2qS0U8GI8HhMnI1DpERcL7nUXXiBc16
         PTYz8eAUyosbXq0y3MTHXnRbHXCyCCqT1bFyYal9wYYXd7TQ7MxCLKh7DqJay4x9w2V8
         8aubAVLKI/iDADAdoE6W4ezkLyMWYBN5La/CjsO+0BkWSTM8DftZ3l9cUmYsp1W+bSwU
         1Z96hvW5ZPzzJl49t43M6XMtZINx32q3DX3JovNIX8JX6g7vx6E4XB4v+nZXo/JefMHW
         FJCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WP0VwW6HlOyyyfh6A1NTvlb2QwsaXuAwRLzhKtRoj0c=;
        b=DD4OjOBd/EbXRJMhb7CjT+D4B0Y2LlW3SpuVRkdrJk5GvckJSFm8mtkcV6MUGMymbp
         ks+RioLzlOfj3/FKi8LoBue8N5KH0z/XjMIZmH9pwEJrPvpyJAE9z1B6AtNr8H4/EfRJ
         HYkOUgl3ZBCtLe1lC1ZSriBURJzyUmtppC/UeZ7lHsSbVtx36XHm5xd4mtmdPHrVVQv+
         JSZJnNdYJoiCcbkKPjCPrIwBVutMlklm6B2T6Q6PcLkfXcHjxOC3mU9pwnapa/1YIxlH
         3h9fOkTDGLW5al77k/P1Oly8scTLbfZx4Vd8QBlIXILvo3NgEsQuJE7W+SnUa5QzkG32
         UX1Q==
X-Gm-Message-State: AOAM532aX0Cab/BtMzmYb0Jltosr+zMxSou579exYY33JP7pUkhsvIzl
        aAIzafxLQZ106B8sAft6oCt9vIGJQhlBvEmm9Kw2vA==
X-Google-Smtp-Source: ABdhPJzNZED2TOQjXmewra1g4f+zhwRCjOfUYuwcm5cwCKv8D28gxFrw2TjlTs7NSstO9XZntwrabmFEA+0lLki0UOk=
X-Received: by 2002:a25:be81:: with SMTP id i1mr29754119ybk.184.1590969979868;
 Sun, 31 May 2020 17:06:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200529225232.207532-1-irogers@google.com> <CAM9d7chrW-zfq-9cjBq_n3ESpYv4jtbeDZFWy+DoEzyA2whrqQ@mail.gmail.com>
In-Reply-To: <CAM9d7chrW-zfq-9cjBq_n3ESpYv4jtbeDZFWy+DoEzyA2whrqQ@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Sun, 31 May 2020 17:06:08 -0700
Message-ID: <CAP-5=fWApg4XGPTJmzpN6nTdhgBF5AC4opm2HiYFkuzhLmdfPg@mail.gmail.com>
Subject: Re: [PATCH] perf libdw: Fix off-by 1 relative directory includes
To:     Namhyung Kim <namhyung@kernel.org>
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

On Sun, May 31, 2020 at 7:29 AM Namhyung Kim <namhyung@kernel.org> wrote:
>
> Hi Ian,
>
> On Sat, May 30, 2020 at 7:53 AM Ian Rogers <irogers@google.com> wrote:
> >
> > This is currently working due to extra include paths in the build.
> >
> > Before:
> > $ cd tools/perf/arch/arm64/util
> > $ ls -la ../../util/unwind-libdw.h
> > ls: cannot access '../../util/unwind-libdw.h': No such file or directory
> >
> > After:
> > $ ls -la ../../../util/unwind-libdw.h
> > -rw-r----- 1 irogers irogers 553 Apr 17 14:31 ../../../util/unwind-libdw.h
>
> Missing sign-off, but otherwise looks good to me

Doh! Thanks Namhyung.

Signed-off-by: Ian Rogers <irogers@google.com>

Ian

> Acked-by: Namhyung Kim <namhyung@kernel.org>
>
> Thanks
> Namhyung
>
>
> > ---
> >  tools/perf/arch/arm64/util/unwind-libdw.c   | 6 +++---
> >  tools/perf/arch/powerpc/util/unwind-libdw.c | 6 +++---
> >  tools/perf/arch/x86/util/unwind-libdw.c     | 6 +++---
> >  3 files changed, 9 insertions(+), 9 deletions(-)
> >
> > diff --git a/tools/perf/arch/arm64/util/unwind-libdw.c b/tools/perf/arch/arm64/util/unwind-libdw.c
> > index 7623d85e77f3..a50941629649 100644
> > --- a/tools/perf/arch/arm64/util/unwind-libdw.c
> > +++ b/tools/perf/arch/arm64/util/unwind-libdw.c
> > @@ -1,8 +1,8 @@
> >  // SPDX-License-Identifier: GPL-2.0
> >  #include <elfutils/libdwfl.h>
> > -#include "../../util/unwind-libdw.h"
> > -#include "../../util/perf_regs.h"
> > -#include "../../util/event.h"
> > +#include "../../../util/unwind-libdw.h"
> > +#include "../../../util/perf_regs.h"
> > +#include "../../../util/event.h"
> >
> >  bool libdw__arch_set_initial_registers(Dwfl_Thread *thread, void *arg)
> >  {
> > diff --git a/tools/perf/arch/powerpc/util/unwind-libdw.c b/tools/perf/arch/powerpc/util/unwind-libdw.c
> > index abf2dbc7f829..7b2d96ec28e3 100644
> > --- a/tools/perf/arch/powerpc/util/unwind-libdw.c
> > +++ b/tools/perf/arch/powerpc/util/unwind-libdw.c
> > @@ -1,9 +1,9 @@
> >  // SPDX-License-Identifier: GPL-2.0
> >  #include <elfutils/libdwfl.h>
> >  #include <linux/kernel.h>
> > -#include "../../util/unwind-libdw.h"
> > -#include "../../util/perf_regs.h"
> > -#include "../../util/event.h"
> > +#include "../../../util/unwind-libdw.h"
> > +#include "../../../util/perf_regs.h"
> > +#include "../../../util/event.h"
> >
> >  /* See backends/ppc_initreg.c and backends/ppc_regs.c in elfutils.  */
> >  static const int special_regs[3][2] = {
> > diff --git a/tools/perf/arch/x86/util/unwind-libdw.c b/tools/perf/arch/x86/util/unwind-libdw.c
> > index fda8f4206ee4..eea2bf87232b 100644
> > --- a/tools/perf/arch/x86/util/unwind-libdw.c
> > +++ b/tools/perf/arch/x86/util/unwind-libdw.c
> > @@ -1,8 +1,8 @@
> >  // SPDX-License-Identifier: GPL-2.0
> >  #include <elfutils/libdwfl.h>
> > -#include "../../util/unwind-libdw.h"
> > -#include "../../util/perf_regs.h"
> > -#include "../../util/event.h"
> > +#include "../../../util/unwind-libdw.h"
> > +#include "../../../util/perf_regs.h"
> > +#include "../../../util/event.h"
> >
> >  bool libdw__arch_set_initial_registers(Dwfl_Thread *thread, void *arg)
> >  {
> > --
> > 2.27.0.rc2.251.g90737beb825-goog
> >
