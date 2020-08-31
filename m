Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6076CC433E7
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 22:00:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 371CE2064B
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 22:00:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pEBr7qmk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730366AbgHaWA0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 18:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbgHaWAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 18:00:25 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37401C061573;
        Mon, 31 Aug 2020 15:00:24 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id n3so583127pjq.1;
        Mon, 31 Aug 2020 15:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4QM6ER7fhRyUxLGEs/oH4GIL5g68LR8X3XorfLvrMNg=;
        b=pEBr7qmkWMEFNmr8jduIx6CpXC1hVj3KRqCwkpGMZD1MstcGG/e+KLyl1ZHpUCwCv/
         lSnDSmvqcIiElkqY6n7AEj9ZtIVNyVJ2ozWnvfYDe/WooqwimO1mpm5LPvEnMAyxGHxj
         VPa21s8o6RYnR6UnwPGdtLR448yAQWDo+oOEPTJjnSADV6P/w5bvVucC8SjdzVN4IH+D
         OkYrop3XJ0XN1n0Xj38KFXAga/BnMH//KzgRii33DipXj0izbVcKbAuO4vu5L1MPUd+y
         IJryP+83ggWz5RR15XffSl+C8z/oKGxKnwbdfHtMpcbhEpr2FiKz5zJUKMbV70EpM6kt
         kNMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4QM6ER7fhRyUxLGEs/oH4GIL5g68LR8X3XorfLvrMNg=;
        b=qj2xwO+oK/iNgqdmEe9Bwb9eC4zUN0LIi+yJgUHso389P7ke5yZeNmKg4l+eeTzXzP
         TKLtiPNFtg+/0fka5N3s85ZICulbCL8LYezPBRZErcWbj8aNWpcek25qBcbePp90fRqy
         Zn7TU0edEkzlM85xFzR1r20rvQF3yADKetEYNCJh9kBKtrJ7i+Dom1w+9T2JfODUTza6
         ypT3GSKM/jvpvMJaYNj3jucHNUB4/oil+o8PoSMsRjtvFJ+F9kBQmxpMhyMAIyJo25GK
         b6TsUqFgE4I078NYxJHm7OIz3YAHYhrP0t95H53inZZIoM5LJp86tq7e3jL413BUW9li
         E/SA==
X-Gm-Message-State: AOAM531FNA5ut6ItEp7AVbmaPAMrJfaZQin9dEWKhEGpYVHz23ZU8lxz
        nODD1S7Hg1KzbMTBPr+ojd7GmTw/tZ4=
X-Google-Smtp-Source: ABdhPJwo+l7Vpf4932990d+gbNKCOBwRQmjjT6uYT6voXh8qvezlpeS1gZEa9bjuM8Bk128x+PQeOA==
X-Received: by 2002:a17:90a:e78e:: with SMTP id iz14mr1188955pjb.233.1598911223267;
        Mon, 31 Aug 2020 15:00:23 -0700 (PDT)
Received: from [10.230.30.107] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id u14sm8687671pfm.103.2020.08.31.15.00.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2020 15:00:22 -0700 (PDT)
Subject: Re: [PATCH 1/1] ARM: dts: bcm2711: Enable ddr modes on emmc2
 controller
To:     Tobias Schramm <t.schramm@manjaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     devicetree@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org
References: <20200829231509.543901-1-t.schramm@manjaro.org>
 <20200829231509.543901-2-t.schramm@manjaro.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <7ff055aa-08c3-4b91-f710-a1f7777b1c5f@gmail.com>
Date:   Mon, 31 Aug 2020 15:00:20 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.1.1
MIME-Version: 1.0
In-Reply-To: <20200829231509.543901-2-t.schramm@manjaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/29/2020 4:15 PM, Tobias Schramm wrote:
> This patch enables ddr modes for eMMC and SD storage on emmc2,
> doubling transfer speed. Previously only single data rate modes were
> used, wasting half the available throughput.
> The bcm2711 supports both SD and eMMC storage using ddr modes. Testing
> show that pcb layout of the Raspberry Pi 4 can support them, too.
> 
> Signed-off-by: Tobias Schramm <t.schramm@manjaro.org>

This depends on Stefan's patch here:

https://lore.kernel.org/linux-arm-kernel/1598651234-29826-1-git-send-email-stefan.wahren@i2se.com/

I am fine with us taking the DTS patch, as long as they all land in 5.10 
at some point.

> ---
>   arch/arm/boot/dts/bcm2711-rpi-4-b.dts | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/bcm2711-rpi-4-b.dts b/arch/arm/boot/dts/bcm2711-rpi-4-b.dts
> index 222d7825e1ab..8b61e258e906 100644
> --- a/arch/arm/boot/dts/bcm2711-rpi-4-b.dts
> +++ b/arch/arm/boot/dts/bcm2711-rpi-4-b.dts
> @@ -191,6 +191,8 @@ &emmc2 {
>   	vqmmc-supply = <&sd_io_1v8_reg>;
>   	vmmc-supply = <&sd_vcc_reg>;
>   	broken-cd;
> +	mmc-ddr-3_3v;
> +	sd-uhs-ddr50;
>   	status = "okay";
>   };
>   
> 

-- 
Florian
