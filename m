Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E2BC8300A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 13:34:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AE082074A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 13:34:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="fzgj81CN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbgD3NeC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 09:34:02 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:55580 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726577AbgD3NeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 09:34:02 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588253641; h=In-Reply-To: Content-Type: MIME-Version:
 References: Reply-To: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=CuOvrrJLy80VLlsv+8kdk0jI2oS0V9P+u4Q0xRy+jj8=; b=fzgj81CNBnuH1emmVDJis3i3epXxa/7rVvgeqagfUH/u6fdehmXYfEQrbjM3EZJ/sKj5/0Ms
 Y0kqsGiDkeZkrJ9LWze34Svq5FtZLOuqOkA4oHoptNF5AR03IyzTxJzQeaG7uVrv0Q2r+kAi
 /PM8Ghk0txMXgWqdBgq6PDLmdYM=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eaad3aa.7fb2e0c57420-smtp-out-n04;
 Thu, 30 Apr 2020 13:33:30 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 5AE79C43636; Thu, 30 Apr 2020 13:33:30 +0000 (UTC)
Received: from quicinc.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: svaddagi)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 53CA5C433D2;
        Thu, 30 Apr 2020 13:33:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 53CA5C433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=vatsa@codeaurora.org
Date:   Thu, 30 Apr 2020 19:03:21 +0530
From:   Srivatsa Vaddagiri <vatsa@codeaurora.org>
To:     Jan Kiszka <jan.kiszka@siemens.com>
Cc:     Will Deacon <will@kernel.org>, konrad.wilk@oracle.com,
        mst@redhat.com, jasowang@redhat.com, stefano.stabellini@xilinx.com,
        iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org,
        virtio-dev@lists.oasis-open.org, tsoni@codeaurora.org,
        pratikp@codeaurora.org, christoffer.dall@arm.com,
        alex.bennee@linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC/PATCH 1/1] virtio: Introduce MMIO ops
Message-ID: <20200430133321.GC3204@quicinc.com>
Reply-To: Srivatsa Vaddagiri <vatsa@codeaurora.org>
References: <1588240976-10213-1-git-send-email-vatsa@codeaurora.org>
 <1588240976-10213-2-git-send-email-vatsa@codeaurora.org>
 <20200430101431.GD19932@willie-the-truck>
 <20200430103446.GH5097@quicinc.com>
 <20200430104149.GG19932@willie-the-truck>
 <20200430111156.GI5097@quicinc.com>
 <7bf8bffe-267b-6c66-86c9-40017d3ca4c2@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <7bf8bffe-267b-6c66-86c9-40017d3ca4c2@siemens.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Jan Kiszka <jan.kiszka@siemens.com> [2020-04-30 14:59:50]:

> >I believe ivshmem2_virtio requires hypervisor to support PCI device emulation
> >(for life-cycle management of VMs), which our hypervisor may not support. A
> >simple shared memory and doorbell or message-queue based transport will work for
> >us.
> 
> As written in our private conversation, a mapping of the ivshmem2 device
> discovery to platform mechanism (device tree etc.) and maybe even the
> register access for doorbell and life-cycle management to something
> hypercall-like would be imaginable. What would count more from virtio
> perspective is a common mapping on a shared memory transport.

Yes that sounds simpler for us.

> That said, I also warned about all the features that PCI already defined
> (such as message-based interrupts) which you may have to add when going a
> different way for the shared memory device.

Is it really required to present this shared memory as belonging to a PCI
device? I would expect the device-tree to indicate the presence of this shared
memory region, which we should be able to present to ivshmem2 as shared memory
region to use (along with some handles for doorbell or message queue use).

I understand the usefulness of modeling the shared memory as part of device so
that hypervisor can send events related to peers going down or coming up. In our
case, there will be other means to discover those events and avoiding this
requirement on hypervisor (to emulate PCI) will simplify the solution for us.

Any idea when we can expect virtio over ivshmem2 to become available?!
 
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
