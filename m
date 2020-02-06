Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10A35C352A1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 01:46:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA23920658
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 01:46:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RlzdZLPU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727605AbgBFBq4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 20:46:56 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:54116 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727170AbgBFBqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 20:46:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580953614;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QFMZVwYTnIpL7fCFcXZb1GizaNxHu6MTVpIRsyiA0gQ=;
        b=RlzdZLPUl5L2d8CZkKUhvMdXjAGtEhk29SH/M0EZcTTNWSaopmSUMZxb4RR8EgsQY7hnzz
        o3az559rtRnNWG64hEpWZUavLF7q2UEEr/Y87EA/XvnJjFndVJoledf0kUvi7XzpBOi7Fj
        CAO0KPIe7dHRdxRgt2K15w7XtybFdiw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-213-FQ5uAGHWOuGLBy3AOFBdww-1; Wed, 05 Feb 2020 20:46:50 -0500
X-MC-Unique: FQ5uAGHWOuGLBy3AOFBdww-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B9A4F10753F3;
        Thu,  6 Feb 2020 01:46:48 +0000 (UTC)
Received: from localhost (ovpn-12-19.pek2.redhat.com [10.72.12.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F0B271A7E3;
        Thu,  6 Feb 2020 01:46:45 +0000 (UTC)
Date:   Thu, 6 Feb 2020 09:46:42 +0800
From:   Baoquan He <bhe@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Wei Yang <richardw.yang@linux.intel.com>
Subject: Re: [PATCH v1] mm/memory_hotplug: Easier calculation to get pages to
 next section boundary
Message-ID: <20200206014642.GJ8965@MiWiFi-R3L-srv>
References: <20200205135251.37488-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200205135251.37488-1-david@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/05/20 at 02:52pm, David Hildenbrand wrote:
> Let's use a calculation that's easier to understand and calculates the
> same result. Reusing existing macros makes this look nicer.
> 
> We always want to have the number of pages (> 0) to the next section
> boundary, starting from the current pfn.
> 
> Suggested-by: Segher Boessenkool <segher@kernel.crashing.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Wei Yang <richardw.yang@linux.intel.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

LGTM.

Reviewed-by: Baoquan He <bhe@redhat.com>

> ---
>  mm/memory_hotplug.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 0a54ffac8c68..c30191183c04 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -528,7 +528,8 @@ void __remove_pages(unsigned long pfn, unsigned long nr_pages,
>  	for (; pfn < end_pfn; pfn += cur_nr_pages) {
>  		cond_resched();
>  		/* Select all remaining pages up to the next section boundary */
> -		cur_nr_pages = min(end_pfn - pfn, -(pfn | PAGE_SECTION_MASK));
> +		cur_nr_pages = min(end_pfn - pfn,
> +				   SECTION_ALIGN_UP(pfn + 1) - pfn);
>  		__remove_section(pfn, cur_nr_pages, map_offset, altmap);
>  		map_offset = 0;
>  	}
> -- 
> 2.24.1
> 

