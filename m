Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C95EC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 17:43:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E701620737
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 17:43:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aeNgAjhr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390099AbgDBRn2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 13:43:28 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:43655 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389264AbgDBRn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 13:43:28 -0400
Received: by mail-yb1-f194.google.com with SMTP id o70so2589975ybg.10
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 10:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z3JH/257xqgnKfhrMVLzqgdi3eoal24QYk5pO+jE35M=;
        b=aeNgAjhrHnsDa2dGp9MylY7r7uaw5pxlaUFoDAABd9ZjmJFPANwAPd9Br40vhNeb7t
         8Sp3GAtndjP0bw2NyoaqtqjlD5P+I+4cQRv8cdkDmm7UI56OpWs3Lq1PLaorB4TrPL6z
         DRocLghTJF8t8cbdAKLx+pqk1vgcqqBZ3PhMF/89Q0kxuA4C/YyBaG7zcjuI0Us6k7fk
         /NBgtiY1fcRVeeLbFlvKv1U2iZmTLNT8uOyIr+VNky1ZzBQx5SW30VV6X0Ngj1/BzPkg
         QpA8UfSbP3YevU1Cc2EguoENjPjaISAIFQI+KIW94OK5bAOH8xHp5fu7bqzXetXGm6eI
         8O7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z3JH/257xqgnKfhrMVLzqgdi3eoal24QYk5pO+jE35M=;
        b=RW4mt15Vu4BX1u6LIk2mO/nI53M8QTd515lLaqPZM51VeLdEsMrq/sW9bxAUuIF0nX
         CFU0gHRoDb8bDUIzucjuXgNh9MGs6+Ku/Tj85xTZV8BVcLNyeflrgaPlMEBOcz3i18H1
         OXf4bPkuPOTr9cjK9+y3JVT4KoHVMFHBfjjN8rNoQEZbAmovr6VKJd27iW9aMMpEMAM2
         nPiaQmnN/biZ1ZSy2VCILXA0Y0+Gil+mbqenyq8Aq0McJaJBzJH3TXNxRz0ORNC6l3+i
         3tXS6d6fvDKYtKyD7WuEEkoqEXC0PJgVeh7yq9luetmZCOoF9GoDo+AGD6h86WjF1mj6
         VKbA==
X-Gm-Message-State: AGi0Pua0Fw67/cY0Rioad4DY9EXmWMN1eWPCAAdjNUDr/8hk29k6JAhg
        vnwkuwjB71QIrbck53tP2HsYka5/PG9CzS2gUQyX7w==
X-Google-Smtp-Source: APiQypJ7L3y78pafhiuxwi6Hov0zeKpMj7OEb+pW2hNM2rrXyn2OsSi0EGEw1w2MKlXdiRj8T+WhayssQ4sSpQ4rjr0=
X-Received: by 2002:a25:c64b:: with SMTP id k72mr7733368ybf.177.1585849405706;
 Thu, 02 Apr 2020 10:43:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200325220802.15039-1-irogers@google.com> <20200331191128.GL9917@kernel.org>
In-Reply-To: <20200331191128.GL9917@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 2 Apr 2020 10:43:14 -0700
Message-ID: <CAP-5=fUkOaP+xzWDQyxttHEx2pbPkZKMbP7-2Pvu4mYXJrnhug@mail.gmail.com>
Subject: Re: [PATCH] perf/script: allow --symbol to accept hexadecimal addresses
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 31, 2020 at 12:11 PM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
> Em Wed, Mar 25, 2020 at 03:08:02PM -0700, Ian Rogers escreveu:
> > From: Stephane Eranian <eranian@google.com>
> >
> > This patch extends the perf script --symbols option to filter
> > on hexadecimal addresses in addition to symbol names. This makes
> > it easier to handle cases where symbols are aliased.
> >
> > With this patch, it is possible to mix and match symbols and hexadecimal
> > addresses using the --symbols option.
> >
> > $ perf script --symbols=noploop,0x4007a0
>
> Applied, can you please send a followup patch to the man page stating
> that this is supported?

Many thanks! I've sent:
https://lore.kernel.org/lkml/20200402174130.140319-1-irogers@google.com/T/#u

Ian

> Thanks,
>
> - Arnaldo
>
> > Reviewed-by: Ian Rogers <irogers@google.com>
> > Signed-off-by: Stephane Eranian <eranian@google.com>
> > ---
> >  tools/perf/util/event.c | 21 +++++++++++++++++----
> >  1 file changed, 17 insertions(+), 4 deletions(-)
> >
> > diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
> > index c5447ff516a2..c978a73fe475 100644
> > --- a/tools/perf/util/event.c
> > +++ b/tools/perf/util/event.c
> > @@ -599,10 +599,23 @@ int machine__resolve(struct machine *machine, struct addr_location *al,
> >               al->sym = map__find_symbol(al->map, al->addr);
> >       }
> >
> > -     if (symbol_conf.sym_list &&
> > -             (!al->sym || !strlist__has_entry(symbol_conf.sym_list,
> > -                                             al->sym->name))) {
> > -             al->filtered |= (1 << HIST_FILTER__SYMBOL);
> > +     if (symbol_conf.sym_list) {
> > +             int ret = 0;
> > +             char al_addr_str[32];
> > +             size_t sz = sizeof(al_addr_str);
> > +
> > +             if (al->sym) {
> > +                     ret = strlist__has_entry(symbol_conf.sym_list,
> > +                                             al->sym->name);
> > +             }
> > +             if (!(ret && al->sym)) {
> > +                     snprintf(al_addr_str, sz, "0x%"PRIx64,
> > +                             al->map->unmap_ip(al->map, al->sym->start));
> > +                     ret = strlist__has_entry(symbol_conf.sym_list,
> > +                                             al_addr_str);
> > +             }
> > +             if (!ret)
> > +                     al->filtered |= (1 << HIST_FILTER__SYMBOL);
> >       }
> >
> >       return 0;
> > --
> > 2.25.1.696.g5e7596f4ac-goog
> >
>
> --
>
> - Arnaldo
