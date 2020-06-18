Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B31C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 21:43:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11460208C3
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 21:43:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="V8mp4jvy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731189AbgFRVn0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 17:43:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbgFRVnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 17:43:22 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D854C06174E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 14:43:22 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id x207so3436304pfc.5
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 14:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=MCieKSv/d/exPmPAc7GwarGBCkAH7xKxzBmQYr15/Mk=;
        b=V8mp4jvyFG4zJvLAWNOdhumVntlmDxZZq/AwM7zrUUDHvFbBYuqdahXr5Xl5RsZWNP
         McQV2xYz0a9JAYqNmaocKtBwdWZkbyzhiJcDskBhX1oigc/Nhe124z2aEuZFPanpjJvo
         uN/PbKkX7EYUYrXf3KbIFgnd7EyavDQFCPgFNgavAaRi/qGhjqXqN7hJoWpGRlXqzyWe
         52Rrov6055Z9UJFAQ4uk9ABRJ3YtRHTx3rduIoJ13/F3hBTUWLrXQObKwlHcKW0yopVu
         lG2tCyXQxN6KrrnIfNPF/0HpuVO/XRBsRHl5G21GqkCraQ0fxibpGPWsR3P/0f4QNC21
         gY5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=MCieKSv/d/exPmPAc7GwarGBCkAH7xKxzBmQYr15/Mk=;
        b=qPjSDOgfokI46W9RuhB1czCnIgDkpja4Z5nUg18II1bP0bS+m+gHyWitiooRX2tT27
         W58kVIn5nqSPgrP3xD99YqJ1raqkv36QTGR47TKMP02QFVddNikVk3Kl98Y5sUsFN9Gf
         PWPqk/w95Pd1vrKZSLkSWAvpHhTaKU3XqV3uH2W+VeNaKldtmYM4JcsUszKsN71fExP5
         ebKxQAl54rYQ7UcKZuHJFqIdgFBHtbC+YRuPjqih+8qWad7kmfks6QGw52oDyl7mz0yk
         XwRnIWYz4k/ZQuhcev3ASNM4imVJl36V3JXOGHaIOWMg+FZm4OSUIrWi1kvZv0/U1KdV
         oLzw==
X-Gm-Message-State: AOAM533ZC/UuZNoORqY0ZIF5LqaGcs7EO5/UibvjCZHmhki5Cp+RE98o
        +VaZ2gyJSUXBe8tN5+Ik23+0OQ==
X-Google-Smtp-Source: ABdhPJwweIQW+LbWu+cyDIJEt3TduPx5LkFVOSuIXAzVaGFHv07HldXcFv0276BewwTjHxXw6vfmvw==
X-Received: by 2002:aa7:9abc:: with SMTP id x28mr5293452pfi.39.1592516601272;
        Thu, 18 Jun 2020 14:43:21 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id 130sm3695771pfw.176.2020.06.18.14.43.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 14:43:20 -0700 (PDT)
Date:   Thu, 18 Jun 2020 14:43:20 -0700 (PDT)
X-Google-Original-Date: Thu, 18 Jun 2020 14:43:16 PDT (-0700)
Subject:     Re: [PATCH] riscv/atomic: Fix sign extension for RV64I
In-Reply-To: <20200611183235.37508-1-nhuck@google.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com, nhuck@google.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     nhuck@google.com
Message-ID: <mhng-daf9e66b-0b4a-42ee-92ef-e2a08101a362@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Jun 2020 11:32:35 PDT (-0700), nhuck@google.com wrote:
> The argument passed to cmpxchg is not guaranteed to be sign
> extended, but lr.w sign extends on RV64I. This makes cmpxchg
> fail on clang built kernels when __old is negative.
>
> To fix this, we just cast __old to long which sign extends on
> RV64I. With this fix, clang built RISC-V kernels now boot.
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/867
> Cc: clang-built-linux@googlegroups.com
> Signed-off-by: Nathan Huckleberry <nhuck@google.com>
> ---
>  arch/riscv/include/asm/cmpxchg.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
> index d969bab4a26b..262e5bbb2776 100644
> --- a/arch/riscv/include/asm/cmpxchg.h
> +++ b/arch/riscv/include/asm/cmpxchg.h
> @@ -179,7 +179,7 @@
>  			"	bnez %1, 0b\n"				\
>  			"1:\n"						\
>  			: "=&r" (__ret), "=&r" (__rc), "+A" (*__ptr)	\
> -			: "rJ" (__old), "rJ" (__new)			\
> +			: "rJ" ((long)__old), "rJ" (__new)		\
>  			: "memory");					\
>  		break;							\
>  	case 8:								\
> @@ -224,7 +224,7 @@
>  			RISCV_ACQUIRE_BARRIER				\
>  			"1:\n"						\
>  			: "=&r" (__ret), "=&r" (__rc), "+A" (*__ptr)	\
> -			: "rJ" (__old), "rJ" (__new)			\
> +			: "rJ" ((long)__old), "rJ" (__new)		\
>  			: "memory");					\
>  		break;							\
>  	case 8:								\
> @@ -270,7 +270,7 @@
>  			"	bnez %1, 0b\n"				\
>  			"1:\n"						\
>  			: "=&r" (__ret), "=&r" (__rc), "+A" (*__ptr)	\
> -			: "rJ" (__old), "rJ" (__new)			\
> +			: "rJ" ((long)__old), "rJ" (__new)		\
>  			: "memory");					\
>  		break;							\
>  	case 8:								\
> @@ -316,7 +316,7 @@
>  			"	fence rw, rw\n"				\
>  			"1:\n"						\
>  			: "=&r" (__ret), "=&r" (__rc), "+A" (*__ptr)	\
> -			: "rJ" (__old), "rJ" (__new)			\
> +			: "rJ" ((long)__old), "rJ" (__new)		\
>  			: "memory");					\
>  		break;							\
>  	case 8:								\

So we talked about this earlier, but just so everyone's one the same page: I
think this should be a compiler bug, but the spec doesn't define any of this
stuff well enough that it actually is.  I'm sort of inclined to make it a
compiler bug, but I'm not sure if that's still possible and it requires a lot
more work.  I'm writing up a bigger email, but it's been floating around for a
few days and I don't want to delay this on sorting out what our inline assembly
actually does.

I've put this on fixes.

Thanks!
