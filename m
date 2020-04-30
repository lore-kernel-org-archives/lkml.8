Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02F60C8300A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 11:02:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C85322078D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 11:02:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="ZOniMLwP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726849AbgD3LCe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 07:02:34 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:29636 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725280AbgD3LCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 07:02:33 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588244553; h=In-Reply-To: Content-Type: MIME-Version:
 References: Reply-To: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=6O+7YgQwWnlvumFVVWc+1u34+7IdYtJxCQ6pA3ekUCE=; b=ZOniMLwP1UlqusUDbsCzqjBbmMlZkrkdNG8jl0F6ct4iF/GUIhNumsHpXM/pv9CH98sd6rgj
 IoKaVht22y7DahykOvzyAWoWBnVVfB3VEUu3zhA5omqSack4qBWtxliH+vtOSzbN9JUEJngL
 ZhL+ZMY0jLEGsoZbnLXcYBt640Q=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eaab037.7fef5da9f688-smtp-out-n04;
 Thu, 30 Apr 2020 11:02:15 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 61E23C4478F; Thu, 30 Apr 2020 11:02:14 +0000 (UTC)
Received: from quicinc.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: svaddagi)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6F10AC433D2;
        Thu, 30 Apr 2020 11:02:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6F10AC433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=vatsa@codeaurora.org
Date:   Thu, 30 Apr 2020 16:32:06 +0530
From:   Srivatsa Vaddagiri <vatsa@codeaurora.org>
To:     Will Deacon <will@kernel.org>
Cc:     konrad.wilk@oracle.com, mst@redhat.com, jasowang@redhat.com,
        jan.kiszka@siemens.com, stefano.stabellini@xilinx.com,
        iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org,
        virtio-dev@lists.oasis-open.org, tsoni@codeaurora.org,
        pratikp@codeaurora.org, christoffer.dall@arm.com,
        alex.bennee@linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC/PATCH 0/1] virtio_mmio: hypervisor specific interfaces for
 MMIO
Message-ID: <20200430110206.GB3204@quicinc.com>
Reply-To: Srivatsa Vaddagiri <vatsa@codeaurora.org>
References: <1588240976-10213-1-git-send-email-vatsa@codeaurora.org>
 <20200430100821.GC19932@willie-the-truck>
 <20200430102939.GG5097@quicinc.com>
 <20200430103919.GF19932@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20200430103919.GF19932@willie-the-truck>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Will Deacon <will@kernel.org> [2020-04-30 11:39:19]:

> Hi Vatsa,
> 
> On Thu, Apr 30, 2020 at 03:59:39PM +0530, Srivatsa Vaddagiri wrote:
> > > What's stopping you from implementing the trapping support in the
> > > hypervisor? Unlike the other patches you sent out, where the guest memory
> > > is not accessible to the host, there doesn't seem to be any advantage to
> > > not having trapping support, or am I missing something here?
> > 
> > 	I have had this discussion with hypervisor folks. They seem to be
> > concerned about complexity of having a VM's fault be handled in another
> > untrusted VM. They are not keen to add MMIO support.
> 
> Right, but I'm concerned about forking the implementation from the spec
> and I'm not keen to add these hooks ;)
> 
> What does your hook actually do? I'm assuming an HVC? 

Yes, it will issue message-queue related hypercalls

> If so, then where the
> fault is handled seems to be unrelated and whether the guest exit is due to
> an HVC or a stage-2 fault should be immaterial. 

A stage-2 fault would be considered fatal normally and result in termination of
guest. Modifying that behavior to allow resumption in case of virtio config
space access, especially including the untrusted VM in this flow, is
perhaps the concern. HVC calls OTOH are more vetted interfaces that the
hypervisor has to do nothing additional to handle.

> In other words, I don't
> follow why the trapping mechanism necessitates the way in which the fault is
> handled.

Let me check with our hypervisor folks again. Thanks for your inputs.

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
