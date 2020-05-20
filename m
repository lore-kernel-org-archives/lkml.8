Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1450C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 09:30:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCAFB207D3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 09:30:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vjazAm37"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbgETJah (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 05:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726896AbgETJaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 05:30:35 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69C25C061A0F
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 02:30:35 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id n18so2121742wmj.5
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 02:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=wc6stLd7fv3SlBSmBsX1XmQPwtI3AmwZLYlnJzwyzvw=;
        b=vjazAm37j6JS0ESDLULP7usxUJmcyJXpI1rYanJaiBMEXC47/00EoRJqXccf2I/aHF
         52deqipmXhdXb5EVkrQLE6gsz2A75scUhggoIq6VvVuYAA7SeSN8FKnu783vCaJD+lGl
         oJbe9GifOa2TT59QiErtSRIQDSyNwLbHL8NjtYgFCMfCdYZ2BbiXPnihGjZel5DGTJ/M
         DZSn/NAOoba12f60Dh40Ra2FYgfuafQB0ij5r+w2xW+9dGHHUENhQYIPsJOjfGgi5rzR
         QcJ5mOS1YHLQIjdCS8QMEujcXfs863rcj24FHVj+SWqcI54f2AWW3KDQDQCkFFqDj1gC
         ewqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=wc6stLd7fv3SlBSmBsX1XmQPwtI3AmwZLYlnJzwyzvw=;
        b=Yp+WnKrHstGZ+t36Me0j6nU/+wsaPtTL2AhLZ9//9LaMwWCvYrCuLNKMLQ1zqIC8I8
         Sibre+BV8SJV6Gd6DrbtowlQd6fIqkTau/vs7eV+NQkjJjQgrRvSO+EVgnPbXd2dMSvF
         GPIniY7r6Iyyi8urCgys8f6yDsh/s8I1e+LNyKx8tnEwd9soe9nDCQ4lnR444OB/3rYl
         BQgyjB8aPEunzP/RJTb+URB/pT5eXlh7VeWCCX0AVe+X5uQIjydbKaJYPHPXoWIUlGKf
         z0EeomA/atVtYCrdQXyxVtQMSXdG9q60siQwDiuIQUDiMyDhyAs3+B5cwZ0BJB9At3hC
         aJ0A==
X-Gm-Message-State: AOAM532Y3EEXvkjc7eD8XrTY6Z3gMwEhTptlG6fyIar/r6a1QRRsatyU
        dcDUuG9IXs18fyeYzJcGdd8I8w==
X-Google-Smtp-Source: ABdhPJymBBbiK71tQTEAqr5QIR08/MCj+YzDXrNmdjU7RtZMKMWFmlQRCDMRfe/P26o83I25huuHag==
X-Received: by 2002:a1c:305:: with SMTP id 5mr3772868wmd.60.1589967034154;
        Wed, 20 May 2020 02:30:34 -0700 (PDT)
Received: from dell ([95.149.164.102])
        by smtp.gmail.com with ESMTPSA id x5sm2370385wro.12.2020.05.20.02.30.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 02:30:33 -0700 (PDT)
Date:   Wed, 20 May 2020 10:30:31 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Robert Jones <rjones@gateworks.com>
Subject: Re: [PATCH v11 1/3] dt-bindings: mfd: Add Gateworks System
 Controller bindings
Message-ID: <20200520093031.GF271301@dell>
References: <1589565428-28886-1-git-send-email-tharvey@gateworks.com>
 <1589565428-28886-2-git-send-email-tharvey@gateworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1589565428-28886-2-git-send-email-tharvey@gateworks.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 May 2020, Tim Harvey wrote:

> This patch adds documentation of device-tree bindings for the
> Gateworks System Controller (GSC).
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
> v11:
>  - no change
> 
> v10:
>  - no change
> 
> v9:
>  - added Reviewed-by: Rob Herring <robh@kernel.org>
>  - remove allOf: see https://lkml.org/lkml/2020/4/15/1930
>  - encorporate Lee's review comments for item descriptions
> 
> v8:
>  - add register to fan-controller node name
> 
> v7:
>  - change divider from mili-ohms to ohms
>  - add constraints for voltage divider and offset
>  - remove unnecessary ref for offset
>  - renamed fan to fan-controller and changed base prop to reg
> 
> v6:
>  - fix typo
>  - drop invalid description from #interrupt-cells property
>  - fix adc pattern property
>  - add unit suffix
>  - replace hwmon/adc with adc/channel
>  - changed adc type to mode and enum int
>  - add unit suffix and drop ref for voltage-divider
>  - moved fan to its own subnode with base register
> 
> v5:
>  - resolve dt_binding_check issues
> 
> v4:
>  - move to using pwm<n>_auto_point<m>_{pwm,temp} for FAN PWM
>  - remove unncessary resolution/scaling properties for ADCs
>  - update to yaml
>  - remove watchdog
> 
> v3:
>  - replaced _ with -
>  - remove input bindings
>  - added full description of hwmon
>  - fix unit address of hwmon child nodes
> ---
>  .../devicetree/bindings/mfd/gateworks-gsc.yaml     | 196 +++++++++++++++++++++
>  1 file changed, 196 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/gateworks-gsc.yaml

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
