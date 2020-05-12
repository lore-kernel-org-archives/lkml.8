Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6282ECA90AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 18:55:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 401AF207BC
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 18:55:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FcZ62UYq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730982AbgELSzs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 14:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbgELSzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 14:55:47 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C50A7C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 11:55:47 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id a2so18979874oia.11
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 11:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8/ib6+c7BKOFq4rzBPSiX9579nf57nKgi51prOVLeqM=;
        b=FcZ62UYqj1Uw6lvR03J/WQSC7U46eIoGLsLYjrBHxCf/M/FHYaJgDcl5gA/cF1utrS
         rfkru4WXu8OGZYcgyVCt8ye8MBGrzlUkmZH6m/OAnV6pKYYFe+QpAr+iHRW/LFW7Kj+9
         sG9V6v26dklp1AJXIbooxCUjUhlmIko+KmvJvsLBoMLg+3viLP5T9hH++KpO2d17bs+R
         auvZq+dVgojLeJaXEreXfZC2ZkGqGWTAjETDUKVLwv+XWSDchaLPp1MbYxGKppv5DPTf
         4FUJzauTU1k8FLeUdo+4ixoVv03YIoPLtqSYqv99JoZhwLIh5R9P8GbUX9rktXFJKxMx
         So7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8/ib6+c7BKOFq4rzBPSiX9579nf57nKgi51prOVLeqM=;
        b=A3K2qqP89pqeQW2y5RI24aXfziznnFBJOgmVAoU+hh5zFgYemsRDAH5I+ROFnvfUI3
         1B+npZaWQiIf6cLC94Bjt08k7ph1sq+daNF45yMJFOIEXtDsOf5yW6lqXJG+YWvtRgf2
         MZ0Nn3aoXUXYmYtsedPFEbQ6iJ1syNxgn3nEIUonp2O8eV7wJuwZzdiED81mllsNY0pd
         BGQ8xScGEHx8773WVyxR1THoQry1hQFoWBmyw9GnpXtsNG3+pOSIfI3Yn8HrMM10xxY/
         dE8TqlVIrlf40VFNZ0LmGW1c6KkQjtpKZBIHH+Kc9Tb4KftREJp4vVEficuZzNMlssA9
         HKgg==
X-Gm-Message-State: AGi0PuZpZ3+YR/WAWj+xNdZgmmOytYKD7tiTI3ongQDVN1RLxGJLfWuv
        pnNae8LzRxqQTwMgSfoJ2iQH8Y+MpRURIDrlY/+Zcx45VdM=
X-Google-Smtp-Source: APiQypJKNayXsH2H4/z2yorcnPrsCNS2C8CiZ3sw6mZmLeULz8JSbRtgJy+ANRRSDHPiZxxC0ZAYjtGexBpLFE8BFcE=
X-Received: by 2002:a05:6808:b36:: with SMTP id t22mr25095274oij.121.1589309746887;
 Tue, 12 May 2020 11:55:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200511204150.27858-1-will@kernel.org> <20200512081826.GE2978@hirez.programming.kicks-ass.net>
 <CANpmjNNo3rhwqG=xEbpP9JiSd8-Faw8fkoUhYJjesHK5S5_KQQ@mail.gmail.com>
In-Reply-To: <CANpmjNNo3rhwqG=xEbpP9JiSd8-Faw8fkoUhYJjesHK5S5_KQQ@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 12 May 2020 20:55:35 +0200
Message-ID: <CANpmjNO8gTbwbpsk=8s2sNU16Od81=PZnY-BL=hyTHk7hGrNPA@mail.gmail.com>
Subject: Re: [PATCH v5 00/18] Rework READ_ONCE() to improve codegen
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Will Deacon <will@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 May 2020 at 19:53, Marco Elver <elver@google.com> wrote:
>
> On Tue, 12 May 2020 at 10:18, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Mon, May 11, 2020 at 09:41:32PM +0100, Will Deacon wrote:
> > > Hi folks,
> > >
> > > (trimmed CC list since v4 since this is largely just a rebase)
> > >
> > > This is version five of the READ_ONCE() codegen improvement series that
> > > I've previously posted here:
> > >
> > > RFC: https://lore.kernel.org/lkml/20200110165636.28035-1-will@kernel.org
> > > v2:  https://lore.kernel.org/lkml/20200123153341.19947-1-will@kernel.org
> > > v3:  https://lore.kernel.org/lkml/20200415165218.20251-1-will@kernel.org
> > > v4:  https://lore.kernel.org/lkml/20200421151537.19241-1-will@kernel.org
> > >
> > > The main change since v4 is that this is now based on top of the KCSAN
> > > changes queued in -tip (locking/kcsan) and therefore contains the patches
> > > necessary to avoid breaking sparc32 as well as some cleanups to
> > > consolidate {READ,WRITE}_ONCE() and data_race().
> > >
> > > Other changes include:
> > >
> > >   * Treat 'char' as distinct from 'signed char' and 'unsigned char' for
> > >     __builtin_types_compatible_p()
> > >
> > >   * Add a compile-time assertion that the argument to READ_ONCE_NOCHECK()
> > >     points at something the same size as 'unsigned long'
> > >
> > > I'm happy for all of this to go via -tip, or I can take it via arm64.
> >
> > Looks good to me; Thanks!
> >
> > Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>
> I just ran a bunch of KCSAN tests. While this series alone would have
> passed the tests, there appears to be a problem with
> __READ_ONCE/__WRITE_ONCE. I think they should already be using
> 'data_race()', as otherwise we will get lots of false positives in
> future.
>
> I noticed this when testing -tip/locking/kcsan, which breaks
> unfortunately, because I see a bunch of spurious data races with
> arch_atomic_{read,set} because "locking/atomics: Flip fallbacks and
> instrumentation" changed them to use __READ_ONCE()/__WRITE_ONCE().
> From what I see, the intent was to not double-instrument,
> unfortunately they are still double-instrumented because
> __READ_ONCE/__WRITE_ONCE doesn't hide the access from KCSAN (nor KASAN
> actually). I don't think we can use __no_sanitize_or_inline for the
> arch_ functions, because we really want them to be __always_inline
> (also to avoid calls to these functions in uaccess regions, which
> objtool would notice).
>
> I think the easiest way to resolve this is to wrap the accesses in
> __*_ONCE with data_race().

I just sent https://lkml.kernel.org/r/20200512183839.2373-1-elver@google.com
-- note that, using __*_ONCE in arch_atomic_{read,set} will once again
double-instrument with this. Overall there are 2 options:
1. provide __READ_ONCE/__WRITE_ONCE wrapped purely in data_race(), or
2. make __READ_ONCE/__WRITE_ONCE perform an atomic check so we may
still catch races with plain accesses.
The patch I sent does (2). It is inevitable that these will be used in
places that we did not expect, purely to get around the type check,
which is why I thought it might be the more conservative approach.

Thoughts?

Thanks,
-- Marco
