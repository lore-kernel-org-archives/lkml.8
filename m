Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 400E0C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 21:04:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 454212054F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 21:04:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZhPd/SkY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727805AbgEMVEK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 17:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725952AbgEMVEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 17:04:08 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B402C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 14:04:08 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id s37so392146ybe.13
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 14:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q6lcIFQoFqx31VM/1zc8og1yddcfl6h88uvYMor0Gpk=;
        b=ZhPd/SkYAxTbCCQE0Mlcbb1zb8dn27S+ZNjpPJws2c8W2BHijrHjSGhhYDprQu1MZQ
         +CbdD3XG3iIUgNnZV0/mBvDMRsAb3NSillVdwHoB8XjDEVEGcXAni3qzpqNzmCpwACQJ
         sWxRZUtn/PmOSICPjelCtBPYBF5b2Wn9ITGzJFtG1jU2jOmoOKzDGENNvHSUQNCBxLBe
         Tv5DPY61wchO6hK1AHVs5D2yr89sekod8Ktmqd3PoPuywmrrh8Up3CxAaI4wLo/ugidq
         t+D/qS6JQQ6yXEhgE1Lfg/0zXaXR0mwUsORaaM8F49pCw87aD9Ywb3DWJEGLe0WO6Aj1
         uo5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q6lcIFQoFqx31VM/1zc8og1yddcfl6h88uvYMor0Gpk=;
        b=lxc7DeJRHx236R4NxohkKxuCv7TI6nhjiqcGi109pbihMb1LEnFszNAHyiWC0/tPQ4
         PN3JmDG69EjatWNGra5KmzTa37qh7JDJo4bPp/VIhjOXkm7sGQXAiHdm/0bRqu0lAJdq
         nBPCoHHSYP7p9TtFpvzHkZ5oZHBO5MkOTYZPw8MuBosvlxfbPVjSgoE2f2zdOJh0SkV/
         tFZ4AZdQgPYFtIlX5ksD3zlAkKG4dLuPt/Cx8TWTjdfMzxm+u/chZ6fX2WMKoWGY71Rb
         5uHL+YjynIomI6bgPsEFfEzplDMGPXmbVJXx1tKkPbipvAb2cvc8OZ+7PkRdLXcW0y0E
         A/bQ==
X-Gm-Message-State: AOAM531WsI660/tPY4KUPCOGRrkH561yWzT7qO3lEyCUhJg23LHBAKF8
        R4CqqYmA05IK2+obl58vlcjssslKak6jv+tm/6mAyw==
X-Google-Smtp-Source: ABdhPJyv2qoxJ6RDVIjn7siPW2L0Ws3YId16DWs45OIoBYyl3vL4ZDwNj8eSx5tpE//BxLTwQVg+UxQ00DZ2rPgxUD8=
X-Received: by 2002:a25:5387:: with SMTP id h129mr1513794ybb.47.1589403847337;
 Wed, 13 May 2020 14:04:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200511195643.GA9850@embeddedor> <0C076F02-CEB7-4DBC-8337-CCEBC0870E44@gmail.com>
 <20200512000404.GA4897@embeddedor> <20200512080607.GD2978@hirez.programming.kicks-ass.net>
 <20200512180352.GB4897@embeddedor>
In-Reply-To: <20200512180352.GB4897@embeddedor>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 13 May 2020 14:03:56 -0700
Message-ID: <CAP-5=fWOhnKe1-c39Pg9M14Yet7U1jRvPpKxa7N2A6JSXLRe=Q@mail.gmail.com>
Subject: Re: [PATCH] perf tools: Replace zero-length array with flexible-array
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Melo <arnaldo.melo@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
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

On Tue, May 12, 2020 at 10:59 AM Gustavo A. R. Silva
<gustavoars@kernel.org> wrote:
>
> On Tue, May 12, 2020 at 10:06:07AM +0200, Peter Zijlstra wrote:
> > On Mon, May 11, 2020 at 07:04:04PM -0500, Gustavo A. R. Silva wrote:
> > > On Mon, May 11, 2020 at 05:20:08PM -0300, Arnaldo Melo wrote:
> > > >
> > > > Thanks, applied
> > > >
> > >
> > > Thanks, Arnaldo.
> > >
> > > I wonder if could also take the other two:
> > >
> > > https://lore.kernel.org/lkml/20200511200911.GA13149@embeddedor/
> > > https://lore.kernel.org/lkml/20200511201227.GA14041@embeddedor/
> >
> > I think I have those, but let me make sure.
>
> Great. :)


Thanks for the cleanup! It has yielded a clang compiler warning/error
for me in kernel/git/acme/linux.git branch perf/core:

util/intel-pt.c:1802:24: error: field 'br_stack' with variable sized
type 'struct branch_stack' not
at the end of a struct or class is a GNU extension
[-Werror,-Wgnu-variable-sized-type-not-at-end]
                       struct branch_stack br_stack;

I think this can be resolved by reordering the members of the struct,
and may have been a latent bug exposed by this change. It's
unfortunate it has broken this build.

Thanks,
Ian

> Thanks
> --
> Gustavo
>
