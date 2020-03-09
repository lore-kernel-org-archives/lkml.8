Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C333C18E5A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 12:56:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E99CF20675
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 12:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583758583;
	bh=Xwqksif7BZPncu4luIX5F7cfLR9MIzGxD2o53j9RqSo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sA07YJtTqO1DIyuWLHCVg2sA8LDkDdQFtkKwuJnjQhFUGikUzESBz3gE4uAOo9H/C
	 biVvCYXRskQ0xwAg9SumX4pNYlkZQATR7WrAz8kkNFQxUCAGgEaI1L/n5TcuF3dW5M
	 KpPuPgf2ZfSjowiHnVASn8FvHQLmY06KEHCSRX4A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbgCIM4V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 08:56:21 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38396 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbgCIM4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 08:56:21 -0400
Received: by mail-wm1-f65.google.com with SMTP id n2so2974930wmc.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 05:56:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gq8lvDnUmFCRgH6sF6xrnqEuLK4v2Ud/2P7jS7ef2Bo=;
        b=PfwQ3S/u1vkreU2Wtg6IVlJOFZUNrKL5U/1cxy331BEg4A/CgmaX1212jj1/lBhFVr
         Zm0kXYMTSTy1Z+AMSSO2+vMSrJuGdnHbxxfoNpQo96aeswrDkCkSEu2TOmAMBSFqNkLQ
         +XK8BwyzKdU9epLMXEOM6Zr80gtJF4BqfbCjsqA8wsohoqJJ8ScthCTfLT4RhRROsNkj
         TkERNGr05edx0JZmaiodZeLVAC5IHZCUBQ5T5HjkFfJggFu2DvPV3IhmkfLq2/4MWOkd
         /qTxM/BL0EonXrp0PKFAP22JDMBlv+RtpwxWu2U/3hJBF+AIjsno9fnk4c6KNFKFH3Bf
         E6vg==
X-Gm-Message-State: ANhLgQ09YwmqfhIbxoAt/vEhdvdstPe8B1MzXwcOEfA9ZSMvfPYBclcT
        BlQ3obIZCUqL38LCE1C96fA=
X-Google-Smtp-Source: ADFU+vsP+Jrln3/r7fb9RQkXChPfF5rGSDid6SM6LWBFHSC/65uEv1bVz/YB4D7HcoTj4W+A+t63gg==
X-Received: by 2002:a7b:c2a2:: with SMTP id c2mr19703362wmk.19.1583758579074;
        Mon, 09 Mar 2020 05:56:19 -0700 (PDT)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id c8sm52475887wru.7.2020.03.09.05.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 05:56:18 -0700 (PDT)
Date:   Mon, 9 Mar 2020 13:56:17 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, david@redhat.com,
        richardw.yang@linux.intel.com, dan.j.williams@intel.com,
        osalvador@suse.de, rppt@linux.ibm.com
Subject: Re: [PATCH v3 1/7] mm/hotplug: fix hot remove failure in
 SPARSEMEM|!VMEMMAP case
Message-ID: <20200309125617.GO8447@dhcp22.suse.cz>
References: <20200307084229.28251-1-bhe@redhat.com>
 <20200307084229.28251-2-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200307084229.28251-2-bhe@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 07-03-20 16:42:23, Baoquan He wrote:
> In section_deactivate(), pfn_to_page() doesn't work any more after
> ms->section_mem_map is resetting to NULL in SPARSEMEM|!VMEMMAP case.
> It caused hot remove failure:
> 
> kernel BUG at mm/page_alloc.c:4806!
> invalid opcode: 0000 [#1] SMP PTI
> CPU: 3 PID: 8 Comm: kworker/u16:0 Tainted: G        W         5.5.0-next-20200205+ #340
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 0.0.0 02/06/2015
> Workqueue: kacpi_hotplug acpi_hotplug_work_fn
> RIP: 0010:free_pages+0x85/0xa0
> Call Trace:
>  __remove_pages+0x99/0xc0
>  arch_remove_memory+0x23/0x4d
>  try_remove_memory+0xc8/0x130
>  ? walk_memory_blocks+0x72/0xa0
>  __remove_memory+0xa/0x11
>  acpi_memory_device_remove+0x72/0x100
>  acpi_bus_trim+0x55/0x90
>  acpi_device_hotplug+0x2eb/0x3d0
>  acpi_hotplug_work_fn+0x1a/0x30
>  process_one_work+0x1a7/0x370
>  worker_thread+0x30/0x380
>  ? flush_rcu_work+0x30/0x30
>  kthread+0x112/0x130
>  ? kthread_create_on_node+0x60/0x60
>  ret_from_fork+0x35/0x40
> 
> Let's move the ->section_mem_map resetting after depopulate_section_memmap()
> to fix it.
> 
> Fixes: ba72b4c8cf60 ("mm/sparsemem: support sub-section hotplug")
> Signed-off-by: Baoquan He <bhe@redhat.com>
> Cc: stable@vger.kernel.org

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/sparse.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/sparse.c b/mm/sparse.c
> index 42c18a38ffaa..1b50c15677d7 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -734,6 +734,7 @@ static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
>  	struct mem_section *ms = __pfn_to_section(pfn);
>  	bool section_is_early = early_section(ms);
>  	struct page *memmap = NULL;
> +	bool empty = false;
>  	unsigned long *subsection_map = ms->usage
>  		? &ms->usage->subsection_map[0] : NULL;
>  
> @@ -764,7 +765,8 @@ static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
>  	 * For 2/ and 3/ the SPARSEMEM_VMEMMAP={y,n} cases are unified
>  	 */
>  	bitmap_xor(subsection_map, map, subsection_map, SUBSECTIONS_PER_SECTION);
> -	if (bitmap_empty(subsection_map, SUBSECTIONS_PER_SECTION)) {
> +	empty = bitmap_empty(subsection_map, SUBSECTIONS_PER_SECTION);
> +	if (empty) {
>  		unsigned long section_nr = pfn_to_section_nr(pfn);
>  
>  		/*
> @@ -779,13 +781,15 @@ static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
>  			ms->usage = NULL;
>  		}
>  		memmap = sparse_decode_mem_map(ms->section_mem_map, section_nr);
> -		ms->section_mem_map = (unsigned long)NULL;
>  	}
>  
>  	if (section_is_early && memmap)
>  		free_map_bootmem(memmap);
>  	else
>  		depopulate_section_memmap(pfn, nr_pages, altmap);
> +
> +	if (empty)
> +		ms->section_mem_map = (unsigned long)NULL;
>  }
>  
>  static struct page * __meminit section_activate(int nid, unsigned long pfn,
> -- 
> 2.17.2
> 

-- 
Michal Hocko
SUSE Labs
