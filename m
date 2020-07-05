Return-Path: <SRS0=6raZ=AQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D57EC433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 03:37:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 456C520890
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 03:37:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O2lLgZzc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728196AbgGEDhg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jul 2020 23:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728134AbgGEDhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 23:37:36 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 090A2C061794
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jul 2020 20:37:36 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id x8so13137565plm.10
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jul 2020 20:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=M5ZbztlPkvw+9ErJFWw7Qbat+ZkMk081NbvPHaI46hs=;
        b=O2lLgZzcbDRX8J92t5mKKUYXAwjo/sQXHSA3N7D4uuiEl8hO5WSoR/nmtz3zSlJyNz
         H4tFAx0OhM+bYW5A2+HaVgdhP8n38fXZCTnw9ok2Aahub5NKT/tgPW+8b/SMC7izclFy
         gYj2DhmS110EYhViIceJGIaX4DZMUPJkhNJ7o/feDHm78xBYlGfwCtuEq/mI08PXg5SN
         e7GCRB0oJVvxKxFFy1DmJpa1rNquJg9FjMhmetGE81blw8bV6lsReGYMclOJpkdYsX8S
         K8RbC0lFNrxBmYqQ9u2xuG964lHJL/qmc87VxTU6jwr5pmEiyqB01/PYLWoRyl/lHG8C
         bamA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=M5ZbztlPkvw+9ErJFWw7Qbat+ZkMk081NbvPHaI46hs=;
        b=B0UF9AFldxP86Vq9jqcquw0sHeD5gIt3jsbEw0L6NmP3+WP2yRRKsfrqlmpbqqQoFm
         hgp6wTJ9HsG0CUE3a+k7Y5H09xdyFcqpnq7fkgeq3T2DuUGBAhX0Zj25aK+Y6j5PBwJq
         F4qLPwvqp7e4tUsLrtDg55cjB1p3GHMkDHTtqH1LDqUVyCesxRA+GhgV5llPCPU+fyZc
         BG8IVtxOqUX22qOmBXhB4c3iYYKugHhuEbSVdbisxzEtHXtJMER3PMyLL8ve1keXc62i
         THr2QQ/QAk2aBTiwGT347uhK34G2UUdkeTdeCEKBwqkjQShST2T6SuI/1RecAW2P2M17
         PmmA==
X-Gm-Message-State: AOAM532owT7i1YXz5tW4C197n8QmfDovEwxNgVEIvDIclY10eZD5aH3Q
        XBWhPDpHcK28leOUTcSz6X4xOQ==
X-Google-Smtp-Source: ABdhPJwYJ4bAkZPeI8sSzaQN9k6F5rcjd5JMGeKP/JEQ+CUkkHSBMoFuFc3gUDQ0nwnKd5YninLHog==
X-Received: by 2002:a17:90a:db48:: with SMTP id u8mr14034064pjx.169.1593920255249;
        Sat, 04 Jul 2020 20:37:35 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id x10sm15766727pfp.80.2020.07.04.20.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2020 20:37:34 -0700 (PDT)
Date:   Sat, 4 Jul 2020 20:35:11 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Will Deacon <will@kernel.org>
Cc:     Konrad Dybcio <konradybcio@gmail.com>, skrzynka@konradybcio.pl,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, jcrouse@codeaurora.org,
        john.stultz@linaro.org
Subject: Re: [PATCH 1/1] iommu/arm-smmu: Implement qcom,skip-init
Message-ID: <20200705033511.GR388985@builder.lan>
References: <20200704122809.73794-1-konradybcio@gmail.com>
 <20200704130922.GB21333@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200704130922.GB21333@willie-the-truck>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 04 Jul 06:09 PDT 2020, Will Deacon wrote:

> [Adding Bjorn, Jordan and John because I really don't want a bunch of
> different ways to tell the driver that the firmware is screwing things up]
> 

Thanks Will.

> On Sat, Jul 04, 2020 at 02:28:09PM +0200, Konrad Dybcio wrote:
> > This adds the downstream property required to support
> > SMMUs on SDM630 and other platforms (the need for it
> > most likely depends on firmware configuration).
> > 
> > Signed-off-by: Konrad Dybcio <konradybcio@gmail.com>
> > ---
> >  .../devicetree/bindings/iommu/arm,smmu.yaml       | 10 ++++++++++
> >  drivers/iommu/arm-smmu.c                          | 15 +++++++++------
> >  2 files changed, 19 insertions(+), 6 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> > index d7ceb4c34423..9abd6d41a32c 100644
> > --- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> > +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> > @@ -102,6 +102,16 @@ properties:
> >        access to SMMU configuration registers. In this case non-secure aliases of
> >        secure registers have to be used during SMMU configuration.
> >  
> > +  qcom,skip-init:
> > +    description: |
> > +      Disable resetting configuration for all context banks
> > +      during device reset.  This is useful for targets where
> > +      some context banks are dedicated to other execution
> > +      environments outside of Linux and those other EEs are
> > +      programming their own stream match tables, SCTLR, etc.
> > +      Without setting this option we will trample on their
> > +      configuration.
> 
> It would probably be better to know _which_ context banks we shouldn't
> touch, no? Otherwise what happens to the others?
> 

From my investigations of the issue of maintaining the boot display
through the initialization of arm-smmu I assume the reason for skipping
this step don't want to flush out the SMR, S2CR and context bank
initialization because it would disrupt the display hardware's access to
memory.

And in itself I believe that this is quite certainly going to work -
until you start attaching devices. Because in itself this does nothing
to ensure that the driver won't overwrite stream mapping or context bank
configuration as devices are attached.

So on e.g. SDM845 we need to ensure that the driver doesn't stomp over
the display mapping left by the bootloader.


Further more, on platforms such as QCS405 (which are derived from
platforms supported by qcom_iommu today), the stream mapping registers
(SMR and S2CR) are write ignore, which means that without knowledge
about the existing mappings the hardware and driver will be out of sync.

NB. Compared to the platforms that is supported by qcom_iommu, the
stream mapping registers are readable on these newer platforms, while on
e.g. MSM8916 we get an access violation by attempting to read SMR/S2CR.

> > +
> >    stream-match-mask:
> >      $ref: /schemas/types.yaml#/definitions/uint32
> >      description: |
> > diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> > index 243bc4cb2705..a5c623d4caf9 100644
> > --- a/drivers/iommu/arm-smmu.c
> > +++ b/drivers/iommu/arm-smmu.c
> > @@ -1655,13 +1655,16 @@ static void arm_smmu_device_reset(struct arm_smmu_device *smmu)
> >  	 * Reset stream mapping groups: Initial values mark all SMRn as
> >  	 * invalid and all S2CRn as bypass unless overridden.
> >  	 */
> > -	for (i = 0; i < smmu->num_mapping_groups; ++i)
> > -		arm_smmu_write_sme(smmu, i);
> >  
> > -	/* Make sure all context banks are disabled and clear CB_FSR  */
> > -	for (i = 0; i < smmu->num_context_banks; ++i) {
> > -		arm_smmu_write_context_bank(smmu, i);
> > -		arm_smmu_cb_write(smmu, i, ARM_SMMU_CB_FSR, ARM_SMMU_FSR_FAULT);
> > +	if (!of_find_property(smmu->dev->of_node, "qcom,skip-init", NULL)) {
> > +		for (i = 0; i < smmu->num_mapping_groups; ++i)
> > +			arm_smmu_write_sme(smmu, i);
> > +
> > +		/* Make sure all context banks are disabled and clear CB_FSR  */
> > +		for (i = 0; i < smmu->num_context_banks; ++i) {
> > +			arm_smmu_write_context_bank(smmu, i);
> > +			arm_smmu_cb_write(smmu, i, ARM_SMMU_CB_FSR, ARM_SMMU_FSR_FAULT);
> > +		}
> >  	}
> 
> Do we not need to worry about the SMRs as well?
> 

I don't think we should skip the actual initialization, because to avoid
strange side effects we need to ensure that the driver and hardware are
in sync (either for specific streams/banks or for all of them).

I've continued my work on supporting boot display on e.g. SDM845, based
on Thierry's patches, but still have some unresolved corner cases to
fully resolve - e.g. how to ensure that the display hardware's stream
mapping survives the probe deferral of the display driver. Hopefully I
will be able to post something in a few days.



That said, there's a generation of platforms between MSM8916 (which we
support using qcom_iommu) and SDM845 (which can run with arm-smmu).
AngeloGioacchino proposed a series last year to extend the qcom_iommu to
support these [1]. If SD630 falls in this category, or in the newer
SDM845/SM8150 category I don't know.

It would be quite interesting to hear more about the exact behaviors
seems on SDM630, to see how we can support this as well.

[1] https://lore.kernel.org/linux-arm-msm/20191001155641.37117-1-kholk11@gmail.com/

Regards,
Bjorn
