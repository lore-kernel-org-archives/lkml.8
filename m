Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A688C3F2D3
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 10:23:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48AA82469F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 10:23:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QLwIe1zG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbgB1KXJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 05:23:09 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:49749 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726005AbgB1KXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 05:23:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582885387;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UxuggNNzearR180tpKOC+gN2nR4ttuW45PhgH1v5/2w=;
        b=QLwIe1zGBi+ywmi8LVF2UeJbMRcT8ZwtgPdoSunqruyli7aJy0JkP0MnngYQIosdbukDLX
        ncKfs3TcOwVX8D9UZkRRkT0zxWnK22H+dPrT50pInYmMKL++QL8kuWAJxx5bUMhm9wvJu8
        hQzQPmuEtL1VxcMbqgvqLpEQPUgT45I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-276-ttNN7RDmOGKWZpNVOC-gPw-1; Fri, 28 Feb 2020 05:23:02 -0500
X-MC-Unique: ttNN7RDmOGKWZpNVOC-gPw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 00B7D107ACC9;
        Fri, 28 Feb 2020 10:23:01 +0000 (UTC)
Received: from localhost (ovpn-12-49.pek2.redhat.com [10.72.12.49])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2E60C101D48A;
        Fri, 28 Feb 2020 10:22:57 +0000 (UTC)
Date:   Fri, 28 Feb 2020 18:22:54 +0800
From:   Baoquan He <bhe@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Wei Yang <richardw.yang@linux.intel.com>
Subject: Re: [PATCH v2 1/2] mm/memory_hotplug: simplify calculation of number
 of pages in __remove_pages()
Message-ID: <20200228102254.GL4937@MiWiFi-R3L-srv>
References: <20200228095819.10750-1-david@redhat.com>
 <20200228095819.10750-2-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200228095819.10750-2-david@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/28/20 at 10:58am, David Hildenbrand wrote:
> In commit 52fb87c81f11 ("mm/memory_hotplug: cleanup __remove_pages()"),
> we cleaned up __remove_pages(), and introduced a shorter variant to
> calculate the number of pages to the next section boundary.
> 
> Turns out we can make this calculation easier to read. We always want to
> have the number of pages (> 0) to the next section boundary, starting from
> the current pfn.
> 
> We'll clean up __remove_pages() in a follow-up patch and directly make
> use of this computation.
> 
> Suggested-by: Segher Boessenkool <segher@kernel.crashing.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Wei Yang <richardw.yang@linux.intel.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  mm/memory_hotplug.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 4a9b3f6c6b37..8fe7e32dad48 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -534,7 +534,8 @@ void __remove_pages(unsigned long pfn, unsigned long nr_pages,
>  	for (; pfn < end_pfn; pfn += cur_nr_pages) {
>  		cond_resched();
>  		/* Select all remaining pages up to the next section boundary */
> -		cur_nr_pages = min(end_pfn - pfn, -(pfn | PAGE_SECTION_MASK));
> +		cur_nr_pages = min(end_pfn - pfn,
> +				   SECTION_ALIGN_UP(pfn + 1) - pfn);

Reviewed-by: Baoquan He <bhe@redhat.com>

