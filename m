Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23E27C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 17:01:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED4F020738
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 17:01:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="TOHtutDi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730385AbgGMRBp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 13:01:45 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:24456 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730206AbgGMRBp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 13:01:45 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1594659704; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=KRdL10OGiMuFb36lTpuRBRxlxK8Gr9DMI+wG0F30ZmI=; b=TOHtutDiYcpYtTllGxbuY4ebBSOr2HQocy4kLd8vuwtt+zU6aTGvfpKz5+Noq3IfJzPy4uZN
 fEDlEgh1WRSYV2vucQEM/Ak4qJFnmDvW8K1YrafTzDlEAliGzFM2m1e3h7fjkTOFuAg5aCgj
 6RL3FIRu2PMa9FIJ89Xk08XT0c8=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n13.prod.us-east-1.postgun.com with SMTP id
 5f0c933d8423214e13976960 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 13 Jul 2020 17:00:45
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id ED482C4339C; Mon, 13 Jul 2020 17:00:44 +0000 (UTC)
Received: from jcrouse1-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7C255C433C6;
        Mon, 13 Jul 2020 17:00:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7C255C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
Date:   Mon, 13 Jul 2020 11:00:32 -0600
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     Will Deacon <will@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        freedreno@lists.freedesktop.org, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/arm-smmu: Add a init_context_bank implementation
 hook
Message-ID: <20200713170032.GH21059@jcrouse1-lnx.qualcomm.com>
Mail-Followup-To: Will Deacon <will@kernel.org>,
        linux-arm-msm@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        freedreno@lists.freedesktop.org, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20200611223656.4724-1-jcrouse@codeaurora.org>
 <20200713151123.GB3072@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200713151123.GB3072@willie-the-truck>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 13, 2020 at 04:11:23PM +0100, Will Deacon wrote:
> On Thu, Jun 11, 2020 at 04:36:56PM -0600, Jordan Crouse wrote:
> > Add a new implementation hook to allow the implementation specific code
> > to tweek the context bank configuration just before it gets written.
> > The first user will be the Adreno GPU implementation to turn on
> > SCTLR.HUPCF to ensure that a page fault doesn't terminating pending
> > transactions. Doing so could hang the GPU if one of the terminated
> > transactions is a CP read.
> > 
> > This depends on the arm-smmu adreno SMMU implementation [1].
> > 
> > [1] https://patchwork.kernel.org/patch/11600943/
> > 
> > Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
> > ---
> > 
> >  drivers/iommu/arm-smmu-qcom.c | 13 +++++++++++++
> >  drivers/iommu/arm-smmu.c      | 28 +++++++++++++---------------
> >  drivers/iommu/arm-smmu.h      | 11 +++++++++++
> >  3 files changed, 37 insertions(+), 15 deletions(-)
> 
> This looks straightforward enough, but I don't want to merge this without
> a user and Sai's series has open questions afaict.

Not sure what you mean by a user in this context?
Are you referring to https://patchwork.kernel.org/patch/11628541/?

> Will

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
