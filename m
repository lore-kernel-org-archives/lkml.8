Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E66EC43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 13:41:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 245A521481
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 13:41:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="TXb+aYYh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729597AbgIGNky (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 09:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729445AbgIGNYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 09:24:54 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47EB1C061575
        for <linux-kernel@vger.kernel.org>; Mon,  7 Sep 2020 06:24:52 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id b79so14208824wmb.4
        for <linux-kernel@vger.kernel.org>; Mon, 07 Sep 2020 06:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IKRTwDbVsmXTAzdxN3hyZaGfI9/6c9DFQDx7XjqaewI=;
        b=TXb+aYYh59B/Qapt3XC50g3Rw9De+LPI+noQ/CYGXFkrilfLCXITqKddUtJRMJAmVt
         ct+uLViTc7SFC65mGLgKLwIkGsZhplGtAXDJbx2RdfwW/3HM6KcF1limKu+qUQqxRSMJ
         fPHUJ+q3X3Gmz6z6Ha00QwIExgpffTYLBJQLehC0ggmymMUsXbGpCxNdGFrwiZfn1jjc
         rvAHXxfw6Z1nhOZP1a08NRKXJKQfr/nEUsYd9Y8fuvRbEHm+rahjaHDcRDBonQNGL0GY
         xPEFiDWcDJ6QrVj7eoxL/XOA7UXnSp4fYIxD1EhWVjpdJphk7sK+Z36zCessZ0WHvO6g
         awpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=IKRTwDbVsmXTAzdxN3hyZaGfI9/6c9DFQDx7XjqaewI=;
        b=F989j5Gs3Qr1jFwFC5WBmkUHV4I+sMXlHUt49+QVv2Zu+lEGJ/jSFUwMBrD9xXvoTC
         8jb4rcP/rcD1aZHucuds5GIoFOsu2EaaErCOXe9D/kw1dRP86Q011JrkJ67KAb5RBc3C
         3DWX17gCMOae8XQKUzCfyG0i+CZiWh+90/BqLkFRd2BjqhIamTc5pSbvlAXRHQA7+TKu
         fMwK/fnQfPxM3rPsYrucxUh+74AJvrlz0BicSdnYVwy9bt+iH7+ypoI490oIlivFswCX
         asF5vU1M6RdkU0xn0PSGaqHQkJHfSDv4k81w3SXDHXlaNuW7TtZPqP0KhamUB1JFn3Yv
         ojTA==
X-Gm-Message-State: AOAM532zGvku7a6pC4Yu2DhyHrSxBsztqxGHovHubdQUk1tUEr/hoRDt
        SYaEdV9ut8VEt9JunE5fqw01MkhxuR+jyIxN
X-Google-Smtp-Source: ABdhPJxIvLhOQcVP0q0sW58n8NnEBJVdj/3cTCoVYv0gNJtoR3vlsfB8mDNHwWBx7PirCrvIPTbFow==
X-Received: by 2002:a7b:cf30:: with SMTP id m16mr20675293wmg.0.1599485089059;
        Mon, 07 Sep 2020 06:24:49 -0700 (PDT)
Received: from ?IPv6:2a01:e35:2ec0:82b0:5405:9623:e2f1:b2ac? ([2a01:e35:2ec0:82b0:5405:9623:e2f1:b2ac])
        by smtp.gmail.com with ESMTPSA id v3sm26967328wmh.6.2020.09.07.06.24.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Sep 2020 06:24:48 -0700 (PDT)
Subject: Re: [PATCH v2 2/3] dt-bindings: display: panel: add TDO tl070wsh30
 DSI panel bindings
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     thierry.reding@gmail.com, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20200907111027.21933-1-narmstrong@baylibre.com>
 <20200907111027.21933-3-narmstrong@baylibre.com>
 <20200907114552.GA526406@ravnborg.org>
From:   Neil Armstrong <narmstrong@baylibre.com>
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 BSwxi7g3Mu7u5kUByanqHyA=
Organization: Baylibre
Message-ID: <358ee0c3-fe1c-b9b6-9ed8-086f9d14afd9@baylibre.com>
Date:   Mon, 7 Sep 2020 15:24:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200907114552.GA526406@ravnborg.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 07/09/2020 13:45, Sam Ravnborg wrote:
> Hi Neil.
> 
> On Mon, Sep 07, 2020 at 01:10:26PM +0200, Neil Armstrong wrote:
>> This add the bindings for the 1024*600 tl070wsh30 DSI panel.
> 
> The binding looks like a panel-simple-dsi.yaml candidate.
> Only differen is enable-gpios versus reset-gpios

This is the only difference, the panel only has a reset signal and no
enable signal.

But I can add a reset-gpios to panel-simple-dsi.yaml, would it be ok ?

Neil

> 
> Could you check if we can use panel-simple-dsi-yaml.
> 
> 	Sam
> 
>>
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>> ---
>>  .../display/panel/tdo,tl070wsh30.yaml         | 58 +++++++++++++++++++
>>  1 file changed, 58 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/display/panel/tdo,tl070wsh30.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/display/panel/tdo,tl070wsh30.yaml b/Documentation/devicetree/bindings/display/panel/tdo,tl070wsh30.yaml
>> new file mode 100644
>> index 000000000000..20f4fdedfcb0
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/display/panel/tdo,tl070wsh30.yaml
>> @@ -0,0 +1,58 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
>> +# Copyright 2020 BayLibre, SAS
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/display/panel/tdo,tl070wsh30.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: TDO TL070WSH30 DSI panel
>> +
>> +maintainers:
>> +  - Neil Armstrong <narmstrong@baylibre.com>
>> +
>> +allOf:
>> +  - $ref: panel-common.yaml#
>> +
>> +properties:
>> +
>> +  compatible:
>> +    enum:
>> +      - tdo,tl070wsh30
>> +
>> +  reg:
>> +    maxItems: 1
>> +    description: DSI virtual channel
>> +
>> +  backlight: true
>> +  reset-gpios: true
>> +  port: true
>> +  power-supply: true
>> +
>> +additionalProperties: false
>> +
>> +required:
>> +  - compatible
>> +  - power-supply
>> +  - reset-gpios
>> +  - port
>> +  - reg
>> +
>> +examples:
>> +  - |
>> +    dsi {
>> +      #address-cells = <1>;
>> +      #size-cells = <0>;
>> +      panel@0 {
>> +        compatible = "tdo,tl070wsh30";
>> +        reg = <0>;
>> +        power-supply = <&vcc_lcd_reg>;
>> +        backlight = <&panel_backlight>;
>> +        reset-gpios = <&gpio_reset>;
>> +
>> +        port {
>> +          panel: endpoint {
>> +            remote-endpoint = <&mipi_dsi_out>;
>> +          };
>> +        };
>> +      };
>> +    };
>> -- 
>> 2.22.0

