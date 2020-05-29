Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 841FEC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 08:31:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63AFC207BC
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 08:31:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WghyQcNa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbgE2Ib7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 04:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbgE2Ib5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 04:31:57 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B270C03E969
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 01:31:57 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id d3so846541pln.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 01:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=84A0M1H4jy1ecL+D5qAu1liGD/cksWTm83SNF7xy+/U=;
        b=WghyQcNaT0+nqHX9TbJBOpZhhUuqKCs0t6Db6P3hFwLDMvvxT3kUESBC7ajW56kRKY
         CRSiMXhf6uHVw/68Q67YX1fHr5mUltzqfc3Q57fYIy+tCodGIXtAln+PKgEIARGmBP/P
         ofH4efXdeHMhL8oNbqIOYTQTX9FVJ62mu7paM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=84A0M1H4jy1ecL+D5qAu1liGD/cksWTm83SNF7xy+/U=;
        b=ZgbVnSue/MCegug9IpOto0NCLe9KP6WwwxIbbZ7su5/s1zDcGm5u+809n/EHVrxari
         rVmz5e8oj0P8fuhRdtCZ6C2OwfaZlJPp9pzUM3EiW4opQwpUOKIshx6qp8HYHG6LxifY
         oINhwxlXVeW/jg876SJvAfH7tH1f+oJVQdsd+xRk0guQsxqiGyJ0kmpe57exZoZdL28P
         hiSk2NL4rD8lF1xjL1ma9mSwigNEGQ68kOGG558u+yipp8IY0XtEZCorXOutS521iQSn
         2UvYuDMeiWRxVLJyr3+1R9XzCBZx0Vl6c9frhAR4UlPxj6r2WFDmwElbTKnq4/NyCLqS
         8GQA==
X-Gm-Message-State: AOAM532z9xo4SLlikj3GeOyhNnh+fW34MhAgo6Wpy2TDN7Y8PIOLWsRl
        xw/NrpfZQWBm3t+7kOs1LbBkJw==
X-Google-Smtp-Source: ABdhPJwEYthMkSM49YNCxr0c5BBaSDzab+YjZMTHlFo3GA6Kodaph5uWiLr/twt3lQYpnSiIFKG4Zg==
X-Received: by 2002:a17:902:fe12:: with SMTP id g18mr6066462plj.215.1590741117028;
        Fri, 29 May 2020 01:31:57 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g18sm6353691pgn.47.2020.05.29.01.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 01:31:56 -0700 (PDT)
Date:   Fri, 29 May 2020 01:31:54 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH] efi: Replace zero-length array and use struct_size()
 helper
Message-ID: <202005290131.4B104937C@keescook>
References: <20200527171425.GA4053@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200527171425.GA4053@embeddedor>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 12:14:25PM -0500, Gustavo A. R. Silva wrote:
> The current codebase makes use of the zero-length array language
> extension to the C90 standard, but the preferred mechanism to declare
> variable-length types such as these ones is a flexible array member[1][2],
> introduced in C99:
> 
> struct foo {
>         int stuff;
>         struct boo array[];
> };
> 
> By making use of the mechanism above, we will get a compiler warning
> in case the flexible array does not occur last in the structure, which
> will help us prevent some kind of undefined behavior bugs from being
> inadvertently introduced[3] to the codebase from now on.
> 
> Also, notice that, dynamic memory allocations won't be affected by
> this change:
> 
> "Flexible array members have incomplete type, and so the sizeof operator
> may not be applied. As a quirk of the original implementation of
> zero-length arrays, sizeof evaluates to zero."[1]
> 
> sizeof(flexible-array-member) triggers a warning because flexible array
> members have incomplete type[1]. There are some instances of code in
> which the sizeof operator is being incorrectly/erroneously applied to
> zero-length arrays and the result is zero. Such instances may be hiding
> some bugs. So, this work (flexible-array member conversions) will also
> help to get completely rid of those sorts of issues.
> 
> Lastly, make use of the sizeof_field() helper instead of an open-coded
> version.
> 
> This issue was found with the help of Coccinelle and audited _manually_.
> 
> [1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> [2] https://github.com/KSPP/linux/issues/21
> [3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

> ---
>  drivers/firmware/efi/efi.c | 3 ++-
>  include/linux/efi.h        | 7 ++-----
>  2 files changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> index 7f1657b6c30df..edc5d36caf54e 100644
> --- a/drivers/firmware/efi/efi.c
> +++ b/drivers/firmware/efi/efi.c
> @@ -622,7 +622,8 @@ int __init efi_config_parse_tables(const efi_config_table_t *config_tables,
>  			rsv = (void *)(p + prsv % PAGE_SIZE);
>  
>  			/* reserve the entry itself */
> -			memblock_reserve(prsv, EFI_MEMRESERVE_SIZE(rsv->size));
> +			memblock_reserve(prsv,
> +					 struct_size(rsv, entry, rsv->size));
>  
>  			for (i = 0; i < atomic_read(&rsv->count); i++) {
>  				memblock_reserve(rsv->entry[i].base,
> diff --git a/include/linux/efi.h b/include/linux/efi.h
> index c45ac969ea4eb..328cc52a5fd45 100644
> --- a/include/linux/efi.h
> +++ b/include/linux/efi.h
> @@ -1234,14 +1234,11 @@ struct linux_efi_memreserve {
>  	struct {
>  		phys_addr_t	base;
>  		phys_addr_t	size;
> -	} entry[0];
> +	} entry[];
>  };
>  
> -#define EFI_MEMRESERVE_SIZE(count) (sizeof(struct linux_efi_memreserve) + \
> -	(count) * sizeof(((struct linux_efi_memreserve *)0)->entry[0]))
> -
>  #define EFI_MEMRESERVE_COUNT(size) (((size) - sizeof(struct linux_efi_memreserve)) \
> -	/ sizeof(((struct linux_efi_memreserve *)0)->entry[0]))
> +	/ sizeof_field(struct linux_efi_memreserve, entry[0]))

Whoa. This is kind of a "reverse struct_size()". I wonder if any other
places in the kernel do a similar calculation?

-- 
Kees Cook
