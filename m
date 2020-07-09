Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76384C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 00:55:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AA7920772
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 00:55:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eo+ggAGI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbgGIAzB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 20:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbgGIAzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 20:55:01 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20876C061A0B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 17:55:01 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id g75so152668wme.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 17:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=msvpLDvjqecx9LlMMsehXjCPgkXnE5LEOAtj+KVjieQ=;
        b=eo+ggAGITdc8fuaE4ILhLXGMOxi7eyHtVCzhUwVFbocWguJcpI9X9AQ6ZJAot6Fi3R
         xmmNMr/RazTdJWybePFdbCoS+H3SWdb+2vQ38XbksvuqYQxgv8SGmwH+PqFpook6Cu5/
         XXU1sOpwHTLW7xXz/jPCXkAFgbh4laLI+3Fc7iDe6M0BukjU2YLTqETNMAa1upeIF6n2
         bc2VTcxzfhyE6BxDDupY9weFdhlObC45aIS3kN/7+TZzDVoP6Cn7FvugSayv8ShdVijJ
         2U4SoXzlH8RVvkcRiYJA/SYu9tgt1xMuzrCtBCv1Z0AzXtwmhk95F91BnMky/JtXq5VW
         IAIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=msvpLDvjqecx9LlMMsehXjCPgkXnE5LEOAtj+KVjieQ=;
        b=jQs6ic8XGmwSJAgcRXH1AtwpG11c0ClaQYMbHNTOw/bCQv8ej9IO5cC52Zv5pWjHu0
         Ix9MXVOCVd+MwIjT3ZP6Qu7Wc8W+SApq9f3TQ5oVXysaoiukYqUxvrLPNj/C0bZ70Lrr
         rt9VB2QfVs39QcDjLIQHVDU2K9gVgEUHVFAVsRRAGz4an6EdBfd+8GcXoJdxn0r2+GwG
         iPOBVUz/Guj+e2/9Ei7u29895Q8lPmR9I2GLukGsAqdO3U7UkYFK8zzyKI4a9cd6uadH
         +QCaR5cJoVbw6bey111dPabZaipKQCdE67JllQnl1J0c1ctbyvscn2BsgV6BfA25yrLV
         g2KA==
X-Gm-Message-State: AOAM531guQ2PUuP1S/KbicUJozrprlQBY5AFnb3D1nn9p+0vLtO4afI/
        11BQ1h8oKLTtk20vZpCLUOm1V4Ts4Eco3r+bx22DRw==
X-Google-Smtp-Source: ABdhPJzAPP1Cj13IH1Cfw54UZgpRwCWm0s5G3dh0hXo+raR75QpxReE3oXVGvMaII9DueUk/WglgmN2cKDRYGiPGbY8=
X-Received: by 2002:a1c:398b:: with SMTP id g133mr11384746wma.76.1594256099409;
 Wed, 08 Jul 2020 17:54:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190726194044.GC24867@kernel.org> <20190729205750.193289-1-nums@google.com>
 <20190807113244.GA9605@krava> <CAP-5=fW8k6YWBYno2RWV5_mojn-0crvmPcLynKGBO_3WMCXfEA@mail.gmail.com>
In-Reply-To: <CAP-5=fW8k6YWBYno2RWV5_mojn-0crvmPcLynKGBO_3WMCXfEA@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 8 Jul 2020 17:54:47 -0700
Message-ID: <CAP-5=fVx1YqNOja4GCAVApQ05BW5Z6CWbAENU3kVCzxJOyKySA@mail.gmail.com>
Subject: Re: [PATCH v2] Fix annotate.c use of uninitialized value error
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Numfor Mbiziwo-Tiapo <nums@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Song Liu <songliubraving@fb.com>, mbd@fb.com,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25, 2019 at 3:11 PM Ian Rogers <irogers@google.com> wrote:
>
> It looks like this wasn't merged to tip. Does anything need addressing
> to get it merged?
>
> Thanks,
> Ian
>
> On Wed, Aug 7, 2019 at 4:32 AM Jiri Olsa <jolsa@redhat.com> wrote:
> >
> > On Mon, Jul 29, 2019 at 01:57:50PM -0700, Numfor Mbiziwo-Tiapo wrote:
> > > Our local MSAN (Memory Sanitizer) build of perf throws a warning
> > > that comes from the "dso__disassemble_filename" function in
> > > "tools/perf/util/annotate.c" when running perf record.
> > >
> > > The warning stems from the call to readlink, in which "build_id_path"
> > > was being read into "linkname". Since readlink does not null terminate,
> > > an uninitialized memory access would later occur when "linkname" is
> > > passed into the strstr function. This is simply fixed by null-terminating
> > > "linkname" after the call to readlink.
> > >
> > > To reproduce this warning, build perf by running:
> > > make -C tools/perf CLANG=1 CC=clang EXTRA_CFLAGS="-fsanitize=memory\
> > >  -fsanitize-memory-track-origins"
> > >
> > > (Additionally, llvm might have to be installed and clang might have to
> > > be specified as the compiler - export CC=/usr/bin/clang)
> > >
> > > then running:
> > > tools/perf/perf record -o - ls / | tools/perf/perf --no-pager annotate\
> > >  -i - --stdio
> > >
> > > Please see the cover letter for why false positive warnings may be
> > > generated.
> > >
> > > Signed-off-by: Numfor Mbiziwo-Tiapo <nums@google.com>
> >
> > Acked-by: Jiri Olsa <jolsa@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Arnaldo, I think this got overlooked. Thanks,

Ian

> > thanks,
> > jirka
> >
> > > ---
> > >  tools/perf/util/annotate.c | 15 +++++++++++----
> > >  1 file changed, 11 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> > > index 70de8f6b3aee..e1b075b52dce 100644
> > > --- a/tools/perf/util/annotate.c
> > > +++ b/tools/perf/util/annotate.c
> > > @@ -1627,6 +1627,7 @@ static int dso__disassemble_filename(struct dso *dso, char *filename, size_t fil
> > >       char *build_id_filename;
> > >       char *build_id_path = NULL;
> > >       char *pos;
> > > +     int len;
> > >
> > >       if (dso->symtab_type == DSO_BINARY_TYPE__KALLSYMS &&
> > >           !dso__is_kcore(dso))
> > > @@ -1655,10 +1656,16 @@ static int dso__disassemble_filename(struct dso *dso, char *filename, size_t fil
> > >       if (pos && strlen(pos) < SBUILD_ID_SIZE - 2)
> > >               dirname(build_id_path);
> > >
> > > -     if (dso__is_kcore(dso) ||
> > > -         readlink(build_id_path, linkname, sizeof(linkname)) < 0 ||
> > > -         strstr(linkname, DSO__NAME_KALLSYMS) ||
> > > -         access(filename, R_OK)) {
> > > +     if (dso__is_kcore(dso))
> > > +             goto fallback;
> > > +
> > > +     len = readlink(build_id_path, linkname, sizeof(linkname) - 1);
> > > +     if (len < 0)
> > > +             goto fallback;
> > > +
> > > +     linkname[len] = '\0';
> > > +     if (strstr(linkname, DSO__NAME_KALLSYMS) ||
> > > +             access(filename, R_OK)) {
> > >  fallback:
> > >               /*
> > >                * If we don't have build-ids or the build-id file isn't in the
> > > --
> > > 2.22.0.709.g102302147b-goog
> > >
