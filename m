Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9EF2C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 07:09:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73EB2208E4
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 07:09:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DpyFsdCB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388898AbgDCHJT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 03:09:19 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:34485 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730550AbgDCHJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 03:09:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585897758;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TUShErNk8cwU7hJf8BxmK0K5c6pEQ4hGGKwc5zmiaaw=;
        b=DpyFsdCBBAPnnPBQEEqxC7y4nxlol9/XgIFm3seGuP41Yl6AhXF3itCz3//LHzhGzUyn9L
        G6U3zAfTIvMCVF/9U2RTnITO60F+bLnFu05FP2xd/DyqDKDfRLRakrx0bwhSIRQD5Up+XQ
        t0YI5ibSuTRk5UQsTusXqWKincM7Fps=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-63-Cvy3b_roPf66oPbJTVFQdA-1; Fri, 03 Apr 2020 03:09:13 -0400
X-MC-Unique: Cvy3b_roPf66oPbJTVFQdA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2400818A6EC1;
        Fri,  3 Apr 2020 07:09:09 +0000 (UTC)
Received: from localhost (ovpn-12-42.pek2.redhat.com [10.72.12.42])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 115A11147D2;
        Fri,  3 Apr 2020 07:09:07 +0000 (UTC)
Date:   Fri, 3 Apr 2020 15:09:04 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Hoan Tran <hoan@os.amperecomputing.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Oscar Salvador <osalvador@suse.de>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "David S. Miller" <davem@davemloft.net>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, x86@kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        lho@amperecomputing.com, mmorana@amperecomputing.com
Subject: Re: [PATCH v3 0/5] mm: Enable CONFIG_NODES_SPAN_OTHER_NODES by
 default for NUMA
Message-ID: <20200403070904.GO2402@MiWiFi-R3L-srv>
References: <1585420282-25630-1-git-send-email-Hoan@os.amperecomputing.com>
 <20200330074246.GA14243@dhcp22.suse.cz>
 <20200330175100.GD30942@linux.ibm.com>
 <20200330182301.GM14243@dhcp22.suse.cz>
 <20200331081423.GE30942@linux.ibm.com>
 <20200331085513.GE30449@dhcp22.suse.cz>
 <20200331140332.GA2129@MiWiFi-R3L-srv>
 <20200331142138.GL30449@dhcp22.suse.cz>
 <20200331143140.GA2402@MiWiFi-R3L-srv>
 <cc717f09-2b18-b242-e438-3ec730c5dac0@os.amperecomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc717f09-2b18-b242-e438-3ec730c5dac0@os.amperecomputing.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/02/20 at 09:46pm, Hoan Tran wrote:
> Hi All,
> 
> On 3/31/20 7:31 AM, Baoquan He wrote:
> > On 03/31/20 at 04:21pm, Michal Hocko wrote:
> > > On Tue 31-03-20 22:03:32, Baoquan He wrote:
> > > > Hi Michal,
> > > > 
> > > > On 03/31/20 at 10:55am, Michal Hocko wrote:
> > > > > On Tue 31-03-20 11:14:23, Mike Rapoport wrote:
> > > > > > Maybe I mis-read the code, but I don't see how this could happen. In the
> > > > > > HAVE_MEMBLOCK_NODE_MAP=y case, free_area_init_node() calls
> > > > > > calculate_node_totalpages() that ensures that node->node_zones are entirely
> > > > > > within the node because this is checked in zone_spanned_pages_in_node().
> > > > > 
> > > > > zone_spanned_pages_in_node does chech the zone boundaries are within the
> > > > > node boundaries. But that doesn't really tell anything about other
> > > > > potential zones interleaving with the physical memory range.
> > > > > zone->spanned_pages simply gives the physical range for the zone
> > > > > including holes. Interleaving nodes are essentially a hole
> > > > > (__absent_pages_in_range is going to skip those).
> > > > > 
> > > > > That means that when free_area_init_core simply goes over the whole
> > > > > physical zone range including holes and that is why we need to check
> > > > > both for physical and logical holes (aka other nodes).
> > > > > 
> > > > > The life would be so much easier if the whole thing would simply iterate
> > > > > over memblocks...
> > > > 
> > > > The memblock iterating sounds a great idea. I tried with putting the
> > > > memblock iterating in the upper layer, memmap_init(), which is used for
> > > > boot mem only anyway. Do you think it's doable and OK? It yes, I can
> > > > work out a formal patch to make this simpler as you said. The draft code
> > > > is as below. Like this it uses the existing code and involves little change.
> > > 
> > > Doing this would be a step in the right direction! I haven't checked the
> > > code very closely though. The below sounds way too simple to be truth I
> > > am afraid. First for_each_mem_pfn_range is available only for
> > > CONFIG_HAVE_MEMBLOCK_NODE_MAP (which is one of the reasons why I keep
> > > saying that I really hate that being conditional). Also I haven't really
> > > checked the deferred initialization path - I have a very vague
> > > recollection that it has been converted to the memblock api but I have
> > > happilly dropped all that memory.
> > 
> > Thanks for your quick response and pointing out the rest suspect aspects,
> > I will investigate what you mentioned, see if they impact.
> 
> I would like to check if we still move on with my patch to remove
> CONFIG_NODES_SPAN_OTHER_NODES and have another patch on top it?

I think we would like to replace CONFIG_NODES_SPAN_OTHER_NODES with
CONFIG_NUMA, and just let UMA return 0 as node id, as Michal replied in
another mail. Anyway, your patch 2~5 are still needed to sit on top of
the change of this new plan.

