Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B930C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 02:11:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F17A206F6
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 02:11:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HyeOmbP6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbgGICLL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 22:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbgGICLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 22:11:07 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90738C061A0B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 19:11:07 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id v8so734218iox.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 19:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XQKwdZHWoHY2rSxRNRjfiy4s8SsL+NaMfgyEBt9FVMQ=;
        b=HyeOmbP69hy5by2aKWO+LM8Rs2KtKRT74K82KD4HQTcsFZ24MRyGImPMPlhce5FHKb
         AVus0TeDI83nyIRToHSqku0RA4HGwTAL5ENXwXeHv44Jds3sj4bF8WhCYbj8r7bgQZX8
         h1n0vY8UXXY/sOsykWUrcsQwCcl6DDc/qcA4LUL1/mPVcwR3p3PrNVtA44v3c5NzyZVh
         N8ejoRw1b4NQ0x5fhgokSs9XRpZcwY53GV0BDNOG2S5bv+uHpi0dt4onj+C/tDuHyHFB
         drmo7nrDYGNPcVV8q0mos3wMH+Q8ZYZFKQnayhJo4xjo/3iC7fgP1syB8eC/lhK35S5w
         gBgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XQKwdZHWoHY2rSxRNRjfiy4s8SsL+NaMfgyEBt9FVMQ=;
        b=qWekBAb5tpHz+xPUYmx6dvf0BnXopzkuFtDkL44X9EQPTcKOPuAO3IH5JHhAoNKmWJ
         T57R0K2loYAnalBhMntexiT4vXMW8443TEKjXcxgx4R5gA8q8YRSja92Mn7ZrNSLVdm9
         eQD8qZrUBF8TM0WCcJKQinPndBP7+oxB8lUYala2+w6HxMDMZ216ryOWjIICJu1aR0HK
         mqHx8yei9/RX9PDApOm2F9YdJJLUiWeocUR5Gcx+R8r2Be+fNvuCG1DwqisSnpJEMySi
         AruXKx9tC+RRhPB5jS1mtziMbPTuvX5Yuukx8t68WkX3KQxvVHZk7jsLo+uC9DG/G9yA
         7vCw==
X-Gm-Message-State: AOAM533YkEoaNfXAkcHhH/bzMMG0ibILPSSRlkOGP5MNt20RdOMQeBT8
        yEFXrUt2T58BHZitwXbc/Wrwtg==
X-Google-Smtp-Source: ABdhPJyu4qYUVmwutCnsTR9t8EWrgbz3Zq8qaXzw3Z7hYQ/d7qhwCYxzFOsvCag0r1fGqW4U84SL9w==
X-Received: by 2002:a5d:9590:: with SMTP id a16mr23921644ioo.150.1594260666941;
        Wed, 08 Jul 2020 19:11:06 -0700 (PDT)
Received: from [172.22.22.26] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id t12sm1049935ilo.80.2020.07.08.19.11.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2020 19:11:06 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] bitfield.h: split up __BF_FIELD_CHECK macro
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
        Jakub Kicinski <kuba@kernel.org>
References: <20200708230402.1644819-1-ndesaulniers@google.com>
 <20200708230402.1644819-3-ndesaulniers@google.com>
From:   Alex Elder <elder@linaro.org>
Message-ID: <4ff07f7c-f4d5-1d50-e9b4-86ded2c20081@linaro.org>
Date:   Wed, 8 Jul 2020 21:11:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200708230402.1644819-3-ndesaulniers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/8/20 6:04 PM, Nick Desaulniers wrote:
> This macro has a few expansion sites that pass literal 0s as parameters.
> Split these up so that we do the precise checks where we care about
> them.
> 
> Suggested-by: Alex Elder <elder@linaro.org>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

I do like this better.  It makes it more obvious when only
the mask is being verified (in FIELD_FIT() for example).
I also appreciate that you distinguished the register
checks from the value checks.
- field masks must be (2^x - 1) << y, x > 0, and constant
- values must be representable within a field mask
- registers must be able to represent the field mask

Reviewed-by: Alex Elder <elder@linaro.org>

> ---
> Changes V1-V2:
> * New patch in v2.
> * Rebased on 0001.
> 
>  .../netronome/nfp/nfpcore/nfp_nsp_eth.c       | 11 ++++----
>  include/linux/bitfield.h                      | 26 +++++++++++++------
>  2 files changed, 24 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_nsp_eth.c b/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_nsp_eth.c
> index 311a5be25acb..938fc733fccb 100644
> --- a/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_nsp_eth.c
> +++ b/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_nsp_eth.c
> @@ -492,11 +492,12 @@ nfp_eth_set_bit_config(struct nfp_nsp *nsp, unsigned int raw_idx,
>  	return 0;
>  }
>  
> -#define NFP_ETH_SET_BIT_CONFIG(nsp, raw_idx, mask, val, ctrl_bit)	\
> -	({								\
> -		__BF_FIELD_CHECK(mask, 0ULL, val, "NFP_ETH_SET_BIT_CONFIG: "); \
> -		nfp_eth_set_bit_config(nsp, raw_idx, mask, __bf_shf(mask), \
> -				       val, ctrl_bit);			\
> +#define NFP_ETH_SET_BIT_CONFIG(nsp, raw_idx, mask, val, ctrl_bit)		\
> +	({									\
> +		__BF_FIELD_CHECK_MASK(mask, "NFP_ETH_SET_BIT_CONFIG: ");	\
> +		__BF_FIELD_CHECK_VAL(mask, val, "NFP_ETH_SET_BIT_CONFIG: ");	\
> +		nfp_eth_set_bit_config(nsp, raw_idx, mask, __bf_shf(mask),	\
> +				       val, ctrl_bit);				\
>  	})
>  
>  /**
> diff --git a/include/linux/bitfield.h b/include/linux/bitfield.h
> index 4e035aca6f7e..79651867beb3 100644
> --- a/include/linux/bitfield.h
> +++ b/include/linux/bitfield.h
> @@ -41,18 +41,26 @@
>  
>  #define __bf_shf(x) (__builtin_ffsll(x) - 1)
>  
> -#define __BF_FIELD_CHECK(_mask, _reg, _val, _pfx)			\
> +#define __BF_FIELD_CHECK_MASK(_mask, _pfx)				\
>  	({								\
>  		BUILD_BUG_ON_MSG(!__builtin_constant_p(_mask),		\
>  				 _pfx "mask is not constant");		\
>  		BUILD_BUG_ON_MSG((_mask) == 0, _pfx "mask is zero");	\
> +		__BUILD_BUG_ON_NOT_POWER_OF_2((_mask) +			\
> +					      (1ULL << __bf_shf(_mask))); \
> +	})
> +
> +#define __BF_FIELD_CHECK_VAL(_mask, _val, _pfx)				\
> +	({								\
>  		BUILD_BUG_ON_MSG(__builtin_constant_p(_val) ?		\
>  				 ~((_mask) >> __bf_shf(_mask)) & (_val) : 0, \
>  				 _pfx "value too large for the field"); \
> -		BUILD_BUG_ON_MSG((_mask) > (typeof(_reg))~0ull,		\
> +	})
> +
> +#define __BF_FIELD_CHECK_REG(_mask, _reg, _pfx)				\
> +	({								\
> +		BUILD_BUG_ON_MSG((_mask) > (typeof(_reg))~0ULL,		\
>  				 _pfx "type of reg too small for mask"); \
> -		__BUILD_BUG_ON_NOT_POWER_OF_2((_mask) +			\
> -					      (1ULL << __bf_shf(_mask))); \
>  	})
>  
>  /**
> @@ -64,7 +72,7 @@
>   */
>  #define FIELD_MAX(_mask)						\
>  	({								\
> -		__BF_FIELD_CHECK(_mask, 0ULL, 0ULL, "FIELD_MAX: ");	\
> +		__BF_FIELD_CHECK_MASK(_mask, "FIELD_MAX: ");		\
>  		(typeof(_mask))((_mask) >> __bf_shf(_mask));		\
>  	})
>  
> @@ -77,7 +85,7 @@
>   */
>  #define FIELD_FIT(_mask, _val)						\
>  	({								\
> -		__BF_FIELD_CHECK(_mask, 0ULL, 0ULL, "FIELD_FIT: ");	\
> +		__BF_FIELD_CHECK_MASK(_mask, "FIELD_FIT: ");		\
>  		!((((typeof(_mask))_val) << __bf_shf(_mask)) & ~(_mask)); \
>  	})
>  
> @@ -91,7 +99,8 @@
>   */
>  #define FIELD_PREP(_mask, _val)						\
>  	({								\
> -		__BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");	\
> +		__BF_FIELD_CHECK_MASK(_mask, "FIELD_PREP: ");		\
> +		__BF_FIELD_CHECK_VAL(_mask, _val, "FIELD_PREP: ");	\
>  		((typeof(_mask))(_val) << __bf_shf(_mask)) & (_mask);	\
>  	})
>  
> @@ -105,7 +114,8 @@
>   */
>  #define FIELD_GET(_mask, _reg)						\
>  	({								\
> -		__BF_FIELD_CHECK(_mask, _reg, 0U, "FIELD_GET: ");	\
> +		__BF_FIELD_CHECK_MASK(_mask, "FIELD_GET: ");		\
> +		__BF_FIELD_CHECK_REG(_mask, _reg,  "FIELD_GET: ");	\
>  		(typeof(_mask))(((_reg) & (_mask)) >> __bf_shf(_mask));	\
>  	})
>  
> 

