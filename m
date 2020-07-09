Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28A28C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 01:49:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05B78206F6
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 01:49:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f4a5EMFn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbgGIBtA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 21:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbgGIBs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 21:48:59 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86F13C08C5CE
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 18:48:59 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id v6so679711iob.4
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 18:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QF5qDVB9CiXNubN0gxjwlT5anz6G/3fGUWW6m+mjh/M=;
        b=f4a5EMFnpoEpIOCT2oXlDjcF0b/ZlejeP7WJ0unPCeU8k7RJS2jwqBYY3UchX3MC+R
         0VIhpfoVspCcxI/FG1mTWDMMsvtquLn6u4ngA0hXDwTItQqCKmAngTdYbuqL5Pp4H9+f
         IM6g/82klI/9mlc34t4btIqOxh3autPzeHAjKPtcD0PQ6JjklEmO8T0omDi8iMNkc4jz
         8AxEE04zv3hy4rQNqZHlww897HRtaGZZb//cV8eCIZ4uWUlEtbh5StXFLpxtrqmKhe0p
         jLzXL5NJCTuqeWGYgH7u0/nDmDp4upIkMXXwu/JV05qszFAgwhyvBH/y3OlDzayL4bnz
         UzfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QF5qDVB9CiXNubN0gxjwlT5anz6G/3fGUWW6m+mjh/M=;
        b=JoHpo/7HV8UM9Bne0uegejaKJDHGxsyeSLEMfkW7Kd0W8ZcbSekazKsfXjGycj24UZ
         uHjwlweFdxYuItGK4ENw66L7K6OLLGml+f3BbSUz9K0CjOYtFJghOdXh13rTBVjgyi6Y
         baP77K7BMFd+gUxfBTYDPJ9g7+etti0UmLaqBcivjGH53M7SWmusMZd3oDr+Vq0g2mX9
         hPyynRXxUMU2joRqm3z/qvuAcswN7BI5VJh2yotYHDUaOt5oo9U6GNwpKA2+/iFVIH61
         4pi2RfBIecoCx28JhlHdKFxXuhcNekMeF0+SnM+wgZs6mY+3fvNc11uE2FgZMGqDXtIq
         opbA==
X-Gm-Message-State: AOAM533j9HJ2FJWo3Zv9yYavO7+Wpz1XfoqOJg+dI4E1ustxhwFLkRlw
        aYEvSZGUMy+IXLqlxoHCqMIA1g==
X-Google-Smtp-Source: ABdhPJykjsuP8f3ytbr9bj87f8LeVaMs5MpXiLOrth4eoyZLJbgisSTrMtipUQCX3IKpjclikig8iA==
X-Received: by 2002:a05:6638:240f:: with SMTP id z15mr43237378jat.76.1594259338786;
        Wed, 08 Jul 2020 18:48:58 -0700 (PDT)
Received: from [172.22.22.26] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id v16sm1441204iow.19.2020.07.08.18.48.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2020 18:48:58 -0700 (PDT)
Subject: Re: [PATCH v2 1/2 net] bitfield.h: don't compile-time validate _val
 in FIELD_FIT
To:     Nick Desaulniers <ndesaulniers@google.com>,
        "David S . Miller" <davem@davemloft.net>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>, oss-drivers@netronome.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jakub Kicinski <kuba@kernel.org>, stable@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>
References: <20200708230402.1644819-1-ndesaulniers@google.com>
 <20200708230402.1644819-2-ndesaulniers@google.com>
From:   Alex Elder <elder@linaro.org>
Message-ID: <af1c02b8-3856-dac9-67e9-af27803c2eee@linaro.org>
Date:   Wed, 8 Jul 2020 20:48:56 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200708230402.1644819-2-ndesaulniers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/8/20 6:04 PM, Nick Desaulniers wrote:
> From: Jakub Kicinski <kuba@kernel.org>
> 
> When ur_load_imm_any() is inlined into jeq_imm(), it's possible for the
> compiler to deduce a case where _val can only have the value of -1 at
> compile time. Specifically,
> 
> /* struct bpf_insn: _s32 imm */
> u64 imm = insn->imm; /* sign extend */
> if (imm >> 32) { /* non-zero only if insn->imm is negative */
>   /* inlined from ur_load_imm_any */
>   u32 __imm = imm >> 32; /* therefore, always 0xffffffff */
>   if (__builtin_constant_p(__imm) && __imm > 255)
>     compiletime_assert_XXX()
> 
> This can result in tripping a BUILD_BUG_ON() in __BF_FIELD_CHECK() that
> checks that a given value is representable in one byte (interpreted as
> unsigned).

Looking at the 12 other callers of FIELD_FIT(), it's hard to
tell but it appears most of them don't supply constant _val
to the macro.  So maybe relaxing this check is no great loss.

I feel like I need to look much more deeply into this to call
it a review, so:

Acked-by: Alex Elder <elder@linaro.org>

> FIELD_FIT() should return true or false at runtime for whether a value
> can fit for not. Don't break the build over a value that's too large for
> the mask. We'd prefer to keep the inlining and compiler optimizations
> though we know this case will always return false.
> 
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/kernel-hardening/CAK7LNASvb0UDJ0U5wkYYRzTAdnEs64HjXpEUL7d=V0CXiAXcNw@mail.gmail.com/
> Reported-by: Masahiro Yamada <masahiroy@kernel.org>
> Debugged-by: Sami Tolvanen <samitolvanen@google.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
> Changes V1->V2:
> * None
> 
>  include/linux/bitfield.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/bitfield.h b/include/linux/bitfield.h
> index 48ea093ff04c..4e035aca6f7e 100644
> --- a/include/linux/bitfield.h
> +++ b/include/linux/bitfield.h
> @@ -77,7 +77,7 @@
>   */
>  #define FIELD_FIT(_mask, _val)						\
>  	({								\
> -		__BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_FIT: ");	\
> +		__BF_FIELD_CHECK(_mask, 0ULL, 0ULL, "FIELD_FIT: ");	\
>  		!((((typeof(_mask))_val) << __bf_shf(_mask)) & ~(_mask)); \
>  	})
>  
> 

