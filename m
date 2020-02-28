Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B359C3F2D1
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 12:50:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63274246A3
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 12:50:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hRPTW2UL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbgB1MuS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 07:50:18 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36633 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbgB1MuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 07:50:16 -0500
Received: by mail-wm1-f67.google.com with SMTP id g83so867369wme.1;
        Fri, 28 Feb 2020 04:50:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7SOOFR5A8cRXpbsPD4NmdfCkYNnaGr0VzqHcY4iP4Ns=;
        b=hRPTW2ULNhZjOA7emZQEEesi0PP78D2LjuQEDDCKuOSmhH2h3dXr/i2KP0Eh5ZDEQY
         Sl8/xquqjPHT2muExLEDXse/D/C+AgxqOUQjBLddCYYebubu6P0yxK2KUCoxir6gVHlt
         a9chrqRrjWXfXXbAKNMM0JZleYqutB3bgwhdSx/4msoeVSXCjvdn8j7lgq8tlFcJBGNj
         zt8hAewJ71Rprux8EA3g0UshuptOIRaucJsW6wAX/ypcH8Q99Jb8vdhwZj/HLpCH6IbN
         j+BXJQeoMzI17eqjjAG64da++fJXdaXh3MWCVKsQM2khOkO/Oym4aoYRNDtwh3syYwAG
         WxLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7SOOFR5A8cRXpbsPD4NmdfCkYNnaGr0VzqHcY4iP4Ns=;
        b=BYJKJNzoqT3/djcTn8WpHkVa93X3ixW7xVY+8naDxfrrY7kB2Yzp8EfWeTxMIrUl1j
         GsHsgvldW50Ni8g/IcSPo+nc+PfySPNQxHCcmI1vpRdxHQ9RuAFbIy1ZOojuE1VRdThL
         Qr3aj2ZUve8GRUNTUY7mWUAfkjcAK8Gdl/x34FMmdqAsWQ5beQCS8XpmNHIyNYeNAiq3
         r8aViRuGj/CiTIAM2UoFcBqt4y7bl0aOaU55oBS+Wih7y4Eeoim7DmLD3uqkmOviTWIe
         BF0pRH9JzdHR7ssbu8MUZ2zKnkvvuvSlZZhloYz00PcjXa3VeZfytSMZ7oTysxYGrPix
         pyPg==
X-Gm-Message-State: APjAAAX04zZkPt8wfeSXAkGfsH8FUDLDbvGHloJ9CLsCBgGwWO6nF+tH
        omagrgBs4UGpPVhXGVoRg1s=
X-Google-Smtp-Source: APXvYqyh7/fg3k/2U7H+2hUIEb3j1cDGCqO8ryTnH0ZUxrE0DmK4Gl1qwlanUJWAfh9jNCS7V8A/dA==
X-Received: by 2002:a05:600c:251:: with SMTP id 17mr4687252wmj.59.1582894214215;
        Fri, 28 Feb 2020 04:50:14 -0800 (PST)
Received: from [192.168.2.1] (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id c9sm12549852wrq.44.2020.02.28.04.50.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Feb 2020 04:50:13 -0800 (PST)
Subject: Re: [PATCH 1/4] dt-bindings: arm: fix Rockchip Kylin board bindings
To:     Robin Murphy <robin.murphy@arm.com>, heiko@sntech.de
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
References: <20200228061436.13506-1-jbx6244@gmail.com>
 <73b41bd1-01e9-6af8-afc8-b1a96614d026@arm.com>
From:   Johan Jonker <jbx6244@gmail.com>
Message-ID: <5d47cf5f-9ac4-cff4-340b-a2518a508738@gmail.com>
Date:   Fri, 28 Feb 2020 13:50:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <73b41bd1-01e9-6af8-afc8-b1a96614d026@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/28/20 1:35 PM, Robin Murphy wrote:
> On 28/02/2020 6:14 am, Johan Jonker wrote:
>> A test with the command below gives this error:
>>
>> arch/arm/boot/dts/rk3036-kylin.dt.yaml: /: compatible:
>> ['rockchip,rk3036-kylin', 'rockchip,rk3036']
>> is not valid under any of the given schemas
>>
>> Fix this error by changing 'rockchip,kylin-rk3036' to
>> 'rockchip,rk3036-kylin' in rockchip.yaml.
> 


> Although I can guess, it might be worth a note to explain why it's the
> binding rather than the DTS that gets changed here.

Hi Robin,

My guess is that given a look at the other boards the processor name
comes first and then the board name, so I changed it in rockchip.yaml.
But maybe Heiko can better explain what the naming consensus in the past
was.

Kind regards,

Johan

> 
> Robin.
> 
>> make ARCH=arm dtbs_check
>> DT_SCHEMA_FILES=Documentation/devicetree/bindings/arm/rockchip.yaml
>>
>> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
>> ---
>>   Documentation/devicetree/bindings/arm/rockchip.yaml | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml
>> b/Documentation/devicetree/bindings/arm/rockchip.yaml
>> index 874b0eaa2..203158038 100644
>> --- a/Documentation/devicetree/bindings/arm/rockchip.yaml
>> +++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
>> @@ -443,7 +443,7 @@ properties:
>>           - description: Rockchip Kylin
>>           items:
>> -          - const: rockchip,kylin-rk3036
>> +          - const: rockchip,rk3036-kylin
>>             - const: rockchip,rk3036
>>           - description: Rockchip PX3 Evaluation board
>>

