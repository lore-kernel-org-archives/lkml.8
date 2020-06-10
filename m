Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E5C5C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 21:39:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2489D2081A
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 21:39:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Rbr0h1Se"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbgFJVjC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 17:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbgFJVjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 17:39:02 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E3BCC03E96B
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 14:39:02 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id m2so1457575pjv.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 14:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UaaxvVuEHQrVAu/jxhStnl/lvg3EdN7pxE+mrpm0qVk=;
        b=Rbr0h1SeiTN78KosHmSXDvYzqg/XXy+aQQm0nN5G4DhZUxzr2O7np6CMT74RLK6rE4
         xOgl0Bw+fBBXdzF8A0X7/lSe9JqtnEyjA2gGNkJw2subjeJwi4V1Z9Yk4DRES5NWOxrP
         +zlW3XZSyaxcdFH2drOG6MnNsTdLQGkWkPj9I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UaaxvVuEHQrVAu/jxhStnl/lvg3EdN7pxE+mrpm0qVk=;
        b=cHxooJTcLCx3xntvSw6H0ef21/a/G20BN+AG1tj6k8ehLBCV/qDpkRQrmUhpJCSi1U
         FJjs9WJpmVYdC5KP0gEVZXRMc/NNiWAoclt2z1dugcrAeXrB6gO9WWuffLj0lMgAzXYk
         CoCc4DeWjHtJOxdzKwvQ/KUq8kojwxrY7NXU7Q/nKra1gB8NbQbvmTfQ9jbGZHKB5Moq
         q1N0JC/bo6IWoTfYhulIO8NvgODJvN8KdiKxfRYh+8Je342M3vncxGpqkGRmgyyzUJVc
         hW55oBcXLydycDlNTOHbWh9EjTBVIRsK2NdqmgfTWlj8V7QtcBRFlhNnDaf36q2WsdMK
         9XBg==
X-Gm-Message-State: AOAM5306zumCU9hL/v0643aSs6hXGgDHOAcDWVf7O6URdrFL3YWWdHvL
        YvV2bZPfV5b/02k3MGwTafVTuw==
X-Google-Smtp-Source: ABdhPJyaJj6JdEG4QEQHKRCbpTCuGNNQl8NZIXwiu7rbWQnmNV/s+taf/gvlb4fkZK7lWoA7UZz9eg==
X-Received: by 2002:a17:90b:3d1:: with SMTP id go17mr4802563pjb.114.1591825141557;
        Wed, 10 Jun 2020 14:39:01 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h12sm670889pgj.71.2020.06.10.14.39.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 14:39:00 -0700 (PDT)
Date:   Wed, 10 Jun 2020 14:38:59 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH v2] overflow.h: Add flex_array_size() helper
Message-ID: <202006101427.68A436C@keescook>
References: <20200609012233.GA3371@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200609012233.GA3371@embeddedor>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 08, 2020 at 08:22:33PM -0500, Gustavo A. R. Silva wrote:
> Add flex_array_size() helper for the calculation of the size, in bytes,
> of a flexible array member contained within an enclosing structure.
> 
> Example of usage:
> 
> struct something {
> 	size_t count;
> 	struct foo items[];
> };
> 
> struct something *instance;
> 
> instance = kmalloc(struct_size(instance, items, count), GFP_KERNEL);
> instance->count = count;
> 
> memcpy(instance->items, source, flex_array_size(instance, items, instance->count));
> 
> The helper returns SIZE_MAX on overflow instead of wrapping around.
> 
> (Additionally replace parameter n with count in struct_size() for
> unification).
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
> Changes in v2:
>  - Add further information to the helper documentation.
>  - Use same code style as struct_size() for consistency.
> 
>  include/linux/overflow.h | 25 +++++++++++++++++++++----
>  1 file changed, 21 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/overflow.h b/include/linux/overflow.h
> index 659045046468f..d2329a914304c 100644
> --- a/include/linux/overflow.h
> +++ b/include/linux/overflow.h
> @@ -304,16 +304,33 @@ static inline __must_check size_t __ab_c_size(size_t a, size_t b, size_t c)
>   * struct_size() - Calculate size of structure with trailing array.
>   * @p: Pointer to the structure.
>   * @member: Name of the array member.
> - * @n: Number of elements in the array.
> + * @count: Number of elements in the array.
>   *
>   * Calculates size of memory needed for structure @p followed by an
> - * array of @n @member elements.
> + * array of @count @member elements.
>   *
>   * Return: number of bytes needed or SIZE_MAX on overflow.
>   */
> -#define struct_size(p, member, n)					\
> -	__ab_c_size(n,							\
> +#define struct_size(p, member, count)					\
> +	__ab_c_size(count,							\
>  		    sizeof(*(p)->member) + __must_be_array((p)->member),\
>  		    sizeof(*(p)))

I like the "count" change -- "n" can be seen as either count or bytes,
so I like this being distinctly "count".

>  
> +/**
> + * flex_array_size() - Calculate size, in bytes, of a flexible array member
> + * within an enclosing structure. Read on for more details.
> + *
> + * @p: Pointer to the structure.
> + * @member: Name of the flexible array member.
> + * @count: Number of elements in the array.
> + *
> + * Calculates size, in bytes, of a flexible array @member of @count elements
> + * within structure @p.
> + *
> + * Return: number of bytes needed or SIZE_MAX on overflow.
> + */
> +#define flex_array_size(p, member, count)					\
> +	array_size(count,							\
> +		    sizeof(*(p)->member) + __must_be_array((p)->member))
> +
>  #endif /* __LINUX_OVERFLOW_H */

I like it! You mentioned off-list that maybe this could be named
sizeof_flex_array() (like sizeof_field(), etc), and that does seem
attractive. As you also mentioned, it begs the question of renaming
struct_size() to sizeof_struct().

Looking back through the thread[1], it seems the name came from Linus[2],
and was more related to the existing array_size() helper.

So, how about this, as a convention we can use to make a choice:

For things that are strictly constant in size, we can use sizeof_*. For
things that have a dynamic component, we'll use *_size(). So, this patch
is correct as-is.

Acked-by: Kees Cook <keescook@chromium.org>

(I wonder who's tree this should go via?)

-Kees

[1] https://lore.kernel.org/lkml/20180507113902.GC18116@bombadil.infradead.org/
[2] https://lore.kernel.org/lkml/CA+55aFy8DSRoUvtiuu5w+XGOK6tYvtJGBH-i8i-y7aiUD2EGLA@mail.gmail.com/

-- 
Kees Cook
