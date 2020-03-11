Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F3DBC2BAEE
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 17:51:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27B3820737
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 17:51:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eNRE/qbm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730636AbgCKRv5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 13:51:57 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46144 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730487AbgCKRv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 13:51:57 -0400
Received: by mail-pl1-f193.google.com with SMTP id w12so1420949pll.13
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 10:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=a5g25PDEXPRR99KehOK1iE2Gu80HzFKYuNkkikGwIFI=;
        b=eNRE/qbm63stiKXIvgwIlV+IxOrzorOkM4iow7B6RZUpJva1559bRWMvw2agkD7Mis
         2YTH3veSMsgbKxZyscQrguxH0BD1nYGckFuQ/fdaY2NKujUR7G6NuenUZTTOfFuGSGgH
         Qxht0ueO4ugRgmAZGeX2WtSxnNFHitwKoKXgM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=a5g25PDEXPRR99KehOK1iE2Gu80HzFKYuNkkikGwIFI=;
        b=T25G6Ogje0Ex7XoeG53CfvEJmUhrVaxAsDZYxWtbO6YOH8mk7U/iB9kaCV+ypYAlKo
         j4zPJ/I3N3+FLGAAnbgp3+xq/+OteCeSfQosbuV5OGjqAbZKAykqyfLyQd8K1TUGesBU
         y4iZ50CoxUhEYC2YdJCd5teH6nIUSUtVfWg8xKNVnByrKSSRUV3YaUP/+J3KUz0YqWJ/
         t7jSUsmQLvv1oFmO4bYv6KS7q6uWswe+8yRKAJusz9iLfTxzJn9chd3BI1UX5EZ0RmYU
         QR0mTycMQT8/auo0qsqAUB8qbXWUgVKmfp84Ydk6moFgd9NrJHmVMH4DGhaz7gPTIEDW
         oESA==
X-Gm-Message-State: ANhLgQ0PyW2Vi+Dyf66ZdD0ng0+kgxBPZIv+6jVLIZr4m5oXlvyve/tY
        xazE10kBXJQfnI0U2w1mrrxoLw==
X-Google-Smtp-Source: ADFU+vsBi+bUj1VxZCycAe0rgyooLlJtfjkUSx8xr00Nuup+ET1asdfp4FcWsNKm5fSW9KpT0NQn8w==
X-Received: by 2002:a17:902:bc4c:: with SMTP id t12mr3853587plz.54.1583949115991;
        Wed, 11 Mar 2020 10:51:55 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id d3sm5730078pfq.126.2020.03.11.10.51.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2020 10:51:54 -0700 (PDT)
Date:   Wed, 11 Mar 2020 10:51:53 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Sandeep Maheswaram <sanm@codeaurora.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Manu Gautam <mgautam@codeaurora.org>
Subject: Re: [PATCH v4 4/4] arm64: dts: qcom: sc7180: Correct qmp phy reset
 entries
Message-ID: <20200311175153.GB144492@google.com>
References: <1583928252-21246-1-git-send-email-sanm@codeaurora.org>
 <1583928252-21246-5-git-send-email-sanm@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1583928252-21246-5-git-send-email-sanm@codeaurora.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sandeep,

This patch landed in Bjorn's tree (arm64-for-5.7 branch). In case you have
to re-spin the series there is no need to include it.

On Wed, Mar 11, 2020 at 05:34:12PM +0530, Sandeep Maheswaram wrote:
> The phy reset entries were incorrect.so swapped them.
> 
> Signed-off-by: Sandeep Maheswaram <sanm@codeaurora.org>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  arch/arm64/boot/dts/qcom/sc7180.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> index 9d112aa..253274d 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> @@ -1306,8 +1306,8 @@
>  				 <&gcc GCC_USB3_PRIM_PHY_COM_AUX_CLK>;
>  			clock-names = "aux", "cfg_ahb", "ref", "com_aux";
>  
> -			resets = <&gcc GCC_USB3_DP_PHY_PRIM_BCR>,
> -				 <&gcc GCC_USB3_PHY_PRIM_BCR>;
> +			resets = <&gcc GCC_USB3_PHY_PRIM_BCR>,
> +				 <&gcc GCC_USB3_DP_PHY_PRIM_BCR>;
>  			reset-names = "phy", "common";
>  
>  			usb_1_ssphy: phy@88e9200 {
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
> 
