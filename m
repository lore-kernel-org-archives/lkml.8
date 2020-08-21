Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBF05C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 00:22:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABE112076E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 00:22:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K/iwexCs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbgHUAWD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 20:22:03 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:20163 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725859AbgHUAWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 20:22:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597969319;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3aBHsIrR7D1rmQusl3vZJUEll0MhNbsTlUTcbOAur3g=;
        b=K/iwexCse09iSj0Ii0nnBpPgYOsmb+c14NbJ6D986HBd3hdPFYQ9Xm27cqc9my1OBBE5WZ
        6Bi1rnoy570BT1fQIIx5lwdA+ZfHrsQykzgWFHniQ79fqMaKEaxyxoOabzffAxWlpJIn4Z
        NcRwBlHh3b6+bKa7nw1vwzJWFshYHyg=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-555-ePbOEGk_OG6cTP2tOEWJsg-1; Thu, 20 Aug 2020 20:21:57 -0400
X-MC-Unique: ePbOEGk_OG6cTP2tOEWJsg-1
Received: by mail-pf1-f198.google.com with SMTP id a73so232185pfa.10
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 17:21:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3aBHsIrR7D1rmQusl3vZJUEll0MhNbsTlUTcbOAur3g=;
        b=nfiPjvkEbPscuV9A0m/Vd15Cwosy4ZoRdpU9tLs+Dx9eZnZ2dHVjv6f5JGy9H8rCeM
         a9E2J/SLk3cP3nDFhlAHXnFsjHQlgyaCJwYMDd0Sf7mHNNwEJGI4CLcYXFesJh/8l0wv
         9QfibYZBjAi6b083L8JRyPKLUE6SzFcbz/Moq9Fvtdy0tj8KLPPY4ci/mCBuKfK7mBmM
         FbuBsknlcXBEtKGLyw3PVvCtKSDcNbwHvQuaGh3yCODL1AbCIdAUwcAM3Y2Guet41Dzy
         CkDV8/jUEA200oymRAtqhuwY7Lkr1lhySnRIZherw5NbvPG3fjtJAzMs/F2amAlFTgff
         lg1Q==
X-Gm-Message-State: AOAM5323aUuc+6xHNWufZs9YVYb3dPzwt/Zu+ICHUTZQHu2QPcB/lZKH
        xnOyvTan8BX4if77scnQ9Errf4CxvUpAZBxfzNCZov7gOTpPBq4yoCTh0OlG30VXWMcSV13mgLo
        zKr4sNPaVPNe2mBvQwiG+FrxY
X-Received: by 2002:a62:20e:: with SMTP id 14mr305543pfc.207.1597969316729;
        Thu, 20 Aug 2020 17:21:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwKnJ5d5JB7dEtC9MO6PnJWSvjC7EM//ku1FdHc84FzCEHPg33i7BQaa39t+IuifAAfBOurJg==
X-Received: by 2002:a62:20e:: with SMTP id 14mr305520pfc.207.1597969316393;
        Thu, 20 Aug 2020 17:21:56 -0700 (PDT)
Received: from xiangao.remote.csb ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id y135sm248586pfg.148.2020.08.20.17.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 17:21:55 -0700 (PDT)
Date:   Fri, 21 Aug 2020 08:21:45 +0800
From:   Gao Xiang <hsiangkao@redhat.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Carlos Maiolino <cmaiolino@redhat.com>,
        Eric Sandeen <esandeen@redhat.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Rafael Aquini <aquini@redhat.com>,
        stable <stable@vger.kernel.org>
Subject: Re: [PATCH v2] mm, THP, swap: fix allocating cluster for swapfile by
 mistake
Message-ID: <20200821002145.GA28298@xiangao.remote.csb>
References: <20200820045323.7809-1-hsiangkao@redhat.com>
 <20200820233446.GB7728@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200820233446.GB7728@dread.disaster.area>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

On Fri, Aug 21, 2020 at 09:34:46AM +1000, Dave Chinner wrote:
> On Thu, Aug 20, 2020 at 12:53:23PM +0800, Gao Xiang wrote:
> > SWP_FS is used to make swap_{read,write}page() go through
> > the filesystem, and it's only used for swap files over
> > NFS. So, !SWP_FS means non NFS for now, it could be either
> > file backed or device backed. Something similar goes with
> > legacy SWP_FILE.
> > 
> > So in order to achieve the goal of the original patch,
> > SWP_BLKDEV should be used instead.
> > 
> > FS corruption can be observed with SSD device + XFS +
> > fragmented swapfile due to CONFIG_THP_SWAP=y.
> > 
> > I reproduced the issue with the following details:
> > 
> > Environment:
> > QEMU + upstream kernel + buildroot + NVMe (2 GB)
> > 
> > Kernel config:
> > CONFIG_BLK_DEV_NVME=y
> > CONFIG_THP_SWAP=y
> 
> Ok, so at it's core this is a swap file extent versus THP swap
> cluster alignment issue?

I think yes.

> 
> > diff --git a/mm/swapfile.c b/mm/swapfile.c
> > index 6c26916e95fd..2937daf3ca02 100644
> > --- a/mm/swapfile.c
> > +++ b/mm/swapfile.c
> > @@ -1074,7 +1074,7 @@ int get_swap_pages(int n_goal, swp_entry_t swp_entries[], int entry_size)
> >  			goto nextsi;
> >  		}
> >  		if (size == SWAPFILE_CLUSTER) {
> > -			if (!(si->flags & SWP_FS))
> > +			if (si->flags & SWP_BLKDEV)
> >  				n_ret = swap_alloc_cluster(si, swp_entries);
> >  		} else
> >  			n_ret = scan_swap_map_slots(si, SWAP_HAS_CACHE,
> 
> IOWs, if you don't make this change, does the corruption problem go
> away if you align swap extents in iomap_swapfile_add_extent() to
> (SWAPFILE_CLUSTER * PAGE_SIZE) instead of just PAGE_SIZE?
> 
> I.e. if the swapfile extents are aligned correctly to huge page swap
> cluster size and alignment, does the swap clustering optimisations
> for swapping THP pages work correctly? And, if so, is there any
> performance benefit we get from enabling proper THP swap clustering
> on swapfiles?
> 

Yeah, I once think about some similiar thing as well. My thought for now is

 - First, SWAP THP doesn't claim to support such swapfile for now.
   And the original author tried to explicitly avoid the whole thing in

   f0eea189e8e9 ("mm, THP, swap: Don't allocate huge cluster for file backed swap device")

   So such thing would be considered as some new feature and need
   more testing at least. But for now I think we just need a quick
   fix to fix the commit f0eea189e8e9 to avoid regression and for
   backport use.

 - It is hard for users to control swapfile in
   SWAPFILE_CLUSTER * PAGE_SIZE extents, especially users'
   disk are fragmented or have some on-disk metadata limitation or
   something. It's very hard for users to utilize this and arrange
   their swapfile physical addr alignment and fragments for now.

So my point is, if it's considered in the future (supporting SWAP
THP swapfile), it needs more carefully consideration and decision
(e.g. stability, performance, simplicity, etc). For now, it's just
a exist regression which fixes the original fix, and finish
the original author claim.

Thanks,
Gao Xiang

> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
> 

