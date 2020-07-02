Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65ED5C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 10:03:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48C1F2084C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 10:03:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728264AbgGBKDk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 06:03:40 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2423 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727819AbgGBKDj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 06:03:39 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 2BA29EFAB6232256022B;
        Thu,  2 Jul 2020 11:03:38 +0100 (IST)
Received: from localhost (10.52.121.38) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1913.5; Thu, 2 Jul 2020
 11:03:37 +0100
Date:   Thu, 2 Jul 2020 11:02:35 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     David Rientjes <rientjes@google.com>
CC:     Yang Shi <yang.shi@linux.alibaba.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <kbusch@kernel.org>, <ying.huang@intel.com>,
        <dan.j.williams@intel.com>
Subject: Re: [RFC][PATCH 3/8] mm/vmscan: Attempt to migrate page in lieu of
 discard
Message-ID: <20200702110235.00005f2f@Huawei.com>
In-Reply-To: <alpine.DEB.2.23.453.2007011226240.1908531@chino.kir.corp.google.com>
References: <20200629234503.749E5340@viggo.jf.intel.com>
        <20200629234509.8F89C4EF@viggo.jf.intel.com>
        <alpine.DEB.2.22.394.2006301732010.1644114@chino.kir.corp.google.com>
        <039a5704-4468-f662-d660-668071842ca3@linux.alibaba.com>
        <alpine.DEB.2.22.394.2006302208460.1685201@chino.kir.corp.google.com>
        <33028a57-24fd-e618-7d89-5f35a35a6314@linux.alibaba.com>
        <alpine.DEB.2.23.453.2007011226240.1908531@chino.kir.corp.google.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.121.38]
X-ClientProxiedBy: lhreml709-chm.china.huawei.com (10.201.108.58) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Jul 2020 12:45:17 -0700
David Rientjes <rientjes@google.com> wrote:

> On Wed, 1 Jul 2020, Yang Shi wrote:
> 
> > > We can do this if we consider pmem not to be a separate memory tier from
> > > the system perspective, however, but rather the socket perspective.  In
> > > other words, a node can only demote to a series of exclusive pmem ranges
> > > and promote to the same series of ranges in reverse order.  So DRAM node 0
> > > can only demote to PMEM node 2 while DRAM node 1 can only demote to PMEM
> > > node 3 -- a pmem range cannot be demoted to, or promoted from, more than
> > > one DRAM node.
> > > 
> > > This naturally takes care of mbind() and cpuset.mems if we consider pmem
> > > just to be slower volatile memory and we don't need to deal with the
> > > latency concerns of cross socket migration.  A user page will never be
> > > demoted to a pmem range across the socket and will never be promoted to a
> > > different DRAM node that it doesn't have access to.  
> > 
> > But I don't see too much benefit to limit the migration target to the
> > so-called *paired* pmem node. IMHO it is fine to migrate to a remote (on a
> > different socket) pmem node since even the cross socket access should be much
> > faster then refault or swap from disk.
> >   
> 
> Hi Yang,
> 
> Right, but any eventual promotion path would allow this to subvert the 
> user mempolicy or cpuset.mems if the demoted memory is eventually promoted 
> to a DRAM node on its socket.  We've discussed not having the ability to 
> map from the demoted page to either of these contexts and it becomes more 
> difficult for shared memory.  We have page_to_nid() and page_zone() so we 
> can always find the appropriate demotion or promotion node for a given 
> page if there is a 1:1 relationship.
> 
> Do we lose anything with the strict 1:1 relationship between DRAM and PMEM 
> nodes?  It seems much simpler in terms of implementation and is more 
> intuitive.
Hi David, Yang,

The 1:1 mapping implies a particular system topology.  In the medium
term we are likely to see systems with a central pool of persistent memory
with equal access characteristics from multiple CPU containing nodes, each
with local DRAM. 

Clearly we could fake a split of such a pmem pool to keep the 1:1 mapping
but it's certainly not elegant and may be very wasteful for resources.

Can a zone based approach work well without such a hard wall?

Jonathan

> 
> > I think using pmem as a node is more natural than zone and less intrusive
> > since we can just reuse all the numa APIs. If we treat pmem as a new zone I
> > think the implementation may be more intrusive and complicated (i.e. need a
> > new gfp flag) and user can't control the memory placement.
> >   
> 
> This is an important decision to make, I'm not sure that we actually 
> *want* all of these NUMA APIs :)  If my memory is demoted, I can simply do 
> migrate_pages() back to DRAM and cause other memory to be demoted in its 
> place.  Things like MPOL_INTERLEAVE over nodes {0,1,2} don't make sense.  
> Kswapd for a DRAM node putting pressure on a PMEM node for demotion that 
> then puts the kswapd for the PMEM node under pressure to reclaim it serves 
> *only* to spend unnecessary cpu cycles.
> 
> Users could control the memory placement through a new mempolicy flag, 
> which I think are needed anyway for explicit allocation policies for PMEM 
> nodes.  Consider if PMEM is a zone so that it has the natural 1:1 
> relationship with DRAM, now your system only has nodes {0,1} as today, no 
> new NUMA topology to consider, and a mempolicy flag MPOL_F_TOPTIER that 
> specifies memory must be allocated from ZONE_MOVABLE or ZONE_NORMAL (and I 
> can then mlock() if I want to disable demotion on memory pressure).
> 


