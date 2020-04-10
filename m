Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A38CC2BA2B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 15:37:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7775120857
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 15:37:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbgDJPhk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 11:37:40 -0400
Received: from mga12.intel.com ([192.55.52.136]:15988 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726080AbgDJPhk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 11:37:40 -0400
IronPort-SDR: KIjv452/LQ9/fgoZSpd++LTAnZtKZ/59Y2AXbKCdIFaMg0OZ+T4lUtdMywpkJwja1hoRYV4X63
 mld0Ns9+90Mw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2020 08:37:40 -0700
IronPort-SDR: J6Dax/bXvKp8e/PrJgA2I2XzuLfvfINEOIs3cyvbW3ArQHG7+oGiWVR519yfHikfr0irB+EU8k
 0HEG6rozXItQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,367,1580803200"; 
   d="scan'208";a="252229219"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga003.jf.intel.com with ESMTP; 10 Apr 2020 08:37:40 -0700
Date:   Fri, 10 Apr 2020 08:43:32 -0700
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
Subject: Re: [PATCH 08/10] iommu/ioasid: Introduce notifier APIs
Message-ID: <20200410084332.6a35a8ca@jacob-builder>
In-Reply-To: <20200401140006.GI882512@myrica>
References: <1585158931-1825-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1585158931-1825-9-git-send-email-jacob.jun.pan@linux.intel.com>
        <20200401140006.GI882512@myrica>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Apr 2020 16:00:06 +0200
Jean-Philippe Brucker <jean-philippe@linaro.org> wrote:

> On Wed, Mar 25, 2020 at 10:55:29AM -0700, Jacob Pan wrote:
> > IOASID users fit into the publisher-subscriber pattern, a system
> > wide blocking notifier chain can be used to inform subscribers of
> > state changes. Notifier mechanism also abstracts publisher from
> > knowing the private context each subcriber may have.
> > 
> > This patch adds APIs and a global notifier chain, a further
> > optimization might be per set notifier for ioasid_set aware users.
> > 
> > Usage example:
> > KVM register notifier block such that it can keep its guest-host
> > PASID translation table in sync with any IOASID updates.  
> 
> When you talk about KVM, is it for
> 
>   [PATCH 0/7] x86: tag application address space for devices
> 
> or something else as well? (I don't see mentions of KVM in that
> series)
> 
Yes, related to this set. This is set is for native ENQCMD support.
VMCS use of IOASID notifier is for the guest SVA + ENQCMD.
We need to maintain a G-H PASID translation in VMCS PASID translation
table. When guest binds a GPASID to a host PASID, this translation
table can be updated such that subsequent ENQCMD in the guest can
resolve to a host PASID.

CH 7.3.1 of DSA spec.
https://software.intel.com/sites/default/files/341204-intel-data-streaming-accelerator-spec.pdf 
> > 
> > VFIO publish IOASID change by performing alloc/free, bind/unbind
> > operations.  
> 
> I was rather seeing IOASID as the end of the VFIO-IOMMU-IOASID chain,
> putting it in the middle complicates locking. If you only need to FREE
> notifier for this calse, maybe VFIO could talk directly to the IOMMU
> driver before freeing an IOASID?  gpasid_unbind() should already
> clear the PASID contexts, no?
> 
Yes, VFIO can track all the PASIDs and make sure they do unbind before
free. But that might be more complicated in VFIO, whereas here, when a
guest exits, VFIO can just free the entire IOASID set, IOASID will
notify IOMMU and do all the cleanup.

For maintaining VMCS pasid translation table, KVM still need to know
bind/unbind in addition to free events.

In addition, we also have VDCM (virtual device composition module) that
needs to perform G-H PASID translation and sanity check. VDCM needs the
free event only. This is also in the DSA spec above. The use is that
when the guest programs a GPASID into a virtual device, VDCM (similar
to SRIOV PDEV driver) needs to intercept (via vfio mdev) and translate
GPASID to HPASID.

> Thanks,
> Jean
> 
> > IOMMU driver gets notified when IOASID is freed by VFIO or core mm
> > code such that PASID context can be cleaned up.
> > 
> > Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>  

[Jacob Pan]
