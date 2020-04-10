Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9E2EC2D0EC
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 19:12:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2F3720732
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 19:12:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H+d2DRuC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbgDJTMb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 15:12:31 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40461 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbgDJTMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 15:12:30 -0400
Received: by mail-pg1-f195.google.com with SMTP id c5so1347934pgi.7
        for <linux-kernel@vger.kernel.org>; Fri, 10 Apr 2020 12:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3NQtoOnuEyxQY/FXT5lwephyBfBpFPfFqIghUX3xTuc=;
        b=H+d2DRuC5uWXZpX/3zSYsDctHQDJdl5XvbQUIahyvyhCvUUEkAOZTLvlJ4MdVDrAxJ
         hwuXLFDFu7au0oPsmF5ZRM75oMAQU1ziYWJgIrhJWjMCwpSVsn/3bbrd/Xht7H+tzGfu
         JSsZQPO5URTEHKm1Js91otw06j96spA1T+3VsF9z5KowXxZBRi3OlhMqrqBuV1NL7X6G
         4bcXp1zOJXStN1i2UjAa8JKmChnosagW0ChvFARU5XsgMh2iWKltXwXx8rIvBW+KLcMs
         fcmISbQSCWu3nbMYK9BPqBLB8dqMaDfgCMmXbc1eUhE+8t8Do9oyLyeHCc1HAzDmC6Ty
         Uzjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3NQtoOnuEyxQY/FXT5lwephyBfBpFPfFqIghUX3xTuc=;
        b=kX45+HBtSQrSCG4TPd09DZMiykEos0o4PiWh6OeXFQsz8XwQHVmLj9uNL8LM3QTLte
         AIScZvxackMsb+iNXKSRl8t4XPW87ECjW3xufti9QzZGh9G2qBt6Kexy2lP6ask/71EX
         XnIcci2ma1U3mZekQx6B40J5bAbMWF+M9lYscz606StrJ53PEEEeEuds6QOPdmNhdhGu
         bqciYjP0osYw8TVpndk/Wx1VASV/JV3lZVug+tOhpINvW6QFXgcqK3PG2bMIuwsEtsLB
         PPTG5QNzknPgyvT7eYYKAwxQ+MkjL3djPVKB5aYhnCKqSOmgYvbewsvjzmX9CoqU2Jrj
         hYEA==
X-Gm-Message-State: AGi0PuYIchJmiR5VG5REirxTKFKJHYMCofDsHo9fN7f/3vPuUCx8yf/0
        isAiXmbKT6Xfivb/DZcgcS9BubBj9kYXJhGVlGS00Q==
X-Google-Smtp-Source: APiQypIQu3i+xg3Mv9W2hQf5k6DodRvFxrVe3HbAdOGfQYNONuXB7G+Me9krYHvUKDEkwINL9D7H46OWsyOkK07BcYo=
X-Received: by 2002:a63:6604:: with SMTP id a4mr5543148pgc.381.1586545949327;
 Fri, 10 Apr 2020 12:12:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200325231250.99205-1-ndesaulniers@google.com>
 <CAKwvOdm8tQaa6BW7EQAz4TxFZETnJCS3z9isY4HvcU7UYqWZUA@mail.gmail.com>
 <20200403222458.GA49554@ubuntu-m2-xlarge-x86> <20200404004020.jilng63qqyccbgke@google.com>
In-Reply-To: <20200404004020.jilng63qqyccbgke@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 10 Apr 2020 12:12:18 -0700
Message-ID: <CAKwvOdkjJWDcN1bNJtcGjNJ0KStRH0Lk+Ge7wEU4gxXPDWQ_PQ@mail.gmail.com>
Subject: Re: [PATCH] elfnote: mark all .note sections SHF_ALLOC
To:     Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Ilie Halip <ilie.halip@gmail.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Fangrui Song <maskray@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(bumping for review)

On Fri, Apr 3, 2020 at 5:40 PM Fangrui Song <maskray@google.com> wrote:
>
> On 2020-04-03, Nathan Chancellor wrote:
> >On Fri, Apr 03, 2020 at 03:13:34PM -0700, 'Nick Desaulniers' via Clang Built Linux wrote:
> >> dropping Jeremy; I got bounceback from the email address. Ping for review?
> >>
> >> On Wed, Mar 25, 2020 at 4:13 PM Nick Desaulniers
> >> <ndesaulniers@google.com> wrote:
> >> >
> >> > ELFNOTE_START allows callers to specify flags for .pushsection assembler
> >> > directives.  All callsites but ELF_NOTE use "a" for SHF_ALLOC. For
> >> > vdso's that explicitly use ELF_NOTE_START and BUILD_SALT, the same
> >> > section is specified twice after preprocessing, once with "a" flag, once
> >> > without. Example:
> >> >
> >> > .pushsection .note.Linux, "a", @note ;
> >> > .pushsection .note.Linux, "", @note ;
> >> >
> >> > While GNU as allows this ordering, it warns for the opposite ordering,
> >> > making these directives position dependent. We'd prefer not to precisely
> >> > match this behavior in Clang's integrated assembler.  Instead, the non
> >> > __ASSEMBLY__ definition of ELF_NOTE uses
> >> > __attribute__((section(".note.Linux"))) which is created with SHF_ALLOC,
> >> > so let's make the __ASSEMBLY__ definition of ELF_NOTE consistent with C
> >> > and just always use "a" flag.
> >> >
> >> > This allows Clang to assemble a working mainline (5.6) kernel via:
> >> > $ make CC=clang AS=clang
> >> >
> >> > Link: https://github.com/ClangBuiltLinux/linux/issues/913
> >> > Cc: Jeremy Fitzhardinge <jeremy@xensource.com>
> >> > Debugged-by: Ilie Halip <ilie.halip@gmail.com>
> >> > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> >
> >Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
>
> I asked on binutils@sourceware.org whether GNU as is willing to change.
> https://sourceware.org/pipermail/binutils/2020-March/109997.html
> I'll also ping that thread.
>
>
> Reviewed-by: Fangrui Song <maskray@google.com>
>
> >> > ---
> >> > Ilie has further treewide cleanups:
> >> > https://github.com/ihalip/linux/commits/elfnote
> >> > This patch is the simplest to move us forwards.
> >> >
> >> >  include/linux/elfnote.h | 2 +-
> >> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >> >
> >> > diff --git a/include/linux/elfnote.h b/include/linux/elfnote.h
> >> > index 594d4e78654f..69b136e4dd2b 100644
> >> > --- a/include/linux/elfnote.h
> >> > +++ b/include/linux/elfnote.h
> >> > @@ -54,7 +54,7 @@
> >> >  .popsection                            ;
> >> >
> >> >  #define ELFNOTE(name, type, desc)              \
> >> > -       ELFNOTE_START(name, type, "")           \
> >> > +       ELFNOTE_START(name, type, "a")          \
> >> >                 desc                    ;       \
> >> >         ELFNOTE_END
> >> >
> >> > --

-- 
Thanks,
~Nick Desaulniers
