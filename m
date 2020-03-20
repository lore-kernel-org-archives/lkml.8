Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EA39C4332D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 16:10:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7806320739
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 16:10:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727485AbgCTQKA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 12:10:00 -0400
Received: from 8bytes.org ([81.169.241.247]:54560 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727403AbgCTQJ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 12:09:56 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id F26624BB; Fri, 20 Mar 2020 17:09:54 +0100 (CET)
Date:   Fri, 20 Mar 2020 17:09:53 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Will Deacon <will@kernel.org>
Cc:     iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robin.murphy@arm.com, jean-philippe@linaro.org,
        kernel-team@android.com
Subject: Re: [GIT PULL] iommu/arm-smmu: Updates for 5.7
Message-ID: <20200320160953.GG5122@8bytes.org>
References: <20200320153519.GB6815@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200320153519.GB6815@willie-the-truck>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 20, 2020 at 03:35:20PM +0000, Will Deacon wrote:
> Hi Joerg,
> 
> Please pull these Arm SMMU updates for 5.7. The summary is in the tag (which
> you may need to re-fetch if you've got my tree added as a remote).
> 
> Cheers,
> 
> Will
> 
> --->8
> 
> The following changes since commit f8788d86ab28f61f7b46eb6be375f8a726783636:
> 
>   Linux 5.6-rc3 (2020-02-23 16:17:42 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git tags/arm-smmu-updates

Pulled, thanks.

