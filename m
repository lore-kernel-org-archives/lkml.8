Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F775C433E5
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 17:19:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5926B206F5
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 17:19:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="l3mLkvRZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730225AbgGMRTe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 13:19:34 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:25685 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729659AbgGMRTd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 13:19:33 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1594660772; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=4XiXe8TG0RFYxFbJZ/n9VVska8WODtyTC6be8J3K5K0=; b=l3mLkvRZ1EidMnHDteO7zW3IfDIfvzKVJsq5JXEbqHIGY5aqbYo5Ds6RpfNoSQHJR4NVAUs0
 DNRZFi3eWdVK0YsFT8K4xVulzv1oyYAtOzCayjILrMy0epIK5AvYc6JlAIdwPuqwTPzEPyk3
 0j/jRIqgljcum+WL5zyPed/nFLs=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n11.prod.us-east-1.postgun.com with SMTP id
 5f0c979ac7a053446acf02c2 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 13 Jul 2020 17:19:22
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 9D904C43391; Mon, 13 Jul 2020 17:19:21 +0000 (UTC)
Received: from jcrouse1-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D0324C433C8;
        Mon, 13 Jul 2020 17:19:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D0324C433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
Date:   Mon, 13 Jul 2020 11:19:17 -0600
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     Will Deacon <will@kernel.org>
Cc:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        John Stultz <john.stultz@linaro.org>,
        freedreno@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [Freedreno] [PATCH v9 4/7] iommu/arm-smmu: Add a pointer to the
 attached device to smmu_domain
Message-ID: <20200713171917.GA3815@jcrouse1-lnx.qualcomm.com>
Mail-Followup-To: Will Deacon <will@kernel.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org,
        John Stultz <john.stultz@linaro.org>,
        freedreno@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org
References: <20200626200042.13713-1-jcrouse@codeaurora.org>
 <20200626200042.13713-5-jcrouse@codeaurora.org>
 <20200713150901.GA3072@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200713150901.GA3072@willie-the-truck>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 13, 2020 at 04:09:02PM +0100, Will Deacon wrote:
> On Fri, Jun 26, 2020 at 02:00:38PM -0600, Jordan Crouse wrote:
> > Add a link to the pointer to the struct device that is attached to a
> > domain. This makes it easy to get the pointer if it is needed in the
> > implementation specific code.
> > 
> > Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
> > ---
> > 
> >  drivers/iommu/arm-smmu.c | 6 ++++--
> >  drivers/iommu/arm-smmu.h | 1 +
> >  2 files changed, 5 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> > index 048de2681670..060139452c54 100644
> > --- a/drivers/iommu/arm-smmu.c
> > +++ b/drivers/iommu/arm-smmu.c
> > @@ -668,7 +668,8 @@ static void arm_smmu_write_context_bank(struct arm_smmu_device *smmu, int idx)
> >  }
> >  
> >  static int arm_smmu_init_domain_context(struct iommu_domain *domain,
> > -					struct arm_smmu_device *smmu)
> > +					struct arm_smmu_device *smmu,
> > +					struct device *dev)
> >  {
> >  	int irq, start, ret = 0;
> >  	unsigned long ias, oas;
> > @@ -801,6 +802,7 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
> >  		cfg->asid = cfg->cbndx;
> >  
> >  	smmu_domain->smmu = smmu;
> > +	smmu_domain->dev = dev;
> >  
> >  	pgtbl_cfg = (struct io_pgtable_cfg) {
> >  		.pgsize_bitmap	= smmu->pgsize_bitmap,
> > @@ -1190,7 +1192,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
> >  		return ret;
> >  
> >  	/* Ensure that the domain is finalised */
> > -	ret = arm_smmu_init_domain_context(domain, smmu);
> > +	ret = arm_smmu_init_domain_context(domain, smmu, dev);
> >  	if (ret < 0)
> >  		goto rpm_put;
> >  
> > diff --git a/drivers/iommu/arm-smmu.h b/drivers/iommu/arm-smmu.h
> > index 5f2de20e883b..d33cfe26b2f5 100644
> > --- a/drivers/iommu/arm-smmu.h
> > +++ b/drivers/iommu/arm-smmu.h
> > @@ -345,6 +345,7 @@ struct arm_smmu_domain {
> >  	struct mutex			init_mutex; /* Protects smmu pointer */
> >  	spinlock_t			cb_lock; /* Serialises ATS1* ops and TLB syncs */
> >  	struct iommu_domain		domain;
> > +	struct device			*dev;	/* Device attached to this domain */
> 
> This really doesn't feel right to me -- you can generally have multiple
> devices attached to a domain and they can come and go without the domain
> being destroyed. Perhaps you could instead identify the GPU during
> cfg_probe() and squirrel that information away somewhere?

I need some help here. The SMMU device (qcom,adreno-smmu) will have at least two
stream ids from two different platform devices (GPU and GMU) and I need to
configure split-pagetable and stall/terminate differently on the two domains.

I couldn't figure out a way to identify the platform device before it attached
itself with iommu_attach_device. I tried poking around in fwspec but got lost.

If there is a way we can uniquely identify the devices (by stream id maybe) then
we could use that though I have reservations about hard coding stream IDs in the
impl driver. That said, the stream IDs have never changed in the life of the
GPU so maybe it's not a problem that needs solving.

Jordan

> The rest of the series looks ok to me.
> 
> Will
> _______________________________________________
> Freedreno mailing list
> Freedreno@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/freedreno

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
