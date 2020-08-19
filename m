Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16195C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 21:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0F4D207DE
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 21:14:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="e97zR/N5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbgHSVOa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 17:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726796AbgHSVO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 17:14:29 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EEEBC061383
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 14:14:29 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id x6so69432pgx.12
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 14:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6vl0Zr0QfPTPUxp3kmQVySN90fESLhsCVNDcmlPX5ao=;
        b=e97zR/N5o7Lz0AtqgugSva+F5lMAwSyEab6QESo7q2edZiuLdMYTgJcKlI35zU8Ytq
         AidBIz2PBjBlhHt6rTBvoAStn4NGEwn4iOia1EP0AooRUq6RxB+Ms1Dl6tGcqeSjOMVm
         p+5j4NMwCvNfiyWtmw+dXNpins8XGzW5Tz6lI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6vl0Zr0QfPTPUxp3kmQVySN90fESLhsCVNDcmlPX5ao=;
        b=j9CaRIktDPVPXu8EcMc4bzsvBXSyVlFM5OSyOZ8GGEUbc7kWpIoN6e1z5sZEsy1zKE
         ll1MiOWLfsMF7O7p2SFiITZGsWu5ISRuhbDha9HKm38GojxZ8n4LsNCXEKMcHqCNb4F2
         HdciXiqLsPzppDz3nba6zep66f4k+NlYb138s8MsZ0kQxsbyzTvArRXEc7lbJqVYfZLh
         2qy7hFIppgrx+p9TVRkSof5UmEGKwMWcEBZ5H1etJLXz29ZyM2I1tU4HCry4ogK8tErV
         uUfhMIwhKWy4TOYhEnEFVcsK8+HzAVau8+WPIqQrp7Wojx3+bNjbw+WTOlWO5ZxC4IcV
         2hqA==
X-Gm-Message-State: AOAM531JW6JxabjVK6+EV/0Rj/VYbSiZxaFSnxW8fA+CQ5fwuYm2hpvC
        X5V26nxHhJuC+lg9HyDVtzpMend29iqldvZyVE8Ks4+ntrvmlWfYA0lwpV59MtzVqILTb0hQ7XB
        PUXv2anVa9pkKGBi4n9kd2edBAn31ZGj9zfghyGVo75qRsix5MESahL4C5jrpr9q/81QBuEWz0d
        XOCok=
X-Google-Smtp-Source: ABdhPJyIsZqKw66CYKr8tbkC1zsYXVMa5TLygt5HGOeUvNsPQA9V/AoHAd7Q3oSpC7rY7R5GYSzPMQ==
X-Received: by 2002:a65:5849:: with SMTP id s9mr217988pgr.145.1597871667999;
        Wed, 19 Aug 2020 14:14:27 -0700 (PDT)
Received: from [10.136.8.253] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id e20sm3981728pjr.28.2020.08.19.14.14.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Aug 2020 14:14:27 -0700 (PDT)
Subject: Re: [PATCH] ARM: dts: BCM5301X: Fix pin controller node
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Christian Lamparter <chunkeey@gmail.com>,
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
 <62f89d06-e6ef-9476-1797-bec153d8e6db@gmail.com>
From:   Ray Jui <ray.jui@broadcom.com>
Message-ID: <a3680cea-e97f-c4a2-de21-a83a3d2c1b5d@broadcom.com>
Date:   Wed, 19 Aug 2020 14:14:20 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <62f89d06-e6ef-9476-1797-bec153d8e6db@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/19/2020 1:49 PM, Florian Fainelli wrote:
> On 8/19/20 1:48 PM, Christian Lamparter wrote:
>> On 2020-08-19 06:23, Florian Fainelli wrote:
>>> The pin controller resources start at 0xc0 from the CRU base which is at
>>> 0x100 from th DMU base, for a final address of 0x1800_c1c0, whereas we
>>> are currently off by 0x100. The resource size of the CRU is also
>>> incorrect and should end at 0x248 bytes from 0x100 which is the start
>>> address. Finally, the compatibility strings defined for the
>>> pin-controller node should reflect the SoC being used.
>>>
>>> Fixes: 9994241ac97c ("ARM: dts: BCM5301X: Describe Northstar pins mux
>>> controller")
>>> Reported-by: Christian Lamparter <chunkeey@gmail.com>
>>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>>> ---
>>> Christian, can you test this as a preliminary patch for your Cisco
>>> Meraki MR32 series? Thanks!
>>
>> Hm, it looks like this is more complicated than this. We should have
>> looked at pinctrl-ns.c's ns_pinctrl_probe() [0] before calling it.
>>
>> |    ns_pinctrl->regmap = syscon_node_to_regmap(of_get_parent(np));
>> |    if (IS_ERR(ns_pinctrl->regmap)) {
>> |        int err = PTR_ERR(ns_pinctrl->regmap);
>> |
>> |        dev_err(dev, "Failed to map pinctrl regs: %d\n", err);
>> |
>> |        return err;
>> |    }
>> |
>> |    if (of_property_read_u32(np, "offset", &ns_pinctrl->offset)) {
>> |        dev_err(dev, "Failed to get register offset\n");
>> |        return -ENOENT;
>> |    }
>>
>> So, the ns_pinctrl_probe() takes the address of the parent node (cru)
>> and then looks for a "offset" property to add to this (which is missing
>> in the bcm5301x.dtsi [1]).
>>
>> Thing is, for this to work, the parent-node should be a "simple-mfd" (so
>> a regmap is created for the reg), right? This would also mean that the
>> "reg" property in the pin-controller node is just cosmetic.
>>
>> I guess the reason why this sort-of-works for me is because I'm using
>> this MR32 with OpenWrt (Rafał Miłecki is probably using it too ;) ).
>>
>> (Note: We should not forget to update the binding-documentation as well!)
>>
>> BTW: I'll reply my findings for the i2c issue with the MR32 in the other
>> mail.
> 
> Rafal, has this driver ever worked to begin with? None of this should be
> necessary, we should just be using a simple platform device resource here.
> 

Florian, what if CDRU is a shared resource whose registers are accessed
and shared by multiple blocks (and therefore device drivers) within the
chip? Then accessing this shared CDRU resource through syscon makes sure
there's no race condition, isn't it?


