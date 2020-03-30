Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41A13C2D0EB
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 09:58:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15BDE2072E
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 09:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585562329;
	bh=EtWOn25Oz9Do1M3pf0Bdh1cgolpiN/DDYknvZuJqAuw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=abX1RKcvgwyKULrKEab/xzyaWljFf+RVBF3jyq4qOVxlk4UX07AN95ZqHY0c51gp7
	 MZoHIuB6svdwFcaR5U1fDCEWYTq+PfPMlZ7bMEZ1+T1f7+v9h7UitjKUu7sqUUjDTk
	 8l2FywD1CD3S0rRN/6MC9a18L17W5gY8vgkb4v9w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728794AbgC3J6s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 05:58:48 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46383 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727522AbgC3J6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 05:58:47 -0400
Received: by mail-wr1-f66.google.com with SMTP id j17so20737559wru.13;
        Mon, 30 Mar 2020 02:58:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RAW4dI5AqDOZg2OFBhTf/EVo0m3y8bG8p0ACgPsFWtE=;
        b=OCp3chht8upmlHjiegUSpYA7Zm5wIKCsvsT4Tl9GUG9ZMi/4WDCkv0aTPhwRfkPi1o
         n81N75mvN0d5J+FzmZG0lqbYJ8NVmmHR9GRM3ll8E7WmpvsInPiN1Ibw+uShxy+EJjvq
         RKR9sBwe2tuK0O6oSMg300FhyuL1sSXxpZ4Tki6iQyE0dbXp5+sn6nt08wJZyugBXBFA
         yP8Z2xLUZD/7oLdw1r2STra+7+YKLSFvP/4qG7yosXmfrPV2BNi8Ph6HzUkvuhkwQwto
         Eb+WUGC7+SQWkzIcl+LxdFvg+BTtCmXoImPX5s92gUJTMClylazhmufGeNk5zZIINyRO
         y8/w==
X-Gm-Message-State: ANhLgQ3bzuQS6RZNLNUQir+N9k06RmVj3w2m4jw1LIkIs6uQ3iBZ/Bza
        Bgwd8ozwrE7m/6MYOzT/cUQ=
X-Google-Smtp-Source: ADFU+vs2ADx9iXcEtG7i4t0y2sXGzETHyH4fleW4u+faHVS+T4YFrF+aBgCdG9nD2ekBmdttmSU8rw==
X-Received: by 2002:a5d:460f:: with SMTP id t15mr14129460wrq.413.1585562325855;
        Mon, 30 Mar 2020 02:58:45 -0700 (PDT)
Received: from localhost (ip-37-188-180-223.eurotel.cz. [37.188.180.223])
        by smtp.gmail.com with ESMTPSA id b199sm17339431wme.23.2020.03.30.02.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 02:58:44 -0700 (PDT)
Date:   Mon, 30 Mar 2020 11:58:43 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Hoan Tran <Hoan@os.amperecomputing.com>,
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
Message-ID: <20200330095843.GF14243@dhcp22.suse.cz>
References: <1585420282-25630-1-git-send-email-Hoan@os.amperecomputing.com>
 <20200330074246.GA14243@dhcp22.suse.cz>
 <20200330092127.GB30942@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200330092127.GB30942@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 30-03-20 12:21:27, Mike Rapoport wrote:
> On Mon, Mar 30, 2020 at 09:42:46AM +0200, Michal Hocko wrote:
> > On Sat 28-03-20 11:31:17, Hoan Tran wrote:
> > > In NUMA layout which nodes have memory ranges that span across other nodes,
> > > the mm driver can detect the memory node id incorrectly.
> > > 
> > > For example, with layout below
> > > Node 0 address: 0000 xxxx 0000 xxxx
> > > Node 1 address: xxxx 1111 xxxx 1111
> > > 
> > > Note:
> > >  - Memory from low to high
> > >  - 0/1: Node id
> > >  - x: Invalid memory of a node
> > > 
> > > When mm probes the memory map, without CONFIG_NODES_SPAN_OTHER_NODES
> > > config, mm only checks the memory validity but not the node id.
> > > Because of that, Node 1 also detects the memory from node 0 as below
> > > when it scans from the start address to the end address of node 1.
> > > 
> > > Node 0 address: 0000 xxxx xxxx xxxx
> > > Node 1 address: xxxx 1111 1111 1111
> > > 
> > > This layout could occur on any architecture. Most of them enables
> > > this config by default with CONFIG_NUMA. This patch, by default, enables
> > > CONFIG_NODES_SPAN_OTHER_NODES or uses early_pfn_in_nid() for NUMA.
> > 
> > I am not opposed to this at all. It reduces the config space and that is
> > a good thing on its own. The history has shown that meory layout might
> > be really wild wrt NUMA. The config is only used for early_pfn_in_nid
> > which is clearly an overkill.
> > 
> > Your description doesn't really explain why this is safe though. The
> > history of this config is somehow messy, though. Mike has tried
> > to remove it a94b3ab7eab4 ("[PATCH] mm: remove arch independent
> > NODES_SPAN_OTHER_NODES") just to be reintroduced by 7516795739bd
> > ("[PATCH] Reintroduce NODES_SPAN_OTHER_NODES for powerpc") without any
> > reasoning what so ever. This doesn't make it really easy see whether
> > reasons for reintroduction are still there. Maybe there are some subtle
> > dependencies. I do not see any TBH but that might be burried deep in an
> > arch specific code.
> 
> Well, back then early_pfn_in_nid() was arch-dependant, today everyone
> except ia64 rely on HAVE_MEMBLOCK_NODE_MAP.

What would it take to make ia64 use HAVE_MEMBLOCK_NODE_MAP? I would
really love to see that thing go away. It is causing problems when
people try to use memblock api.

> So, if the memblock node map
> is correct, that using CONFIG_NUMA instead of CONFIG_NODES_SPAN_OTHER_NODES
> would only mean that early_pfn_in_nid() will cost several cycles more on
> architectures that didn't select CONFIG_NODES_SPAN_OTHER_NODES (i.e. arm64
> and sh).

Do we have any idea on how much of an overhead that is? Because this is
per each pfn so it can accumulate a lot! 

> Agian, ia64 is an exception here.

Thanks for the clarification!
-- 
Michal Hocko
SUSE Labs
