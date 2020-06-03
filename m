Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C699C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 19:10:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10EEF2074B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 19:10:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="egSBgEUc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726103AbgFCTKQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 15:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbgFCTKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 15:10:16 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1813C08C5C0
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jun 2020 12:10:15 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id g5so2783914otg.6
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jun 2020 12:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=67IcpGYjCT+FsM7zbHjM+OI8M/GSYi0Apdlq92IAtKw=;
        b=egSBgEUck8UQz5o9i/JnEEmHXFwrBxadOEmq90yGlgKOu+HCgL5g3nxhkf5b6Ovq/l
         HHq+upRNTN4uvWeyXA+HcQbpRHcBwfO+afkekfPvRDARUDeF7lYUHUiQXNU/OK+kUsa/
         Wjpvp00faAf7t58EoAULDOx6dfR5UW+c/lSislNu47WzHAxohV6EBMXjSEPj/5tt7//I
         dOlQ0E0vg0RbtuKExus+nzXYEnur3oKWSqGe58pYn31Zhs5unANTt1O4/tNh7i2Ggupy
         pvGrbz17Uh5a2cb7eeYmSYupyOKiNb5SXeb0bbX7SSl3DIaZHrm1Wh8igIJLEo5rLG2T
         kOKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=67IcpGYjCT+FsM7zbHjM+OI8M/GSYi0Apdlq92IAtKw=;
        b=Bsm8MahG4WhgITaU/IUscPqiXA1T0qDtCNu43er7T2mi/jV8/6ORvohfikGr2CLCma
         Cbr8gJSSlTYcMoNPWlrtX0FlFa9DMhtC2a8kai5LfzBDyYFq2bKvC+/kUl/CzsqHNCzW
         MnBlj0adeWxZozkdSWjp+dQDpWFM7cbgs4KEP2QHYU6Mttqnlgbz/TgefADJi1gBjm+4
         yuloQteih/ZQoIXgWBXsYYZnasaIyUpnOW5OMsseDxHW3ZnVJ+MouGu40ONetQCWkLae
         3RFohaXdvHWwye44oefVcaPM4wC5mJxct5T1O+29QgpCadegjZ4eBdBmza0cAjpxMzWM
         CI9w==
X-Gm-Message-State: AOAM5329kg35FJoM0nL4w5TbI9lVDXsyqZriAwVX/oJQ1WvQtVOjhUq1
        4lnhGvrafNSEROKx3mCpc1sMQetWNDjbdO1QCRmuxn82+YE=
X-Google-Smtp-Source: ABdhPJzQDGKSNuG6Kwa6WRYAOGHzzDEuVlY9p6iwO/hOyhcWYVRYxcbMmK6V+RUHi5OfzInrdCmAXAGXE847ofvzMkQ=
X-Received: by 2002:a9d:7dc4:: with SMTP id k4mr988102otn.251.1591211414645;
 Wed, 03 Jun 2020 12:10:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200603114014.152292216@infradead.org> <20200603120037.GA2570@hirez.programming.kicks-ass.net>
 <20200603120818.GC2627@hirez.programming.kicks-ass.net> <CANpmjNOxLkqh=qpHQjUC_bZ0GCjkoJ4NxF3UuNGKhJSvcjavaA@mail.gmail.com>
 <20200603121815.GC2570@hirez.programming.kicks-ass.net> <CANpmjNPxMo0sNmkbMHmVYn=WJJwtmYR03ZtFDyPhmiMuR1ug=w@mail.gmail.com>
 <CANpmjNPzmynV2X+e76roUmt_3oq8KDDKyLLsgn__qtAb8i0aXQ@mail.gmail.com>
 <20200603160722.GD2570@hirez.programming.kicks-ass.net> <20200603181638.GD2627@hirez.programming.kicks-ass.net>
In-Reply-To: <20200603181638.GD2627@hirez.programming.kicks-ass.net>
From:   Marco Elver <elver@google.com>
Date:   Wed, 3 Jun 2020 21:10:02 +0200
Message-ID: <CANpmjNPJ_vTyTYyrXxP2ei0caLo10niDo8PapdJj2s4-w_R3TA@mail.gmail.com>
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

On Wed, 3 Jun 2020 at 20:16, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Jun 03, 2020 at 06:07:22PM +0200, Peter Zijlstra wrote:
> > On Wed, Jun 03, 2020 at 04:47:54PM +0200, Marco Elver wrote:
>
> > > With that in mind, you could whitelist "__ubsan_handle"-prefixed
> > > functions in objtool. Given the __always_inline+noinstr+__ubsan_handle
> > > case is quite rare, it might be reasonable.
> >
> > Yes, I think so. Let me go have dinner and then I'll try and do a patch
> > to that effect.
>
> Here's a slightly more radical patch, it unconditionally allows UBSAN.
>
> I've not actually boot tested this.. yet.
>
> ---
> Subject: x86/entry, ubsan, objtool: Whitelist __ubsan_handle_*()
> From: Peter Zijlstra <peterz@infradead.org>
> Date: Wed Jun  3 20:09:06 CEST 2020
>
> The UBSAN instrumentation only inserts external CALLs when things go
> 'BAD', much like WARN(). So treat them similar to WARN()s for noinstr,
> that is: allow them, at the risk of taking the machine down, to get
> their message out.
>
> Suggested-by: Marco Elver <elver@google.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

This is much cleaner, as it gets us UBSAN coverage back. Seems to work
fine for me (only lightly tested), so

Acked-by: Marco Elver <elver@google.com>

Thanks!
