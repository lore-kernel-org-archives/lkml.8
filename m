Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC675C3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 15:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAB9E206F9
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 15:47:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZDtoQrdG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbgCWPrY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 11:47:24 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:37944 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727176AbgCWPrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 11:47:24 -0400
Received: by mail-ot1-f68.google.com with SMTP id t28so13841806ott.5
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 08:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cItIuGU2gR6wVLWQZQIQDeYiaP+Gc3FxK48fZM1brJk=;
        b=ZDtoQrdGGlgu75KoHaK60jCUVrLQZE1+QnsJ4tGfG4vAD9Acz0nNQiNrCABc1w7gUr
         N0kaqBhWvXNmUnm2BgEv+qeEgn8DVbX5vDwwkbo5uBYuDZ+sr5SuftcU2K3kV42i1JOg
         lBTOz50tJwChTdzUOiOXWe52jxfbGkL2BDZtKCjQ9rJ2hu03qEygyQdiDPmVYEYfnAUP
         8kJWK8JO89b/G4/XbVGe5YDk6BBz09OWKMGhI8o2LXYrl1rOOlCJM/kqTuJ0BwJ5nUZG
         xM4PVqZYi+D0kfbBibDO016lqGbTLk9P2Jxda+mUDfGjcI3Mfh0Tv4I0tddAQSNIC1EG
         /wnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cItIuGU2gR6wVLWQZQIQDeYiaP+Gc3FxK48fZM1brJk=;
        b=qEc55IVMmEsUavJfxPZDuwCCtNoUIFAskaPUXdIVJVXsxzUGfo9d2JDJOE7zmeN6Ms
         oUdgTPRqsSlHfsl8KtM2wUUaAYLW5txqEangZLH68nxj3/2O78DU71Gf/9TaHhLAuEly
         c+mGD/0vCyUBpXSAZphUudz3kJ0NWWZcdpjz208EOmm9QMmQ7DEh0P8ebWDypbrmYO6/
         7rMpolrTY2cRm5n5Z81v+JRGlt7i9upKf7iMF/gwbt9doGoeoqvS9sp5rTeX9oewn89L
         NMs2YjfEZCqN943VxgcVa6qpt3LqV/pk9zqapJA07g5DfG1ilTk3NOLShNUwx/iyhjdq
         l+Gw==
X-Gm-Message-State: ANhLgQ0IM2aOGpyTcA9aEEsTSygxjUCYW1f9wWqlgpEvb1+JzjKF6jYp
        LkB/5scHUOddn99WBPMrvz5GbZuH
X-Google-Smtp-Source: ADFU+vvhIvZo++vpC2sEQ+aVp7I3JdDelQ2YEVzzpCKyvbHCRqADKg+N8Nc327lxhP0mF6a+vd3BKg==
X-Received: by 2002:a05:6830:201a:: with SMTP id e26mr19198262otp.238.1584978443730;
        Mon, 23 Mar 2020 08:47:23 -0700 (PDT)
Received: from ubuntu-m2-xlarge-x86 ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id g5sm5424312oiy.27.2020.03.23.08.47.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Mar 2020 08:47:22 -0700 (PDT)
Date:   Mon, 23 Mar 2020 08:47:21 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Clement Courbet <courbet@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH]     x86: Alias memset to __builtin_memset.
Message-ID: <20200323154721.GB40380@ubuntu-m2-xlarge-x86>
References: <20200323114207.222412-1-courbet@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200323114207.222412-1-courbet@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 23, 2020 at 12:42:06PM +0100, 'Clement Courbet' via Clang Built Linux wrote:
>     Recent compilers know the meaning of builtins (`memset`,
>     `memcpy`, ...) and can replace calls by inline code when
>     deemed better. For example, `memset(p, 0, 4)` will be lowered
>     to a four-byte zero store.
> 
>     When using -ffreestanding (this is the case e.g. building on
>     clang), these optimizations are disabled. This means that **all**
>     memsets, including those with small, constant sizes, will result
>     in an actual call to memset.
> 
>     We have identified several spots where we have high CPU usage
>     because of this. For example, a single one of these memsets is
>     responsible for about 0.3% of our total CPU usage in the kernel.
> 
>     Aliasing `memset` to `__builtin_memset` allows the compiler to
>     perform this optimization even when -ffreestanding is used.
>     There is no change when -ffreestanding is not used.
> 
>     Below is a diff (clang) for `update_sg_lb_stats()`, which
>     includes the aforementionned hot memset:
>         memset(sgs, 0, sizeof(*sgs));
> 
>     Diff:
>         movq %rsi, %rbx        ~~~>  movq $0x0, 0x40(%r8)
>         movq %rdi, %r15        ~~~>  movq $0x0, 0x38(%r8)
>         movl $0x48, %edx       ~~~>  movq $0x0, 0x30(%r8)
>         movq %r8, %rdi         ~~~>  movq $0x0, 0x28(%r8)
>         xorl %esi, %esi        ~~~>  movq $0x0, 0x20(%r8)
>         callq <memset>         ~~~>  movq $0x0, 0x18(%r8)
>                                ~~~>  movq $0x0, 0x10(%r8)
>                                ~~~>  movq $0x0, 0x8(%r8)
>                                ~~~>  movq $0x0, (%r8)
> 
>     In terms of code size, this grows the clang-built kernel a
>     bit (+0.022%):
>     440285512 vmlinux.clang.after
>     440383608 vmlinux.clang.before
> 
> Signed-off-by: Clement Courbet <courbet@google.com>
> ---
>  arch/x86/include/asm/string_64.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/x86/include/asm/string_64.h b/arch/x86/include/asm/string_64.h
> index 75314c3dbe47..7073c25aa4a3 100644
> --- a/arch/x86/include/asm/string_64.h
> +++ b/arch/x86/include/asm/string_64.h
> @@ -18,6 +18,15 @@ extern void *__memcpy(void *to, const void *from, size_t len);
>  void *memset(void *s, int c, size_t n);
>  void *__memset(void *s, int c, size_t n);
>  
> +/* Recent compilers can generate much better code for known size and/or
> + * fill values, and will fallback on `memset` if they fail.
> + * We alias `memset` to `__builtin_memset` explicitly to inform the compiler to
> + * perform this optimization even when -ffreestanding is used.
> + */
> +#if (__GNUC__ >= 4)

This ifdef is unnecessary, this will always be true because the minimum
supported GCC version is 4.6 and clang pretends it is 4.2.1. It appears
the Intel compiler will pretend to be whatever whatever GCC version the
host is using (no idea if it is still used by anyone or truly supported
but still worth mentioning) so it would still always be true because of
the GCC 4.6 requirement.

I cannot comment on the validity of the patch even though the reasoning
seems sound to me.

Cheers,
Nathan

> +#define memset(s, c, count) __builtin_memset(s, c, count)
> +#endif
> +
>  #define __HAVE_ARCH_MEMSET16
>  static inline void *memset16(uint16_t *s, uint16_t v, size_t n)
>  {
> @@ -74,6 +83,7 @@ int strcmp(const char *cs, const char *ct);
>  #undef memcpy
>  #define memcpy(dst, src, len) __memcpy(dst, src, len)
>  #define memmove(dst, src, len) __memmove(dst, src, len)
> +#undef memset
>  #define memset(s, c, n) __memset(s, c, n)
>  
>  #ifndef __NO_FORTIFY
> -- 
> 2.25.1.696.g5e7596f4ac-goog
> 
