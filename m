Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04504C47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:37:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBA6B206B9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:37:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rtChuStS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729647AbgEEOhZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 10:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729259AbgEEOhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 10:37:24 -0400
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 629CDC061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 07:37:24 -0700 (PDT)
Received: by mail-yb1-xb42.google.com with SMTP id b8so1407883ybn.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 07:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ygxrlI0ZSekRzDHkF8rXsRVkEZqYITgYVQ/ZzppaEPU=;
        b=rtChuStS101uVJbD+PVVcFgQk+MLAj3cK1UlxOoqBrlpJrXpeSqxbHR7lare2rZC+0
         i792GYo63axXaEOZq3jkqtZgNzdJAoSezIKAUcMUx83PkqgUrmay/6uaMS7Ym2Ayynlh
         UPzZl2M0SRKEjkThkXZXpSLW5GRKYc1dofxAOkdM4Xog0WxodwvvWNUi8zphh6RNITLj
         S7wDM5OpQ/aVrD2myve31QApPRHB8zQMJhaHDUgzF3w+l14ceqtSGXAKZldqGcMjFmqR
         usbvO/F5AMyouCq2a/GG3BjqEOfJl9sxhYa5vs0UFf18w9OWNzSMK7lmOeKpDygsyvtU
         xj1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ygxrlI0ZSekRzDHkF8rXsRVkEZqYITgYVQ/ZzppaEPU=;
        b=qF2dBDDrcdgkqKDUoSi4DLizQz8lDJNJct0sC8x6XitpRiCxHvN/BA0IB/HBDG3QqS
         jt5AL/nkPwcoZ1wd0Md//XL5ulVKxSPsRIHMpEh/fY5Q/nNAFgxvQbfZrozYlVlpo8cy
         CMI375X7jDWlQM9CL51utnxpOHvf9Mcam2MY00nEPX8Rh5xnSKdScHAXZcChiGt/fbrK
         oM5R/iQMZsTi+96L9H626FTh3NKQvfadp6kdQVtF5HHh3Q+He+z2H6m7dlPRtTcoccNd
         dNqPf8enG1tAnW3VWJVZJkwDF1UtYzahTCdSMPQadpiiVcF/dsIRTFSa5MocO/kM0u0/
         HimQ==
X-Gm-Message-State: AGi0PuYhc+d6kbOiLhiCWywCudOrhYABFPt4zd36IZ81S+1QxKMeXsv+
        11Zi25KoJEQqUspafVHKmJ9Q76ZY8IOeHjPsFB/QlA==
X-Google-Smtp-Source: APiQypKAO2flllDOx1A0V5NpXh5GeEyfLGJYDkXddJkMTMPPspMtvv9/NARPO9CdlDHhZ2beclInWPkvwa/kaejG9Ck=
X-Received: by 2002:a25:6b06:: with SMTP id g6mr3032933ybc.383.1588689443267;
 Tue, 05 May 2020 07:37:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200501221315.54715-1-irogers@google.com> <20200501221315.54715-3-irogers@google.com>
 <20200505142521.GD2041406@krava>
In-Reply-To: <20200505142521.GD2041406@krava>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 5 May 2020 07:37:11 -0700
Message-ID: <CAP-5=fWp9Tt27FPcE=QZriMSpM3qO+vE3jk=u=o0298HYvW2mw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] lib kallsyms: parse using io api
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 5, 2020 at 7:25 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Fri, May 01, 2020 at 03:13:14PM -0700, Ian Rogers wrote:
>
> SNIP
>
> > diff --git a/tools/lib/symbol/kallsyms.c b/tools/lib/symbol/kallsyms.c
> > index 1a7a9f877095..e335ac2b9e19 100644
> > --- a/tools/lib/symbol/kallsyms.c
> > +++ b/tools/lib/symbol/kallsyms.c
> > @@ -1,7 +1,9 @@
> >  // SPDX-License-Identifier: GPL-2.0
> >  #include "symbol/kallsyms.h"
> > +#include "api/io.h"
> >  #include <stdio.h>
> > -#include <stdlib.h>
> > +#include <sys/stat.h>
> > +#include <fcntl.h>
> >
> >  u8 kallsyms2elf_type(char type)
> >  {
> > @@ -15,74 +17,62 @@ bool kallsyms__is_function(char symbol_type)
> >       return symbol_type == 'T' || symbol_type == 'W';
> >  }
> >
> > -/*
> > - * While we find nice hex chars, build a long_val.
> > - * Return number of chars processed.
> > - */
> > -int hex2u64(const char *ptr, u64 *long_val)
>
> hi,
> when you remove in here hex2u64, you'll break the compile:
>
>           LINK     perf
>         /usr/bin/ld: perf-in.o: in function `modules__parse':
>         /home/jolsa/linux-perf/tools/perf/util/symbol.c:607: undefined reference to `hex2u64'
>         /usr/bin/ld: /home/jolsa/linux-perf/tools/perf/util/symbol.c:607: undefined reference to `hex2u64'
>         /usr/bin/ld: perf-in.o: in function `dso__load_perf_map':
>         /home/jolsa/linux-perf/tools/perf/util/symbol.c:1477: undefined reference to `hex2u64'
>         /usr/bin/ld: /home/jolsa/linux-perf/tools/perf/util/symbol.c:1483: undefined reference to `hex2u64'
>         collect2: error: ld returned 1 exit status
>         make[2]: *** [Makefile.perf:629: perf] Error 1
>         make[1]: *** [Makefile.perf:225: sub-make] Error 2
>         make: *** [Makefile:70: all] Error 2
>
> that hex2u64 move needs to come before this change

Good catch. Fixed in v3.
https://lore.kernel.org/lkml/20200505143625.147832-1-irogers@google.com/T/#t

Thanks,
Ian

> jirka
>
