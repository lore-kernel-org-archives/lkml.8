Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61F65C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 19:18:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27F96206D7
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 19:18:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="LJSwO27g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387993AbgBNTSM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 14:18:12 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33797 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387445AbgBNTSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 14:18:11 -0500
Received: by mail-wm1-f66.google.com with SMTP id s144so2709484wme.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 11:18:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=alfJFtHKJM/Uyz0gLDfPfrM5tSB9dNPsAfTb3Z88wWA=;
        b=LJSwO27g2GKc2awVc8VpB/xF0Y1TAHxkCB4lDDP5c+PfqZJYx6jpTfHi5IdhIIoBXj
         oDxysBiJQlYIG4LVMpFi32QleK68KJw7uIvfB7WADBx5So/a68VG/D9GkxVu7gLulsl7
         ky/fP98MM+iOVubCw6s0W7wXuPWuX5/TTMHCZaoSq2eULAY6A8ytrfdkM1dH7uaSJVw8
         NLHfP8Dl+U3cQuQKfUjuk5VfFRf0uL3ZbyyzIm9MfzpXLBFmqVLKUS+DJCrM7HCRupBi
         rN9uchVRidbMX9t+Z9QMvjJNZMGDAdwNZzpy54SjraFBCj31MjiFOVjQKOpfm4W+DchM
         K0pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=alfJFtHKJM/Uyz0gLDfPfrM5tSB9dNPsAfTb3Z88wWA=;
        b=NSf4WrJ3n2N9/5TIYOPy7LlvmbodxxjoHVZMlsAboReL7MCxqqBZ7yfV6jaVTMvOv2
         N+y1IIjXuavsG5dpZksMpMKi0hfXhT7CQFCToCL+pSMKpt+35fBcTDW/bh31pasmSFNe
         PNWUW3DTElqtUaKlo0DJEeRqWe5il2ylG6kUb1zyZJIVJWTCe6fZTEvLNYTp4yGKiG0n
         hTs5y/atz4jQuDoBYz7LeeYOyHYR3hzlB/uALI6f8CTg9ArhDe5ZNU9Aag4QqbCz49aP
         b5JJ96XVEgJZ6T6dP/pO7/dc+qVX1IRqDqQbeEeCto1hNvr+UW8Z9OS3FGr6fiPJVfYa
         UC2A==
X-Gm-Message-State: APjAAAU6sZ3IdJYFxkct6Nf2s4XsO+Bhn9OsPajSJqLdV6bzMKeYcU02
        juDuU82Sn67fnQR60rnmV1dgvA==
X-Google-Smtp-Source: APXvYqzyucT7GHVeUgi+5TIyBryVhiWXBuXBSMxGy6Ld77Vtz6UEawy6ZwoJS89byCYQ4btqYCjn0g==
X-Received: by 2002:a1c:3d46:: with SMTP id k67mr6370811wma.171.1581707890051;
        Fri, 14 Feb 2020 11:18:10 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id c9sm8045588wrq.44.2020.02.14.11.18.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Feb 2020 11:18:09 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Guillaume La Roque <glaroque@baylibre.com>,
        devicetree@vger.kernel.org
Cc:     linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: dts: meson-sm1-sei610: add missing interrupt-names
In-Reply-To: <42e82841-067d-245b-6196-183503da389b@baylibre.com>
References: <20200117133423.22602-1-glaroque@baylibre.com> <42e82841-067d-245b-6196-183503da389b@baylibre.com>
Date:   Fri, 14 Feb 2020 11:18:06 -0800
Message-ID: <7h8sl5asgh.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> On 17/01/2020 14:34, Guillaume La Roque wrote:
>> add missing "host-wakeup interrupt names
>> 
>> Fixes: 30388cc07572 ("arm64: dts: meson-sm1-sei610: add gpio bluetooth interrupt")
>> 
>> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
>> ---
>>  arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts | 1 +
>>  1 file changed, 1 insertion(+)
>> 
>> diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts b/arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts
>> index a8bb3fa9fec9..cb1b48f5b8b1 100644
>> --- a/arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts
>> +++ b/arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts
>> @@ -593,6 +593,7 @@
>>  		compatible = "brcm,bcm43438-bt";
>>  		interrupt-parent = <&gpio_intc>;
>>  		interrupts = <95 IRQ_TYPE_LEVEL_HIGH>;
>> +		interrupt-names = "host-wakeup";
>>  		shutdown-gpios = <&gpio GPIOX_17 GPIO_ACTIVE_HIGH>;
>>  		max-speed = <2000000>;
>>  		clocks = <&wifi32k>;
>> 
>
> Acked-by: Neil Armstrong <narmstrong@baylibre.com>

Queued as a fix for v5.6-rc1.

Thanks,

Kevin
