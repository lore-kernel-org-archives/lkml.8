Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45F8FC43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 17:07:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E64C82071A
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 17:07:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732609AbgDARHn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 13:07:43 -0400
Received: from mga07.intel.com ([134.134.136.100]:21353 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732273AbgDARHn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 13:07:43 -0400
IronPort-SDR: HC3QAmG6qRIx1aO4xUx7EN0BRwf4r1fUnkuJRCHUrhH8W7cYHZoGGjBp/CHbnt/KEUrRokEuXC
 /Cqa/RILpwdQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2020 10:07:42 -0700
IronPort-SDR: oQipLpnApWd0p+CgyFBkSRZiHFTfxhOuwvsqHh1iQub51HAu+NxoD5fHDo9HsHXa60RzSslzN3
 Yx50zav9Uwzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,332,1580803200"; 
   d="scan'208";a="249528821"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga003.jf.intel.com with ESMTP; 01 Apr 2020 10:07:42 -0700
Date:   Wed, 1 Apr 2020 10:13:30 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        "Alex Williamson" <alex.williamson@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Jonathan Cameron" <jic23@kernel.org>,
        Eric Auger <eric.auger@redhat.com>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH V10 06/11] iommu/vt-d: Add bind guest PASID support
Message-ID: <20200401101330.275f6e34@jacob-builder>
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D19D800EEC@SHSMSX104.ccr.corp.intel.com>
References: <1584746861-76386-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1584746861-76386-7-git-send-email-jacob.jun.pan@linux.intel.com>
        <AADFC41AFE54684AB9EE6CBC0274A5D19D7F77B4@SHSMSX104.ccr.corp.intel.com>
        <20200330135138.556ea8a4@jacob-builder>
        <AADFC41AFE54684AB9EE6CBC0274A5D19D800EEC@SHSMSX104.ccr.corp.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Mar 2020 03:43:39 +0000
"Tian, Kevin" <kevin.tian@intel.com> wrote:

> > > >  struct intel_svm_dev {
> > > > @@ -698,9 +700,13 @@ struct intel_svm_dev {
> > > >  struct intel_svm {
> > > >  	struct mmu_notifier notifier;
> > > >  	struct mm_struct *mm;
> > > > +
> > > >  	struct intel_iommu *iommu;
> > > >  	int flags;
> > > >  	int pasid;
> > > > +	int gpasid; /* Guest PASID in case of vSVA bind with
> > > > non-identity host
> > > > +		     * to guest PASID mapping.
> > > > +		     */  
> > >
> > > we don't need to highlight identity or non-identity thing, since
> > > either way shares the same infrastructure here and it is not the
> > > knowledge that the kernel driver should assume
> > >  
> > Sorry, I don't get your point.
> > 
> > What I meant was that this field "gpasid" is only used for
> > non-identity case. For identity case, we don't have
> > SVM_FLAG_GUEST_PASID.  
> 
> what's the problem if a guest tries to set gpasid even in identity
> case? do you want to add check to reject it? Also I remember we
> discussed before that we want to provide a consistent interface 
> to other consumer e.g. KVM to setup VMCS PASID translation table.
> In that case, regardless of identity or non-identity, we need provide
> such mapping info.
The solution is in flux a little. For KVM to set up VMCS, we are
planning to use IOASID set private ID as guest PASID. So this part of
the code will go away, i.e. G-H PASID mapping will no longer stored in
IOMMU driver. Perhaps we can address this after the transition?
