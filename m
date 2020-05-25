Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A710C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 09:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 678D92073B
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 09:42:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="QQ0qixAo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389670AbgEYJmZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 05:42:25 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:31211 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389626AbgEYJmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 05:42:25 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1590399744; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=4XMfEHIN7oui+iQA662Dn6grh5+WRfXrieHjrwR2Wm8=;
 b=QQ0qixAoq6xueVeqokCSz1sNXzR4eIGRjnDytsDsPHmyuPGTkhuN+sPLaBSPt6BoZV3jHrJt
 6b6hDJgSWn0ucWkBPsKRThM/kelnJjKJ/cOSlWPehyo8ZYplEbMnyphVIGre5lL/NGu0L4de
 mC7LBObYAKB9dpFW0rOnAN2sZFU=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 5ecb92feeb073d56917e77fc (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 25 May 2020 09:42:22
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E9217C433CA; Mon, 25 May 2020 09:42:21 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5FBA1C433C6;
        Mon, 25 May 2020 09:42:21 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 25 May 2020 15:12:21 +0530
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To:     Jonathan Marek <jonathan@marek.ca>
Cc:     linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm-owner@vger.kernel.org
Subject: Re: [PATCH 2/6] arm64: dts: qcom: sm8250: add apps_smmu node
In-Reply-To: <20200524023815.21789-3-jonathan@marek.ca>
References: <20200524023815.21789-1-jonathan@marek.ca>
 <20200524023815.21789-3-jonathan@marek.ca>
Message-ID: <42f39eeb2af9c82a551a417c62ea21d7@codeaurora.org>
X-Sender: saiprakash.ranjan@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

On 2020-05-24 08:08, Jonathan Marek wrote:
> Add the apps_smmu node for sm8250. Note that adding the iommus field 
> for
> UFS is required because initializing the iommu removes the bypass 
> mapping
> that created by the bootloader.
> 

This statement doesn't seem right, you can just say since the bypass is 
disabled
by default now, we need to add this property to enable translation and 
avoid global faults.

> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
> ---
>  arch/arm64/boot/dts/qcom/sm8250.dtsi | 107 +++++++++++++++++++++++++++
>  1 file changed, 107 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi
> b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> index 2f99c350c287..43c5e48c15e2 100644
> --- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> @@ -323,6 +323,8 @@ ufs_mem_hc: ufshc@1d84000 {
> 
>  			power-domains = <&gcc UFS_PHY_GDSC>;
> 
> +			iommus = <&apps_smmu 0x0e0 0>, <&apps_smmu 0x4e0 0>;
> +
>  			clock-names =
>  				"core_clk",
>  				"bus_aggr_clk",
> @@ -428,6 +430,111 @@ tlmm: pinctrl@f100000 {
>  			wakeup-parent = <&pdc>;
>  		};
> 
> +		apps_smmu: iommu@15000000 {
> +			compatible = "qcom,sdm845-smmu-500", "arm,mmu-500";

This should be qcom,sm8250-smmu-500 and also you need to update the 
arm-smmu
binding with this compatible in a separate patch.

-Sai

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member
of Code Aurora Forum, hosted by The Linux Foundation
