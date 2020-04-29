Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48C12C83000
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 22:47:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2527E20757
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 22:47:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbgD2WrQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 18:47:16 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:35987 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726164AbgD2WrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 18:47:16 -0400
Received: from mail-qt1-f177.google.com ([209.85.160.177]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1Mbkac-1itE5c1Wnu-00dCHZ for <linux-kernel@vger.kernel.org>; Thu, 30 Apr
 2020 00:47:14 +0200
Received: by mail-qt1-f177.google.com with SMTP id v26so3462064qto.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 15:47:14 -0700 (PDT)
X-Gm-Message-State: AGi0PubR1ErpX7LBYGkqttg/ifipVUtihKNiGukwi7CLiDAxNAKGEnvE
        Y1+cP+Mlu1eBhKYEVLVX9kHAPoDW1TgXuSK+O2s=
X-Google-Smtp-Source: APiQypLplSKTUGiR0ZWf/3t3HIdK4LBUX9u1J9ZYBeDYJ0hO9VI+n9TLMwvsJxpyu8mxqwLftBlvmV3gGEtsatMttDo=
X-Received: by 2002:ac8:4c8d:: with SMTP id j13mr684743qtv.142.1588200433220;
 Wed, 29 Apr 2020 15:47:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a2qLJkokMGt48JRky=WUeAbJRuNmoD1oqfWdrGSC6y1LA@mail.gmail.com>
 <20200428161044.caamvx67t2z4t6vd@treble> <20200429185536.5xshpcwtn4be4llh@treble>
In-Reply-To: <20200429185536.5xshpcwtn4be4llh@treble>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 30 Apr 2020 00:46:57 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0M9qh2-_5VKx89ZsTfy5S1zhfWwnO7rN4xYhDwBBvPjw@mail.gmail.com>
Message-ID: <CAK8P3a0M9qh2-_5VKx89ZsTfy5S1zhfWwnO7rN4xYhDwBBvPjw@mail.gmail.com>
Subject: Re: Remaining randconfig objtool warnings, linux-next-20200428
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:kJXsrWp3/YRsrqGzA4eWIVtdtOGSjvD/4bNuwSAlkACxuVwtuqP
 pCZ/X4KVcMe6O/tg9gyTEG3GEAnGmYuI8iPsKpZ6ORT3Y3Qa4PtfIb4ffbSw9WLlMmE41vO
 u2b7WRSfmOUqSMSGCSy+oz7AYO9ibyE7WPkIynwKsAY2Sk76aVDUK6d/YCSSVwYJX4RxJyu
 zX/MGtYhmPa5C+yxiOagg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kV93q/HSReY=:qk05a4cfYvmQL+cX2GUamo
 ulkTq1tYQoDt9IiDjkrCoa9JOJXHyPfNKgJwB7qVuY1Fx8l/r8wodskd8Lh1Ot24zTuozkGYm
 GkTTIPRCy8u/LRx8hliZYcLgMPz/Qkp/m61RZFCQ4YwYQDv2f9Onl0tio6QiPSKqh4Sa9+Z//
 ssiaq+HtOT6RHeLrUdYeer3XJjD7OlQwT3QI7s7WV3cXycCW/Z3pwkerWqyXpJOEq7oidDmI9
 8rQYVNL+E9zEpis1xgCJhY3PoI9iuKIEgNbKofcfqzesCEt6aplXN48QHdDc6cQp9ZzxWS3Ts
 4ZyHl4HR5fUIACiFdoDEbVpN2YUDoOXyPG80IulvNUWXMKwq8TqZZ9b4pnv+B1KV1wFG4zOAq
 ZHc5/k+2KpBjwv3kpz6XVue3rSI8g7q3gM1WofPZ7HZAp1b7rEmxDz/Qw3ZRagggvI+IcdLHY
 kliPG9A8nOu90+dbEXWy2knC40nb73MuITHUOjIayVcJkAw9mnaGQ9xwDWqy7dToAc8vOqNeh
 u6v7k1C/F2RWI5VsJ/sOUZRQwK1sNMotN1jQ08yjAHWVF2BFebl/IyGrJTjAHmwOk1w6qb24E
 bBCPc8jKzLVZCYyJvBzBE1++y8+8M/qjF/Ur1QRpO2cAHuq5mE2TSk+MHHnC2M25+wcLeEZ3E
 1Pv1opp9KJ6pMpYnbl7TB/syAgH7gu5UpEROGZoRfE9rCe+2Py5JqwPG7YWGFQr+NMp4zXSln
 d2fSyKOZvcMul11g50ifdYOs0Ox0yhsauQVeLHKN+Fv9AkerBo8n9zyKLi1iuH5UhBwNbY+ag
 iPldjwDkhTL0ALRxZU1qG3D0UYvXVkyO3qTOVb4+DGFF6IiHMk=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 29, 2020 at 8:55 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> On Tue, Apr 28, 2020 at 11:10:44AM -0500, Josh Poimboeuf wrote:
> > > ==> build/x86/0xE0F2ACFF_defconfig/log <==
> > > kernel/time/posix-stubs.o: warning: objtool: __x64_sys_timer_create()+0x23: sibling call from callable instruction with modified stack frame
>
> This one is fixed with the following cleanup:
>
> From: Josh Poimboeuf <jpoimboe@redhat.com>
> Subject: [PATCH] linkage: Convert syscall alias macros to C
>
> There's no need to use inline asm to create ELF alias symbols.
> Annotated C function declarations can be used instead.
>
> This also makes the ordering of the ELF symbol table more logical, with
> the real function now always coming before the aliases.  This makes it
> easier for objtool, objdump and other tools to differentiate them.
>
> This fixes the following warning:
>
>   kernel/time/posix-stubs.o: warning: objtool: __x64_sys_timer_create()+0x23: sibling call from callable instruction with modified stack frame
>
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> ---
>  include/linux/linkage.h | 14 ++++----------
>  1 file changed, 4 insertions(+), 10 deletions(-)

Unfortunately, this patch leads to new warnings when
CONFIG_POSIX_TIMERS is disabled:

In file included from /git/arm-soc/kernel/time/posix-stubs.c:9:
/git/arm-soc/kernel/time/posix-stubs.c:35:37: error: conflicting types
for 'sys_timer_create'
   35 | #define SYS_NI(name)  SYSCALL_ALIAS(sys_##name, sys_ni_posix_timers)
      |                                     ^~~~
/git/arm-soc/include/linux/linkage.h:26:63: note: in definition of
macro 'SYSCALL_ALIAS'
   26 | #define SYSCALL_ALIAS(alias, name) __alias(name) typeof(name) alias
      |                                                               ^~~~~
/git/arm-soc/kernel/time/posix-stubs.c:42:1: note: in expansion of
macro 'SYS_NI'
   42 | SYS_NI(timer_create);
      | ^~~~~~
In file included from /git/arm-soc/kernel/time/posix-stubs.c:13:
/git/arm-soc/include/linux/syscalls.h:616:17: note: previous
declaration of 'sys_timer_create' was here
  616 | asmlinkage long sys_timer_create(clockid_t which_clock,
      |                 ^~~~~~~~~~~~~~~~

We can probably move those SYS_NI() instances to kernel/sys_ni.c,
which does not include the header, but it's still a bit ugly. I'll try
that tomorrow
unless you come up with a better suggestion first.

        Arnd
