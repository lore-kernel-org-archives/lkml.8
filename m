Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E99BC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 15:01:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DE7620709
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 15:01:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="awVghec/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729479AbgGUPBR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 11:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726710AbgGUPBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 11:01:16 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82E6DC061794
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 08:01:16 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id gc15so1524017pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 08:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/Qaew4QJeDWIbHxaIC4ZFCXZp/j8T/O+RXZWS5JxQBs=;
        b=awVghec/Xv7N4jnb0ivK1KZBxyps6BqZ757DEs33+E4ee8cKx13kg6wuykfA/LBLOh
         +wnX2xVcp86JvLi/MEQRqWyzz0wn9ClTZeCHUTJNs1/b0bdfTehPPVJt/O264qOZDS3D
         hz9IUsTCEqBvXqBbfI8YKWLp0SUXcUo3XWr6X5qLNMkbxgjYhuV1QH37sbOx35KTaj39
         5kppJOiP/Fk68ncCq8UBQ8JC7rYl0dcKizF4Hi5/jUQMjwXzl8USWgFuUZFcMJpTlRBc
         /ebIrTKk0AzuQawdFqKAy1o7CSTTWC81qLrFfKabdYX0k0EEKCw8Y86Bo1UqL1nm3HJC
         3gnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/Qaew4QJeDWIbHxaIC4ZFCXZp/j8T/O+RXZWS5JxQBs=;
        b=b0zjftk0/307jJTuODu2CFD9N7qRZs1hMKVTtlteZVx4uirXSISxNg1rNAmVckhBVn
         rcSzrIGvaSIHPs1bD4iD+roGtHW6GZrH7Xw+F5NuxbfcNog+K7/Yk8c8gaYzhiBIhik5
         xcab45DjZMbXi/5ELL9HVOAnx1MFbMdJC0O2FhfaKONQC3X5DVc+YogWA36HgdPUtSb9
         oyH5cDEFfvznacuBrbnciFs8+H2cL86lA6XXt3zOtKtVxiITj/BkTM1I8QNxjieQdeLn
         KuEXNYvx42RoMMNAqeTKT9xtQ/3sIzXa4fmGu4qIOhTgbmSkXIZ/DGc1FwfkTe8CE41D
         a+/A==
X-Gm-Message-State: AOAM533HzXjqjtRJ08M6hYMZmcpqTebSmjyEPcQnahN+DqGYRfkauMTo
        B08+UhMytioXRHEL8sX8bkCg6w==
X-Google-Smtp-Source: ABdhPJxwSj6Y65B/irw2WmgGdBIQHcnhxUdwU6YYxAgzTFSpfyquDbZvh9MJVEFM8KJsV3GdwyXbtA==
X-Received: by 2002:a17:90a:2465:: with SMTP id h92mr4951912pje.26.1595343676029;
        Tue, 21 Jul 2020 08:01:16 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id m19sm18547881pgd.13.2020.07.21.08.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 08:01:15 -0700 (PDT)
Date:   Tue, 21 Jul 2020 09:01:13 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sdm845: Support ETMv4 power management
Message-ID: <20200721150113.GB1216561@xps15>
References: <20200721071343.2898-1-saiprakash.ranjan@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200721071343.2898-1-saiprakash.ranjan@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 21, 2020 at 12:43:43PM +0530, Sai Prakash Ranjan wrote:
> Add "arm,coresight-loses-context-with-cpu" property to coresight
> ETM nodes to avoid failure of trace session because of losing
> context on entering deep idle states.
> 
> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index e506793407d8..0b5f063dcaea 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -3016,6 +3016,7 @@ etm@7040000 {
>  
>  			clocks = <&aoss_qmp>;
>  			clock-names = "apb_pclk";
> +			arm,coresight-loses-context-with-cpu;
>  
>  			out-ports {
>  				port {
> @@ -3035,6 +3036,7 @@ etm@7140000 {
>  
>  			clocks = <&aoss_qmp>;
>  			clock-names = "apb_pclk";
> +			arm,coresight-loses-context-with-cpu;
>  
>  			out-ports {
>  				port {
> @@ -3054,6 +3056,7 @@ etm@7240000 {
>  
>  			clocks = <&aoss_qmp>;
>  			clock-names = "apb_pclk";
> +			arm,coresight-loses-context-with-cpu;
>  
>  			out-ports {
>  				port {
> @@ -3073,6 +3076,7 @@ etm@7340000 {
>  
>  			clocks = <&aoss_qmp>;
>  			clock-names = "apb_pclk";
> +			arm,coresight-loses-context-with-cpu;
>  
>  			out-ports {
>  				port {
> @@ -3092,6 +3096,7 @@ etm@7440000 {
>  
>  			clocks = <&aoss_qmp>;
>  			clock-names = "apb_pclk";
> +			arm,coresight-loses-context-with-cpu;
>  
>  			out-ports {
>  				port {
> @@ -3111,6 +3116,7 @@ etm@7540000 {
>  
>  			clocks = <&aoss_qmp>;
>  			clock-names = "apb_pclk";
> +			arm,coresight-loses-context-with-cpu;
>  
>  			out-ports {
>  				port {
> @@ -3130,6 +3136,7 @@ etm@7640000 {
>  
>  			clocks = <&aoss_qmp>;
>  			clock-names = "apb_pclk";
> +			arm,coresight-loses-context-with-cpu;
>  
>  			out-ports {
>  				port {
> @@ -3149,6 +3156,7 @@ etm@7740000 {
>  
>  			clocks = <&aoss_qmp>;
>  			clock-names = "apb_pclk";
> +			arm,coresight-loses-context-with-cpu;
>  
>  			out-ports {
>  				port {
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
> 
