Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D608C83003
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 03:35:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3522B206D8
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 03:35:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="UF3RQFaL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbgD2Dfs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 23:35:48 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:38994 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726551AbgD2Dfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 23:35:48 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588131347; h=In-Reply-To: Content-Type: MIME-Version:
 References: Reply-To: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=RKZjGjRaRWOMA4bE7u8bYNMGSYHBc1o/5aoxXJ54jnQ=; b=UF3RQFaLof+5O/hFPoKjFlz5tpUNnScnSIb9FENKdSFtxf0g/Q1Kf6gpzYvaQt3MXn9uJsoz
 Wvsu6560LqUM7K0+p7g1TpB7Z5sP8LXnKHItCGCooLd0odjK7oQHbOqgzBMQh65n4eA41TDl
 Cx1S+iOT36h2gV9PQQVQQMnLQII=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ea8f613.7f1ff9fc10a0-smtp-out-n05;
 Wed, 29 Apr 2020 03:35:47 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 359A1C43637; Wed, 29 Apr 2020 03:35:47 +0000 (UTC)
Received: from quicinc.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: svaddagi)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7C61BC433D2;
        Wed, 29 Apr 2020 03:35:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7C61BC433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=vatsa@codeaurora.org
Date:   Wed, 29 Apr 2020 09:05:39 +0530
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
Message-ID: <20200429033539.GB5097@quicinc.com>
Reply-To: Srivatsa Vaddagiri <vatsa@codeaurora.org>
References: <1588073958-1793-1-git-send-email-vatsa@codeaurora.org>
 <1588073958-1793-6-git-send-email-vatsa@codeaurora.org>
 <20200428121232-mutt-send-email-mst@kernel.org>
 <20200428174952.GA5097@quicinc.com>
 <20200428163448-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20200428163448-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Michael S. Tsirkin <mst@redhat.com> [2020-04-28 16:41:04]:

> > Won't we still need some changes to virtio to make use of its own pool (to
> > bounce buffers)? Something similar to its own DMA ops proposed in this patch?
> 
> If you are doing this for all devices, you need to either find a way
> to do this without chaning DMA ops, or by doing some automatic change
> to all drivers.

Ok thanks for this input. I will see how we can obfuscate this in DMA APIs
itself.

Can you also comment on the virtio transport problem I cited? The hypervisor we
are dealing with does not support MMIO transport. It supports message queue
send/recv and also doorbell, which I think can be used if we can make some
change like this to virtio_mmio.c:

+static inline u32
+virtio_readl(struct virtio_mmio_device *vm_dev, u32 reg_offset)
+{
+        return vm_dev->mmio_ops->readl(vm_dev, reg_offset);
+}
+ 
+static inline void
+virtio_writel(struct virtio_mmio_device *vm_dev, u32 reg_offset, u32 data)
+{
+        vm_dev->mmio_ops->writel(vm_dev, reg_offset, data);
+}


        /* Check magic value */
-        magic = readl(vm_dev->base + VIRTIO_MMIO_MAGIC_VALUE);
+        magic = vrito_readl(vm_dev, VIRTIO_MMIO_MAGIC_VALUE);

mmio_ops->readl on most platforms can default to readl itself, while on a
platform like us, it can boil down to message_queue send/recv. Would such a
change be acceptable?

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
