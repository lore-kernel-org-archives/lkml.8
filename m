Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE97EC2D0EF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 19:49:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A29832078E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 19:49:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hZedHUrB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730649AbgDQTtX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 15:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730449AbgDQTtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 15:49:23 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40170C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 12:49:23 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id n24so1321721plp.13
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 12:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=InFG+7wmM1ycJvBdbCnWYIaIthHKtuRUOVVdHek9xPQ=;
        b=hZedHUrB47kHEl6zoxinp3pjiuzikhv2LK3zsgck77sn620PeUvezMA762nYoptxTf
         Q+MDTuUYzD28gdjMhSZ+hLrbyMGHoA7xMJ90hCZgPUP8sr8ahXezraw/djYiWDxdNBKl
         LAF4dpH5CWLzAxx2+RRiRGY1SaGt/uU7z2C33g6/tPFN0X/z05dIvEI2W4FLR4YNCRJf
         m8TGDCiNhhFL5CDpcerRQ41OSlOYk0/29zuC6GuwpZchuLcXQ3xLDZglQcr0r6fJK8gm
         tOTppRL8fBzFChz0T631qibvKXblMrSE4j78PPsATdBiCcEHjkY7tpJTxdoUcrpE6CIk
         PuZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=InFG+7wmM1ycJvBdbCnWYIaIthHKtuRUOVVdHek9xPQ=;
        b=Fuuuq4wyv0paJFJT497a7HmCkhBCm0FHBWdaJX4jgq1uwblX6+I30H/P/XkCd5VLEz
         ReqNf9bgNT8ZXH2lFyRp4cqcYnsC6JNLs19OQGKEysExJFU7Xp2ZdFdP6iALLhxy/1zt
         pik71WbKWeReRTlkN0hOVr+O1Dwy5zmMX2V5WWm4G7mPRTDGunnYOSXsAfeXaR8OlQrV
         T+Np7Iq2ip+wp7wsYjs818+nUb3PKS0BmXymoZp9SID5RG361LKXLIgni4PEsheXxSbZ
         dnvt6ub0uTTXXuhb3+iSyWV1BzS+WaOSOuNY1S0nOnV/EjcyYnrk1A4xHHDOAo0L897C
         mWOQ==
X-Gm-Message-State: AGi0PuYPaGp5h8H17TDO6JaA0NSECrPMYEYjV5MSihP2N27C7MWI5UdD
        qwLphny28uGXE4POj3FEAyulbofowUwCvWiJ2QI9fA==
X-Google-Smtp-Source: APiQypKslFO65KYatKd2wbzpQJIProKQjJuxjfo2AesEJnNQ2cpOBQBqsHr3CdbZj5ut72QEeQu1Gxs2GN9+6+Odyl8=
X-Received: by 2002:a17:902:988e:: with SMTP id s14mr4959971plp.179.1587152962365;
 Fri, 17 Apr 2020 12:49:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200415074842.GA31016@zn.tnic> <alpine.LSU.2.21.2004151445520.11688@wotan.suse.de>
 <20200415231930.19755bc7@sf> <20200417075739.GA7322@zn.tnic>
 <20200417080726.GS2424@tucnak> <20200417084224.GB7322@zn.tnic>
 <20200417085859.GU2424@tucnak> <20200417090909.GC7322@zn.tnic>
 <CAKwvOdnFXPBJsAUD++HtYS5JiR2KmX73M5GAUe-tvX-JYV7DaA@mail.gmail.com>
 <CAKwvOdmNwNwa6rMC27-QZq8VDrYdTQeQqss-bAwF1EMmnAHxdw@mail.gmail.com> <20200417190607.GY2424@tucnak>
In-Reply-To: <20200417190607.GY2424@tucnak>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 17 Apr 2020 12:49:09 -0700
Message-ID: <CAKwvOdkkbWgWmNthq5KijCdtatM9PEAaCknaq8US9w4qaDuwug@mail.gmail.com>
Subject: Re: [PATCH v2] x86: fix early boot crash on gcc-10
To:     Jakub Jelinek <jakub@redhat.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Sergei Trofimovich <slyfox@gentoo.org>,
        Michael Matz <matz@suse.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ah seems we do have __attribute__((no_selector))
(https://reviews.llvm.org/D46300,
https://releases.llvm.org/7.0.0/tools/clang/docs/AttributeReference.html#no-stack-protector-clang-no-stack-protector-clang-no-stack-protector)
which differs from GCC attribute name.

I'm still catching up on the thread (and my cat is insistent about
sleeping on my lap while I'm trying to use my laptop), but I like
https://lore.kernel.org/lkml/20200417190607.GY2424@tucnak/T/#m23d197d3a66a6c7d04c5444af4f51d940895b412
if it additionally defined __no_stack_protector for compiler-clang.h.

On Fri, Apr 17, 2020 at 12:06 PM Jakub Jelinek <jakub@redhat.com> wrote:
>
> On Fri, Apr 17, 2020 at 11:22:25AM -0700, Nick Desaulniers wrote:
> > > Sorry, I don't quite follow.  The idea is that an empty asm statement
> > > in foo() should prevent foo() from being inlined into bar()?
> >
> > s/inlined/tail called/
>
> Yeah.  The thing is, the caller changes the stack protector guard base
> value, so at the start of the function it saves a different value then
> it compares at the end.  But, the function that it calls at the end
> actually doesn't return, so this isn't a problem.
> If it is tail called though, the stack protector guard checking is done
> before the tail call and it crashes.
> If the called function is marked with noreturn attribute or _Noreturn,
> at least GCC will also not tail call it and all is fine, but not sure
> what LLVM does in that case.

Seems fine? https://godbolt.org/z/VEoEfw
(try commenting out the __attribute__((noreturn)) to observe the tail calls.
-- 
Thanks,
~Nick Desaulniers
