Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4513EC10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 13:18:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E65B22525
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 13:18:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hmfQfJvs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbgCINSe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 09:18:34 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:22260 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725956AbgCINSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 09:18:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583759912;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1K5R56oPivAmrjTNpcDkpowCNoJPz3om5lUYieNs7Bw=;
        b=hmfQfJvs2kq+xY3ZzfGOA4w8iCBI+88wwb7I0jLGJ05kGmd1XbBW9umub/+KAN/SrEUh4e
        zm5sEZeaVxWxbKzKFV71PCjyN4DQIj/La7rZCOtyl255FfDXtg0o5OI4PN0QmYAQZxk8RP
        apaHEd1+fPEilykI4+sJLmOgQ7uscWw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-197-Qr1mgu6CMmm_3by9S08W0Q-1; Mon, 09 Mar 2020 09:18:29 -0400
X-MC-Unique: Qr1mgu6CMmm_3by9S08W0Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2C4F08010D9;
        Mon,  9 Mar 2020 13:18:26 +0000 (UTC)
Received: from localhost (ovpn-12-179.pek2.redhat.com [10.72.12.179])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B8BB48882D;
        Mon,  9 Mar 2020 13:18:16 +0000 (UTC)
Date:   Mon, 9 Mar 2020 21:18:12 +0800
From:   Baoquan He <bhe@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, mhocko@suse.com,
        richardw.yang@linux.intel.com, dan.j.williams@intel.com,
        osalvador@suse.de, rppt@linux.ibm.com
Subject: Re: [PATCH v3 1/7] mm/hotplug: fix hot remove failure in
 SPARSEMEM|!VMEMMAP case
Message-ID: <20200309131812.GN4937@MiWiFi-R3L-srv>
References: <20200307084229.28251-1-bhe@redhat.com>
 <20200307084229.28251-2-bhe@redhat.com>
 <b0ff37b3-bae1-bdd6-8a4f-62f03e028839@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0ff37b3-bae1-bdd6-8a4f-62f03e028839@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/09/20 at 09:58am, David Hildenbrand wrote:
> On 07.03.20 09:42, Baoquan He wrote:
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
> > Fixes: ba72b4c8cf60 ("mm/sparsemem: support sub-section hotplug")
> > Signed-off-by: Baoquan He <bhe@redhat.com>
> > Cc: stable@vger.kernel.org
> > ---
> >  mm/sparse.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> > 
> > diff --git a/mm/sparse.c b/mm/sparse.c
> > index 42c18a38ffaa..1b50c15677d7 100644
> > --- a/mm/sparse.c
> > +++ b/mm/sparse.c
> > @@ -734,6 +734,7 @@ static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
> >  	struct mem_section *ms = __pfn_to_section(pfn);
> >  	bool section_is_early = early_section(ms);
> >  	struct page *memmap = NULL;
> > +	bool empty = false;
> 
> Oh, one NIT: no need to initialize empty to false.

Thanks for careful reviewing, David.

Not very sure about this, do you have a doc or discussion thread about
not initializing local variable? Maybe Andrew can help update it if this
is not suggested. 

