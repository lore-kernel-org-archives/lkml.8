Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46A19C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 15:22:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20B0F20786
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 15:22:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730136AbgGHPW1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 11:22:27 -0400
Received: from mga02.intel.com ([134.134.136.20]:38714 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729915AbgGHPW1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 11:22:27 -0400
IronPort-SDR: E7/9L/vRGeGTk0dsKmw7uTnatTa40VxW4iH0mjXlJpysKzJaXEjwEm5zXfQmoiDDtLWEwi8MVj
 HDglnXduxxRg==
X-IronPort-AV: E=McAfee;i="6000,8403,9676"; a="136057806"
X-IronPort-AV: E=Sophos;i="5.75,327,1589266800"; 
   d="scan'208";a="136057806"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2020 08:22:27 -0700
IronPort-SDR: Bm2u0Vasa2bnwwN+WYUNG+lwMSlKRZ0VAGFlbB/8mL6kec0+obJsV1ZPaOMAL6W2B8XTK94Vnj
 geu4Bkd0fXwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,327,1589266800"; 
   d="scan'208";a="427869822"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga004.jf.intel.com with ESMTP; 08 Jul 2020 08:22:26 -0700
Date:   Wed, 8 Jul 2020 08:29:05 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Eric Auger <eric.auger@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v4 1/5] docs: IOMMU user API
Message-ID: <20200708082905.1b5da847@jacob-builder>
In-Reply-To: <6d01dac0-aa9d-e22b-9baf-28c2f538871a@linux.intel.com>
References: <1594165429-20075-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1594165429-20075-2-git-send-email-jacob.jun.pan@linux.intel.com>
        <6d01dac0-aa9d-e22b-9baf-28c2f538871a@linux.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Jul 2020 10:07:13 +0800
Lu Baolu <baolu.lu@linux.intel.com> wrote:

> Hi,
> 
> On 7/8/20 7:43 AM, Jacob Pan wrote:
> > +For UAPIs that are shared with in-kernel users, a wrapper function
> > +is provided to distinguish the callers. For example,
> > +
> > +Userspace caller ::
> > +
> > +  int iommu_sva_unbind_gpasid(struct iommu_domain *domain, struct
> > device *dev,
> > +  void __user *udata)
> > +
> > +In-kernel caller ::
> > +
> > +  int __iommu_sva_unbind_gpasid(struct iommu_domain *domain,
> > struct device *dev,
> > +  struct iommu_gpasid_bind_data *data)  
> 
> iommu_page_response() may have the same needs. Can we reach an
> agreement on the naming rules?
> 
Yes iommu_page_response() also has to deal with in-kernel and UAPI
callers. I left it out because I thought the current VFIO and SVA common
code is not ready for PRQ yet, I might be reading old news :) argsz
need to be handled as well.

Perhaps we can wait until this set is settled? Do you have a suggestion
on the naming rules?

> Best regards,
> baolu

[Jacob Pan]
