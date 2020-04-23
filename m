Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C341C55191
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 06:10:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00E3C2166E
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 06:10:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbgDWGK2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 02:10:28 -0400
Received: from verein.lst.de ([213.95.11.211]:56130 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725562AbgDWGK1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 02:10:27 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id B47E6227A81; Thu, 23 Apr 2020 08:10:23 +0200 (CEST)
Date:   Thu, 23 Apr 2020 08:10:23 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Christoph Hellwig <hch@lst.de>, linux-mm@kvack.org,
        Ralph Campbell <rcampbell@nvidia.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        amd-gfx@lists.freedesktop.org, Ben Skeggs <bskeggs@redhat.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        dri-devel@lists.freedesktop.org,
        "Kuehling, Felix" <Felix.Kuehling@amd.com>,
        intel-gfx@lists.freedesktop.org,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-kernel@vger.kernel.org,
        Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>,
        nouveau@lists.freedesktop.org
Subject: Re: [PATCH hmm 5/5] mm/hmm: remove the customizable pfn format
 from hmm_range_fault
Message-ID: <20200423061023.GA9856@lst.de>
References: <0-v1-4eb72686de3c+5062-hmm_no_flags_jgg@mellanox.com> <5-v1-4eb72686de3c+5062-hmm_no_flags_jgg@mellanox.com> <20200422060329.GD22366@lst.de> <20200422123911.GV26002@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422123911.GV26002@ziepe.ca>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 22, 2020 at 09:39:11AM -0300, Jason Gunthorpe wrote:
> > Nice callchain from hell..  Unfortunately such "code listings" tend to
> > get out of date very quickly, so I'm not sure it is worth keeping in
> > the code.  What would be really worthile is consolidating the two
> > different sets of defines (NVIF_VMM_PFNMAP_V0_ vs NVKM_VMM_PFN_)
> > to make the code a little easier to follow.
> 
> I was mainly concerned that this function is using hmm properly,
> becuase it sure looks like it is just forming the CPU physical address
> into a HW specific data. But it turns out it is just an internal data
> for some other code and the dma_map is impossibly far away
> 
> It took forever to find, I figured I'd leave a hint for the next poor
> soul that has to look at this.. 
> 
> Also, I think it shows there is no 'performance' argument here, if
> this path needs more performance the above should be cleaned
> before we abuse hmm_range_fault.
> 
> Put it in the commit message instead?

Yes, the graph itself sounds reasonable for the commit log as a point
of time information.

> > >  	npages = (range->end - range->start) >> PAGE_SHIFT;
> > >  	for (i = 0; i < npages; ++i) {
> > >  		struct page *page;
> > >  
> > > +		if (!(range->hmm_pfns[i] & HMM_PFN_VALID)) {
> > > +			ioctl_addr[i] = 0;
> > >  			continue;
> > > +		}
> > 
> > Can't we rely on the caller pre-zeroing the array?
> 
> This ends up as args.phys in nouveau_svm_fault - I didn't see a
> zeroing?
> 
> I think it makes sense that this routine fully sets the output array
> and does not assume pre-initialize

Ok.
