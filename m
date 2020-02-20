Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86510C11D0C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 18:57:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EA382467A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 18:57:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="FKlKE9hf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728792AbgBTS5i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 13:57:38 -0500
Received: from mail27.static.mailgun.info ([104.130.122.27]:21455 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728315AbgBTS5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 13:57:37 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1582225057; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=vvYcgKLiQoRaBLEmDopEG/p1yFw3UjwbMybQGfgcmIs=; b=FKlKE9hfjfuu6AwGbyqC3eDibBUudPnVAsTSTDRhP8mvERex0Vr7zUqAsPq/gfRwtsYWx9rx
 WE83bzm+fmVvDsJ7IsVbl/eQAJcEcnYRw60c8S6HwpsX6DeNUrcIZ2uA9oLV9QXTybYTQqPW
 xGoDRMWHNQL3hDbr0eYmrb1CIjQ=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e4ed69a.7fb7887c5a78-smtp-out-n03;
 Thu, 20 Feb 2020 18:57:30 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 708A1C447A4; Thu, 20 Feb 2020 18:57:29 +0000 (UTC)
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: pratikp)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BC218C43383;
        Thu, 20 Feb 2020 18:57:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BC218C43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=pratikp@codeaurora.org
Date:   Thu, 20 Feb 2020 10:57:28 -0800
From:   Pratik Patel <pratikp@codeaurora.org>
To:     Will Deacon <will@kernel.org>
Cc:     isaacm@codeaurora.org, Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org, Liam Mark <lmark@codeaurora.org>,
        iommu@lists.linux-foundation.org, kernel-team@android.com
Subject: Re: [RFC PATCH] iommu/dma: Allow drivers to reserve an iova range
Message-ID: <20200220185728.GA32137@pratikp-lnx>
References: <1581721096-16235-1-git-send-email-isaacm@codeaurora.org>
 <20200217080138.GB10342@infradead.org>
 <c58fd502-52a4-cb0f-6e7f-e9cc00627313@arm.com>
 <fc6e1b6689bca7a00e6b12d2bc877d20@codeaurora.org>
 <20200219111501.GA19400@willie-the-truck>
 <d8b70a579f07c688b264e83a0ec0b6d6@codeaurora.org>
 <20200220084552.GB11827@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200220084552.GB11827@willie-the-truck>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/20  08:45 am, Will Deacon wrote:
> On Wed, Feb 19, 2020 at 12:06:28PM -0800, isaacm@codeaurora.org wrote:
> > On 2020-02-19 03:15, Will Deacon wrote:
> > > On Tue, Feb 18, 2020 at 05:57:18PM -0800, isaacm@codeaurora.org wrote:
> > > > Does this mean that the driver should be managing the IOVA space and
> > > > mappings for this device using the IOMMU API? If so, is the
> > > > rationale for
> > > > this because the device driver can have the information of what IOVA
> > > > ranges
> > > > can and cannot be used? Shouldn't there be a generic way of
> > > > informing an
> > > > IOMMU driver about these reserved ranges? Perhaps through a device
> > > > tree
> > > > property, instead of deferring this type of management to the driver?
> > > 
> > > Before we dive into designing that, can you please clarify whether the
> > > reserved IOVA range applies to all DMA masters mastering through a
> > > particular SMMU, or whether it's just about one specific master? I was
> > > assuming the former, but wanted to be sure.
> > > 
> > This situation currently applies to one master.
> 
> Interesting. Is it problematic if the range is reserved for all masters
> sharing that SMMU?
> 
Yes, that would be an overkill. It certainly is useful and in
some cases quite helpful to not waste that range of IOVA space for
other masters on the same SMMU that can use it.

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project 
