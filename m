Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BFF5C28CBC
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 14:13:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7FF0206D9
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 14:13:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pk7zbkMm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728690AbgD3ONJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 10:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726830AbgD3ONE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 10:13:04 -0400
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7C17C035494
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 07:13:03 -0700 (PDT)
Received: by mail-yb1-xb44.google.com with SMTP id p7so3247930ybo.12
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 07:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RuWwUfWQPRmorLJ8b4zPbt9Fzldh22r5PvhTsct28+I=;
        b=pk7zbkMmpolApkEOyS3DR9EpWhiAdivVNW9DyuWBuWmykocUs1WMpHP3+1cKYrJDFt
         fUY2r3pHLWypxFMnu8f8gwOQeCTfc+MCr/KCIl6f0q8sXIUnpPoxWR2ACDSMxnCvGX+9
         TPs6FhDnt6eoep0i+XYqgQiB5AU/7zOWPAd3yaVzAsbIXsWq8ttxqtWmm7U4HXaMix/v
         wVGxFG2ziimHkpUyfODY85r/+MWa/FTDTlPCV77olgN/52pXUWbexTtE4n020G/fJSQV
         TZCUaeNnACcCno+1i/Xka0EAdccl7aU27HZHFQhxKfJ+UluRikOeMomXMl2MmF/7bOMK
         D4Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RuWwUfWQPRmorLJ8b4zPbt9Fzldh22r5PvhTsct28+I=;
        b=nWnLn5ivIPI6pucaXZjRJIVU5wuUDCFfk9abKnz5zclTNebJIFAzturiA6Tp37WdLx
         mCRt07s0qez0T3/J4P8+zOW1Ozubw39N/jNXxJlc5iq0VlzPNtCZgw6Wvr3KZwRMg78+
         H/0xISwT4QMDtdHlHmxLt1eEL7TbLpk3tDEG4oEXPOWmmU4UtaEyngCpKMX3R9VNtwRp
         uZPZxNONVV3wnA8DQr163Q3z4GmgH5mWY+4oiSnI8lSCgYVLz18FWguAyHUcXh5SfQSn
         wVSIf0Y4ERNT2BYd2tLsaVEycJhhG0TVDNFMQIUqU+Fm9tk7JYdxbLSrHZT95ElkYpH7
         PUHw==
X-Gm-Message-State: AGi0PuaYTB5mzF8d3Yn1UvqMpF3nyEt30+e5cT07Ianod1GEmOd5DBl9
        Er67v1aRxRGaPGdfMAlZ32NSXddjDHSumdYiYJe4eA==
X-Google-Smtp-Source: APiQypKm5TqtGiKOOqwKJzOfYvb5QkQThWB3by2Fk9vyZpGFSzLNc6qrnPaoU2AON83sJot6qF68YMUxNVn9il077vA=
X-Received: by 2002:a25:ddc3:: with SMTP id u186mr6092717ybg.383.1588255982479;
 Thu, 30 Apr 2020 07:13:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200409185744.255881-1-irogers@google.com> <20200414125105.GC117177@krava>
 <CAP-5=fXRN-h3M4s5XYtA=PX+qxZVvBiE94xRF9RN7zHG9fYE1w@mail.gmail.com>
In-Reply-To: <CAP-5=fXRN-h3M4s5XYtA=PX+qxZVvBiE94xRF9RN7zHG9fYE1w@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 30 Apr 2020 07:12:49 -0700
Message-ID: <CAP-5=fW0+FyFkakrYL6MYYYSQ_8F8kP+AhZ6W1Aqgophegzamg@mail.gmail.com>
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

On Tue, Apr 14, 2020 at 7:01 AM Ian Rogers <irogers@google.com> wrote:
>
> On Tue, Apr 14, 2020 at 5:51 AM Jiri Olsa <jolsa@redhat.com> wrote:
> >
> > On Thu, Apr 09, 2020 at 11:57:44AM -0700, Ian Rogers wrote:
> > > Currently pipe mode files fail like:
> > > $ perf record -o - sleep 1 > /tmp/perf.pipe.data
> > > $ perf report -i /tmp/perf.pipe.data
> > > incompatible file format (rerun with -v to learn more)
> > >
> > > This change makes it so that if a perf.data file's header size is wrong
> > > it is re-checked in pipe mode, where if wrong it fails as it currently
> > > does.
> > >
> >
> > hi,
> > how about doing it the other way round like below,
> > read header and find out if it's pipe..
> >
> > seems it's less changes
> >
> > jirka
>
> Looks good to me. I think removing the function declaration from
> util/header.h is still worthwhile, but needn't be in a patch with this
> change.

Hi Jiri,

Do you need to send this patch?

Thanks,
Ian

> Thanks!
> Ian
>
> > ---
> > diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> > index acbd046bf95c..20c34cec9a46 100644
> > --- a/tools/perf/util/header.c
> > +++ b/tools/perf/util/header.c
> > @@ -3469,7 +3469,7 @@ static int perf_header__read_pipe(struct perf_session *session)
> >                 return -EINVAL;
> >         }
> >
> > -       return 0;
> > +       return f_header.size == sizeof(f_header) ? 0 : -1;
> >  }
> >
> >  static int read_attr(int fd, struct perf_header *ph,
> > @@ -3571,7 +3571,7 @@ int perf_session__read_header(struct perf_session *session)
> >         struct perf_file_header f_header;
> >         struct perf_file_attr   f_attr;
> >         u64                     f_id;
> > -       int nr_attrs, nr_ids, i, j;
> > +       int nr_attrs, nr_ids, i, j, err;
> >         int fd = perf_data__fd(data);
> >
> >         session->evlist = evlist__new();
> > @@ -3580,8 +3580,16 @@ int perf_session__read_header(struct perf_session *session)
> >
> >         session->evlist->env = &header->env;
> >         session->machines.host.env = &header->env;
> > -       if (perf_data__is_pipe(data))
> > -               return perf_header__read_pipe(session);
> > +
> > +       /*
> > +        * We could still read 'pipe' data from regular file,
> > +        * check for the pipe header first.
> > +        */
> > +       err = perf_header__read_pipe(session);
> > +       if (!err || (err && perf_data__is_pipe(data))) {
> > +               data->is_pipe = true;
> > +               return err;
> > +       }
> >
> >         if (perf_file_header__read(&f_header, header, fd) < 0)
> >                 return -EINVAL;
> >
