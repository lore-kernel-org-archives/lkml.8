Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B9FBC83014
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 13:37:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2F0D2074A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 13:37:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YnYKe19f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbgD3Nhs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 09:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726577AbgD3Nhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 09:37:47 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29D47C035494
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 06:37:47 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id e17so4900940qtp.7
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 06:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bCxKlbHJaTEyAh+t90Uz2r+RNa6TsPTGNQeXGObtATE=;
        b=YnYKe19fVMzlvt09cdbRMbtg7AJgWf4r+vmQNBRHLOAkMjzPaGthVJ88ZCGAuehE3G
         rD4tUe/kZ9oY1gI8oStWos7LiJwsz9+r/jDN38r6EqPm7334+uqXwlaCnjlDAOMDCRlU
         laoBjaG5PFouW1qDaFbx5BXiDUmgyXq6Cw1H5X2dpGx6QEflb89GjJ/3Mq4Jn/EHQaD1
         2hhuP5604ScwkmNf5LRIqwpX89MIufZ1PZkCaxetNbUC9IAjJhHsuOXE/SphJz9JcNy4
         DFf+OUhNm92JV3Vz6pxtdkHW2MhBuxgTXHbTr2GBEXpec6zCF1kLkkQPdlnNNQjHw5JZ
         oUTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bCxKlbHJaTEyAh+t90Uz2r+RNa6TsPTGNQeXGObtATE=;
        b=qjwI4Pfn9hwuZqed79RGDlFOIHGKP7sjWYLgQ1Dm62++7bI3jWaccGqhVQ1Y6yc8Nc
         M0a3PRjgiYkhmg0fCIFvGlGT04u+IqdafQTsAY87jyeu45kGNO6D14H9eIXGHA15mfmb
         ZosTMocBlukhxfm8XnmUQSFujI4szjMawRd0dtU09oEUREacEyyuW3QvxB0Xq8YTAUYW
         L16v7bt81nwrARsVYkJn7Zx5dB+o+us6Zz4mchFGLEGdNwV8s1c2C3oAhPEIIzl11xQo
         TGtALVkjLCuVmp/gotBkXeBL5B+AzYTkPIko/rcGN0ciAbi/nXsNQHHbBfRUBrYsXxlk
         0kDA==
X-Gm-Message-State: AGi0PuZACAIu6U9kmxXT/2oCLvdP/UdfQFw9hGA/nzTnGMPri8/EwfZ6
        /gpvN54ABEZSJaEk1tBhWro=
X-Google-Smtp-Source: APiQypLT9+cPc/TqAiXv3wpy/3/S37kYFDZtOXxTqf8uat6m1pxp+AHoMzekGHoT2LWIVKDGqVA2GA==
X-Received: by 2002:ac8:5302:: with SMTP id t2mr3820799qtn.124.1588253866263;
        Thu, 30 Apr 2020 06:37:46 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id x194sm1855954qkb.131.2020.04.30.06.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 06:37:45 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E4E02409A3; Thu, 30 Apr 2020 10:37:42 -0300 (-03)
Date:   Thu, 30 Apr 2020 10:37:42 -0300
To:     Konstantin Khlebnikov <koct9i@gmail.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Andi Kleen <ak@linux.intel.com>,
        Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
Subject: Re: [PATCH v2 2/3] perf tool: fix detecting smt at machines with
 more than 32 cpus
Message-ID: <20200430133742.GK30487@kernel.org>
References: <158817718710.747528.11009278875028211991.stgit@buzz>
 <158817735893.747933.15107805593224835078.stgit@buzz>
 <20200429181346.GF30487@kernel.org>
 <CALYGNiPcicchqKr4+a8QT=mm20ReGMv5-V605RzCAHP8-2vN3g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALYGNiPcicchqKr4+a8QT=mm20ReGMv5-V605RzCAHP8-2vN3g@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Apr 29, 2020 at 09:38:52PM +0300, Konstantin Khlebnikov escreveu:
> On Wed, Apr 29, 2020 at 9:16 PM Arnaldo Carvalho de Melo
> <arnaldo.melo@gmail.com> wrote:
> >
> > Em Wed, Apr 29, 2020 at 07:22:43PM +0300, Konstantin Khlebnikov escreveu:
> > > Cpu bitmap is split into 32 bit words. For system with more than 32 cores
> > > threads are always in different words thus first word never has two bits:
> > > cpu0: "0000,00000100,00000001", cpu 79: "8000,00000080,00000000".
> > >
> > > Instead of parsing bitmap read "core_cpus_list" or "thread_siblings_list"
> > > and simply check presence of ',' or '-' in it.
> > >
> > > Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> > > Fixes: de5077c4e38f ("perf tools: Add utility function to detect SMT status")
> > > ---
> > >  tools/perf/util/smt.c |   37 +++++++++++++++++--------------------
> > >  1 file changed, 17 insertions(+), 20 deletions(-)
> > >
> > > diff --git a/tools/perf/util/smt.c b/tools/perf/util/smt.c
> > > index 8481842e9edb..dc37b5abd1c3 100644
> > > --- a/tools/perf/util/smt.c
> > > +++ b/tools/perf/util/smt.c
> > > @@ -1,6 +1,7 @@
> > >  #include <stdio.h>
> > >  #include <stdlib.h>
> > >  #include <unistd.h>
> > > +#include <string.h>
> > >  #include <linux/bitops.h>
> > >  #include "api/fs/fs.h"
> > >  #include "smt.h"
> > > @@ -9,39 +10,35 @@ int smt_on(void)
> > >  {
> > >       static bool cached;
> > >       static int cached_result;
> > > +     int active;
> > >       int cpu;
> > >       int ncpu;
> > > +     char *str = NULL;
> > > +     size_t strlen;
> >
> > Try not to use as the name of a variable the well known name of a
> > standard C library function, there are cases where some of those names
> > are used as #define directives and then all hell break loose...
> 
> You mean "strlen"? Yeah, that's weird name for variable
> but it was here before me thus I haven't noticed.

Sorry, I saw it in a + prefixed line so from a quick look I thought you
were introducing it, my bad.
 
> >
> > Also doing first the change that makes the use of that new file would
> > allow me to have processed that patch first, which is way simpler than
> > this one, i.e. try to leave the more involved changes to the end of the
> > patchkit, that helps cherry-picking the less complex/smaller parts of
> > your patchkit.
> 
> Hmm. Common sense tells to put cleanups and bugfixes before new features.

Well, in this case on up-to-date machines that code is not even used,
its a fallback.

If you don't have the time I'll eventually adjust the patch to what I
have now in my perf/core branch, since I've reordered them,

Thanks,

- Arnaldo
 
> > I've applied the first one, thanks!
> >
> > - Arnaldo
> >
> > >       if (cached)
> > >               return cached_result;
> > >
> > >       ncpu = sysconf(_SC_NPROCESSORS_CONF);
> > >       for (cpu = 0; cpu < ncpu; cpu++) {
> > > -             unsigned long long siblings;
> > > -             char *str;
> > > -             size_t strlen;
> > >               char fn[256];
> > >
> > > -             snprintf(fn, sizeof fn,
> > > -                     "devices/system/cpu/cpu%d/topology/core_cpus", cpu);
> > > -             if (sysfs__read_str(fn, &str, &strlen) < 0) {
> > > -                     snprintf(fn, sizeof fn,
> > > -                             "devices/system/cpu/cpu%d/topology/thread_siblings",
> > > -                             cpu);
> > > -                     if (sysfs__read_str(fn, &str, &strlen) < 0)
> > > -                             continue;
> > > -             }
> > > -             /* Entry is hex, but does not have 0x, so need custom parser */
> > > -             siblings = strtoull(str, NULL, 16);
> > > -             free(str);
> > > -             if (hweight64(siblings) > 1) {
> > > -                     cached_result = 1;
> > > -                     cached = true;
> > > +             snprintf(fn, sizeof(fn), "devices/system/cpu/cpu%d/topology/%s",
> > > +                      cpu, "core_cpus_list");
> > > +             if (sysfs__read_str(fn, &str, &strlen) > 0)
> > > +                     break;
> > > +
> > > +             snprintf(fn, sizeof(fn), "devices/system/cpu/cpu%d/topology/%s",
> > > +                      cpu, "thread_siblings_list");
> > > +             if (sysfs__read_str(fn, &str, &strlen) > 0)
> > >                       break;
> > > -             }
> > >       }
> > > +
> > > +     active = str && (strchr(str, ',') != NULL || strchr(str, '-') != NULL);
> > > +     free(str);
> > > +
> > >       if (!cached) {
> > > -             cached_result = 0;
> > > +             cached_result = active;
> > >               cached = true;
> > >       }
> > >       return cached_result;
> > >
> >
> > --
> >
> > - Arnaldo

-- 

- Arnaldo
