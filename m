Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C75F3C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 19:26:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B89920870
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 19:26:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fi2nlPxf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbgFBT0A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 15:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbgFBTZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 15:25:59 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD364C08C5C0
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 12:25:59 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id a137so13060827oii.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 12:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zgQoiQ3jaz0VjmfJxEyv0Pkaee0Wtz3ujBDf41O3EoY=;
        b=Fi2nlPxf/7Sa9yL3oOOWXjSuvQO+/3PiuizVCpbkvABocM3wpiq9rEaww9oCBIn3kJ
         M9us/HJhWsL6/Bm9mtP3sFn+stJEHu8jLSGBxddXYQWrgNV9l5oq2oekS3VwBZq2lJfP
         mFNW3S5NASbtdyAQ5rzI0ZyTdf/5X9WhEj99hn03hWzbITdwssWB8ix8bgPvsDFd9Sm6
         Sk9X62TDOkck6zj1jc1U5ttZWD0h+/aJnRo4yxFPnPWLg5lFu08o7J8QwQa2oZD9JD6x
         tnwnVL/prvzdasAcsyB7LzT0uxRPs5NjaoD282/aBueMDrBGz8xVMcESgwEDHEgXXsQO
         nhRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zgQoiQ3jaz0VjmfJxEyv0Pkaee0Wtz3ujBDf41O3EoY=;
        b=Ql6/Khh8yWSAJkOq8l3zL/lQ+j1BFU+qq+oBXAj9gNb4i/AJIc+eZxptm5sVDLZzaz
         mEVBuG/olf+p54NIk4hkuTfrjTMurhfS7JFkp7DU93GWSQ2MQ5JMcO3cZzBY13v/RsNT
         u89Re4TxQ2PEW2T+6jfHAAV/ax3fIs3N+Xzs3HFw+mMYttSdaNvdlX/cTdWL4mB+SQi0
         1QUAlKML2ji6LtPp/Kt/qeVYNWnqejfLHR9I/qjWm2VBohKVvvCaNeIEIvuS3zCDXgF/
         tpkKuoRzm5wbZinzaXElohp/LCX4x4QpncBjn5E8GbmwIlQV9BNtlkIyW7+QSeIuwwWv
         rnCw==
X-Gm-Message-State: AOAM531Sd2BNoGllwgjseB/B7Ewrec3zZ9561lbgZHvdZ+4b6DctIslD
        lnK1p+UNnOGZuqIUTYcdjug0Y6g/efYD21TIoOnTyQ==
X-Google-Smtp-Source: ABdhPJwIVmLeg7KBh+0LIITomvk05gYui9ah5z9tDXNow8PwZDW+dpW2479CpV1tvhdwfob0zfLBFJO38XqtH/awYqE=
X-Received: by 2002:a05:6808:3ac:: with SMTP id n12mr2388414oie.172.1591125958861;
 Tue, 02 Jun 2020 12:25:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200602184409.22142-1-elver@google.com> <CAKwvOd=5_pgx2+yQt=V_6h7YKiCnVp_L4nsRhz=EzawU1Kf1zg@mail.gmail.com>
 <20200602191936.GE2604@hirez.programming.kicks-ass.net>
In-Reply-To: <20200602191936.GE2604@hirez.programming.kicks-ass.net>
From:   Marco Elver <elver@google.com>
Date:   Tue, 2 Jun 2020 21:25:47 +0200
Message-ID: <CANpmjNP3kAZt3kXuABVqJLAJAW0u9-=kzr-QKDLmO6V_S7qXvQ@mail.gmail.com>
Subject: Re: [PATCH -tip 1/2] Kconfig: Bump required compiler version of KASAN
 and UBSAN
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Will Deacon <will@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Jun 2020 at 21:19, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Jun 02, 2020 at 11:57:15AM -0700, Nick Desaulniers wrote:
> > On Tue, Jun 2, 2020 at 11:44 AM 'Marco Elver' via Clang Built Linux
> > <clang-built-linux@googlegroups.com> wrote:
> > >
> > > Adds config variable CC_HAS_WORKING_NOSANITIZE, which will be true if we
> > > have a compiler that does not fail builds due to no_sanitize functions.
> > > This does not yet mean they work as intended, but for automated
> > > build-tests, this is the minimum requirement.
> > >
> > > For example, we require that __always_inline functions used from
> > > no_sanitize functions do not generate instrumentation. On GCC <= 7 this
> > > fails to build entirely, therefore we make the minimum version GCC 8.
> > >
> > > For KCSAN this is a non-functional change, however, we should add it in
> > > case this variable changes in future.
> > >
> > > Link: https://lkml.kernel.org/r/20200602175859.GC2604@hirez.programming.kicks-ass.net
> > > Suggested-by: Peter Zijlstra <peterz@infradead.org>
> > > Signed-off-by: Marco Elver <elver@google.com>
> >
> > Is this a problem only for x86?  If so, that's quite a jump in minimal
> > compiler versions for a feature that I don't think is currently
> > problematic for other architectures?  (Based on
> > https://lore.kernel.org/lkml/20200529171104.GD706518@hirez.programming.kicks-ass.net/
> > )
>
> Currently x86 only, but I know other arch maintainers are planning to
> have a hard look at their code based on our findings.

I've already spotted a bunch of 'noinstr' outside arch/x86 e.g. in
kernel/{locking,rcu}, and a bunch of these functions use atomic_*, all
of which are __always_inline. The noinstr uses outside arch/x86 would
break builds on all architecture with GCC <= 7 when using sanitizers.
At least that's what led me to conclude we need this for all
architectures.

Thanks,
-- Marco
