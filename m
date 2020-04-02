Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81263C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 15:48:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F53320757
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 15:48:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389526AbgDBPsv convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 11:48:51 -0400
Received: from mga12.intel.com ([192.55.52.136]:37901 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388677AbgDBPsv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 11:48:51 -0400
IronPort-SDR: H982esY7z4C51MWKu7UzxnVZmuPDLnrp88z7d/saxkgo/29XNXC3R0AnqwQ3790uid28x6j9I2
 ifCRoNW5fPyw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2020 08:48:50 -0700
IronPort-SDR: KEe169meLIkf/vdOOwURi2neV19Ws31MpLRpkg89lEXup7r2SGjaTaWNXhMRk0b2QZoFy4X97l
 /vpNoWLNO2bQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,336,1580803200"; 
   d="scan'208";a="249872084"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga003.jf.intel.com with ESMTP; 02 Apr 2020 08:48:50 -0700
Date:   Thu, 2 Apr 2020 08:54:38 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Auger Eric <eric.auger@redhat.com>
Cc:     "Liu, Yi L" <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jonathan Cameron <jic23@kernel.org>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH V10 08/11] iommu/vt-d: Add svm/sva invalidate function
Message-ID: <20200402085438.38d7bd80@jacob-builder>
In-Reply-To: <d1cd2852-876a-b072-8576-962a6e61b9a9@redhat.com>
References: <1584746861-76386-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1584746861-76386-9-git-send-email-jacob.jun.pan@linux.intel.com>
        <AADFC41AFE54684AB9EE6CBC0274A5D19D7FA0AB@SHSMSX104.ccr.corp.intel.com>
        <3215b83c-81f7-a30f-fe82-a51f29d7b874@redhat.com>
        <AADFC41AFE54684AB9EE6CBC0274A5D19D800D67@SHSMSX104.ccr.corp.intel.com>
        <20200331135807.4e9976ab@jacob-builder>
        <AADFC41AFE54684AB9EE6CBC0274A5D19D803C33@SHSMSX104.ccr.corp.intel.com>
        <A2975661238FB949B60364EF0F2C25743A21D52E@SHSMSX104.ccr.corp.intel.com>
        <d1cd2852-876a-b072-8576-962a6e61b9a9@redhat.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Apr 2020 09:32:37 +0200
Auger Eric <eric.auger@redhat.com> wrote:

> > I didn’t read through all comments. Here is a concern with this 2-D
> > table, the iommu cache type is defined as below. I suppose there is
> > a problem here. If I'm using IOMMU_CACHE_INV_TYPE_PASID, it will
> > beyond the 2-D table.
> > 
> > /* IOMMU paging structure cache */
> > #define IOMMU_CACHE_INV_TYPE_IOTLB      (1 << 0) /* IOMMU IOTLB */
> > #define IOMMU_CACHE_INV_TYPE_DEV_IOTLB  (1 << 1) /* Device IOTLB */
> > #define IOMMU_CACHE_INV_TYPE_PASID      (1 << 2) /* PASID cache */
> > #define IOMMU_CACHE_INV_TYPE_NR         (3)  
> oups indeed

I think it is not an issue, since we use bit position not the raw cache
type as index into the 2D array. Right?

for_each_set_bit(cache_type, 

 ret = to_vtd_granularity(cache_type, inv_info->granularity, &

static inline int to_vtd_granularity(int type, int granu, int *vtd_granu)
{

	*vtd_granu = inv_type_granu_table[type][granu];
