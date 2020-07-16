Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30293C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 15:22:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B5852065F
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 15:22:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="plx+rFzx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729096AbgGPPWV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 11:22:21 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:64460 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728150AbgGPPWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 11:22:21 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1594912940; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=Fsjdjjd/Og6F+tby19z8oTo04GrQvO0K2CiurdVNlIQ=; b=plx+rFzx9DnFD7gtnZuSIC3e4ihce6pfmwZnhff47l6jwuenHnBZSfjvbcb+JiAA5rAxN3Y7
 zRMXsFphTwHcZDxy6g0es1MMN3mwWHW8wXHQTr+pdojwWEbKkXG9tFL8AoYkBbdaZgyM6MZX
 zY9+YO0QPtDrWfLU0fNG/jXL/tw=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n11.prod.us-west-2.postgun.com with SMTP id
 5f106f4fee86618575d5d276 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 16 Jul 2020 15:16:31
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 97C25C433AF; Thu, 16 Jul 2020 15:16:30 +0000 (UTC)
Received: from jcrouse1-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0060BC433C9;
        Thu, 16 Jul 2020 15:16:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0060BC433C9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
Date:   Thu, 16 Jul 2020 09:16:25 -0600
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
Message-ID: <20200716151625.GA14526@jcrouse1-lnx.qualcomm.com>
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
 <20200713171917.GA3815@jcrouse1-lnx.qualcomm.com>
 <20200716085053.GB6771@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200716085053.GB6771@willie-the-truck>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 16, 2020 at 09:50:53AM +0100, Will Deacon wrote:
> On Mon, Jul 13, 2020 at 11:19:17AM -0600, Jordan Crouse wrote:
> > On Mon, Jul 13, 2020 at 04:09:02PM +0100, Will Deacon wrote:
> > > On Fri, Jun 26, 2020 at 02:00:38PM -0600, Jordan Crouse wrote:
> > > > diff --git a/drivers/iommu/arm-smmu.h b/drivers/iommu/arm-smmu.h
> > > > index 5f2de20e883b..d33cfe26b2f5 100644
> > > > --- a/drivers/iommu/arm-smmu.h
> > > > +++ b/drivers/iommu/arm-smmu.h
> > > > @@ -345,6 +345,7 @@ struct arm_smmu_domain {
> > > >  	struct mutex			init_mutex; /* Protects smmu pointer */
> > > >  	spinlock_t			cb_lock; /* Serialises ATS1* ops and TLB syncs */
> > > >  	struct iommu_domain		domain;
> > > > +	struct device			*dev;	/* Device attached to this domain */
> > > 
> > > This really doesn't feel right to me -- you can generally have multiple
> > > devices attached to a domain and they can come and go without the domain
> > > being destroyed. Perhaps you could instead identify the GPU during
> > > cfg_probe() and squirrel that information away somewhere?
> > 
> > I need some help here. The SMMU device (qcom,adreno-smmu) will have at least two
> > stream ids from two different platform devices (GPU and GMU) and I need to
> > configure split-pagetable and stall/terminate differently on the two domains.
> 
> Hmm. How does the GPU driver know which context bank is assigned to the GPU
> and which one is assigned to the GMU? I assume it needs this information so
> that it can play its nasty tricks with the TTBR registers?
> 
> I ask because if we need to guarantee stability of the context-bank
> assignment, then you could match on that in the ->init_context() callback,
> but now I worry that it currently works by luck :/
 
Its more like "educated" luck. If we assign the domains in the right order we
know that the GPU will be on context bank 0 but you are entirely right that if
everything doesn't go exactly the way we need things go badly.

Some targets do have the ability to reprogram which context bank is used but
that would require a domain attribute from the SMMU driver to communicate that
information back to the GPU driver.

> Do we need to add an extra callback to allocate the context bank?

That seems like a reasonable option. That seems like it would work with legacy
targets and rely less on luck.

Jordan

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
