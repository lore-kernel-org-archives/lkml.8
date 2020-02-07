Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37CABC352A2
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 04:11:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08B962064C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 04:11:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KoeCHPmg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727309AbgBGELr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 23:11:47 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25624 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726674AbgBGELq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 23:11:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581048705;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=akgcBFyOF/SJfU2Z94L9VSjtKLSXA2U9TSAHH+wmN5c=;
        b=KoeCHPmgnwtOK0xwMjS2uQy+N2CLfkPQZRHF1CTNSt6++4zuu12GXXBig0uPFjZ75Vj2RZ
        3GXX3xiZTDfCzOou/qYEgd5gAmMM5U5tHbc+fZOGhhdFZUVCjYcaEoMw2zE2krtMMyT+YL
        PV85C8+QcTpAflTTCcJMzkkhDHeyvhs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-205-Cw8G6ibaM4CZqgLJh8wlFw-1; Thu, 06 Feb 2020 23:11:41 -0500
X-MC-Unique: Cw8G6ibaM4CZqgLJh8wlFw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0E9101088389;
        Fri,  7 Feb 2020 04:11:40 +0000 (UTC)
Received: from localhost (ovpn-12-30.pek2.redhat.com [10.72.12.30])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DE3FA60BEC;
        Fri,  7 Feb 2020 04:11:36 +0000 (UTC)
Date:   Fri, 7 Feb 2020 12:11:34 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Wei Yang <richardw.yang@linux.intel.com>
Cc:     akpm@linux-foundation.org, osalvador@suse.de,
        dan.j.williams@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, david@redhat.com
Subject: Re: [PATCH 2/3] mm/sparsemem: get physical address to page struct
 instead of virtual address to pfn
Message-ID: <20200207041134.GC25537@MiWiFi-R3L-srv>
References: <20200206231629.14151-1-richardw.yang@linux.intel.com>
 <20200206231629.14151-3-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200206231629.14151-3-richardw.yang@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/07/20 at 07:16am, Wei Yang wrote:
> memmap should be the physical address to page struct instead of virtual
> address to pfn.

Maybe not, memmap stores a virtual address.

> 
> Since we call this only for SPARSEMEM_VMEMMAP, pfn_to_page() is valid at
> this point.
> 
> Fixes: ba72b4c8cf60 ("mm/sparsemem: support sub-section hotplug")
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> CC: Dan Williams <dan.j.williams@intel.com>
> ---
>  mm/sparse.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/sparse.c b/mm/sparse.c
> index b5da121bdd6e..56816f653588 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -888,7 +888,7 @@ int __meminit sparse_add_section(int nid, unsigned long start_pfn,
>  	/* Align memmap to section boundary in the subsection case */
>  	if (IS_ENABLED(CONFIG_SPARSEMEM_VMEMMAP) &&
>  		section_nr_to_pfn(section_nr) != start_pfn)
> -		memmap = pfn_to_kaddr(section_nr_to_pfn(section_nr));
> +		memmap = pfn_to_page(section_nr_to_pfn(section_nr));

With Dan's confirmation, sub-section is only valid in vmemmap case. I
think the old if (section_nr_to_pfn(section_nr) != start_pfn) is enough
to filter out non vmemmap case. So only below code is good:

 +		memmap = pfn_to_page(section_nr_to_pfn(section_nr));

>  	sparse_init_one_section(ms, section_nr, memmap, ms->usage, 0);
>  
>  	return 0;
> -- 
> 2.17.1
> 

