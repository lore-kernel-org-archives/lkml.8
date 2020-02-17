Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9553AC35242
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 07:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C652206D5
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 07:39:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="xSIYa2za"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbgBQHjC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 02:39:02 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40899 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726683AbgBQHjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 02:39:01 -0500
Received: by mail-wr1-f67.google.com with SMTP id t3so18335913wru.7
        for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2020 23:38:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=Ra+M29CjHPnhIpuNAQgZQpc3ckx3Pxcs/DfQWA9zI+8=;
        b=xSIYa2za/Qrh1kzrTrcFaipMEucxZqWSY1/sGPKm7xetj4GzRFRHUlgd8Pxv7F7Amp
         KVvw7M8fgQQK/Tz4HDQwlT2Kp9qz4Phw/SIyj0xXHUpSlF0azECO0qc1CRYOuhyt/Ueq
         WMPzRKD3GSXgHqMlBbR8s3D8oIw/zCmV/f62nKfE3CKXSjDjR0IEHmMfmPxbkmrpZRCu
         TfnSiEuIvqx/UKMzfhTm8kr6ev6jphuZlw6l0dkS2ouHS3uZ6dLgVgA5uZvOaiYNfTX6
         7Naf2BDDJRtpuhJInlOKV9mO9uhL0+kTu+nQfF+TRLnXk75rqNEvH3L+ZI0mJwlNQ4xE
         Esmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=Ra+M29CjHPnhIpuNAQgZQpc3ckx3Pxcs/DfQWA9zI+8=;
        b=Z7uWrbQklJAvYnLRcHiMAlwJF5I7Mhzq7LKdq2j4R8BtHuQ0uSADpnNJaEIlBXJWpY
         MgTx8JBJ6GEZ4ZcR8As33omC4kZ2xYn31I0LNjF/pkND+7HM1SUHepkTlWLimyxpzWz2
         407pJk6TFNLit3UrwJEuaSjH9wHYY6f3dhy4ulV+qV67sJGtU6y6DN3ZimPV3k0889A8
         8r12XFHq1kHIGieqEDgqFHx1QNtZEsxjZJ8/9E0Iq8cogB6wn1GoRCB3wFRuoTZBEgBi
         uwcLP015ik0NpA+8kPK4itwqLEHhyUM6bu00nEDtzkae01xTGFw0mMr4fyTEGzEnzD1F
         FoOQ==
X-Gm-Message-State: APjAAAW/0HpytPlpIDOMli/+BcV1SdGHyxuUaZ1DIvOCbho0o0gh+lun
        dLg5Nheo9Bvf+ZKFPU2G/k9Okg==
X-Google-Smtp-Source: APXvYqx9fOOdunfmR6iWLBjPSh9B++/NSNDOBPnAw9CgNVgoSc4uWoD7y74CF/YZ2CXXmZLxUHsT9g==
X-Received: by 2002:a5d:5273:: with SMTP id l19mr21442762wrc.175.1581925138814;
        Sun, 16 Feb 2020 23:38:58 -0800 (PST)
Received: from localhost (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.gmail.com with ESMTPSA id c15sm19842783wrt.1.2020.02.16.23.38.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2020 23:38:58 -0800 (PST)
References: <20200216202101.2810-1-linux.amoon@gmail.com>
User-agent: mu4e 1.3.3; emacs 26.3
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Anand Moon <linux.amoon@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: amlogic: odroid-n2: set usb-pwr-en regulator always on
In-reply-to: <20200216202101.2810-1-linux.amoon@gmail.com>
Date:   Mon, 17 Feb 2020 08:38:57 +0100
Message-ID: <1jpnedzmr2.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun 16 Feb 2020 at 21:21, Anand Moon <linux.amoon@gmail.com> wrote:

> usb-pwr-en regulator is getting disable after booting, setting
> regulator-alway-on help enable the regulator after booting.

This explains what your patch does, not why it needs to be done.
Why does this regulator need be on at all time ? What device needs it
and cannot claim it properly ?

>
> [   31.766097] USB_PWR_EN: disabling
>
> Fixes: c35f6dc5c377 (arm64: dts: meson: Add minimal support for Odroid-N2)
> Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Cc: Jerome Brunet <jbrunet@baylibre.com>
> Cc: Neil Armstrong <narmstrong@baylibre.com>
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
> Patch generated on top of my earier patch.
> [0] https://patchwork.kernel.org/patch/11384531/
> [1] https://patchwork.kernel.org/patch/11384533/
>
> Before
> [root@alarm ~]# cat /sys/kernel/debug/regulator/regulator_summary | grep USB
>        USB_PWR_EN                 0    1      0 unknown  5000mV     0mA  5000mV  5000mV
> After
> [root@alarm ~]# cat /sys/kernel/debug/regulator/regulator_summary | grep USB
>        USB_PWR_EN                 1    1      0 unknown  5000mV     0mA  5000mV  5000mV
> ---
>  arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
> index 23eddff85fe5..938a9e15adfc 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
> @@ -177,6 +177,7 @@ usb_pwr_en: regulator-usb_pwr_en {
>  		regulator-min-microvolt = <5000000>;
>  		regulator-max-microvolt = <5000000>;
>  		vin-supply = <&vcc_5v>;
> +		regulator-always-on;
>  
>  		/* Connected to the microUSB port power enable */
>  		gpio = <&gpio GPIOH_6 GPIO_ACTIVE_HIGH>;

