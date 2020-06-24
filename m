Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DBE4C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 08:42:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06FAA2088E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 08:42:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="sjUMD2Y4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728843AbgFXImK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 04:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727890AbgFXImJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 04:42:09 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB779C061573
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 01:42:08 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id n23so1654556ljh.7
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 01:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=U9Y3mMEn+doGyQindvusnFiRFTGJSlJ41lw2KppHaQM=;
        b=sjUMD2Y4BnGJF9F5G/QzwTYguxPh0uyIGcELYBrvEg3KUruDRJLHGshCaZ/WC1U0Xf
         6ZbIs0gXaZpcNTTl47QbM9QxKQbSnPtUUVu6B3J9zbU4+LBlnNGCOrM56mtRsGCm0xex
         hU0s8+EZKtDxlKiceB+1mfH8jkOC5/T8CZHrwTLZke8h4ThenspGeknXuELkpvBas1fZ
         HcLL2QiBuP+mDOimuoIpvBx5rP1l+z4vBcpzDiOU8dd9CjFC5/Q27fw8tplTEawxB55N
         QNTdDajj0KfgqOjF4MzY2XJYLV2dWj8D5gr6j/WhRWgq2jmhudA7tJi64K/aTlLCOi4S
         9x/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=U9Y3mMEn+doGyQindvusnFiRFTGJSlJ41lw2KppHaQM=;
        b=gLH+U5aCXt6m0RjfJV1vzOu/oEnAczstprRuqy4xCzNbl9ixRtPC3C/RYtoRYBVhTt
         NCcsDKEBaWVrxnbNaZtLbwov5ImF4DwPUlskwSZgNIP7Xpn++xKOvi/KZMw3sLyvsTqd
         eousRf1kpBb6LF1/NXdiUOoQnN4M6dSR4nfBukhHk1Ras3QDgdCMtpCLx0cMm1Cok78d
         biaiB0phr+/nTAJ+XRb99g3h72I3nLbIlI+M9A6YVjIcNdaEC5ug/VuGMKU842oJrQIZ
         /tRiV9wIrzBwnXtbiWAJQmnw9PNxfj53H6cqKl4tlcKWQs4/mEnG2UinGQbYup/wGvwq
         Hnqw==
X-Gm-Message-State: AOAM531QmK8ZOk9diJrjY3d/nc2oPNMGsPWE7hCRSSPwa7JFES0uxzf1
        Sqt0DFHaS+9zVpYtkmamHKGchBRm6uzJVg==
X-Google-Smtp-Source: ABdhPJxWz2zHxxYyeUTsDV4G12M7iX0sqxgtBhVO4cTO9Xf4zISUyecpI4UYqC/F6so3Uk/Lqvf9Nw==
X-Received: by 2002:a05:651c:290:: with SMTP id b16mr13625069ljo.149.1592988127361;
        Wed, 24 Jun 2020 01:42:07 -0700 (PDT)
Received: from ?IPv6:2a00:1fa0:4295:f835:1ba:7b55:ca16:3bac? ([2a00:1fa0:4295:f835:1ba:7b55:ca16:3bac])
        by smtp.gmail.com with ESMTPSA id j19sm1173718ljg.28.2020.06.24.01.42.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2020 01:42:06 -0700 (PDT)
Subject: Re: [PATCH v2 7/7 RESEND] dt-bindings: interrupt-controller: Fix
 typos in loongson,liointc.yaml
To:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     Huacai Chen <chenhc@lemote.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>
References: <1592981136-3572-1-git-send-email-yangtiezhu@loongson.cn>
 <1592981136-3572-8-git-send-email-yangtiezhu@loongson.cn>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <0b20ab00-2809-1770-c7c0-114260b2a571@cogentembedded.com>
Date:   Wed, 24 Jun 2020 11:42:05 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <1592981136-3572-8-git-send-email-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 24.06.2020 9:45, Tiezhu Yang wrote:

> Fix the following two typos in loongson,liointc.yaml:
> fron -> from
> it's -> its
> 
> Fixes: b6280c8bb6f5 ("dt-bindings: interrupt-controller: Add Loongson LIOINTC")
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>   .../devicetree/bindings/interrupt-controller/loongson,liointc.yaml    | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/loongson,liointc.yaml b/Documentation/devicetree/bindings/interrupt-controller/loongson,liointc.yaml
> index b1db21e..13908ca 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/loongson,liointc.yaml
> +++ b/Documentation/devicetree/bindings/interrupt-controller/loongson,liointc.yaml
> @@ -51,8 +51,8 @@ properties:
>       description: |
>         This property points how the children interrupts will be mapped into CPU
>         interrupt lines. Each cell refers to a parent interrupt line from 0 to 3
> -      and each bit in the cell refers to a children interrupt fron 0 to 31.
> -      If a CPU interrupt line didn't connected with liointc, then keep it's
> +      and each bit in the cell refers to a children interrupt from 0 to 31.
> +      If a CPU interrupt line didn't connected with liointc, then keep its

    "Connect", while you're at it?

>         cell with zero.
>       $ref: /schemas/types.yaml#/definitions/uint32-array
>       minItems: 4

MBR, Sergei
