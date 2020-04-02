Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4194C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 07:09:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4D3520784
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 07:09:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BRsvNZdm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728585AbgDBHJA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 03:09:00 -0400
Received: from mail-pg1-f182.google.com ([209.85.215.182]:40508 "EHLO
        mail-pg1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbgDBHJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 03:09:00 -0400
Received: by mail-pg1-f182.google.com with SMTP id t24so1427609pgj.7
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 00:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XYgwcvQtj04cMThvyGVJPvXOVvdU39SYnDgmkM5OLVw=;
        b=BRsvNZdmd3lkKdk95io3bNQlk3BP3PP4C0bWg47HHMPxAMXZePbJnAoc9S3Y9G6+BY
         Imq4TvBMLnJuZig63sUKJtyj8qXbRj5DOexpDI9qCS872P3aTm1Z9zAYTl1RI47WzYW3
         hHcN6OXxXcMN7fC2qlotg1/9xWefEEerdIQ/k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XYgwcvQtj04cMThvyGVJPvXOVvdU39SYnDgmkM5OLVw=;
        b=qFkE8dkKzEoXV+2ilsWx2FmNR3fEa4MJZD+cPKBVuTckPBsdqHijqsOq6PgJ7gNDve
         +QVkXImnguxirlHiLOf4wuNNgeV6v/3NnRYVS1Qly/zCiJPSADHxg2iy5+awjpxuGMGE
         SMhYCOTxgmhnLCQ/+jJ/k0qUyBJSiULdpntnYN2R0sV/392/0zZ/xPU0m5fDgIQOTPJL
         kodZCyPBBY83E/DnR8Pe05TWRvGRh8aWnEjmAurdYJbjSkf/qdZ1iof/zqLYvEp87v5r
         RUOZiFQYb1vTzL4TJXgpCVj5qBG5/8tN5weTqeZIMhm0bar+Pmt2i52j98QnmdX45LGg
         1zMg==
X-Gm-Message-State: AGi0PublYSEQLNKkrEhp7OQDrz1/BgzVWwRszDnDtPmu1LAekj6P4487
        bJIHho+He9N9QdrdyNcCguuWfA==
X-Google-Smtp-Source: APiQypJ3nvFayKkzS2Xv9F9+f5EsPkXkDSqcA7QN/1N+7zAOGbeh+aE0A3FY9RP9xpyA15mHGST/0w==
X-Received: by 2002:a63:e511:: with SMTP id r17mr2054192pgh.352.1585811338960;
        Thu, 02 Apr 2020 00:08:58 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x27sm3058205pfj.74.2020.04.02.00.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2020 00:08:58 -0700 (PDT)
Date:   Thu, 2 Apr 2020 00:08:56 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] lkdtm: bugs: Fix spelling mistake
Message-ID: <202004020008.C3403E1@keescook>
References: <20200401182855.GA16253@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200401182855.GA16253@embeddedor>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 01, 2020 at 01:28:55PM -0500, Gustavo A. R. Silva wrote:
> Fix spelling mistake s/Intentially/Intentionally
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Thanks! Greg, can you snag this when you get a chance?

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  drivers/misc/lkdtm/bugs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/lkdtm/bugs.c b/drivers/misc/lkdtm/bugs.c
> index 886459e0ddd9..736675f0a246 100644
> --- a/drivers/misc/lkdtm/bugs.c
> +++ b/drivers/misc/lkdtm/bugs.c
> @@ -208,7 +208,7 @@ void lkdtm_OVERFLOW_UNSIGNED(void)
>  	ignored = value;
>  }
>  
> -/* Intentially using old-style flex array definition of 1 byte. */
> +/* Intentionally using old-style flex array definition of 1 byte. */
>  struct array_bounds_flex_array {
>  	int one;
>  	int two;
> -- 
> 2.26.0
> 

-- 
Kees Cook
