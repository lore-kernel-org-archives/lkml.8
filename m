Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 703E2C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 10:07:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46ACB2073E
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 10:07:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728286AbgEOKHV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 06:07:21 -0400
Received: from 8bytes.org ([81.169.241.247]:43136 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728007AbgEOKHV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 06:07:21 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 27896379; Fri, 15 May 2020 12:07:20 +0200 (CEST)
Date:   Fri, 15 May 2020 12:07:18 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Joerg Roedel <jroedel@suse.de>,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2 23/33] iommu/mediatek-v1 Convert to
 probe/release_device() call-backs
Message-ID: <20200515100718.GS18353@8bytes.org>
References: <20200414131542.25608-1-joro@8bytes.org>
 <20200414131542.25608-24-joro@8bytes.org>
 <1589528699.26119.9.camel@mhfsdcap03>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589528699.26119.9.camel@mhfsdcap03>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, May 15, 2020 at 03:44:59PM +0800, Yong Wu wrote:
> On Tue, 2020-04-14 at 15:15 +0200, Joerg Roedel wrote:
> > -	return iommu_device_link(&data->iommu, dev);
> > +	err = arm_iommu_attach_device(dev, mtk_mapping);
> > +	if (err)
> > +		dev_err(dev, "Can't create IOMMU mapping - DMA-OPS will not work\n");
> 
> 
> Hi Joerg,
> 
>      Thanks very much for this patch.
> 
>      This arm_iommu_attach_device is called just as we expected.
> 
>      But it will fail in this callstack as the group->mutex was tried to
> be re-locked...
> 
> [<c0938e8c>] (iommu_attach_device) from [<c0317590>]
> (__arm_iommu_attach_device+0x34/0x90)
> [<c0317590>] (__arm_iommu_attach_device) from [<c03175f8>]
> (arm_iommu_attach_device+0xc/0x20)
> [<c03175f8>] (arm_iommu_attach_device) from [<c09432cc>]
> (mtk_iommu_probe_finalize+0x34/0x50)
> [<c09432cc>] (mtk_iommu_probe_finalize) from [<c093a8ac>]
> (bus_iommu_probe+0x2a8/0x2c4)
> [<c093a8ac>] (bus_iommu_probe) from [<c093a950>] (bus_set_iommu
> +0x88/0xd4)
> [<c093a950>] (bus_set_iommu) from [<c0943c74>] (mtk_iommu_probe
> +0x2f8/0x364)

Thanks for the report, is

	https://lore.kernel.org/lkml/1589530123-30240-1-git-send-email-yong.wu@mediatek.com/

The fix for this issue or is something else required?


Thanks,

	Joerg
