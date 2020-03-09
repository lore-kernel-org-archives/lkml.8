Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 601A3C10F25
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 19:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E30220727
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 19:37:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O4ebsCY+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbgCIThC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 15:37:02 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35359 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbgCIThB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 15:37:01 -0400
Received: by mail-pf1-f193.google.com with SMTP id u68so4577384pfb.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 12:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rITjmflNY+bq50oaknXGIP+wYS1ykHN9pumCvBYNG4g=;
        b=O4ebsCY+7YUPuxBh2Atk8v7bx3ueAt2d+7HKZyAJCvWiXWfgJWGtKs5KWerDRnzNry
         +fdChmcSEb+N0WcaPi8F41uvPNsHiH0uTaiV8I0dNZwo8qKaCBNC2hPBwXUGqd7DvSHS
         dEyvRiPKT7czcOnqu/CN/Wx9ctdn/ttvP8wSGwRk540gD4270ktraUZ7NgT2oSpsWLDS
         GcQSv0rvX7jmq2s269TwVlCyuxpcbMeZ9NoPeHIt/CpZDJOkXebTj/LN0jMj9nihRU7A
         cnjEbKmn1OUsJ4I9T8bTp/hr8ovWonGGHFGMzB8NwxwQOxS9EahykA2shaF21e2ZEJrC
         KIVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rITjmflNY+bq50oaknXGIP+wYS1ykHN9pumCvBYNG4g=;
        b=n7wwWMwmMfvTEAaPi2GnYnYASQNX0Oo/bg5m5ySCLRVFoOlLHpt2Frb2XC2qJjUy1k
         XcBND0w+P2UXK73EdS24wSZnaANoFyL1LBZGkJHV3EDOxUmBi3KVVjEC2iAQwKsde54H
         BjBjsE/kJPujvhPkTc1tcr/etGQJC4exmfdr5sUTkh30TzfE9nVGQe2r2PkimGD6JF7Y
         EYXYqFBQYi8CE6N7fMOYWLWJ3gtQ9Cr97bNtehEnxlVIHqrv+Ef/gVQmKvgr831O8lza
         f4M/mk2WXv3izOvLMiu5zBZcMooADbsbVfNBgR+Oie24WG6+n1zE+0HPzQnA13974o1c
         MzKA==
X-Gm-Message-State: ANhLgQ0HIsTmbBS+RT31xuRKSv4apgSuD5hof60H5J9UHVuX5jiMMAiK
        63kkjAx9vcbl1p6TvhfNnRrn/GMbCtAyp0COMkG20Q==
X-Google-Smtp-Source: ADFU+vvWy2Q4moyksCTcMsym0aCPmtdYAZ1mOx2+sL1mCELnyal5EoixDESIO8hyXX6y5vMzqcirCbvjbmNznpfKvjQ=
X-Received: by 2002:a62:37c7:: with SMTP id e190mr18266676pfa.165.1583782619765;
 Mon, 09 Mar 2020 12:36:59 -0700 (PDT)
MIME-Version: 1.0
References: <b56602fcf79f849e733e7b521bb0e17895d390fa.1582230379.git.joe@perches.com>
 <20200220162114.138f976ae16a5e58e13a51ae@linux-foundation.org>
In-Reply-To: <20200220162114.138f976ae16a5e58e13a51ae@linux-foundation.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 9 Mar 2020 12:36:47 -0700
Message-ID: <CAKwvOdkzc3AtpkRcZU06yvAEzp_bjw55HkpGui6RsAcy=FhnJw@mail.gmail.com>
Subject: Re: [PATCH] cvt_fallthrough: A tool to convert /* fallthrough */
 comments to fallthrough;
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Joe Perches <joe@perches.com>, LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2020 at 4:21 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Thu, 20 Feb 2020 12:30:21 -0800 Joe Perches <joe@perches.com> wrote:
>
> > Convert /* fallthrough */ style comments to the pseudo-keyword fallthrough
> > to allow clang 10 and higher to work at finding missing fallthroughs too.
> >
> > Requires a git repository and overwrites the input files.
> >
> > Typical command use:
> >     ./scripts/cvt_fallthrough.pl <path|file>
> >
> > i.e.:
> >
> >    $ ./scripts/cvt_fallthrough.pl block
> >      converts all files in block and its subdirectories
> >    $ ./scripts/cvt_fallthrough.pl drivers/net/wireless/zydas/zd1201.c
> >      converts a single file
> >
> > A fallthrough comment with additional comments is converted akin to:
> >
> > -             /* fall through - maybe userspace knows this conn_id. */
> > +             fallthrough;    /* maybe userspace knows this conn_id */
> >
> > A fallthrough comment or fallthrough; between successive case statements
> > is deleted.
> >
> > e.g.:
> >
> >     case FOO:
> >       /* fallthrough */ (or fallthrough;)
> >     case BAR:
> >
> > is converted to:
> >
> >     case FOO:
> >     case BAR:
> >
> > Signed-off-by: Joe Perches <joe@perches.com>
> > ---
> >  scripts/cvt_fallthrough.pl | 215 +++++++++++++++++++++++++++++++++++++
>
> Do we need this in the tree long-term?  Or is it a matters of "hey
> Linus, please run this" then something like add a checkpatch rule to
> catch future slipups?

Just for some added context, please see
https://reviews.llvm.org/D73852, where support for parsing some forms
of fallthrough statements was added to Clang in a broken state by a
contributor, but then ripped out by the code owner (of the clang front
end to LLVM, and also happens to be the C++ ISO spec editor).  He
provides further clarification
https://bugs.llvm.org/show_bug.cgi?id=43465#c37.

I'm inclined to agree with him; to implement this, we need to keep
around comments for semantic analyses, a later phase of compilation
than preprocessing.  It feels like a layering violation to either not
discard comments as soon as possible, or emit diagnostics from the
preprocessor.  And as Joe's data shows, there's the classic issue
faced when using regexes to solve a problem; suddenly you now have two
problems.
https://xkcd.com/1171/

I would like to see this patch landed, though I am curious as toward's
Andrew's question ('Or is it a matters of "hey Linus, please run
this"') of what's the imagined workflow here, since it seems like the
script needs to be run per file. I suppose you could still do that
treewide, but is that the intention, or is it to do so on a per
subsystem level?



--
Thanks,
~Nick Desaulniers
