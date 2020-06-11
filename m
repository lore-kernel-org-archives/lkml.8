Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C55CC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 09:35:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11439204EC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 09:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591868131;
	bh=SFu6ijIwLu9L/2DkNn7ff4c2xan6U+236bF9FN93/sE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=AELPnagTHh+FR80WCWYbHwDkfzFTbVE9QKaAlkg1NUASqDA0eqx1QZ0/xnEMf7FqZ
	 vPTUNqzqIwswsHGgxyGkIDMDUgVq9SkwR3z2TMKfJwYENshGbkPzUHTF3KfsFQDHXs
	 5kDpSTKV4m+hLSA1hW2kNxSCL7nSf0kKur4pwxW0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbgFKJf3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 05:35:29 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41199 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726560AbgFKJf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 05:35:28 -0400
Received: by mail-wr1-f66.google.com with SMTP id j10so5401760wrw.8;
        Thu, 11 Jun 2020 02:35:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fCziW7D9RQqCEqfz7/IGRWHPMeEiWE2daJvcDBf0ZPA=;
        b=sd4niBTvsJr+OjxfwYzZy/zmX5UHFSvgUubOcCTS9TucQ/Gl569kvXpMmLFDdjXkZm
         ub/McMAoMmNiFgY/8WtTY4l6GyPeBY5RenXfQThl5pH2cmEk4F5oiNK+jMEeL/RLEwwT
         0r6TXOTuij1gWvAKu2MUnUi/hu05bJemhjh2k2mjqkeLMyIsQI8lTh4YHAp2jvzCJt69
         1v1fv7mzoDJTylwvc8FJRPfv5D1wz6mluXTlKglTzCzssFn6Rw/kmYwa2HmK+Z0AySM9
         MH/sZ/7Vgb+cMOaorTtKPJDjfYnPDg4jdinRvItoFrl7t9N1RGOj6R0VmTEAo/UgYMY2
         riLg==
X-Gm-Message-State: AOAM531em3EIDz6qvd4lL7aThNi++5PafH3yP0a3G3bkbpTbY1kkL1k7
        eTDpDfnfGVcVJM7RPLLCj9M=
X-Google-Smtp-Source: ABdhPJwH0mDt5sHqy/XukKQyC767OzXT3IpOZMbx+o8zAQCUAY/T6Fsnyv8bfwIUq0D76RR8+m6TOg==
X-Received: by 2002:a5d:484b:: with SMTP id n11mr8689943wrs.356.1591868126445;
        Thu, 11 Jun 2020 02:35:26 -0700 (PDT)
Received: from localhost (ip-37-188-174-201.eurotel.cz. [37.188.174.201])
        by smtp.gmail.com with ESMTPSA id y19sm3165036wmi.6.2020.06.11.02.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2020 02:35:25 -0700 (PDT)
Date:   Thu, 11 Jun 2020 11:35:23 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Joonsoo Kim <js1304@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 16/19] mm: memcontrol: charge swapin pages on
 instantiation
Message-ID: <20200611093523.GB20450@dhcp22.suse.cz>
References: <20200508183105.225460-1-hannes@cmpxchg.org>
 <20200508183105.225460-17-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200508183105.225460-17-hannes@cmpxchg.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 08-05-20 14:31:03, Johannes Weiner wrote:
[...]
> diff --git a/mm/memory.c b/mm/memory.c
> index 832ee914cbcf..93900b121b6e 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3125,9 +3125,20 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  			page = alloc_page_vma(GFP_HIGHUSER_MOVABLE, vma,
>  							vmf->address);
>  			if (page) {
> +				int err;
> +
>  				__SetPageLocked(page);
>  				__SetPageSwapBacked(page);
>  				set_page_private(page, entry.val);
> +
> +				/* Tell memcg to use swap ownership records */
> +				SetPageSwapCache(page);
> +				err = mem_cgroup_charge(page, vma->vm_mm,
> +							GFP_KERNEL, false);
> +				ClearPageSwapCache(page);
> +				if (err)
> +					goto out_page;

err would be a return value from try_charge and that can be -ENOMEM. Now
we almost never return ENOMEM for GFP_KERNEL single page charge. Except
for async OOM handling (oom_disabled v1). So this needs translation to
VM_FAULT_OOM.

I am not an expert on the swap code so I might have missed some subtle
issues but the rest of the patch seems reasonable to me.
-- 
Michal Hocko
SUSE Labs
