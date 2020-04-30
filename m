Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5CF5C8300A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 10:34:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1A0520838
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 10:34:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="Lx1tODra"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbgD3Kez (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 06:34:55 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:12248 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726309AbgD3Kez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 06:34:55 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588242894; h=In-Reply-To: Content-Type: MIME-Version:
 References: Reply-To: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=FacaeX+QW3gZe3CsWw46u78war6rqHZGj6J6LKrNjcs=; b=Lx1tODratd2FPN/DnDoLP6n+swOCkWbIEz/z/q+bg1Yy5CvxyoiTgObDBHoE/4OQxgv++uU2
 GB6NSZo9NS8sB+BowTugIt+gsV3/WTCdcRXtc5CTrR/gBMGlEm9+7EmmJI6kuj//mkWd5QX7
 jFXkHUsO2ev7C+Dt39nj1ENb/4U=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eaaa9ce.7f386b0530a0-smtp-out-n01;
 Thu, 30 Apr 2020 10:34:54 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 29249C432C2; Thu, 30 Apr 2020 10:34:54 +0000 (UTC)
Received: from quicinc.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: svaddagi)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 73383C433CB;
        Thu, 30 Apr 2020 10:34:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 73383C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=vatsa@codeaurora.org
Date:   Thu, 30 Apr 2020 16:04:46 +0530
From:   Srivatsa Vaddagiri <vatsa@codeaurora.org>
To:     Will Deacon <will@kernel.org>
Cc:     konrad.wilk@oracle.com, mst@redhat.com, jasowang@redhat.com,
        jan.kiszka@siemens.com, stefano.stabellini@xilinx.com,
        iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org,
        virtio-dev@lists.oasis-open.org, tsoni@codeaurora.org,
        pratikp@codeaurora.org, christoffer.dall@arm.com,
        alex.bennee@linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC/PATCH 1/1] virtio: Introduce MMIO ops
Message-ID: <20200430103446.GH5097@quicinc.com>
Reply-To: Srivatsa Vaddagiri <vatsa@codeaurora.org>
References: <1588240976-10213-1-git-send-email-vatsa@codeaurora.org>
 <1588240976-10213-2-git-send-email-vatsa@codeaurora.org>
 <20200430101431.GD19932@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20200430101431.GD19932@willie-the-truck>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Will Deacon <will@kernel.org> [2020-04-30 11:14:32]:

> > +#ifdef CONFIG_VIRTIO_MMIO_OPS
> >  
> > +static struct virtio_mmio_ops *mmio_ops;
> > +
> > +#define virtio_readb(a)		mmio_ops->mmio_readl((a))
> > +#define virtio_readw(a)		mmio_ops->mmio_readl((a))
> > +#define virtio_readl(a)		mmio_ops->mmio_readl((a))
> > +#define virtio_writeb(val, a)	mmio_ops->mmio_writeb((val), (a))
> > +#define virtio_writew(val, a)	mmio_ops->mmio_writew((val), (a))
> > +#define virtio_writel(val, a)	mmio_ops->mmio_writel((val), (a))
> 
> How exactly are these ops hooked up? I'm envisaging something like:
> 
> 	ops = spec_compliant_ops;
> 	[...]
> 	if (firmware_says_hypervisor_is_buggy())
> 		ops = magic_qcom_ops;
> 
> am I wrong?

If CONFIG_VIRTIO_MMIO_OPS is defined, then I expect this to be unconditionally
set to 'magic_qcom_ops' that uses hypervisor-supported interface for IO (for
example: message_queue_send() and message_queue_recevie() hypercalls).

> > +int register_virtio_mmio_ops(struct virtio_mmio_ops *ops)
> > +{
> > +	pr_info("Registered %s as mmio ops\n", ops->name);
> > +	mmio_ops = ops;
> 
> Not looking good, and really defeats the point of standardising this stuff
> imo.

Ok. I guess the other option is to standardize on a new virtio transport (like
ivshmem2-virtio)?

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
