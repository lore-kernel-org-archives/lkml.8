Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0F95C33CAF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 14:47:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B23F62467A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 14:47:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gYR8w1cp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbgAVOrM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 09:47:12 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:34819 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbgAVOrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 09:47:11 -0500
Received: by mail-pj1-f67.google.com with SMTP id s7so3720960pjc.0;
        Wed, 22 Jan 2020 06:47:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ADCjuEPw44EETM4S2srrF1oIcsWNqgJFd7MKFaEnfRk=;
        b=gYR8w1cpyQX/IIWcvWuIFRNpl7JWcIhtMDjoFDUaa4ALknxMr+KQ7DT89oArVh6c16
         Fsb91OXQ+KCfkXYlZa5JaEYwR4QOJofxcK6Gy+6eFogGWy5svS0c5WA59xmNLeOeHe5f
         5+KYxEuBPay5d/ZLaqnxyaqNNjOmwjjF+0cZNhJX8blAYXMcJR3COexd452nZETb1bEX
         aYAYUTSqAQixgk2ZSdIqTDcNA0hhaLxOZebiT+rciVm31KqNWIZ0ZF8o6TgBcT+dsavK
         fZ/nin+3VqRir198VSZCw/Ys9UZvMTP8z7TqQGezSqeoVmCtGZjcYs4DMBchvkduRFyd
         3mbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ADCjuEPw44EETM4S2srrF1oIcsWNqgJFd7MKFaEnfRk=;
        b=nzmHdx2+Zu3BXAxUPmlp0p4+kIWCJg+35WJAwSlmuOHi3ZWJ2tzWk8HIw27PYLVZSd
         NLI0enrfBrZdoxof7Wfjf/O9mdWMzzKxennw0rGc287RsmjMOCh2OAmtByq5NPG5kK7v
         Vy8/3Uukz59u5o8lJd/E/MMPl5WqWhqYaf0D5uLUEWHHWnnnMoJO9DrFzjehNsETov4R
         vPPlzE0gZG8dXo7bez3aKN2moaWkbBF62U8IRold3yLUMIXlE/ORpCVtq/rPHliwoOpf
         BsLc4Qy4hptRePWQBqiqtqYHUPKl1AwtJMESTW+SJyrRSJWbZxa0X28tVJOuiYuC1fQd
         eXVw==
X-Gm-Message-State: APjAAAUSvTGEk2S1EgRjn9R17nBOGRiiD7x45LjGUaFyPE/5laJoKedU
        nMDY0hniTPro/4OmrzXlaVU=
X-Google-Smtp-Source: APXvYqxnhGFSwqsi3SgX4c9AnxtNRP2F88B4HNzAuqta4TdusNteHhtYs2grK58U/8NAVg+1EGE+2A==
X-Received: by 2002:a17:90a:d783:: with SMTP id z3mr3349203pju.3.1579704430653;
        Wed, 22 Jan 2020 06:47:10 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l2sm3653107pjt.31.2020.01.22.06.47.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jan 2020 06:47:09 -0800 (PST)
Subject: Re: [PATCH v4 2/2] hwmon: (adt7475) Added attenuator bypass support
To:     Logan Shaw <logan.shaw@alliedtelesis.co.nz>, jdelvare@suse.com,
        robh+dt@kernel.org
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Joshua.Scott@alliedtelesis.co.nz,
        Chris.Packham@alliedtelesis.co.nz
References: <20200120001703.9927-1-logan.shaw@alliedtelesis.co.nz>
 <20200120001703.9927-3-logan.shaw@alliedtelesis.co.nz>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <f6d272b9-9099-8407-0dd3-ea6cbcb1a39b@roeck-us.net>
Date:   Wed, 22 Jan 2020 06:47:07 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200120001703.9927-3-logan.shaw@alliedtelesis.co.nz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/19/20 4:17 PM, Logan Shaw wrote:
> Added a new file documenting the adt7475 devicetree and added the four
> new properties to it.
> 
> Signed-off-by: Logan Shaw <logan.shaw@alliedtelesis.co.nz>

Please fix the reported errors.

Guenter

> ---
> ---
>   .../devicetree/bindings/hwmon/adt7475.yaml    | 90 +++++++++++++++++++
>   1 file changed, 90 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/hwmon/adt7475.yaml
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/adt7475.yaml b/Documentation/devicetree/bindings/hwmon/adt7475.yaml
> new file mode 100644
> index 000000000000..f2427de9991e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/adt7475.yaml
> @@ -0,0 +1,90 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/adt7475.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ADT7475 hwmon sensor
> +
> +maintainers:
> +  - Jean Delvare <jdelvare@suse.com>
> +
> +description: |
> +  The ADT7473, ADT7475, ADT7476, and ADT7490 are thermal monitors and multiple
> +  PWN fan controllers.
> +
> +  They support monitoring and controlling up to four fans (the ADT7490 can only
> +  control up to three). They support reading a single on chip temperature
> +  sensor and two off chip temperature sensors (the ADT7490 additionally
> +  supports measuring up to three current external temperature sensors with
> +  series resistance cancellation (SRC)).
> +
> +  Datasheets:
> +  https://www.onsemi.com/pub/Collateral/ADT7473-D.PDF
> +  https://www.onsemi.com/pub/Collateral/ADT7475-D.PDF
> +  https://www.onsemi.com/pub/Collateral/ADT7476-D.PDF
> +  https://www.onsemi.com/pub/Collateral/ADT7490-D.PDF
> +
> +  Description taken from omsemiconductors specification sheets, with minor
> +  rephrasing.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,adt7473
> +      - adi,adt7475
> +      - adi,adt7476
> +      - adi,adt7490
> +
> +  reg:
> +    maxItems: 1
> +
> +  bypass-attenuator-in0:
> +    description: |
> +      Configures bypassing the individual voltage input
> +      attenuator, on in0. This is supported on the ADT7476 and ADT7490.
> +      If set to a non-zero integer the attenuator is bypassed, if set to
> +      zero the attenuator is not bypassed. If the property is absent then
> +      the config register is not modified.
> +    maxItems: 1
> +
> +  bypass-attenuator-in1:
> +    description: |
> +      Configures bypassing the individual voltage input
> +      attenuator, on in1. This is supported on the ADT7473, ADT7475,
> +      ADT7476 and ADT7490. If set to a non-zero integer the attenuator
> +      is bypassed, if set to zero the attenuator is not bypassed. If the
> +      property is absent then the config register is not modified.
> +    maxItems: 1
> +
> +  bypass-attenuator-in3:
> +    description: |
> +      Configures bypassing the individual voltage input
> +      attenuator, on in3. This is supported on the ADT7476 and ADT7490.
> +      If set to a non-zero integer the attenuator is bypassed, if set to
> +      zero the attenuator is not bypassed. If the property is absent then
> +      the config register is not modified.
> +    maxItems: 1
> +
> +  bypass-attenuator-in4:
> +    description: |
> +      Configures bypassing the individual voltage input
> +      attenuator, on in4. This is supported on the ADT7476 and ADT7490.
> +      If set to a non-zero integer the attenuator is bypassed, if set to
> +      zero the attenuator is not bypassed. If the property is absent then
> +      the config register is not modified.
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +examples:
> +  - |
> +    hwmon@2e {
> +      compatible = "adi,adt7476";
> +      reg = <0x2e>;
> +      bypass-attenuator-in0 = <1>;
> +      bypass-attenuator-in1 = <0>;
> +    };
> +...
> 

