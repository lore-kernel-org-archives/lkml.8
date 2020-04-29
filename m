Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DA5EC83000
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 22:24:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DA5320757
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 22:24:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbgD2WYD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 18:24:03 -0400
Received: from mga17.intel.com ([192.55.52.151]:33252 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726481AbgD2WYD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 18:24:03 -0400
IronPort-SDR: VbB/PxLe7O+XOG0Mfkp26ZuSwxjYA41HyRrTcWmnKUSDLoINR5ykWS2ZbnUkapG7Hce/Nmoq9a
 8HpBNVo6mDcg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2020 15:24:02 -0700
IronPort-SDR: QmHGe38YMh/15b3Az8RAY2FiSQGf0moHXjggntwMvaFvKgufCh1vejIfwUqtMw+VgsIpnWWIlK
 tYmtAtx/DxNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,333,1583222400"; 
   d="scan'208";a="367944111"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by fmsmga001.fm.intel.com with ESMTP; 29 Apr 2020 15:24:01 -0700
Date:   Wed, 29 Apr 2020 15:30:03 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Auger Eric <eric.auger@redhat.com>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jonathan Cameron <jic23@kernel.org>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v12 4/8] iommu/vt-d: Add bind guest PASID support
Message-ID: <20200429153003.31d2edf7@jacob-builder>
In-Reply-To: <72d52eba-8c78-9d99-2537-b03dbfb3b543@redhat.com>
References: <1587495165-80096-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1587495165-80096-5-git-send-email-jacob.jun.pan@linux.intel.com>
        <AADFC41AFE54684AB9EE6CBC0274A5D19D8A0D03@SHSMSX104.ccr.corp.intel.com>
        <20200427133409.47ba22b2@jacob-builder>
        <72d52eba-8c78-9d99-2537-b03dbfb3b543@redhat.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Apr 2020 16:12:01 +0200
Auger Eric <eric.auger@redhat.com> wrote:

> >> in last review Eric raised the open about what about binding the
> >> same PASID to the same pdev multiple times. We discussed that
> >> should be disallowed. Here can you check whether aux_domain is
> >> enabled on pdev to restrict multiple-binding only for
> >> sub-devices?  
> > Why aux_domain is sufficient? A pdev could have aux_domain enabled
> > but still bind pdev many times more than its mdevs.
> > 
> > Either we allow multiple bind or not.  
> 
> I tried to figure out whether binding the same PASID to the same pdev
> was meaningful. I understood it is not. If this case can be detected
> at VFIO level I am fine as well.
I will remove the multiple bind support for now. Reintroduce it when we
enable mdev.

Thanks,

Jacob
