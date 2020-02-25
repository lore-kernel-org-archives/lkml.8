Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94DF0C35DF9
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 09:57:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67C8721744
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 09:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582624637;
	bh=oNoxmtwDoRX7im/zXlCTJeA/EqqXHfsMBdj6TSTOf0Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=X2ONxUX7jp/oLNe5juW1uaeV2Prr8i2mIMJrqHjiDrIy61+KO9xdbtmGGb0WsIzRv
	 23vXCglfLO53Grcii273ZOvWxMW+QLaxaabe32lWzAlhut3F9voIYWpaXDHgygE9XZ
	 fSsqgzab+7OKzYfwMjhjqy1CcxCi9lvgi/JZHcCs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729417AbgBYJ5Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 04:57:16 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39378 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbgBYJ5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 04:57:16 -0500
Received: by mail-wm1-f67.google.com with SMTP id c84so2439268wme.4
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 01:57:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uuJgO70EZWRPhcWgOVoAzvPvh7CsKKHz+o1Wbgf3edU=;
        b=imHiUlF08Z07GTxQa2XY0D06cf2N+Xw5IacoJvuOfgOq56GCRjp5Yis8wMSSqETTUe
         vlbyx5ChUYCyLdiUhHS+H2RuV4d+TUIVnjtoUA3awQpOqdjf0w+bfXlt0aP3C0mxiRiV
         +Zgz55IXNM+Kymyz9oAniaafU/Tkgg1bfCQPQgYcCIbAXKue1aHvsiE4xbK4iOqDYxPJ
         HQonTX28l0aWW8trhIPIkQMXqckkq3o6VCRrocsr2NncyzR5/fXYe2ROJErM/B6+KLeJ
         DKcsItrtwYKvDZ/+Rt0ELEuf071YZGlxO7ysZBeLHXyriNqUZBHApe/TdFpf/SEK6CoE
         /yDg==
X-Gm-Message-State: APjAAAV1gdWFVi43LhGgVQF6UZ1bOD7ZCadwOHJMgBycYVZTnMvU45JR
        ho2Tzqn7MPIVgkWerWB0j6aF3FVM
X-Google-Smtp-Source: APXvYqzl5Wa2LVoqcT0D6oC/HDPcFd6i5oM20HvD8fnByWa2WpdGoHn6VdH8PJ8QE2f/XOXaXrRDAQ==
X-Received: by 2002:a7b:c651:: with SMTP id q17mr4555596wmk.5.1582624634022;
        Tue, 25 Feb 2020 01:57:14 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id p26sm3317403wmc.24.2020.02.25.01.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 01:57:13 -0800 (PST)
Date:   Tue, 25 Feb 2020 10:57:13 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, richardw.yang@linux.intel.com,
        david@redhat.com, osalvador@suse.de, dan.j.williams@intel.com,
        rppt@linux.ibm.com, robin.murphy@arm.com
Subject: Re: [PATCH v2 4/7] mm/sparse.c: only use subsection map in VMEMMAP
 case
Message-ID: <20200225095713.GL22443@dhcp22.suse.cz>
References: <20200220043316.19668-1-bhe@redhat.com>
 <20200220043316.19668-5-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200220043316.19668-5-bhe@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 20-02-20 12:33:13, Baoquan He wrote:
> Currently, subsection map is used when SPARSEMEM is enabled, including
> VMEMMAP case and !VMEMMAP case. However, subsection hotplug is not
> supported at all in SPARSEMEM|!VMEMMAP case, subsection map is unnecessary
> and misleading. Let's adjust code to only allow subsection map being
> used in VMEMMAP case.

This really needs more explanation I believe. What exactly happens if
somebody tries to hotremove a part of the section with !VMEMMAP? I can
see that clear_subsection_map returns 0 but that is not an error code.
Besides that section_deactivate doesn't propagate the error upwards.
/me stares into the code

OK, I can see it now. It is relying on check_pfn_span to use the proper
subsection granularity. This really begs for a comment in the code
somewhere.

> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  include/linux/mmzone.h |  2 ++
>  mm/sparse.c            | 20 ++++++++++++++++++++
>  2 files changed, 22 insertions(+)
> 
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 462f6873905a..fc0de3a9a51e 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -1185,7 +1185,9 @@ static inline unsigned long section_nr_to_pfn(unsigned long sec)
>  #define SUBSECTION_ALIGN_DOWN(pfn) ((pfn) & PAGE_SUBSECTION_MASK)
>  
>  struct mem_section_usage {
> +#ifdef CONFIG_SPARSEMEM_VMEMMAP
>  	DECLARE_BITMAP(subsection_map, SUBSECTIONS_PER_SECTION);
> +#endif
>  	/* See declaration of similar field in struct zone */
>  	unsigned long pageblock_flags[0];
>  };
> diff --git a/mm/sparse.c b/mm/sparse.c
> index df857ee9330c..66c497d6a229 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -209,6 +209,7 @@ static inline unsigned long first_present_section_nr(void)
>  	return next_present_section_nr(-1);
>  }
>  
> +#ifdef CONFIG_SPARSEMEM_VMEMMAP
>  static void subsection_mask_set(unsigned long *map, unsigned long pfn,
>  		unsigned long nr_pages)
>  {
> @@ -243,6 +244,11 @@ void __init subsection_map_init(unsigned long pfn, unsigned long nr_pages)
>  		nr_pages -= pfns;
>  	}
>  }
> +#else
> +void __init subsection_map_init(unsigned long pfn, unsigned long nr_pages)
> +{
> +}
> +#endif
>  
>  /* Record a memory area against a node. */
>  void __init memory_present(int nid, unsigned long start, unsigned long end)
> @@ -726,6 +732,7 @@ static void free_map_bootmem(struct page *memmap)
>  }
>  #endif /* CONFIG_SPARSEMEM_VMEMMAP */
>  
> +#ifdef CONFIG_SPARSEMEM_VMEMMAP
>  /**
>   * clear_subsection_map - Clear subsection map of one memory region
>   *
> @@ -764,6 +771,12 @@ static int clear_subsection_map(unsigned long pfn, unsigned long nr_pages)
>  
>  	return 1;
>  }
> +#else
> +static int clear_subsection_map(unsigned long pfn, unsigned long nr_pages)
> +{
> +	return 0;
> +}
> +#endif
>  
>  static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
>  		struct vmem_altmap *altmap)
> @@ -820,6 +833,7 @@ static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
>  		ms->section_mem_map = (unsigned long)NULL;
>  }
>  
> +#ifdef CONFIG_SPARSEMEM_VMEMMAP
>  /**
>   * fill_subsection_map - fill subsection map of a memory region
>   * @pfn - start pfn of the memory range
> @@ -854,6 +868,12 @@ static int fill_subsection_map(unsigned long pfn, unsigned long nr_pages)
>  
>  	return rc;
>  }
> +#else
> +static int fill_subsection_map(unsigned long pfn, unsigned long nr_pages)
> +{
> +	return 0;
> +}
> +#endif
>  
>  static struct page * __meminit section_activate(int nid, unsigned long pfn,
>  		unsigned long nr_pages, struct vmem_altmap *altmap)
> -- 
> 2.17.2
> 

-- 
Michal Hocko
SUSE Labs
