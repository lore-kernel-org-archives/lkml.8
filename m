Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B10EC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 14:49:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 778752053B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 14:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593182984;
	bh=KReFy7bD9jthAOMnarPvGzVuindwMsXwbkgJSMssLZo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Rga+2DyvsJ8MVfAe7aaoE9LP/qka12vcfHYvEMlU+szr0bV6iwDjd43j5ErQKKA0G
	 mpBRHVxgCRl4wNoW6SBS5AB2V+3bo2q/G1Kewju3PqiDvA2hHWDkh3vdb4o4dKJRI+
	 NJ/aEaRCow41EhPhkBbW4teqcbJghLY7DryY9Pjk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbgFZOtm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 10:49:42 -0400
Received: from mail-ej1-f67.google.com ([209.85.218.67]:32952 "EHLO
        mail-ej1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbgFZOtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 10:49:41 -0400
Received: by mail-ej1-f67.google.com with SMTP id n24so9679325ejd.0;
        Fri, 26 Jun 2020 07:49:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sXNXgq00NlKTHNcOwWfxYSdR88eik0/rKaR9cxhKl6A=;
        b=lukWAH9vgHdZgEGAHpY0MsbYav2IAXU8aEYRIBG+7saQjzhuwm3h/BWn25lsMWsnfh
         enrAqDMlA2MxamAY3R1cSXOKoSaeizvHvcI85a4S9C+K4mvRxDPxUafwj/8cILKm2qP7
         SoVLeKgBdinVA5EfLKLWANfLNRw1C52LNYva6O83P8w25485jlF9o9MWDFZUZexWVyn5
         X4HwghAsso+o4JCmUW2Hydkj40N0pvmdEyxKrfuWShrubtCDFFm4sMrHundWQdo5zOWO
         FrvFAeB7CuqrgrXlLYS0AHTgCVV7/6f9Hm24B1i0elWMh3aXerh+tP0RjhLfD+aLJZ0Y
         lFiQ==
X-Gm-Message-State: AOAM530DtBTIKgA2J32qM3GBND4Yt4KJy1BEz81hiqXFMp6w8E7g4j+P
        RpjUixWIQRFDjB2jIO5aNpFHDG8I
X-Google-Smtp-Source: ABdhPJwJZYqF5Lx4BzajVu7rgPO/aoYF7E4BurVBbIjzIUDyjYjrP5rSp6ikLtIBKeMC4o53xdhUaA==
X-Received: by 2002:a17:906:8294:: with SMTP id h20mr2755432ejx.17.1593182979774;
        Fri, 26 Jun 2020 07:49:39 -0700 (PDT)
Received: from localhost (ip-37-188-168-3.eurotel.cz. [37.188.168.3])
        by smtp.gmail.com with ESMTPSA id gr15sm6130129ejb.84.2020.06.26.07.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 07:49:38 -0700 (PDT)
Date:   Fri, 26 Jun 2020 16:49:37 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH] docs/core-api: memory-allocation: describe reclaim
 behaviour
Message-ID: <20200626144937.GB1320@dhcp22.suse.cz>
References: <20200626142950.135184-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200626142950.135184-1-rppt@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 26-06-20 17:29:50, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> Changelog of commit dcda9b04713c ("mm, tree wide: replace __GFP_REPEAT by
> __GFP_RETRY_MAYFAIL with more useful semantic") has very nice description
> of GFP flags that affect reclaim behaviour of the page allocator.
> 
> It would be pity to keep this description buried in the log so let's expose
> it in the Documentation/ as well.
> 
> Cc: Michal Hocko <mhocko@suse.com>
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>

Thanks for making that into the documentation.
Acked-by: Michal Hocko <mhocko@suse.com>

> ---
> Hi,
> 
> I've been looking for something completely unrealated and found this
> really nice piece of documentation.
> 
> Thanks Michal! ;-)
> 
>  Documentation/core-api/memory-allocation.rst | 44 ++++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 
> diff --git a/Documentation/core-api/memory-allocation.rst b/Documentation/core-api/memory-allocation.rst
> index 4aa82ddd01b8..4446a1ac36cc 100644
> --- a/Documentation/core-api/memory-allocation.rst
> +++ b/Documentation/core-api/memory-allocation.rst
> @@ -84,6 +84,50 @@ driver for a device with such restrictions, avoid using these flags.
>  And even with hardware with restrictions it is preferable to use
>  `dma_alloc*` APIs.
>  
> +GFP flags and reclaim behavior
> +------------------------------
> +Memory allocations may trigger direct or background reclaim and it is
> +useful to understand how hard the page allocator will try to satisfy that
> +or another request.
> +
> +  * ``GFP_KERNEL & ~__GFP_RECLAIM`` - optimistic allocation without _any_
> +    attempt to free memory at all. The most light weight mode which even
> +    doesn't kick the background reclaim. Should be used carefully because it
> +    might deplete the memory and the next user might hit the more aggressive
> +    reclaim.
> +
> +  * ``GFP_KERNEL & ~__GFP_DIRECT_RECLAIM`` (or ``GFP_NOWAIT``)- optimistic
> +    allocation without any attempt to free memory from the current
> +    context but can wake kswapd to reclaim memory if the zone is below
> +    the low watermark. Can be used from either atomic contexts or when
> +    the request is a performance optimization and there is another
> +    fallback for a slow path.
> +
> +  * ``(GFP_KERNEL|__GFP_HIGH) & ~__GFP_DIRECT_RECLAIM`` (aka ``GFP_ATOMIC``) -
> +    non sleeping allocation with an expensive fallback so it can access
> +    some portion of memory reserves. Usually used from interrupt/bottom-half
> +    context with an expensive slow path fallback.
> +
> +  * ``GFP_KERNEL`` - both background and direct reclaim are allowed and the
> +    **default** page allocator behavior is used. That means that not costly
> +    allocation requests are basically no-fail but there is no guarantee of
> +    that behavior so failures have to be checked properly by callers
> +    (e.g. OOM killer victim is allowed to fail currently).
> +
> +  * ``GFP_KERNEL | __GFP_NORETRY`` - overrides the default allocator behavior
> +    and all allocation requests fail early rather than cause disruptive
> +    reclaim (one round of reclaim in this implementation). The OOM killer
> +    is not invoked.
> +
> +  * ``GFP_KERNEL | __GFP_RETRY_MAYFAIL`` - overrides the default allocator
> +    behavior and all allocation requests try really hard. The request
> +    will fail if the reclaim cannot make any progress. The OOM killer
> +    won't be triggered.
> +
> +  * ``GFP_KERNEL | __GFP_NOFAIL`` - overrides the default allocator behavior
> +    and all allocation requests will loop endlessly until they succeed.
> +    This might be really dangerous especially for larger orders.
> +
>  Selecting memory allocator
>  ==========================
>  
> -- 
> 2.25.4

-- 
Michal Hocko
SUSE Labs
