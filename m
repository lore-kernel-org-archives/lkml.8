Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC1CAC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 21:36:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0A512085B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 21:36:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U2sAFd8u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbgFQVgC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 17:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbgFQVgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 17:36:01 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7514C06174E;
        Wed, 17 Jun 2020 14:36:00 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id k1so1542269pls.2;
        Wed, 17 Jun 2020 14:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=byMpenmEXb5a4s4WAANKsP7CLHm8UjXMOFTysLJaeCQ=;
        b=U2sAFd8udhnyEe0FRgvauCJ3bAkQ8+OyWASvnhTwMaLGMlzEDa89g7bpUwoR3G8qU3
         JfvQkfAXmxetbQbwJpAWucSSf8KGFQ5K5/8cRjGE/y+oORL5+lKdXoDAVfgFYwxknha6
         NnjweLXlncqNH9Nb5wYJdB55dodqqFhowF/Y9qrrxNeexowfpZrc2vW8EKtXjEqMbbWU
         Uzl4j9tJJhem04+ZH3NitCK0nJcRNgQ4ejVmpAozAj7kmaQzIWz2lQQnbaE/gaSzF3iG
         ERbuBczyyc9KdRS6uX5iZMotg6O22mzDhU5+6e+tOqiGwi21OjP4l6IjXLlkH/bz0CGz
         Pd6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=byMpenmEXb5a4s4WAANKsP7CLHm8UjXMOFTysLJaeCQ=;
        b=RN5xY/8Ox0tRK994MbUi2a/d//AtPvZ2Alj8kH6IgYaMiFeagZzTEYbuarNKfI6aRz
         PbwYEpEa45dTgI/hpYMycDHFUaMSYKxqPl+Od0ERuv0ZEUgIR9aMo1jG4CMz5pnCrSO1
         3fmmUF62xHeJPpaej+3xsPzn65GP2w+sMq0yrJNGyT/yQaDJgRTidDN+t+QDhqaFqL2V
         aW0KzST1YeZKv0tN1yJXj2K+DLtHWWN2XTw+zP3kzMVUUUNrvWAQaszmEnrQd1+cvdkU
         sWFRTkuNRou+FSgSArZ2O4syhDwFNu8Ri3IU42kU4q8TyPh6DEAUHc37SNcPXiyFYd/b
         uShQ==
X-Gm-Message-State: AOAM530uH9TpO/lkZKKtA2ezU+dWtzxBnqS1YccwXQdAGBo3odUn0L4e
        Dx7OwUbgzA5esbEdSKImgUQ=
X-Google-Smtp-Source: ABdhPJycPAHh4Oq7/Vgn/6SEn6o9Wwjc8tdJk9NSQcvuEwtVl1vUo4Fjs5jWBqHQ7jPSzJnrvHBAqg==
X-Received: by 2002:a17:90a:778c:: with SMTP id v12mr1037637pjk.34.1592429760254;
        Wed, 17 Jun 2020 14:36:00 -0700 (PDT)
Received: from [10.230.188.43] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id n4sm774980pfq.9.2020.06.17.14.35.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2020 14:35:59 -0700 (PDT)
Subject: Re: [PATCH 1/2] dt-bindings: phy: add bcm63xx-usbh bindings
To:     =?UTF-8?Q?=c3=81lvaro_Fern=c3=a1ndez_Rojas?= <noltari@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     Jonas Gorski <jonas.gorski@gmail.com>, kishon@ti.com,
        vkoul@kernel.org, robh+dt@kernel.org,
        bcm-kernel-feedback-list@broadcom.com, p.zabel@pengutronix.de,
        krzk@kernel.org, gregkh@linuxfoundation.org, alcooperx@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20200616083408.3426435-1-noltari@gmail.com>
 <20200616083408.3426435-2-noltari@gmail.com>
 <2cc00ff1-f411-1c2d-d2ce-4cc0bfc2ccb5@gmail.com>
 <F5FC8442-319A-48A7-BEEA-92C0EADE6BDA@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <d289fb29-3491-080c-0615-b956e5c37f3e@gmail.com>
Date:   Wed, 17 Jun 2020 14:35:57 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <F5FC8442-319A-48A7-BEEA-92C0EADE6BDA@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/17/2020 4:16 AM, Álvaro Fernández Rojas wrote:
>> On 6328, the same register space allows the controlling of the USB PHY
>> in either host or device mode, so I believe you would need to add a
>> #phy-cells = 1 in order to distinguish the consumer (host versus device)
>> if we get to the point where drivers/usb/gadget/udc/bcm63xx_udc.c
>> becomes DT aware.
> 
> I’ve just realized that I have implemented this wrong in v3, because I implemented the SwapControl USB_DEVICE_SEL value, and you meant the UTMIControl1 USB_DEVICE_MODE_SEL value.

Right that is the register I was referring to.

> So I have a couple of questions about this, because I haven’t got any bcm63xx with usb device configuration to test:
> - Is USB_DEVICE_SEL also needed in SwapControl or do we only need USB_DEVICE_MODE_SEL in UTMIControl1?

It looks like it depends on the device, for 6318 and 63268, there is
USB_DEVICE_MODE_SEL defined, but not for 6328, 6362 or 6368 for
instance. Note that USB_DEVICE_MODE_SEL is relevant for port 2 only for
6318 and 63268 whereas the UTMI_CONTROL1 appears to be for any port.

> - Are the rest of the host values needed when configured in device mode? Should I only set the device values when in device mode?

They could probably be configured although I am not sure they sure they
will be used at all, it's been a while since I looked at this (over 8
years).

I don't know if you have any board with USB device mode capability, if
you do not please email privately and I will ship you one.
-- 
Florian
