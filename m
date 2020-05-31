Return-Path: <SRS0=AKQz=7N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11561C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 09:32:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD6F220707
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 09:32:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xw7LhJ3V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727996AbgEaJcQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 May 2020 05:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbgEaJcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 05:32:15 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 382C2C061A0E
        for <linux-kernel@vger.kernel.org>; Sun, 31 May 2020 02:32:15 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id ec10so545019qvb.5
        for <linux-kernel@vger.kernel.org>; Sun, 31 May 2020 02:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BZ0Nb+D2BlnH8V9KcsWA38LcbQH/W/Hv8FyeJMQSm4E=;
        b=Xw7LhJ3V6PkWtUA7kGdT2SDjkYkljX+j1MdAYPbqZi07I5gGKEc2lBQOSBZefLVkQQ
         desChS1RuL07+Dg0D1jZUm85p3YtYHg7jwYxzcOxol9PIMmY2MUT69NDaGrCC5CYlE96
         F0ILaNm6AdnF933jmpZzbNenJ7/O+O2q6DeYIM1QY36wmDg/HZDJpbdFWgInegykuh3e
         5jcP1KM+26mhcJ7UmstzV6Hq0LZKv33ChMNA+cfIV+zS+1tgGwrk3afAFB53GicY9E0A
         fW8mKe0BXUZ9j7E4aj/BThb61cYJsaT8zuRgWWlf51h7zUtiSTkO4VGI3ptlpeBuJLgo
         BKEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BZ0Nb+D2BlnH8V9KcsWA38LcbQH/W/Hv8FyeJMQSm4E=;
        b=KpgivmJCdDAGuCgBHqi7ZCc3tSlPXF4licyTsitysXhvyDYYQJN/XFYUumxfHIxRqM
         AU7rpvkUZ38WgtB6Fx5EknppFKtXfRRRvaHZclGHFVTBofayjYgEza/tcpqD2UCz3wMO
         7sIl11aMXTLcftPWvTCkoz2G3hnPOaJdgE5xLPXRzIH/9mgLAJihaXUzPoiElaDxdLG3
         Z0/CCOjZIdhyuxZciVy+br8siCM+GJ03dMpmYQFhZmhBQCxeS9Knfray4aCJZZweCGo6
         303l8nvPrt8oqyUPI1dR4+2cpSCqRThE4XMqOgokAJwQQ58f4l85wiI20G/MqxPDOdMJ
         XMtw==
X-Gm-Message-State: AOAM533stHENr2fESTd9i7mXSe+Pw/kZ3cqPuf1D9MnBiRdC5PCvKmfy
        jW5GnUe8b3/HR5bm7F9wWZeNae8uxb8EnJ2nLkWEhw==
X-Google-Smtp-Source: ABdhPJwBUgCkO9WBFaCd/WLMLZDKm1hAr8BrIK8yT7W5UydHHqHpWN163wrjdQZkysjW5aK4mT/o75fLlkCujwH83q8=
X-Received: by 2002:a05:6214:bc5:: with SMTP id ff5mr16199847qvb.34.1590917533617;
 Sun, 31 May 2020 02:32:13 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000d2474c05a6c938fe@google.com> <CACT4Y+ajjB8RmG3_H_9r-kaRAZ05ejW02-Py47o7wkkBjwup3Q@mail.gmail.com>
 <87o8q6n38p.fsf@nanos.tec.linutronix.de> <20200529160711.GC706460@hirez.programming.kicks-ass.net>
 <20200529171104.GD706518@hirez.programming.kicks-ass.net>
In-Reply-To: <20200529171104.GD706518@hirez.programming.kicks-ass.net>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Sun, 31 May 2020 11:32:02 +0200
Message-ID: <CACT4Y+YB=J0+w7+SHBC3KpKOzxh1Xaarj1cXOPOLKPKQwAW6nQ@mail.gmail.com>
Subject: Re: PANIC: double fault in fixup_bad_iret
To:     Peter Zijlstra <peterz@infradead.org>,
        Marco Elver <elver@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        syzbot <syzbot+dc1fa714cb070b184db5@syzkaller.appspotmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 29, 2020 at 7:11 PM Peter Zijlstra <peterz@infradead.org> wrote:
> > Like with KCSAN, we should blanket kill KASAN/UBSAN and friends (at the
> > very least in arch/x86/) until they get that function attribute stuff
> > sorted.
>
> Something like so.
>
> ---
> diff --git a/arch/x86/Makefile b/arch/x86/Makefile
> index 00e378de8bc0..a90d32b87d7e 100644
> --- a/arch/x86/Makefile
> +++ b/arch/x86/Makefile
> @@ -1,6 +1,14 @@
>  # SPDX-License-Identifier: GPL-2.0
>  # Unified Makefile for i386 and x86_64
>
> +#
> +# Until such a time that __no_kasan and __no_ubsan work as expected (and are
> +# made part of noinstr), don't sanitize anything.
> +#
> +KASAN_SANITIZE := n
> +UBSAN_SANITIZE := n
> +KCOV_INSTRUMENT := n
> +
>  # select defconfig based on actual architecture
>  ifeq ($(ARCH),x86)
>    ifeq ($(shell uname -m),x86_64)

+kasan-dev
+Marco, please send a fix for this
