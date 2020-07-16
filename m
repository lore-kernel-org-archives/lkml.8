Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D8D9C433F2
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 02:34:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79B1C207BC
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 02:34:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iBaOVvOB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728053AbgGPCeT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 22:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727939AbgGPCeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 22:34:08 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FB47C061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 19:34:08 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id q17so2976299pfu.8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 19:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OBHFrLP+zznPw6dlb+xXG2h+uzB263gsWgoLrOM5A/U=;
        b=iBaOVvOBp/8cpWJBRzkHXXsvpirEoq1CjGUnb1KIpi1G+rcRPDkFLIFlGBCVL54pKM
         s7xII+/8u3NGU8VPmuhB1E288OtTD10FzrwznllqHJ7H13zf+muLeTiFCh3hmbfAJ7bU
         rkAfVlG5pbOycj9rqP2MwkqPEtLXoqGt4BkMQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OBHFrLP+zznPw6dlb+xXG2h+uzB263gsWgoLrOM5A/U=;
        b=QJjhDdhP4oBUruAParVLlhTC4aEwIOjHs6Mop8lTTkke0A4H9/fNZMVGwJ+XS3GsVI
         rXtRtLNTrbTH1ZYLfquiXNzaYqNuscDrADWJk8rNIM0Re+iG+Q3FthI6oFgOG2fRcou+
         z0ujA11M3tOuLOw75gsn/8TMrod3Gp3OioskabH5RpQAj0MMki0Hk06UQKWU+OUKe9Gl
         JI+mr8QR1Hky822mJHGNKtVcFE31XubXDvZFTWgSj4S1cQ3OhoVqAbvq01wGv5MnDxiJ
         gm/ughIvrKHmtNnOjYZKVNVYe4ggzVw3LbT/PiqbuetK1Cs32heDe6/oK7JHtsrjU9WO
         T2zw==
X-Gm-Message-State: AOAM5328Il3lmcoUyUiYWATeod3eTy3Q83jrVEDyNPIBcGAicfaLjYaL
        G2M41ruwKNvboHAYWEsEsi4Ntg==
X-Google-Smtp-Source: ABdhPJwT2W5XcXGiXUbSxWDU3H1XbGT7OIjiB+N9Wb/ir/tyFHQzD+xKtJnodqbNxpjPU8gbPlwKtA==
X-Received: by 2002:aa7:8597:: with SMTP id w23mr1732977pfn.219.1594866848006;
        Wed, 15 Jul 2020 19:34:08 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c139sm3047867pfb.65.2020.07.15.19.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 19:34:07 -0700 (PDT)
Date:   Wed, 15 Jul 2020 19:34:06 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Vitor Massaru Iha <vitor@massaru.org>
Cc:     kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, brendanhiggins@google.com,
        davidgow@google.com, skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [RFC 3/3] lib: Convert test_user_copy to KUnit test
Message-ID: <202007151929.7A4E04E@keescook>
References: <20200715031120.1002016-1-vitor@massaru.org>
 <20200715031120.1002016-4-vitor@massaru.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200715031120.1002016-4-vitor@massaru.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 15, 2020 at 12:11:20AM -0300, Vitor Massaru Iha wrote:
> This adds the conversion of the runtime tests of test_user_copy fuctions,
> from `lib/test_user_copy.c`to KUnit tests.
> 
> Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>
> [...]
> @@ -16,6 +16,7 @@
>  #include <linux/slab.h>
>  #include <linux/uaccess.h>
>  #include <linux/vmalloc.h>
> +#include <kunit/test.h>
>  
>  /*
>   * Several 32-bit architectures support 64-bit {get,put}_user() calls.
> @@ -31,26 +32,16 @@
>  # define TEST_U64
>  #endif
>  
> -#define test(condition, msg, ...)					\
> -({									\
> -	int cond = (condition);						\
> -	if (cond)							\
> -		pr_warn("[%d] " msg "\n", __LINE__, ##__VA_ARGS__);	\
> -	cond;								\
> -})
> -
>  static bool is_zeroed(void *from, size_t size)
>  {
>  	return memchr_inv(from, 0x0, size) == NULL;
>  }
>  
> -static int test_check_nonzero_user(char *kmem, char __user *umem, size_t size)
> +static void test_check_nonzero_user(struct kunit *test, char *kmem, char __user *umem, size_t size)
>  {
> -	int ret = 0;
>  	size_t start, end, i, zero_start, zero_end;
>  
> -	if (test(size < 2 * PAGE_SIZE, "buffer too small"))
> -		return -EINVAL;
> +	KUNIT_EXPECT_FALSE_MSG(test, size < 2 * PAGE_SIZE, "buffer too small");

I think this could be a much smaller diff if you just replaced the
"test" macro:

#define test(condition, msg, ...)					\
({									\
	int cond = !!(condition);					\
	KUNIT_EXPECT_FALSE_MSG(kunit_context, cond, msg, ##__VA_ARGS__);\
	cond;								\
})

-- 
Kees Cook
