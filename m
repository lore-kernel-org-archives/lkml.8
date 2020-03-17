Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1E92C18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 15:52:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B633E20663
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 15:52:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="DJjbqK+M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbgCQPwm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 11:52:42 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:30160 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726294AbgCQPwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 11:52:42 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1584460362; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=F3ioMX8bj8P3wFuntkEmg3te9kA2v3f1KYJgn3TX8No=;
 b=DJjbqK+MfSvWe/G94I3T9dFIYvYYtCrYtG8QLVi3CjOnmm7WAE3L0WVeTV/zahRkZzNUX1Vh
 Oum1uZ0sQrno4vgLH9vPJDFZFDaqnnNLd4X0jvGp41MdXtdRBjp1RV9I/iBxU1rpgN5N/0IE
 vfR2/Bkiyxt0U4B4aRKk0B2gqyI=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e70f236.7f14e17cc0d8-smtp-out-n03;
 Tue, 17 Mar 2020 15:52:22 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 69A8FC433BA; Tue, 17 Mar 2020 15:52:22 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CBA72C433D2;
        Tue, 17 Mar 2020 15:52:21 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 17 Mar 2020 21:22:21 +0530
From:   Sibi Sankar <sibis@codeaurora.org>
To:     bjorn.andersson@linaro.org, robh+dt@kernel.org, joro@8bytes.org,
        robin.murphy@arm.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-remoteproc@vger.kernel.org, ohad@wizery.com,
        agross@kernel.org, dianders@chromium.org,
        saiprakash.ranjan@codeaurora.org
Subject: Re: [PATCH v2 0/3] Request direct mapping for modem device
In-Reply-To: <20200317150910.26053-1-sibis@codeaurora.org>
References: <20200317150910.26053-1-sibis@codeaurora.org>
Message-ID: <fe9bb128563bea9798573ac9eec1d214@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-03-17 20:39, Sibi Sankar wrote:
> The Q6 modem sub-system has direct access to DDR through memnoc and
> an indirect access routed through a SMMU which MSS CE (crypto engine
> sub-component of MSS) uses during out of reset sequence. Request direct
> mapping for the modem device since smmu is not expected to provide 
> access
> control/translation for these SIDs (sandboxing of the modem is achieved
> through XPUs engaged using SMC calls). This is done on platforms which
> don't have TrustZone (which programs the modem SIDs) to prevent the
> following global faults seen on Cheza/Trogdor:
> 
> Cheza:
> arm-smmu 15000000.iommu: Unexpected global fault, this could be serious
> arm-smmu 15000000.iommu: GFSR 0x80000002, GFSYNR0 0x00000000,
> 			 GFSYNR1 0x00000781, GFSYNR2 0x00000000
> 
> Trogdor:
> arm-smmu 15000000.iommu: Unexpected global fault, this could be serious
> arm-smmu 15000000.iommu: GFSR 0x80000002, GFSYNR0 0x00000000,
> 			 GFSYNR1 0x00000461, GFSYNR2 0x00000000
> 
> V2:
>  * Request direct mapping from SoC-specific corner of the SMMU
>    driver [Robin]
>  * Add iommu property to remoteproc modem node on Cheza
> 
> Depends on:
> https://lore.kernel.org/patchwork/cover/1183528/
> 
> Sibi Sankar (3):
>   dt-bindings: remoteproc: qcom: Add iommus property
>   remoteproc: qcom_q6v5_mss: Request direct mapping for modem device

iommu: arm-smmu-qcom: Request direct mapping for modem device

sry should have been ^^ instead


>   arm64: dts: qcom: sdm845-cheza: Add iommus property
> 
>  Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt | 3 +++
>  arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi                 | 4 ++++
>  drivers/iommu/arm-smmu-qcom.c                              | 6 ++++++
>  3 files changed, 13 insertions(+)

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.
