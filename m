Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A576DC4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 14:10:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8140C20CC7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 14:10:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727427AbgCSOKe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 10:10:34 -0400
Received: from 8bytes.org ([81.169.241.247]:53860 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727141AbgCSOKe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 10:10:34 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 198871E6; Thu, 19 Mar 2020 15:10:32 +0100 (CET)
Date:   Thu, 19 Mar 2020 15:10:30 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     ashok.raj@intel.com, jacob.jun.pan@linux.intel.com,
        kevin.tian@intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Liu Yi L <yi.l.liu@intel.com>
Subject: Re: [PATCH 1/1] iommu/vt-d: Fix page request descriptor size
Message-ID: <20200319141029.GB5122@8bytes.org>
References: <20200317011018.22799-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200317011018.22799-1-baolu.lu@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 17, 2020 at 09:10:18AM +0800, Lu Baolu wrote:
> From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> 
> Intel VT-d might support PRS (Page Reqest Support) when it's
> running in the scalable mode. Each page request descriptor
> occupies 32 bytes and is 32-bytes aligned. The page request
> descriptor offset mask should be 32-bytes aligned.
> 
> Fixes: 5b438f4ba315d ("iommu/vt-d: Support page request in scalable mode")
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel-svm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

