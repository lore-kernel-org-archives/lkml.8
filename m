Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FCBCC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 15:41:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 813FB20720
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 15:41:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404550AbgFXPla (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 11:41:30 -0400
Received: from mga02.intel.com ([134.134.136.20]:53746 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404356AbgFXPla (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 11:41:30 -0400
IronPort-SDR: /dKZZC3IHU89Vjlqf8qN+gf+p9lZBlhyXxmvm1h+8EeTQBkt+Z6N2IraLgqTa5/n9q+szumlPu
 2mAE7yh78U8g==
X-IronPort-AV: E=McAfee;i="6000,8403,9662"; a="132949564"
X-IronPort-AV: E=Sophos;i="5.75,275,1589266800"; 
   d="scan'208";a="132949564"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2020 08:41:30 -0700
IronPort-SDR: rzdLG36kkSS7oyD7HLRd8ixwCO09LluAN6+s2jm/57l2vznZFZ8k/4vp/rSV+PmGUhPAWXkTGI
 EZ7XvfSZV1wA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,275,1589266800"; 
   d="scan'208";a="275729014"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga003.jf.intel.com with ESMTP; 24 Jun 2020 08:41:29 -0700
Date:   Wed, 24 Jun 2020 08:48:01 -0700
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
Subject: Re: [PATCH v3 3/5] iommu/uapi: Use named union for user data
Message-ID: <20200624084801.297c9c0b@jacob-builder>
In-Reply-To: <96f6d717-e9b3-2a6b-5cff-c38dbe97aa7c@linux.intel.com>
References: <1592931837-58223-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1592931837-58223-4-git-send-email-jacob.jun.pan@linux.intel.com>
        <96f6d717-e9b3-2a6b-5cff-c38dbe97aa7c@linux.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Jun 2020 14:29:57 +0800
Lu Baolu <baolu.lu@linux.intel.com> wrote:

> >   		case IOMMU_CACHE_INV_TYPE_IOTLB:
> >   			/* HW will ignore LSB bits based on
> > address mask */ if (inv_info->granularity == IOMMU_INV_GRANU_ADDR &&
> >   			    size &&
> > -			    (inv_info->addr_info.addr &
> > ((BIT(VTD_PAGE_SHIFT + size)) - 1))) {
> > +				(inv_info->granu.addr_info.addr &
> > ((BIT(VTD_PAGE_SHIFT + size)) - 1))) {  
> 
> Nit: Keep it aligned. With this tweaked,
> 
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
will do. Thanks.
