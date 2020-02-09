Return-Path: <SRS0=6uoK=35=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57730C35250
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Feb 2020 10:37:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2308C20733
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Feb 2020 10:37:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D+aJI4T/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727663AbgBIKhC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Feb 2020 05:37:02 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57496 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726312AbgBIKhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Feb 2020 05:37:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581244620;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SWKMsAmoROZC3QCkAyrOWBtkkYi/wXfg2JPbAKg922E=;
        b=D+aJI4T/1Lde4ZTIvmbTLsbBB/rB+Ie931OEwArdTuHrsDKhT6iQNwRZ/U/tvt6U/dk4J+
        OPpsZIB0/9Sb6wM/5xcfXAsgLVT+juWBKvY6h1Eyp3Gsicd6a3xgsW70RH+3e97p2ZLQS4
        yHS5f2TOs9YAWtFAKc/kdXS5eIX9X78=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-440-a_SbAk6FME6VvC-3ifZFBg-1; Sun, 09 Feb 2020 05:36:57 -0500
X-MC-Unique: a_SbAk6FME6VvC-3ifZFBg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B0A288017CC;
        Sun,  9 Feb 2020 10:36:55 +0000 (UTC)
Received: from localhost (ovpn-12-31.pek2.redhat.com [10.72.12.31])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7ED9619C58;
        Sun,  9 Feb 2020 10:36:52 +0000 (UTC)
Date:   Sun, 9 Feb 2020 18:36:49 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Wei Yang <richardw.yang@linux.intel.com>
Cc:     akpm@linux-foundation.org, osalvador@suse.de,
        dan.j.williams@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, david@redhat.com
Subject: Re: [PATCH] mm/sparsemem: pfn_to_page is not valid yet on SPARSEMEM
Message-ID: <20200209103649.GW8965@MiWiFi-R3L-srv>
References: <20200206125343.9070-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200206125343.9070-1-richardw.yang@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/06/20 at 08:53pm, Wei Yang wrote:
> When we use SPARSEMEM instead of SPARSEMEM_VMEMMAP, pfn_to_page()
> doesn't work before sparse_init_one_section() is called. This leads to a
> crash when hotplug memory.
> 
> We should use memmap as it did.

A good fix, thanks.

Reviewed-by: Baoquan He <bhe@redhat.com>

By the way, the failure trace should be added to log so that people can
know better what happened. And this happened in hot adding side in
SPARSEMEM|!VMEMMAP case, the hot removing failed too in this case, I
will psot patch to fix it right away.

> 
> Fixes: ba72b4c8cf60 ("mm/sparsemem: support sub-section hotplug")
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> CC: Dan Williams <dan.j.williams@intel.com>
> ---
>  mm/sparse.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/sparse.c b/mm/sparse.c
> index 5a8599041a2a..2efb24ff8f96 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -882,7 +882,7 @@ int __meminit sparse_add_section(int nid, unsigned long start_pfn,
>  	 * Poison uninitialized struct pages in order to catch invalid flags
>  	 * combinations.
>  	 */
> -	page_init_poison(pfn_to_page(start_pfn), sizeof(struct page) * nr_pages);
> +	page_init_poison(memmap, sizeof(struct page) * nr_pages);
>  
>  	ms = __nr_to_section(section_nr);
>  	set_section_nid(section_nr, nid);
> -- 
> 2.17.1
> 

