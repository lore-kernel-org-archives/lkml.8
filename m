Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B4D6C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 14:01:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7328020578
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 14:01:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kFUEjZ3g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388799AbgDNOBt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 10:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388766AbgDNOBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 10:01:32 -0400
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8660C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 07:01:31 -0700 (PDT)
Received: by mail-yb1-xb41.google.com with SMTP id f14so7208677ybr.13
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 07:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MIDJlS/B7wlQH2YydJ9/dEBDpObouopjC3wL/DmqL9o=;
        b=kFUEjZ3goTyjvkRtvIf6sCblHsCruQDZnTnWWDm05zXBv7/PvbjH6ibUv32LNttn4x
         4LGfDYhSEGcpxmkVV2noww0NRJTQcXLuctwvvkhCgEcSRLIXboJr8zFnlOK7meFwxmhQ
         a5Re0yCt6xmctNlV2+YnzA3aObhiVDqlcJ1hYRG9GeVBTrI5Irwetg0YkDRH4pZRNvNF
         +2TZWrwf0IONYd2YXHXMKcy9ZAaY5DAoE+3dd4I3X0EyFo/zqAHI2W/2+TBY3QgU1uMt
         P/gKnNe+dZliDr6yLR3N6v8aqVMd0cJX/NlA+Q9RfRvOZR1FB1GDlUnMMGCqm5tMUcpq
         jPaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MIDJlS/B7wlQH2YydJ9/dEBDpObouopjC3wL/DmqL9o=;
        b=cdNzjq/HrQFW/gSUiBgDZOhzjcd+rtAwMmRpQdwPrXUt6LpYJDYUAJrxNvRyoict1e
         BSkgd8BgX+8jbunK60fxAuy8GxClcS92xpSVskH2zyuDPbkrVdqaBZ+X9HFokG8gNy8D
         7dxVCw8jHl4NGY8vskAT+02j6z3Lgq7UobToCYMuFD+bG5PptbypMfBcrQiIPOA4Ppaw
         wQdFU9p3W3hTgqpKQXc0g3qqq0M+8Th5XFb67cWS9zRnbWgpSBw5OMrpsk8QrD1q5tNf
         cBjq6QUNFIOEAOrq3IIaspbaWfi4/ofUKxFUGm+o01Ez5oBuIsdJujiu85+5KDOSx6T8
         a1rA==
X-Gm-Message-State: AGi0PuZZloRsrf2/l8o5giKdjUED3bL2DM4CiOzLnXh9mo9KL7xnK7Q/
        XCO26dRs4wJuOlnT+rF8U9aOPhQlP9mUkRIo2AgzLw==
X-Google-Smtp-Source: APiQypItgskixgRfRGKi8eqR0/m5Z4IRus8H7UVib4WzuiYeNZm99KFXbfvo1afyBUdLKm/Ibah+wYPyayyGiY01ri0=
X-Received: by 2002:a25:d993:: with SMTP id q141mr164348ybg.403.1586872890503;
 Tue, 14 Apr 2020 07:01:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200409185744.255881-1-irogers@google.com> <20200414125105.GC117177@krava>
In-Reply-To: <20200414125105.GC117177@krava>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 14 Apr 2020 07:01:19 -0700
Message-ID: <CAP-5=fXRN-h3M4s5XYtA=PX+qxZVvBiE94xRF9RN7zHG9fYE1w@mail.gmail.com>
Subject: Re: [PATCH] perf data: if a bad header size, retry in pipe mode
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 14, 2020 at 5:51 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Thu, Apr 09, 2020 at 11:57:44AM -0700, Ian Rogers wrote:
> > Currently pipe mode files fail like:
> > $ perf record -o - sleep 1 > /tmp/perf.pipe.data
> > $ perf report -i /tmp/perf.pipe.data
> > incompatible file format (rerun with -v to learn more)
> >
> > This change makes it so that if a perf.data file's header size is wrong
> > it is re-checked in pipe mode, where if wrong it fails as it currently
> > does.
> >
>
> hi,
> how about doing it the other way round like below,
> read header and find out if it's pipe..
>
> seems it's less changes
>
> jirka

Looks good to me. I think removing the function declaration from
util/header.h is still worthwhile, but needn't be in a patch with this
change.

Thanks!
Ian

> ---
> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index acbd046bf95c..20c34cec9a46 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -3469,7 +3469,7 @@ static int perf_header__read_pipe(struct perf_session *session)
>                 return -EINVAL;
>         }
>
> -       return 0;
> +       return f_header.size == sizeof(f_header) ? 0 : -1;
>  }
>
>  static int read_attr(int fd, struct perf_header *ph,
> @@ -3571,7 +3571,7 @@ int perf_session__read_header(struct perf_session *session)
>         struct perf_file_header f_header;
>         struct perf_file_attr   f_attr;
>         u64                     f_id;
> -       int nr_attrs, nr_ids, i, j;
> +       int nr_attrs, nr_ids, i, j, err;
>         int fd = perf_data__fd(data);
>
>         session->evlist = evlist__new();
> @@ -3580,8 +3580,16 @@ int perf_session__read_header(struct perf_session *session)
>
>         session->evlist->env = &header->env;
>         session->machines.host.env = &header->env;
> -       if (perf_data__is_pipe(data))
> -               return perf_header__read_pipe(session);
> +
> +       /*
> +        * We could still read 'pipe' data from regular file,
> +        * check for the pipe header first.
> +        */
> +       err = perf_header__read_pipe(session);
> +       if (!err || (err && perf_data__is_pipe(data))) {
> +               data->is_pipe = true;
> +               return err;
> +       }
>
>         if (perf_file_header__read(&f_header, header, fd) < 0)
>                 return -EINVAL;
>
