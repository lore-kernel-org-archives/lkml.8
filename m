Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E2CFC2D0EC
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 21:00:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ADA12078E
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 21:00:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbgDJVAN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 17:00:13 -0400
Received: from mga14.intel.com ([192.55.52.115]:62407 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726626AbgDJVAN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 17:00:13 -0400
IronPort-SDR: /6Jpw9AjGqv0HfoXe12urdgNlo3fNMB+cC6dJbUyuYgpQf4Y4SAlFuKlLhITyKAzABTCGGcrgP
 C1oCBkrvuJJQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2020 14:00:12 -0700
IronPort-SDR: hw8vPaWSQRseTrREmDo4wEHF8666mtcHFEvvy/V5KhBxJx+IhmwkOEeDDxYKUMPmn9738D0XY4
 XhMcrt1ZGmBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,368,1580803200"; 
   d="scan'208";a="331278002"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga001.jf.intel.com with ESMTP; 10 Apr 2020 14:00:12 -0700
Date:   Fri, 10 Apr 2020 14:06:04 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Auger Eric <eric.auger@redhat.com>
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Yi L <yi.l.liu@linux.intel.com>, jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v11 05/10] iommu/vt-d: Add bind guest PASID support
Message-ID: <20200410140604.403cb5b2@jacob-builder>
In-Reply-To: <ab57b85b-235f-dc80-1c25-9b3d42dc5f4e@redhat.com>
References: <1585939334-21396-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1585939334-21396-6-git-send-email-jacob.jun.pan@linux.intel.com>
        <ab57b85b-235f-dc80-1c25-9b3d42dc5f4e@redhat.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

Missed a few things in the last reply.

On Thu, 9 Apr 2020 09:41:32 +0200
Auger Eric <eric.auger@redhat.com> wrote:

> > +			intel_pasid_tear_down_entry(iommu, dev,
> > svm->pasid);  
> intel_svm_unbind_mm() calls intel_flush_svm_range_dev(svm, sdev, 0,
> -1, 0); Don't we need to flush the (DEV-)IOTLBs as well?
Right, pasid tear down should always include (DEV-)IOTLB flush, I
initially thought it is taken care of by intel_pasid_tear_down_entry().

> > +			/* TODO: Drain in flight PRQ for the PASID
> > since it
> > +			 * may get reused soon, we don't want to
> > +			 * confuse with its previous life.
> > +			 * intel_svm_drain_prq(dev, pasid);
> > +			 */
> > +			kfree_rcu(sdev, rcu);
> > +
> > +			if (list_empty(&svm->devs)) {
> > +				/*
> > +				 * We do not free the IOASID here
> > in that
> > +				 * IOMMU driver did not allocate
> > it.  
> s/in/as?
I meant to say "in that" as "for the reason that"

> > +				 * Unlike native SVM, IOASID for
> > guest use was
> > +				 * allocated prior to the bind
> > call.> +				 * In any case, if the free
> > call comes before
> > +				 * the unbind, IOMMU driver will
> > get notified
> > +				 * and perform cleanup.
> > +				 */
> > +				ioasid_set_data(pasid, NULL);
> > +				kfree(svm);
> > +			}  
> nit: you may use intel_svm_free_if_empty()
True, but I meant to insert ioasid_notifier under the list_empty
condition in the following ioasid patch.


Thanks,

Jacob
