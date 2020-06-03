Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3480C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 14:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDB9320772
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 14:48:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MIkps4tW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726026AbgFCOsI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 10:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbgFCOsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 10:48:07 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FBF4C08C5C0
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jun 2020 07:48:07 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id o13so2073796otl.5
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jun 2020 07:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K4mWQ9BO+ADAedoRkxDsxNn5p6Rl0+bZnTb72ellqDY=;
        b=MIkps4tW3dJjh2gI+MkcQDiSeHA+/2kyUTQs223quN2IFGpE5XwbsFdY0xuq1Pinx/
         9Cur14MPWPsnKRuFW8iuEli5YlOWV4L03LVquMJk7w/RnWUT7vvxrEA0SgreCY9PlWQl
         SMIwYh4Okf4LTQAFjd5y3kIId4UHXRGMRyCHfEplkPLMbCIsVd/gDdfRVJaU284qpJPN
         pgdlDRfpzpnjzkb5jqg90mr2QxDPJfa4qpm8JhOka8ZbuQ4OydQUriTBWd4V7Zlm4vih
         8lsA9I/2CyfiG+040dFG7EAbys/uwW8GgPkBBMyeQ0letlLHoWlPzOr3Y1V+NvTPLXnD
         5xuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K4mWQ9BO+ADAedoRkxDsxNn5p6Rl0+bZnTb72ellqDY=;
        b=Rg39aKp3L9EFZytRrwsvCyle9mBTXFSD17dVcOD4mSKu1u73CnGTrs1+lDHAuHWMy4
         +ntZRHkiplsDHnY3h7SISGuq1XyASBx1+oiRUgT5OGbAGMdXMTemrN9PZTLeZcWoBrzt
         ppN7AUp1cY7BXyaNjqVD5DarzfZ/Pw894Wqt+0AJ5h6egV0AB6hw0HekUkRYkgJpkmpv
         8dyBx+w5Nj/IM4TuE2h/s4RVv6hCSwc44Lp8o/jXzWR8waN27rBKHtJ0FP+1NrZKokkX
         UTSrd90EWuvedXV+TkPA7eUgkXabne7MJsLc/uHsmVSUfZg9ukhZtSV+M872jZQ/xnse
         D4Fw==
X-Gm-Message-State: AOAM530bbkM+Oku/eWsmksgCmNChxWkulihkwjzbyHVgBog56r73Vh+J
        qOMrL/QKb8POG1duIhtKVMLRui3TDTBt4E3zERDX2A==
X-Google-Smtp-Source: ABdhPJziZsRVXntK8sNdeCrfyAujrpVvkIXmhqO25+V3RupcnSBtEIl8SdahpAwthlHGQF8U/clIQ2OCahYRM6xd8CM=
X-Received: by 2002:a9d:6958:: with SMTP id p24mr256297oto.17.1591195686488;
 Wed, 03 Jun 2020 07:48:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200603114014.152292216@infradead.org> <20200603120037.GA2570@hirez.programming.kicks-ass.net>
 <20200603120818.GC2627@hirez.programming.kicks-ass.net> <CANpmjNOxLkqh=qpHQjUC_bZ0GCjkoJ4NxF3UuNGKhJSvcjavaA@mail.gmail.com>
 <20200603121815.GC2570@hirez.programming.kicks-ass.net> <CANpmjNPxMo0sNmkbMHmVYn=WJJwtmYR03ZtFDyPhmiMuR1ug=w@mail.gmail.com>
In-Reply-To: <CANpmjNPxMo0sNmkbMHmVYn=WJJwtmYR03ZtFDyPhmiMuR1ug=w@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Wed, 3 Jun 2020 16:47:54 +0200
Message-ID: <CANpmjNPzmynV2X+e76roUmt_3oq8KDDKyLLsgn__qtAb8i0aXQ@mail.gmail.com>
Subject: Re: [PATCH 0/9] x86/entry fixes
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Jun 2020 at 15:32, Marco Elver <elver@google.com> wrote:
>
> On Wed, 3 Jun 2020 at 14:18, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Wed, Jun 03, 2020 at 02:08:57PM +0200, Marco Elver wrote:
> >
> > > What is the .config you used? I somehow can't reproduce. I've applied
> > > the patches on top of -tip/master.
> >
> > So tip/master, my patches, your patches, this series.
> >
> > $ make CC=/opt/llvm/bin/clang O=defconfig-build/ -j80 -s bzImage
> >
> > is what I used, with the below config.
> >
>
> Thanks, can reproduce now. So far I haven't found any indication that
> there is a missing check in Clang's instrumentation passes somewhere.
> I'm a bit suspicious because both Clang and GCC have this behaviour.
> I'll continue looking.

This is fun: __always_inline functions inlined into
__no_sanitize_undefined *do* get instrumented because apparently UBSan
passes must run before the optimizer (before inlining), contrary to
what [ATM]SAN instrumentation does. Both GCC and Clang do this.

Some options to fix:

1. Add __no_sanitize_undefined to the problematic __always_inline
functions. I don't know if a macro like '#define
__always_inline_noinstr __always_inline __no_sanitize_undefined' is
useful, but it's not an automatic fix either. This option isn't great,
because it doesn't really scale.

2. If you look at the generated code for functions with
__ubsan_handle_*, all the calls are actually guarded by a branch. So
if we know that there is no UBSan violation in the function, AFAIK
we're fine. What are the exact requirements for 'noinstr'? Is it only
"do not call anything I didn't tell you to call?" If that's the case,
and there is no bug in the function ;-), then for UBSan we're fine.
With that in mind, you could whitelist "__ubsan_handle"-prefixed
functions in objtool. Given the __always_inline+noinstr+__ubsan_handle
case is quite rare, it might be reasonable.

We could try to do better, and make __ubsan_handle_* 'noinstr' by
checking if _RET_IP_ is in .noinstr.text and just return. Would that
work? But that would only be useful if there is a UBSan bug. It might
also slow-down regular UBSan, and if we assume that the
__always_inline functions called from noinstr functions that end up
with UBSan instrumentation don't have bugs (big assumption), then not
much is gained either.

Thoughts?

Thanks,
-- Marco
