Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 084CBC35247
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 03:10:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C39D621D7D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 03:10:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="INKYZ4Nx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbgBGDKV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 22:10:21 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:28926 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726509AbgBGDKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 22:10:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581045020;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ewJLTC6LRmSKJd248CeUIvVW+fCQGBNVg2u0Qpt8QYU=;
        b=INKYZ4NxGJvRlPPArc1eQ/a4Ew7nplHrG6JLGJu9j/tLTvmnteb6qMhbgGbrfNX/Av1X2u
        F2+psqfz2hc0nLAqXaBV+3vNqXg0bNG62W9xPKQBzW17RbW8oLYnpvY4wnZlqM5RtbpvAd
        I361BUfE76FZWO1SolBB5rLrLiUevQY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-45-7_6eto-FNlqE8-gl1Fjh0A-1; Thu, 06 Feb 2020 22:10:19 -0500
X-MC-Unique: 7_6eto-FNlqE8-gl1Fjh0A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7AC661084420;
        Fri,  7 Feb 2020 03:10:17 +0000 (UTC)
Received: from localhost (ovpn-12-30.pek2.redhat.com [10.72.12.30])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5334910016DA;
        Fri,  7 Feb 2020 03:10:14 +0000 (UTC)
Date:   Fri, 7 Feb 2020 11:10:11 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Wei Yang <richardw.yang@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 2/3] mm/sparsemem: get physical address to page struct
 instead of virtual address to pfn
Message-ID: <20200207031011.GR8965@MiWiFi-R3L-srv>
References: <20200206231629.14151-1-richardw.yang@linux.intel.com>
 <20200206231629.14151-3-richardw.yang@linux.intel.com>
 <CAPcyv4h7dKE85EQ9jR1akXnT6PcG2M2g7YCCLqse=kKieP1H9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4h7dKE85EQ9jR1akXnT6PcG2M2g7YCCLqse=kKieP1H9w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

On 02/06/20 at 06:19pm, Dan Williams wrote:
> On Thu, Feb 6, 2020 at 3:17 PM Wei Yang <richardw.yang@linux.intel.com> wrote:
> > diff --git a/mm/sparse.c b/mm/sparse.c
> > index b5da121bdd6e..56816f653588 100644
> > --- a/mm/sparse.c
> > +++ b/mm/sparse.c
> > @@ -888,7 +888,7 @@ int __meminit sparse_add_section(int nid, unsigned long start_pfn,
> >         /* Align memmap to section boundary in the subsection case */
> >         if (IS_ENABLED(CONFIG_SPARSEMEM_VMEMMAP) &&
> >                 section_nr_to_pfn(section_nr) != start_pfn)
> > -               memmap = pfn_to_kaddr(section_nr_to_pfn(section_nr));
> > +               memmap = pfn_to_page(section_nr_to_pfn(section_nr));
> 
> Yes, this looks obviously correct. This might be tripping up
> makedumpfile. Do you see any practical effects of this bug? The kernel
> mostly avoids ->section_mem_map in the vmemmap case and in the
> !vmemmap case section_nr_to_pfn(section_nr) should always equal
> start_pfn.

The practical effects is that the memmap for the first unaligned section will be lost
when destroy namespace to hot remove it. Because we encode the ->section_mem_map
into mem_section, and get memmap from the related mem_section to free it in
section_deactivate(). In fact in vmemmap, we don't need to encode the ->section_mem_map
with memmap.

By the way, sub-section support is only valid in vmemmap case, right?
Seems yes from code, but I don't find any document to prove it.

Thanks
Baoquan

