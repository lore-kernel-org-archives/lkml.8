Return-Path: <SRS0=6uoK=35=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA311C352A4
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Feb 2020 13:50:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9003F20715
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Feb 2020 13:50:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EMbIWCTn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727752AbgBINu2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Feb 2020 08:50:28 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39824 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727631AbgBINu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Feb 2020 08:50:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581256227;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Udi2H1EwM2qQoiqz9yVbyKVFlwCemua0aBE5Wupm5+Q=;
        b=EMbIWCTnk9zCyYSb/iZhY7FEfxT3spkdKRggd2JFyBgqU2Cy/Ylsgq0WQxKO4BkmGrYxTz
        AtM4C0YxIbjzaQlNTVvYPRfoaacGg6LOoRQXvAm1vjZLOIK9Fl+L7slQMw4G/TYh6OYSiE
        bzzWZ3v/F7ip1FJ0V7IZaJxhWRXYv+E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-219-AHWhzolrOT27cMUr1QaVmg-1; Sun, 09 Feb 2020 08:50:23 -0500
X-MC-Unique: AHWhzolrOT27cMUr1QaVmg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CFB3F18B6382;
        Sun,  9 Feb 2020 13:50:21 +0000 (UTC)
Received: from localhost (ovpn-12-31.pek2.redhat.com [10.72.12.31])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9444187B0A;
        Sun,  9 Feb 2020 13:50:18 +0000 (UTC)
Date:   Sun, 9 Feb 2020 21:50:15 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Wei Yang <richardw.yang@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 2/3] mm/sparsemem: get physical address to page struct
 instead of virtual address to pfn
Message-ID: <20200209135015.GX8965@MiWiFi-R3L-srv>
References: <20200206231629.14151-1-richardw.yang@linux.intel.com>
 <20200206231629.14151-3-richardw.yang@linux.intel.com>
 <CAPcyv4h7dKE85EQ9jR1akXnT6PcG2M2g7YCCLqse=kKieP1H9w@mail.gmail.com>
 <20200207112632.5inklkwyiewhrd75@master>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200207112632.5inklkwyiewhrd75@master>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/07/20 at 11:26am, Wei Yang wrote:
> On Thu, Feb 06, 2020 at 06:19:46PM -0800, Dan Williams wrote:
> >On Thu, Feb 6, 2020 at 3:17 PM Wei Yang <richardw.yang@linux.intel.com> wrote:
> >>
> >> memmap should be the physical address to page struct instead of virtual
> >> address to pfn.
> >>
> >> Since we call this only for SPARSEMEM_VMEMMAP, pfn_to_page() is valid at
> >> this point.
> >>
> >> Fixes: ba72b4c8cf60 ("mm/sparsemem: support sub-section hotplug")
> >> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> >> CC: Dan Williams <dan.j.williams@intel.com>
> >> ---
> >>  mm/sparse.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/mm/sparse.c b/mm/sparse.c
> >> index b5da121bdd6e..56816f653588 100644
> >> --- a/mm/sparse.c
> >> +++ b/mm/sparse.c
> >> @@ -888,7 +888,7 @@ int __meminit sparse_add_section(int nid, unsigned long start_pfn,
> >>         /* Align memmap to section boundary in the subsection case */
> >>         if (IS_ENABLED(CONFIG_SPARSEMEM_VMEMMAP) &&
> >>                 section_nr_to_pfn(section_nr) != start_pfn)
> >> -               memmap = pfn_to_kaddr(section_nr_to_pfn(section_nr));
> >> +               memmap = pfn_to_page(section_nr_to_pfn(section_nr));
> >
> >Yes, this looks obviously correct. This might be tripping up
> >makedumpfile. Do you see any practical effects of this bug? The kernel
> >mostly avoids ->section_mem_map in the vmemmap case and in the
> >!vmemmap case section_nr_to_pfn(section_nr) should always equal
> >start_pfn.
> 
> I took another look into the code. Looks there is no practical effect after
> this. Because in the vmemmap case, we don't need ->section_mem_map to retrieve
> the real memmap.
> 
> But leave a inconsistent data in section_mem_map is not a good practice.

Yeah, it does has no pratical effect. I tried to create sub-section
alighed namespace, then trigger crash, makedumpfile isn't impacted.
Because pmem memory is only added, but not onlined. We don't report it
to kdump, makedumpfile will ignore it.

I think it's worth fixing it to encode a correct memmap address. We
don't know if in the future this will break anything.

Thanks
Baoquan

