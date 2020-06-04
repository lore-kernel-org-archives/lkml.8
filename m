Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05A33C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 00:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA10E20738
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 00:17:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbgFDARE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 20:17:04 -0400
Received: from mga02.intel.com ([134.134.136.20]:50997 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725946AbgFDARD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 20:17:03 -0400
IronPort-SDR: +rFKHX+H3B2p2Sp+AnAYvHeJHdAEWNAhXQBxGVo+cD5HjfkfpPWJNDhlAgPtq1jsix+hJjNTF8
 Gz+ektxfNe0Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2020 17:17:03 -0700
IronPort-SDR: sPBO2MhJa/2O5WbvWn1JQCmgd3+rjkI/Y5faZkoSCUZXYwyxGD01/SMaTFrDfd3dXrYc1xhz1g
 +NSZ/hoIN89Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,470,1583222400"; 
   d="scan'208";a="294150329"
Received: from allen-box.sh.intel.com (HELO [10.239.159.139]) ([10.239.159.139])
  by fmsmga004.fm.intel.com with ESMTP; 03 Jun 2020 17:17:01 -0700
Cc:     baolu.lu@linux.intel.com, David Woodhouse <dwmw2@infradead.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>, Qian Cai <cai@lca.pw>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] iommu: Move Intel and AMD drivers into their own
 subdirectory
To:     Joerg Roedel <joro@8bytes.org>
References: <20200602092616.24638-1-joro@8bytes.org>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <148834f4-849e-acf1-c347-e25093aac518@linux.intel.com>
Date:   Thu, 4 Jun 2020 08:13:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200602092616.24638-1-joro@8bytes.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joerg,

On 6/2/20 5:26 PM, Joerg Roedel wrote:
> Hi,
> 
> two small patches to move the Intel and AMD IOMMU drivers into their own
> subdirectory under drivers/iommu/ to make the file structure a bit less
> cluttered.
> 

Does the MAINTAINERS file need to update?

Best regards,
baolu

> Regards,
> 
> 	Joerg
> 
> Joerg Roedel (2):
>    iommu/amd: Move AMD IOMMU driver into subdirectory
>    iommu/vt-d: Move Intel IOMMU driver into subdirectory
> 
>   drivers/iommu/Makefile                         | 18 +++++++++---------
>   drivers/iommu/{ => amd}/amd_iommu.h            |  0
>   drivers/iommu/{ => amd}/amd_iommu_types.h      |  0
>   .../{amd_iommu_debugfs.c => amd/debugfs.c}     |  0
>   drivers/iommu/{amd_iommu_init.c => amd/init.c} |  2 +-
>   drivers/iommu/{amd_iommu.c => amd/iommu.c}     |  2 +-
>   .../iommu/{amd_iommu_v2.c => amd/iommu_v2.c}   |  0
>   .../iommu/{amd_iommu_quirks.c => amd/quirks.c} |  0
>   .../{intel-iommu-debugfs.c => intel/debugfs.c} |  0
>   drivers/iommu/{ => intel}/dmar.c               |  2 +-
>   drivers/iommu/{ => intel}/intel-pasid.h        |  0
>   drivers/iommu/{intel-iommu.c => intel/iommu.c} |  2 +-
>   .../irq_remapping.c}                           |  2 +-
>   drivers/iommu/{intel-pasid.c => intel/pasid.c} |  0
>   drivers/iommu/{intel-svm.c => intel/svm.c}     |  0
>   drivers/iommu/{intel-trace.c => intel/trace.c} |  0
>   16 files changed, 14 insertions(+), 14 deletions(-)
>   rename drivers/iommu/{ => amd}/amd_iommu.h (100%)
>   rename drivers/iommu/{ => amd}/amd_iommu_types.h (100%)
>   rename drivers/iommu/{amd_iommu_debugfs.c => amd/debugfs.c} (100%)
>   rename drivers/iommu/{amd_iommu_init.c => amd/init.c} (99%)
>   rename drivers/iommu/{amd_iommu.c => amd/iommu.c} (99%)
>   rename drivers/iommu/{amd_iommu_v2.c => amd/iommu_v2.c} (100%)
>   rename drivers/iommu/{amd_iommu_quirks.c => amd/quirks.c} (100%)
>   rename drivers/iommu/{intel-iommu-debugfs.c => intel/debugfs.c} (100%)
>   rename drivers/iommu/{ => intel}/dmar.c (99%)
>   rename drivers/iommu/{ => intel}/intel-pasid.h (100%)
>   rename drivers/iommu/{intel-iommu.c => intel/iommu.c} (99%)
>   rename drivers/iommu/{intel_irq_remapping.c => intel/irq_remapping.c} (99%)
>   rename drivers/iommu/{intel-pasid.c => intel/pasid.c} (100%)
>   rename drivers/iommu/{intel-svm.c => intel/svm.c} (100%)
>   rename drivers/iommu/{intel-trace.c => intel/trace.c} (100%)
> 
