Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BEF5C3F2D1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 18:34:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E4712146E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 18:34:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KWzUi9zG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730126AbgCDSek (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 13:34:40 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39962 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725795AbgCDSek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 13:34:40 -0500
Received: by mail-pg1-f195.google.com with SMTP id t24so1389116pgj.7
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 10:34:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0gU/ydvoeF3FI4Xw1IIpa4KUATDx4gtHUDSOYCOmG0M=;
        b=KWzUi9zGawgvgRT3WYGVcOgm2MbTkdl3pN2n1WC8zTG5SM4dYhYQPJdQakjL1gafUG
         zDSGSz2bXd7ozCcEbAfrJ0x5P7VlGE4wOIsFIwBjXqcAmtmlNpr6aAHWA6tHgYADi6Xk
         omLj2Jp0VeSWP2usvRiZwB5S0st+Jd4iPcWLk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0gU/ydvoeF3FI4Xw1IIpa4KUATDx4gtHUDSOYCOmG0M=;
        b=uhSL31lKj+qD7tUtuknYO9qeObvCq3OsVyQV9Cq0NtqItzNbUbdgXGpNvAd/9457RE
         giVASuVPKoPpzt6tCPRw0UOhQqU6PcyDASEp6PGDNPKGs1q4X1tTVftCXgu9MV75/URz
         V8D/ruBNGEyiy0sU7RrRxg5LCkfhYNgQPnGUHdqx3bkVDKnGSIFuxezs62nguZXPPCUk
         d0jnHQYt3uJh2ki948CEpa4xj0jQ+8dYhS63+Wh+zRClv3N4JU46KcRgEv5kBh/vP5Ch
         /s0qWjHynspNoy4TZyS/m0SfZ5H+53jhOYgdGy+GtCL/mpc/EMJ+2KClYHbTtwi/xJPX
         aLwg==
X-Gm-Message-State: ANhLgQ3kiMbqkY75ryw0rdI6bXwirVLlfSFNfONFsu46+W22ObT4wbG0
        bnVfUpwBAGrvkY9tFKEQx/wGdw==
X-Google-Smtp-Source: ADFU+vv27iSAb+4oCoK+xIGaMZcuVgt4tBM7DzSSZNsajzkGnFKC9x+DO1KUY+bUOAPt9ojivLNa7A==
X-Received: by 2002:a62:ae17:: with SMTP id q23mr3855198pff.239.1583346877981;
        Wed, 04 Mar 2020 10:34:37 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b21sm30443381pfp.0.2020.03.04.10.34.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 10:34:36 -0800 (PST)
Date:   Wed, 4 Mar 2020 10:34:35 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Jason Yan <yanaijie@huawei.com>
Cc:     pmladek@suse.com, rostedt@goodmis.org,
        sergey.senozhatsky@gmail.com, andriy.shevchenko@linux.intel.com,
        linux@rasmusvillemoes.dk, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>,
        "Tobin C . Harding" <tobin@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Axtens <dja@axtens.net>
Subject: Re: [PATCH] vfsprintf: only hash addresses in security environment
Message-ID: <202003041022.26AF0178@keescook>
References: <20200304124707.22650-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200304124707.22650-1-yanaijie@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 04, 2020 at 08:47:07PM +0800, Jason Yan wrote:
> When I am implementing KASLR for powerpc, Scott Wood argued that format
> specifier "%p" always hashes the addresses that people do not have a
> choice to shut it down: https://patchwork.kernel.org/cover/11367547/
> 
> It's true that if in a debug environment or security is not concerned,
> such as KASLR is absent or kptr_restrict = 0,  there is no way to shut
> the hashing down except changing the code and build the kernel again
> to use a different format specifier like "%px". And when we want to
> turn to security environment, the format specifier has to be changed
> back and rebuild the kernel.
> 
> As KASLR is available on most popular platforms and enabled by default,
> print the raw value of address while KASLR is absent and kptr_restrict
> is zero. Those who concerns about security must have KASLR enabled or
> kptr_restrict set properly.

Sorry, but no: %p censoring is there to stem the flood of endless pointer
leaks into logs, sysfs, proc, etc. These are used for attacks to build
reliable kernel memory targets, regardless of KASLR. (KASLR can be
bypassed with all kinds of sampling methods, side-channels, etc.)

Linus has rejected past suggestions to provide a flag for it[1],
wanting %p to stay unconditionally censored.

-Kees

[1] https://lore.kernel.org/lkml/CA+55aFwieC1-nAs+NFq9RTwaR8ef9hWa4MjNBWL41F-8wM49eA@mail.gmail.com/

> 
> Cc: Scott Wood <oss@buserror.net>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: "Tobin C . Harding" <tobin@kernel.org>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Daniel Axtens <dja@axtens.net>
> Signed-off-by: Jason Yan <yanaijie@huawei.com>
> ---
>  lib/vsprintf.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> index 7c488a1ce318..f74131b152a1 100644
> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
> @@ -2253,8 +2253,15 @@ char *pointer(const char *fmt, char *buf, char *end, void *ptr,
>  		return err_ptr(buf, end, ptr, spec);
>  	}
>  
> -	/* default is to _not_ leak addresses, hash before printing */
> -	return ptr_to_id(buf, end, ptr, spec);
> +	/*
> +	 * In security environment, while kaslr is enabled or kptr_restrict is
> +	 * not zero, hash before printing so that addresses will not be
> +	 * leaked. And if not in a security environment, print the raw value
> +	 */
> +	if (IS_ENABLED(CONFIG_RANDOMIZE_BASE) || kptr_restrict)
> +		return ptr_to_id(buf, end, ptr, spec);
> +	else
> +		return pointer_string(buf, end, ptr, spec);
>  }
>  
>  /*
> -- 
> 2.17.2
> 

-- 
Kees Cook
