Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C4EC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 16:48:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE8642077D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 16:48:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CF2pkdTO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728430AbgGIQst (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 12:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726890AbgGIQsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 12:48:43 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 676D8C08C5CE
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 09:48:43 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id o1so1073329plk.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 09:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8JulLZkbhkxBJld9UcW1bp7kKFXu909a3L7NGHRfHog=;
        b=CF2pkdTO/cmM1aimn9kGQiMUMY8ZIeZzvrIAjzlPk2GimjcgWS8XUfvFmfhnT6a2KT
         72SMMVNATr1EcnJ6XoPeFH1/wAmjX8QN9y6dnSB5lz2+WYkF0FkvrgIkA0oqIboA4/Ov
         uvNSSUDpDyYwAFfwTsTh7ZbnkuIQsY6dvVXWQ+3m1UEN34wQhbsJBBCKpqmqX959w/CK
         jACQ0XgWOItT5xl+kyOTcT/q5cTvqWZ7vULfsVNwndu4b+w0Eu+1VLDnthMPFTb7A84U
         PxQLIaS+brjNP4vU+sMuQyer+QAWr6xT1HrdciTaxdZ2Li2YF8zCBQkINqtjhzMwtfyt
         T+zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8JulLZkbhkxBJld9UcW1bp7kKFXu909a3L7NGHRfHog=;
        b=smcM7tJiVLGIVJq9I0qONXtGn11pVu+UflKz73+h7okMneEz/ibe1GpbQ2/gN9shfY
         tTvC+56gOnjEe1+tsZYhghRiOfYwsRHBKgamFR2EtqeaSlGUqV+cBgzAbaz+9gK1QVAD
         Och/uuWMCaKGblf95rkuoUX+PtmjbOes3MVkRZwCW8v1M7mwSvGvg/hOBSjRH0jHLFl0
         DFL2gMPsIBSha258N/S4axmkI0fvP32WoJMaM+K9VidCceUH4lgPhI91rQRiHsqg1bBd
         hQKr1FhHrDvMDYU4DKV4oYE9U3KqhvHdIJIZ3976756ffiCx9VypUy1DeG0h+tO2nxEq
         /fZw==
X-Gm-Message-State: AOAM5338I9ZetaKxGXRXBdcMF6yx3e693/XWnxv6hCnMODA5g4w8c4k8
        RhINhrg7ckH3qfflBtLMG8NV4f5IDJQ=
X-Google-Smtp-Source: ABdhPJwDJM3uQ2KakQWSb/5lIKFeBEQm4VshEG9AnmftSIGRVhm29Zscyx+er1CWEdTOkUl3kSyQVg==
X-Received: by 2002:a17:902:ab8e:: with SMTP id f14mr57060503plr.80.1594313322777;
        Thu, 09 Jul 2020 09:48:42 -0700 (PDT)
Received: from yoga (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id q29sm3225777pfl.77.2020.07.09.09.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 09:48:42 -0700 (PDT)
Date:   Thu, 9 Jul 2020 09:48:37 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rob Clark <robdclark@gmail.com>
Cc:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 2/5] iommu/arm-smmu: Emulate bypass by using context banks
Message-ID: <20200709164833.GR11847@yoga>
References: <20200709050145.3520931-1-bjorn.andersson@linaro.org>
 <20200709050145.3520931-3-bjorn.andersson@linaro.org>
 <CAF6AEGugJYmMpeH_9mWXcegq1awzraUzBTa0S1Rqcr3=Bmk0uQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAF6AEGugJYmMpeH_9mWXcegq1awzraUzBTa0S1Rqcr3=Bmk0uQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 09 Jul 09:17 PDT 2020, Rob Clark wrote:

> On Wed, Jul 8, 2020 at 10:01 PM Bjorn Andersson
> <bjorn.andersson@linaro.org> wrote:
[..]
> > @@ -678,7 +680,11 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
> >         if (smmu_domain->smmu)
> >                 goto out_unlock;
> >
> > -       if (domain->type == IOMMU_DOMAIN_IDENTITY) {
> > +       /*
> > +        * Nothing to do for IDENTITY domains,unless disabled context banks are
> > +        * used to emulate bypass mappings on Qualcomm platforms.
> > +        */
> > +       if (domain->type == IOMMU_DOMAIN_IDENTITY && !smmu->qcom_bypass_quirk) {
> 
> maybe I'm overlooking something, but I think this would put us back to
> allocating pgtables (and making iommu->map/unmap() no longer no-ops),
> which I don't think we want
> 

You're right, we are allocating page tables for these contexts and
map/unmap would modify the page tables. But afaict traversal is never
performed, given that the banks are never enabled.

But as drivers probe properly, or the direct mapped drivers sets up
their iommu domains explicitly with translation this would not be used.

So afaict we're just wasting some memory - for the gain of not
overcomplicating this function.

Regards,
Bjorn

> BR,
> -R
> 
> >                 smmu_domain->stage = ARM_SMMU_DOMAIN_BYPASS;
> >                 smmu_domain->smmu = smmu;
> >                 goto out_unlock;
> > @@ -826,6 +832,10 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
> >         domain->geometry.aperture_end = (1UL << ias) - 1;
> >         domain->geometry.force_aperture = true;
> >
> > +       /* Enable translation for non-identity context banks */
> > +       if (domain->type != IOMMU_DOMAIN_IDENTITY)
> > +               cfg->m = true;
> > +
> >         /* Initialise the context bank with our page table cfg */
> >         arm_smmu_init_context_bank(smmu_domain, &pgtbl_cfg);
> >         arm_smmu_write_context_bank(smmu, cfg->cbndx);
> > diff --git a/drivers/iommu/arm-smmu.h b/drivers/iommu/arm-smmu.h
> > index d172c024be61..a71d193073e4 100644
> > --- a/drivers/iommu/arm-smmu.h
> > +++ b/drivers/iommu/arm-smmu.h
> > @@ -305,6 +305,8 @@ struct arm_smmu_device {
> >
> >         /* IOMMU core code handle */
> >         struct iommu_device             iommu;
> > +
> > +       bool                            qcom_bypass_quirk;
> >  };
> >
> >  enum arm_smmu_context_fmt {
> > @@ -323,6 +325,7 @@ struct arm_smmu_cfg {
> >         };
> >         enum arm_smmu_cbar_type         cbar;
> >         enum arm_smmu_context_fmt       fmt;
> > +       bool                            m;
> >  };
> >  #define ARM_SMMU_INVALID_IRPTNDX       0xff
> >
> > --
> > 2.26.2
> >
> > _______________________________________________
> > iommu mailing list
> > iommu@lists.linux-foundation.org
> > https://lists.linuxfoundation.org/mailman/listinfo/iommu
