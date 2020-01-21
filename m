Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8DD3C2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 12:32:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B89E217F4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 12:32:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F4LJ0mcg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729678AbgAUMca (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 07:32:30 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:44500 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729375AbgAUMc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 07:32:28 -0500
Received: by mail-ed1-f68.google.com with SMTP id bx28so2745388edb.11
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 04:32:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SL+YF5Uofufimw4rDKfqmNibtNPjVUG+hLupAtvlD2M=;
        b=F4LJ0mcgZTCF24ZNSkWceJ2+LXhM1w8W9vLaRiJYZG+NfN3Q6zP6KECdytxCUQLcdj
         378uw024Loy9mByscDnH7SyccPgbbumow0Fh1LlcNQWGh0boDEUyKTwlJdttgVrW34Rt
         T/gDIx+cRlMycWAgj2wSx4PGodUHLt6IYEwRUF+DvHd/hPCkZ05WgaGvRT5YMa882FZZ
         gZ8j5hqB6Gpkgs2ZhO+WQvpoqPWggEMkQaicgBgSm4+k4UOhgn1qPjnh/XmH5Y9HIQWO
         H3MjwkA9OW0g2YCyA9qyN9PKwdN37236q/nsHWTAmzNS+sZezuvPnHE74gMA/Na+PXn4
         mvNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SL+YF5Uofufimw4rDKfqmNibtNPjVUG+hLupAtvlD2M=;
        b=rrk8pkxiAlcEcO/95RfZMaE+HMQpuVLnCbUEcIm/c9uGuyB3r6b2xCnV2ZQ76EjOB/
         QaBS7+lwOfk/+PWoEsA8M5puEJJPQ4cV+wrlSDeGKksdEb/ajE3kd4lqoM1batoRSqv4
         l8uv6Ibf1Zr28eOmMfPmcIwwBQXf02BOANLGxUgwKpyn0Tdgz/U/A1Nhu8skc9XRaKc6
         vStf2sAFiGy6F0TUzpnTwYFdDl+OgO72eE/6yqVc+b7y0KfFlyQ3YRsSZkwPkeu4dtTb
         Xz+KbE01kBhBVHGiV8+nRkUa1jphJVIJxg6kIu+8dmyx1epE4u8Kw8JXdfKoVmvebMXk
         G9sg==
X-Gm-Message-State: APjAAAWMO4ODbtwxT+yl8GT93Op+Bjpr8XzZqaTbUP4Bw8BHtnnEvaol
        3uhKETimBSg5dSILVs5Fq48bT3HizfI=
X-Google-Smtp-Source: APXvYqwUyxzwa78ktvSmQlERGkWfMEq+Iav0VLVz+58M305ktq8lVUWTidW0Amk/Zxhdv1fRA7FIHQ==
X-Received: by 2002:a17:906:b841:: with SMTP id ga1mr4129501ejb.184.1579609946792;
        Tue, 21 Jan 2020 04:32:26 -0800 (PST)
Received: from [192.168.27.209] ([37.157.136.193])
        by smtp.googlemail.com with ESMTPSA id e21sm1411279eds.36.2020.01.21.04.32.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jan 2020 04:32:26 -0800 (PST)
Subject: Re: [PATCH V4 4/4] arm64: dts: sc7180: Add Venus firmware subnode
To:     Dikshita Agarwal <dikshita@codeaurora.org>,
        linux-media@vger.kernel.org, stanimir.varbanov@linaro.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, vgarodia@codeaurora.org
References: <1579006416-11599-1-git-send-email-dikshita@codeaurora.org>
 <1579006416-11599-5-git-send-email-dikshita@codeaurora.org>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <9c874b8f-1ac0-d1f5-043f-9a89b8203cd1@linaro.org>
Date:   Tue, 21 Jan 2020 14:32:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1579006416-11599-5-git-send-email-dikshita@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/14/20 2:53 PM, Dikshita Agarwal wrote:
> This adds Venus firmware subnode for non-TZ platform.
> 
> Signed-off-by: Dikshita Agarwal <dikshita@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/sc7180-idp.dts | 6 ++++++
>  1 file changed, 6 insertions(+)

Reviewed-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>

> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7180-idp.dts b/arch/arm64/boot/dts/qcom/sc7180-idp.dts
> index 388f50a..2f82510 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180-idp.dts
> +++ b/arch/arm64/boot/dts/qcom/sc7180-idp.dts
> @@ -287,6 +287,12 @@
>  	vdda-pll-supply = <&vreg_l4a_0p8>;
>  };
>  
> +&venus {
> +	video-firmware {
> +		iommus = <&apps_smmu 0x0c42 0x0>;
> +	};
> +};
> +
>  /* PINCTRL - additions to nodes defined in sc7180.dtsi */
>  
>  &qspi_clk {
> 

-- 
regards,
Stan
