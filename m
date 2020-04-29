Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E61FC83004
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 12:22:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 260B721BE5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 12:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588162938;
	bh=Y4Lk+77XpJwPgx3aGZqBZgJVvcY5ctwNA5Sk1H9o578=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=r54ECgMNuooXNTOTc0+leDZ4inVPBqFMQbbD7+9/71AJ1CWToIjbEnsDyQu75Ltqh
	 dUgx+xisnZ+lLiM/nArMsxG+mn3tlxy6jcGNbBFBj5HhBRJfit2kgQtjoj+bOgygv3
	 v/8+XLsXXYBJMe7eEXjbDumpC+WLpw/SmoDEHFis=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbgD2MWR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 08:22:17 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45985 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726739AbgD2MWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 08:22:17 -0400
Received: by mail-wr1-f65.google.com with SMTP id t14so2236909wrw.12
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 05:22:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=F1Vyi5oIpMniiJ1X1bwh1/7tqzVkkRj08pWhRZE7c+M=;
        b=DMFHBHmCtRCiIry6FLabTL1gh/05iyNbyiO2E3Tf+TWxD4qKokJiWboug4C14MMOfq
         c/Bur5pg+86+KL7Q7HZzTNBkQbr9d7b+ZTc+jhBuv+rc51bg4/k6y0BpfaC6nkohtBq1
         0MRzOHA+qNKxdgOfJLma+swqfbljuOsN/LvxPvcdF+Qfy0VCEnkqVX629syIJD/0yFzJ
         pzwA2/7xED4kX+IF/OLQZklQzkXsiLpOqVwfrDkGm+wPVyxcg140HqKh2hnTsXcXGg4z
         X35qiF7XOnoBCLt4qDo/nvHTcnpsW9RTGUnt+yIeRuUdJnQJ/PntGsDd2kB1zJpK3647
         iGSw==
X-Gm-Message-State: AGi0PuYKkvaKSS1PNxN9POZgpB0NIRmJHMYh4RlvpQX2rqyJt1EFXCT2
        8hotaGkS6qWn+r9Hf23EUOM=
X-Google-Smtp-Source: APiQypKnWBYUo6BP7xM7bZ+TgaJBDEnHFZi4EuKVmDYQRCUHS4sHLGy0+C//6II7OWTEW5xn6unxsw==
X-Received: by 2002:a5d:6a8b:: with SMTP id s11mr38386766wru.258.1588162933425;
        Wed, 29 Apr 2020 05:22:13 -0700 (PDT)
Received: from localhost (ip-37-188-130-62.eurotel.cz. [37.188.130.62])
        by smtp.gmail.com with ESMTPSA id n25sm7497026wmk.9.2020.04.29.05.22.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 05:22:12 -0700 (PDT)
Date:   Wed, 29 Apr 2020 14:22:11 +0200
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
Message-ID: <20200429122211.GD28637@dhcp22.suse.cz>
References: <20200428093836.27190-1-srikar@linux.vnet.ibm.com>
 <20200428093836.27190-4-srikar@linux.vnet.ibm.com>
 <20200428165912.ca1eadefbac56d740e6e8fd1@linux-foundation.org>
 <20200429014145.GD19958@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200429014145.GD19958@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 29-04-20 07:11:45, Srikar Dronamraju wrote:
> > > 
> > > By marking, N_ONLINE as NODE_MASK_NONE, lets stop assuming that Node 0 is
> > > always online.
> > > 
> > > ...
> > >
> > > --- a/mm/page_alloc.c
> > > +++ b/mm/page_alloc.c
> > > @@ -116,8 +116,10 @@ EXPORT_SYMBOL(latent_entropy);
> > >   */
> > >  nodemask_t node_states[NR_NODE_STATES] __read_mostly = {
> > >  	[N_POSSIBLE] = NODE_MASK_ALL,
> > > +#ifdef CONFIG_NUMA
> > > +	[N_ONLINE] = NODE_MASK_NONE,
> > > +#else
> > >  	[N_ONLINE] = { { [0] = 1UL } },
> > > -#ifndef CONFIG_NUMA
> > >  	[N_NORMAL_MEMORY] = { { [0] = 1UL } },
> > >  #ifdef CONFIG_HIGHMEM
> > >  	[N_HIGH_MEMORY] = { { [0] = 1UL } },
> > 
> > So on all other NUMA machines, when does node 0 get marked online?
> > 
> > This change means that for some time during boot, such machines will
> > now be running with node 0 marked as offline.  What are the
> > implications of this?  Will something break?
> 
> Till the nodes are detected, marking Node 0 as online tends to be redundant.
> Because the system doesn't know if its a NUMA or a non-NUMA system.
> Once we detect the nodes, we online them immediately. Hence I don't see any
> side-effects or negative implications of this change.
> 
> However if I am missing anything, please do let me know.
> 
> >From my part, I have tested this on
> 1. Non-NUMA Single node but CPUs and memory coming from zero node.
> 2. Non-NUMA Single node but CPUs and memory coming from non-zero node.
> 3. NUMA Multi node but with CPUs and memory from node 0.
> 4. NUMA Multi node but with no CPUs and memory from node 0.

Have you tested on something else than ppc? Each arch does the NUMA
setup separately and this is a big mess. E.g. x86 marks even memory less
nodes (see init_memory_less_node) as online.

Honestly I have hard time to evaluate the effect of this patch. It makes
some sense to assume all nodes offline before they get online but this
is a land mine territory.

I am also not sure what kind of problem this is going to address. You
have mentioned numa balancing without many details.
-- 
Michal Hocko
SUSE Labs
