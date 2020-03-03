Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DE1FC3F2CD
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 05:00:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08AAD20848
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 05:00:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nbtp2Tl3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725828AbgCCFAC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 00:00:02 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38342 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbgCCFAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 00:00:02 -0500
Received: by mail-pl1-f195.google.com with SMTP id p7so757684pli.5
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 21:00:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OSg+JSGp6hQhw1bce7F3mzW7bduFXt5gWaDypQm8zyQ=;
        b=nbtp2Tl36OKExvWG4Z11h/mNp7CTtxBemLmJhMZ31czsu66C86WttOMdwcZrEfew9l
         stexFmDexS+B5uCgHu4F404ZjmjNs/DCYfxYCA74JgeyMxOOnWB5Wq+tRyLYJp3gcR1C
         9in0FcBLeOIrELlzyfvQH3MvAXgrRU6VQDef8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OSg+JSGp6hQhw1bce7F3mzW7bduFXt5gWaDypQm8zyQ=;
        b=f355WdCdZmxyPb9SRuxAqU/eZzeVuP2u8lAo5hwO8TbnM13jYwVEXw5loEJ8zC5hgM
         p/b0LpbXT2xQbTOLtESVrYeISSU0Fju/4uR4ql3p8hCJ8BB+2qoJ0vOlz3VZAzgkOUPQ
         fWhoxxATmjzz1LDCGaiJXVoax90Kd6VsKgXm0z1WdWo/UsVtUqHhym3btRRoGGYzzdS4
         Pv8BihN6vhjSkRM0FBDKCCRr0uJe0f8zTmbeHV6xW6I9Xe12FA829OwwQJEukIEQ2Si4
         QdudnIbD2pwWKO3G8rSltz7Jg3fVDDRLPg8zymFFlTf3ZNM5rX9TXS23tpClH/wbH7zp
         SvYg==
X-Gm-Message-State: ANhLgQ1WYA245gtUpfo5ln1D+WuQI9BCL3SktzZ2o6AE1p8WS50oytOx
        gZLKdxNTJTdTxVuERR5xNL8pkg==
X-Google-Smtp-Source: ADFU+vupxZfjILlqH5h0J2YTQlKFsovubCjWTMtXLdyyWGfbmfoz5dCW8BCqr9rffqRMgylCer7bUg==
X-Received: by 2002:a17:90b:2290:: with SMTP id kx16mr2109790pjb.152.1583211601610;
        Mon, 02 Mar 2020 21:00:01 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g7sm532672pjl.17.2020.03.02.21.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 21:00:00 -0800 (PST)
Date:   Mon, 2 Mar 2020 20:59:59 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Garnier <thgarnie@chromium.org>
Cc:     kernel-hardening@lists.openwall.com, kristen@linux.intel.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 11/11] x86/alternatives: Adapt assembly for PIE
 support
Message-ID: <202003022059.67FCB9CB75@keescook>
References: <20200228000105.165012-1-thgarnie@chromium.org>
 <20200228000105.165012-12-thgarnie@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200228000105.165012-12-thgarnie@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2020 at 04:00:56PM -0800, Thomas Garnier wrote:
> Change the assembly options to work with pointers instead of integers.
> The generated code is the same PIE just ensures input is a pointer.
> 
> Signed-off-by: Thomas Garnier <thgarnie@chromium.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  arch/x86/include/asm/alternative.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
> index 13adca37c99a..43a148042656 100644
> --- a/arch/x86/include/asm/alternative.h
> +++ b/arch/x86/include/asm/alternative.h
> @@ -243,7 +243,7 @@ static inline int alternatives_text_reserved(void *start, void *end)
>  /* Like alternative_io, but for replacing a direct call with another one. */
>  #define alternative_call(oldfunc, newfunc, feature, output, input...)	\
>  	asm_inline volatile (ALTERNATIVE("call %P[old]", "call %P[new]", feature) \
> -		: output : [old] "i" (oldfunc), [new] "i" (newfunc), ## input)
> +		: output : [old] "X" (oldfunc), [new] "X" (newfunc), ## input)
>  
>  /*
>   * Like alternative_call, but there are two features and respective functions.
> @@ -256,8 +256,8 @@ static inline int alternatives_text_reserved(void *start, void *end)
>  	asm_inline volatile (ALTERNATIVE_2("call %P[old]", "call %P[new1]", feature1,\
>  		"call %P[new2]", feature2)				      \
>  		: output, ASM_CALL_CONSTRAINT				      \
> -		: [old] "i" (oldfunc), [new1] "i" (newfunc1),		      \
> -		  [new2] "i" (newfunc2), ## input)
> +		: [old] "X" (oldfunc), [new1] "X" (newfunc1),		      \
> +		  [new2] "X" (newfunc2), ## input)
>  
>  /*
>   * use this macro(s) if you need more than one output parameter
> -- 
> 2.25.1.481.gfbce0eb801-goog
> 

-- 
Kees Cook
