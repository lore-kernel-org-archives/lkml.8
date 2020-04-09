Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61C8BC2BA2B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 14:41:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 389442078E
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 14:41:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WmixIhEA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727841AbgDIOle (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 10:41:34 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60654 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727737AbgDIOle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 10:41:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586443292;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=89GNIOSKjsOD8QJV6eCKtCzrS0MjyFeJYEzczikaUfM=;
        b=WmixIhEAPyFwklTqe2cWyM/gqP7bbMkWxLW1zsOUbwnsQK0j7bVTPNIxHWzYUZYGleDfAY
        Z9os8mmtSg8kd/sDxmSN7Qz19eYl/3zLcQR61fy9wI0AIr+OBQT+ZhRB8oPF1LLQlWaCbO
        eq0g8yhX1cNKOMuXEuJwQ4HGioxH5/c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-282-cRVUOBR5Nx2JHnnd5Bfdcg-1; Thu, 09 Apr 2020 10:41:26 -0400
X-MC-Unique: cRVUOBR5Nx2JHnnd5Bfdcg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4E8F08017F3;
        Thu,  9 Apr 2020 14:41:23 +0000 (UTC)
Received: from localhost (ovpn-12-133.pek2.redhat.com [10.72.12.133])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0F81E391;
        Thu,  9 Apr 2020 14:41:22 +0000 (UTC)
Date:   Thu, 9 Apr 2020 22:41:19 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Mike Rapoport <rppt@linux.ibm.com>,
        Michal Hocko <mhocko@kernel.org>
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
Subject: Re: [PATCH RFC] mm: remove CONFIG_HAVE_MEMBLOCK_NODE_MAP (was: Re:
 [PATCH v3 0/5] mm: Enable CONFIG_NODES_SPAN_OTHER_NODES by default for NUMA)
Message-ID: <20200409144119.GE2129@MiWiFi-R3L-srv>
References: <1585420282-25630-1-git-send-email-Hoan@os.amperecomputing.com>
 <20200330074246.GA14243@dhcp22.suse.cz>
 <20200330092127.GB30942@linux.ibm.com>
 <20200330095843.GF14243@dhcp22.suse.cz>
 <20200331215618.GG30942@linux.ibm.com>
 <20200401054227.GC2129@MiWiFi-R3L-srv>
 <20200401075155.GH30942@linux.ibm.com>
 <20200402080144.GK22681@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200402080144.GK22681@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/02/20 at 10:01am, Michal Hocko wrote:
> On Wed 01-04-20 10:51:55, Mike Rapoport wrote:
> > Hi,
> > 
> > On Wed, Apr 01, 2020 at 01:42:27PM +0800, Baoquan He wrote:
> [...]
> > > From above information, we can remove HAVE_MEMBLOCK_NODE_MAP, and
> > > replace it with CONFIG_NUMA. That sounds more sensible to store nid into
> > > memblock when NUMA support is enabled.
> >  
> > Replacing CONFIG_HAVE_MEMBLOCK_NODE_MAP with CONFIG_NUMA will work, but
> > this will not help cleaning up the whole node/zone initialization mess and
> > we'll be stuck with two implementations.
> 
> Yeah, this is far from optimal.
> 
> > The overhead of enabling HAVE_MEMBLOCK_NODE_MAP is only for init time as
> > most architectures will anyway discard the entire memblock, so having it in
> > a UMA arch won't be a problem. The only exception is arm that uses
> > memblock for pfn_valid(), here we may also think about a solution to
> > compensate the addition of nid to the memblock structures. 
> 
> Well, we can make memblock_region->nid defined only for CONFIG_NUMA.
> memblock_get_region_node would then unconditionally return 0 on UMA.
> Essentially the same way we do NUMA for other MM code. I only see few
> direct usage of region->nid.

Checked code again, seems HAVE_MEMBLOCK_NODE_MAP is selected directly in
all ARCHes which support it. Means HAVE_MEMBLOCK_NODE_MAP is enabled by
default on those ARCHes, and has no dependency on CONFIG_NUMA at all.
E.g on x86, it just calls free_area_init_nodes() in generic code path,
while free_area_init_nodes() is defined in CONFIG_HAVE_MEMBLOCK_NODE_MAP
ifdeffery scope. So I tend to agree with Mike to remove
HAVE_MEMBLOCK_NODE_MAP firstly on all ARCHes. We can check if it's worth
only defining memblock_region->nid for CONFIG_NUMA case after
HAVE_MEMBLOCK_NODE_MAP is removed.

config X86
        def_bool y
	...
	select HAVE_MEMBLOCK_NODE_MAP
	...

