Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BCD9C4724C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 15:34:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3372720661
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 15:34:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LlGi3ZL9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727890AbgD3Pe5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 11:34:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36955 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727874AbgD3Pe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 11:34:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588260895;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=C22aH0fz8DA6IZeCgBxInpVn3oEYYNaN8sS5dDQDJtQ=;
        b=LlGi3ZL9bCpKkazI6YVg6mS+77SfuMJIzgKZ03hAeUcYFbeBTnf590YrDOkZMSHY0jXXQD
        ZQJn3y7Rv7lVPmPACanRPO/1qll6dTNwois3x6hnnYYYE098pP5jDgsl57frd1I/CVwAbJ
        c6Sy1b0VHAfVEMyJPRHZcNtK+Ow6038=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-364-JD-D-Pn7MD-DfbJmZ1QOGA-1; Thu, 30 Apr 2020 11:34:51 -0400
X-MC-Unique: JD-D-Pn7MD-DfbJmZ1QOGA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AF8C9107B266;
        Thu, 30 Apr 2020 15:34:49 +0000 (UTC)
Received: from krava (unknown [10.40.192.9])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4F65360E1C;
        Thu, 30 Apr 2020 15:34:47 +0000 (UTC)
Date:   Thu, 30 Apr 2020 17:34:44 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>
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
Subject: Re: [PATCH] perf data: if a bad header size, retry in pipe mode
Message-ID: <20200430153444.GG1694693@krava>
References: <20200409185744.255881-1-irogers@google.com>
 <20200414125105.GC117177@krava>
 <CAP-5=fXRN-h3M4s5XYtA=PX+qxZVvBiE94xRF9RN7zHG9fYE1w@mail.gmail.com>
 <CAP-5=fW0+FyFkakrYL6MYYYSQ_8F8kP+AhZ6W1Aqgophegzamg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fW0+FyFkakrYL6MYYYSQ_8F8kP+AhZ6W1Aqgophegzamg@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 30, 2020 at 07:12:49AM -0700, Ian Rogers wrote:
> On Tue, Apr 14, 2020 at 7:01 AM Ian Rogers <irogers@google.com> wrote:
> >
> > On Tue, Apr 14, 2020 at 5:51 AM Jiri Olsa <jolsa@redhat.com> wrote:
> > >
> > > On Thu, Apr 09, 2020 at 11:57:44AM -0700, Ian Rogers wrote:
> > > > Currently pipe mode files fail like:
> > > > $ perf record -o - sleep 1 > /tmp/perf.pipe.data
> > > > $ perf report -i /tmp/perf.pipe.data
> > > > incompatible file format (rerun with -v to learn more)
> > > >
> > > > This change makes it so that if a perf.data file's header size is wrong
> > > > it is re-checked in pipe mode, where if wrong it fails as it currently
> > > > does.
> > > >
> > >
> > > hi,
> > > how about doing it the other way round like below,
> > > read header and find out if it's pipe..
> > >
> > > seems it's less changes
> > >
> > > jirka
> >
> > Looks good to me. I think removing the function declaration from
> > util/header.h is still worthwhile, but needn't be in a patch with this
> > change.
> 
> Hi Jiri,
> 
> Do you need to send this patch?

ah right, will post, thanks for reminder

jirka

> 
> Thanks,
> Ian
> 
> > Thanks!
> > Ian
> >
> > > ---
> > > diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> > > index acbd046bf95c..20c34cec9a46 100644
> > > --- a/tools/perf/util/header.c
> > > +++ b/tools/perf/util/header.c
> > > @@ -3469,7 +3469,7 @@ static int perf_header__read_pipe(struct perf_session *session)
> > >                 return -EINVAL;
> > >         }
> > >
> > > -       return 0;
> > > +       return f_header.size == sizeof(f_header) ? 0 : -1;
> > >  }
> > >
> > >  static int read_attr(int fd, struct perf_header *ph,
> > > @@ -3571,7 +3571,7 @@ int perf_session__read_header(struct perf_session *session)
> > >         struct perf_file_header f_header;
> > >         struct perf_file_attr   f_attr;
> > >         u64                     f_id;
> > > -       int nr_attrs, nr_ids, i, j;
> > > +       int nr_attrs, nr_ids, i, j, err;
> > >         int fd = perf_data__fd(data);
> > >
> > >         session->evlist = evlist__new();
> > > @@ -3580,8 +3580,16 @@ int perf_session__read_header(struct perf_session *session)
> > >
> > >         session->evlist->env = &header->env;
> > >         session->machines.host.env = &header->env;
> > > -       if (perf_data__is_pipe(data))
> > > -               return perf_header__read_pipe(session);
> > > +
> > > +       /*
> > > +        * We could still read 'pipe' data from regular file,
> > > +        * check for the pipe header first.
> > > +        */
> > > +       err = perf_header__read_pipe(session);
> > > +       if (!err || (err && perf_data__is_pipe(data))) {
> > > +               data->is_pipe = true;
> > > +               return err;
> > > +       }
> > >
> > >         if (perf_file_header__read(&f_header, header, fd) < 0)
> > >                 return -EINVAL;
> > >
> 

