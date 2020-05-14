Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7D65C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 19:07:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C073A2065F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 19:07:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KojQQwr+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729288AbgENTHG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 15:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728779AbgENTHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 15:07:00 -0400
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34232C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 12:07:00 -0700 (PDT)
Received: by mail-yb1-xb41.google.com with SMTP id i16so2081762ybq.9
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 12:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0qCYNs2CSDyIVi64uoLkz66pQmNK2j6ygGTzZfOYnzI=;
        b=KojQQwr+FP1sG1Tc9Zn7a0yfdfQdqT35piN3mx9x7vtv69ME8CohxDMY5VSWaQN62S
         z0KPUD35AbOGZrl6GIBejowH3CqV0VkEqa8Md1HFdUv7Zmx/0POxzLGgeoF+gwr+JeUZ
         MZ/tL7gB83t+hGTJcYu2EVEJEaNGfj0ne5fboSCOf9O/+Tvi9p7rJFN0cY3kpD9RR+7L
         eZyKxgghSY7/TcYTKEgImubH6pErnMVYyZOhaTuajQU3eS75EXdY3lnwGn/hY2JQTJAC
         khuDmr8fz2BX6emMDtkDuSMZsEnfDJL3l5KIeXmXzz6j1TWbTW4IzYn3S6+BgiFu+y/m
         aFhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0qCYNs2CSDyIVi64uoLkz66pQmNK2j6ygGTzZfOYnzI=;
        b=aEwYmOyDCtfKT0+EhUR4tf7BKWGgJYplmrBWfJXbWl2nmw8kUF+gUN/Oqgy06FKWg6
         fTojr4I/1wFt9yoi4AzbM+84sCODHkCwxZz/Q8JZKXtqRY0dQqNNd/2K54nYTiHo1zs0
         ZjCcEp6tYmkt1yCfKlmoso389Ki7jAOXNu2M8g9wBV1hJHyFtjtfEvOR8Q0fBJ4PppxM
         bqy1ZkQDBZxMc6JsxAIAqTuTGvZbLDvQAfeZASCFck1rCI4QYQs0LVo9QWZ1kW1X66y2
         n8u+odRQqf8zmSl8Fv+9rRBosaipmLKqQ6mMLzf+NANpO03J32KzSZzwOovrx977R4xV
         sWHA==
X-Gm-Message-State: AOAM533l+ov64jYU8CuRQjCTD3QrH8LTjrcXb/Th33RsVs3PJNtbGAxY
        HdcIYnV59Qt1Ut+Mjs66+dTncIFJwruzKq+LlkYQjw==
X-Google-Smtp-Source: ABdhPJzphKsd+sh3MAeBf6+tjOED4Unl+agXSj1k3Juzx1Uns7DdWmOQm/z2psspAyAsziKhGcLgRFfezAjeqbzeGT8=
X-Received: by 2002:a25:d450:: with SMTP id m77mr9574174ybf.177.1589483219072;
 Thu, 14 May 2020 12:06:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200513234738.GA21211@embeddedor> <20200514131030.GL5583@kernel.org>
 <20200514150601.GS4897@embeddedor>
In-Reply-To: <20200514150601.GS4897@embeddedor>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 14 May 2020 12:06:48 -0700
Message-ID: <CAP-5=fWTCFx80Hd_97_4AxFV4KsRyYptLbQfw=XVw_j8i-EAyg@mail.gmail.com>
Subject: Re: [PATCH perf/core] perf intel-pt: Fix clang build failure in intel_pt_synth_pebs_sample
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 14, 2020 at 8:01 AM Gustavo A. R. Silva
<gustavoars@kernel.org> wrote:
>
> On Thu, May 14, 2020 at 10:10:30AM -0300, Arnaldo Carvalho de Melo wrote:
> > Em Wed, May 13, 2020 at 06:47:38PM -0500, Gustavo A. R. Silva escreveu:
> > > Fix the following build failure generated with command
> > > $ make CC=clang HOSTCC=clang -C tools/ perf:
> > >
> > > util/intel-pt.c:1802:24: error: field 'br_stack' with variable sized type 'struct branch_stack' not at the end of a struct or class is a GNU extension [-Werror,-Wgnu-variable-sized-type-not-at-end]
> > >                         struct branch_stack br_stack;
> > >                                             ^
> > > 1 error generated.
> > >
> > > Fix this by reordering the members of struct br.
> >
> > Yeah, I noticed that as far back as with ubuntu 16.04's clang:
> >
> > clang version 3.8.0-2ubuntu4 (tags/RELEASE_380/final)
> >
> > util/intel-pt.c:1802:24: error: field 'br_stack' with variable sized type 'struct branch_stack' not at the end of a struct or class is a GNU
> >       extension [-Werror,-Wgnu-variable-sized-type-not-at-end]
> >                         struct branch_stack br_stack;
> >                                             ^
> > 1 error generated.
> >
> >
> > Will fold this with the bug introducing the problem to avoid bisection
> > problems.
> >
>
> I agree. Also, the commit hash of the "Fixes" tag only applies to the
> perf/core branch and, I guess that might create confusion.


So while this fixes the warning I believe it breaks the intent of the code.

tools/perf/util/branch.h:
struct branch_stack {
       u64                     nr;
       u64                     hw_idx;
       struct branch_entry     entries[];
};

tools/perf/util/intel-pt.c:
               struct {
                       struct branch_stack br_stack;
                       struct branch_entry entries[LBRS_MAX];
               } br;

The array in br is trying to extend branch_stack's entries array. You
might have to do something like:

alignas(alignof(branch_stack)) char storage[sizeof(branch_stack) +
sizeof(branch_entry) * LBRS_MAX];
struct branch_stack *br = &storage;

malloc/free may be nicer on the eyeballs.

Thanks,
Ian

> Thanks
> --
> Gustavo
