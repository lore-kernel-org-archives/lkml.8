Return-Path: <SRS0=IBMW=4Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0010BC10F00
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 11:56:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C322A2070A
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 11:56:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="haHvIz5D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726180AbgCGL4H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Mar 2020 06:56:07 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:31397 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726065AbgCGL4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Mar 2020 06:56:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583582165;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jVGh5l7IYfQ0JRs6ZhFDe9dOS0KlBegkv9u7kXJdDx0=;
        b=haHvIz5DdRD0hf1/rgLQxnsQe02i18C+I5jhotb5oEF25SYVY+h+Sj0iclBAzuzLKTSp+W
        BioUaJuCq91k0AfkuEXiIOfWXO5pBPprZuyvjjKGAqnEIei0vbqHZE2v49gNizWK890gyh
        iJ85SVHdBd/XC+x3go4KRF3rwSG7hx0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-44-w7WOqL_qPleAx0MieHxsHg-1; Sat, 07 Mar 2020 06:56:03 -0500
X-MC-Unique: w7WOqL_qPleAx0MieHxsHg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 77FE7801E6C;
        Sat,  7 Mar 2020 11:56:02 +0000 (UTC)
Received: from localhost (ovpn-12-29.pek2.redhat.com [10.72.12.29])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CFD5A9078A;
        Sat,  7 Mar 2020 11:55:58 +0000 (UTC)
Date:   Sat, 7 Mar 2020 19:55:56 +0800
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org, mhocko@suse.com,
        david@redhat.com, richardw.yang@linux.intel.com,
        dan.j.williams@intel.com, osalvador@suse.de, rppt@linux.ibm.com
Subject: Re: [PATCH v3 5/7] mm/sparse.c: add note about only VMEMMAP
 supporting sub-section support
Message-ID: <20200307115556.GB27711@MiWiFi-R3L-srv>
References: <20200307084229.28251-1-bhe@redhat.com>
 <20200307084229.28251-6-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200307084229.28251-6-bhe@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/07/20 at 04:42pm, Baoquan He wrote:

Sorry, the subject should be:

mm/sparse.c: add note about only VMEMMAP supporting sub-section hotplug

> And tell check_pfn_span() gating the porper alignment and size of
> hot added memory region.
> 
> And also move the code comments from inside section_deactivate()
> to being above it. The code comments are reasonable for the whole
> function, and the moving makes code cleaner.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  mm/sparse.c | 37 ++++++++++++++++++++-----------------
>  1 file changed, 20 insertions(+), 17 deletions(-)
> 
> diff --git a/mm/sparse.c b/mm/sparse.c
> index 2142045ab5c5..0fbd79c4ad81 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -772,6 +772,22 @@ static bool is_subsection_map_empty(struct mem_section *ms)
>  }
>  #endif
>  
> +/*
> + * To deactivate a memory region, there are 3 cases to handle across
> + * two configurations (SPARSEMEM_VMEMMAP={y,n}):
> + *
> + * 1. deactivation of a partial hot-added section (only possible in
> + *    the SPARSEMEM_VMEMMAP=y case).
> + *      a) section was present at memory init.
> + *      b) section was hot-added post memory init.
> + * 2. deactivation of a complete hot-added section.
> + * 3. deactivation of a complete section from memory init.
> + *
> + * For 1, when subsection_map does not empty we will not be freeing the
> + * usage map, but still need to free the vmemmap range.
> + *
> + * For 2 and 3, the SPARSEMEM_VMEMMAP={y,n} cases are unified
> + */
>  static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
>  		struct vmem_altmap *altmap)
>  {
> @@ -784,23 +800,6 @@ static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
>  		return;
>  
>  	empty = is_subsection_map_empty(ms);
> -	/*
> -	 * There are 3 cases to handle across two configurations
> -	 * (SPARSEMEM_VMEMMAP={y,n}):
> -	 *
> -	 * 1/ deactivation of a partial hot-added section (only possible
> -	 * in the SPARSEMEM_VMEMMAP=y case).
> -	 *    a/ section was present at memory init
> -	 *    b/ section was hot-added post memory init
> -	 * 2/ deactivation of a complete hot-added section
> -	 * 3/ deactivation of a complete section from memory init
> -	 *
> -	 * For 1/, when subsection_map does not empty we will not be
> -	 * freeing the usage map, but still need to free the vmemmap
> -	 * range.
> -	 *
> -	 * For 2/ and 3/ the SPARSEMEM_VMEMMAP={y,n} cases are unified
> -	 */
>  	if (empty) {
>  		unsigned long section_nr = pfn_to_section_nr(pfn);
>  
> @@ -907,6 +906,10 @@ static struct page * __meminit section_activate(int nid, unsigned long pfn,
>   *
>   * This is only intended for hotplug.
>   *
> + * Note that only VMEMMAP supports sub-section aligned hotplug,
> + * the proper alignment and size are gated by check_pfn_span().
> + *
> + *
>   * Return:
>   * * 0		- On success.
>   * * -EEXIST	- Section has been present.
> -- 
> 2.17.2
> 

