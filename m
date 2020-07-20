Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CD70C433FB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:36:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18AAA20734
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:36:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="wWcO1Uos"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731318AbgGTPwF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 11:52:05 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:23888 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731296AbgGTPwD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 11:52:03 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1595260321; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=xnVbQfIOaNQRuCHlcnsyb5PH1Ei/vPGEs+i3wjo8U3s=; b=wWcO1Uosneqk+A2SDkEfoAiaaesNDWLq/joIENBWxY2pfxnnHut/C70IRdBvAJJUNusBjQ+H
 t22fUO4VyQZ7hUABANClX6R7lGmYP8sK2K/j0wHTHhd3DNprL57LNWs9LFcKDE49XmUVGNSo
 sY85FNDx09xI1ioJgMpJ4+r6dV4=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n20.prod.us-west-2.postgun.com with SMTP id
 5f15bd7eed710aec625e04cb (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 20 Jul 2020 15:51:26
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id DBAE0C43461; Mon, 20 Jul 2020 15:51:25 +0000 (UTC)
Received: from jcrouse1-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 59B0EC43457;
        Mon, 20 Jul 2020 15:51:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 59B0EC43457
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
Date:   Mon, 20 Jul 2020 09:51:16 -0600
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     Will Deacon <will@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Jonathan Marek <jonathan@marek.ca>,
        linux-arm-msm@vger.kernel.org,
        John Stultz <john.stultz@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH v2 2/5] iommu/arm-smmu: Emulate bypass by using context
 banks
Message-ID: <20200720155116.GA4243@jcrouse1-lnx.qualcomm.com>
Mail-Followup-To: Will Deacon <will@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Jonathan Marek <jonathan@marek.ca>, linux-arm-msm@vger.kernel.org,
        John Stultz <john.stultz@linaro.org>, Vinod Koul <vkoul@kernel.org>
References: <20200717001619.325317-3-bjorn.andersson@linaro.org>
 <20200720085841.GA11189@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200720085841.GA11189@willie-the-truck>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 20, 2020 at 09:58:42AM +0100, Will Deacon wrote:
> On Thu, Jul 16, 2020 at 05:16:16PM -0700, Bjorn Andersson wrote:
> > Some firmware found on various Qualcomm platforms traps writes to S2CR
> > of type BYPASS and writes FAULT into the register. This prevents us from
> > marking the streams for the display controller as BYPASS to allow
> > continued scanout of the screen through the initialization of the ARM
> > SMMU.
> > 
> > This adds a Qualcomm specific cfg_probe function, which probes the
> > behavior of the S2CR registers and if found faulty enables the related
> > quirk. Based on this quirk context banks are allocated for IDENTITY
> > domains as well, but with ARM_SMMU_SCTLR_M omitted.
> > 
> > The result is valid stream mappings, without translation.
> > 
> > Tested-by: John Stultz <john.stultz@linaro.org>
> > Tested-by: Vinod Koul <vkoul@kernel.org>
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > ---
> > 
> > Changes since v1:
> > - Picked up tested-by
> > 
> >  drivers/iommu/arm-smmu-qcom.c | 21 +++++++++++++++++++++
> >  drivers/iommu/arm-smmu.c      | 14 ++++++++++++--
> >  drivers/iommu/arm-smmu.h      |  3 +++
> >  3 files changed, 36 insertions(+), 2 deletions(-)
> 
> [...]
> 
> > diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> > index fb85e716ae9a..5d5fe6741ed4 100644
> > --- a/drivers/iommu/arm-smmu.c
> > +++ b/drivers/iommu/arm-smmu.c
> > @@ -654,7 +654,9 @@ static void arm_smmu_write_context_bank(struct arm_smmu_device *smmu, int idx)
> >  
> >  	/* SCTLR */
> >  	reg = ARM_SMMU_SCTLR_CFIE | ARM_SMMU_SCTLR_CFRE | ARM_SMMU_SCTLR_AFE |
> > -	      ARM_SMMU_SCTLR_TRE | ARM_SMMU_SCTLR_M;
> > +	      ARM_SMMU_SCTLR_TRE;
> > +	if (cfg->m)
> > +		reg |= ARM_SMMU_SCTLR_M;
> >  	if (stage1)
> >  		reg |= ARM_SMMU_SCTLR_S1_ASIDPNE;
> >  	if (IS_ENABLED(CONFIG_CPU_BIG_ENDIAN))
> > @@ -678,7 +680,11 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
> >  	if (smmu_domain->smmu)
> >  		goto out_unlock;
> >  
> > -	if (domain->type == IOMMU_DOMAIN_IDENTITY) {
> > +	/*
> > +	 * Nothing to do for IDENTITY domains,unless disabled context banks are
> > +	 * used to emulate bypass mappings on Qualcomm platforms.
> > +	 */
> > +	if (domain->type == IOMMU_DOMAIN_IDENTITY && !smmu->qcom_bypass_quirk) {
> 
> Given that the other thread [1] with Jordan (why haven't you cc'd him?! --
> adding him now) has identified the need for a callback to allocate the
> context bank, why don't we use the same sort of idea here? If the impl
> provides a CB allocator function, call it irrespective of the domain type.
> If it allocates a domain even for an identity domain, then we can install
> if with SCTLR.M clear.

Here is what I have so far for the context bank allocator.  I think its a good
start, but it still feels a bit half baked, so comments definitely welcome.

https://lists.linuxfoundation.org/pipermail/iommu/2020-July/046754.html
https://lists.linuxfoundation.org/pipermail/iommu/2020-July/046752.html

> Will
> 
> [1] https://lore.kernel.org/r/20200716151625.GA14526@jcrouse1-lnx.qualcomm.com

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
