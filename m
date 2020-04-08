Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5D8BC2BB54
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 00:07:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3F852054F
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 00:07:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ulXYa0uw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgDHAHq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 20:07:46 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33306 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726416AbgDHAHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 20:07:45 -0400
Received: by mail-wm1-f65.google.com with SMTP id v8so2653wma.0;
        Tue, 07 Apr 2020 17:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2fG/vO+qjiABqlpw9kh+t0UsO4QTTlq+ppWwS4RE+1s=;
        b=ulXYa0uw1K3wGSI9lmvkLzIfcxAKWdBvy7EdTUT/KxNS2CvQEMt0D6e98IyXq7tRlq
         k1mqFzMf82KDa15dQTDDxaAhxRwQQfLKhQ9/Hj0R5uvtYY16hcvY9NpGLWj2kqE6B3tE
         tVFZvf8BP1rvRCZd6Luyf3sesAUpNunXZvp5pWsnVscyBQfQYjwyldgsZH4xX86ns35q
         e4NsuQSxZvc+TD2unNeht7i5NjYqzRJ4KOfliHV80SQ+oY0YCSOJE/CukL1L+TpcxVQy
         GCbibqjigI0V9Vmg4h2jxbSEb449X2qbg944PlaM+ZHgYL+Y+I4/JnpNK9HN42HCuFiC
         drMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=2fG/vO+qjiABqlpw9kh+t0UsO4QTTlq+ppWwS4RE+1s=;
        b=S7gVfDIJr/1qQbV/DHerVqNxZy+ZBrGCYwuv0OoJDaYBe6v3/2k2T9F/NmXOW/xA0E
         xFWVahrh3qcxjusxh1ehORRopk5jcuUnjROzlzY8Rx+HvjsjXNo9/eGAhVl7o6ZgJOIc
         uxgba7ewPeyvcom+Q/OHv54s0r1YCCLaKAYd8AIlM5q4QECP+OvneyYqpCKDxfCWjDkN
         DpOIjtkya4dzXqkQ9QdgE9pyuIDCJ28MupIoQF3+aHsvqB+N/FiBblTMQ1GIpI/JCeht
         BYqSa72PE3bQPwFDXhSDm5AV6JaNDyw9rrYT7lmmvY3KLHgeOminOQ+cEmRlflaccuC6
         mhkw==
X-Gm-Message-State: AGi0Pubfi8nOW3/JIhNXfWb39fvFxFbve89o1wj71GV+ozZs/VzoSOEm
        oUEZQlexjbNuhozkq72/GBg=
X-Google-Smtp-Source: APiQypK0JrKIVG1lFeKNPmMG8d7tfr77E0xegYAKNfqXt+djTc20xcBBX628F8sOnjoSsKo6gGbEBg==
X-Received: by 2002:a7b:cf27:: with SMTP id m7mr1785049wmg.58.1586304462488;
        Tue, 07 Apr 2020 17:07:42 -0700 (PDT)
Received: from [192.168.1.3] (ip68-111-84-250.oc.oc.cox.net. [68.111.84.250])
        by smtp.gmail.com with ESMTPSA id d133sm1260586wmc.27.2020.04.07.17.07.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Apr 2020 17:07:41 -0700 (PDT)
Subject: Re: [PATCH 0/5] arm: dts: linksys: rename codename to model
To:     Paul Spooren <mail@aparcar.org>, Andrew Lunn <andrew@lunn.ch>
Cc:     devicetree@vger.kernel.org, jason@lakedaemon.net,
        gregory.clement@bootlin.com, linux-kernel@vger.kernel.org,
        daniel@makrotopia.org, freifunk@adrianschmutzler.de,
        robh+dt@kernel.org, kaloz@openwrt.org,
        linux-arm-kernel@lists.infradead.org,
        sebastian.hesselbarth@gmail.com
References: <20200407210816.866084-1-mail@aparcar.org>
 <20200407224615.GA359603@lunn.ch>
 <004a2ef9c1e04f9ffbb9c3cc9907ca656a406713.camel@aparcar.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 M5kY0ACeNhCZJvZ5g4C2Lc9fcTHu8jxmEkI=
Message-ID: <ecf4dc01-81f8-a33d-b4a7-2065748993ed@gmail.com>
Date:   Tue, 7 Apr 2020 17:07:38 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <004a2ef9c1e04f9ffbb9c3cc9907ca656a406713.camel@aparcar.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/7/2020 4:38 PM, Paul Spooren wrote:
> Hi Andrew,
> 
> thank you very much for the quick response!
> 
> On Wed, 2020-04-08 at 00:46 +0200, Andrew Lunn wrote:
>> On Tue, Apr 07, 2020 at 11:08:10AM -1000, Paul Spooren wrote:
>>> Linksys chose to use codenames for a few of their devices and sell
>>> their
>>> them under an entirely different name.
>>>
>>> codename  model name
>>> rango  -> wrt3200acm
>>> mamba  -> wrt1900ac
>>> cobra  -> wrt1900ac-v2
>>> caiman -> wrt1200ac
>>> shelby -> wrt1900acs
>>
>> Hi Paul
>>
>> There was quite a bit of discussion about this when the first board
>> was added. If i remember correctly, it was Mamba.
>>
>> Imre Kaloz, <kaloz@openwrt.org> was the one arguing for
>> the name armada-xp-linksys-mamba.dts.
>>
>> So it seems that openwrt.org has now come full circle?
> 
> I talked with three currently active OpenWrt core developers and all
> were in favor of a unification. I wasn't aware of any previous
> discussions nor any pro arguments to keep code names.
> 
> I've added Imre via CC so maybe he can share his opinion, too.
>>
>>> This introduces some extra loops in OpenWrt, a distribution
>>> specialized
>>> on embedded Internet facing devices, as both codename and model
>>> name are
>>> used within the build system. The double naming requires developers
>>> to
>>> keep track of that mapping and introduces inconsistencies:
>>>
>>> To build a specific device in OpenWrt profiles are used, named
>>> after the
>>> the compatible string for targets using device tree (similar to how
>>> .dts
>>> files are named in the linux source tree). However, the first item
>>> of
>>> the DT `compatible` list in this case is `linksys,rango`, which is
>>> inconsistent with the model name and not what common users would
>>> expect.
>>>
>>> Such double naming complicates currently the automatic search for
>>> firmware upgrade as the build system does not support such mapping.
>>> Ideally the first item of the DT `compatible` list would contain a
>>> string suitable to be used as a filename recognizable by normal
>>> users to
>>> belong to that device.
>>> With this patch set the Linksys device tree files are moved from
>>> containing the codename to contain a sanitized model name and also
>>> use
>>> it as first entry of the DT `compatible` list.
>>
>> I've no problems adding another compatible to the list. But i don't
>> like the idea of renaming the files. The file names could be
>> considered ABI! What installers/bootloaders are you going to break by
>> renaming them?
> 
> Are you okay with adding the new compatible string as first element of
> the list? This would already simplify the OpenWrt build system.

Having a mapping table between model names in OpenWrt profiles and .dts
file names in the kernel sources is not that complicated to maintain,
changing the kernel for that reason sounds a bit weak IMHO.
-- 
Florian
