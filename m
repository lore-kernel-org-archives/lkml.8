Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEFDDC54E8D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 19:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1E38206DB
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 19:30:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OzVpqUU6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731402AbgEKTac (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 15:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731200AbgEKTac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 15:30:32 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D54C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 12:30:31 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id p25so5176952pfn.11
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 12:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gzyfnO/5LbG2mrH2lA0azbgAQiWtK0agPG/QW/aD0JA=;
        b=OzVpqUU6k4CDMc0nrbShznwLyn+kmnl+BiPHhPbWnikxGiuco8hPSb3nS1q3qW7Cek
         TlIdfXMHgEChfZXCfsI3of4zCEHuppr5PoCE3ZmpK0SP1LiofuG1NSTRPyOmD0nbKgGD
         Bwa03tUplrVt+uaafrpI8WO/Kiw8FLdoImebhEbTRHIm2mxwGlr8SIVV8RSntyAW7IIW
         m9WJ98M8I/GIgMuti/4gM3KJ4GRCV7VPnkIyNoVSwhRvr8uOQ9XfPJNaLkNucRR21ygo
         7yLopUX/fMQxLY0w5Z54iE/yRdh2wOKRkc5CN/QWkO77VCCiI1CCgHTzJiuY46Yq4gJI
         1epw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gzyfnO/5LbG2mrH2lA0azbgAQiWtK0agPG/QW/aD0JA=;
        b=sh+3gLOwemgYqS6ohScmspFw9hf/FO7xF9KD/osAyTyLXDMIV68sQcCuLZb2LGsNJW
         VHTxVveo3iaxHn/r8mClCNswYA5TaUe/umgcSysUGfDDl+xQ8jCXXsCgAYqeNhf6Hj2m
         iMPBmjVg+oMRn4xeKbiYZs6I+FFEwBabF1Jn5mAbB+R5BLGCKnGXcUqBh6X97aupNjnr
         wQO7a0+lYZeT5cttIc2qwIt/+6Bo/+sz6n9VUtiKywE5C15Y7PJFcANw0+zm7Gvl0HkN
         y7NyQ+70zdCQWaEsJEbe5Ey5mL+AQvG9UUHo4Aj2v+K7tfojeAsZqwVAWZHXdCZ+eJa1
         i37A==
X-Gm-Message-State: AGi0PuaiHCIratG7Fxd/FHAoJ/27rX3N5LYl5Q5RDV41cXCycSDJpd5y
        /ncoBklxoWSSunz5WIKuxFYNTA==
X-Google-Smtp-Source: APiQypIOtVLmN26sBLQEPnN3hrhyIv6xvI5WifHGysFUwEmFLrhzINvd3EvqA0ARHr6GkqxEp7LIOw==
X-Received: by 2002:a63:750b:: with SMTP id q11mr15767211pgc.138.1589225431230;
        Mon, 11 May 2020 12:30:31 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id z185sm8726197pgz.26.2020.05.11.12.30.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 12:30:30 -0700 (PDT)
Date:   Mon, 11 May 2020 12:31:24 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
        swboyd@chromium.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, dianders@chromium.org,
        evgreen@chromium.org, mka@chromium.org
Subject: Re: [PATCH v6] iommu/arm-smmu-qcom: Request direct mapping for modem
 device
Message-ID: <20200511193124.GG20625@builder.lan>
References: <20200511175532.25874-1-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200511175532.25874-1-sibis@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 11 May 10:55 PDT 2020, Sibi Sankar wrote:

> The modem remote processor has two access paths to DDR. One path is
> directly connected to DDR and another path goes through an SMMU. The
> SMMU path is configured to be a direct mapping because it's used by
> various peripherals in the modem subsystem. Typically this direct
> mapping is configured statically at EL2 by QHEE (Qualcomm's Hypervisor
> Execution Environment) before the kernel is entered.
> 
> In certain firmware configuration, especially when the kernel is already
> in full control of the SMMU, defer programming the modem SIDs to the
> kernel. Let's add compatibles here so that we can have the kernel
> program the SIDs for the modem in these cases.
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---
> 
> V6
>  * Rebased on Will's for-joerg/arm-smmu/updates
>  * Reword commit message and add more details [Stephen]
> 
>  drivers/iommu/arm-smmu-qcom.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iommu/arm-smmu-qcom.c b/drivers/iommu/arm-smmu-qcom.c
> index 5bedf21587a56..cf01d0215a397 100644
> --- a/drivers/iommu/arm-smmu-qcom.c
> +++ b/drivers/iommu/arm-smmu-qcom.c
> @@ -17,7 +17,9 @@ static const struct of_device_id qcom_smmu_client_of_match[] = {
>  	{ .compatible = "qcom,mdp4" },
>  	{ .compatible = "qcom,mdss" },
>  	{ .compatible = "qcom,sc7180-mdss" },
> +	{ .compatible = "qcom,sc7180-mss-pil" },
>  	{ .compatible = "qcom,sdm845-mdss" },
> +	{ .compatible = "qcom,sdm845-mss-pil" },
>  	{ }
>  };
>  
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
