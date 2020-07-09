Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69357C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 02:11:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F2A5206F6
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 02:11:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yq5oLu8A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbgGICLG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 22:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbgGICLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 22:11:05 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7E75C08C5C1
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 19:11:05 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id k23so683273iom.10
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 19:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XQKwdZHWoHY2rSxRNRjfiy4s8SsL+NaMfgyEBt9FVMQ=;
        b=yq5oLu8Ao5cM+9i/QwjMwwbHAJ7qi9TlcWwXcNu9Pm4ERI9yjeGThHirHyl4q1xSwD
         ZdJCFe7f5u3WPuTjh7p3Q4XQf+t+ot3C03XJUzTfjJLOK4iQ9TmqQb4Y5r5Z7p5pPH13
         RmSNPkLWPpOEWkR2ORv0bF/1KRmcq55WUJLrNRC5Qp8VeTkclHI4F6c5FHJms5D46vW/
         RRWBnfALX+2RkMIbU+aPky8VYmyoJjyCV/BfB8KhRJ6j3a6wKbm3ge1dq2hRxNF9PfYm
         PDWeUks+oBW88zxWIwmFghKnJhCCshPEOeMZtgu18Qp04rt41Obuvpzrly+e2VYRkxqL
         FXaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XQKwdZHWoHY2rSxRNRjfiy4s8SsL+NaMfgyEBt9FVMQ=;
        b=QTrigZeWe5aMDknnqAGDVcUQuZMCQ6ok1+OAN81rwmEwyv9yqeydOzwRRzCy6JtHKO
         82bWwfS4vMx+KZ2mxxE3PgqKy+Vjrwq0SlQGe4jiUH4z1F0y1cyjsZtwJ6GMfe+7tabn
         7xOnovQj74vSNxxW+rZey29FfG/h+UIKNaH21Ai44IAPrypwJt7OLnHzScm1isZBpRc7
         uF0lmJQFKBAJDsuXUk/cid9F+bNonLp3cpUdWxypRXxMaevRuIQnY3Vdn7gsrmKb+GgE
         TsD7WzAZ4onadcHUW/hlHwN1eoS18j0uthDzjyGiVw3bCny8bsLHvuqWnow4QbeJod5D
         n2Uw==
X-Gm-Message-State: AOAM5336nCGC04P8++SNUy+RvTIFrdAAleuIXv3yhSoATfjdE5BcE5it
        bo03itqQBxVnui7Adk+SmayRfA==
X-Google-Smtp-Source: ABdhPJzUaribanHeB7RYNCUqwFUZGpNAJBtINhYQYo1QOCVuZMwyjasupVK3U0gH8W850q5lF8+gcg==
X-Received: by 2002:a02:cca8:: with SMTP id t8mr69432488jap.31.1594260665112;
        Wed, 08 Jul 2020 19:11:05 -0700 (PDT)
Received: from [172.22.22.26] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id a5sm1080977ilt.71.2020.07.08.19.11.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2020 19:11:04 -0700 (PDT)
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
Message-ID: <265aac2c-85a9-7e80-5f51-43556c37d3d0@linaro.org>
Date:   Wed, 8 Jul 2020 21:11:03 -0500
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

