Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8E0CC4BA12
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 13:07:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E3062467F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 13:07:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SN77YI4L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbgBZNHy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 08:07:54 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46930 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726592AbgBZNHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 08:07:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582722472;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=I9Ln/3T7qXcU74IlWJ1bBpZpKyU+byQv4hYuFlbZtOA=;
        b=SN77YI4Ld/0Itt0O1TKNQgVYI72CgqOXM0uk6jJhG81iokiIEvGcvHKnuVqW5QsaIsbSG2
        BPjF0ItqcUKmUzDSkLC1mF9YYPARQNcYeRsGn4LSLhMGixocDuYa84cSQ2VxX3YqhRPRSM
        5Fq96TPHd3hzGNDycVu0pLHOfKhNoCQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-232-o9q3gO2WPR-I-5yu0RIQLQ-1; Wed, 26 Feb 2020 08:07:49 -0500
X-MC-Unique: o9q3gO2WPR-I-5yu0RIQLQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 59C16800D48;
        Wed, 26 Feb 2020 13:07:47 +0000 (UTC)
Received: from localhost (ovpn-12-39.pek2.redhat.com [10.72.12.39])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A51325DA60;
        Wed, 26 Feb 2020 13:07:43 +0000 (UTC)
Date:   Wed, 26 Feb 2020 21:07:41 +0800
From:   Baoquan He <bhe@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, richardw.yang@linux.intel.com,
        osalvador@suse.de, dan.j.williams@intel.com, mhocko@suse.com,
        rppt@linux.ibm.com, robin.murphy@arm.com
Subject: Re: [PATCH v2 1/7] mm/hotplug: fix hot remove failure in
 SPARSEMEM|!VMEMMAP case
Message-ID: <20200226130741.GH24216@MiWiFi-R3L-srv>
References: <20200220043316.19668-1-bhe@redhat.com>
 <20200220043316.19668-2-bhe@redhat.com>
 <93280f63-bed7-9677-a7fa-8ea2089d26d2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93280f63-bed7-9677-a7fa-8ea2089d26d2@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/26/20 at 01:31pm, David Hildenbrand wrote:
> On 20.02.20 05:33, Baoquan He wrote:
> > In section_deactivate(), pfn_to_page() doesn't work any more after
> > ms->section_mem_map is resetting to NULL in SPARSEMEM|!VMEMMAP case.
> > It caused hot remove failure:
> > 
> > kernel BUG at mm/page_alloc.c:4806!
> > invalid opcode: 0000 [#1] SMP PTI
> > CPU: 3 PID: 8 Comm: kworker/u16:0 Tainted: G        W         5.5.0-next-20200205+ #340
> > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 0.0.0 02/06/2015
> > Workqueue: kacpi_hotplug acpi_hotplug_work_fn
> > RIP: 0010:free_pages+0x85/0xa0
> > Call Trace:
> >  __remove_pages+0x99/0xc0
> >  arch_remove_memory+0x23/0x4d
> >  try_remove_memory+0xc8/0x130
> >  ? walk_memory_blocks+0x72/0xa0
> >  __remove_memory+0xa/0x11
> >  acpi_memory_device_remove+0x72/0x100
> >  acpi_bus_trim+0x55/0x90
> >  acpi_device_hotplug+0x2eb/0x3d0
> >  acpi_hotplug_work_fn+0x1a/0x30
> >  process_one_work+0x1a7/0x370
> >  worker_thread+0x30/0x380
> >  ? flush_rcu_work+0x30/0x30
> >  kthread+0x112/0x130
> >  ? kthread_create_on_node+0x60/0x60
> >  ret_from_fork+0x35/0x40
> > 
> > Let's move the ->section_mem_map resetting after depopulate_section_memmap()
> > to fix it.
> > 
> 
> Fixes: Tag? Stable: Tag?

Right, should add these. Will add them. Thanks for noticing.

> 
> > Signed-off-by: Baoquan He <bhe@redhat.com>
> > ---
> >  mm/sparse.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/mm/sparse.c b/mm/sparse.c
> > index 596b2a45b100..b8e52c8fed7f 100644
> > --- a/mm/sparse.c
> > +++ b/mm/sparse.c
> > @@ -779,13 +779,15 @@ static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
> >  			ms->usage = NULL;
> >  		}
> >  		memmap = sparse_decode_mem_map(ms->section_mem_map, section_nr);
> > -		ms->section_mem_map = (unsigned long)NULL;
> >  	}
> >  
> >  	if (section_is_early && memmap)
> >  		free_map_bootmem(memmap);
> >  	else
> >  		depopulate_section_memmap(pfn, nr_pages, altmap);
> > +
> > +	if (bitmap_empty(subsection_map, SUBSECTIONS_PER_SECTION))
> > +		ms->section_mem_map = (unsigned long)NULL;
> >  }
> >  
> >  static struct page * __meminit section_activate(int nid, unsigned long pfn,
> > 
> 
> Reviewed-by: David Hildenbrand <david@redhat.com>
> 
> -- 
> Thanks,
> 
> David / dhildenb

