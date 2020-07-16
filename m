Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A14EC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 12:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27D7C2074B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 12:05:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QMStxITX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728470AbgGPMFX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 08:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726855AbgGPMFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 08:05:22 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47677C061755;
        Thu, 16 Jul 2020 05:05:22 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id p20so6245640ejd.13;
        Thu, 16 Jul 2020 05:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Nn0p+VC3mjMAaWXDs75FvqknjH9VujxJJl7BKzqrJ4U=;
        b=QMStxITXfBYGPH7IoKLkYlVSpfkbXBkzNwmzuWLQBkId1n0iBBig/TP+MbZviBZhNA
         TSppo9btpbVQV+0Zo2kGl08hfozUnwtA+wV/5sB45dwOqwXqLdN2cuqUc75Eau587zfR
         6tjPpeuelHZfyUKn75quJrku54GJEQaQ7BpnwkaPM5Wkul/VRn/PUeGDiJEeUDMv4/bs
         P9PRylJNVo6Za5z4YRdP1MUTwt2XctExfRHt/Z+3IlZgAaxIW+ntgO9ldYGa0IoDumSU
         yG6d1IcMBi7+noiFyw6LI6sNh/mIASviOL7XpnUd6H7ezK6I8PjBwyVzn8U4CTYj7QUp
         UI0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Nn0p+VC3mjMAaWXDs75FvqknjH9VujxJJl7BKzqrJ4U=;
        b=gubKoVEQCQ6qDrdjLDC+SIVfKrNG39xjNMntzGkBrDE3VmPaGReeu/A4KTHjOHDM9q
         lsWBYSKKlQonxF7lsMfs8epHih6UawlShJzGLMM4ztP/G5Vp7IAUolwIAN8llZi+2rmP
         U78TomxHQL/CR4op91U2DALfwvySpoeoAVHmSFZcZf19Jhu3yT4y3uppuS8zlKWNq1KJ
         /uixzHgM7JGMBuwB0WphFqdrJ34fPsp8I7K7WnjoTygT6EJGdGfLVEOJRCcBCmA2Rlc5
         wlptp/CBfzZeSZjDWqnDL+jGFDJFWXHiXgWlKJ8cOO8jwpW8GkPlZMvRPWVTVunmqRiL
         3Q4A==
X-Gm-Message-State: AOAM5336AtMrbPeiRfKd7RT8LsKGZKe/dRKm7DQzdfr2PvC7alq5MO5l
        qcZ4AjnSpWIcazJCXt2IK3fgat0qUaY=
X-Google-Smtp-Source: ABdhPJyU1vdiUyOQq2A2BKvBXyq3FCDBUUlE+FdRWyF6rFZblydCM80031QWdDAnb4oy1I4VRFMCTQ==
X-Received: by 2002:a17:906:45a:: with SMTP id e26mr2224563eja.67.1594901120564;
        Thu, 16 Jul 2020 05:05:20 -0700 (PDT)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id s13sm4790677ejd.117.2020.07.16.05.05.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jul 2020 05:05:19 -0700 (PDT)
Subject: Re: [RFC PATCH v1 1/2] dt-bindings: arm: rockchip: add A95X Z2
 description
To:     Rob Herring <robh@kernel.org>
Cc:     heiko@sntech.de, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200620134659.4592-1-jbx6244@gmail.com>
 <20200620134659.4592-2-jbx6244@gmail.com> <20200715192935.GA684031@bogus>
From:   Johan Jonker <jbx6244@gmail.com>
Message-ID: <14b39efe-f38b-b471-560d-1ecaeafc5dd5@gmail.com>
Date:   Thu, 16 Jul 2020 14:05:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200715192935.GA684031@bogus>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

The A95X Z2 boxes are sold by various vendors/manufacturers/web shops.
The box it self only shows a label with a model name.
Determining the true vendor is a kind of tricky for a outsider of the
business.
Could you advise what would be a save choice to the rather rigid vendor
requirements.
Is for example this a option:

  "^a95x,.*":
    description: A95X

Is there someone who can give more info on this subject?

Kind regards,

Johan Jonker

On 7/15/20 9:29 PM, Rob Herring wrote:
> On Sat, Jun 20, 2020 at 03:46:58PM +0200, Johan Jonker wrote:
>> Add A95X Z2 description for a board with rk3318 processor.
>>
>> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
>> ---
>>  Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
>> index d4a404509..3d44b3cf0 100644
>> --- a/Documentation/devicetree/bindings/arm/rockchip.yaml
>> +++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
>> @@ -25,6 +25,11 @@ properties:
>>            - const: vamrs,rock960
>>            - const: rockchip,rk3399
>>  
>> +      - description: A95X Z2
>> +        items:
>> +          - const: a95x,z2
> 
> Need to document vendor prefix.
> 
>> +          - const: rockchip,rk3318
>> +
>>        - description: Amarula Vyasa RK3288
>>          items:
>>            - const: amarula,vyasa-rk3288
>> -- 
>> 2.11.0
>>

