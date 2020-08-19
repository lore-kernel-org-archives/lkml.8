Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0FD2C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 20:49:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6938821734
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 20:49:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pdzwz1e2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbgHSUtv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 16:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbgHSUtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 16:49:50 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FC22C061757;
        Wed, 19 Aug 2020 13:49:50 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id l23so19223130edv.11;
        Wed, 19 Aug 2020 13:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=K2zgoWJMVJSa/TNQOYcMLprt+kXYKK8dtG0LjjuZCoc=;
        b=Pdzwz1e2rv9Embus7JEws1HnUGspCVHG2cS3m11g1KQ7xcV/CBtajPnm8coQB3M8Cf
         lFzjr1HHim02CnT2r0i1136TYAY7qOgXMUoVu4Pc8R7FE/Kg+b0o4fGL/TcyXNkL4ZKI
         69vu+99/3MGyT/t8D/O7kCf/gkQzpOtK1YxyZTB/G4+JKG2+qnNed+69aeo9m9SgqZHe
         fJ5TPAymerYIAWI8wnmTRVB8A0fM4QqW+IWb9vmj329aImTdA0NqNMSMXeFI8ThY40Gi
         YHJevJr2UTHfRtQi+2b1CyKgMUVxa14HV8YipEcfar2H46JMRg+MPgRoscW0wPQph/kf
         LFPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=K2zgoWJMVJSa/TNQOYcMLprt+kXYKK8dtG0LjjuZCoc=;
        b=a19VQ6oo4aVwOVT7nv4u/V7V4b1eHywCzviG/9WT9IQNA02776oHCvp0ihAfzuToZ8
         92Yr1FUaiST//ocqUGslhOldbt2WErL3VTsGOD3Z5jsDsD+nnavA34a0QRfsfSPev7Rh
         2GNCM1vAESEqYG1jEAvqsN6aMiFjbal+sJD4UMAlJ23KXcutB7WNLE8XiU0gS84JgILi
         kb751npnUAPE9LVyWVOsEDmncKKewTJCXqGMu75fEL3O0uXYZz+5k9OwGgAb95eOVelW
         2P64mgwPG9oVBLHLilEopUzXl42UQFbNevupn992CVoAVxzaV8qyytYqj8rKrBtZBxyb
         zAIw==
X-Gm-Message-State: AOAM532oO2rAZCCoH81y4AtIQ+vvVfvbq416zZ6WxRagPvrNQJvciLll
        Zm3Mug7UeIBwx2EVw9K+qSN2kO7Anuc=
X-Google-Smtp-Source: ABdhPJyZmpCyVYq9115eormBuLkTdxhAUGIEG4kLQKfecG2vG8kdFo0MwgmrSWxjpY6tMR+Ul2uyMg==
X-Received: by 2002:aa7:ccd5:: with SMTP id y21mr25745238edt.91.1597870189025;
        Wed, 19 Aug 2020 13:49:49 -0700 (PDT)
Received: from [10.67.50.75] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id l7sm18338674eds.47.2020.08.19.13.49.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Aug 2020 13:49:48 -0700 (PDT)
Subject: Re: [PATCH] ARM: dts: BCM5301X: Fix pin controller node
To:     Christian Lamparter <chunkeey@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        "maintainer:BROADCOM BCM5301X ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20200819042308.19043-1-f.fainelli@gmail.com>
 <7501cb2f-ea5a-8339-40a0-6706fea32a06@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 G10n8gCguORqNGMsVRxrlLs7/himep7MrCc=
Message-ID: <62f89d06-e6ef-9476-1797-bec153d8e6db@gmail.com>
Date:   Wed, 19 Aug 2020 13:49:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <7501cb2f-ea5a-8339-40a0-6706fea32a06@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/19/20 1:48 PM, Christian Lamparter wrote:
> On 2020-08-19 06:23, Florian Fainelli wrote:
>> The pin controller resources start at 0xc0 from the CRU base which is at
>> 0x100 from th DMU base, for a final address of 0x1800_c1c0, whereas we
>> are currently off by 0x100. The resource size of the CRU is also
>> incorrect and should end at 0x248 bytes from 0x100 which is the start
>> address. Finally, the compatibility strings defined for the
>> pin-controller node should reflect the SoC being used.
>>
>> Fixes: 9994241ac97c ("ARM: dts: BCM5301X: Describe Northstar pins mux
>> controller")
>> Reported-by: Christian Lamparter <chunkeey@gmail.com>
>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>> ---
>> Christian, can you test this as a preliminary patch for your Cisco
>> Meraki MR32 series? Thanks!
> 
> Hm, it looks like this is more complicated than this. We should have
> looked at pinctrl-ns.c's ns_pinctrl_probe() [0] before calling it.
> 
> |    ns_pinctrl->regmap = syscon_node_to_regmap(of_get_parent(np));
> |    if (IS_ERR(ns_pinctrl->regmap)) {
> |        int err = PTR_ERR(ns_pinctrl->regmap);
> |
> |        dev_err(dev, "Failed to map pinctrl regs: %d\n", err);
> |
> |        return err;
> |    }
> |
> |    if (of_property_read_u32(np, "offset", &ns_pinctrl->offset)) {
> |        dev_err(dev, "Failed to get register offset\n");
> |        return -ENOENT;
> |    }
> 
> So, the ns_pinctrl_probe() takes the address of the parent node (cru)
> and then looks for a "offset" property to add to this (which is missing
> in the bcm5301x.dtsi [1]).
> 
> Thing is, for this to work, the parent-node should be a "simple-mfd" (so
> a regmap is created for the reg), right? This would also mean that the
> "reg" property in the pin-controller node is just cosmetic.
> 
> I guess the reason why this sort-of-works for me is because I'm using
> this MR32 with OpenWrt (Rafał Miłecki is probably using it too ;) ).
> 
> (Note: We should not forget to update the binding-documentation as well!)
> 
> BTW: I'll reply my findings for the i2c issue with the MR32 in the other
> mail.

Rafal, has this driver ever worked to begin with? None of this should be
necessary, we should just be using a simple platform device resource here.
-- 
Florian
