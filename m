Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A165EC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 09:10:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 810002084C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 09:10:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbgGCJKG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 05:10:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:43230 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726269AbgGCJKF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 05:10:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8D1E3ADE4;
        Fri,  3 Jul 2020 09:10:03 +0000 (UTC)
Date:   Fri, 3 Jul 2020 11:10:01 +0200
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Gautham R Shenoy <ego@linux.vnet.ibm.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>,
        Mel Gorman <mgorman@suse.de>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev@lists.ozlabs.org, Christopher Lameter <cl@linux.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v5 3/3] mm/page_alloc: Keep memoryless cpuless node 0
 offline
Message-ID: <20200703091001.GJ21462@kitsune.suse.cz>
References: <20200624092846.9194-1-srikar@linux.vnet.ibm.com>
 <20200624092846.9194-4-srikar@linux.vnet.ibm.com>
 <20200701084200.GN2369@dhcp22.suse.cz>
 <20200701100442.GB17918@linux.vnet.ibm.com>
 <184102af-ecf2-c834-db46-173ab2e66f51@redhat.com>
 <20200701110145.GC17918@linux.vnet.ibm.com>
 <0468f965-8762-76a3-93de-3987cf859927@redhat.com>
 <12945273-d788-710d-e8d7-974966529c7d@redhat.com>
 <20200701122110.GT2369@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200701122110.GT2369@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 01, 2020 at 02:21:10PM +0200, Michal Hocko wrote:
> On Wed 01-07-20 13:30:57, David Hildenbrand wrote:
> > On 01.07.20 13:06, David Hildenbrand wrote:
> > > On 01.07.20 13:01, Srikar Dronamraju wrote:
> > >> * David Hildenbrand <david@redhat.com> [2020-07-01 12:15:54]:
> > >>
> > >>> On 01.07.20 12:04, Srikar Dronamraju wrote:
> > >>>> * Michal Hocko <mhocko@kernel.org> [2020-07-01 10:42:00]:
> > >>>>
> > >>>>>
> > >>>>>>
> > >>>>>> 2. Also existence of dummy node also leads to inconsistent information. The
> > >>>>>> number of online nodes is inconsistent with the information in the
> > >>>>>> device-tree and resource-dump
> > >>>>>>
> > >>>>>> 3. When the dummy node is present, single node non-Numa systems end up showing
> > >>>>>> up as NUMA systems and numa_balancing gets enabled. This will mean we take
> > >>>>>> the hit from the unnecessary numa hinting faults.
> > >>>>>
> > >>>>> I have to say that I dislike the node online/offline state and directly
> > >>>>> exporting that to the userspace. Users should only care whether the node
> > >>>>> has memory/cpus. Numa nodes can be online without any memory. Just
> > >>>>> offline all the present memory blocks but do not physically hot remove
> > >>>>> them and you are in the same situation. If users are confused by an
> > >>>>> output of tools like numactl -H then those could be updated and hide
> > >>>>> nodes without any memory&cpus.
> > >>>>>
> > >>>>> The autonuma problem sounds interesting but again this patch doesn't
> > >>>>> really solve the underlying problem because I strongly suspect that the
> > >>>>> problem is still there when a numa node gets all its memory offline as
> > >>>>> mentioned above.
> 
> I would really appreciate a feedback to these two as well.
> 
> > >>>>> While I completely agree that making node 0 special is wrong, I have
> > >>>>> still hard time to review this very simply looking patch because all the
> > >>>>> numa initialization is so spread around that this might just blow up
> > >>>>> at unexpected places. IIRC we have discussed testing in the previous
> > >>>>> version and David has provided a way to emulate these configurations
> > >>>>> on x86. Did you manage to use those instruction for additional testing
> > >>>>> on other than ppc architectures?
> > >>>>>
> > >>>>
> > >>>> I have tried all the steps that David mentioned and reported back at
> > >>>> https://lore.kernel.org/lkml/20200511174731.GD1961@linux.vnet.ibm.com/t/#u
> > >>>>
> > >>>> As a summary, David's steps are still not creating a memoryless/cpuless on
> > >>>> x86 VM.
> > >>>
> > >>> Now, that is wrong. You get a memoryless/cpuless node, which is *not
> > >>> online*. Once you hotplug some memory, it will switch online. Once you
> > >>> remove memory, it will switch back offline.
> > >>>
> > >>
> > >> Let me clarify, we are looking for a node 0 which is cpuless/memoryless at
> > >> boot.  The code in question tries to handle a cpuless/memoryless node 0 at
> > >> boot.
> > > 
> > > I was just correcting your statement, because it was wrong.
> > > 
> > > Could be that x86 code maps PXM 1 to node 0 because PXM 1 does neither
> > > have CPUs nor memory. That would imply that we can, in fact, never have
> > > node 0 offline during boot.
> > > 
> > 
> > Yep, looks like it.
> > 
> > [    0.009726] SRAT: PXM 1 -> APIC 0x00 -> Node 0
> > [    0.009727] SRAT: PXM 1 -> APIC 0x01 -> Node 0
> > [    0.009727] SRAT: PXM 1 -> APIC 0x02 -> Node 0
> > [    0.009728] SRAT: PXM 1 -> APIC 0x03 -> Node 0
> > [    0.009731] ACPI: SRAT: Node 0 PXM 1 [mem 0x00000000-0x0009ffff]
> > [    0.009732] ACPI: SRAT: Node 0 PXM 1 [mem 0x00100000-0xbfffffff]
> > [    0.009733] ACPI: SRAT: Node 0 PXM 1 [mem 0x100000000-0x13fffffff]
> 
> This begs a question whether ppc can do the same thing?
Or x86 stop doing it so that you can see on what node you are running?

What's the point of this indirection other than another way of avoiding
empty node 0?

Thanks

Michal
