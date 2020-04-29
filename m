Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C6E5C83006
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 18:39:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B46E2083B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 18:39:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dSONLi0j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbgD2SjF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 14:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726456AbgD2SjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 14:39:05 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F4085C03C1AE
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 11:39:04 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id x2so3401992ilp.13
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 11:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eKasnrnVysKtreE1SqWrltyL8nRF8DWFXFhyrWQbNOs=;
        b=dSONLi0jn/D2yP8lFGOe7fSzszpeTX5NwEr7+gsNwFv8NibO1nop2fIGuL+/oOMHq7
         dz8DMGD5hEblJsPy+rkDHe3PYP0F84j+fRfNAGl0Ew40gz5rU5IVw+7d3yJe/n95LdEK
         wLux2QBj5anpqY4UANjtCndA3ttK0zxNC9Yd4Tf4c2YNUBiULO6toJVkcVwDhENtAnNE
         aPwhFE/wVk9/ZyECK/BiZ2e+BopPZXivZezu4Kc9kQ5GLAtOd7kqGSik/JhJyEy2FFih
         wq97VOF56ysapkBWosKBMm9Cz01ERkfPeQg/LKXU1peIvSJx0vr+GBGZf3+6NJ4rHLTg
         PiJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eKasnrnVysKtreE1SqWrltyL8nRF8DWFXFhyrWQbNOs=;
        b=P8shTyHPwvOOvve/cXxyAx68wZxLzGqkdt8+GXXiK0MgD5BwY1xoiahY/ROLubXtiw
         PIhemuTJKWN+FilO+ZKVAEfPIQW2OBhdtmShLfsQPBupP9dT5xGMjvs1NVcybsouPRSD
         5esmznmc2HNNptUhvROuqX+8RlcH1O9bx9cDw+E08v+tHnfwe8koll5lnFdB+QNf4Bor
         c/TBGg2YbDicp38+tIAoNicvT1SRi0MRo35TblMptOp+7qPX/a/TN0FBOgQ45khmmPLl
         p/s+8AHQfFBrC4mTy7w/QPhRfubluQ5C+e8m7OXIrpJyCq4R1+DmBTfvfrUlM9753Hn0
         smdQ==
X-Gm-Message-State: AGi0PubneZnG9BBuelw9T8rt4+yr3TC+dmLXdBuQYfnOQ3hJ2A0WwXa4
        sqPWGsAdjD9ZCyosBXgap42VeblEN+DuRwsQcpI=
X-Google-Smtp-Source: APiQypINNCZGcYlbPsZ86Hr902X6rNt90sZ+erHBtLV0cBJXHd3Vyo/x+R6sazjj9MBscRspZKFzbHYnt7BVJMqj0zc=
X-Received: by 2002:a92:6c11:: with SMTP id h17mr26980301ilc.178.1588185544373;
 Wed, 29 Apr 2020 11:39:04 -0700 (PDT)
MIME-Version: 1.0
References: <158817718710.747528.11009278875028211991.stgit@buzz>
 <158817735893.747933.15107805593224835078.stgit@buzz> <20200429181346.GF30487@kernel.org>
In-Reply-To: <20200429181346.GF30487@kernel.org>
From:   Konstantin Khlebnikov <koct9i@gmail.com>
Date:   Wed, 29 Apr 2020 21:38:52 +0300
Message-ID: <CALYGNiPcicchqKr4+a8QT=mm20ReGMv5-V605RzCAHP8-2vN3g@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] perf tool: fix detecting smt at machines with more
 than 32 cpus
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Andi Kleen <ak@linux.intel.com>,
        Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 29, 2020 at 9:16 PM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
> Em Wed, Apr 29, 2020 at 07:22:43PM +0300, Konstantin Khlebnikov escreveu:
> > Cpu bitmap is split into 32 bit words. For system with more than 32 cores
> > threads are always in different words thus first word never has two bits:
> > cpu0: "0000,00000100,00000001", cpu 79: "8000,00000080,00000000".
> >
> > Instead of parsing bitmap read "core_cpus_list" or "thread_siblings_list"
> > and simply check presence of ',' or '-' in it.
> >
> > Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> > Fixes: de5077c4e38f ("perf tools: Add utility function to detect SMT status")
> > ---
> >  tools/perf/util/smt.c |   37 +++++++++++++++++--------------------
> >  1 file changed, 17 insertions(+), 20 deletions(-)
> >
> > diff --git a/tools/perf/util/smt.c b/tools/perf/util/smt.c
> > index 8481842e9edb..dc37b5abd1c3 100644
> > --- a/tools/perf/util/smt.c
> > +++ b/tools/perf/util/smt.c
> > @@ -1,6 +1,7 @@
> >  #include <stdio.h>
> >  #include <stdlib.h>
> >  #include <unistd.h>
> > +#include <string.h>
> >  #include <linux/bitops.h>
> >  #include "api/fs/fs.h"
> >  #include "smt.h"
> > @@ -9,39 +10,35 @@ int smt_on(void)
> >  {
> >       static bool cached;
> >       static int cached_result;
> > +     int active;
> >       int cpu;
> >       int ncpu;
> > +     char *str = NULL;
> > +     size_t strlen;
>
> Try not to use as the name of a variable the well known name of a
> standard C library function, there are cases where some of those names
> are used as #define directives and then all hell break loose...

You mean "strlen"? Yeah, that's weird name for variable
but it was here before me thus I haven't noticed.

>
> Also doing first the change that makes the use of that new file would
> allow me to have processed that patch first, which is way simpler than
> this one, i.e. try to leave the more involved changes to the end of the
> patchkit, that helps cherry-picking the less complex/smaller parts of
> your patchkit.

Hmm. Common sense tells to put cleanups and bugfixes before new features.

>
> I've applied the first one, thanks!
>
> - Arnaldo
>
> >       if (cached)
> >               return cached_result;
> >
> >       ncpu = sysconf(_SC_NPROCESSORS_CONF);
> >       for (cpu = 0; cpu < ncpu; cpu++) {
> > -             unsigned long long siblings;
> > -             char *str;
> > -             size_t strlen;
> >               char fn[256];
> >
> > -             snprintf(fn, sizeof fn,
> > -                     "devices/system/cpu/cpu%d/topology/core_cpus", cpu);
> > -             if (sysfs__read_str(fn, &str, &strlen) < 0) {
> > -                     snprintf(fn, sizeof fn,
> > -                             "devices/system/cpu/cpu%d/topology/thread_siblings",
> > -                             cpu);
> > -                     if (sysfs__read_str(fn, &str, &strlen) < 0)
> > -                             continue;
> > -             }
> > -             /* Entry is hex, but does not have 0x, so need custom parser */
> > -             siblings = strtoull(str, NULL, 16);
> > -             free(str);
> > -             if (hweight64(siblings) > 1) {
> > -                     cached_result = 1;
> > -                     cached = true;
> > +             snprintf(fn, sizeof(fn), "devices/system/cpu/cpu%d/topology/%s",
> > +                      cpu, "core_cpus_list");
> > +             if (sysfs__read_str(fn, &str, &strlen) > 0)
> > +                     break;
> > +
> > +             snprintf(fn, sizeof(fn), "devices/system/cpu/cpu%d/topology/%s",
> > +                      cpu, "thread_siblings_list");
> > +             if (sysfs__read_str(fn, &str, &strlen) > 0)
> >                       break;
> > -             }
> >       }
> > +
> > +     active = str && (strchr(str, ',') != NULL || strchr(str, '-') != NULL);
> > +     free(str);
> > +
> >       if (!cached) {
> > -             cached_result = 0;
> > +             cached_result = active;
> >               cached = true;
> >       }
> >       return cached_result;
> >
>
> --
>
> - Arnaldo
