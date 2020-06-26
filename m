Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1FCDC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 16:41:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0FAB207FC
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 16:41:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="MtdrETYC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbgFZQl1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 12:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbgFZQl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 12:41:27 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F8ACC03E979
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 09:41:27 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id u185so2838457pfu.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 09:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=hFXLpE7iZLR8mWC/BJB98odAF50dNLGX6HXgsEqe10Y=;
        b=MtdrETYCbYAe5Wae4JiMSgT8v/aaQbhefe1TDDgDkX0rdv2qi/wS1bKp3aLWHiVvC3
         g09w57rMUfItPUBoMQ7xCj8Baw039IEF/l5NIDuUvp1NW3FkyTGxDvYlLT7zJcpfjXKo
         XZw5t9jYxBZVDrcQRZQtVfV/abVPMpuabhbcE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=hFXLpE7iZLR8mWC/BJB98odAF50dNLGX6HXgsEqe10Y=;
        b=tvuAnwDgpWiE3KAsmwx3WCFmLdQ33vVKIwL0dInlVJvqdyL1JFPBzlh12eVxnWsuVV
         EVPCv9Y9P+HWJwgNAYM0tqP1M/tFCVFizSFM8wMw1r4tEYt6SWmMgj2OXTExhbiNJoPE
         buYc9Cet1DlHU82+xujnIPX8K5cieGIoKznfN8SIEcIjUpIju7o8Fr8XUPDPYtNs/8Zi
         /a9oTgUTva2RJC7V79UHEK6hTO3oer/xKUT+0dfFJBlYHFasjl2BsFIay3VtZLtThYN0
         h8u17TvbbJPnWFG21zkAaLWI4eT3uAjX09OicM3Tf2Xf+cKTdizJ7uss5fE+qLa4pUYv
         OKow==
X-Gm-Message-State: AOAM532XCrfVMa7uuPj+leVKfrcsTqei3cxKNzoKe2bUPMB+BGPamqyM
        USX5PdOKZh9Q5wUvDbTBapIulg==
X-Google-Smtp-Source: ABdhPJxhdS9f8NXQEcBXWWzG7fn0fIgKDq2TpotTVnV0cuajw0/vGlhj1yQXPXDBJVMrNPPQmwDUJw==
X-Received: by 2002:a62:1a0f:: with SMTP id a15mr3787231pfa.177.1593189686532;
        Fri, 26 Jun 2020 09:41:26 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id 125sm20738580pff.130.2020.06.26.09.41.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jun 2020 09:41:25 -0700 (PDT)
Subject: Re: [PATCH] ARM: dts: bcm: Align L2 cache-controller nodename with
 dtschema
To:     Krzysztof Kozlowski <krzk@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20200626080646.4300-1-krzk@kernel.org>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <5a8802f2-d9bf-6a64-1a04-b490bbeb0475@broadcom.com>
Date:   Fri, 26 Jun 2020 09:41:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200626080646.4300-1-krzk@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for cleanup.

On 2020-06-26 1:06 a.m., Krzysztof Kozlowski wrote:
> Fix dtschema validator warnings like:
>      l2-cache@22000: $nodename:0:
>          'l2-cache@22000' does not match '^(cache-controller|cpu)(@[0-9a-f,]+)*$'
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Acked-by: Scott Branden <scott.branden@broadcom.com>
> ---
>   arch/arm/boot/dts/bcm-cygnus.dtsi | 2 +-
>   arch/arm/boot/dts/bcm-hr2.dtsi    | 2 +-
>   arch/arm/boot/dts/bcm-nsp.dtsi    | 2 +-
>   arch/arm/boot/dts/bcm21664.dtsi   | 2 +-
>   4 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/boot/dts/bcm-cygnus.dtsi b/arch/arm/boot/dts/bcm-cygnus.dtsi
> index 1bc45cfd5453..35bdd0969f0a 100644
> --- a/arch/arm/boot/dts/bcm-cygnus.dtsi
> +++ b/arch/arm/boot/dts/bcm-cygnus.dtsi
> @@ -91,7 +91,7 @@
>   			      <0x20100 0x100>;
>   		};
>   
> -		L2: l2-cache@22000 {
> +		L2: cache-controller@22000 {
>   			compatible = "arm,pl310-cache";
>   			reg = <0x22000 0x1000>;
>   			cache-unified;
> diff --git a/arch/arm/boot/dts/bcm-hr2.dtsi b/arch/arm/boot/dts/bcm-hr2.dtsi
> index 5e5f5ca3c86f..cbebed5f050e 100644
> --- a/arch/arm/boot/dts/bcm-hr2.dtsi
> +++ b/arch/arm/boot/dts/bcm-hr2.dtsi
> @@ -104,7 +104,7 @@
>   			      <0x20100 0x100>;
>   		};
>   
> -		L2: l2-cache@22000 {
> +		L2: cache-controller@22000 {
>   			compatible = "arm,pl310-cache";
>   			reg = <0x22000 0x1000>;
>   			cache-unified;
> diff --git a/arch/arm/boot/dts/bcm-nsp.dtsi b/arch/arm/boot/dts/bcm-nsp.dtsi
> index da6d70f09ef1..1c4a46e350e3 100644
> --- a/arch/arm/boot/dts/bcm-nsp.dtsi
> +++ b/arch/arm/boot/dts/bcm-nsp.dtsi
> @@ -122,7 +122,7 @@
>   			      <0x20100 0x100>;
>   		};
>   
> -		L2: l2-cache@22000 {
> +		L2: cache-controller@22000 {
>   			compatible = "arm,pl310-cache";
>   			reg = <0x22000 0x1000>;
>   			cache-unified;
> diff --git a/arch/arm/boot/dts/bcm21664.dtsi b/arch/arm/boot/dts/bcm21664.dtsi
> index 3cf66faf3b56..58ec1b2f8ef6 100644
> --- a/arch/arm/boot/dts/bcm21664.dtsi
> +++ b/arch/arm/boot/dts/bcm21664.dtsi
> @@ -90,7 +90,7 @@
>   		reg-io-width = <4>;
>   	};
>   
> -	L2: l2-cache@3ff20000 {
> +	L2: cache-controller@3ff20000 {
>   		compatible = "arm,pl310-cache";
>   		reg = <0x3ff20000 0x1000>;
>   		cache-unified;

