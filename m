Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0A2DC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 18:07:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7947020BED
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 18:07:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UCovHOK/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389616AbgDBSHQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 14:07:16 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37769 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728225AbgDBSHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 14:07:15 -0400
Received: by mail-wm1-f68.google.com with SMTP id j19so4724442wmi.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 11:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vdWks4AQpqeehaYYou2J7fvgzfRz/UIxr+69/Uefw0Q=;
        b=UCovHOK/R0xU+Kgba2KKg3vpKr5w7kDbPHVtfDtLRt0ovdIFeohbEXiTAlEM27UEQb
         iEstPqVajRxrmlV+kD+vqHPIGCUNbr7oUjmhfHvX+5ZAVRcxfRyopx2YojbXznHZESIO
         PFSirCSDUfuBH1FjZTgvSJIVjYnWzXEBXZULQtl8qi+ccU7ZT3TiqymNaza7Ew03A4qX
         Y9yvHSuWn0eL5Tu2fdkeXmPz9f8Ju4p4JnTCXgcKtWUTZeWajcJpMGDGZE+Oz7PwPe3T
         j7mqBnv3/2P7DHY+xiZBApl3cIG4gQX24PuXrJgsdBG153/bmWQXSGzRKzH83cPvM8eQ
         vVmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=vdWks4AQpqeehaYYou2J7fvgzfRz/UIxr+69/Uefw0Q=;
        b=kaqxrTbEP51QecHddKGscjHdHmwB6eXG73dGiyAzw1IY9KovA1+D1Yewi+gqmhdj1p
         S7GVT1gAXyAqpME72m90WpUYXzasLz9i+NvkKln4oTS9fR/4k4o2jTNIOiZXSP3YSj+6
         j/gknSF7cuA77plmFLnEL71nv7QhjGigEGvR+vlMeZjzzOccMTIZ8T6QMJtO1fkVgoNQ
         PKchbClLsBk2mLGfCK8ByCEjg9DKL3u5moyOu7uYP1OVkZB6dsMor4SmuPs0ljSPy5Ev
         PT0+qCxgP3GwWWASaiDXbwPjLDg+yK092d1BBrjb096zHgeGcqCur4Jph8NeTTPXetBj
         7m/A==
X-Gm-Message-State: AGi0PuZvPEkdsxeafZ+A7tehUNUnxr1/sRgjpwzxyDtxEnxjQvKx59fc
        L73S4pcBsXD1K6skMePd++siO7Zi
X-Google-Smtp-Source: APiQypK/TnjutWZFfVrDgy+A0DM6aUOj0McmEO9npLMEDPtugaLyhZWY+MXHhcN+kLZfFoJ/hiLT0A==
X-Received: by 2002:a05:600c:2188:: with SMTP id e8mr4554975wme.121.1585850832763;
        Thu, 02 Apr 2020 11:07:12 -0700 (PDT)
Received: from [10.230.186.223] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id h132sm8671874wmf.18.2020.04.02.11.07.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Apr 2020 11:07:11 -0700 (PDT)
Subject: Re: [PATCH] Documentation: dt-bindings: Document 'rng-seed' for
 /chosen
To:     Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, hsinyi@chromium.org,
        geert+renesas@glider.be, swboyd@chromium.org, robh@kernel.org,
        tytso@mit.edu
References: <20200402033640.12465-1-f.fainelli@gmail.com>
 <20200402081346.GA2548@willie-the-truck>
From:   Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 M5kY0ACeNhCZJvZ5g4C2Lc9fcTHu8jxmEkI=
Message-ID: <c380729c-9cba-6639-de9b-64d3d0896110@gmail.com>
Date:   Thu, 2 Apr 2020 11:07:08 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200402081346.GA2548@willie-the-truck>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/2/2020 1:13 AM, Will Deacon wrote:
> Hi Florian,
> 
> On Wed, Apr 01, 2020 at 08:36:40PM -0700, Florian Fainelli wrote:
>> The /chosen node can have a 'rng-seed' property read as a u32 quantity
>> which would contain a random number provided by the boot agent. This is
>> useful in configurations where the kernel does not have access to a
>> random number generator.
>>
>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>> ---
>>  Documentation/devicetree/bindings/chosen.txt | 13 +++++++++++++
>>  1 file changed, 13 insertions(+)
> 
> Thanks for doing this; I realised it was undocumented the other day when I
> tried to look it up myself.
> 
>> diff --git a/Documentation/devicetree/bindings/chosen.txt b/Documentation/devicetree/bindings/chosen.txt
>> index 45e79172a646..126b31eecfeb 100644
>> --- a/Documentation/devicetree/bindings/chosen.txt
>> +++ b/Documentation/devicetree/bindings/chosen.txt
>> @@ -28,6 +28,19 @@ mode) when EFI_RNG_PROTOCOL is supported, it will be overwritten by
>>  the Linux EFI stub (which will populate the property itself, using
>>  EFI_RNG_PROTOCOL).
>>  
>> +rng-seed
>> +--------
>> +
>> +This property is used to initialize the kernel's entropy pool from a
>> +trusted boot agent capable of providing a random number. It is parsed
>> +as a u32 value, e.g.
> 
> Are you sure about this being limited to a u32 value? I thought you could
> pass an arbitrary-length value here.

Humm indeed, we can pass an arbitrary value, I completely conflated the
type of "l" here:

	int l;
	...
        rng_seed = of_get_flat_dt_prop(node, "rng-seed", &l);

with how much we would be reading from the property, which is complete
nonsense. Out of curiosity, what property length do platforms typically
populate?
-- 
Florian
