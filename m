Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF33FC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 21:04:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8253020734
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 21:04:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bOP7TlKt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728670AbgFAVEr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 17:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727875AbgFAVEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 17:04:47 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01FD8C061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 14:04:47 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id k2so349705pjs.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 14:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c89nzIUmVYClehsGT37noOH+nKmXC+jdlhbLWMBSiQM=;
        b=bOP7TlKtN6fDoNPrO/8e2R6H/rjVdA8aYI+OuiaOLEqCwa8GU3K48DYmRO1fl0YenU
         A7ytxTRl9AwfxsQDyODeG/ThvxEMe1KxNz9ndI+PvRWTIt6ASep8TE4M30Tciykja8d/
         VPfRnGCzZ9gfSF3qesti10Ofq6JoHRaWCa+MmwLettPwWR6senuq2TVqUHPVhVrWzqaU
         rxuuD87FXfiuXCMyFd3pVgHAXhqwcGK6TC3t6xStivbT55MpvATDr3M/HlJ7vFdPdd0v
         1IB+ZHr8e1eUeacDXfxAt/BCzIG3goxwRayFIy3j8wbRx++HdcouZbdr5+046TCH6k+C
         l+Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c89nzIUmVYClehsGT37noOH+nKmXC+jdlhbLWMBSiQM=;
        b=K2RHBem4cbsAeP2sw7YMUb2wPZ+CCvbcu39rQopU2N2knB0LKZPnBIMx8qbO7Xrss4
         K47fwoh+e8fh0PpiQ+Ri2Jcwzg88W5qO7xsddqU66s7SeSlh1S+btXO2pjKfMP82/YIP
         +We1XQ72zPovXHCFB3ot/namjaNhA6a9E/S5TKgdaoCcpxE9Be4fpvjiYgdc+fiZyoZC
         c171k7XRlntZIcj1FFRmBEBM6FYq7GwDIASXrSwTK2l32bEPqVcVmjbAXHd8DS1QZAhF
         IYfWTQjapOm66Wuc69VDAv7fZ7zsMwVAuLJ+KVpxt22Q6NeCAQGNJppnUS1BGU7LQK4q
         atnQ==
X-Gm-Message-State: AOAM530DCn7NZcyelT3V4gpIc9EKCUKDO3+Jig1dkE1vi0lAhwOzkQXG
        zySDr91twdjleiBcYNThhXeT0L41oGVdUGAP/27Glg==
X-Google-Smtp-Source: ABdhPJyOOUcxV06ayk7oZRGXPmTsVnpSUVSIPDL93Xo6TS1FiN9RmnPW4U93F//O23gjxQ1zUE482vKuAaUZtYqrG84=
X-Received: by 2002:a17:90b:4c47:: with SMTP id np7mr1433736pjb.101.1591045486114;
 Mon, 01 Jun 2020 14:04:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200527141553.1768675-1-arnd@arndb.de> <CAKwvOdk8PToaHMWVKV-6Uhhx6CNz15OWLOp_5RCERvdOisLrpA@mail.gmail.com>
 <CAGG=3QWwafjBUPaGLbJxyU7K65H0SnHBHZ-mnxtAC2A1xfjWYA@mail.gmail.com>
In-Reply-To: <CAGG=3QWwafjBUPaGLbJxyU7K65H0SnHBHZ-mnxtAC2A1xfjWYA@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 1 Jun 2020 14:04:34 -0700
Message-ID: <CAKwvOd=8iPixqQLweaaFSaq2+YKNxO_N2a-+nEK24M6CS3x7cg@mail.gmail.com>
Subject: Re: [PATCH] x86: fix clang integrated assembler build
To:     Bill Wendling <morbo@google.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "# 3.4.x" <stable@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Jiri Slaby <jslaby@suse.cz>,
        Juergen Gross <jgross@suse.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Tony Luck <tony.luck@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Fangrui Song <maskray@google.com>,
        Jian Cai <jiancai@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 1:57 PM Bill Wendling <morbo@google.com> wrote:
>
>
>
> On Wed, May 27, 2020 at 11:04 AM Nick Desaulniers <ndesaulniers@google.com> wrote:
>>
>> On Wed, May 27, 2020 at 7:16 AM Arnd Bergmann <arnd@arndb.de> wrote:
>> >
>> > clang and gas seem to interpret the symbols in memmove_64.S and
>> > memset_64.S differently, such that clang does not make them
>> > 'weak' as expected, which leads to a linker error, with both
>> > ld.bfd and ld.lld:
>> >
>> > ld.lld: error: duplicate symbol: memmove
>> > >>> defined at common.c
>> > >>>            kasan/common.o:(memmove) in archive mm/built-in.a
>> > >>> defined at memmove.o:(__memmove) in archive arch/arm64/lib/lib.a
>> >
>> > ld.lld: error: duplicate symbol: memset
>> > >>> defined at common.c
>> > >>>            kasan/common.o:(memset) in archive mm/built-in.a
>> > >>> defined at memset.o:(__memset) in archive arch/arm64/lib/lib.a
>> >
>> > Copy the exact way these are written in memcpy_64.S, which does
>> > not have the same problem.
>> >
>> > I don't know why this makes a difference, and it would be good
>> > to have someone with a better understanding of assembler internals
>> > review it.
>> >
>> > It might be either a bug in the kernel or a bug in the assembler,
>> > no idea which one. My patch makes it work with all versions of
>> > clang and gcc, which is probably helpful even if it's a workaround
>> > for a clang bug.
>> >
>> > Cc: stable@vger.kernel.org
>> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>>
>> + Bill, Fangrui, Jian
>> I think we saw this bug or a very similar bug internally around the
>> ordering of .weak to .global.
>>
> I think that would be this patch by Fangrui:
>
>   https://prodkernel-review.git.corp.google.com/c/kernel/release/9xx/+/292011

Thanks. That patch references this discussion:
https://lore.kernel.org/linuxppc-dev/20200325164257.170229-1-maskray@google.com/

>
> -bw
>
>>
>> > ---
>> >  arch/x86/lib/memmove_64.S | 4 ++--
>> >  arch/x86/lib/memset_64.S  | 4 ++--
>> >  2 files changed, 4 insertions(+), 4 deletions(-)
>> >
>> > diff --git a/arch/x86/lib/memmove_64.S b/arch/x86/lib/memmove_64.S
>> > index 7ff00ea64e4f..dcca01434be8 100644
>> > --- a/arch/x86/lib/memmove_64.S
>> > +++ b/arch/x86/lib/memmove_64.S
>> > @@ -26,8 +26,8 @@
>> >   */
>> >  .weak memmove
>> >
>> > -SYM_FUNC_START_ALIAS(memmove)
>> > -SYM_FUNC_START(__memmove)
>> > +SYM_FUNC_START_ALIAS(__memmove)
>> > +SYM_FUNC_START_LOCAL(memmove)
>> >
>> >         mov %rdi, %rax
>> >
>> > diff --git a/arch/x86/lib/memset_64.S b/arch/x86/lib/memset_64.S
>> > index 9ff15ee404a4..a97f2ea4e0b2 100644
>> > --- a/arch/x86/lib/memset_64.S
>> > +++ b/arch/x86/lib/memset_64.S
>> > @@ -19,8 +19,8 @@
>> >   *
>> >   * rax   original destination
>> >   */
>> > -SYM_FUNC_START_ALIAS(memset)
>> > -SYM_FUNC_START(__memset)
>> > +SYM_FUNC_START_ALIAS(__memset)
>> > +SYM_FUNC_START_LOCAL(memset)
>> >         /*
>> >          * Some CPUs support enhanced REP MOVSB/STOSB feature. It is recommended
>> >          * to use it when possible. If not available, use fast string instructions.
>> > --
>> > 2.26.2
>> >
>> > --
>> > You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
>> > To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
>> > To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20200527141553.1768675-1-arnd%40arndb.de.
>>
>>
>>
>> --
>> Thanks,
>> ~Nick Desaulniers



-- 
Thanks,
~Nick Desaulniers
