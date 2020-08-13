Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E84FC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 06:39:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63EAB2078B
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 06:39:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="ZDQ0Aoqv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726082AbgHMGjt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 02:39:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbgHMGjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 02:39:48 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CDBEC061757
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 23:39:47 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id v9so4954904ljk.6
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 23:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DGJizY94NWmpnKm3GAJouLUxDuyTMohNxnOXsjH4jLI=;
        b=ZDQ0Aoqv6FnTD3/bfGlR9gICLkiVY5WvKr3dWfAUck7qO+8DZ8teafppmock/Y4qT7
         DFDnilfEVDSRSYLuy+2glK+2sknNkQlhtrXXYppwzznVaC5E6zwPYNNl9AB+GXsjvIpI
         yUpzwG3XoJofGSMPE4xmHuFsCDfBH2SA9srBI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DGJizY94NWmpnKm3GAJouLUxDuyTMohNxnOXsjH4jLI=;
        b=Nhi9H2kIuLe4aD49Extz4x3usmDcagGCDSEjaHH5WbIyL1h9iCm2gJGn2P05GZl9kw
         iUXo62AzQTQJBZATI9Zw1PvQx5suq6I2tV5q5H8Y/gh8Mu1t2EY0VFhaoDnFz6wd/K8d
         RN5684FelXly4Mw4pbyHscmj6s9Fv68+gVT1mkaC1rmhKzJIoEOrzlPFA4PNaz4vA9EB
         E9Q+lA7J7xKo5xrTSGw0En/qrcUj3Ph0HCzoQVOC43Fg4VgvLm5AwkZpMexsZ+4FG9nt
         NNt21xu6Her4ut9aupMp15nwyJOxHzq+r5wmIfrR1bhQ564/uC42tnCMyNv4uro2KOj+
         k2Eg==
X-Gm-Message-State: AOAM531Rb6w9Zw4gwWHXJyAptVKk7ze4O99+ofI2dJFltX4S2uWXdT+O
        z88Xcl11SE51OkEV6x/Ed6K03Q==
X-Google-Smtp-Source: ABdhPJw6LZZ+Ms96aQHHbPrKTPxSWnVJUIZegwrkkTpmSBZCxYRwf6p+3bl6zuFL7Rpcoi3F+H4+qw==
X-Received: by 2002:a2e:8697:: with SMTP id l23mr1231973lji.190.1597300785847;
        Wed, 12 Aug 2020 23:39:45 -0700 (PDT)
Received: from [172.16.11.132] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id b17sm916732ljp.9.2020.08.12.23.39.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Aug 2020 23:39:45 -0700 (PDT)
Subject: Re: [PATCH] overflow: Add __must_check attribute to check_*() helpers
To:     Kees Cook <keescook@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com
References: <202008121450.405E4A3@keescook>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <f7b6ad2f-4b35-1ca8-0137-05b27a0eb574@rasmusvillemoes.dk>
Date:   Thu, 13 Aug 2020 08:39:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <202008121450.405E4A3@keescook>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/08/2020 23.51, Kees Cook wrote:
> Since the destination variable of the check_*_overflow() helpers will
> contain a wrapped value on failure, it would be best to make sure callers
> really did check the return result of the helper. Adjust the macros to use
> a bool-wrapping static inline that is marked with __must_check. This means
> the macros can continue to have their type-agnostic behavior while gaining
> the function attribute (that cannot be applied directly to macros).
> 
> Suggested-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  include/linux/overflow.h | 51 +++++++++++++++++++++++-----------------
>  1 file changed, 30 insertions(+), 21 deletions(-)
> 
> diff --git a/include/linux/overflow.h b/include/linux/overflow.h
> index 93fcef105061..ef7d538c2d08 100644
> --- a/include/linux/overflow.h
> +++ b/include/linux/overflow.h
> @@ -43,6 +43,16 @@
>  #define is_non_negative(a) ((a) > 0 || (a) == 0)
>  #define is_negative(a) (!(is_non_negative(a)))
>  
> +/*
> + * Allows to effectively us apply __must_check to a macro so we can have

word ordering?

> + * both the type-agnostic benefits of the macros while also being able to
> + * enforce that the return value is, in fact, checked.
> + */
> +static inline bool __must_check __must_check_bool(bool condition)
> +{
> +	return unlikely(condition);
> +}
> +
>  #ifdef COMPILER_HAS_GENERIC_BUILTIN_OVERFLOW
>  /*
>   * For simplicity and code hygiene, the fallback code below insists on
> @@ -52,32 +62,32 @@
>   * alias for __builtin_add_overflow, but add type checks similar to
>   * below.
>   */
> -#define check_add_overflow(a, b, d) ({		\
> +#define check_add_overflow(a, b, d) __must_check_bool(({	\
>  	typeof(a) __a = (a);			\
>  	typeof(b) __b = (b);			\
>  	typeof(d) __d = (d);			\
>  	(void) (&__a == &__b);			\
>  	(void) (&__a == __d);			\
>  	__builtin_add_overflow(__a, __b, __d);	\
> -})
> +}))

Sorry, I meant to send this before your cooking was done but forgot
about it again. Not a big deal, but it occurred to me it might be better
to rename the existing check_*_overflow to __check_*_overflow (in both
branches of the COMPILER_HAS_GENERIC_BUILTIN_OVERFLOW), and then

#define check_*_overflow(a, b, d)
__must_check_bool(__check_*_overflow(a, b, d))

Mostly because it gives less whitespace churn, but it might also be
handy to have the dunder versions available (if nothing else then
perhaps in some test code).

But as I said, no biggie, I'm fine either way. Now I'm just curious if
0-day is going to find some warning introduced by this :)

Rasmus
