Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59341C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 02:03:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39B272065D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 02:03:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B0UhxI61"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbgF2CDX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jun 2020 22:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbgF2CDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 22:03:23 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38918C03E979
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jun 2020 19:03:22 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id p3so7595450pgh.3
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jun 2020 19:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QDZVkEGnIrKfbxBfohB8JpyHIKxziKsOzFFQJQW1Y2g=;
        b=B0UhxI61raVzv+EmENSz8VpoRV7j2xH27ETZQ52gSc61GH1r/h/ezXpRdNhwEbZHtK
         uBy8nUuY8AqprEoCZxvLTVbKPajt3AEutHfbdumpGqZF0QJpQ1Lrrjn0JqP2dW/V/vTp
         CKJkhzsPVPftyk8Su7NczWON8qvTBXgbq0dBHTeyMy9gGvsoENibT8lhswpFsBOfz3Yx
         N+4hBdcssVo/al2DqZvXi48JBD9Qk2UPSyY4Ann/JkDgP75TCf16LaXHVRTAdh0s4Jle
         KNFS1cDM1sqceGyjDPKA53I4oYdjBEode/i43sgesSCkXk1R8a2UZmdcGwphqJy6W2jR
         KmtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QDZVkEGnIrKfbxBfohB8JpyHIKxziKsOzFFQJQW1Y2g=;
        b=Vq0yaO9m9n9O/t1l38GLU3Yeyrss0K/mkXm0YzPvgP15q8x3Qn9oZM4ACjld0ql9qr
         WcHMpGkX3kWBCcYZmK5q30OBE5ACcIoj/puGkVILsPV/4F72W04Um3sxXuLzIzI0NjNi
         HEHV5F3wF0tQOuXXS5Oi3q7kODx/YtMIuEozkLmuY5QJnDdx361+pEKF+HP+ooIu5v0h
         CaIQylD0Su7M75qkJ9fzODxS6zTf5FFfG18KdV3xcvzRa79+PapxicY590uxB/Z3CMiy
         gdib5jLkg2FttJK4cRHdOwZzZm78TAwqeT6tjiiz2bb7I6G/FOqyWeP3faZZIcUjq2YV
         QIWg==
X-Gm-Message-State: AOAM533ISsAPFH4df2Ek5HxmFAIhv7iehu05AM8yROSt3AC4+w2P7Chh
        Qon28UoahLA1oiZ4llBuERKRKAyAcgc=
X-Google-Smtp-Source: ABdhPJxxkJXjW4f5no0NjX84TxHnLzmVO8fiRUg6nyOW06GtGPhTBdBZIsVWaxOWXIxLMVXsL+WGCg==
X-Received: by 2002:aa7:9184:: with SMTP id x4mr12338959pfa.271.1593396201686;
        Sun, 28 Jun 2020 19:03:21 -0700 (PDT)
Received: from localhost ([122.172.127.76])
        by smtp.gmail.com with ESMTPSA id s10sm4726713pjf.3.2020.06.28.19.03.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Jun 2020 19:03:21 -0700 (PDT)
Date:   Mon, 29 Jun 2020 07:33:18 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Viresh Kumar <vireshk@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: spear: Align L2 cache-controller nodename with
 dtschema
Message-ID: <20200629020318.etzz3xsju7shcglr@vireshk-i7>
References: <20200626080557.3680-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200626080557.3680-1-krzk@kernel.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26-06-20, 10:05, Krzysztof Kozlowski wrote:
> Fix dtschema validator warnings like:
>     l2-cache: $nodename:0: 'l2-cache' does not match '^(cache-controller|cpu)(@[0-9a-f,]+)*$'
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  arch/arm/boot/dts/spear13xx.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/spear13xx.dtsi b/arch/arm/boot/dts/spear13xx.dtsi
> index f187da4485f4..c87b881b2c8b 100644
> --- a/arch/arm/boot/dts/spear13xx.dtsi
> +++ b/arch/arm/boot/dts/spear13xx.dtsi
> @@ -43,7 +43,7 @@
>  			      0 7 0x04>;
>  	};
>  
> -	L2: l2-cache {
> +	L2: cache-controller {
>  		    compatible = "arm,pl310-cache";
>  		    reg = <0xed000000 0x1000>;
>  		    cache-unified;

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
