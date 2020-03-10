Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 794DFC18E5A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 10:10:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D05F222D9
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 10:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583835050;
	bh=lX6Hm885Qs0gR4ZGUFuLRhwlo8L9c82RLVgZTGB2Y9k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=03DrWNejNs6GdXHEK1FVcybPdlK1pB+lF7qXpig0XPQyTt0SWtKNft2aVTOSWTa+v
	 JO9mtuHFmQHwl+AkNkEaPcWzG8fGOGuDk7Wur/F+yxYWselwgfvrAukNtpM7POyKsL
	 s1A/3ErFuitmB24Zxsn8hPXTxoPiSxlz5z1a1fLs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbgCJKKt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 06:10:49 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50968 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbgCJKKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 06:10:48 -0400
Received: by mail-wm1-f66.google.com with SMTP id a5so652952wmb.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 03:10:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=w1muF95flLMeOHW3vwFj3CGt+CE8hwju5evxMy9X1pY=;
        b=KI/0yaRLeeEmxF/pwAKIcT+FknT1msoF0KTDj5Vci4WxfTYEAABTzipCI1IYjcoaxR
         en9Nsx/GpOOEdUfuJzj7ddbWJ8X6WpbFI+05W9dl0QcudZ9FePMRyDRmD/F900KiJfDX
         qg9ZqiDHHu1uascveD6e4TXU5w0Pzj1ospxX4n1vxuDhYQWWsYxM0iL32CqpRYDGkWmg
         /ReOJBjREOBGBXsvDppeXHHNEguN1e3EwY1BZKhzYQpmwx2prXamx734kv1kUiavg9z9
         J+KzHLU8B07C78/2Ho0M8O6K0zc5uxE2cOBzJrBwynZDyL/IfY1I35pBLnyhh0geNKWr
         31UA==
X-Gm-Message-State: ANhLgQ15NHhmHHf5P0W1KnFgJAX4U/EN7WgT85Svxjh7m5imbmtiedP2
        g39Jf53Hf13LM14xvl8JIVA=
X-Google-Smtp-Source: ADFU+vvw4aVKgyY94Ay1EuF0rQhBEU+88Lja8aXifwqEBvY2KByO+ZUAAMMA8lve4IU+xtfx6wGBog==
X-Received: by 2002:a1c:a502:: with SMTP id o2mr1391124wme.94.1583835046625;
        Tue, 10 Mar 2020 03:10:46 -0700 (PDT)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id u1sm46731381wrt.78.2020.03.10.03.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 03:10:45 -0700 (PDT)
Date:   Tue, 10 Mar 2020 11:10:44 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, x86@kernel.org
Subject: Re: [PATCH] x86/mm: Remove the redundant conditional check
Message-ID: <20200310101044.GE8447@dhcp22.suse.cz>
References: <20200308013511.12792-1-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200308013511.12792-1-bhe@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 08-03-20 09:35:11, Baoquan He wrote:
> In commit f70029bbaacbfa8f0 ("mm, memory_hotplug: drop CONFIG_MOVABLE_NODE"),
> the dependency on CONFIG_MOVABLE_NODE was removed for N_MEMORY, so the
> conditional check in paging_init() doesn't make any sense any more.
> Remove it.

Please expand more. I would really have to refresh the intention of the
code but from a quick look at the code CONFIG_HIGHMEM still makes
N_MEMORY != N_NORMAL_MEMORY. So what what does this change mean for that
config?

> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  arch/x86/mm/init_64.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
> index abbdecb75fad..0a14711d3a93 100644
> --- a/arch/x86/mm/init_64.c
> +++ b/arch/x86/mm/init_64.c
> @@ -818,8 +818,7 @@ void __init paging_init(void)
>  	 *	 will not set it back.
>  	 */
>  	node_clear_state(0, N_MEMORY);
> -	if (N_MEMORY != N_NORMAL_MEMORY)
> -		node_clear_state(0, N_NORMAL_MEMORY);
> +	node_clear_state(0, N_NORMAL_MEMORY);
>  
>  	zone_sizes_init();
>  }
> -- 
> 2.17.2
> 

-- 
Michal Hocko
SUSE Labs
