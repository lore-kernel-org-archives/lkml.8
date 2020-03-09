Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D91D5C18E5A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 11:58:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2939205ED
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 11:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583755102;
	bh=i5juxwhE187oLeD3dJo6g7F9UT/uxMxIR+fl6tlLNh8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MSg9W+EmMy08Q0blBz33AU+8vOx0opLCIB/nDLA6OeNVMr7Sn29/EcGMAgGQ0B6SX
	 aMFNG6Z24TzthVh8rq6vge9w+f4j92fiOnEzXKRXhAfIV0Chkr2OzNMEmjwWXZdSCn
	 PgFMLJf+yMkmueYQBq0kYMvB5zD7ij7TEvDR3R04=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbgCIL6V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 07:58:21 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45422 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726215AbgCIL6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 07:58:21 -0400
Received: by mail-wr1-f66.google.com with SMTP id m9so1711116wro.12
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 04:58:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=V2Ssma6CGptYN1B4ayzZk89MffFfSZ5Lvl/x2QnN3OI=;
        b=nGrjD9MwNhFzlDk4wb6DbxnETVyNnC2I0eCaWrpYCJmXViRY3QXArQfoRHGD6K9cxY
         +V9oqg2etjZtvDLtghJr0mEP4slWKDrGZeq98W1YTggq2aPkwLRbiAFfzGgqt4+rUmHm
         cRaXZ+echwZZDtWZtJnyPgE9R2u5lfgowvvYDHKTlDn4Y03S8Rotbcyi9gdSScuGTyML
         +387C6lbunUplClvMNwEqmIVxZhOLZtxLkCKI44HJq8ppyg27mQhX4Uwh34LhG9/T+pG
         yCUqqS/1OQyBw7cGifWhGtq+C0MuAX1a0DAi/Rz9ptebU5JCqv6777P5EzsgRC7c4gLT
         jibA==
X-Gm-Message-State: ANhLgQ3+OAfIhBx4x+IKmunFU3edIAcJ6XLnw2WBgY5OKfFt9KkbquNh
        GPiLehOfwaJ2ZlMXksq/TxQhWbta
X-Google-Smtp-Source: ADFU+vsNVjsCmPNEvh3yD8H3Vxk5520qSyatBjlAbFdu4IR1M/u++zj5CIzrig4ZY5v2DToolkbAmA==
X-Received: by 2002:adf:f9cd:: with SMTP id w13mr20423228wrr.406.1583755099729;
        Mon, 09 Mar 2020 04:58:19 -0700 (PDT)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id h3sm64424256wrb.23.2020.03.09.04.58.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 04:58:18 -0700 (PDT)
Date:   Mon, 9 Mar 2020 12:58:18 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Shaju Abraham <shajunutanix@gmail.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Shaju Abraham <shaju.abraham@nutanix.com>
Subject: Re: [PATCH] mm/vmpressure.c: Include GFP_KERNEL flag to vmpressure
Message-ID: <20200309115818.GK8447@dhcp22.suse.cz>
References: <20200309113141.167289-1-shaju.abraham@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200309113141.167289-1-shaju.abraham@nutanix.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 09-03-20 11:31:41, Shaju Abraham wrote:
> The VM pressure notification flags have excluded GFP_KERNEL with the
> reasoning that user land will not be able to take any action in case of
> kernel memory being low. This is not true always. Consider the case of
> a user land program managing all the huge memory pages. By including
> GFP_KERNEL flag whenever the kernel memory is low, pressure notification
> can be send, and the manager process can split huge pages to satisfy kernel
> memory requirement.

Are you sure about this reasoning? GFP_KERNEL = __GFP_FS | __GFP_IO | __GFP_RECLAIM
Two of the flags mentioned there are already listed so we are talking
about __GFP_RECLAIM here. Including it here would be a more appropriate
change than GFP_KERNEL btw.

But still I do not really understand what is the actual problem and how
is this patch meant to fix it. vmpressure is triggered only from the
reclaim path which inherently requires to have __GFP_RECLAIM present
so I fail to see how this can make any change at all. How have you
tested it?

> This is a common scanario in cloud. Most of the host memory is reserved
> as hugepages and can be broken down to small pages on demand. This is
> done to minimise fragmentation so that Virtual Machine power on will be
> successful always.
> 
> Signed-off-by: Shaju Abraham <shaju.abraham@nutanix.com>
> ---
>  mm/vmpressure.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/vmpressure.c b/mm/vmpressure.c
> index 4bac22fe1aa2..7ccfb3dd8173 100644
> --- a/mm/vmpressure.c
> +++ b/mm/vmpressure.c
> @@ -253,7 +253,8 @@ void vmpressure(gfp_t gfp, struct mem_cgroup *memcg, bool tree,
>  	 * Indirect reclaim (kswapd) sets sc->gfp_mask to GFP_KERNEL, so
>  	 * we account it too.
>  	 */
> -	if (!(gfp & (__GFP_HIGHMEM | __GFP_MOVABLE | __GFP_IO | __GFP_FS)))
> +	if (!(gfp & (__GFP_HIGHMEM | __GFP_MOVABLE | __GFP_IO |
> +		     __GFP_FS | GFP_KERNEL)))
>  		return;
>  
>  	/*
> -- 
> 2.20.1
> 

-- 
Michal Hocko
SUSE Labs
