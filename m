Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F30CCC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 15:38:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7A052077D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 15:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594309128;
	bh=L0YHyaVnrGtsrYU/MOJaw8jpmow7WmEpb0uvKXYmZ/w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Qxj7gsFyhmqiNi8KCCVhxPhGRaYxAhuAYi3pi3inxe/pRrSZJbcOg6FPVx/dREt+2
	 44Xnl0LZ2X8aaiM3JfFo3x+znXWsBG9DX6cNr7NdLbleo4JSxikXNERjJ2HAGAriUD
	 dwydN493wpcMrMtEEwuvCuBKwXGT78SEBUWxTZHM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbgGIPir (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 11:38:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:44298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726339AbgGIPir (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 11:38:47 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 012D720720;
        Thu,  9 Jul 2020 15:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594309126;
        bh=L0YHyaVnrGtsrYU/MOJaw8jpmow7WmEpb0uvKXYmZ/w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BbT1W8mOKlsd9oZlX+zEwJ+k4sQrfbiB+LYaqVy6quzl84kh3UMvL9E1ZEqLes9kv
         jDh9/S7dyTE+tehwP+Ctr+jup7P9ZqNHyc1HjpYaGbAxzNvdKHj1YlAROST2en5Ka8
         7LAW7cT5QZHXANkqGHgq8FWp34kCXYUh55kU/RuA=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 11AD4405FF; Thu,  9 Jul 2020 12:38:44 -0300 (-03)
Date:   Thu, 9 Jul 2020 12:38:44 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Numfor Mbiziwo-Tiapo <nums@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Song Liu <songliubraving@fb.com>, mbd@fb.com,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v2] Fix annotate.c use of uninitialized value error
Message-ID: <20200709153844.GA7487@kernel.org>
References: <20190726194044.GC24867@kernel.org>
 <20190729205750.193289-1-nums@google.com>
 <20190807113244.GA9605@krava>
 <CAP-5=fW8k6YWBYno2RWV5_mojn-0crvmPcLynKGBO_3WMCXfEA@mail.gmail.com>
 <CAP-5=fVx1YqNOja4GCAVApQ05BW5Z6CWbAENU3kVCzxJOyKySA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fVx1YqNOja4GCAVApQ05BW5Z6CWbAENU3kVCzxJOyKySA@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Jul 08, 2020 at 05:54:47PM -0700, Ian Rogers escreveu:
> On Fri, Oct 25, 2019 at 3:11 PM Ian Rogers <irogers@google.com> wrote:
> >
> > It looks like this wasn't merged to tip. Does anything need addressing
> > to get it merged?

Finally processed, thanks for the multiple reminders,

- Arnaldo

> > Thanks,
> > Ian
> >
> > On Wed, Aug 7, 2019 at 4:32 AM Jiri Olsa <jolsa@redhat.com> wrote:
> > >
> > > On Mon, Jul 29, 2019 at 01:57:50PM -0700, Numfor Mbiziwo-Tiapo wrote:
> > > > Our local MSAN (Memory Sanitizer) build of perf throws a warning
> > > > that comes from the "dso__disassemble_filename" function in
> > > > "tools/perf/util/annotate.c" when running perf record.
> > > >
> > > > The warning stems from the call to readlink, in which "build_id_path"
> > > > was being read into "linkname". Since readlink does not null terminate,
> > > > an uninitialized memory access would later occur when "linkname" is
> > > > passed into the strstr function. This is simply fixed by null-terminating
> > > > "linkname" after the call to readlink.
> > > >
> > > > To reproduce this warning, build perf by running:
> > > > make -C tools/perf CLANG=1 CC=clang EXTRA_CFLAGS="-fsanitize=memory\
> > > >  -fsanitize-memory-track-origins"
> > > >
> > > > (Additionally, llvm might have to be installed and clang might have to
> > > > be specified as the compiler - export CC=/usr/bin/clang)
> > > >
> > > > then running:
> > > > tools/perf/perf record -o - ls / | tools/perf/perf --no-pager annotate\
> > > >  -i - --stdio
> > > >
> > > > Please see the cover letter for why false positive warnings may be
> > > > generated.
> > > >
> > > > Signed-off-by: Numfor Mbiziwo-Tiapo <nums@google.com>
> > >
> > > Acked-by: Jiri Olsa <jolsa@kernel.org>
> 
> Acked-by: Ian Rogers <irogers@google.com>
> 
> Arnaldo, I think this got overlooked. Thanks,
> 
> Ian
> 
> > > thanks,
> > > jirka
> > >
> > > > ---
> > > >  tools/perf/util/annotate.c | 15 +++++++++++----
> > > >  1 file changed, 11 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> > > > index 70de8f6b3aee..e1b075b52dce 100644
> > > > --- a/tools/perf/util/annotate.c
> > > > +++ b/tools/perf/util/annotate.c
> > > > @@ -1627,6 +1627,7 @@ static int dso__disassemble_filename(struct dso *dso, char *filename, size_t fil
> > > >       char *build_id_filename;
> > > >       char *build_id_path = NULL;
> > > >       char *pos;
> > > > +     int len;
> > > >
> > > >       if (dso->symtab_type == DSO_BINARY_TYPE__KALLSYMS &&
> > > >           !dso__is_kcore(dso))
> > > > @@ -1655,10 +1656,16 @@ static int dso__disassemble_filename(struct dso *dso, char *filename, size_t fil
> > > >       if (pos && strlen(pos) < SBUILD_ID_SIZE - 2)
> > > >               dirname(build_id_path);
> > > >
> > > > -     if (dso__is_kcore(dso) ||
> > > > -         readlink(build_id_path, linkname, sizeof(linkname)) < 0 ||
> > > > -         strstr(linkname, DSO__NAME_KALLSYMS) ||
> > > > -         access(filename, R_OK)) {
> > > > +     if (dso__is_kcore(dso))
> > > > +             goto fallback;
> > > > +
> > > > +     len = readlink(build_id_path, linkname, sizeof(linkname) - 1);
> > > > +     if (len < 0)
> > > > +             goto fallback;
> > > > +
> > > > +     linkname[len] = '\0';
> > > > +     if (strstr(linkname, DSO__NAME_KALLSYMS) ||
> > > > +             access(filename, R_OK)) {
> > > >  fallback:
> > > >               /*
> > > >                * If we don't have build-ids or the build-id file isn't in the
> > > > --
> > > > 2.22.0.709.g102302147b-goog
> > > >

-- 

- Arnaldo
