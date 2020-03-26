Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4CFAC43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 17:19:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EE8E20775
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 17:19:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Vk72SUbH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728142AbgCZRTA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 13:19:00 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43264 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbgCZRS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 13:18:59 -0400
Received: by mail-pg1-f193.google.com with SMTP id u12so3192770pgb.10
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 10:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0r/SurdDSCSAHVti9CZwgq0zi7acyKoJlvToplzgYwo=;
        b=Vk72SUbH0AvbkhQ5XzcwGL7Voe73IZEF73e/9vZHeWg3ayRXD7y/T9U7Uh5KWQjjP8
         CngWsDMtAPuLWsVlmB7aXos16mH3SNU0M8VlXfCMvp/8Bx9WCHkMBqDmkU0TZ7L01CCW
         e/AUEQ1wJPERfVcLRtO1/uNX+Ay7mqmrzOVwtTg97qIX6gAwTaUXjesu1tEQ/zlL9/rk
         1cmlxmMeuk46R2/U46OrkAlX4oM9FUMXLbvQnIGajbNyi8POyK6bFhuk1yWjrqUn7rqr
         ODl5/33x6szSqlJdysIchhk/nbfRB0LxnzH2MWIHVjMQ4woLENNRFnDJkF0NI40SjDXK
         iXZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0r/SurdDSCSAHVti9CZwgq0zi7acyKoJlvToplzgYwo=;
        b=kQVphSg6t/bbd2nBzYOZLbeJqUNDCEnI1f5HsWf68DE//PL+FB2M83uS8bsezhk88i
         dj0LOj33ETnsdNRhny1z0sGCX5LLQcEw473VZLjwgXcSX5WsEV5GwS56Aw+PMpex19Wa
         hWNOutEDzBVkQ19mK576m1AMZSKd169GwNJIYj5IIiUmyjaq2XSk9IofIBLtb7Jb4n7f
         q6ElVKk6oEfCYg8Q7BHXy/mSs3dLjnRDX75s784k8IhE2u2QFapI1PV17MBB/jPdDpPb
         RK/46wlJFEiu26HCAmc6gDD0Cu8GruNTkxU46FiXhnDQWOnUmlbDQ2ogA74wPtb+5lFH
         HAhA==
X-Gm-Message-State: ANhLgQ0gjTashibggpb4GD4uTwqoYN2c8aRtE9MqY07ikR3eR3cEuROa
        6p6UkDakW9YAObsjX8Wnj2Vcc2/sr8026I5nOJ9xQg==
X-Google-Smtp-Source: ADFU+vte/68TxLOoZDxjEk01TZmRSfqPyyu5ylgPkQx+VuS/XaqbzT6xAtlusN5AxnwbvbOL7dGPmztB+EKwgHNkl2Y=
X-Received: by 2002:a63:a34d:: with SMTP id v13mr9360167pgn.10.1585243137461;
 Thu, 26 Mar 2020 10:18:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200323114207.222412-1-courbet@google.com> <20200326123841.134068-1-courbet@google.com>
In-Reply-To: <20200326123841.134068-1-courbet@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 26 Mar 2020 10:18:45 -0700
Message-ID: <CAKwvOdk0N96DOZCUob0b=0DuAxYFq7-3Ft=RToi7EC8vOAhQZw@mail.gmail.com>
Subject: Re: [PATCH] x86: Alias memset to __builtin_memset.
To:     Clement Courbet <courbet@google.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Joe Perches <joe@perches.com>,
        Bernd Petrovitsch <bernd@petrovitsch.priv.at>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Allison Randal <allison@lohutok.net>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 26, 2020 at 5:38 AM Clement Courbet <courbet@google.com> wrote:
>
> I discussed with the original authors who added freestanding to our
> build. It turns out that it was added globally but this was just to
> to workaround powerpc not compiling under clang, but they felt the
> fix was appropriate globally.
>
> Now Nick has dug up https://lkml.org/lkml/2019/8/29/1300, which
> advises against freestanding. Also, I've did some research and
> discovered that the original reason for using freestanding for
> powerpc has been fixed here:
> https://lore.kernel.org/linuxppc-dev/20191119045712.39633-3-natechancellor@gmail.com/
>
> I'm going to remove -ffreestanding from downstream, so we don't really need
> this anymore, sorry for waisting people's time.
>
> I wonder if the freestanding fix from the aforementioned patch is really needed
> though. I think that clang is actually right to point out the issue.
> I don't see any reason why setjmp()/longjmp() are declared as taking longs
> rather than ints. The implementation looks like it only ever propagates the
> value (in longjmp) or sets it to 1 (in setjmp), and we only ever call longjmp
> with integer parameters. But I'm not a PowerPC expert, so I might
> be misreading the code.
>
>
> So it seems that we could just remove freestanding altogether and rewrite the
> code to:
>
> diff --git a/arch/powerpc/include/asm/setjmp.h b/arch/powerpc/include/asm/setjmp.h
> index 279d03a1eec6..7941ae68fe21 100644
> --- a/arch/powerpc/include/asm/setjmp.h
> +++ b/arch/powerpc/include/asm/setjmp.h
> @@ -12,7 +12,9 @@
>
>  #define JMP_BUF_LEN    23
> -extern long setjmp(long *);
> -extern void longjmp(long *, long);
> +typedef long * jmp_buf;
> +
> +extern int setjmp(jmp_buf);
> +extern void longjmp(jmp_buf, int);
>
> I'm happy to send a patch for this, and get rid of more -ffreestanding.
> Opinions ?

Yes, I think the above diff and additionally cleaning up
-ffreestanding from arch/powerpc/kernel/Makefile and
arch/powerpc/xmon/Makefile would be a much better approach.  If that's
good enough to fix the warning, I kind of can't believe we didn't spot
that in the original code review!

Actually, the god awful warning was:
./arch/powerpc/include/asm/setjmp.h:10:13: error: declaration of
built-in function 'setjmp' requires the declaration of the 'jmp_buf'
type, commonly provided in the header <setjmp.h>.
[-Werror,-Wincomplete-setjmp-declaration]
extern long setjmp(long *) __attribute__((returns_twice));
            ^
So jmp_buf was missing, wasn't used, but also the long vs int confusion.

I tested the above diff, all calls to setjmp under arch/powerpc/ just
compare the return value against 0.  Callers of longjmp just pass 1
for the final parameter. So the above changes should be no functional
change.
-- 
Thanks,
~Nick Desaulniers
