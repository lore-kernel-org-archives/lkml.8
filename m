Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68A2CC10DCE
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 09:30:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73E1F206BE
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 09:30:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TzL2mRYJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbgCOJa1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Mar 2020 05:30:27 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:37553 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726521AbgCOJa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 05:30:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584264625;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rNFz5DYWHgexHyJt056VriaIF9paJuhnZXXnkdcdqbg=;
        b=TzL2mRYJKAgXMfNkumr72/yUVM9jkNg8ca4qTRUeRNaZqDYEWaFeqlhuBt5dpVK5jVFt1T
        uYLVuO6BM7/jv2IqhfgdRNMSlcE6N93R7CQX6AQgvR1tpYZDhleqKwSu7sdwXwjNdGgR+f
        lkym10VwmfyPJ8af6z07X20tRFZvHVA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-460-1ULkcQfGN8SlH9l2u-WY7w-1; Sun, 15 Mar 2020 05:30:21 -0400
X-MC-Unique: 1ULkcQfGN8SlH9l2u-WY7w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9F24B107ACC7;
        Sun, 15 Mar 2020 09:30:19 +0000 (UTC)
Received: from krava (ovpn-204-71.brq.redhat.com [10.40.204.71])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7D467907F7;
        Sun, 15 Mar 2020 09:30:16 +0000 (UTC)
Date:   Sun, 15 Mar 2020 10:30:13 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH] perf mem2node: avoid double free related to realloc
Message-ID: <20200315093013.GC492969@krava>
References: <20200314042826.166953-1-irogers@google.com>
 <20200314142332.GB492969@krava>
 <CAP-5=fXZJidxHYeCqHcNPBArMe_aYwP0+u2dxiTD+V1fammK_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fXZJidxHYeCqHcNPBArMe_aYwP0+u2dxiTD+V1fammK_Q@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 14, 2020 at 09:49:37AM -0700, Ian Rogers wrote:
> On Sat, Mar 14, 2020 at 7:23 AM Jiri Olsa <jolsa@redhat.com> wrote:
> >
> > On Fri, Mar 13, 2020 at 09:28:26PM -0700, Ian Rogers wrote:
> > > Realloc of size zero is a free not an error, avoid this causing a double
> > > free. Caught by clang's address sanitizer:
> > >
> > > ==2634==ERROR: AddressSanitizer: attempting double-free on 0x6020000015f0 in thread T0:
> > >     #0 0x5649659297fd in free llvm/llvm-project/compiler-rt/lib/asan/asan_malloc_linux.cpp:123:3
> > >     #1 0x5649659e9251 in __zfree tools/lib/zalloc.c:13:2
> > >     #2 0x564965c0f92c in mem2node__exit tools/perf/util/mem2node.c:114:2
> > >     #3 0x564965a08b4c in perf_c2c__report tools/perf/builtin-c2c.c:2867:2
> > >     #4 0x564965a0616a in cmd_c2c tools/perf/builtin-c2c.c:2989:10
> > >     #5 0x564965944348 in run_builtin tools/perf/perf.c:312:11
> > >     #6 0x564965943235 in handle_internal_command tools/perf/perf.c:364:8
> > >     #7 0x5649659440c4 in run_argv tools/perf/perf.c:408:2
> > >     #8 0x564965942e41 in main tools/perf/perf.c:538:3
> > >
> > > 0x6020000015f0 is located 0 bytes inside of 1-byte region [0x6020000015f0,0x6020000015f1)
> > > freed by thread T0 here:
> > >     #0 0x564965929da3 in realloc third_party/llvm/llvm-project/compiler-rt/lib/asan/asan_malloc_linux.cpp:164:3
> > >     #1 0x564965c0f55e in mem2node__init tools/perf/util/mem2node.c:97:16
> > >     #2 0x564965a08956 in perf_c2c__report tools/perf/builtin-c2c.c:2803:8
> > >     #3 0x564965a0616a in cmd_c2c tools/perf/builtin-c2c.c:2989:10
> > >     #4 0x564965944348 in run_builtin tools/perf/perf.c:312:11
> > >     #5 0x564965943235 in handle_internal_command tools/perf/perf.c:364:8
> > >     #6 0x5649659440c4 in run_argv tools/perf/perf.c:408:2
> > >     #7 0x564965942e41 in main tools/perf/perf.c:538:3
> > >
> > > previously allocated by thread T0 here:
> > >     #0 0x564965929c42 in calloc third_party/llvm/llvm-project/compiler-rt/lib/asan/asan_malloc_linux.cpp:154:3
> > >     #1 0x5649659e9220 in zalloc tools/lib/zalloc.c:8:9
> > >     #2 0x564965c0f32d in mem2node__init tools/perf/util/mem2node.c:61:12
> > >     #3 0x564965a08956 in perf_c2c__report tools/perf/builtin-c2c.c:2803:8
> > >     #4 0x564965a0616a in cmd_c2c tools/perf/builtin-c2c.c:2989:10
> > >     #5 0x564965944348 in run_builtin tools/perf/perf.c:312:11
> > >     #6 0x564965943235 in handle_internal_command tools/perf/perf.c:364:8
> > >     #7 0x5649659440c4 in run_argv tools/perf/perf.c:408:2
> > >     #8 0x564965942e41 in main tools/perf/perf.c:538:3
> > >
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > ---
> > >  tools/perf/util/mem2node.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/tools/perf/util/mem2node.c b/tools/perf/util/mem2node.c
> > > index 797d86a1ab09..7f97aa69eb65 100644
> > > --- a/tools/perf/util/mem2node.c
> > > +++ b/tools/perf/util/mem2node.c
> > > @@ -95,7 +95,7 @@ int mem2node__init(struct mem2node *map, struct perf_env *env)
> > >
> > >       /* Cut unused entries, due to merging. */
> > >       tmp_entries = realloc(entries, sizeof(*entries) * j);
> > > -     if (tmp_entries)
> > > +     if (j == 0 || tmp_entries)
> >
> > nice catch.. I wonder if we should fail in here, or at least
> > warn that there're no entris.. which is really strange ;-)
> 
> The workload was the stream benchmark with perf c2c, but stream isn't
> particularly long running. Not sure how j became 0, there's 2
> possibilities in the code. The worry with a warning is the spam, so I
> just wanted to make the code correct.

I was wondering if we should fail completely,
but we might break some c2c expected behaviour

how about just WARN_ONCE pn j == 0, and then
the lookup will fail already with:

        if (WARN_ONCE(node < 0, "WARNING: failed to find node\n"))
                return;

just get enough hints ;-)

jirka

> 
> Thanks,
> Ian
> 
> > thanks,
> > jirka
> >
> > >               entries = tmp_entries;
> > >
> > >       for (i = 0; i < j; i++) {
> > > --
> > > 2.25.1.481.gfbce0eb801-goog
> > >
> >
> 

