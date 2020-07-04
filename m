Return-Path: <SRS0=f/ZA=AP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE55EC433E1
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 13:09:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBF29208D5
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 13:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593868170;
	bh=XKkYUna+C06YzYOPFLvRPSDNzCZHTcnnHceCSplfaDo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=EY0+G6/LL4Z9fEEBGKvD0pE2dl7Qp+fLPBoFNTo03E68keMWTHpAJuRCMLcM1u1aI
	 wxZjIZV5cIp6hmHKSNYEdThvnHq4OMBfQ3oKNhgWdkEAnRJ5pc00lAFFvGIv5CLtlE
	 GDRHn8/XZ41tSI05jcXFu9zzToJDX4t9eU+aIH0Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbgGDNJ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jul 2020 09:09:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:38716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726638AbgGDNJ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 09:09:28 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E48F2075D;
        Sat,  4 Jul 2020 13:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593868168;
        bh=XKkYUna+C06YzYOPFLvRPSDNzCZHTcnnHceCSplfaDo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UQGCEihcRR8O+4v1S89+qf+2jJkRhmrnWFknwJYLWkBg5Z/dQ75ffTq12DsnOKMiA
         gg5x/N0JSgmAq656qlHecV6niqLIryBTuDHAFrCPSMiuDMtV75akZowtq8QyvEWLze
         zxMxUuXexGPuai9UV2WwDb6idRHJqhw3KHGUJgN8=
Date:   Sat, 4 Jul 2020 14:09:23 +0100
From:   Will Deacon <will@kernel.org>
To:     Konrad Dybcio <konradybcio@gmail.com>
Cc:     skrzynka@konradybcio.pl, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org,
        jcrouse@codeaurora.org, john.stultz@linaro.org
Subject: Re: [PATCH 1/1] iommu/arm-smmu: Implement qcom,skip-init
Message-ID: <20200704130922.GB21333@willie-the-truck>
References: <20200704122809.73794-1-konradybcio@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200704122809.73794-1-konradybcio@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Adding Bjorn, Jordan and John because I really don't want a bunch of
different ways to tell the driver that the firmware is screwing things up]

On Sat, Jul 04, 2020 at 02:28:09PM +0200, Konrad Dybcio wrote:
> This adds the downstream property required to support
> SMMUs on SDM630 and other platforms (the need for it
> most likely depends on firmware configuration).
> 
> Signed-off-by: Konrad Dybcio <konradybcio@gmail.com>
> ---
>  .../devicetree/bindings/iommu/arm,smmu.yaml       | 10 ++++++++++
>  drivers/iommu/arm-smmu.c                          | 15 +++++++++------
>  2 files changed, 19 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> index d7ceb4c34423..9abd6d41a32c 100644
> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> @@ -102,6 +102,16 @@ properties:
>        access to SMMU configuration registers. In this case non-secure aliases of
>        secure registers have to be used during SMMU configuration.
>  
> +  qcom,skip-init:
> +    description: |
> +      Disable resetting configuration for all context banks
> +      during device reset.  This is useful for targets where
> +      some context banks are dedicated to other execution
> +      environments outside of Linux and those other EEs are
> +      programming their own stream match tables, SCTLR, etc.
> +      Without setting this option we will trample on their
> +      configuration.

It would probably be better to know _which_ context banks we shouldn't
touch, no? Otherwise what happens to the others?

> +
>    stream-match-mask:
>      $ref: /schemas/types.yaml#/definitions/uint32
>      description: |
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index 243bc4cb2705..a5c623d4caf9 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -1655,13 +1655,16 @@ static void arm_smmu_device_reset(struct arm_smmu_device *smmu)
>  	 * Reset stream mapping groups: Initial values mark all SMRn as
>  	 * invalid and all S2CRn as bypass unless overridden.
>  	 */
> -	for (i = 0; i < smmu->num_mapping_groups; ++i)
> -		arm_smmu_write_sme(smmu, i);
>  
> -	/* Make sure all context banks are disabled and clear CB_FSR  */
> -	for (i = 0; i < smmu->num_context_banks; ++i) {
> -		arm_smmu_write_context_bank(smmu, i);
> -		arm_smmu_cb_write(smmu, i, ARM_SMMU_CB_FSR, ARM_SMMU_FSR_FAULT);
> +	if (!of_find_property(smmu->dev->of_node, "qcom,skip-init", NULL)) {
> +		for (i = 0; i < smmu->num_mapping_groups; ++i)
> +			arm_smmu_write_sme(smmu, i);
> +
> +		/* Make sure all context banks are disabled and clear CB_FSR  */
> +		for (i = 0; i < smmu->num_context_banks; ++i) {
> +			arm_smmu_write_context_bank(smmu, i);
> +			arm_smmu_cb_write(smmu, i, ARM_SMMU_CB_FSR, ARM_SMMU_FSR_FAULT);
> +		}
>  	}

Do we not need to worry about the SMRs as well?

Will
