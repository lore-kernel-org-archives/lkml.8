Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A786CC4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 01:59:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 762D920767
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 01:59:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DGK4ptB8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbgCSB7N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 21:59:13 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:38821 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726596AbgCSB7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 21:59:12 -0400
Received: by mail-ot1-f66.google.com with SMTP id t28so797552ott.5
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 18:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kQ+8lYTbuo7gMKlfggSjar9t6x0ZwfKKLWy/FGGXtQI=;
        b=DGK4ptB8KNnEnFHfkrNQfSNomDn3CITlj0ORrlBg2GH7d+MQZ7MSRZJfh0euCMSzOr
         3yp1RS2puOkpUXmP+f7IHLHx3kB3EJeBVc7ovaGsCqupeitEtw30nabRv/jNFk5G9PJ7
         YCLCxHS30zj5Y1VvrPFHUP0F81wrb/sFXzldChq2ENmWfQodyeVhp5uxTsKHDssCSBXP
         YG4RCLNspV4d2VintxEubm9O1YME+00WYB0EVcj+1LrW4i/U08Zu+I+Zg+xpppoYglae
         vTLP7YAty9G0xbCMzmTvaIuPrm6oMGqchwxEos3eD6o8dmL5ofab+tTjcIe8C2xe0TMN
         Rj1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kQ+8lYTbuo7gMKlfggSjar9t6x0ZwfKKLWy/FGGXtQI=;
        b=fhKYnpxI/5u4QL27Co8qrpf3KUBzguhfT38hIkUGqyoNkDyb4pRILVsTbl72DVDwvT
         kUg/MTxYn7s/aHnXgGloqPb//JJeet42G4HwJ7KMGhn23hk1Fb7MQl98vu5otFormDAo
         iN5TEHjYNcH3oK1a7kheWgEtEr2T3y43I15viAxRKfvMjrSz4rwQVcavakOVIIBNtO3E
         0UT7hR/J9j0gK+TSN5DoKzU0xUNewKZkBsrTs/dsH0LLQzyflNsGuR4X/pxJnDudO3yy
         tZL4hPTvE64RfbiPZ6gaDwsT8SJILRC1dJw0qv6LI5KpPdpaFEm4JsRSfl/IgRE82M2L
         iBEw==
X-Gm-Message-State: ANhLgQ2gPRbbqJT872Iklqym3OZ5vBUPWyIvuR3GZ18u4SDRc6T4dZor
        p9SlQbxTxwmbfBaNU501Zlg=
X-Google-Smtp-Source: ADFU+vuto8y0H0LO70EiGVuUrvWHulp1Xhd/H7x+LQ1t1HBNckuOl9gT5SZsduHFC+yy563ALykZqQ==
X-Received: by 2002:a9d:450a:: with SMTP id w10mr497928ote.114.1584583151915;
        Wed, 18 Mar 2020 18:59:11 -0700 (PDT)
Received: from ubuntu-m2-xlarge-x86 ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id f20sm303167ote.6.2020.03.18.18.59.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Mar 2020 18:59:11 -0700 (PDT)
Date:   Wed, 18 Mar 2020 18:59:09 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Jason Baron <jbaron@akamai.com>
Cc:     linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH v2] dynamic_debug: Use address-of operator on section
 symbols
Message-ID: <20200319015909.GA8292@ubuntu-m2-xlarge-x86>
References: <20200220051320.10739-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200220051320.10739-1-natechancellor@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2020 at 10:13:20PM -0700, Nathan Chancellor wrote:
> Clang warns:
> 
> ../lib/dynamic_debug.c:1034:24: warning: array comparison always
> evaluates to false [-Wtautological-compare]
>         if (__start___verbose == __stop___verbose) {
>                               ^
> 1 warning generated.
> 
> These are not true arrays, they are linker defined symbols, which are
> just addresses. Using the address of operator silences the warning and
> does not change the resulting assembly with either clang/ld.lld or
> gcc/ld (tested with diff + objdump -Dr).
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/894
> Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
> v1 -> v2: https://lore.kernel.org/lkml/20200219045423.54190-5-natechancellor@gmail.com/
> 
> * No longer a series because there is no prerequisite patch.
> * Use address-of operator instead of casting to unsigned long.
> 
>  lib/dynamic_debug.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> index aae17d9522e5..8f199f403ab5 100644
> --- a/lib/dynamic_debug.c
> +++ b/lib/dynamic_debug.c
> @@ -1031,7 +1031,7 @@ static int __init dynamic_debug_init(void)
>  	int n = 0, entries = 0, modct = 0;
>  	int verbose_bytes = 0;
>  
> -	if (__start___verbose == __stop___verbose) {
> +	if (&__start___verbose == &__stop___verbose) {
>  		pr_warn("_ddebug table is empty in a CONFIG_DYNAMIC_DEBUG build\n");
>  		return 1;
>  	}
> -- 
> 2.25.1
> 

Gentle ping for review/acceptance.

Cheers,
Nathan
