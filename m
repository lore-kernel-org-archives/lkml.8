Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EECE9C33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 10:02:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAC2B2073A
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 10:02:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbgAQKC7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 05:02:59 -0500
Received: from 8bytes.org ([81.169.241.247]:60110 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726220AbgAQKC6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 05:02:58 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id F0116327; Fri, 17 Jan 2020 11:02:56 +0100 (CET)
Date:   Fri, 17 Jan 2020 11:02:55 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Will Deacon <will@kernel.org>
Cc:     iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robin.murphy@arm.com, jean-philippe@linaro.org,
        kernel-team@android.com
Subject: Re: [GIT PULL] iommu/arm-smmu: Updates for 5.6
Message-ID: <20200117100255.GC15760@8bytes.org>
References: <20200116102548.GA14761@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200116102548.GA14761@willie-the-truck>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 16, 2020 at 10:25:49AM +0000, Will Deacon wrote:
> Hi Joerg,
> 
> Please pull these Arm SMMU updates for 5.6. The branch is based on your
> arm/smmu branch and includes a patch addressing the feedback from Greg
> about setting the module 'owner' field in the 'iommu_ops'.
> 
> I've used a signed tag this time, so you can see the summary of the
> changes listed in there. The big deal is that we're laying the groundwork
> for PCIe PASID support in SMMUv3, and I expect to hook that up for PCIe
> masters in 5.7 once we've exported the necessary symbols to do so.
> 
> Cheers,
> 
> Will
> 
> --->8
> 
> The following changes since commit 1ea27ee2f76e67f98b9942988f1336a70d351317:
> 
>   iommu/arm-smmu: Update my email address in MODULE_AUTHOR() (2019-12-23 14:06:06 +0100)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git tags/arm-smmu-updates

Pulled, thanks Will.

