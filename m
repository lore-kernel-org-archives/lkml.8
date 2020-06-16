Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69889C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 18:21:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4900B208D5
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 18:21:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k1C+nc35"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729090AbgFPSVH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 14:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbgFPSVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 14:21:07 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05483C061573;
        Tue, 16 Jun 2020 11:21:07 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id e18so9577277pgn.7;
        Tue, 16 Jun 2020 11:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=g7lLlvEoTvgmLjDaNGJohAzTK6L4QW2JMDxy1R2U07I=;
        b=k1C+nc35mNiDzLc/LR34YvTox6ks1agGzn3W6Mj5a+xMvsZRhmcQVBKTdMXEwY9isp
         Oq7x2OsRGhqzGg3aCF+C6fKTs+1TI8y9CRFzM9KECTe2gf/+GJnh2VS4D7z1qxqgpnE4
         0NgwtMTMmNI/+LaX7OKJkBdV2QQlobyMvxcleQoPivBhGIvxGAt6/FaU2GWUPQou2yHn
         iGmDg7/cvoq893LJDlgdy/t60Gu3Bb4t7xNW6uKi3ODg2ArtvjIr33HmKZA7rQohZmpd
         P5rdPOB8ooD52gH24Z8Tl8O/PE7GNjdTQslApgkPPltBDVNgqkmyGAgkLn84IbbvI6Qr
         Y/3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=g7lLlvEoTvgmLjDaNGJohAzTK6L4QW2JMDxy1R2U07I=;
        b=ej4f0KTLsPVHzkAztKEI8TknGTRjmm3WodRMIyhuD2jYU18GZTDvKyWr3b+3eWHy5Y
         Huw/hK4XXK781dYSdNwQqov5n9qbFR9/8pawUV3TBeGJBtjoqPPucPozPkpEgrzRQ+/4
         Ci88RZIUqD7ZqR8X2vk6wXIXLEXjwJYjc932Yw5lkpsBTcmMSb723dYU5g9ZWLKRWOwA
         FtdaoX5Lrxs7JyVqVsaQu4poFFaj8VP/5g/7HzUgDLxbgAsO/kvJJVvQXHLAoBjNvDxB
         WkKVxmvY6IovSMP/QtGcaH0fivTrxDY3ZyCwcLPuMz9zVyuNPcyDeqQAX30uLbawdQS+
         Yz5w==
X-Gm-Message-State: AOAM533XhCPRqQFPMDGQCFy6gS8VqWLCuKFStBTGSjJ1WOSr30KtRH5e
        blKO4hcEQ1Uw2tcz3ufMeVQ=
X-Google-Smtp-Source: ABdhPJwmv2dcMN86tGUhvu18FNgfqKb/uMjls5HdgtO6rxzlCQDlrniJZ7XxJTydspog+2ArpjAXkg==
X-Received: by 2002:a62:4e91:: with SMTP id c139mr3347199pfb.18.1592331666423;
        Tue, 16 Jun 2020 11:21:06 -0700 (PDT)
Received: from [10.230.188.43] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id c9sm18385998pfr.72.2020.06.16.11.21.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jun 2020 11:21:05 -0700 (PDT)
Subject: Re: [PATCH 1/2] dt-bindings: phy: add bcm63xx-usbh bindings
To:     =?UTF-8?Q?=c3=81lvaro_Fern=c3=a1ndez_Rojas?= <noltari@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     simon@fire.lp0.eu, Jonas Gorski <jonas.gorski@gmail.com>,
        kishon@ti.com, vkoul@kernel.org, robh+dt@kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Philipp Zabel <p.zabel@pengutronix.de>, krzk@kernel.org,
        gregkh@linuxfoundation.org, alcooperx@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20200616083408.3426435-1-noltari@gmail.com>
 <20200616083408.3426435-2-noltari@gmail.com>
 <2cc00ff1-f411-1c2d-d2ce-4cc0bfc2ccb5@gmail.com>
 <7E21D795-8D20-4EB1-9758-D2B5BD389F1F@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <e011e0f4-d503-e9fe-8615-69678dd9bdca@gmail.com>
Date:   Tue, 16 Jun 2020 11:21:03 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <7E21D795-8D20-4EB1-9758-D2B5BD389F1F@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/16/2020 11:10 AM, Álvaro Fernández Rojas wrote:
> Hello Florian,
> 
>> El 16 jun 2020, a las 19:17, Florian Fainelli <f.fainelli@gmail.com> escribió:
>>
>>
>>
>> On 6/16/2020 1:34 AM, Álvaro Fernández Rojas wrote:
>>> Document BCM63xx USBH PHY bindings.
>>>
>>> Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
>>> ---
>>> .../bindings/phy/brcm,bcm63xx-usbh-phy.yaml   | 72 +++++++++++++++++++
>>> 1 file changed, 72 insertions(+)
>>> create mode 100644 Documentation/devicetree/bindings/phy/brcm,bcm63xx-usbh-phy.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/phy/brcm,bcm63xx-usbh-phy.yaml b/Documentation/devicetree/bindings/phy/brcm,bcm63xx-usbh-phy.yaml
>>> new file mode 100644
>>> index 000000000000..3e7c97799b91
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/phy/brcm,bcm63xx-usbh-phy.yaml
>>> @@ -0,0 +1,72 @@
>>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: "http://devicetree.org/schemas/phy/brcm,bcm63xx-usbh-phy.yaml#"
>>> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
>>> +
>>> +title: BCM63xx USBH PHY
>>> +
>>> +maintainers:
>>> +  - Álvaro Fernández Rojas <noltari@gmail.com>
>>> +
>>> +properties:
>>> +  compatible:
>>> +    enum:
>>> +      - brcm,bcm6318-usbh-phy
>>> +      - brcm,bcm6328-usbh-phy
>>> +      - brcm,bcm6358-usbh-phy
>>> +      - brcm,bcm6362-usbh-phy
>>> +      - brcm,bcm6368-usbh-phy
>>> +      - brcm,bcm63268-usbh-phy
>>> +
>>> +  reg:
>>> +    maxItems: 1
>>> +
>>> +  clocks:
>>> +    maxItems: 2
>>> +
>>> +  clock-names:
>>> +    items:
>>> +      - const: usbh
>>> +      - const: usb_ref
>>> +
>>> +  resets:
>>> +    maxItems: 1
>>> +
>>> +  "#phy-cells":
>>> +    const: 0
>>
>> On 6328, the same register space allows the controlling of the USB PHY
>> in either host or device mode, so I believe you would need to add a
>> #phy-cells = 1 in order to distinguish the consumer (host versus device)
>> if we get to the point where drivers/usb/gadget/udc/bcm63xx_udc.c
>> becomes DT aware.
> 
> I’m not really sure about how I should do this because there’s no definition for device phy mode in dt-bindings/phy/phy.h:
> https://github.com/torvalds/linux/blob/master/include/dt-bindings/phy/phy.h#L13
> 
> Which value should I use for device mode and which one for host?

0 for the host, which would be equivalent to not specifying the
property, and 1 for the device.

> Should I support both modes at the same time or are they exclusive?

This is an OTG controller so you need to be able to dynamically
re-configure the PHY to be in either device or host mode (see comment
about bcm63xx_select_phy_mode), but there would not be both at the same
time.
-- 
Florian
