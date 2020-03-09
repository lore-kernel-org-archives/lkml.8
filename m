Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 313F1C10F25
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 21:46:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08EA224649
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 21:46:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gRvj0NRM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbgCIVq6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 17:46:58 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42926 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbgCIVq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 17:46:57 -0400
Received: by mail-pg1-f194.google.com with SMTP id h8so5315352pgs.9
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 14:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aK0b3s9O+q+fcz6y0aBgSyJD8LLmxkLGUIQTTCdGXtc=;
        b=gRvj0NRMPhKrp2Gc0dBU+uUOJMZL7fyba9kKQA6pDLzhyIoQkOOaCPEj0EgF2LsIUl
         +IjCgYM6dqpLXmCDMsxrcW85UArKpWTvf62ZbHNsY3JHfDEhl44DRUA7F3vJzs9u3btq
         QzCExt7t1AadKp/6NQKmsrvu9IFWk6727RLQE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aK0b3s9O+q+fcz6y0aBgSyJD8LLmxkLGUIQTTCdGXtc=;
        b=qYpAv4OaoH/otxXVEmNjYIMw5IzrKy1e+qSXHa9KcPn9NKdn53SPRMyLQxDO3tO7sS
         EJLmLLJRrw/0TxcjC/P7Dy9n+kqm29Zrtw0EXkx6C3nER4FmY+880MPZWrB3F4zOYUnF
         hvLN5CrNO6flfJBooRhvvioZHMGmVUrKd6yePFYDvi7PlAg/rF21Sexc3RlPZg6KoFqE
         sSHLpOlFCDyddCij3smXF+3ZVXrTpA2gb1msYuvUmYrXpiMeMyF3wcau8khD2Z2VyW4C
         FKCAHb7KkkoRC2HswQjCsQgFlAI5ye8RbJSST7NOuhbwHbzqd1L1Q76eluAxOXFKXhZO
         RLmg==
X-Gm-Message-State: ANhLgQ3SGUuIRtbSxpjFUraNMt1ydZXR6+vyF9jz1UGPGZcs22YYG9GU
        Uh/ySfT+cPZE1HQo6bzIIiSD9dECgvA=
X-Google-Smtp-Source: ADFU+vui2PI+tPodi/gDbzk8X20qrEXcMZQPJQIwcrACiLNCMDWQhdCq0KjUZHMyl/l+jXRhgPt+fA==
X-Received: by 2002:a63:5546:: with SMTP id f6mr18423923pgm.260.1583790416271;
        Mon, 09 Mar 2020 14:46:56 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 9sm41081010pge.65.2020.03.09.14.46.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 14:46:55 -0700 (PDT)
Date:   Mon, 9 Mar 2020 14:46:54 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] pstore: ram_core: Replace zero-length array with
 flexible-array member
Message-ID: <202003091446.6B5E42EF@keescook>
References: <20200309202327.GA8813@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200309202327.GA8813@embeddedor>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 09, 2020 at 03:23:27PM -0500, Gustavo A. R. Silva wrote:
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
> This issue was found with the help of Coccinelle.
> 
> [1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> [2] https://github.com/KSPP/linux/issues/21
> [3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Thanks! Applied to for-next/pstore.

-Kees

> ---
>  fs/pstore/ram_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/pstore/ram_core.c b/fs/pstore/ram_core.c
> index 1f4d8c06f9be..c917c191e78c 100644
> --- a/fs/pstore/ram_core.c
> +++ b/fs/pstore/ram_core.c
> @@ -34,7 +34,7 @@ struct persistent_ram_buffer {
>  	uint32_t    sig;
>  	atomic_t    start;
>  	atomic_t    size;
> -	uint8_t     data[0];
> +	uint8_t     data[];
>  };
>  
>  #define PERSISTENT_RAM_SIG (0x43474244) /* DBGC */
> -- 
> 2.25.0
> 

-- 
Kees Cook
