Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96E20C47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 16:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73BFF206A4
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 16:13:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hqsTDeOO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730596AbgEEQNn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 12:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730157AbgEEQN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 12:13:29 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE1DC061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 09:13:28 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id w18so1282426qvs.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 09:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NN0AhXtIWLO+HzOAES8HqNedREZZwt4I5Op/INZ8tT8=;
        b=hqsTDeOOKt2oTCYnII9kbPDggfYoPKHu8fF8wHTD1Ksg0D2YpXT7fE3Pv3kcepcZkp
         Ex5xph1tKfw47bEc7eiVeGV/Sdrddx2m7p3dtiBuOUcjO+Haf2dawpCwBLkQnNw3EWH9
         vCteutFM4t4bCZpi4K9cll4khRu4fPEyY4kTZt3jgnuaUOVoIISkKJt7D5xA3UX3riqr
         u/P3GpPal0LOm1MAG5RJ9V35KcifXo1ZgeqCflT3Vl/1hRHlANNOHp6GpD4SNNKgV2TB
         7dXWckzAEXeBWtV6uMsL+vH+r0gg8nv3+qVr7lJQXCFvqm3pOP9wWZD+iTOFmFdRyq+d
         DNCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NN0AhXtIWLO+HzOAES8HqNedREZZwt4I5Op/INZ8tT8=;
        b=GXWgl0VblFmo+w34wM9dTxW9m+0TMeIgxIdprBbMpE4dMcs5K7kDM6UBYMaylTXdwC
         rHXUQiQUJ9k3jAGfbycnNHXP4UzE3dSNYGMavjn3mmXjsryu2MQ/02nX6jeyYNCpCPVa
         fm2K41sm5atkl+tGir5iR8vjjmTzk9Ik1WkD3oafEcDMj0TL/L1JyVGk4w0IiEG0X2wc
         1E5d4x4V/ZkI6xfCf1Vh/2oG/tqq2kJbEt3i8Os8YAPG0H39km8GE0iE1q9ar0WrWi6n
         9pEj+PGWi2viu2Z4OcddXbmj8qcS1Yc67xKmv9KGPyPDxZsiYPiOoRWcow/Ws+lQEgP6
         knaw==
X-Gm-Message-State: AGi0PuZSj1d3RzWKRn/LpS/acM9liAPiwuZsD7tow0PitForo/ETgNf+
        LnOdQ9ZqziMrLkc9GWqKUqU=
X-Google-Smtp-Source: APiQypLEHVVBQZlZoCeE3RwnN9M2t2NC/sXURxVYUEKvEHe6znRhtOuUtbqlkRQUAjqZUMIvtfjbMQ==
X-Received: by 2002:a0c:9a08:: with SMTP id p8mr3601876qvd.54.1588695207450;
        Tue, 05 May 2020 09:13:27 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id x124sm2070293qkd.32.2020.05.05.09.13.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 09:13:26 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id CFD19409A3; Tue,  5 May 2020 13:13:24 -0300 (-03)
Date:   Tue, 5 May 2020 13:13:24 -0300
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v2 2/3] lib kallsyms: parse using io api
Message-ID: <20200505161324.GW30487@kernel.org>
References: <20200501221315.54715-1-irogers@google.com>
 <20200501221315.54715-3-irogers@google.com>
 <20200505142521.GD2041406@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200505142521.GD2041406@krava>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, May 05, 2020 at 04:25:21PM +0200, Jiri Olsa escreveu:
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
> >  	return symbol_type == 'T' || symbol_type == 'W';
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
> 	  LINK     perf
> 	/usr/bin/ld: perf-in.o: in function `modules__parse':
> 	/home/jolsa/linux-perf/tools/perf/util/symbol.c:607: undefined reference to `hex2u64'
> 	/usr/bin/ld: /home/jolsa/linux-perf/tools/perf/util/symbol.c:607: undefined reference to `hex2u64'
> 	/usr/bin/ld: perf-in.o: in function `dso__load_perf_map':
> 	/home/jolsa/linux-perf/tools/perf/util/symbol.c:1477: undefined reference to `hex2u64'
> 	/usr/bin/ld: /home/jolsa/linux-perf/tools/perf/util/symbol.c:1483: undefined reference to `hex2u64'
> 	collect2: error: ld returned 1 exit status
> 	make[2]: *** [Makefile.perf:629: perf] Error 1
> 	make[1]: *** [Makefile.perf:225: sub-make] Error 2
> 	make: *** [Makefile:70: all] Error 2
> 
> that hex2u64 move needs to come before this change

I noticed this and fixed it all, was about to send this note I've added:

---------------

Also we can't remove hex2u64() in this patch as this breaks the build:

  /usr/bin/ld: /tmp/build/perf/perf-in.o: in function `modules__parse':
  /home/acme/git/perf/tools/perf/util/symbol.c:607: undefined reference to `hex2u64'
  /usr/bin/ld: /home/acme/git/perf/tools/perf/util/symbol.c:607: undefined reference to `hex2u64'
  /usr/bin/ld: /tmp/build/perf/perf-in.o: in function `dso__load_perf_map':
  /home/acme/git/perf/tools/perf/util/symbol.c:1477: undefined reference to `hex2u64'
  /usr/bin/ld: /home/acme/git/perf/tools/perf/util/symbol.c:1483: undefined reference to `hex2u64'
  collect2: error: ld returned 1 exit status

Leave it there, move it in the next patch.
