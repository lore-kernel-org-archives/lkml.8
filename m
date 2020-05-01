Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8055BC47254
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 21:59:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A69B21835
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 21:59:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pD3s9EAW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbgEAV7p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 17:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbgEAV7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 17:59:44 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CBFAC061A0E
        for <linux-kernel@vger.kernel.org>; Fri,  1 May 2020 14:59:44 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id m5so5697368ilj.10
        for <linux-kernel@vger.kernel.org>; Fri, 01 May 2020 14:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pDnC17yV3YK6+UXyEP5tqCWTQ7iWQE5yaacGTLu3Bc4=;
        b=pD3s9EAWNfIU7par29nN6lUA34erm8IVRafEDx41O3QbV/hemBxzAtdMXSb3pZm574
         aO9aHakyiRxmGFaRx/JJuIXm2qP1QpRI6DT/uibu9HpFpcIxNVNNN0NfrhmRr6x+w9OL
         U5jDk9RfBViHO4PuRQ1UcNg4udK1HCU6VhdKHepQjPK1zJahKE1raamn+tjJ0afzx01g
         Tns0Qh7Wxh+TMn6G+JFpVi+RJ+OOvijYEVG9F8vYzHR3g8EudBURX8dL5GH/oK99t1Ov
         WKlqB/4JtYBZHuL2FluC+U07eyBEYNvi0YfKz5VGrt7znXVKVIlcMh328Yova+1wR1DP
         CExQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pDnC17yV3YK6+UXyEP5tqCWTQ7iWQE5yaacGTLu3Bc4=;
        b=h4OJpJvQUt3rWQb0NeOlD7TPspCQ1PPvxk2iOHh1kdJxbiXsGjovDfUjpehSG/037t
         mTF3VM5qAYBNalM8pSU1E0oMc/AyKgdU9VRVhytwgF9eRCCoJcPNgwygy3IAAAmoPSTJ
         2YLP2nCT9Iib30Yvf48EAllWYvD3yKQvHsfptw7PybNmT7rnP0EaYb6Xwt0gwbb7G9ag
         3Frno6Vy7XHQAI+0D0WgYfi2IufZChtqe9rQ60+0KK8bu9wdpkbznsmbTJ/PGQJsvidM
         ML3BI2l6R5LLtQ1w/eAr/lnJyBiDtlvPX00H7u4h4+91d+xIK+HYSP9jzZ1e7BsNH3NO
         0yOg==
X-Gm-Message-State: AGi0PuaatIKNZDQIqGYXB7JIn/WUmD+FuFhMUnXFAnemPa+pKandckeX
        pmDQo70oTlLd8US0CrExIWtYug==
X-Google-Smtp-Source: APiQypIex3AmKv2b0vjFHu/JjPhozuTBvTpn+IlLgEkDCXArGdu/fO286GMESqLSgsBCeQY0NXUrzw==
X-Received: by 2002:a92:8515:: with SMTP id f21mr5748721ilh.20.1588370383756;
        Fri, 01 May 2020 14:59:43 -0700 (PDT)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id s5sm1724282ili.59.2020.05.01.14.59.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 May 2020 14:59:43 -0700 (PDT)
Subject: Re: [PATCH net-next 1/4] arm64: dts: sdm845: add IPA iommus property
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net
Cc:     evgreen@chromium.org.net, subashab@codeaurora.org,
        cpratapa@codeaurora.org, bjorn.andersson@linaro.org,
        agross@kernel.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20200501214625.31539-1-elder@linaro.org>
 <20200501214625.31539-2-elder@linaro.org>
Message-ID: <2648d6a5-9ef7-b60d-c9a2-d5e1c083bc0a@linaro.org>
Date:   Fri, 1 May 2020 16:59:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200501214625.31539-2-elder@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/1/20 4:46 PM, Alex Elder wrote:
> Add an "iommus" property to the IPA node in "sdm845.dtsi".  It is
> required because there are two regions of memory the IPA accesses
> through an SMMU.  The next few patches define and map those regions.
> 
> Signed-off-by: Alex Elder <elder@linaro.org>

I'm very sorry, I grouped these incorrectly.

I intended for this one patch to go to Bjorn and Andy to be
taken in through the Qualcomm tree, *not* through the net-next
tree.

I also neglected to mention that this addition is related to
this other series, which has the modem define some IOMMU
streams for the modem to use (one of the definitions is
related to the modem's use of IPA):
   https://lore.kernel.org/patchwork/cover/1227747/

Would you like me to post v2 of the series correcting this?

					-Alex

> ---
>   arch/arm64/boot/dts/qcom/sdm845.dtsi | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index 8f926b5234d4..de6bb86c4968 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -1761,6 +1761,8 @@
>   
>   		ipa: ipa@1e40000 {
>   			compatible = "qcom,sdm845-ipa";
> +
> +			iommus = <&apps_smmu 0x720 0x3>;
>   			reg = <0 0x1e40000 0 0x7000>,
>   			      <0 0x1e47000 0 0x2000>,
>   			      <0 0x1e04000 0 0x2c000>;
> 

