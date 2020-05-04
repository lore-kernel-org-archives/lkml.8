Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 951D5C47257
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 09:37:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F8B4206D9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 09:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588585038;
	bh=0lYxspjaMoDGUXxXy8dqrvw/yuh9UvAHfJd+Y4RkbZw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=l5btOW6ZNJpymdeZILlEkmueZWi6A0KlsivF1JwFlLLyNW8e1o5+kEyfUwcX6f9gN
	 MW5atFu+WVJiCq4roKgVKe7iGyaASzAcrdpGJb/OTq5VwpEUFP4wN2goQo2puEmzzz
	 e1jnB2sWgYCwXAexKEb7zqV/aeQEk+odhasfkuOc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728395AbgEDJhR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 05:37:17 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39571 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728254AbgEDJhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 05:37:17 -0400
Received: by mail-wm1-f68.google.com with SMTP id y24so8266552wma.4
        for <linux-kernel@vger.kernel.org>; Mon, 04 May 2020 02:37:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xShnDcExFWUimqBCgUn/sr5omAC3qqGsdXHfhGb4bfY=;
        b=ijl16MNuYM7GA/Vz/AKuijPoAHqFgCXYWRb23a3P61G1TehSf+mjy54VdvJ39xc9wR
         bf8ivKBDgRaka2bDZyG2MojYUk7stKfezq92GPycHHUlr4nsvcqNETxCF8xbVGsOdI91
         Bwxn2BPob40kufadtCEtiJkJ7uscA6LKgdbj1M/FsMv4GDg7VGJSKM8d7x4hgn5nT8yX
         Veg/Le3f55HMlHkXff+mdg0dD5sZBwvAsBvTgWaN8j4w5ZDGaZh2Ji6ne72ybykIh93o
         jVAHuUdbqbv0BpEJR/3wENXnxr6Ndgk3m+GgTTzhDf+mMGwn+pltYMOhmuCoJY5ADu/P
         6vmQ==
X-Gm-Message-State: AGi0PuYZg47NNomuWJ7JDMs7INcAQMzGkOIWyHvWmG3ksHzYv1e9YCvZ
        7Q5p5DQpWjeJa4FLx3UU1FI=
X-Google-Smtp-Source: APiQypLae5YnSUv+ooI2RRFb4kBQa1woRc21MEvx2dUfHqs063c/mGtiWy9UZXkzufK7tXaL5UFAnA==
X-Received: by 2002:a1c:9c0a:: with SMTP id f10mr13701826wme.139.1588585033830;
        Mon, 04 May 2020 02:37:13 -0700 (PDT)
Received: from localhost (ip-37-188-183-9.eurotel.cz. [37.188.183.9])
        by smtp.gmail.com with ESMTPSA id u30sm18494318wru.13.2020.05.04.02.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 02:37:13 -0700 (PDT)
Date:   Mon, 4 May 2020 11:37:12 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Mel Gorman <mgorman@suse.de>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Christopher Lameter <cl@linux.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2 3/3] mm/page_alloc: Keep memoryless cpuless node 0
 offline
Message-ID: <20200504093712.GL22838@dhcp22.suse.cz>
References: <20200428093836.27190-1-srikar@linux.vnet.ibm.com>
 <20200428093836.27190-4-srikar@linux.vnet.ibm.com>
 <20200428165912.ca1eadefbac56d740e6e8fd1@linux-foundation.org>
 <20200429014145.GD19958@linux.vnet.ibm.com>
 <20200429122211.GD28637@dhcp22.suse.cz>
 <20200430071820.GF19958@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200430071820.GF19958@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 30-04-20 12:48:20, Srikar Dronamraju wrote:
> * Michal Hocko <mhocko@kernel.org> [2020-04-29 14:22:11]:
> 
> > On Wed 29-04-20 07:11:45, Srikar Dronamraju wrote:
> > > > > 
> > > > > By marking, N_ONLINE as NODE_MASK_NONE, lets stop assuming that Node 0 is
> > > > > always online.
> > > > > 
> > > > > ...
> > > > >
> > > > > --- a/mm/page_alloc.c
> > > > > +++ b/mm/page_alloc.c
> > > > > @@ -116,8 +116,10 @@ EXPORT_SYMBOL(latent_entropy);
> > > > >   */
> > > > >  nodemask_t node_states[NR_NODE_STATES] __read_mostly = {
> > > > >  	[N_POSSIBLE] = NODE_MASK_ALL,
> > > > > +#ifdef CONFIG_NUMA
> > > > > +	[N_ONLINE] = NODE_MASK_NONE,
> > > > > +#else
> > > > >  	[N_ONLINE] = { { [0] = 1UL } },
> > > > > -#ifndef CONFIG_NUMA
> > > > >  	[N_NORMAL_MEMORY] = { { [0] = 1UL } },
> > > > >  #ifdef CONFIG_HIGHMEM
> > > > >  	[N_HIGH_MEMORY] = { { [0] = 1UL } },
> > > > 
> > > > So on all other NUMA machines, when does node 0 get marked online?
> > > > 
> > > > This change means that for some time during boot, such machines will
> > > > now be running with node 0 marked as offline.  What are the
> > > > implications of this?  Will something break?
> > > 
> > > Till the nodes are detected, marking Node 0 as online tends to be redundant.
> > > Because the system doesn't know if its a NUMA or a non-NUMA system.
> > > Once we detect the nodes, we online them immediately. Hence I don't see any
> > > side-effects or negative implications of this change.
> > > 
> > > However if I am missing anything, please do let me know.
> > > 
> > > >From my part, I have tested this on
> > > 1. Non-NUMA Single node but CPUs and memory coming from zero node.
> > > 2. Non-NUMA Single node but CPUs and memory coming from non-zero node.
> > > 3. NUMA Multi node but with CPUs and memory from node 0.
> > > 4. NUMA Multi node but with no CPUs and memory from node 0.
> > 
> > Have you tested on something else than ppc? Each arch does the NUMA
> > setup separately and this is a big mess. E.g. x86 marks even memory less
> > nodes (see init_memory_less_node) as online.
> > 
> 
> while I have predominantly tested on ppc, I did test on X86 with CONFIG_NUMA
> enabled/disabled on both single node and multi node machines.
> However, I dont have a cpuless/memoryless x86 system.

This should be able to emulate inside kvm, I believe.

> > Honestly I have hard time to evaluate the effect of this patch. It makes
> > some sense to assume all nodes offline before they get online but this
> > is a land mine territory.
> > 
> > I am also not sure what kind of problem this is going to address. You
> > have mentioned numa balancing without many details.
> 
> 1. On a machine with just one node with node number not being 0,
> the current setup will end up showing 2 online nodes. And when there are
> more than one online nodes, numa_balancing gets enabled.
> 
> Without patch
> $ grep numa /proc/vmstat
> numa_hit 95179
> numa_miss 0
> numa_foreign 0
> numa_interleave 3764
> numa_local 95179
> numa_other 0
> numa_pte_updates 1206973                 <----------
> numa_huge_pte_updates 4654                 <----------
> numa_hint_faults 19560                 <----------
> numa_hint_faults_local 19560                 <----------
> numa_pages_migrated 0
> 
> 
> With patch
> $ grep numa /proc/vmstat 
> numa_hit 322338756
> numa_miss 0
> numa_foreign 0
> numa_interleave 3790
> numa_local 322338756
> numa_other 0
> numa_pte_updates 0                 <----------
> numa_huge_pte_updates 0                 <----------
> numa_hint_faults 0                 <----------
> numa_hint_faults_local 0                 <----------
> numa_pages_migrated 0
> 
> So we have a redundant page hinting numa faults which we can avoid.

interesting. Does this lead to any observable differences? Btw. it would
be really great to describe how the online state influences the numa
balancing.

> 2. Few people have complained about existence of this dummy node when
> parsing lscpu and numactl o/p. They somehow start to think that the tools
> are reporting incorrectly or the kernel is not able to recognize resources
> connected to the node.

Please be more specific.
-- 
Michal Hocko
SUSE Labs
