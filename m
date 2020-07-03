Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55409C433E1
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 11:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B93620737
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 11:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593776769;
	bh=j1VNZR18REsx8bsPsQossvdCOXZE1cun2AuroPzRoiQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LB6nEBraYF0JbszemyfSoM3OJjNtipz4bknPf5yBZZNBMP/HIKv53n6X+CfIhPdV8
	 J+HFnO8J3oVQon5EO8nhAnEXGX3ffW/s7vbDNxfIXiWvrQzttmoBlF0EGp1wSNUDAE
	 9vO/4MIwERU/DFt+P0lR7hkSvJtCKetd+l8qt7V8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbgGCLqH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 07:46:07 -0400
Received: from mail-ej1-f68.google.com ([209.85.218.68]:35349 "EHLO
        mail-ej1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725984AbgGCLqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 07:46:07 -0400
Received: by mail-ej1-f68.google.com with SMTP id rk21so33891934ejb.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jul 2020 04:46:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zOLRTXypBkGKl2kAvzwg2amrLm3xJsaPOJq55Ci040U=;
        b=m/LSdx/K8RjwptzjtIDhVxi4kVODmaNAAVAchtVg3wkHzBgf3NX5vCbzJeTPsMHkBJ
         VqH+PKQhX0/ikClo119YOsnl7yvAarsUelxDsJQrD6cCjfZJZj2mUmkq3Fppi+EAh6FM
         jn9wBHRPFOoJaJCdYE72VQPZFj77IU9PPk9Tod6baxyjkM6r5bdl7vaYl2TNZeV0h5SF
         55++mehcNoOyAnU7TgK1pRn6IucS1Im5o3NCTxR9tcZj7BTz6u3bVP9SRxeGbnWFNPRx
         dpxhKYgA7KXFkUkyuGHZJSTDZyB/jn8JT7usrnI9zJiu4S30bZGzmNPYqezH9cP0yfKz
         UBag==
X-Gm-Message-State: AOAM5313C88Obi4ggJoLwn/RvqMMv0sUDQC/0YHh4/JLA22v2w9ZAlj0
        mtHR6uUFG9vfGOWBwaP2Fr8=
X-Google-Smtp-Source: ABdhPJxiZQ+sUtrLEOAAu4uB/rZ3Td5hYf/PfImH7X4Ib//AJK5+KRVTJibstj3un/6PbX49VNYjpQ==
X-Received: by 2002:a17:906:3945:: with SMTP id g5mr33887273eje.549.1593776765299;
        Fri, 03 Jul 2020 04:46:05 -0700 (PDT)
Received: from localhost (ip-37-188-168-3.eurotel.cz. [37.188.168.3])
        by smtp.gmail.com with ESMTPSA id dj22sm750086edb.54.2020.07.03.04.46.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2020 04:46:04 -0700 (PDT)
Date:   Fri, 3 Jul 2020 13:46:03 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>,
        Gautham R Shenoy <ego@linux.vnet.ibm.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>,
        Mel Gorman <mgorman@suse.de>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev@lists.ozlabs.org, Christopher Lameter <cl@linux.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v5 3/3] mm/page_alloc: Keep memoryless cpuless node 0
 offline
Message-ID: <20200703114603.GU18446@dhcp22.suse.cz>
References: <20200701100442.GB17918@linux.vnet.ibm.com>
 <184102af-ecf2-c834-db46-173ab2e66f51@redhat.com>
 <20200701110145.GC17918@linux.vnet.ibm.com>
 <0468f965-8762-76a3-93de-3987cf859927@redhat.com>
 <12945273-d788-710d-e8d7-974966529c7d@redhat.com>
 <20200701122110.GT2369@dhcp22.suse.cz>
 <20200703091001.GJ21462@kitsune.suse.cz>
 <20200703092414.GR18446@dhcp22.suse.cz>
 <20200703105944.GS18446@dhcp22.suse.cz>
 <3f926058-cabc-94d0-0f92-4e966ea4cdc3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f926058-cabc-94d0-0f92-4e966ea4cdc3@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 03-07-20 13:32:21, David Hildenbrand wrote:
> On 03.07.20 12:59, Michal Hocko wrote:
> > On Fri 03-07-20 11:24:17, Michal Hocko wrote:
> >> [Cc Andi]
> >>
> >> On Fri 03-07-20 11:10:01, Michal Suchanek wrote:
> >>> On Wed, Jul 01, 2020 at 02:21:10PM +0200, Michal Hocko wrote:
> >>>> On Wed 01-07-20 13:30:57, David Hildenbrand wrote:
> >> [...]
> >>>>> Yep, looks like it.
> >>>>>
> >>>>> [    0.009726] SRAT: PXM 1 -> APIC 0x00 -> Node 0
> >>>>> [    0.009727] SRAT: PXM 1 -> APIC 0x01 -> Node 0
> >>>>> [    0.009727] SRAT: PXM 1 -> APIC 0x02 -> Node 0
> >>>>> [    0.009728] SRAT: PXM 1 -> APIC 0x03 -> Node 0
> >>>>> [    0.009731] ACPI: SRAT: Node 0 PXM 1 [mem 0x00000000-0x0009ffff]
> >>>>> [    0.009732] ACPI: SRAT: Node 0 PXM 1 [mem 0x00100000-0xbfffffff]
> >>>>> [    0.009733] ACPI: SRAT: Node 0 PXM 1 [mem 0x100000000-0x13fffffff]
> >>>>
> >>>> This begs a question whether ppc can do the same thing?
> >>> Or x86 stop doing it so that you can see on what node you are running?
> >>>
> >>> What's the point of this indirection other than another way of avoiding
> >>> empty node 0?
> >>
> >> Honestly, I do not have any idea. I've traced it down to
> >> Author: Andi Kleen <ak@suse.de>
> >> Date:   Tue Jan 11 15:35:48 2005 -0800
> >>
> >>     [PATCH] x86_64: Fix ACPI SRAT NUMA parsing
> >>
> >>     Fix fallout from the recent nodemask_t changes. The node ids assigned
> >>     in the SRAT parser were off by one.
> >>
> >>     I added a new first_unset_node() function to nodemask.h to allocate
> >>     IDs sanely.
> >>
> >>     Signed-off-by: Andi Kleen <ak@suse.de>
> >>     Signed-off-by: Linus Torvalds <torvalds@osdl.org>
> >>
> >> which doesn't really tell all that much. The historical baggage and a
> >> long term behavior which is not really trivial to fix I suspect.
> > 
> > Thinking about this some more, this logic makes some sense afterall.
> > Especially in the world without memory hotplug which was very likely the
> > case back then. It is much better to have compact node mask rather than
> > sparse one. After all node numbers shouldn't really matter as long as
> > you have a clear mapping to the HW. I am not sure we export that
> > information (except for the kernel ring buffer) though.
> > 
> > The memory hotplug changes that somehow because you can hotremove numa
> > nodes and therefore make the nodemask sparse but that is not a common
> > case. I am not sure what would happen if a completely new node was added
> > and its corresponding node was already used by the renumbered one
> > though. It would likely conflate the two I am afraid. But I am not sure
> > this is really possible with x86 and a lack of a bug report would
> > suggest that nobody is doing that at least.
> > 
> 
> I think the ACPI code takes care of properly mapping PXM to nodes.
> 
> So if I start with PXM 0 empty and PXM 1 populated, I will get
> PXM 1 == node 0 as described. Once I hotplug something to PXM 0 in QEMU
> 
> $ echo "object_add memory-backend-ram,id=mem0,size=1G" | sudo nc -U /var/tmp/monitor
> $ echo "device_add pc-dimm,id=dimm0,memdev=mem0,node=0" | sudo nc -U /var/tmp/monitor
> 
> $ echo "info numa" | sudo nc -U /var/tmp/monitor
> QEMU 5.0.50 monitor - type 'help' for more information
> (qemu) info numa
> 2 nodes
> node 0 cpus:
> node 0 size: 1024 MB
> node 0 plugged: 1024 MB
> node 1 cpus: 0 1 2 3
> node 1 size: 4096 MB
> node 1 plugged: 0 MB

Thanks for double checking.

> I get in the guest:
> 
> [   50.174435] ------------[ cut here ]------------
> [   50.175436] node 1 was absent from the node_possible_map
> [   50.176844] WARNING: CPU: 0 PID: 7 at mm/memory_hotplug.c:1021 add_memory_resource+0x8c/0x290

This would mean that the ACPI code or whoever does the remaping is not
adding the new node into possible nodes.

[...]
> I remember that we added that check just recently (due to powerpc if I am not wrong).
> Not sure why that triggers here.

This was a misbehaving Qemu IIRC providing a garbage map.

-- 
Michal Hocko
SUSE Labs
