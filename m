Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13A31C4BA0A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 03:44:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6AE42067C
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 03:44:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JgKIMjah"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbgBZDop (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 22:44:45 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:25794 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726024AbgBZDop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 22:44:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582688684;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=g4gojvp3vC3N2CngBOtMsPIUT4YDPupheuU+NRdhvhM=;
        b=JgKIMjahHNKVmPvxwU+G8EZgwvxV119uu/8PskdipBPDOzxv0LIBE/ADLN4En1Ol+v9FdA
        ETLsaufXa+d8CiTXLWCinMMMZr3cl044eV1FWXH9mqoYfR5All6cmrs9DrYQAnzKr8TdAA
        CjAi0249SCtWYMq9Y/pCN7zSRWz6wiA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-143-WJgVg_aSNIeoVPp7BnFFgA-1; Tue, 25 Feb 2020 22:44:42 -0500
X-MC-Unique: WJgVg_aSNIeoVPp7BnFFgA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8117E107ACC5;
        Wed, 26 Feb 2020 03:44:40 +0000 (UTC)
Received: from localhost (ovpn-12-39.pek2.redhat.com [10.72.12.39])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DB16590519;
        Wed, 26 Feb 2020 03:44:36 +0000 (UTC)
Date:   Wed, 26 Feb 2020 11:44:33 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, richardw.yang@linux.intel.com,
        david@redhat.com, osalvador@suse.de, dan.j.williams@intel.com,
        rppt@linux.ibm.com, robin.murphy@arm.com
Subject: Re: [PATCH v2 0/7] mm/hotplug: Only use subsection map in VMEMMAP
 case
Message-ID: <20200226034433.GE24216@MiWiFi-R3L-srv>
References: <20200220043316.19668-1-bhe@redhat.com>
 <20200220103849.GG20509@dhcp22.suse.cz>
 <20200221142847.GG4937@MiWiFi-R3L-srv>
 <20200225100352.GN22443@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200225100352.GN22443@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/25/20 at 11:03am, Michal Hocko wrote:
> On Fri 21-02-20 22:28:47, Baoquan He wrote:
> > On 02/20/20 at 11:38am, Michal Hocko wrote:
> > > On Thu 20-02-20 12:33:09, Baoquan He wrote:
> > > > Memory sub-section hotplug was added to fix the issue that nvdimm could
> > > > be mapped at non-section aligned starting address. A subsection map is
> > > > added into struct mem_section_usage to implement it. However, sub-section
> > > > is only supported in VMEMMAP case.
> > > 
> > > Why? Is there any fundamental reason or just a lack of implementation?
> > > VMEMMAP should be really only an implementation detail unless I am
> > > missing something subtle.
> > 
> > Thanks for checking.
> > 
> > VMEMMAP is one of two ways to convert a PFN to the corresponding
> > 'struct page' in SPARSE model. I mentioned them as VMEMMAP case, or
> > !VMEMMAP case because we called them like this previously when reviewed
> > patches, hope it won't cause confusion.
> > 
> > Currently, config ZONE_DEVICE depends on SPARSEMEM_VMEMMAP. The
> > subsection_map is added to struct mem_section_usage to track which sub
> > section is present, VMEMMAP fills those bits which corresponding
> > sub-sections are present, while !VMEMMAP, namely classic SPARSE, fills
> > the whole map always.
> > 
> > As we know, VMEMMAP builds page table to map a cluster of 'struct page'
> > into the corresponding area of 'vmemmap'. Subsection hotplug can be
> > supported naturally, w/o any change, just map needed region related to
> > sub-sections on demand. For !VMEMMAP, it allocates memmap with
> > alloc_pages() or vmalloc, thing is a little complicated, e.g the mixed
> > section, boot memory occupies the starting area, later pmem hot added to
> > the rear part.
> > 
> > About !VMEMMAP which doesn't support sub-section hotplog, Dan said 
> > it's more because the effort and maintenance burden outweighs the
> > benefit. And the current 64 bit ARCHes all enable
> > SPARSEMEM_VMEMMAP_ENABLE by default.
> 
> OK, if this is the primary argument then make sure to document it in the
> changelog (cover letter).

Will add it when repost.

