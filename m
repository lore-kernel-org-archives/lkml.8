Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40ECBC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 12:29:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 186792078B
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 12:29:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dgq2ENGi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729357AbgEUM3G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 08:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729189AbgEUM3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 08:29:03 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FCA1C061A0E;
        Thu, 21 May 2020 05:29:03 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id a2so8543369ejb.10;
        Thu, 21 May 2020 05:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6GWXUPDNtcqPMbMf+st3rlAt+MWIjWvFAG+evIajo2Q=;
        b=Dgq2ENGih+H9YOhCve0hYfcTj4H0NHnoqFUNURea3Nkq//rRp/Y7OwrKGo+V56lh7g
         unHKMmsPtCGSyKki7bPw90RLPuG3B9MQMZEU3Bh41SPPYHZyGhq3tyFAfEcpvjXZcam3
         rjLqQJw4w1VaH1NQzO8vKnX+RAPU2vO2j4ZZaqF+9dTSJUFjGpEL2Tjt4XMPJu6xSqJd
         SknvoknV8qSmYree9EawNrQVfTmyG9RrjSbcL4kG787IpHfKpdooYHXGdSBpLXvkvRrp
         C2Qj6FEFT83LXlKAyrx8SU/cSRmt1JlIFOSixmgW2oCKJUV2U3kEH+tdIc8YLaLjhvfz
         +4lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6GWXUPDNtcqPMbMf+st3rlAt+MWIjWvFAG+evIajo2Q=;
        b=NrJInznbND84SiSBUmxOsy8ttJV8ZNKl0/5RqPwAMaZ1z6rkeTC/Xpw41Rf2HGJ/HI
         YLf/yEmZPdZ/43+/axBhl07L8m5j8TP1GNK8E7Hgz/4rBPlQOlwfWMiGAN5KKpdYISf9
         3gK29ktL8Yi8FpxQRkrsBReNwJFOuu+heddrJHSUWenNsDlUNeXBB3+W2phqEDNuIZeL
         gwJSuZRcoVger6Y093kGFynXuhs3sbFA64YBpodKkTnu3v0bUTsgch+d18pfNQKOILfC
         8NLlwraqv+E63Ltt3KhPp24Zb8kLrObtywU9lXw/JTlHGtbhX4Vca7dvw16YWiU8F7b/
         SLtQ==
X-Gm-Message-State: AOAM533n0Rwgk0uzzqSNgpAX7j333PDA6sk89HdYEoKnNdEu+FTd//f7
        K5fyqQ9POEV1IU0JEVz7a+0=
X-Google-Smtp-Source: ABdhPJyIuKGqOWjquNroUoWJ3cJmIA0tMeGKZOElZzWNqX8OV/c6qN8Y0YF0wDLkl/gS4HLH53vhxQ==
X-Received: by 2002:a17:907:9484:: with SMTP id dm4mr3521767ejc.56.1590064142189;
        Thu, 21 May 2020 05:29:02 -0700 (PDT)
Received: from [192.168.2.1] (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id nj6sm4692805ejb.99.2020.05.21.05.29.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 May 2020 05:29:01 -0700 (PDT)
Subject: Re: [RFC PATCH] arm64: dts: rockchip: fix dmas dma-names for rk3308
 i2s node
To:     Robin Murphy <robin.murphy@arm.com>, heiko@sntech.de
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, kever.yang@rock-chips.com,
        wxt@rock-chips.com
References: <20200520064816.3954-1-jbx6244@gmail.com>
 <543270ad-dd11-2bd4-8959-e898834c19e5@arm.com>
From:   Johan Jonker <jbx6244@gmail.com>
Message-ID: <094fa89d-61f7-1eb4-be78-b430502c5d3e@gmail.com>
Date:   Thu, 21 May 2020 14:28:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <543270ad-dd11-2bd4-8959-e898834c19e5@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin, Kever, Caesar,

On 5/21/20 1:48 PM, Robin Murphy wrote:
> On 2020-05-20 07:48, Johan Jonker wrote:
>> One of the current rk3308 'i2s' nodes has a different dma layout
>> with only 1 item. Table 9-2 DMAC1 Request Mapping Table shows that
>> there 2 dma sources available, so fix the dmas and dma-names
>> for the rk3308 'i2s' node.
>>
>> 10 I2S/PCM_2CH_1 tx High level
>> 11 I2S/PCM_2CH_1 rx High level
> 
> ...however table 1-5 in the same manual (at least that I could find)
> says request 10 is reserved. Does that mean it was intended to be wired
> up for this, but ended up broken for some reason?
> 
> Do you have hardware to confirm whether this works reliably or not?

No, I don't.
A description for 3308 was added to rockchip-i2s.yaml with only rx by
myself.
It would be nice if someone could test, confirm or give a hint.

Could someone from Rockchip(Kever, Caesar) explain the 'Reserved' in
Table 1-5 ?

Table 1-5 RK3308 DMAC1 hardware request connection list

10 Reserved     High level
11 I2S_2CH_1 rx High level

> 
> Robin.
> 
>> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
>> ---
>>   arch/arm64/boot/dts/rockchip/rk3308.dtsi | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3308.dtsi
>> b/arch/arm64/boot/dts/rockchip/rk3308.dtsi
>> index ac7f69407..79c1dd1fe 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk3308.dtsi
>> +++ b/arch/arm64/boot/dts/rockchip/rk3308.dtsi
>> @@ -564,8 +564,8 @@
>>           interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>;
>>           clocks = <&cru SCLK_I2S1_2CH>, <&cru HCLK_I2S1_2CH>;
>>           clock-names = "i2s_clk", "i2s_hclk";
>> -        dmas = <&dmac1 11>;
>> -        dma-names = "rx";
>> +        dmas = <&dmac1 10>, <&dmac1 11>;
>> +        dma-names = "tx", "rx";
>>           resets = <&cru SRST_I2S1_2CH_M>, <&cru SRST_I2S1_2CH_H>;
>>           reset-names = "reset-m", "reset-h";
>>           status = "disabled";
>>

