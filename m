Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D2EFC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 525B520758
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:02:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lH4mJXL6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390225AbgHQSC1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 14:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389624AbgHQSCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 14:02:01 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1976CC061342
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 11:02:00 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id y6so7923125plt.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 11:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WDw5eMluEqJ71UREIfdhLPB079gyndxPuX/d/PHa2Q8=;
        b=lH4mJXL67WGnjmOPFlC/XMt7+biiQPvdCIitAOA7CnDS96ZV60CLgfv8bglKeuCSu6
         4SfaZpWGc+jg2/VTpMrRebhg63dsBW0e+GKH7i2JdiltjEMkX8M2aFxFahU6JdFifONV
         t8EVV3qa9mFYayJE4ty3p9v42scjEUUEmPDpc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WDw5eMluEqJ71UREIfdhLPB079gyndxPuX/d/PHa2Q8=;
        b=ivXNdqY8k9beUfPUZIMcGccG9Azs2uQx7aJuvdk+bLYV0IkCYxoUK0AvzQLQLycFA1
         B9sBEMVLf2oJghuTe3OR3MgUQWk8VRZBKmYwFcDIoZu+RcRonC3R4qOAIE8/RP7r6YlI
         +uqiNg6bmNVt/g5UXV4Vayu4A4HWTuHWjFpxdTPDkMelgk0fr8IjRjn/wF8ldRIsorNC
         zgmesu1qbxbNqIKgdEsJfoGmVjIv9EEg0ciujdhBjRkoUzkKBDK9lMljAPuBjCrqTKwA
         B8R9S4owAAep+/yU0zQJBoLdFQj4xJ2CyebabTdEm+rde5QG2xdabnQkSJs5dXI74d0r
         f/Yg==
X-Gm-Message-State: AOAM530PfoAE+pn+pAfWGzmx/8mIcsYztw41WEIhQIRtrXHVlReel8WZ
        tAe2V/hK2T2VMM4JhfoEJ7XkKw==
X-Google-Smtp-Source: ABdhPJzTSklBYKNKgwQHtVwq6E0KgdOo2lDcZNazJWEFqsY1hZgpv5RGw21eM5NAFArPgo5KBNW+lg==
X-Received: by 2002:a17:90b:3891:: with SMTP id mu17mr13119099pjb.160.1597687320442;
        Mon, 17 Aug 2020 11:02:00 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:f693:9fff:fef4:e70a])
        by smtp.gmail.com with ESMTPSA id x136sm20161179pfc.28.2020.08.17.11.01.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2020 11:01:59 -0700 (PDT)
Date:   Mon, 17 Aug 2020 11:01:58 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     satya priya <skakit@codeaurora.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        gregkh@linuxfoundation.org, Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, akashast@codeaurora.org,
        rojay@codeaurora.org, msavaliy@qti.qualcomm.com
Subject: Re: [PATCH V2 2/3] arm64: dts: qcom: sc7180: Add sleep pin ctrl for
 BT uart
Message-ID: <20200817180158.GD2995789@google.com>
References: <1595563082-2353-1-git-send-email-skakit@codeaurora.org>
 <1595563082-2353-3-git-send-email-skakit@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1595563082-2353-3-git-send-email-skakit@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 24, 2020 at 09:28:01AM +0530, satya priya wrote:
> Add sleep pin ctrl for BT uart, and also change the bias
> configuration to match Bluetooth module.
> 
> Signed-off-by: satya priya <skakit@codeaurora.org>
> ---
> Changes in V2:
>  - This patch adds sleep state for BT UART. Newly added in V2.
> 
>  arch/arm64/boot/dts/qcom/sc7180-idp.dts | 42 ++++++++++++++++++++++++++++-----
>  1 file changed, 36 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7180-idp.dts b/arch/arm64/boot/dts/qcom/sc7180-idp.dts
> index 26cc491..bc919f2 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180-idp.dts
> +++ b/arch/arm64/boot/dts/qcom/sc7180-idp.dts
> @@ -469,20 +469,50 @@
>  
>  &qup_uart3_default {
>  	pinconf-cts {
> -		/*
> -		 * Configure a pull-down on 38 (CTS) to match the pull of
> -		 * the Bluetooth module.
> -		 */
> +		/* Configure no pull on 38 (CTS) to match Bluetooth module */

Has the pull from the Bluetooth module been removed or did the previous config
incorrectly claim that the Bluetooth module has a pull-down?

>  		pins = "gpio38";
> +		bias-disable;
> +	};
> +
> +	pinconf-rts {
> +		/* We'll drive 39 (RTS), so configure pull-down */
> +		pins = "gpio39";
> +		drive-strength = <2>;
>  		bias-pull-down;
> +	};
> +
> +	pinconf-tx {
> +		/* We'll drive 40 (TX), so no pull */

The rationales for RTS and TX contradict each other. According to the comment
the reason to configure a pull-down on RTS is that it is driven by the host.
Then for TX the reason to configure no pull is that it is driven by the host.

Please make sure the comments *really* describe the rationale, otherwise they
are just confusing.
