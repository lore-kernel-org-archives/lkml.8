Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46385C433E4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 16:11:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DF172076D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 16:11:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fGVtEIMM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729249AbgGPQLX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 12:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728837AbgGPQLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 12:11:21 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A56FCC061755;
        Thu, 16 Jul 2020 09:11:20 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id a21so7131021ejj.10;
        Thu, 16 Jul 2020 09:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=afikj2x6d80faw5ihr4eewg9zarzp6KGseVCVHdo4Xc=;
        b=fGVtEIMMVzv7JQI7ZwCO1ec93nwrG0eR8KkMl6HxIa8zP53rpG4eecbAlNDXUB5EQw
         0uGmIYBFKOkLsPakr9gBU4jxgpIT62ecZKmjtepYHJ5z0NgBhK5tx6V1GVXvSXH/3cAp
         mb9pI4UIrY1NxC03ZiAxK6ATO/4yuPJtkEAERro8FHBTtkocyj34RmGfZ117vEodlVkh
         X/3DUK4o5vbSuKYE2+6lAjE8aTbIguxkkkT91zoICdY7WKpZNA52vP2bGWBNwyxLqZbn
         YVuAF0Ct2Ssx8NYaO4FVRb+uCAF0+09dgFJoxmJKXDfootnEbbzaxGmghhIxWkr7J/7D
         MfPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=afikj2x6d80faw5ihr4eewg9zarzp6KGseVCVHdo4Xc=;
        b=ff8DBJZHtzLbfQ+slnHJpS0w7u6rs9c2Ql9Dy6pHFHiWBrBMw1NRmt5VIdSbl1hZoD
         p4mFcJvLKrsaB/oRBcjTFmYbnLe77HAC29Z84B/0im2yBt1w/YmcSPnR1sw8fua28+AB
         ItS6Qrr07S1h/g3xoeoK4nZZ6x16fooWfwH4Pxx6zU+WjJ/WpkXzbUs54kgEUs9saKsd
         ZIijpW34nvCD964KXdHOQ/BKDa16SX8YEl1Cvr8tI+J0TrDJ6HjuvKW+A94p/yd1p/wV
         KQ6pn33eHuaLGBFwyR0PdDLjHY+B4LPIDGl4yoiCK0/dlbWydMHbb3YAyVo0S2E97bEL
         T+kw==
X-Gm-Message-State: AOAM533X7vTB8hPsNQwPqGJcZ02cAiJ/TzWbR09ceIYoa9lWXpJGR3m6
        ws/LINwCpmM17Ul0GJEz0EGkpuax9OE=
X-Google-Smtp-Source: ABdhPJw3Sjmye5JUDNp0BJHq8yK9rY4J+JijCf75AbIl4nClN+7v8c0wXm4G8SksZjQzW8i1NpFtng==
X-Received: by 2002:a17:906:f94c:: with SMTP id ld12mr4608617ejb.426.1594915879041;
        Thu, 16 Jul 2020 09:11:19 -0700 (PDT)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id j21sm5781506edq.20.2020.07.16.09.11.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jul 2020 09:11:18 -0700 (PDT)
Subject: Re: [RFC PATCH v1 1/2] dt-bindings: arm: rockchip: add A95X Z2
 description
To:     Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh@kernel.org>
Cc:     linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        heiko@sntech.de, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
References: <20200620134659.4592-1-jbx6244@gmail.com>
 <20200620134659.4592-2-jbx6244@gmail.com> <20200715192935.GA684031@bogus>
 <14b39efe-f38b-b471-560d-1ecaeafc5dd5@gmail.com>
 <56b1447d-6c62-9e73-a7ce-08fb70096a97@arm.com>
From:   Johan Jonker <jbx6244@gmail.com>
Message-ID: <544f9182-034b-6309-a945-72b5a34ee2e8@gmail.com>
Date:   Thu, 16 Jul 2020 18:11:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <56b1447d-6c62-9e73-a7ce-08fb70096a97@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/16/20 3:34 PM, Robin Murphy wrote:
> On 2020-07-16 13:05, Johan Jonker wrote:
>> Hi Rob,
>>
>> The A95X Z2 boxes are sold by various vendors/manufacturers/web shops.
>> The box it self only shows a label with a model name.
>> Determining the true vendor is a kind of tricky for a outsider of the
>> business.
>> Could you advise what would be a save choice to the rather rigid vendor
>> requirements.
>> Is for example this a option:
>>
>>    "^a95x,.*":
>>      description: A95X
>>
>> Is there someone who can give more info on this subject?
> 
> FWIW we already have some "A95X" branded things attributed to Nexbox in
> upstream DTs, however, the evidence from scraping around the internet
> suggests that the closest thing to an original vendor for the "A95X Z2"
> model is probably these folks:
> 
> https://zkmagic.en.alibaba.com/

That's where I got my update/backup img from.
A mail was sent, but what if they all claim to be a 'official' or
'direct' store?

option 1:

      - description: A95X Z2
        items:
          - const: a95x,z2

  "^a95x,.*":
    description: A95X

or option 2:

      - description: Zkmagic A95X Z2
        items:
          - const: zkmagic,a95x-z2

  "^zkmagic,.*":
    description: Shenzhen Zkmagic Technology Co., Ltd.

I'ld rather prefer a short neutral name like option 1 just to be save. ;)
For the completeness there seems to be:
a95x a2
a95x a3
a95x f1
a95x f2
a95x f3
a95x max
a95x max plus
a95x r1
a95x r2
a95x r3
a95x r5
a95x z2
a95x z2 +

Any advice welcome..

Johan

> 
> Robin.
> 
>>
>> Kind regards,
>>
>> Johan Jonker
>>
>> On 7/15/20 9:29 PM, Rob Herring wrote:
>>> On Sat, Jun 20, 2020 at 03:46:58PM +0200, Johan Jonker wrote:
>>>> Add A95X Z2 description for a board with rk3318 processor.
>>>>
>>>> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
>>>> ---
>>>>   Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
>>>>   1 file changed, 5 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml
>>>> b/Documentation/devicetree/bindings/arm/rockchip.yaml
>>>> index d4a404509..3d44b3cf0 100644
>>>> --- a/Documentation/devicetree/bindings/arm/rockchip.yaml
>>>> +++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
>>>> @@ -25,6 +25,11 @@ properties:
>>>>             - const: vamrs,rock960
>>>>             - const: rockchip,rk3399
>>>>   +      - description: A95X Z2
>>>> +        items:
>>>> +          - const: a95x,z2
>>>
>>> Need to document vendor prefix.
>>>
>>>> +          - const: rockchip,rk3318
>>>> +
>>>>         - description: Amarula Vyasa RK3288
>>>>           items:
>>>>             - const: amarula,vyasa-rk3288
>>>> -- 
>>>> 2.11.0
>>>>
>>
>>
>> _______________________________________________
>> Linux-rockchip mailing list
>> Linux-rockchip@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-rockchip
>>

