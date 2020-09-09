Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A559C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 17:11:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51E922087C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 17:11:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730550AbgIIRLI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 13:11:08 -0400
Received: from mga11.intel.com ([192.55.52.93]:19272 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730317AbgIIRK6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 13:10:58 -0400
IronPort-SDR: 4bZWr28V0muMRHpAwVI5HolmG70awak0f/3q3YhNfoSgXz6NVkQIc09KFxNKdXWWY+Uxn0iE4d
 fHV/EtUi0Ubw==
X-IronPort-AV: E=McAfee;i="6000,8403,9739"; a="155842243"
X-IronPort-AV: E=Sophos;i="5.76,409,1592895600"; 
   d="scan'208";a="155842243"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2020 10:10:56 -0700
IronPort-SDR: 5qT68Jsn0cJQAktVnxQeDCfV8fH0mpJfxEtiS+SvivGmWwong8TxccfnMWaV91WoWzHQrBbXr3
 ET5pqWXNskJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,409,1592895600"; 
   d="scan'208";a="333886837"
Received: from otc-nc-03.jf.intel.com (HELO otc-nc-03) ([10.54.39.36])
  by orsmga008.jf.intel.com with ESMTP; 09 Sep 2020 10:10:56 -0700
Date:   Wed, 9 Sep 2020 10:10:56 -0700
From:   "Raj, Ashok" <ashok.raj@intel.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     dwmw2@infradead.org, baolu.lu@linux.intel.com, joro@8bytes.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        eperezma@redhat.com, peterx@redhat.com, mst@redhat.com,
        stable@vger.kernel.org, Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH] intel-iommu: don't disable ATS for device without page
 aligned request
Message-ID: <20200909171056.GF104641@otc-nc-03>
References: <20200909083432.9464-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200909083432.9464-1-jasowang@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason

On Wed, Sep 09, 2020 at 04:34:32PM +0800, Jason Wang wrote:
> Commit 61363c1474b1 ("iommu/vt-d: Enable ATS only if the device uses
> page aligned address.") disables ATS for device that can do unaligned
> page request.

Did you take a look at the PCI specification?
Page Aligned Request is in the ATS capability Register.

ATS Capability Register (Offset 0x04h)

bit (5):
Page Aligned Request - If Set, indicates the Untranslated address is always
aligned to 4096 byte boundary. Setting this field is recommended. This
field permits software to distinguish between implemntations compatible
with this specification and those compatible with an earlier version of
this specification in which a Requester was permitted to supply anything in
bits [11:2].

> 
> This looks wrong, since the commit log said it's because the page
> request descriptor doesn't support reporting unaligned request.

I don't think you can change the definition from ATS to PRI. Both are
orthogonal feature.

> 
> A victim is Qemu's virtio-pci which doesn't advertise the page aligned
> address. Fixing by disable PRI instead of ATS if device doesn't have
> page aligned request.

This is a requirement for the Intel IOMMU's.

You say virtio, so is it all emulated device or you talking about some
hardware that implemented virtio-pci compliant hw? If you are sure the
device actually does comply with the requirement, but just not enumerating
the capability, you can maybe work a quirk to overcome that?

Now PRI also has an alignment requirement, and Intel IOMMU's requires that
as well. If your device supports SRIOV as well, PASID and PRI are
enumerated just on the PF and not the VF. You might want to pay attension
to that. We are still working on a solution for that problem.

I don't think this is the right fix for your problem. 

> 
> Cc: stable@vger.kernel.org
> Cc: Ashok Raj <ashok.raj@intel.com>
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: Keith Busch <keith.busch@intel.com>
> Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/iommu/intel/iommu.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
