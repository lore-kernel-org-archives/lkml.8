Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B65DBC352A4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 07:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E45920733
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 07:54:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TSQ1toVe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727429AbgBJHyU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 02:54:20 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45736 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725468AbgBJHyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 02:54:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581321258;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XgLHa51B4K0w5LvvHzrXajltEAxAjyKabDg5eUISb44=;
        b=TSQ1toVeXYO7mZ6+xlC42LK3XY7GzA1SOaLg5bEqW2lUxaSldR1zroc4alZ/X47VeCE7bw
        fYuxgoqbPj7x0DcPKScDa2Wfw4OfpMlRT4FhIvrFq7LjRmex8rXryBCNxKksy0tDms2trb
        F1deQ09H6ORxAVvYX/vZhae1TQyy764=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-54-GVX0NUuzPkabOEQeyZpvpg-1; Mon, 10 Feb 2020 02:54:15 -0500
X-MC-Unique: GVX0NUuzPkabOEQeyZpvpg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DCF671005514;
        Mon, 10 Feb 2020 07:54:13 +0000 (UTC)
Received: from localhost (ovpn-12-27.pek2.redhat.com [10.72.12.27])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4F39E90061;
        Mon, 10 Feb 2020 07:54:09 +0000 (UTC)
Date:   Mon, 10 Feb 2020 15:54:06 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Wei Yang <richardw.yang@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, dan.j.williams@intel.com,
        david@redhat.com
Subject: Re: [PATCH 7/7] mm/hotplug: fix hot remove failure in
 SPARSEMEM|!VMEMMAP case
Message-ID: <20200210075406.GE8965@MiWiFi-R3L-srv>
References: <20200209104826.3385-1-bhe@redhat.com>
 <20200209104826.3385-8-bhe@redhat.com>
 <20200209235202.GC8705@richard>
 <20200210034105.GA8965@MiWiFi-R3L-srv>
 <20200210060804.GF7326@richard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200210060804.GF7326@richard>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/10/20 at 02:08pm, Wei Yang wrote:
> On Mon, Feb 10, 2020 at 11:41:05AM +0800, Baoquan He wrote:
> >On 02/10/20 at 07:52am, Wei Yang wrote:
> >> >---
> >> > mm/sparse.c | 4 +++-
> >> > 1 file changed, 3 insertions(+), 1 deletion(-)
> >> >
> >> >diff --git a/mm/sparse.c b/mm/sparse.c
> >> >index 623755e88255..345d065ef6ce 100644
> >> >--- a/mm/sparse.c
> >> >+++ b/mm/sparse.c
> >> >@@ -854,13 +854,15 @@ static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
> >> > 			ms->usage = NULL;
> >> > 		}
> >> > 		memmap = sparse_decode_mem_map(ms->section_mem_map, section_nr);
> >> >-		ms->section_mem_map = (unsigned long)NULL;
> >> > 	}
> >> > 
> >> > 	if (section_is_early && memmap)
> >> > 		free_map_bootmem(memmap);
> >> > 	else
> >> > 		depopulate_section_memmap(pfn, nr_pages, altmap);
> >> 
> >> The crash happens in depopulate_section_memmap() when trying to get memmap by
> >> pfn_to_page(). Can we pass memmap directly?
> >
> >Yes, that's also a good idea. While it needs to add a parameter for
> >depopulate_section_memmap(), the parameter is useless for VMEMMAP
> >though, I personally prefer the current fix which is a little simpler.
> >
> 
> Not a new parameter, but replace pfn with memmap.
> 
> Not sure why the parameter is useless for VMEMMAP? memmap will be assigned to
> start and finally pass to vmemmap_free().

In section_deactivate(), per the code comments from Dan, we can know
that:

	/*
	 * section which only contains bootmem will be handled by
	 * free_map_bootmem(), including a complete section, or partial
	 * section which only has memory starting from the begining.
	 */
        if (section_is_early && memmap)
                free_map_bootmem(memmap);                                                                                                         
        else
	/* 
	 * section which contains region mixing bootmem with hot added
	 * sub-section region, only sub-section region, complete
	 * section. And in the mxied case, if hot remove the hot added
	 * sub-section aligned part, no memmap is got in the current
	 * code. So we still need pfn to calculate it for vmemmap case.
	 * To me, whenever we need, it looks better that we always use
	 * pfn to get its own memmap. 
	 */
                depopulate_section_memmap(pfn, nr_pages, altmap);

This is why I would like to keep the current logic as is,only one line
of code adjusting can fix the issue. Please let me know if I miss
anything.


> 
> >Anyway, both is fine to me, I can update if you think passing memmap is
> >better.
> >
> >> 
> >> >+
> >> >+	if(!rc)
> >> >+		ms->section_mem_map = (unsigned long)NULL;
> >> > }
> >> > 
> >> > static struct page * __meminit section_activate(int nid, unsigned long pfn,
> >> >-- 
> >> >2.17.2
> >> 
> >> -- 
> >> Wei Yang
> >> Help you, Help me
> >> 
> 
> -- 
> Wei Yang
> Help you, Help me
> 

