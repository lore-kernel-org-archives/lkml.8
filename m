Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71C30C54FCC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 21:45:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FE8C206D9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 21:45:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726353AbgDUVpR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 17:45:17 -0400
Received: from mga03.intel.com ([134.134.136.65]:26604 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725850AbgDUVpQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 17:45:16 -0400
IronPort-SDR: wMs3zuSSGIbZUN5ycGOZbicEm00WWT+MwNlXFq8m4CJXVW/iTYqcDs6A4/3+85/r/RnBTOs1O/
 8sUj3C2O5Wgg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2020 14:45:16 -0700
IronPort-SDR: MwvvF2uOE0/rXubMe0J7rP2SBZ7NPzFjCQFRpdgTxUXhT+1BkCZkaaUflxP8D0Ma8PrKuUH+uN
 o6C6CID10IyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,411,1580803200"; 
   d="scan'208";a="244305142"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga007.jf.intel.com with ESMTP; 21 Apr 2020 14:45:16 -0700
Date:   Tue, 21 Apr 2020 14:51:14 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Eric Auger <eric.auger@redhat.com>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH 03/10] iommu/ioasid: Introduce per set allocation APIs
Message-ID: <20200421145114.49e05059@jacob-builder>
In-Reply-To: <20200407110107.GA285264@myrica>
References: <1585158931-1825-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1585158931-1825-4-git-send-email-jacob.jun.pan@linux.intel.com>
        <20200401134745.GE882512@myrica>
        <20200406130245.690cfe15@jacob-builder>
        <20200407110107.GA285264@myrica>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jean,

Sorry for the late reply, been trying to redesign the notification part.

On Tue, 7 Apr 2020 13:01:07 +0200
Jean-Philippe Brucker <jean-philippe@linaro.org> wrote:

> On Mon, Apr 06, 2020 at 01:02:45PM -0700, Jacob Pan wrote:
> > > > +	sdata = kzalloc(sizeof(*sdata), GFP_KERNEL);
> > > > +	if (!sdata)
> > > > +		return -ENOMEM;    
> > > 
> > > I don't understand why we need this structure at all, nor why we
> > > need the SID. Users have already allocated an ioasid_set, so why
> > > not just stick the content of ioasid_set_data in there, and pass
> > > the ioasid_set pointer to ioasid_alloc()?
> > >   
> > 
> > My thinking was that ioasid_set is an opaque user token, e.g. we
> > use mm to identify a common set belong to a VM.
> > 
> > This sdata is an IOASID internal structure for managing & servicing
> > per set data. If we let user fill in the content, some of the
> > entries need to be managed by the IOASID code under a lock.  
> 
> We don't have to let users fill the content. A bit like iommu_domain:
> device drivers don't modify it, they pass it to iommu_map() rather
> than passing a domain ID.
> 
much better.

> > IMO, not suitable to let user allocate and manage.
> > 
> > Perhaps we should rename struct ioasid_set to ioasid_set_token?  
> 
> Is the token actually used anywhere?  As far as I can tell VFIO does
> its own uniqueness check before calling ioasid_alloc_set(), and
> consumers of notifications don't read the token.
> 
for vt-d, the per vm token (preferrably mm) will be used by kvm to
manage its PASID translation table.
when kvm receives a notification about a new guest-host PASID mapping,
it needs to know which vm it belongs to. So if mm is used as token,
both vfio and kvm can identify PASID ownership.

> > 
> > /**
> >  * struct ioasid_set_data - Meta data about ioasid_set
> >  *
> >  * @token:	Unique to identify an IOASID set
> >  * @xa:		XArray to store ioasid_set private ID to
> > system-wide IOASID
> >  *		mapping
> >  * @max_id:	Max number of IOASIDs can be allocated within
> > the set
> >  * @nr_id	Number of IOASIDs allocated in the set
> >  * @sid		ID of the set
> >  */
> > struct ioasid_set_data {
> > 	struct ioasid_set *token;
> > 	struct xarray xa;
> > 	int size;
> > 	int nr_ioasids;
> > 	int sid;
> > 	struct rcu_head rcu;
> > };  
> 
> How about we remove the current ioasid_set, call this structure
> ioasid_set instead of ioasid_set_data, and have ioasid_alloc_set()
> return it, rather than requiring users to allocate the ioasid_set
> themselves?
> 
> 	struct ioasid_set *ioasid_alloc_set(ioasid_t quota):
> 
> This way ioasid_set is opaque to users (we could have the definition
> in ioasid.c), but it can be passed to ioasid_alloc() and avoids the
> lookup by SID. Could also add the unique token as a void * argument to
> ioasid_alloc_set(), if needed.
> 
Sounds good. still pass a token. Thanks for the idea.

> Thanks,
> Jean

[Jacob Pan]
