Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0725BC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 14:21:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEF7D20772
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 14:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591021316;
	bh=RrZctJLElM1GNi+AhE7h1wRaQmmwNOujm6i/ZZr4hg8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xL3IU4jnUJ//zqff8+LCAD9be1PBcWkoG2Ct17rGfP5zZ5AfHBuu1cMpjymOFaOpg
	 3f1DT9kUjfh2IT1keCAYwGQsJotn1Cl14q/kj+IpLQIlodCMJKCq3C7kyQHs+G4MJP
	 waI/fBqDeJTnSBFm3EcrWlWWsl0ZXg7oHzDJ/1bc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbgFAOV4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 10:21:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:35472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726075AbgFAOVz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 10:21:55 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9FDE12068D;
        Mon,  1 Jun 2020 14:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591021314;
        bh=RrZctJLElM1GNi+AhE7h1wRaQmmwNOujm6i/ZZr4hg8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f3vJczxS7NA3LjeNZutrYVPMU+xSLDRCqDL3oC6w3wSVa0oa77sFHhcOyeNZ5oY76
         qjYoVdASvWHTSnd06e854umBqX7gMmJjyMFmX93iOd0yGaVZsOvzgSfp+Ppw1KTcVt
         V/na8VWuvyzmzjff1Ev+Zmwlx5gUkcDPny3++wTA=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 141AE40AFD; Mon,  1 Jun 2020 11:21:51 -0300 (-03)
Date:   Mon, 1 Jun 2020 11:21:50 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH] perf libdw: Fix off-by 1 relative directory includes
Message-ID: <20200601142150.GG31795@kernel.org>
References: <20200529225232.207532-1-irogers@google.com>
 <CAM9d7chrW-zfq-9cjBq_n3ESpYv4jtbeDZFWy+DoEzyA2whrqQ@mail.gmail.com>
 <CAP-5=fWApg4XGPTJmzpN6nTdhgBF5AC4opm2HiYFkuzhLmdfPg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fWApg4XGPTJmzpN6nTdhgBF5AC4opm2HiYFkuzhLmdfPg@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, May 31, 2020 at 05:06:08PM -0700, Ian Rogers escreveu:
> On Sun, May 31, 2020 at 7:29 AM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > Hi Ian,
> >
> > On Sat, May 30, 2020 at 7:53 AM Ian Rogers <irogers@google.com> wrote:
> > >
> > > This is currently working due to extra include paths in the build.
> > >
> > > Before:
> > > $ cd tools/perf/arch/arm64/util
> > > $ ls -la ../../util/unwind-libdw.h
> > > ls: cannot access '../../util/unwind-libdw.h': No such file or directory
> > >
> > > After:
> > > $ ls -la ../../../util/unwind-libdw.h
> > > -rw-r----- 1 irogers irogers 553 Apr 17 14:31 ../../../util/unwind-libdw.h
> >
> > Missing sign-off, but otherwise looks good to me
> 
> Doh! Thanks Namhyung.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>

Thanks, applied.

- Arnaldo
 
> Ian
> 
> > Acked-by: Namhyung Kim <namhyung@kernel.org>
> >
> > Thanks
> > Namhyung
> >
> >
> > > ---
> > >  tools/perf/arch/arm64/util/unwind-libdw.c   | 6 +++---
> > >  tools/perf/arch/powerpc/util/unwind-libdw.c | 6 +++---
> > >  tools/perf/arch/x86/util/unwind-libdw.c     | 6 +++---
> > >  3 files changed, 9 insertions(+), 9 deletions(-)
> > >
> > > diff --git a/tools/perf/arch/arm64/util/unwind-libdw.c b/tools/perf/arch/arm64/util/unwind-libdw.c
> > > index 7623d85e77f3..a50941629649 100644
> > > --- a/tools/perf/arch/arm64/util/unwind-libdw.c
> > > +++ b/tools/perf/arch/arm64/util/unwind-libdw.c
> > > @@ -1,8 +1,8 @@
> > >  // SPDX-License-Identifier: GPL-2.0
> > >  #include <elfutils/libdwfl.h>
> > > -#include "../../util/unwind-libdw.h"
> > > -#include "../../util/perf_regs.h"
> > > -#include "../../util/event.h"
> > > +#include "../../../util/unwind-libdw.h"
> > > +#include "../../../util/perf_regs.h"
> > > +#include "../../../util/event.h"
> > >
> > >  bool libdw__arch_set_initial_registers(Dwfl_Thread *thread, void *arg)
> > >  {
> > > diff --git a/tools/perf/arch/powerpc/util/unwind-libdw.c b/tools/perf/arch/powerpc/util/unwind-libdw.c
> > > index abf2dbc7f829..7b2d96ec28e3 100644
> > > --- a/tools/perf/arch/powerpc/util/unwind-libdw.c
> > > +++ b/tools/perf/arch/powerpc/util/unwind-libdw.c
> > > @@ -1,9 +1,9 @@
> > >  // SPDX-License-Identifier: GPL-2.0
> > >  #include <elfutils/libdwfl.h>
> > >  #include <linux/kernel.h>
> > > -#include "../../util/unwind-libdw.h"
> > > -#include "../../util/perf_regs.h"
> > > -#include "../../util/event.h"
> > > +#include "../../../util/unwind-libdw.h"
> > > +#include "../../../util/perf_regs.h"
> > > +#include "../../../util/event.h"
> > >
> > >  /* See backends/ppc_initreg.c and backends/ppc_regs.c in elfutils.  */
> > >  static const int special_regs[3][2] = {
> > > diff --git a/tools/perf/arch/x86/util/unwind-libdw.c b/tools/perf/arch/x86/util/unwind-libdw.c
> > > index fda8f4206ee4..eea2bf87232b 100644
> > > --- a/tools/perf/arch/x86/util/unwind-libdw.c
> > > +++ b/tools/perf/arch/x86/util/unwind-libdw.c
> > > @@ -1,8 +1,8 @@
> > >  // SPDX-License-Identifier: GPL-2.0
> > >  #include <elfutils/libdwfl.h>
> > > -#include "../../util/unwind-libdw.h"
> > > -#include "../../util/perf_regs.h"
> > > -#include "../../util/event.h"
> > > +#include "../../../util/unwind-libdw.h"
> > > +#include "../../../util/perf_regs.h"
> > > +#include "../../../util/event.h"
> > >
> > >  bool libdw__arch_set_initial_registers(Dwfl_Thread *thread, void *arg)
> > >  {
> > > --
> > > 2.27.0.rc2.251.g90737beb825-goog
> > >

-- 

- Arnaldo
