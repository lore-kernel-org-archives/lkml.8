Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86A8AC10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 16:40:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 532832067C
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 16:40:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="A2mIKIMp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbgCIQkw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 12:40:52 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40711 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727083AbgCIQkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 12:40:51 -0400
Received: by mail-pg1-f195.google.com with SMTP id t24so4952635pgj.7
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 09:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WTvrl8fRpnRiASZqhFGETSdxBpHyS37A1HRGojDdq8A=;
        b=A2mIKIMpPkaRMpQMHk9TwxhktTJ2T3uuBhRLddnMQ4yigfv7zwqTpURhxVyTB06iB8
         oufBJkIiw6itkAMdjWsgbw82mco66J26jsxYw+Y0zaaQmqjnrOpdcIMPg2MwIkqyFlO5
         xCDvsoC70L+nwUs2MygA7OZDRuHdhoEVIBA0Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WTvrl8fRpnRiASZqhFGETSdxBpHyS37A1HRGojDdq8A=;
        b=gkMzV6h3z5ieJ8Xujyr+m252yN4IQJX6TZhXxH+boQcVbj3Ad24bgjxBd4sHJLol6h
         8ujfzaIQVR1e7AJnp3iGZY4TwQCm7AinnrJ/tIHs1pKJ3GkqXY5IRBZXUF3UrfKb1jGA
         KIk+CXxlvi8GpdEbhvcucOTU47kGHDEhmvwkMkTg6s+Em/QduMBbeJ0oKJG0lmdDEZbN
         +zlrd7e0P2ni7XVeTM70TkayRBeiKcYOcHPJn6XF8AcUn4QispK1GWwt1eEwJFWHqoLi
         WO3S0MJeaGHX/LoMsknJAz29T07p3iCdrJ8D4IK3TyEYG88/Ia6sv4P2PDriMhKyRFMa
         ZBcw==
X-Gm-Message-State: ANhLgQ1lZ3WizZiIcTWMt9iiYXwTVpLuCd1bP4yYINhr8qQ0j7jFeR6A
        Y2srXF/PlRzWZ19lfvsRu1Z4G9ILQk4=
X-Google-Smtp-Source: ADFU+vs05CXKSjfSL+xssvtv8H+whaiud7nM8sXdZEPyQaf2+pNUDEb177gNXZ0D5iJN6r4SxBXqiQ==
X-Received: by 2002:a62:5447:: with SMTP id i68mr17665917pfb.44.1583772049811;
        Mon, 09 Mar 2020 09:40:49 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 19sm7403775pgx.63.2020.03.09.09.40.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 09:40:48 -0700 (PDT)
Date:   Mon, 9 Mar 2020 09:40:47 -0700
From:   Kees Cook <keescook@chromium.org>
To:     akpm@linux-foundation.org
Cc:     Rikard Falkeborn <rikard.falkeborn@gmail.com>, bp@alien8.de,
        geert@linux-m68k.org, haren@us.ibm.com, joe@perches.com,
        johannes@sipsolutions.net, linux-kernel@vger.kernel.org,
        mingo@redhat.com, tglx@linutronix.de, yamada.masahiro@socionext.com
Subject: Re: [PATCH v5] linux/bits.h: Add compile time sanity check of
 GENMASK inputs
Message-ID: <202003090940.C44356F1@keescook>
References: <20191101212857.GA889092@rikard>
 <20200308193954.2372399-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200308193954.2372399-1-rikard.falkeborn@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 08, 2020 at 08:39:54PM +0100, Rikard Falkeborn wrote:
> GENMASK() and GENMASK_ULL() are supposed to be called with the high bit
> as the first argument and the low bit as the second argument. Mixing
> them will return a mask with zero bits set.
> 
> Recent commits show getting this wrong is not uncommon, see e.g.
> commit aa4c0c9091b0 ("net: stmmac: Fix misuses of GENMASK macro") and
> commit 9bdd7bb3a844 ("clocksource/drivers/npcm: Fix misuse of GENMASK
> macro").
> 
> To prevent such mistakes from appearing again, add compile time sanity
> checking to the arguments of GENMASK() and GENMASK_ULL(). If both
> arguments are known at compile time, and the low bit is higher than the
> high bit, break the build to detect the mistake immediately.
> 
> Since GENMASK() is used in declarations, BUILD_BUG_ON_ZERO() must be
> used instead of BUILD_BUG_ON().
> 
> __builtin_constant_p does not evaluate is argument, it only checks if it
> is a constant or not at compile time, and __builtin_choose_expr does not
> evaluate the expression that is not chosen. Therefore, GENMASK(x++, 0)
> does only evaluate x++ once.
> 
> Commit 95b980d62d52 ("linux/bits.h: make BIT(), GENMASK(), and friends
> available in assembly") made the macros in linux/bits.h available in
> assembly. Since BUILD_BUG_OR_ZERO() is not asm compatible, disable the
> checks if the file is included in an asm file.
> 
> Due to bugs in GCC versions before 4.9 [0], disable the check if
> building with a too old GCC compiler.
> 
> [0]: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=19449
> 
> Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> Reviewed-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> Another attempt to get this merged. I've test built allmodconfig for
> i386, x86_64 and arm64 for linux-next 20200306 without issues. Also, the
> last known GENMASK issue was just merged into Linus tree [1].
> 
> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=96b4ea324ae92386db2b0c73ace597c80cde1ecb 
> 
> Changes in v5:
>   - Added Masahiros Reviewed-by
>   - Waited for bugfixes to get merged
> 
> Changes in v4:
>   - Disable the argument check for GCC < 4.9 due to a compiler bug.
> 
> Changes in v3:
>   - Changed back to shorter macro argument names
>   - Remove casts and use 0 instead of UL(0) in GENMASK_INPUT_CHECK(),
>     since all results in GENMASK_INPUT_CHECK() are now ints. Update
>     commit message to reflect that.
> 
> Changes in v2:
>   - Add comment about why inputs are not checked when used in asm file
>   - Use UL(0) instead of 0
>   - Extract mask creation in a separate macro to improve readability
>   - Use high and low instead of h and l (part of this was extracted to a
>     separate patch)
>   - Updated commit message
> 
> Joe Perches sent a series to fix the existing misuses of GENMASK().
> Those patches have been merged into Linus tree except two places where
> the GENMASK misuse is in unused macros, which will not fail to build.
> There was also a patch by Nathan Chancellor that have now been merged.
> 
>  include/linux/bits.h | 22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/bits.h b/include/linux/bits.h
> index 669d69441a62..f108302a3121 100644
> --- a/include/linux/bits.h
> +++ b/include/linux/bits.h
> @@ -18,12 +18,30 @@
>   * position @h. For example
>   * GENMASK_ULL(39, 21) gives us the 64bit vector 0x000000ffffe00000.
>   */
> -#define GENMASK(h, l) \
> +#if !defined(__ASSEMBLY__) && \
> +	(!defined(CONFIG_CC_IS_GCC) || CONFIG_GCC_VERSION >= 49000)
> +#include <linux/build_bug.h>
> +#define GENMASK_INPUT_CHECK(h, l) \
> +	(BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
> +		__builtin_constant_p((l) > (h)), (l) > (h), 0)))
> +#else
> +/*
> + * BUILD_BUG_ON_ZERO is not available in h files included from asm files,
> + * disable the input check if that is the case.
> + */
> +#define GENMASK_INPUT_CHECK(h, l) 0
> +#endif
> +
> +#define __GENMASK(h, l) \
>  	(((~UL(0)) - (UL(1) << (l)) + 1) & \
>  	 (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
> +#define GENMASK(h, l) \
> +	(GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
>  
> -#define GENMASK_ULL(h, l) \
> +#define __GENMASK_ULL(h, l) \
>  	(((~ULL(0)) - (ULL(1) << (l)) + 1) & \
>  	 (~ULL(0) >> (BITS_PER_LONG_LONG - 1 - (h))))
> +#define GENMASK_ULL(h, l) \
> +	(GENMASK_INPUT_CHECK(h, l) + __GENMASK_ULL(h, l))
>  
>  #endif	/* __LINUX_BITS_H */
> -- 
> 2.25.1
> 

-- 
Kees Cook
