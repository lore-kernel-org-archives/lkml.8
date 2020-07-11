Return-Path: <SRS0=TDCE=AW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C1F9C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 12:37:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41C3A2076A
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 12:37:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cEaKL+pO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728209AbgGKMhf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jul 2020 08:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbgGKMhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jul 2020 08:37:34 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F807C08C5DD
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jul 2020 05:37:34 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id m9so3768378pfh.0
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jul 2020 05:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ja2u/aTH0QYUI+aOka8Hx8/x8jsy05eo2BYAUZcjGF0=;
        b=cEaKL+pOBerfmPoBsOViPTFvVm0Zxt7177Srgy7ciPMn5Dy2LZOidFFyHRJVOZWlJS
         jGtfA02Pu+Bkmdlw5MyKqATYFlS8dlZhU9VyHCMzn5GdjQX8X6ZuF6P7k+DA73rqvLcH
         6JgT02fgZtrn4DFIma69ccMb6FOZXv1bvL3TEiwDhpriwrMhjfJkvnJjBXXFnMXLK3P9
         ebKv7wvg4L226CoD4+Q8BQ/Wt5TV/hUrw1/YQpzicBNJRBZOKoDJEeJUB1ytRB6TUpda
         yQG5g3GPLhozlSdRy6OWQ5p8UypJRsNsY8cy7R8UAIKgi2awjpz7+4lIxcAx/J2nRxif
         ilFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ja2u/aTH0QYUI+aOka8Hx8/x8jsy05eo2BYAUZcjGF0=;
        b=k60ghXJF+Q7aK+5knW4lLbS3H6963RgV06farauh1fmgplKTXyvYbWtBWFo6KOykUz
         OUooX0uafhwnNeMHMRm3YHIru8GLW3maCRv5gIGNcYxNd2usCI0L91Wudm/0ujW3BNqB
         De5x7+6hrTIoYhEQgXpOwEl66e/PJRI7EipRyxUA1aV1k2yWCciBqRUyuRX/a1zjfx3k
         Y2mZH6fLI3U7+FsR+kg04H06SYekbEiljN5GfGQoyZFVk/J7g+QL553acgWiPcP7hYIN
         DxxN0xmJU5WWluNOLJyltM6n4rY7MHcAodo6yvOhMeESZiJgztUBmwagOlZ+9RvEHZ0n
         yWsg==
X-Gm-Message-State: AOAM533ZG2aKqAAyR8fknD2epzKUl+Q748efrUJ1htTpBGmL0KT8wz38
        pj1lEuCDVrMFm/oCGYSsljI=
X-Google-Smtp-Source: ABdhPJwQddKQLxHwDNXd6m70yhxZIJ3RHF4VS2bbCFxLJ58507FqgW51TIv4z5A2IfIws7bBvZvXKg==
X-Received: by 2002:a65:6703:: with SMTP id u3mr58633040pgf.254.1594471053983;
        Sat, 11 Jul 2020 05:37:33 -0700 (PDT)
Received: from mail.google.com ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id c2sm8558777pgk.77.2020.07.11.05.37.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2020 05:37:32 -0700 (PDT)
Date:   Sat, 11 Jul 2020 20:37:25 +0800
From:   Changbin Du <changbin.du@gmail.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Changbin Du <changbin.du@gmail.com>, Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 08/17] perf: util: add general function to parse
 sublevel options
Message-ID: <20200711123725.sojcctyvzyxzlfzs@mail.google.com>
References: <20200710134322.15400-1-changbin.du@gmail.com>
 <20200710134322.15400-9-changbin.du@gmail.com>
 <CAM9d7ciuzqbBb+POeuiFh-KOFKKzi7LOC6r2vu=WiQ_5tMe7Zw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7ciuzqbBb+POeuiFh-KOFKKzi7LOC6r2vu=WiQ_5tMe7Zw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 10, 2020 at 11:29:49PM +0900, Namhyung Kim wrote:
> On Fri, Jul 10, 2020 at 10:44 PM Changbin Du <changbin.du@gmail.com> wrote:
> >
> > This factors out a general function perf_parse_sublevel_options() to parse
> > sublevel options. The 'sublevel' options is something like the '--debug'
> > options which allow more sublevel options.
> >
> > Signed-off-by: Changbin Du <changbin.du@gmail.com>
> >
> > ---
> > v2: add util/parse-sublevel-options.c
> > ---
> [snip]
> > diff --git a/tools/perf/util/parse-sublevel-options.c b/tools/perf/util/parse-sublevel-options.c
> > new file mode 100644
> > index 000000000000..39798568547c
> > --- /dev/null
> > +++ b/tools/perf/util/parse-sublevel-options.c
> > @@ -0,0 +1,63 @@
> > +#include <stdlib.h>
> > +#include <stdint.h>
> > +#include <string.h>
> > +#include <stdio.h>
> > +
> > +#include "util/debug.h"
> > +#include "util/parse-sublevel-options.h"
> > +
> > +static int parse_one_sublevel_option(const char *str,
> > +                                    struct sublevel_option *opts)
> > +{
> > +       struct sublevel_option *opt = &opts[0];
> > +       char *vstr, *s = strdup(str);
> > +       int v = 1;
> 
> I know you just copied the code, but let's add a check for
> the return value of strdup().
>
yes, the 's' should be checked here.

> Also I think you can just use the opts pointer..
> 
For this, personally I prefer to opt as it's singular form. Because we are
dealing with single element.

> 
> > +
> > +       vstr = strchr(s, '=');
> > +       if (vstr)
> > +               *vstr++ = 0;
> > +
> > +       while (opt->name) {
> > +               if (!strcmp(s, opt->name))
> > +                       break;
> > +               opt++;
> > +       }
> > +
> > +       if (!opt->name) {
> > +               pr_err("Unknown option name '%s'\n", s);
> > +               free(s);
> > +               return -1;
> > +       }
> > +
> > +       if (vstr)
> > +               v = atoi(vstr);
> > +
> > +       *opt->value_ptr = v;
> > +       free(s);
> > +       return 0;
> > +}
> > +
> > +/* parse options like --foo a=<n>,b,c... */
> > +int perf_parse_sublevel_options(const char *str, struct sublevel_option *opts)
> > +{
> > +       char *s = strdup(str);
> > +       char *p = NULL;
> > +       int ret;
> > +
> > +       if (!s)
> > +               return -1;
> > +
> > +       p = strtok(s, ",");
> > +       while (p) {
> > +               ret = parse_one_sublevel_option(p, opts);
> > +               if (ret) {
> > +                       free(s);
> > +                       return ret;
> > +               }
> > +
> > +               p = strtok(NULL, ",");
> > +       }
> > +
> > +       free(s);
> > +       return 0;
> > +}
> > diff --git a/tools/perf/util/parse-sublevel-options.h b/tools/perf/util/parse-sublevel-options.h
> > new file mode 100644
> > index 000000000000..9b9efcc2aaad
> > --- /dev/null
> > +++ b/tools/perf/util/parse-sublevel-options.h
> > @@ -0,0 +1,11 @@
> > +#ifndef _PERF_PARSE_SUBLEVEL_OPTIONS_H
> > +#define _PERF_PARSE_SUBLEVEL_OPTIONS_H
> > +
> > +struct sublevel_option {
> > +       const char *name;
> > +       int *value_ptr;
> > +};
> > +
> > +int perf_parse_sublevel_options(const char *str, struct sublevel_option *opts);
> > +
> > +#endif
> > \ No newline at end of file
> 
> Please add a newline at the end.
> 
> Thanks
> Namhyung
> 
> 
> > --
> > 2.25.1
> >

-- 
Cheers,
Changbin Du
