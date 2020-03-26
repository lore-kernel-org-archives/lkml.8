Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48A57C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 20:00:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18C6F206E6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 20:00:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KbididJg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728502AbgCZUAv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 16:00:51 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39144 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727612AbgCZUAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 16:00:50 -0400
Received: by mail-pf1-f193.google.com with SMTP id d25so3323729pfn.6
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 13:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FlSVVlhlYYW7/x0OqEsezQf2BkVBpegKGjBAddfWNUk=;
        b=KbididJgsGKs+7m9AR24gcfdwEmhINz+umf+OjZjPHpVHguqJjmfKqF0W2Ppac0tUg
         4O+p7atIWuXQ8TY8fXVrVlvj16ut5wLWxJ1gT6QBG0cmcKoi+70H/isKgCJTd+dSCnlz
         mmsJAbyd1UgA1qXQAnclG3S6swQ5rdWq4Yctw3LD3KoiEtptQcWExB7LZZ0wQCWuithI
         MS3rZg4bZKs3xCCzHcYi76/N8JIFL18WJCCr47746skxpi3gJqAANiCnxuPtJGVzUx4Z
         T0hMraWAOGAy9KWk5bczutZMbBNff6cPttZcNogY59lV+I4yYFwbRg3CPKZD1pJ7iAp3
         jwJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FlSVVlhlYYW7/x0OqEsezQf2BkVBpegKGjBAddfWNUk=;
        b=gKLVJsLPWQRWdiOjskWGiRywvo8qx0RH0TBRo62x+16oKziJFkYoxZS1/lzr75mufm
         TB3kKaUEKkHi42Ew5b5Y1Btc4xPtBgQyqqBAyK46Er19RCLFK5URd7vZ+aaiYYOEaUkE
         PzClcDY9BiU2oQ85OOGRHtFHTDrUk96XLIYTtepBNgWZ3+qbPLI3IUmWIu7hRZeweEoC
         vMmTpLyIZg08Stn4cXjqoboGlQsg3uc/pdD5t+E4870AlAJ2i5D2so7yNvZnU0/s6bMP
         q2OOl7WmrsSNVIjVTnArT1nNYLs3izX1MsbidSmh6TieywS58ktEOxpWtBBFFMe2j4gn
         SAoA==
X-Gm-Message-State: ANhLgQ1r9Zez895nYwhqfTO3d/3UJg6xg9se4wN3dqmpKSJw5guXkFEo
        H1GFozLJqZaA1gjTzsJAuWRbgFJML0UgSpDyA5m1YQ==
X-Google-Smtp-Source: ADFU+vsXlfYtpSptaeecY6E6uaFdB6/SfI28A8caF1H7oZVFDiixPQWN1SWCuskSTE+9lx5h2gjPX3DDnWzsl9+7Xnw=
X-Received: by 2002:aa7:918e:: with SMTP id x14mr2179958pfa.39.1585252849021;
 Thu, 26 Mar 2020 13:00:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200326080104.27286-1-masahiroy@kernel.org> <20200326080104.27286-11-masahiroy@kernel.org>
 <CAKwvOdk=MCePWHD=Kj3K7fD0y8TBZfiFLB0X+gnhPUd=RnrH6A@mail.gmail.com> <CAHmME9oD7DVSGVkWv2jAyr5eZUy2Ac+MWzss5dhKEmG3hq6AFg@mail.gmail.com>
In-Reply-To: <CAHmME9oD7DVSGVkWv2jAyr5eZUy2Ac+MWzss5dhKEmG3hq6AFg@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 26 Mar 2020 13:00:35 -0700
Message-ID: <CAKwvOdmG4hRnG+R_ASLULdEVm31XkEo4vih7GxpNWK9f6xtCng@mail.gmail.com>
Subject: Re: [PATCH v2 10/16] x86: probe assembler capabilities via kconfig
 instead of makefile
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 26, 2020 at 12:54 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> On Thu, Mar 26, 2020 at 11:49 AM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > On Thu, Mar 26, 2020 at 1:02 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
> > >
> > > From: "Jason A. Donenfeld" <Jason@zx2c4.com>
> > >
> > > Doing this probing inside of the Makefiles means we have a maze of
> > > ifdefs inside the source code and child Makefiles that need to make
> > > proper decisions on this too. Instead, we do it at Kconfig time, like
> > > many other compiler and assembler options, which allows us to set up the
> > > dependencies normally for full compilation units. In the process, the
> > > ADX test changes to use %eax instead of %r10 so that it's valid in both
> > > 32-bit and 64-bit mode.
> >
> > Does KConfig generate -D<foo> flags for KBUILD_CFLAGS and KBUILD_AFLAGS?
>
> kconfig sticks everything it's got into include/generated/autoconf.h.
> That's how you're able to use all those #ifdef CONFIG_* macros
> already. This change moves things from a command line -D to the
> autoconf.h file.

Cool, I wondered how that was wired up.  Though seeing the word
"autoconf" brings on PTSD for me.
Patch LGTM.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>
> > Looks like lib/raid6/test/Makefile also generates some of these?
>
> raid6 has its own crazy thing going on. The test directory compiles
> that code for use in userspace. You might argue that its whole
> situation is non-standard and weird and should be reworked
> differently, but that seems like fodder for a different patchset on
> the linux-raid list.



-- 
Thanks,
~Nick Desaulniers
