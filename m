Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B407C2D0EB
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 18:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62224206F6
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 18:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585592586;
	bh=xCuUwcArA/aQJxUI/G503CTo6Yd1DkvTaIxPjk102js=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xFR8IYOvIPCvn/ZmWuIGEY97CVFJuKEJA3V/UHtPbP9gv7YMA9PE5fR8OTuoZY2/j
	 HIiDZNhxqQChUGqL1Etvnprr11gy3DN8U1vPuGrj2qQS1tpaj25GRJ0zT8glERDC28
	 qUGXvBVg+onjHSyteDJjCwjEe4I5DzW06bc3NXIw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbgC3SXF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 14:23:05 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36380 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726769AbgC3SXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 14:23:05 -0400
Received: by mail-wr1-f67.google.com with SMTP id 31so22892272wrs.3;
        Mon, 30 Mar 2020 11:23:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0jhRFYVkza+qJU3Il8/iXGVhPGBzX8dkXPD9i1bwSag=;
        b=HcIXr8Hrwmmw5Wi5wr+oQPp0f5r7SVEypa4eQqW5Mf4OTkKkR07I7N2dGa8lQXTAzm
         G9MLDuJhlTsCe8pMxN93AQ6yXlYl9xHv5mIVNeFJWn/s++YRKXa8YJnVOgXr09kKFhUo
         PcQq+zg/SoXMPB3rX4FXig7id4wbZT3B5EqdLzdsmlTBf1XOfOOJ97KCYkAdqzeKNb0h
         hhFSVw124mRpzMYyCo9WykLEFe3Y18V2m8iBasSQtNFGtyyftMwA4+kGpWEo75fQ6yja
         7wisH2SmVT2PJfx6ABwD+AsaKsjG2KsLk/6APKLBAjCVPGs4eQchcBwGIqwqCEBeiafe
         nFjA==
X-Gm-Message-State: ANhLgQ14Be72ZQxblAst7bNF/iqQ4sFcVt+rRAcfmlxBTWFnCZjY3qJ2
        9y48WK3CcpVTZuwFyuh5IGU=
X-Google-Smtp-Source: ADFU+vv5K/FBYjKeTVX0F/L19lDVfm50dWVM5MaRN4MeyMqOqGnWTdxnNM7cmfvlZTzDum9SAd0OPg==
X-Received: by 2002:adf:d849:: with SMTP id k9mr15996160wrl.108.1585592583199;
        Mon, 30 Mar 2020 11:23:03 -0700 (PDT)
Received: from localhost (ip-37-188-180-223.eurotel.cz. [37.188.180.223])
        by smtp.gmail.com with ESMTPSA id f187sm474696wme.9.2020.03.30.11.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 11:23:02 -0700 (PDT)
Date:   Mon, 30 Mar 2020 20:23:01 +0200
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
Message-ID: <20200330182301.GM14243@dhcp22.suse.cz>
References: <1585420282-25630-1-git-send-email-Hoan@os.amperecomputing.com>
 <20200330074246.GA14243@dhcp22.suse.cz>
 <20200330175100.GD30942@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200330175100.GD30942@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 30-03-20 20:51:00, Mike Rapoport wrote:
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
> I've looked at this a bit more and it seems that the check for
> early_pfn_in_nid() in memmap_init_zone() can be simply removed.
> 
> The commits you've mentioned were way before the addition of
> HAVE_MEMBLOCK_NODE_MAP and the whole infrastructure that calculates zone
> sizes and boundaries based on the memblock node map.
> So, the memmap_init_zone() is called when zone boundaries are already
> within a node.

But zones from different nodes might overlap in the pfn range. And this
check is there to skip over those overlapping areas. The only way to
skip over this check I can see is to do a different pfn walk and go
through memblock ranges which are guaranteed to belong to a single node.
-- 
Michal Hocko
SUSE Labs
