Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDA7AC43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 03:24:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95CFA20714
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 03:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585279462;
	bh=EJrO+ay23oFPaDm5e7voyfzo2zotMJYKFA+r8ofPtU8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=TSViV3ZH1Mqnwkj3XguiyxP8nWxTeYip564gNuds/zFqVdVWuaEklJzxq287llmfB
	 aWX69tgPhKSet68VYoyy3bY3+n//yjG9yfPQlYnhzxdBFJHcUoLbtKpn/Wp4ZrGb8B
	 I5dn3GyX0K1eeoYzdM24D9E2HtBbMPp5Lwggo0Ao=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727722AbgC0DYV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 23:24:21 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37790 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726363AbgC0DYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 23:24:21 -0400
Received: by mail-lf1-f68.google.com with SMTP id j11so6690297lfg.4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 20:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WqlgEyg9y7uuAPxy577cVMUd3cF1yLpYiceQFIfBvp0=;
        b=eKUmY5/1JeJPIfRiVE1DqyubJzXLusIjTtIOS6QZI6Lxp260kF2xbps8bxKV5i+MPY
         P6vk0HgEvc9KiCOekc/QzuOAiSvHl52t43HSgbRPU9yqbegFMMIJGif51HsKr1vuTYRZ
         Uq+dwn7ljedT1tMdNmD+BHYa31ROiOUf/ycv8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WqlgEyg9y7uuAPxy577cVMUd3cF1yLpYiceQFIfBvp0=;
        b=qy2U1h0zqVg60HzOLixyAMfWBs7SkhtAgrH0HDnfMsfpsq1/D0bEqG6pdNM9lDm/j3
         t0AYuVOptgLGxiAa+D7emn5QuAxZYvUKQ2JSoID+s7vZdV2iPHsm9akPGTNN7ZOW0nBN
         Q5Vc2Auv50UNeXl7EnXAk7iRvR9ZEHQbwkWt+IERPB8TMyJeblfesnHFhQA/zabq2YBx
         tO49uV/xEOfI2ummkhuzBfe6DN9zRB32xmtVHG1W66sygzdWDz7VCA+syp9RD43GkiXM
         IRudtWgtuStrcD8Dkxf0FqtUa2hR86Bb/aOeZ4baHTfLmRlub1cPWKXyy0Lb7FFHLP5+
         kudw==
X-Gm-Message-State: ANhLgQ2dAthrYqAih7cHgkjqe1UWvH2p8ayhYRJXUxXyclxE809GjsuM
        gpMy/0mE9hKurzxyunA9wiE+Eap2to4=
X-Google-Smtp-Source: ADFU+vt65/q9ZeYpkZHGx2/kmFd5lewNmQrOO/HxkjEOhAvaGl/HFY/zg3isvp+BUbP79dQB0+T/Hw==
X-Received: by 2002:a19:88d4:: with SMTP id k203mr7663365lfd.75.1585279456761;
        Thu, 26 Mar 2020 20:24:16 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id m12sm2161482lji.50.2020.03.26.20.24.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Mar 2020 20:24:15 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id g12so8779606ljj.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 20:24:15 -0700 (PDT)
X-Received: by 2002:a2e:9b8e:: with SMTP id z14mr7111562lji.150.1585279455046;
 Thu, 26 Mar 2020 20:24:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200327022836.881203-1-viro@ZenIV.linux.org.uk> <20200327022836.881203-6-viro@ZenIV.linux.org.uk>
In-Reply-To: <20200327022836.881203-6-viro@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 26 Mar 2020 20:23:59 -0700
X-Gmail-Original-Message-ID: <CAHk-=wga5Z9qk0Wa-Jpwb7x+4BG6C17cHfqX4KKqWm9jATpQUw@mail.gmail.com>
Message-ID: <CAHk-=wga5Z9qk0Wa-Jpwb7x+4BG6C17cHfqX4KKqWm9jATpQUw@mail.gmail.com>
Subject: Re: [RFC][PATCH v2 6/8] x86: don't reload after cmpxchg in
 unsafe_atomic_op2() loop
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 26, 2020 at 7:28 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> From: Al Viro <viro@zeniv.linux.org.uk>
>
> lock cmpxchg leaves the current value in eax; no need to reload it.

I think this one is buggy.

Patch edited to remove the "-" lines, so that you see the end result:

>         int oldval = 0, ret, tem;                               \
>         asm volatile("1:\tmovl  %2, %0\n"                       \
> +                    "2:\tmovl\t%0, %3\n"                       \
>                      "\t" insn "\n"                             \
> +                    "3:\t" LOCK_PREFIX "cmpxchgl %3, %2\n"     \
> +                    "\tjnz\t2b\n"                              \
> +                    "4:\n"                                     \
>                      "\t.section .fixup,\"ax\"\n"               \
> +                    "5:\tmov\t%5, %1\n"                        \
>                      "\tjmp\t3b\n"                              \
>                      "\t.previous\n"                            \
> +                    _ASM_EXTABLE_UA(1b, 5b)                    \
> +                    _ASM_EXTABLE_UA(3b, 5b)                    \
>                      : "=&a" (oldval), "=&r" (ret),             \
>                        "+m" (*uaddr), "=&r" (tem)               \
>                      : "r" (oparg), "i" (-EFAULT), "1" (0));    \

I think that

                       "\tjmp\t3b\n"

line in the fixup section should be

                       "\tjmp\t4b\n"

because you don't want to jump to the cmpxchg instruction.

Maybe I'm misreading it.

               Linus
