Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 323CBC47254
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 21:58:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06AE62166E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 21:58:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fJBQzmqE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbgEAV6l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 17:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbgEAV6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 17:58:40 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A630C061A0C
        for <linux-kernel@vger.kernel.org>; Fri,  1 May 2020 14:58:40 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id l25so2789811pgc.5
        for <linux-kernel@vger.kernel.org>; Fri, 01 May 2020 14:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nXJ3m4MMM/OsUK7PNE8I0lsI/APtCvjRVtGqz9bLeZM=;
        b=fJBQzmqEj5827OycN37PamnFbjSvAf3MBUGhyRbef2wiNVtUmhhmRm8FBOyfPY5WeH
         seDwI7gpfm7CV7l+V7ap44c48TV07lg9+xb9q0JMfQrRaJvFhkTFgpcZ0QcUSJ9ZIrj5
         mYBXXmpcUx8AW9ZeWmLdIYt/yqH0D4nqef9PE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nXJ3m4MMM/OsUK7PNE8I0lsI/APtCvjRVtGqz9bLeZM=;
        b=S/9AvP0bBXUw86I1NRqXoMvNj2YluX5ZBesD41IJWJ88sCuxq8xtPGhRlVEkdmAnC/
         SR0/ZQxW/J822BlnrpiofHWcp6ImDYWtKJPY4Pgy6dqkyuBTQi9lqnfoP9omN0DdF2M9
         dlSazJDUXq1KQ2pB7s8Uz9ppEr7I4JLSFdsxJtMlI/nPAAjuCd+YYdJFCw7JUzb99Cyy
         QVBlmrbf3oHqLyVYAxz7UUP+GkGRPkb4FG/zGs/qdjqBN7rWmi/iBua0B0RsHvOiDkQA
         leYx3LvodLnCAGQauHfuGB7+ZBlOEbYHoxJf0cnARuKTh7IoJYucqBGDHwsKuIdtD6qa
         bcmA==
X-Gm-Message-State: AGi0PuabLXSb7LOxPNbq+bV+K8uwSE9Z2/BVjda4BfTo24I7IeKYpna9
        RQIgi4F3VDJCDI9qWFC31Mc/YA==
X-Google-Smtp-Source: APiQypJGedgd6pVFIRuvnFWyfjQs8vgrkj6AxquXSdPSapU4qNonv6Rye6vo2WxN0wiJBwlqJYY0QQ==
X-Received: by 2002:a63:3c4b:: with SMTP id i11mr6010161pgn.179.1588370319386;
        Fri, 01 May 2020 14:58:39 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 1sm3018400pff.151.2020.05.01.14.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2020 14:58:38 -0700 (PDT)
Date:   Fri, 1 May 2020 14:58:37 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Julien Grall <julien.grall@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ubsan: fix gcc-10 warnings
Message-ID: <202005011458.039084F70C@keescook>
References: <20200429185948.4189600-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200429185948.4189600-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 29, 2020 at 08:59:35PM +0200, Arnd Bergmann wrote:
> The latest compiler expects slightly different function prototypes
> for the ubsan helpers:
> 
> lib/ubsan.c:192:6: error: conflicting types for built-in function '__ubsan_handle_add_overflow'; expected 'void(void *, void *, void *)' [-Werror=builtin-declaration-mismatch]
>   192 | void __ubsan_handle_add_overflow(struct overflow_data *data,
>       |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> lib/ubsan.c:200:6: error: conflicting types for built-in function '__ubsan_handle_sub_overflow'; expected 'void(void *, void *, void *)' [-Werror=builtin-declaration-mismatch]
>   200 | void __ubsan_handle_sub_overflow(struct overflow_data *data,
>       |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> lib/ubsan.c:207:6: error: conflicting types for built-in function '__ubsan_handle_mul_overflow'; expected 'void(void *, void *, void *)' [-Werror=builtin-declaration-mismatch]
>   207 | void __ubsan_handle_mul_overflow(struct overflow_data *data,
>       |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> lib/ubsan.c:214:6: error: conflicting types for built-in function '__ubsan_handle_negate_overflow'; expected 'void(void *, void *)' [-Werror=builtin-declaration-mismatch]
>   214 | void __ubsan_handle_negate_overflow(struct overflow_data *data,
>       |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> lib/ubsan.c:234:6: error: conflicting types for built-in function '__ubsan_handle_divrem_overflow'; expected 'void(void *, void *, void *)' [-Werror=builtin-declaration-mismatch]
>   234 | void __ubsan_handle_divrem_overflow(struct overflow_data *data,
>       |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Change the Linux implementation to match these, using a local
> typed pointer.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks for that!

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  lib/ubsan.c | 33 +++++++++++++++++----------------
>  1 file changed, 17 insertions(+), 16 deletions(-)
> 
> diff --git a/lib/ubsan.c b/lib/ubsan.c
> index f8c0ccf35f29..cb9af3f6b77e 100644
> --- a/lib/ubsan.c
> +++ b/lib/ubsan.c
> @@ -189,7 +189,7 @@ static void handle_overflow(struct overflow_data *data, void *lhs,
>  	ubsan_epilogue();
>  }
>  
> -void __ubsan_handle_add_overflow(struct overflow_data *data,
> +void __ubsan_handle_add_overflow(void *data,
>  				void *lhs, void *rhs)
>  {
>  
> @@ -197,23 +197,23 @@ void __ubsan_handle_add_overflow(struct overflow_data *data,
>  }
>  EXPORT_SYMBOL(__ubsan_handle_add_overflow);
>  
> -void __ubsan_handle_sub_overflow(struct overflow_data *data,
> +void __ubsan_handle_sub_overflow(void *data,
>  				void *lhs, void *rhs)
>  {
>  	handle_overflow(data, lhs, rhs, '-');
>  }
>  EXPORT_SYMBOL(__ubsan_handle_sub_overflow);
>  
> -void __ubsan_handle_mul_overflow(struct overflow_data *data,
> +void __ubsan_handle_mul_overflow(void *data,
>  				void *lhs, void *rhs)
>  {
>  	handle_overflow(data, lhs, rhs, '*');
>  }
>  EXPORT_SYMBOL(__ubsan_handle_mul_overflow);
>  
> -void __ubsan_handle_negate_overflow(struct overflow_data *data,
> -				void *old_val)
> +void __ubsan_handle_negate_overflow(void *_data, void *old_val)
>  {
> +	struct overflow_data *data = _data;
>  	char old_val_str[VALUE_LENGTH];
>  
>  	if (suppress_report(&data->location))
> @@ -231,9 +231,9 @@ void __ubsan_handle_negate_overflow(struct overflow_data *data,
>  EXPORT_SYMBOL(__ubsan_handle_negate_overflow);
>  
>  
> -void __ubsan_handle_divrem_overflow(struct overflow_data *data,
> -				void *lhs, void *rhs)
> +void __ubsan_handle_divrem_overflow(void *_data, void *lhs, void *rhs)
>  {
> +	struct overflow_data *data = _data;
>  	char rhs_val_str[VALUE_LENGTH];
>  
>  	if (suppress_report(&data->location))
> @@ -326,10 +326,9 @@ void __ubsan_handle_type_mismatch(struct type_mismatch_data *data,
>  }
>  EXPORT_SYMBOL(__ubsan_handle_type_mismatch);
>  
> -void __ubsan_handle_type_mismatch_v1(struct type_mismatch_data_v1 *data,
> -				void *ptr)
> +void __ubsan_handle_type_mismatch_v1(void *_data, void *ptr)
>  {
> -
> +	struct type_mismatch_data_v1 *data = _data;
>  	struct type_mismatch_data_common common_data = {
>  		.location = &data->location,
>  		.type = data->type,
> @@ -341,8 +340,9 @@ void __ubsan_handle_type_mismatch_v1(struct type_mismatch_data_v1 *data,
>  }
>  EXPORT_SYMBOL(__ubsan_handle_type_mismatch_v1);
>  
> -void __ubsan_handle_out_of_bounds(struct out_of_bounds_data *data, void *index)
> +void __ubsan_handle_out_of_bounds(void *_data, void *index)
>  {
> +	struct out_of_bounds_data *data = _data;
>  	char index_str[VALUE_LENGTH];
>  
>  	if (suppress_report(&data->location))
> @@ -357,9 +357,9 @@ void __ubsan_handle_out_of_bounds(struct out_of_bounds_data *data, void *index)
>  }
>  EXPORT_SYMBOL(__ubsan_handle_out_of_bounds);
>  
> -void __ubsan_handle_shift_out_of_bounds(struct shift_out_of_bounds_data *data,
> -					void *lhs, void *rhs)
> +void __ubsan_handle_shift_out_of_bounds(void *_data, void *lhs, void *rhs)
>  {
> +	struct shift_out_of_bounds_data *data = _data;
>  	struct type_descriptor *rhs_type = data->rhs_type;
>  	struct type_descriptor *lhs_type = data->lhs_type;
>  	char rhs_str[VALUE_LENGTH];
> @@ -399,8 +399,9 @@ void __ubsan_handle_shift_out_of_bounds(struct shift_out_of_bounds_data *data,
>  EXPORT_SYMBOL(__ubsan_handle_shift_out_of_bounds);
>  
>  
> -void __ubsan_handle_builtin_unreachable(struct unreachable_data *data)
> +void __ubsan_handle_builtin_unreachable(void *_data)
>  {
> +	struct unreachable_data *data = _data;
>  	ubsan_prologue(&data->location, "unreachable");
>  	pr_err("calling __builtin_unreachable()\n");
>  	ubsan_epilogue();
> @@ -408,9 +409,9 @@ void __ubsan_handle_builtin_unreachable(struct unreachable_data *data)
>  }
>  EXPORT_SYMBOL(__ubsan_handle_builtin_unreachable);
>  
> -void __ubsan_handle_load_invalid_value(struct invalid_value_data *data,
> -				void *val)
> +void __ubsan_handle_load_invalid_value(void *_data, void *val)
>  {
> +	struct invalid_value_data *data = _data;
>  	char val_str[VALUE_LENGTH];
>  
>  	if (suppress_report(&data->location))
> -- 
> 2.26.0
> 

-- 
Kees Cook
