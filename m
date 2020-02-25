Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 102E4C35E01
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 13:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5B94218AC
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 13:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582639026;
	bh=NSe2qcF5m4QUBVLGBbzhTThwrghbCfTzzj3uocTKlD8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=G58Xa64yI8hZPCJeldMOV+VTHlBjfBqS5jkSgve7kWGrWZ8+phlOXZ1omeWRQowA+
	 8aptFdOLm2A+2NKMNrqOipCwH3nbFBdG5/EdLLAp4c+ACWDoJJ6ZDp3ADLt4e2xS8V
	 E/yz2CXoeU4Vf+M+GV0+PTPMLkaNfJI2MIJTwUT4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730533AbgBYN5F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 08:57:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:34734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730354AbgBYN5F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 08:57:05 -0500
Received: from localhost (unknown [122.167.120.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ABA46218AC;
        Tue, 25 Feb 2020 13:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582639024;
        bh=NSe2qcF5m4QUBVLGBbzhTThwrghbCfTzzj3uocTKlD8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZLKREDsuwaQ3xDBP4YS8S2KT17+3WoI1udgh7jMBiglrNcfxx3vwlAt1i4LWXVvmM
         oFfdWMbMooCYNperlWvHl3QMzSeOHZLs4g1PGga1IyKnUV5ongK+51xXi56gGMBgie
         X1seoyYoNdkz8/UfV8FHSSFeY7hLo5j8hz3/4Omg=
Date:   Tue, 25 Feb 2020 19:27:00 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        daniel.lezcano@linaro.org, bjorn.andersson@linaro.org,
        sivaa@codeaurora.org, Andy Gross <agross@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/3] dt-bindings: thermal: tsens: Make dtbs_check pass
 for msm8916 tsens
Message-ID: <20200225135700.GQ2618@vkoul-mobl>
References: <cover.1582632110.git.amit.kucheria@linaro.org>
 <33b60b91ee43359d7507054e9b95c3078fd5cda3.1582632110.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33b60b91ee43359d7507054e9b95c3078fd5cda3.1582632110.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-02-20, 17:38, Amit Kucheria wrote:
> The qcom-tsens binding requires a SoC-specific and a TSENS
> family-specific binding to be specified in the compatible string.
> 
> Since them family-specific binding is not listed in the .dtsi file, we
> see the following warnings in 'make dtbs_check'. Fix them.

Update subject line here too?

> /home/amit/work/builds/build-aarch64/arch/arm64/boot/dts/qcom/msm8916-mtp.dt.yaml:
> thermal-sensor@4a9000: compatible: ['qcom,msm8916-tsens'] is not valid
> under any of the given schemas (Possible causes of the failure):
> /home/amit/work/builds/build-aarch64/arch/arm64/boot/dts/qcom/msm8916-mtp.dt.yaml:
> thermal-sensor@4a9000: compatible: ['qcom,msm8916-tsens'] is too short
> /home/amit/work/builds/build-aarch64/arch/arm64/boot/dts/qcom/msm8916-mtp.dt.yaml:
> thermal-sensor@4a9000: compatible:0: 'qcom,msm8916-tsens' is not one of
> ['qcom,msm8976-tsens', 'qcom,qcs404-tsens']
> /home/amit/work/builds/build-aarch64/arch/arm64/boot/dts/qcom/msm8916-mtp.dt.yaml:
> thermal-sensor@4a9000: compatible:0: 'qcom,msm8916-tsens' is not one of
> ['qcom,msm8996-tsens', 'qcom,msm8998-tsens', 'qcom,sdm845-tsens']
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/msm8916.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> index 9f31064f2374..1748ea3f4b4f 100644
> --- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> @@ -860,7 +860,7 @@
>  		};
>  
>  		tsens: thermal-sensor@4a9000 {
> -			compatible = "qcom,msm8916-tsens";
> +			compatible = "qcom,msm8916-tsens", "qcom,tsens-v0_1";
>  			reg = <0x4a9000 0x1000>, /* TM */
>  			      <0x4a8000 0x1000>; /* SROT */
>  			nvmem-cells = <&tsens_caldata>, <&tsens_calsel>;
> -- 
> 2.20.1

-- 
~Vinod
