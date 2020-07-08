Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54DF4C433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 17:01:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32572206F6
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 17:01:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R0L8z7z3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730800AbgGHRBH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 13:01:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbgGHRBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 13:01:06 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87EBFC08C5C1;
        Wed,  8 Jul 2020 10:01:05 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id l17so4029009wmj.0;
        Wed, 08 Jul 2020 10:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kmG9b4C0CGWiQmngusza359yBl9owEptyLOdBdxcZPw=;
        b=R0L8z7z3gg2e8s10ZSWNSgyEjZAAMPCzk7F8P9EWXVkYhXtCupySosRDeHdcZcKvT8
         liPiJPb6ctjJQespNd09zAdoFfagtBn4l5yyJtHvyyoxYNwpFsSWiSrVIwL8FVsHdtsw
         jEBc61J6o2bmaHQ+cJlAmw9OkfSyOMa4E141uykah44gvGS3YOGUIPv+1aeQXIfDxzhG
         56M0Epi3WqI4Ycb4uByVbzLmvN6uj0xC5wn0gec4/JW8plTve+IE2v1w+cqnr5jwXhpK
         LO+F1v1fcr3k/NpKZyFCmNfjg6to2tfYJpoGyJm41Xj2s3Q5vmkRtLKeaNK4QQLGxC53
         Y/Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kmG9b4C0CGWiQmngusza359yBl9owEptyLOdBdxcZPw=;
        b=fFTHIKF82QjKPAmJ3FV71m2SeOdEYwt6ybw+dpAxvczANDNbASm4fJKi/HoSS+C8Tm
         HYe8V/5MHaUWGve7lEruNHL3kCgR+icgolaBG0nu1RRIE/Y+RI3o3P0cSW/iFIR/Kl92
         /U59xsC5nVGlzbkAQ5HMepxz4eydStZkFaNjxFdBVkZWdFUDqCaEkkXPbvzqFc4lQrk7
         Ehx0AOPnOVkMvTJdfKznU8g07tqirn4BomGbUTJiQEvILAkANUJy/QanZPNJGdZ8aiWE
         Rcf5aVyapUJyLV3feAeGB4uo2/EX9FXEeGV9Uy09k93CBcHRUv8wFw09m24xa5cBO4X3
         /Qhw==
X-Gm-Message-State: AOAM530XnmV5KZ/gVzU1COmpdU8viuNOgrKcAbMq3bELPtejT09Yet+n
        2R6kYMU9iiTPiooSRluBkVo=
X-Google-Smtp-Source: ABdhPJwRCorVzWEJ98mxCh/6oheaQq5W6O1pJfnoyvQ+20/LU2fCMzKSwSK3HCxoGP90YIcw/bwzfg==
X-Received: by 2002:a1c:49d7:: with SMTP id w206mr10756670wma.181.1594227664190;
        Wed, 08 Jul 2020 10:01:04 -0700 (PDT)
Received: from ziggy.stardust (static-99-78-7-89.ipcom.comunitel.net. [89.7.78.99])
        by smtp.gmail.com with ESMTPSA id j6sm895312wro.25.2020.07.08.10.01.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2020 10:01:03 -0700 (PDT)
Subject: Re: [PATCH] arm64: dts: mt8173: Re-measure capacity-dmips-mhz
To:     Hsin-Yi Wang <hsinyi@chromium.org>,
        linux-mediatek@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        ikjn@chromium.org
References: <20200706083705.2343150-1-hsinyi@chromium.org>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <71bc5fa2-0869-5d91-6bb8-e8d59176e19c@gmail.com>
Date:   Wed, 8 Jul 2020 19:01:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200706083705.2343150-1-hsinyi@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/07/2020 10:37, Hsin-Yi Wang wrote:
> Re measure capacity-dmips-mhz on elm and hana:
> 
> cpu 1:  9502 DMIPS @ 1703 Mhz
> cpu 3: 16250 DMIPS @ 2106 Mhz
> 
> ==> 740 : 1024

I have some trouble to match the commit message to the actual patch. Commit 
message talks about cpu 1 but patch changes cpu0. Where are the values of the 
other CPUs?

Regards,
Matthias

> 
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---
>   arch/arm64/boot/dts/mediatek/mt8173.dtsi | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> index 70b1ffcab7f0..5e046f9d48ce 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> @@ -167,7 +167,7 @@ cpu0: cpu@0 {
>   				 <&apmixedsys CLK_APMIXED_MAINPLL>;
>   			clock-names = "cpu", "intermediate";
>   			operating-points-v2 = <&cluster0_opp>;
> -			capacity-dmips-mhz = <526>;
> +			capacity-dmips-mhz = <740>;
>   		};
>   
>   		cpu1: cpu@1 {
> @@ -182,7 +182,7 @@ cpu1: cpu@1 {
>   				 <&apmixedsys CLK_APMIXED_MAINPLL>;
>   			clock-names = "cpu", "intermediate";
>   			operating-points-v2 = <&cluster0_opp>;
> -			capacity-dmips-mhz = <526>;
> +			capacity-dmips-mhz = <740>;
>   		};
>   
>   		cpu2: cpu@100 {
> 
