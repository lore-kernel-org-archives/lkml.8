Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19E8CC47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 20:18:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA318206E6
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 20:18:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ciEjpD2Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731557AbgEKUSa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 16:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727873AbgEKUS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 16:18:29 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FF58C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 13:18:29 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id b8so5049035pgi.11
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 13:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+m8sVUgc8aPcmghox0D5Tb+emn0mp6DYOcFERI7ISpQ=;
        b=ciEjpD2YdDzSCTfHuoXy/3ajnn9CSNdCqZ1psuhJVatGZygL37Iuh+7h7Ai7PCiWG2
         Qh8Y438cE71v4/X/mh79hbmj/ZkPw8NVPzyrb1IubcctyM/7hfKld+4HzfBsGkIvLaQH
         NV2NEZYROQEWIajvRJF7j9kvd/oYzwEP6mc6YsFgb5fV8sT0HK3U/OgEZF9vA3iPHNvb
         iE817v59mM347GZ6KKbaZDnOPEngKh9Cxs8THlYMc+L0F1T+vmJ61cofOHZKuGyDvS+7
         yWQ1wX0FGX88oV2bQFJGfpC1+A7c/fOuk4k2NSpJPWu5aHq4YM5q98QuJPcBaHe/RpT4
         6pqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+m8sVUgc8aPcmghox0D5Tb+emn0mp6DYOcFERI7ISpQ=;
        b=Fzpjmx7vZ8yPq4RrKRQLZh+5zag1BhDmZ5YFho1fAUOOEYJKQZFQmk2fZ2cny9X2kn
         IOINYAKsaUeXu28D7gdplOPdZAtZJTWFeTD4w+/H+T32Tuk2tzJrrRUd4T7OKzl6fF2B
         VChC7FcESQJ1K8C2Va4fqF8IbHG5fhclkMLbjGHfdnsLwqfXzu8eoPhud00sB7lwf7ZG
         trEngi3tfgGNURv9XuCiPsbkXQ6jWzUgHVdOMGM8QQZ+8Bj5ycg7csBshf+hT99R3KnD
         DQvyjtB/uZx6FRSYxb3kifLJIQZcGnKtwmZyIrCRW6QIkCBof+4VHN14W/ZutMvvk2mb
         xbKw==
X-Gm-Message-State: AGi0PuYMhXGllTxIfhrDVu92zdPSxGMelYqjhjxchkE7wXuhUsPgx3yT
        lHBI2veINLG1Dlvv5wVH0/lgFGFrVg0v1RDEPIVxtQ==
X-Google-Smtp-Source: APiQypL0NijdFR+l6HOF3b13nE9gWqAqZhSNYbhzaEJXXfZT50vsqXzcwLFAojmfCvcwO1Bh+xXLq74pqkGFb+GVVAE=
X-Received: by 2002:aa7:8084:: with SMTP id v4mr15521498pff.39.1589228308658;
 Mon, 11 May 2020 13:18:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200504230309.237398-1-ndesaulniers@google.com>
 <CAKwvOdmspKUknbzDn9kY2jMgkFw=Ktvst0ZtwambDOfybqJGWw@mail.gmail.com>
 <CAMzpN2iDottAY3p=GS0A_7XX7bpmWsmSOEcztMXNEEvcwHirjg@mail.gmail.com>
 <CAKwvOdnxV_KwC-q73e3basJvo4-9FCGeMUOrZLj5xyt6Yyeh2A@mail.gmail.com> <CAMzpN2gTEwGh0U+L3_R6pC8Qmv1iY7bRTiTEXD86mF3u9Nnkqg@mail.gmail.com>
In-Reply-To: <CAMzpN2gTEwGh0U+L3_R6pC8Qmv1iY7bRTiTEXD86mF3u9Nnkqg@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 11 May 2020 13:18:15 -0700
Message-ID: <CAKwvOd=dxX-KG3o6tyYmnoxMwVHvFvvHdaC5G+8ynGEFhZarVQ@mail.gmail.com>
Subject: Re: [PATCH] x86: support i386 with Clang
To:     Brian Gerst <brgerst@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        David Woodhouse <dwmw2@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dmitry Golovin <dima@golovin.in>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 11, 2020 at 12:34 PM Brian Gerst <brgerst@gmail.com> wrote:
>
> On Mon, May 11, 2020 at 2:46 PM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > On Mon, May 11, 2020 at 11:09 AM Brian Gerst <brgerst@gmail.com> wrote:
> > > This looks like the same issue that we just discussed for bitops.h.
> > > Add the "b" operand size modifier to force it to use the 8-bit
> > > register names (and probably also needs the "w" modifier in the 16-bit
> > > case).
> >
> > While it does feel familiar, it is slightly different.
> > https://godbolt.org/z/Rme4Zg
> > That case was both compilers validating the inline asm, yet generating
> > assembly that the assembler would choke on.  This case is validation
> > in the front end failing.
>
> > long long ret;
> > switch (sizeof(ret)) {
> > case 1:
> >         asm ("movb $5, %0" : "=q" (ret));
> >         break;
> > case 8:;
> > }
>
> So if the issue here is that the output variable type is long long,
> what code is using a 64-bit percpu variable on a 32-bit kernel?  Can
> you give a specific file that fails to build with Clang?  If Clang is
> choking on it it may be silently miscompiling on GCC.

I'm not sure that's the case.  Applying this patch, undoing the hunk
in percpu_from_op() we get tons of errors.  Looking at one:

kernel/events/core.c:8679:8: error: invalid output size for constraint '=q'
./include/linux/percpu-defs.h:446:2: note: expanded from macro '__this_cpu_read'
        raw_cpu_read(pcp);                                              \
        ^
...

There's nothing wrong with this line, it's reading a percpu u64 into a
local u64.  The error comes from validating the inline asm in the dead
branch.
-- 
Thanks,
~Nick Desaulniers
