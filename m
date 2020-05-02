Return-Path: <SRS0=7DLR=6Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1558C3A5A9
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 15:11:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C333B2072E
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 15:11:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iY9gEDc7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728202AbgEBPLx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 May 2020 11:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728023AbgEBPLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 May 2020 11:11:52 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 314A1C061A0C
        for <linux-kernel@vger.kernel.org>; Sat,  2 May 2020 08:11:52 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id s30so10332199qth.2
        for <linux-kernel@vger.kernel.org>; Sat, 02 May 2020 08:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=f945qmsRocAEp8gf6rmU05hEia4s9EsqMMhwTZIcQws=;
        b=iY9gEDc7QWiLE1i4WH7KVUlEPpYzLSF8IKdVH4VdhDicc3JWEEBvXEvrgRPsxFMYqE
         1UDADJGVYQBEwcvrQfU+MZmQG3lxekJ4o8dW9hHmidnokW7bIBdivEX7zThVUj9y9aId
         W7CNfI3+mfUEk06Cmqf+F3wSJNBBJ2sjqbchcTpEr2bzLY7//gUd4jlAI9b9oaQsLezb
         sNB112f3nDJacrdEC6gIB7/DjOGbLeRaIURdk7kYGNqPJ2tfc5CRj1JltZ9X3F8eyWHf
         aYjDkWTQi5uWf/oTiZh2rK45+WcKzVJEUe2tYaoaAnuVMVj5LNcrnHiTrlbnSb56WcsW
         2EFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=f945qmsRocAEp8gf6rmU05hEia4s9EsqMMhwTZIcQws=;
        b=Mm69BVNE12oD/3iOc+/XsktM5mImUOjOYPWJD8Wn+HmHsEgnjOm38C+INatSkYloD3
         gyqs1dwPYrFovJtU5pLvzepK3j5CrzcvjRpwbGd2lurvnat91w/n9eOB8HmF8iqBsdrV
         +QnzrfkngC4MbF7Z9L9Oi8NME4qdph01b0vYAa571KmYYJ169OosQJ0NzmTNLxrTOmqg
         Jq92xXMfzD9VffgzbAsJy15wH2eJxYP+1yDZObbmobO468NsM5YjXmRyJK0Q3Z50yaYo
         LVZIRG0XjhC0ebf7bhEQNBkuw5EhnEcWaz1qn1Cd5OF/zyBAGlXpEv5Cp+hA3fnDLp9i
         rBtQ==
X-Gm-Message-State: AGi0PuYh1NT71qkYsFdv83/C14Qo9kZyNT7T4pUdBJ0ii/Htsk44zYz4
        p7Tc+U3JDPUIHFOJEqSm7iA=
X-Google-Smtp-Source: APiQypJb3RSWfr7wWeygr6gn0Bn6jsLjHZw0Gc4rMKnUxFMaud/JBfMsnnJ8e1Jg9NXrb9qh1XcK+Q==
X-Received: by 2002:ac8:6757:: with SMTP id n23mr8822961qtp.304.1588432311225;
        Sat, 02 May 2020 08:11:51 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id h6sm5318820qtd.79.2020.05.02.08.11.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2020 08:11:50 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 24EAC409A3; Sat,  2 May 2020 12:11:48 -0300 (-03)
Date:   Sat, 2 May 2020 12:11:48 -0300
To:     Ian Rogers <irogers@google.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v2 1/2] perf parse-events: fix memory leaks found on
 parse_events
Message-ID: <20200502151148.GA5377@kernel.org>
References: <20200319023101.82458-1-irogers@google.com>
 <20200429175420.GD30487@kernel.org>
 <CAP-5=fWTAbyOXr5GghrbvfkaZ6EzH7GNDJiiDJkFqeF5mPgDeA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fWTAbyOXr5GghrbvfkaZ6EzH7GNDJiiDJkFqeF5mPgDeA@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Apr 30, 2020 at 02:39:14PM -0700, Ian Rogers escreveu:
> On Wed, Apr 29, 2020 at 10:54 AM Arnaldo Carvalho de Melo
> <arnaldo.melo@gmail.com> wrote:
> >
> > Em Wed, Mar 18, 2020 at 07:31:00PM -0700, Ian Rogers escreveu:
> > > Memory leaks found by applying LLVM's libfuzzer on the parse_events
> > > function.
> > >
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > ---
> > >  tools/perf/util/parse-events.c | 2 ++
> > >  tools/perf/util/parse-events.y | 3 ++-
> > >  2 files changed, 4 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> > > index 593b6b03785d..1e0bec5c0846 100644
> > > --- a/tools/perf/util/parse-events.c
> > > +++ b/tools/perf/util/parse-events.c
> > > @@ -1482,6 +1482,8 @@ int parse_events_add_pmu(struct parse_events_state *parse_state,
> > >
> > >               list_for_each_entry_safe(pos, tmp, &config_terms, list) {
> > >                       list_del_init(&pos->list);
> > > +                     if (pos->free_str)
> > > +                             free(pos->val.str);
> >
> > I'm applying it but only after changing it to zfree(&pos->free_str), to
> > make sure that any othe rcode that may still hold a pointer to pos will
> > see a NULL in ->free_str and crash sooner rather than later.
> >
> > >                       free(pos);
> > >               }
> > >               return -EINVAL;
> >
> > And the following should be in a different patch
> >
> > > diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
> > > index 94f8bcd83582..8212cc771667 100644
> > > --- a/tools/perf/util/parse-events.y
> > > +++ b/tools/perf/util/parse-events.y
> > > @@ -44,7 +44,7 @@ static void free_list_evsel(struct list_head* list_evsel)
> > >
> > >       list_for_each_entry_safe(evsel, tmp, list_evsel, core.node) {
> > >               list_del_init(&evsel->core.node);
> > > -             perf_evsel__delete(evsel);
> > > +             evsel__delete(evsel);
> > >       }
> > >       free(list_evsel);
> > >  }
> >
> > And this one in another, I'll fix this up, but please try in the future
> > to provide different patches for different fixes, so that if we
> > eventually find out that one of the unrelated fixes is wrong, then we
> > can revert the patch more easily with 'git revert' instead of having to
> > do a patch that reverts just part of the bigger hodge-podge patch.
> >
> > If you go and have a track record of doing this as piecemeal as
> > possible, I will in turn feel more confident of processing your patches
> > in a faster fashion ;-) :-)
> 
> Thanks, at some point I'd like to get libfuzzer with asan working for
> more than just me so that we don't backslide. It'd also make the
> reproductions easier to share.

If we can detect the presence of the needed components, libraries,
compiler with the right feature set, yeah, a 'perf test' built under
such environment surely would benefit from having further tests,

- Arnaldo
