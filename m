Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ADE0C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 15:43:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 034D020758
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 15:43:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f8dZ8xIO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728338AbgERPnb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 11:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbgERPna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 11:43:30 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60406C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 08:43:29 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id l3so8786815edq.13
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 08:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qyyQKzYFu/7h5E836hsgHKMOfWSgn0qWVarFhD2DEKU=;
        b=f8dZ8xIORXQNPBbRYt6xuYG9yfeUK8KLQEncOoSt/DlNVKhrfcCqQsrmToClTv+rDn
         sE3/yNsrV9X+OWjNoF1yI9vpVMHapHaevxWDOBxsCejOCoP+asNHtW9jdIHCp9yiT02/
         kEkpaXhWGTu4YahO4l81RK4NfQqLa7PSTKmp9AjTKFmLw3R9VrMEe+TvCniIGi+f4GnU
         1iEIIT3VYX0Ld4ecoW8mDwn9xDVLlBYiClR0amYTreCm7rtt4eo6HAlOY9QkJBzqiAfD
         p5SMtyGzYzc/Y4HsPGCiM7qIKsHWC+Kqlv9PeoxuDFfGfcUZ5FqyZ1wczQ8aG9Jb5HyO
         2ukg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qyyQKzYFu/7h5E836hsgHKMOfWSgn0qWVarFhD2DEKU=;
        b=lPE+8YYwxLR3/QIeZp0ceiJ34EDH8ozJFDkamYHRsx57j786cmqQBrE6C8gISsAJK2
         zCMahRb2ePgI0iCFwzVAH+gH3i1OPg1/TRCrynPpCImcBUcC/+cW4Lo1C8iuB/UWRe3x
         /sFmiBd1tEMFjXbu6Wm//Vq5W+YN6/T+O6Yp1CFR+jDj5EYDKdH7/XEbe/CcqymvDnM7
         aSqWIW0nJ+Zf1bEi8Hf6O1J2OoAROx2LAxvU2Y5gcotoL5WubjfiaaA6ybPKxoRV4FPp
         KPG9BEdfnEyZ4vO0nNwyK1R5fUSD4ItcZNMPN+Du7PFW28m0sl9DMu/tNhDY8CRdAwKA
         Hktg==
X-Gm-Message-State: AOAM530TeEvjTxnoVC7+oYWL54wBHZZ+ZIiN0tIVewu5owsw82XhRKr2
        ZgRqr/G7EQl9a++6pnIlrwo5LBKPhgfvgKeM+Ql/HtOp
X-Google-Smtp-Source: ABdhPJxP1ZGgNfWEZpA7rdeonukC7hlRqJ69qe2XV5mydYq9AF5tI0IPiItsHDjtamtke7kCgi4YwfpVCRybotw6QOM=
X-Received: by 2002:a05:6402:204b:: with SMTP id bc11mr13735965edb.114.1589816607562;
 Mon, 18 May 2020 08:43:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200515172756.27185-1-will@kernel.org> <CABCJKucXmMD82mQ0rSMjfByXD42htTjkde3TsKTVP-jvuqkZwQ@mail.gmail.com>
 <20200518135228.GI32394@willie-the-truck>
In-Reply-To: <20200518135228.GI32394@willie-the-truck>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Mon, 18 May 2020 08:43:16 -0700
Message-ID: <CABCJKudRHeE3VOPK2HDmkg3qCrzNQpmOywrfMfdX+aE8jpUnUg@mail.gmail.com>
Subject: Re: [PATCH 0/6] Clean up Shadow Call Stack patches for 5.8
To:     Will Deacon <will@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@am.com>,
        Jann Horn <jannh@google.com>, Ard Biesheuvel <ardb@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 18, 2020 at 6:52 AM Will Deacon <will@kernel.org> wrote:
>
> On Fri, May 15, 2020 at 01:42:40PM -0700, Sami Tolvanen wrote:
> > On Fri, May 15, 2020 at 10:28 AM Will Deacon <will@kernel.org> wrote:
> > > Will Deacon (6):
> > >   arm64: scs: Store absolute SCS stack pointer value in thread_info
> > >   scs: Move accounting into alloc/free functions
> > >   arm64: scs: Use 'scs_sp' register alias for x18
> > >   scs: Move scs_overflow_check() out of architecture code
> > >   scs: Remove references to asm/scs.h from core code
> > >   scs: Move DEFINE_SCS macro into core code
> > >
> > >  arch/Kconfig                         |  4 +--
> > >  arch/arm64/include/asm/scs.h         | 29 ++++------------
> > >  arch/arm64/include/asm/thread_info.h |  4 +--
> > >  arch/arm64/kernel/asm-offsets.c      |  2 +-
> > >  arch/arm64/kernel/entry.S            | 10 +++---
> > >  arch/arm64/kernel/head.S             |  2 +-
> > >  arch/arm64/kernel/process.c          |  2 --
> > >  arch/arm64/kernel/scs.c              |  6 +---
> > >  include/linux/scs.h                  | 16 +++++----
> > >  kernel/sched/core.c                  |  3 ++
> > >  kernel/scs.c                         | 52 +++++++++++++---------------
> > >  11 files changed, 55 insertions(+), 75 deletions(-)
> > >
> > > --
> > > 2.26.2.761.g0e0b3e54be-goog
> >
> > Thanks, Will. I tested these on my SCS tree and didn't run into any
> > issues. Looks good to me.
>
> Cheers, Sami. Can I add your 'Tested-by' to the patches, please?

Sure, please feel free to add Tested-by tags.

Sami
