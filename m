Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 013FDC2BB55
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 15:33:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBEB920857
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 15:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586446408;
	bh=URJUKis2DSCIjQdFIOH3dCBa0FClwI72/474EvClkDA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=I0OkrQNPYPWAb9QrRllknDAiUTSzjyOA2IG4uhwAlPHeR9vGsvek2Y995HiGtd7Y2
	 wwJEnORHZf1w2T0wT1qaptwESV0WIfe/zihbYDQw4wIgnkilHiaAkCvoXg5BfGox0I
	 PK6uKkJyPzwOMK+Nzvy5Ho5tHC6EBhWhPHkLUHHk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728338AbgDIPd1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 11:33:27 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33810 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727919AbgDIPd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 11:33:26 -0400
Received: by mail-wr1-f65.google.com with SMTP id 65so12453075wrl.1;
        Thu, 09 Apr 2020 08:33:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eU8HVKPcEFasCzGb3YcmSlRzYlNKnx8U/U7SeGkKTM4=;
        b=C+8DZyqPajHcUCsRWoTTPdTzp+9mYo3pWjlIfXH3GRnCf+cdk0McSbKJvwBTPTgbzN
         gG7RNoybDzIk7efDPLlLMjf/MCfapIHuElEML9W5yyiSqIQIs3Gvp1HRevesRnmSvT8j
         0cU0lHiPhDHBSWVA0/r4NsmWDahWp+bgiGxJrE2LrGEtKCd9zpRzbsPziWcvh6lf0s9B
         cSHIDhSElFmJj76sRVqEZc4XSX40rLQE5T0sVzelazRG72Zp7IiS2azgaDcnrniQGzfe
         t+ymP8afc2A+pu+APkeCwunUP/M4jzCEqVyArme0EBuqyor5/IzJ/H+H4Gi9ygugTJ8n
         jzBw==
X-Gm-Message-State: AGi0PuZK+e7JQOjWSdthtkNTSvEkXqFCAiQ0TqH1Ea4s8fmt5waXlbbF
        xNT7LM6ZYrAL6mjjcpIuqII=
X-Google-Smtp-Source: APiQypLhnJ0ArE660dAIRKPg+UfX8htjcJDtxqzlxSXIrBucMDxX/FoA+uq76nGwKcjVTj7PGoGnsA==
X-Received: by 2002:a5d:5112:: with SMTP id s18mr15000370wrt.306.1586446403503;
        Thu, 09 Apr 2020 08:33:23 -0700 (PDT)
Received: from localhost (ip-37-188-180-223.eurotel.cz. [37.188.180.223])
        by smtp.gmail.com with ESMTPSA id o67sm4335914wmo.5.2020.04.09.08.33.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2020 08:33:22 -0700 (PDT)
Date:   Thu, 9 Apr 2020 17:33:21 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     Mike Rapoport <rppt@linux.ibm.com>,
        Hoan Tran <Hoan@os.amperecomputing.com>,
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
Message-ID: <20200409153321.GQ18386@dhcp22.suse.cz>
References: <1585420282-25630-1-git-send-email-Hoan@os.amperecomputing.com>
 <20200330074246.GA14243@dhcp22.suse.cz>
 <20200330092127.GB30942@linux.ibm.com>
 <20200330095843.GF14243@dhcp22.suse.cz>
 <20200331215618.GG30942@linux.ibm.com>
 <20200401054227.GC2129@MiWiFi-R3L-srv>
 <20200401075155.GH30942@linux.ibm.com>
 <20200402080144.GK22681@dhcp22.suse.cz>
 <20200409144119.GE2129@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200409144119.GE2129@MiWiFi-R3L-srv>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 09-04-20 22:41:19, Baoquan He wrote:
> On 04/02/20 at 10:01am, Michal Hocko wrote:
> > On Wed 01-04-20 10:51:55, Mike Rapoport wrote:
> > > Hi,
> > > 
> > > On Wed, Apr 01, 2020 at 01:42:27PM +0800, Baoquan He wrote:
> > [...]
> > > > From above information, we can remove HAVE_MEMBLOCK_NODE_MAP, and
> > > > replace it with CONFIG_NUMA. That sounds more sensible to store nid into
> > > > memblock when NUMA support is enabled.
> > >  
> > > Replacing CONFIG_HAVE_MEMBLOCK_NODE_MAP with CONFIG_NUMA will work, but
> > > this will not help cleaning up the whole node/zone initialization mess and
> > > we'll be stuck with two implementations.
> > 
> > Yeah, this is far from optimal.
> > 
> > > The overhead of enabling HAVE_MEMBLOCK_NODE_MAP is only for init time as
> > > most architectures will anyway discard the entire memblock, so having it in
> > > a UMA arch won't be a problem. The only exception is arm that uses
> > > memblock for pfn_valid(), here we may also think about a solution to
> > > compensate the addition of nid to the memblock structures. 
> > 
> > Well, we can make memblock_region->nid defined only for CONFIG_NUMA.
> > memblock_get_region_node would then unconditionally return 0 on UMA.
> > Essentially the same way we do NUMA for other MM code. I only see few
> > direct usage of region->nid.
> 
> Checked code again, seems HAVE_MEMBLOCK_NODE_MAP is selected directly in
> all ARCHes which support it. Means HAVE_MEMBLOCK_NODE_MAP is enabled by
> default on those ARCHes, and has no dependency on CONFIG_NUMA at all.
> E.g on x86, it just calls free_area_init_nodes() in generic code path,
> while free_area_init_nodes() is defined in CONFIG_HAVE_MEMBLOCK_NODE_MAP
> ifdeffery scope. So I tend to agree with Mike to remove
> HAVE_MEMBLOCK_NODE_MAP firstly on all ARCHes. We can check if it's worth
> only defining memblock_region->nid for CONFIG_NUMA case after
> HAVE_MEMBLOCK_NODE_MAP is removed.

This can surely go in separate patches. What I meant to say is the
region->nid is by definition 0 on !CONFIG_NUMA.

-- 
Michal Hocko
SUSE Labs
