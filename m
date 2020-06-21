Return-Path: <SRS0=0j3N=AC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA5FEC433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 07:25:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA8E22486C
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 07:25:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KQR3Qdwr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729429AbgFUHZD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jun 2020 03:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729395AbgFUHZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jun 2020 03:25:01 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CAAFC061795
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jun 2020 00:25:01 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id k1so6098037pls.2
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jun 2020 00:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=t8DfxJQgsCB49aGfdQiob3v0fXxUaFZwxnv8u/wZF/o=;
        b=KQR3QdwrumXa62xgL+DVytV1CTh7/7+K7UWVQw+wq4Xw96YtBusVtgLr48eeF+tFuQ
         OWXhrt9WOLh/OpeX3oe+7UsSWerjF+K9IxLgXwKKaZrOzJgdGAFnLsQFMiK8WlEx1KQe
         s97MKMkCDslPjdT0c49KVqoqxEil1HM4YYHXpmLJi9ADTuQDOG4jegROfNiaV87XxtQM
         LXbnWYQcdRCxFrLUWBY9bmfM3z+TfISg3PO5PpPFu1GVcj00PREZ1ei4fTs4YHYz/4Y4
         XwRz//QTB6GGC/+iIeYPT9UWYS8gAntsDzOP9hVKpIN8gNjBvU73eBGiIG904dnJCnCc
         Sugw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=t8DfxJQgsCB49aGfdQiob3v0fXxUaFZwxnv8u/wZF/o=;
        b=RAxf+ElJ5wivLV9klnWcbYXlIwKE16cSGvZqqWtcBS72xjOuuqLTRcTNV7yrN+6aHg
         PE0gvRs96djVFNd2z8bNax9ahkU5DyiQKP4pd6OM97vyhiCNiP1e8xaGIrFuxKfmwtIw
         2OCTzLcmVz9sz9ZSeVIexIdeFBLvsLbt/MjxwimH7wmuW4gPiRDBkejM4Fc2rDXFkUIJ
         VcBoh4U4Gp6jZZwzoDDwHYMMpM8ai9/AU5Qfjo29hWAU6OFkXfOkNVdwCTdvvvFhx0Te
         F/GUVJTAaJjlkyfK4JmxnGzgl/jRv4vjn8b1fItzXjOM+BJqa+AqEZKwk3z/zurIKCga
         SpZA==
X-Gm-Message-State: AOAM531qiYrO71VcEFxyf/lfYTIKk1jrAAq26lb+HmOOOzcB/wIbqUFe
        uP6mEHSYI0SjCrwfDDyHgOpImA==
X-Google-Smtp-Source: ABdhPJzdfufl/2D2MnrN1ggslh+BlG+1XHrUvCJ0m6IM55MOOhIMmKkvsm/pMCewTxbEWp4a5dJCgw==
X-Received: by 2002:a17:90b:3793:: with SMTP id mz19mr11685376pjb.12.1592724300915;
        Sun, 21 Jun 2020 00:25:00 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id c194sm10037877pfc.212.2020.06.21.00.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2020 00:25:00 -0700 (PDT)
Date:   Sun, 21 Jun 2020 00:22:13 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc:     Andy Gross <agross@kernel.org>, Stephen Boyd <swboyd@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        mike.leach@linaro.org, Jonathan Marek <jonathan@marek.ca>
Subject: Re: [PATCH 2/4] arm64: dts: qcom: sc7180: Add iommus property to ETR
Message-ID: <20200621072213.GG128451@builder.lan>
References: <cover.1591708204.git.saiprakash.ranjan@codeaurora.org>
 <2312c9a10e7251d69e31e4f51c0f1d70e6f2f2f5.1591708204.git.saiprakash.ranjan@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2312c9a10e7251d69e31e4f51c0f1d70e6f2f2f5.1591708204.git.saiprakash.ranjan@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 09 Jun 06:30 PDT 2020, Sai Prakash Ranjan wrote:

> Define iommus property for Coresight ETR component in
> SC7180 SoC with the SID and mask to enable SMMU
> translation for this master.
> 

We don't have &apps_smmu in linux-next, as we've yet to figure out how
to disable the boot splash or support the stream mapping handover.

So I'm not able to apply this.

Regards,
Bjorn

> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/sc7180.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> index f684a0b87848..9b38867740ca 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> @@ -1711,6 +1711,7 @@
>  		etr@6048000 {
>  			compatible = "arm,coresight-tmc", "arm,primecell";
>  			reg = <0 0x06048000 0 0x1000>;
> +			iommus = <&apps_smmu 0x04a0 0x20>;
>  
>  			clocks = <&aoss_qmp>;
>  			clock-names = "apb_pclk";
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
> 
