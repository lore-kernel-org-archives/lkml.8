Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81AD7C433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 20:57:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CAAB206E3
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 20:57:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730188AbgHaU47 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 16:56:59 -0400
Received: from mga03.intel.com ([134.134.136.65]:54289 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728354AbgHaU46 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 16:56:58 -0400
IronPort-SDR: Pl/9gf0cICtQarKvAd08k6qTHvb03biht8W6pgJ4unzoXS+IdDPp5XH1DzR9fz34oE3UOSM1QV
 humDwSSZAB9A==
X-IronPort-AV: E=McAfee;i="6000,8403,9730"; a="157062072"
X-IronPort-AV: E=Sophos;i="5.76,376,1592895600"; 
   d="scan'208";a="157062072"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2020 13:56:56 -0700
IronPort-SDR: t0PJjCuD1wtMFqkpi/FztVOjFZGZRijtNvTBBG6lxNyyHI/hyCERrhJlJXzQk2/5kzDmDwSPHq
 pOmLMXDREYiw==
X-IronPort-AV: E=Sophos;i="5.76,376,1592895600"; 
   d="scan'208";a="445865326"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2020 13:56:55 -0700
Date:   Mon, 31 Aug 2020 13:56:55 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>,
        linux-kernel@vger.kernel.org,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-nvdimm@lists.01.org, xen-devel@lists.xenproject.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v4 1/2] memremap: rename MEMORY_DEVICE_DEVDAX to
 MEMORY_DEVICE_GENERIC
Message-ID: <20200831205655.GK1422350@iweiny-DESK2.sc.intel.com>
References: <20200811094447.31208-1-roger.pau@citrix.com>
 <20200811094447.31208-2-roger.pau@citrix.com>
 <96e34f77-8f55-d8a2-4d1f-4f4b667b0472@redhat.com>
 <20200820113741.GV828@Air-de-Roger>
 <20200831101907.GA753@Air-de-Roger>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200831101907.GA753@Air-de-Roger>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 31, 2020 at 12:19:07PM +0200, Roger Pau Monné wrote:
> On Thu, Aug 20, 2020 at 01:37:41PM +0200, Roger Pau Monné wrote:
> > On Tue, Aug 11, 2020 at 11:07:36PM +0200, David Hildenbrand wrote:
> > > On 11.08.20 11:44, Roger Pau Monne wrote:
> > > > This is in preparation for the logic behind MEMORY_DEVICE_DEVDAX also
> > > > being used by non DAX devices.
> > > > 
> > > > No functional change intended.
> > > > 
> > > > Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>

Dan is out on leave so I'll chime in.

I can't really justify keeping this as DEVDAX if there is another user who
needs the same type of mapping.

Sorry for the delay.

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> > > > ---
> > > > Cc: Dan Williams <dan.j.williams@intel.com>
> > > > Cc: Vishal Verma <vishal.l.verma@intel.com>
> > > > Cc: Dave Jiang <dave.jiang@intel.com>
> > > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > > Cc: Jason Gunthorpe <jgg@ziepe.ca>
> > > > Cc: Ira Weiny <ira.weiny@intel.com>
> > > > Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
> > > > Cc: Johannes Thumshirn <jthumshirn@suse.de>
> > > > Cc: Logan Gunthorpe <logang@deltatee.com>
> > > > Cc: linux-nvdimm@lists.01.org
> > > > Cc: xen-devel@lists.xenproject.org
> > > > Cc: linux-mm@kvack.org
> > > > ---
> > > >  drivers/dax/device.c     | 2 +-
> > > >  include/linux/memremap.h | 9 ++++-----
> > > >  mm/memremap.c            | 2 +-
> > > >  3 files changed, 6 insertions(+), 7 deletions(-)
> > > > 
> > > > diff --git a/drivers/dax/device.c b/drivers/dax/device.c
> > > > index 4c0af2eb7e19..1e89513f3c59 100644
> > > > --- a/drivers/dax/device.c
> > > > +++ b/drivers/dax/device.c
> > > > @@ -429,7 +429,7 @@ int dev_dax_probe(struct device *dev)
> > > >  		return -EBUSY;
> > > >  	}
> > > >  
> > > > -	dev_dax->pgmap.type = MEMORY_DEVICE_DEVDAX;
> > > > +	dev_dax->pgmap.type = MEMORY_DEVICE_GENERIC;
> > > >  	addr = devm_memremap_pages(dev, &dev_dax->pgmap);
> > > >  	if (IS_ERR(addr))
> > > >  		return PTR_ERR(addr);
> > > > diff --git a/include/linux/memremap.h b/include/linux/memremap.h
> > > > index 5f5b2df06e61..e5862746751b 100644
> > > > --- a/include/linux/memremap.h
> > > > +++ b/include/linux/memremap.h
> > > > @@ -46,11 +46,10 @@ struct vmem_altmap {
> > > >   * wakeup is used to coordinate physical address space management (ex:
> > > >   * fs truncate/hole punch) vs pinned pages (ex: device dma).
> > > >   *
> > > > - * MEMORY_DEVICE_DEVDAX:
> > > > + * MEMORY_DEVICE_GENERIC:
> > > >   * Host memory that has similar access semantics as System RAM i.e. DMA
> > > > - * coherent and supports page pinning. In contrast to
> > > > - * MEMORY_DEVICE_FS_DAX, this memory is access via a device-dax
> > > > - * character device.
> > > > + * coherent and supports page pinning. This is for example used by DAX devices
> > > > + * that expose memory using a character device.
> > > >   *
> > > >   * MEMORY_DEVICE_PCI_P2PDMA:
> > > >   * Device memory residing in a PCI BAR intended for use with Peer-to-Peer
> > > > @@ -60,7 +59,7 @@ enum memory_type {
> > > >  	/* 0 is reserved to catch uninitialized type fields */
> > > >  	MEMORY_DEVICE_PRIVATE = 1,
> > > >  	MEMORY_DEVICE_FS_DAX,
> > > > -	MEMORY_DEVICE_DEVDAX,
> > > > +	MEMORY_DEVICE_GENERIC,
> > > >  	MEMORY_DEVICE_PCI_P2PDMA,
> > > >  };
> > > >  
> > > > diff --git a/mm/memremap.c b/mm/memremap.c
> > > > index 03e38b7a38f1..006dace60b1a 100644
> > > > --- a/mm/memremap.c
> > > > +++ b/mm/memremap.c
> > > > @@ -216,7 +216,7 @@ void *memremap_pages(struct dev_pagemap *pgmap, int nid)
> > > >  			return ERR_PTR(-EINVAL);
> > > >  		}
> > > >  		break;
> > > > -	case MEMORY_DEVICE_DEVDAX:
> > > > +	case MEMORY_DEVICE_GENERIC:
> > > >  		need_devmap_managed = false;
> > > >  		break;
> > > >  	case MEMORY_DEVICE_PCI_P2PDMA:
> > > > 
> > > 
> > > No strong opinion (@Dan?), I do wonder if a separate type would make sense.
> > 
> > Gentle ping.
> 
> Sorry to ping again, but I would rather get this out of my queue if
> possible, seeing as the other patch is OK to go in but depends on this
> one going in first.
> 
> Thanks, Roger.
