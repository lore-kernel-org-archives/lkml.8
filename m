Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5FC3C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 17:18:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3669206D7
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 17:18:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qMf5OWp/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729772AbgFORSB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 13:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729354AbgFORSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 13:18:00 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F32CAC061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 10:17:59 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id l63so5618771pge.12
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 10:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4tBg685n+rvOlJARxC/GZpj7s58rUY4EPS7OgTBXC28=;
        b=qMf5OWp/BZGBVGr6GzBckHt7yZutPv6Ww0rfvb7z0X6LV4pWqnPy6J1A3STjwKZMWi
         nVBys61Vt7LoY86iMXOZtz8Cac6wHUA2uwAWybbItiJy9TChYqMS/gjHJq7rL09/sOEt
         OesmI/6d7jNHv1UL/WtnVV2TkJ1V58mZCeuO+YMK4uWp9VM1H30g9Bn3c1JbNohJWFSI
         csKqKPb8i+P6Mgo+G2Y4CwGRgBi6Vh+Y2RfjP2BhRdNoVTapT7y0zBIe3Ub5RALjtJkc
         SQzsXAoZWDnwZnBThFKWfsLfnuezFzF4YfSabLLP3QzLPYn8qzqhyspUwgqqPjxetusa
         4fHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4tBg685n+rvOlJARxC/GZpj7s58rUY4EPS7OgTBXC28=;
        b=LmYw2vOH2ZEuqd6xooWPXzN7uIE/97WEmdlz10HgdJJ88XjVqs/lehPpuAgcxlH9Ji
         oy/miR2skcAR8loBmJevKmnmD0J7ImKBrYjvDI1WYSRiwnT6nuswUctGkn5JPQ8MHuTi
         lRdpQrgGp5sX5gGUn87fRwBMQwrvG1DVgi1WwapLPOFgjKV/s9T3L8EVILa1Mdmh/neI
         hX5YA6BGgKurXSHpiU/a8qGwtQY+Oi11/sUgp9ZzvnXzX60mS7d1BHWX3DZdgYklzXut
         HcvoKXTSZGHMgci1WjUzPgF7yCvipjIqphVMjMf08kSyX2w+z76JsTC42pu5KAThpKY/
         av6A==
X-Gm-Message-State: AOAM531qyopMa+OSsx5IrNKx1lChwh4txCy5kEB4zTLXcRe2az4rHHIF
        cJgPQ2ztd8PtQoFRne+fXvtoOA==
X-Google-Smtp-Source: ABdhPJzDcXoNX77HGgl+fpRA2bt04/aYiGdDfkkyODxwlkE3OkNhPp/3uUdSH5iaHvmi/LICqc75gQ==
X-Received: by 2002:a62:640b:: with SMTP id y11mr23794549pfb.195.1592241478412;
        Mon, 15 Jun 2020 10:17:58 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id i22sm14310258pfo.92.2020.06.15.10.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 10:17:57 -0700 (PDT)
Date:   Mon, 15 Jun 2020 11:17:55 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        mike.leach@linaro.org, Jonathan Marek <jonathan@marek.ca>
Subject: Re: [PATCH 1/4] arm64: dts: qcom: sc7180: Add support to skip
 powering up of ETM
Message-ID: <20200615171755.GA225607@xps15>
References: <cover.1591708204.git.saiprakash.ranjan@codeaurora.org>
 <8c5ff297d8c89d9d451352f189baf26c8938842a.1591708204.git.saiprakash.ranjan@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c5ff297d8c89d9d451352f189baf26c8938842a.1591708204.git.saiprakash.ranjan@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 09, 2020 at 07:00:28PM +0530, Sai Prakash Ranjan wrote:
> Add "qcom,skip-power-up" property to skip powering up ETM
> on SC7180 SoC to workaround a hardware errata where CPU
> watchdog counter is stopped when ETM power up bit is set
> (i.e., when TRCPDCR.PU = 1).
> 
> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> ---
> 
> Depends on ETM driver change here:
>  - https://git.linaro.org/kernel/coresight.git/commit/?h=next-v5.8-rc1&id=159e248e75b1b548276b6571d7740a35cab1f5be 
> 
> ---
>  arch/arm64/boot/dts/qcom/sc7180.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> index 7c2b79dda3d7..f684a0b87848 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> @@ -1810,6 +1810,7 @@
>  			clocks = <&aoss_qmp>;
>  			clock-names = "apb_pclk";
>  			arm,coresight-loses-context-with-cpu;
> +			qcom,skip-power-up;
>  
>  			out-ports {
>  				port {
> @@ -1829,6 +1830,7 @@
>  			clocks = <&aoss_qmp>;
>  			clock-names = "apb_pclk";
>  			arm,coresight-loses-context-with-cpu;
> +			qcom,skip-power-up;
>  
>  			out-ports {
>  				port {
> @@ -1848,6 +1850,7 @@
>  			clocks = <&aoss_qmp>;
>  			clock-names = "apb_pclk";
>  			arm,coresight-loses-context-with-cpu;
> +			qcom,skip-power-up;
>  
>  			out-ports {
>  				port {
> @@ -1867,6 +1870,7 @@
>  			clocks = <&aoss_qmp>;
>  			clock-names = "apb_pclk";
>  			arm,coresight-loses-context-with-cpu;
> +			qcom,skip-power-up;
>  
>  			out-ports {
>  				port {
> @@ -1886,6 +1890,7 @@
>  			clocks = <&aoss_qmp>;
>  			clock-names = "apb_pclk";
>  			arm,coresight-loses-context-with-cpu;
> +			qcom,skip-power-up;
>  
>  			out-ports {
>  				port {
> @@ -1905,6 +1910,7 @@
>  			clocks = <&aoss_qmp>;
>  			clock-names = "apb_pclk";
>  			arm,coresight-loses-context-with-cpu;
> +			qcom,skip-power-up;
>  
>  			out-ports {
>  				port {
> @@ -1924,6 +1930,7 @@
>  			clocks = <&aoss_qmp>;
>  			clock-names = "apb_pclk";
>  			arm,coresight-loses-context-with-cpu;
> +			qcom,skip-power-up;
>  
>  			out-ports {
>  				port {
> @@ -1943,6 +1950,7 @@
>  			clocks = <&aoss_qmp>;
>  			clock-names = "apb_pclk";
>  			arm,coresight-loses-context-with-cpu;
> +			qcom,skip-power-up;

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

>  
>  			out-ports {
>  				port {
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
> 
