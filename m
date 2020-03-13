Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2EBAC10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 14:56:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B0F5206FA
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 14:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584111385;
	bh=LAzcPJ5imJkcghWhzqoGEdM+ZgxF28msfALdpuJDjVc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=h+wJXtujUbECnz5Tpc6Wcu+W0lR8YVg+iJns7R3XGtIn4f1NkLE+z62vm1JB1XDjq
	 XJNh7+fgGmkXHO4l+JSnTWrj4tpSmM3QMfZAwo0YNBHN04/8MFI2E0c0hkcGCQM8yj
	 dbWjiLZtwpe7kpG9X3nI9HtIdcBib6TOYlUKNbQY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbgCMO4Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 10:56:24 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40566 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbgCMO4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 10:56:24 -0400
Received: by mail-wr1-f68.google.com with SMTP id f3so5486565wrw.7
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 07:56:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9ElDdxeSYu4NkyRAmxZIQdqY4pRojIvARlsO9YRK9Us=;
        b=MqPIjjencIy+UVSuoMMpKtvcMzVksS0XRLxtWNatQO+FqHeig6l/5Jdimvruh6iKqD
         YtbuOixFI7n2hGBvIhPgFzINlT1223dRfzgOy/I2akxkx2Nll6N0YOZGOn3s/ufzjIhc
         LXJEyIXUzt45omezQRxbbwSBCB9YQLbRY5RzhF1ih/sCNphUGseNll4mWDHZk/GxS/8J
         u45hJtKmFA65oL5vRl6sN13DBT15EAF64iui6KCpYSNUY8eFMhTrhEuvNVZNQ505HctX
         6EiHGalHch9vYOQg4mudVPPoXE0K+NuatqNUyfiZiIN7cGHTVgb0Lzgr8QXV61ta+PtV
         C/mQ==
X-Gm-Message-State: ANhLgQ1qn8tQz4aDUDguV/jz2BM0ePp9cZJ+VLkto+0W5TJED5iXhtFA
        TSoZOp4IzKUkiepTriFrHApzI/Eh
X-Google-Smtp-Source: ADFU+vue2NbGV7G1Z3URoRGbNmt4diUMnxkBPy4bJadi/+ZMVIcecNH72arlxQKgIIPN16O57+azhQ==
X-Received: by 2002:adf:ef81:: with SMTP id d1mr1471759wro.212.1584111382205;
        Fri, 13 Mar 2020 07:56:22 -0700 (PDT)
Received: from localhost (ip-37-188-247-35.eurotel.cz. [37.188.247.35])
        by smtp.gmail.com with ESMTPSA id 9sm17160750wmo.38.2020.03.13.07.56.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 07:56:21 -0700 (PDT)
Date:   Fri, 13 Mar 2020 15:56:19 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, willy@infradead.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, david@redhat.com,
        richard.weiyang@gmail.com
Subject: Re: [PATCH v3] mm/sparse.c: Use kvmalloc_node/kvfree to alloc/free
 memmap for the classic sparse
Message-ID: <20200313145619.GD21007@dhcp22.suse.cz>
References: <20200312130822.6589-1-bhe@redhat.com>
 <20200312141749.GL27711@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200312141749.GL27711@MiWiFi-R3L-srv>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 12-03-20 22:17:49, Baoquan He wrote:
> This change makes populate_section_memmap()/depopulate_section_memmap
> much simpler.

Not only and you should make it more explicit. It also tries to allocate
memmaps from the target numa node so this is a functional change. I
would prefer to have that in a separate patch in case we hit some weird
NUMA setups which would choke on memory less nodes and similar horrors.

> Suggested-by: Michal Hocko <mhocko@kernel.org>
> Signed-off-by: Baoquan He <bhe@redhat.com>

I do not see any reason this shouldn't work. Btw. did you get to test
it?

Feel free to add
Acked-by: Michal Hocko <mhocko@suse.com>
to both patches if you go and split.

> ---
> v2->v3:
>   Remove __GFP_NOWARN and use array_size when calling kvmalloc_node()
>   per Matthew's comments.
> 
>  mm/sparse.c | 27 +++------------------------
>  1 file changed, 3 insertions(+), 24 deletions(-)
> 
> diff --git a/mm/sparse.c b/mm/sparse.c
> index bf6c00a28045..bb99633575b5 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -734,35 +734,14 @@ static void free_map_bootmem(struct page *memmap)
>  struct page * __meminit populate_section_memmap(unsigned long pfn,
>  		unsigned long nr_pages, int nid, struct vmem_altmap *altmap)
>  {
> -	struct page *page, *ret;
> -	unsigned long memmap_size = sizeof(struct page) * PAGES_PER_SECTION;
> -
> -	page = alloc_pages(GFP_KERNEL|__GFP_NOWARN, get_order(memmap_size));
> -	if (page)
> -		goto got_map_page;
> -
> -	ret = vmalloc(memmap_size);
> -	if (ret)
> -		goto got_map_ptr;
> -
> -	return NULL;
> -got_map_page:
> -	ret = (struct page *)pfn_to_kaddr(page_to_pfn(page));
> -got_map_ptr:
> -
> -	return ret;
> +	return kvmalloc_node(array_size(sizeof(struct page),
> +			PAGES_PER_SECTION), GFP_KERNEL, nid);
>  }
>  
>  static void depopulate_section_memmap(unsigned long pfn, unsigned long nr_pages,
>  		struct vmem_altmap *altmap)
>  {
> -	struct page *memmap = pfn_to_page(pfn);
> -
> -	if (is_vmalloc_addr(memmap))
> -		vfree(memmap);
> -	else
> -		free_pages((unsigned long)memmap,
> -			   get_order(sizeof(struct page) * PAGES_PER_SECTION));
> +	kvfree(pfn_to_page(pfn));
>  }
>  
>  static void free_map_bootmem(struct page *memmap)
> -- 
> 2.17.2
> 

-- 
Michal Hocko
SUSE Labs
