Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87A7EC83003
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 04:09:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5781920731
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 04:09:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="GmElLMCX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbgD2EJm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 00:09:42 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:17644 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725497AbgD2EJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 00:09:42 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588133381; h=In-Reply-To: Content-Type: MIME-Version:
 References: Reply-To: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=ZygyuDR/+QYBGGocHbLP5ReISc55KGqtsbV+9Eyjzc4=; b=GmElLMCXAefxRkR0FqYR/fjHxFWbTExS64AKUOtvocZXfrkZ1o4ACkSi7pUXpFyQI1Smk3+f
 xo4iSIfxwVflZuI+XeV3X6Pr6yOkGaS2/D9uvwL8do7kGztjgN9X45L3w2KqedJ19z76kNTG
 paimqlPu5UeIcFUKCjQm2nHCj3M=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ea8fe03.7f04b35b69d0-smtp-out-n04;
 Wed, 29 Apr 2020 04:09:39 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id EC051C433F2; Wed, 29 Apr 2020 04:09:37 +0000 (UTC)
Received: from quicinc.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: svaddagi)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5AB9AC433CB;
        Wed, 29 Apr 2020 04:09:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5AB9AC433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=vatsa@codeaurora.org
Date:   Wed, 29 Apr 2020 09:39:29 +0530
From:   Srivatsa Vaddagiri <vatsa@codeaurora.org>
To:     Stefano Stabellini <sstabellini@kernel.org>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>, konrad.wilk@oracle.com,
        jasowang@redhat.com, jan.kiszka@siemens.com, will@kernel.org,
        stefano.stabellini@xilinx.com, iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org,
        virtio-dev@lists.oasis-open.org, tsoni@codeaurora.org,
        pratikp@codeaurora.org, christoffer.dall@arm.com,
        alex.bennee@linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] virtio: Add bounce DMA ops
Message-ID: <20200429040929.GC5097@quicinc.com>
Reply-To: Srivatsa Vaddagiri <vatsa@codeaurora.org>
References: <1588073958-1793-1-git-send-email-vatsa@codeaurora.org>
 <1588073958-1793-6-git-send-email-vatsa@codeaurora.org>
 <20200428121232-mutt-send-email-mst@kernel.org>
 <20200428174952.GA5097@quicinc.com>
 <20200428163448-mutt-send-email-mst@kernel.org>
 <alpine.DEB.2.21.2004281556180.29217@sstabellini-ThinkPad-T480s>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2004281556180.29217@sstabellini-ThinkPad-T480s>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Stefano Stabellini <sstabellini@kernel.org> [2020-04-28 16:04:34]:

> > > Is swiotlb commonly used for multiple devices that may be on different trust
> > > boundaries (and not behind a hardware iommu)?
> 
> The trust boundary is not a good way of describing the scenario and I
> think it leads to miscommunication.
> 
> A better way to describe the scenario would be that the device can only
> DMA to/from a small reserved-memory region advertised on device tree.
> 
> Do we have other instances of devices that can only DMA to/from very
> specific and non-configurable address ranges? If so, this series could
> follow their example.

AFAICT there is no such notion in current DMA API.

static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size,
                bool is_ram)
{
        return end <= min_not_zero(*dev->dma_mask, dev->bus_dma_limit);
}

Only the max address a device can access is defined and not a range that we seem
to need here. I think we need to set the bus_dma_limit to 0 for virtio devices
which will force the use of swiotlb_map API. We should also have a per-device
swiotlb pool defined, so that swiotlb can use the pool meant for the given
device.

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
