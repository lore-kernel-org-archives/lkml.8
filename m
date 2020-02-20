Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5C77C5ACC4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 02:49:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B69C121D56
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 02:49:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727885AbgBTCtm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 21:49:42 -0500
Received: from mga09.intel.com ([134.134.136.24]:43079 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727211AbgBTCtm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 21:49:42 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Feb 2020 18:49:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,462,1574150400"; 
   d="scan'208";a="228782315"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.249.162.231]) ([10.249.162.231])
  by fmsmga007.fm.intel.com with ESMTP; 19 Feb 2020 18:49:39 -0800
Subject: Re: question about iommu_need_mapping
To:     Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20200219235516.zl44y7ydgqqja6x5@cantor>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <af5a148e-76bc-4aa4-dd1c-b04a5ffc56b1@linux.intel.com>
Date:   Thu, 20 Feb 2020 10:49:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200219235516.zl44y7ydgqqja6x5@cantor>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jerry,

On 2020/2/20 7:55, Jerry Snitselaar wrote:
> Is it possible for a device to end up with dev->archdata.iommu == NULL
> on iommu_need_mapping in the following instance:
> 
> 1. iommu_group has dma domain for default
> 2. device gets private identity domain in intel_iommu_add_device
> 3. iommu_need_mapping gets called with that device.
> 4. dmar_remove_one_dev_info sets dev->archdata.iommu = NULL via 
> unlink_domain_info.
> 5. request_default_domain_for_dev exits after checking that 
> group->default_domain
>     exists, and group->default_domain->type is dma.
> 6. iommu_request_dma_domain_for_dev returns 0 from 
> request_default_domain_for_dev
>     and a private dma domain isn't created for the device.
> 

Yes. It's possible.

> The case I was seeing went away with commit 9235cb13d7d1 ("iommu/vt-d:
> Allow devices with RMRRs to use identity domain"), because it changed
> which domain the group and devices were using, but it seems like it is
> still a possibility with the code. Baolu, you mentioned possibly
> removing the domain switch. Commit 98b2fffb5e27 ("iommu/vt-d: Handle
> 32bit device with identity default domain") makes it sound like the
> domain switch is required.

It's more "nice to have" than "required" if the iommu driver doesn't
disable swiotlb explicitly. The device access of system memory higher
than the device's addressing capability could go through the bounced
buffer implemented in swiotlb.

Best regards,
baolu
