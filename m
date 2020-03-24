Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C816C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 10:08:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6399120786
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 10:08:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727161AbgCXKIW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 06:08:22 -0400
Received: from 8bytes.org ([81.169.241.247]:55414 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726994AbgCXKIW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 06:08:22 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 998162E2; Tue, 24 Mar 2020 11:08:20 +0100 (CET)
Date:   Tue, 24 Mar 2020 11:08:19 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "guohanjun@huawei.com" <guohanjun@huawei.com>,
        Sudeep Holla <Sudeep.Holla@arm.com>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Will Deacon <will@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH v3 10/15] iommu/arm-smmu: Use accessor functions for
 iommu private data
Message-ID: <20200324100819.GA4038@8bytes.org>
References: <20200320091414.3941-1-joro@8bytes.org>
 <20200320091414.3941-11-joro@8bytes.org>
 <09ed4676-449e-c6eb-8c51-c15b326c206c@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09ed4676-449e-c6eb-8c51-c15b326c206c@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Robin,

On Mon, Mar 23, 2020 at 04:02:33PM +0000, Robin Murphy wrote:
> Yikes, this ends up pretty ugly, and I'd prefer not have this much
> complexity hidden in macros that were intended just to be convenient
> shorthand. Would you mind pulling in the patch below as a precursor?

Sure thing, but your mail-client seemed to have fiddled with the patch
so that is is unusable to me. I tried to fix it up, but it still doesn't
apply. Can you please re-send it to me either via git-send-email or just
as a mime-attachement?

> Other than that, the rest of the series looks OK at a glance. We should also
> move fwspec->ops to dev_iommu, as those are "IOMMU API" data rather than
> "firmware" data, but let's consider that separately as this series is
> already long enough.

Yes, moving ops out of fwspec is next on the list, and moving the
iommu_group pointer into dev_iommu.

Regards,

	Joerg

