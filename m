Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44D43C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 20:28:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CC672184D
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 20:28:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eyyBQ3kV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbgEHU2j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 16:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726811AbgEHU2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 16:28:38 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E48CC061A0C
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 13:28:38 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id t3so2538537otp.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 May 2020 13:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IyFIhj/81iNIcxew/1W4kf3IkOg+PZK0fC0YxofxM9k=;
        b=eyyBQ3kVmTEBdu/6V/sBFcv/Spj8vWFYPFgUaDuNst0uTIwmNioqW0DHl3QegBJWAh
         N1Kq55FanpPUu6ZMwM0WPM4xfvli70oA9y89oDyBPWnz6r1OLr8TdpPmP4jh4fSOUBl7
         VRIaZpDpafa8Ygf7axMVFO4xig0rFh+X55H77seDkMgvPw5WIplCqKr8VAArlhdfGG/J
         LhuGzMWUydrNokuNcpWm1m+DH5X4enwSPNC0M07aTbmR3eQqxiM2JZodRIG+wxPScoxw
         C8s+LtgHEwXW2v60WyL8P1kZWX5ZKa5TKYtV57u1x4OCsGX5dMypoKSNVXyxa8bxIJ5L
         Rz3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IyFIhj/81iNIcxew/1W4kf3IkOg+PZK0fC0YxofxM9k=;
        b=ibiQpgsKL/URDkDSJ1a5SUY3OlSdmpkW8uKksBHY2EiN5DIM1AUVJK/E6D8al5Z9Aw
         Avql49u0lYKdobA5z2VHXRsJcNYTfIglnN7TVE/zc4zmLkA9B1XhG5xds+hphyjY6xem
         jY286dSEvTglEuFdZk6LjMOIzMPNtisTBMsff93N7zDq6v29zB5Qc93uvQAQ2502nW9r
         EtL9CAmG5qb0fhx1PZA+Yruu3XR2LTeNwehv7xbXPgFOINh56uWpNtOctAgSoHpmf307
         22HnUsQdD7vlwv+uCCV6slyr8ta134BDScLpUjNKRKzTqtxOROBZbQG0ar3GcR8BWum4
         SUCA==
X-Gm-Message-State: AGi0PuZxeDoAhDt68lgdV2lWQsUaB9rrjHQ8brdT855OINcRnKvYksSR
        N2jpRZA1BGpX5aK8lc1Qwe0eswUGIIY=
X-Google-Smtp-Source: APiQypJ7A2HMOg+s0CNunxQgl5IbpSs1Egdf3tQfXA8gZPl9mVxD55Wbb6EVLYj8vFkkbUUtmy1ZVw==
X-Received: by 2002:a9d:7990:: with SMTP id h16mr3554812otm.145.1588969717893;
        Fri, 08 May 2020 13:28:37 -0700 (PDT)
Received: from ubuntu-s3-xlarge-x86 ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id n6sm722136oof.35.2020.05.08.13.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 13:28:37 -0700 (PDT)
Date:   Fri, 8 May 2020 13:28:35 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        "kernelci . org bot" <bot@kernelci.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Brian Gerst <brgerst@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Ilie Halip <ilie.halip@gmail.com>, x86@kernel.org,
        Marco Elver <elver@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Daniel Axtens <dja@axtens.net>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH v5] x86: bitops: fix build regression
Message-ID: <20200508202835.GA550540@ubuntu-s3-xlarge-x86>
References: <20200508182835.228107-1-ndesaulniers@google.com>
 <20200508183230.229464-1-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200508183230.229464-1-ndesaulniers@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 08, 2020 at 11:32:29AM -0700, Nick Desaulniers wrote:
> This is easily reproducible via CC=clang+CONFIG_STAGING=y+CONFIG_VT6656=m.
> 
> It turns out that if your config tickles __builtin_constant_p via
> differences in choices to inline or not, these statements produce
> invalid assembly:
> 
> $ cat foo.c
> long a(long b, long c) {
>   asm("orb\t%1, %0" : "+q"(c): "r"(b));
>   return c;
> }
> $ gcc foo.c
> foo.c: Assembler messages:
> foo.c:2: Error: `%rax' not allowed with `orb'
> 
> Use the `%b` "x86 Operand Modifier" to instead force register allocation
> to select a lower-8-bit GPR operand.
> 
> The "q" constraint only has meaning on -m32 otherwise is treated as
> "r". Not all GPRs have low-8-bit aliases for -m32.
> 
> Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Link: https://github.com/ClangBuiltLinux/linux/issues/961
> Link: https://lore.kernel.org/lkml/20200504193524.GA221287@google.com/
> Link: https://gcc.gnu.org/onlinedocs/gcc/Extended-Asm.html#x86Operandmodifiers
> Fixes: 1651e700664b4 ("x86: Fix bitops.h warning with a moved cast")
> Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
> Reported-by: kernelci.org bot <bot@kernelci.org>
> Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Suggested-by: Brian Gerst <brgerst@gmail.com>
> Suggested-by: H. Peter Anvin <hpa@zytor.com>
> Suggested-by: Ilie Halip <ilie.halip@gmail.com>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
Tested-by: Nathan Chancellor <natechancellor@gmail.com> # build, clang-11

> ---
> Changes V4 -> V5:
> * actually use `%b` in arch_change_bit().
> 
> Changes V3 -> V4:
> * drop (u8) cast from arch_change_bit() as well.
> 
> Changes V2 -> V3:
> * use `%b` "x86 Operand Modifier" instead of bitwise op then cast.
> * reword commit message.
> * add Brian and HPA suggested by tags
> * drop Nathan & Sedat Tested by/reviewed by tags (new patch is different
>   enough).
> * Take over authorship.
> 
> Changes V1 -> V2:
> * change authorship/signed-off-by to Ilie
> * add Nathan's Tested by/reviewed by
> * update commit message slightly with info sent to HPA.
>  arch/x86/include/asm/bitops.h | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/include/asm/bitops.h b/arch/x86/include/asm/bitops.h
> index b392571c1f1d..35460fef39b8 100644
> --- a/arch/x86/include/asm/bitops.h
> +++ b/arch/x86/include/asm/bitops.h
> @@ -52,9 +52,9 @@ static __always_inline void
>  arch_set_bit(long nr, volatile unsigned long *addr)
>  {
>  	if (__builtin_constant_p(nr)) {
> -		asm volatile(LOCK_PREFIX "orb %1,%0"
> +		asm volatile(LOCK_PREFIX "orb %b1,%0"
>  			: CONST_MASK_ADDR(nr, addr)
> -			: "iq" (CONST_MASK(nr) & 0xff)
> +			: "iq" (CONST_MASK(nr))
>  			: "memory");
>  	} else {
>  		asm volatile(LOCK_PREFIX __ASM_SIZE(bts) " %1,%0"
> @@ -72,9 +72,9 @@ static __always_inline void
>  arch_clear_bit(long nr, volatile unsigned long *addr)
>  {
>  	if (__builtin_constant_p(nr)) {
> -		asm volatile(LOCK_PREFIX "andb %1,%0"
> +		asm volatile(LOCK_PREFIX "andb %b1,%0"
>  			: CONST_MASK_ADDR(nr, addr)
> -			: "iq" (CONST_MASK(nr) ^ 0xff));
> +			: "iq" (~CONST_MASK(nr)));
>  	} else {
>  		asm volatile(LOCK_PREFIX __ASM_SIZE(btr) " %1,%0"
>  			: : RLONG_ADDR(addr), "Ir" (nr) : "memory");
> @@ -123,9 +123,9 @@ static __always_inline void
>  arch_change_bit(long nr, volatile unsigned long *addr)
>  {
>  	if (__builtin_constant_p(nr)) {
> -		asm volatile(LOCK_PREFIX "xorb %1,%0"
> +		asm volatile(LOCK_PREFIX "xorb %b1,%0"
>  			: CONST_MASK_ADDR(nr, addr)
> -			: "iq" ((u8)CONST_MASK(nr)));
> +			: "iq" (CONST_MASK(nr)));
>  	} else {
>  		asm volatile(LOCK_PREFIX __ASM_SIZE(btc) " %1,%0"
>  			: : RLONG_ADDR(addr), "Ir" (nr) : "memory");
> -- 
> 2.26.2.645.ge9eca65c58-goog
> 
