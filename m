Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41B0FC3F2D1
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 10:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1817D246A8
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 10:34:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Am0FD42/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbgB1Ke4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 05:34:56 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:49995 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726063AbgB1Kez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 05:34:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582886094;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b9BiqptG5CvKmVJGgPPEg6FbrIABgQ16W4CEhy9cQo4=;
        b=Am0FD42/IXUe7ra6fBUf43fgW/wJ8nwKwnkGnAjBjM8jJYzEnvzeVTTT6KYbS+dKd9qjyG
        U4001UMjeLpDODMISbrzwI8FJr2tf3MIV9Yc1yxGUuevc8nkKbZ1hRCb+x3i6bs55t22mm
        t3nVLgduCjIHYVUr9XtUdDPKhJpe32k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-477-WkdMyT2vNu6cy-v1klaoWA-1; Fri, 28 Feb 2020 05:34:50 -0500
X-MC-Unique: WkdMyT2vNu6cy-v1klaoWA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 134821005510;
        Fri, 28 Feb 2020 10:34:49 +0000 (UTC)
Received: from localhost (ovpn-12-49.pek2.redhat.com [10.72.12.49])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6BA348681F;
        Fri, 28 Feb 2020 10:34:45 +0000 (UTC)
Date:   Fri, 28 Feb 2020 18:34:42 +0800
From:   Baoquan He <bhe@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Wei Yang <richardw.yang@linux.intel.com>
Subject: Re: [PATCH v2 2/2] mm/memory_hotplug: cleanup __add_pages()
Message-ID: <20200228103442.GL24216@MiWiFi-R3L-srv>
References: <20200228095819.10750-1-david@redhat.com>
 <20200228095819.10750-3-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200228095819.10750-3-david@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/28/20 at 10:58am, David Hildenbrand wrote:
> Let's drop the basically unused section stuff and simplify. The logic
> now matches the logic in __remove_pages().
> 
> Cc: Segher Boessenkool <segher@kernel.crashing.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Wei Yang <richardw.yang@linux.intel.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  mm/memory_hotplug.c | 18 +++++++-----------
>  1 file changed, 7 insertions(+), 11 deletions(-)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 8fe7e32dad48..1a00b5a37ef6 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -307,8 +307,9 @@ static int check_hotplug_memory_addressable(unsigned long pfn,
>  int __ref __add_pages(int nid, unsigned long pfn, unsigned long nr_pages,
>  		struct mhp_restrictions *restrictions)
>  {
> +	const unsigned long end_pfn = pfn + nr_pages;
> +	unsigned long cur_nr_pages;
>  	int err;
> -	unsigned long nr, start_sec, end_sec;
>  	struct vmem_altmap *altmap = restrictions->altmap;
>  
>  	err = check_hotplug_memory_addressable(pfn, nr_pages);
> @@ -331,18 +332,13 @@ int __ref __add_pages(int nid, unsigned long pfn, unsigned long nr_pages,
>  	if (err)
>  		return err;
>  
> -	start_sec = pfn_to_section_nr(pfn);
> -	end_sec = pfn_to_section_nr(pfn + nr_pages - 1);
> -	for (nr = start_sec; nr <= end_sec; nr++) {
> -		unsigned long pfns;
> -
> -		pfns = min(nr_pages, PAGES_PER_SECTION
> -				- (pfn & ~PAGE_SECTION_MASK));
> -		err = sparse_add_section(nid, pfn, pfns, altmap);
> +	for (; pfn < end_pfn; pfn += cur_nr_pages) {
> +		/* Select all remaining pages up to the next section boundary */
> +		cur_nr_pages = min(end_pfn - pfn,
> +				   SECTION_ALIGN_UP(pfn + 1) - pfn);
> +		err = sparse_add_section(nid, pfn, cur_nr_pages, altmap);

Honestly, I am not a big fan of this kind of code refactoring. The old
code may span seveal more lines or define several several more veriables,
but logic is clear, and no visible defect. It's hard to say how much we
can benefit from this kind of code simplifying, and reviewing it will take
people more time. While for the code style consistency with
__remove_page(), I would like to see it's merged. My personal opinion.

Reviewed-by: Baoquan He <bhe@redhat.com>

>  		if (err)
>  			break;
> -		pfn += pfns;
> -		nr_pages -= pfns;
>  		cond_resched();
>  	}
>  	vmemmap_populate_print_last();
> -- 
> 2.24.1
> 

