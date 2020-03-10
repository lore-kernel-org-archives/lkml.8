Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 635DBC18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 14:56:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DCFF20674
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 14:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583852212;
	bh=b+D8G7sStSeBNt0PRnOo9CagMAXVFU0MUrjlAljGdpk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=CP/EZM7KSvq1dCekIlewm9Ac1nm97t21RSbJahnbC73jtQh2+eNrX8wWiquTH7kU0
	 ODsy0D59F6EFVEXTgf/gCAtvwXxdQMsg3sDe2RZ1x2EFH4CensNpkdbmk5yUkEMawM
	 SvekimEvRdeMj349l1EG3Jim03VLPY2N0xDb5qgM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727667AbgCJO4v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 10:56:51 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43177 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727532AbgCJO4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 10:56:51 -0400
Received: by mail-wr1-f65.google.com with SMTP id v9so16256127wrf.10
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 07:56:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GrLGwCNgXbztCMRReSyKuUa/Wr+RcCmi95sU2m2TGR8=;
        b=qvnde8v7iN8TCwGS6/VfKrVINF5iVEpnULFuQN1TGydWJCBpqpYUdBHpAKtOJ9ECfy
         F2RU2S0pE8ByMgklLNv7DcWnn1XKYvh6ZV0/OSDiQGwk5rGBHPXLSdL7F/syg3/qiV+M
         z/9eut78uYzZk5J1mbCmOHQJXWxVVscSV+Ih37oPMcEFfe5FpQ4Md47fKEUaFjLw9YkO
         BeL589UAD5xhgt15hkFwT8wfvZvV8DzIt16NBax57C7myTBCHY33UweSa//XJh995YXA
         b/kQFZsSt07S9ksD8LCy9gZ56VxsVrrrEClPAb9dM+AZK1E5hGRnwCR0YwMerOvN17KL
         /h9A==
X-Gm-Message-State: ANhLgQ2RAXPygRyEZqXIuoOy5cseNVoqyBYMygw4tHLXV3pTI2VSderc
        /Z3m3AkoHZIk+Wuuzg6S6lE=
X-Google-Smtp-Source: ADFU+vuByKdUn9XJ2iY4aPSdnV5FvFJXdIwLh05Qa4WphMsMCFkF1Y3x+YJKcDeKdLoKQsCKZ8USog==
X-Received: by 2002:a5d:6082:: with SMTP id w2mr27809592wrt.300.1583852209062;
        Tue, 10 Mar 2020 07:56:49 -0700 (PDT)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id h18sm4141209wmm.6.2020.03.10.07.56.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 07:56:48 -0700 (PDT)
Date:   Tue, 10 Mar 2020 15:56:47 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, david@redhat.com,
        richardw.yang@linux.intel.com, dan.j.williams@intel.com,
        osalvador@suse.de, rppt@linux.ibm.com
Subject: Re: [PATCH v3 7/7] mm/sparse.c: Use __get_free_pages() instead in
 populate_section_memmap()
Message-ID: <20200310145647.GN8447@dhcp22.suse.cz>
References: <20200307084229.28251-1-bhe@redhat.com>
 <20200307084229.28251-8-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200307084229.28251-8-bhe@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 07-03-20 16:42:29, Baoquan He wrote:
> This removes the unnecessary goto, and simplify codes.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> Reviewed-by: Wei Yang <richardw.yang@linux.intel.com>
> ---
>  mm/sparse.c | 16 ++++++----------
>  1 file changed, 6 insertions(+), 10 deletions(-)
> 
> diff --git a/mm/sparse.c b/mm/sparse.c
> index fde651ab8741..266f7f5040fb 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -735,23 +735,19 @@ static void free_map_bootmem(struct page *memmap)
>  struct page * __meminit populate_section_memmap(unsigned long pfn,
>  		unsigned long nr_pages, int nid, struct vmem_altmap *altmap)
>  {
> -	struct page *page, *ret;
> +	struct page *ret;
>  	unsigned long memmap_size = sizeof(struct page) * PAGES_PER_SECTION;
>  
> -	page = alloc_pages(GFP_KERNEL|__GFP_NOWARN, get_order(memmap_size));
> -	if (page)
> -		goto got_map_page;
> +	ret = (void*)__get_free_pages(GFP_KERNEL|__GFP_NOWARN,
> +				get_order(memmap_size));
> +	if (ret)
> +		return ret;
>  
>  	ret = vmalloc(memmap_size);
>  	if (ret)
> -		goto got_map_ptr;
> +		return ret;
>  
>  	return NULL;
> -got_map_page:
> -	ret = (struct page *)pfn_to_kaddr(page_to_pfn(page));
> -got_map_ptr:
> -
> -	return ret;
>  }

Boy this code is ugly. Is there any reason we cannot simply use
kvmalloc_array(PAGES_PER_SECTION, sizeof(struct page), GFP_KERNEL | __GFP_NOWARN)

And if we care about locality then go even one step further
kvmalloc_node(PAGES_PER_SECTION * sizeof(struct page), GFP_KERNEL | __GFP_NOWARN, nid)

-- 
Michal Hocko
SUSE Labs
