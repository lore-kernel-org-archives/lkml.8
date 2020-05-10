Return-Path: <SRS0=j177=6Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D072C38A2A
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 23:20:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 282C720725
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 23:19:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729126AbgEJXT5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 19:19:57 -0400
Received: from mga14.intel.com ([192.55.52.115]:32356 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728856AbgEJXT5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 19:19:57 -0400
IronPort-SDR: femZO/HCqNMpkjA8ITOUxLmQowXiHgEsTYM8bF9njviYDF0ZEUzt53m+B/VDTvJNNNmlCjUpIk
 EUoATwhVX2zA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2020 16:19:56 -0700
IronPort-SDR: bMVr+HfzhLC7IDcW8Rgd6plGgxxu9+/Eji/jiXNKDERKa1e19pHZ6VicKFtf8Dpfrh0Rmd2H7z
 fTYtNw4Yfwng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,377,1583222400"; 
   d="scan'208";a="279614189"
Received: from allen-box.sh.intel.com (HELO [10.239.159.139]) ([10.239.159.139])
  by orsmga002.jf.intel.com with ESMTP; 10 May 2020 16:19:53 -0700
Cc:     baolu.lu@linux.intel.com, ashok.raj@intel.com,
        jacob.jun.pan@linux.intel.com, kevin.tian@intel.com,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Daniel Drake <drake@endlessm.com>,
        Derrick Jonathan <jonathan.derrick@intel.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v4 0/3] Replace private domain with per-group default
 domain
To:     Joerg Roedel <joro@8bytes.org>
References: <20200506015947.28662-1-baolu.lu@linux.intel.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <7928dd48-93da-62f0-b455-6e6b248d0fae@linux.intel.com>
Date:   Mon, 11 May 2020 07:16:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200506015947.28662-1-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joerg,

On 5/6/20 9:59 AM, Lu Baolu wrote:
> Some devices are required to use a specific type (identity or dma) of
> default domain when they are used with a vendor iommu. When the system
> level default domain type is different from it, the vendor iommu driver
> has to request a new default domain with either
> iommu_request_dma_domain_for_dev() or iommu_request_dm_for_dev() in the
> add_dev() callback. Unfortunately, these two helpers only work when the
> group hasn't been assigned to any other devices, hence, some vendor iommu
> driver has to use a private domain if it fails to request a new default
> one.
> 
> Joerg proposed an on-going proposal which makes the default domain
> framework to support configuring per-group default domain during boot
> process.
> 
> https://lkml.org/lkml/2020/4/14/616
> [This has been applied in iommu/next.]
> 
> Hence, there is no need to keep the private domain implementation
> in the Intel IOMMU driver. This patch series aims to remove it.

Can you please take this series to iommu/next for wider test?

Best regards,
baolu
