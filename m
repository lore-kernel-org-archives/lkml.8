Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F0CFC83001
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 17:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD1CD20757
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 17:50:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="uHXUgMQF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728585AbgD1RuQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 13:50:16 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:38252 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728557AbgD1RuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 13:50:14 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588096214; h=In-Reply-To: Content-Type: MIME-Version:
 References: Reply-To: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=RU7G35ytN1BEFIjXJLTsdCsbIgjwEPp3gbageUwxBUA=; b=uHXUgMQFCKzNWvCslqSJ3mgoYDLvUikTrnKow3d296SFYBVV5HKdJi39+I2Xudja7EUJBo91
 3eet8ltre2BN/Hrg4ItHQFTQ0A18ebgeiQzGX0PdhUtBUMZ5bWa0k3V1cuP7rqw3UXTkfR6l
 r6InaRzNTr8tjgO0h5GuKC9Xz18=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ea86cc8.7fdb739bb7d8-smtp-out-n02;
 Tue, 28 Apr 2020 17:50:00 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6A3E8C44792; Tue, 28 Apr 2020 17:50:00 +0000 (UTC)
Received: from quicinc.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: svaddagi)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B39A3C433D2;
        Tue, 28 Apr 2020 17:49:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B39A3C433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=vatsa@codeaurora.org
Date:   Tue, 28 Apr 2020 23:19:52 +0530
From:   Srivatsa Vaddagiri <vatsa@codeaurora.org>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     konrad.wilk@oracle.com, jasowang@redhat.com,
        jan.kiszka@siemens.com, will@kernel.org,
        stefano.stabellini@xilinx.com, iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org,
        virtio-dev@lists.oasis-open.org, tsoni@codeaurora.org,
        pratikp@codeaurora.org, christoffer.dall@arm.com,
        alex.bennee@linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] virtio: Add bounce DMA ops
Message-ID: <20200428174952.GA5097@quicinc.com>
Reply-To: Srivatsa Vaddagiri <vatsa@codeaurora.org>
References: <1588073958-1793-1-git-send-email-vatsa@codeaurora.org>
 <1588073958-1793-6-git-send-email-vatsa@codeaurora.org>
 <20200428121232-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20200428121232-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Michael S. Tsirkin <mst@redhat.com> [2020-04-28 12:17:57]:

> Okay, but how is all this virtio specific?  For example, why not allow
> separate swiotlbs for any type of device?
> For example, this might make sense if a given device is from a
> different, less trusted vendor.

Is swiotlb commonly used for multiple devices that may be on different trust
boundaries (and not behind a hardware iommu)? If so, then yes it sounds like a
good application of multiple swiotlb pools.

> All this can then maybe be hidden behind the DMA API.

Won't we still need some changes to virtio to make use of its own pool (to
bounce buffers)? Something similar to its own DMA ops proposed in this patch?

> > +void virtio_bounce_set_dma_ops(struct virtio_device *vdev)
> > +{
> > +	if (!bounce_buf_paddr)
> > +		return;
> > +
> > +	set_dma_ops(vdev->dev.parent, &virtio_dma_ops);
> 
> 
> I don't think DMA API maintainers will be happy with new users
> of set_dma_ops.

Is there an alternate API that is more preffered?

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
