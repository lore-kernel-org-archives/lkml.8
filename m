Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2D1EC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 17:34:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9A9B208B8
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 17:34:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iiqRWOJe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732285AbgFRReL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 13:34:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728384AbgFRReK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 13:34:10 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB7EC06174E;
        Thu, 18 Jun 2020 10:34:10 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id y9so3156480qvs.4;
        Thu, 18 Jun 2020 10:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HEt4Pvebw1D02KEOJn4E0FCDzL41oY+kb0al+hZuU00=;
        b=iiqRWOJedzCE0nYhPevpMxA8E6GErKmVq3eX5LGN4vJS4nnKZIA9PyIsZHpqjFGHVs
         p/LDOiY/w5n9vRMD7htsyddAZewMnIg5W4pcBuRm+vrc+l3pTEy2OhoRkstG43xS/U5l
         5BH2Ab5f8LC6ee+/Yn49oZvorgfF2aKN/i36uBuXFkxWluqJk3sCJQc4c3BgmbyLlUGz
         Ciy8z6wf1a5LrL9jGISLUlgKWKymwDUpxbumR2Ra4OKxnycymndz8538yK+RCIA7yQCS
         fubzWDqY3Ao/URof858vU9iylT4IqHWKeAfrLSinM68jauqU8TGW5Av2d0RTtNzqyoI3
         MfKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HEt4Pvebw1D02KEOJn4E0FCDzL41oY+kb0al+hZuU00=;
        b=B5dH2vSqDqYZCm5bsaVBM3PZDJbvvwoxXzR1emGrGGlSAdum0omIb2XjVGWbJZr6hn
         6eXbk3o70n26/mfq2w5QNpb5o6v5FixmhDpmezMzYsfe4hnyvVG1n5GTAjyS4rUTvcxF
         wTqXrp7pJe76N91e9IDRHVtyBVyV9Bcu5ye3g68gu1J8+fP1TRFBQ3Leym/4holV19Gx
         Ncu0HPdEQHkOuAU+Kg8+kuRV5j62s8nhyVKy9ET92XPmRS39mVuVF/lhmy6nPaOaYYP5
         7bGLOycp30XQKqEit4j2/EM0ofCBOUlQSoUYyUvONKT7TgmPbLTeCHQ3jzduaeOSW94z
         lTGA==
X-Gm-Message-State: AOAM533GJNL90sreH4tnlGVdV5v/eAjuKFyoIsI4rNm+rzIXHX9/dWNC
        qCDLozQXJL1jsmciV+LG1xE=
X-Google-Smtp-Source: ABdhPJzf++G2jVb6Z9CC0IL2NDF9hkq8ySX+4NfRd5wM/n+z3/yS5T9b//i24vaF/xge3XVL62440w==
X-Received: by 2002:a05:6214:9ce:: with SMTP id dp14mr4790257qvb.216.1592501649452;
        Thu, 18 Jun 2020 10:34:09 -0700 (PDT)
Received: from [192.168.1.46] (c-73-88-245-53.hsd1.tn.comcast.net. [73.88.245.53])
        by smtp.gmail.com with ESMTPSA id n13sm4307698qtf.35.2020.06.18.10.34.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jun 2020 10:34:08 -0700 (PDT)
Subject: Re: [PATCH v2 1/3] mfd: core: Make a best effort attempt to match
 devices with the correct of_nodes
To:     Lee Jones <lee.jones@linaro.org>
Cc:     andy.shevchenko@gmail.com, michael@walle.cc, robh+dt@kernel.org,
        broonie@kernel.org, devicetree@vger.kernel.org,
        linus.walleij@linaro.org, linux@roeck-us.net,
        andriy.shevchenko@linux.intel.com, robin.murphy@arm.com,
        gregkh@linuxfoundation.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20200611191002.2256570-1-lee.jones@linaro.org>
 <4b188fb5-6667-720d-46e1-6f103efe8966@gmail.com>
 <20200615092644.GA2608702@dell>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <eef50a78-8571-5600-4fee-c824fd4a7f69@gmail.com>
Date:   Thu, 18 Jun 2020 12:34:07 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200615092644.GA2608702@dell>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-06-15 04:26, Lee Jones wrote:
> On Sun, 14 Jun 2020, Frank Rowand wrote:
> 
>> Hi Lee,
>>
>> I'm looking at 5.8-rc1.
>>
>> The only use of OF_MFD_CELL() where the same compatible is specified
>> for multiple elements of a struct mfd_cell array is for compatible
>> "stericsson,ab8500-pwm" in drivers/mfd/ab8500-core.c:
>>
>>         OF_MFD_CELL("ab8500-pwm",
>>                     NULL, NULL, 0, 1, "stericsson,ab8500-pwm"),
>>         OF_MFD_CELL("ab8500-pwm",
>>                     NULL, NULL, 0, 2, "stericsson,ab8500-pwm"),
>>         OF_MFD_CELL("ab8500-pwm",
>>                     NULL, NULL, 0, 3, "stericsson,ab8500-pwm"),

         OF_MFD_CELL("ab8500-pwm",
                     NULL, NULL, 0, 0, "stericsson,ab8500-pwm"),

         OF_MFD_CELL_REG("ab8500-pwm-mc",
                         NULL, NULL, 0, 0, "stericsson,ab8500-pwm", 0),
         OF_MFD_CELL_REG("ab8500-pwm-mc",
                         NULL, NULL, 0, 1, "stericsson,ab8500-pwm", 1),
         OF_MFD_CELL_REG("ab8500-pwm-mc",
                         NULL, NULL, 0, 2, "stericsson,ab8500-pwm", 2),

>>
>> The only .dts or .dtsi files where I see compatible "stericsson,ab8500-pwm"
>> are:
>>
>>    arch/arm/boot/dts/ste-ab8500.dtsi
>>    arch/arm/boot/dts/ste-ab8505.dtsi
>>
>> These two .dtsi files only have a single node with this compatible.
>> Chasing back to .dts and .dtsi files that include these two .dtsi
>> files, I see no case where there are multiple nodes with this
>> compatible.
>>
>> So it looks to me like there is no .dts in mainline that is providing
>> the three "stericsson,ab8500-pwm" nodes that drivers/mfd/ab8500-core.c
>> is expecting.  No case that there are multiple mfd child nodes where
>> mfd_add_device() would assign the first of n child nodes with the
>> same compatible to multiple devices.
>>
>> So it appears to me that drivers/mfd/ab8500-core.c is currently broken.
>> Am I missing something here?
>>
>> If I am correct, then either drivers/mfd/ab8500-core.c or
>> ste-ab8500.dtsi and ste-ab8505.dtsi need to be fixed.
> 
> Your analysis is correct.

OK, if I'm not overlooking anything, that is good news.

Existing .dts source files only have one "ab8500-pwm" child.  They already
work correcly.

Create a new compatible for the case of multiple children.  In my example
I will add "-mc" (multiple children) to the existing compatible.  There
is likely a better name, but this lets me provide an example.

Modify drivers/mfd/ab8500-core.c to use the new compatible, and new .dts
source files with multiple children use the new compatible:

         OF_MFD_CELL("ab8500-pwm",
                     NULL, NULL, 0, 0, "stericsson,ab8500-pwm"),

         OF_MFD_CELL_REG("ab8500-pwm-mc",
                         NULL, NULL, 0, 0, "stericsson,ab8500-pwm", 0),
         OF_MFD_CELL_REG("ab8500-pwm-mc",
                         NULL, NULL, 0, 1, "stericsson,ab8500-pwm", 1),
         OF_MFD_CELL_REG("ab8500-pwm-mc",
                         NULL, NULL, 0, 2, "stericsson,ab8500-pwm", 2),

The "OF_MFD_CELL" entry is the existing entry, which will handle current
.dts source files.  The new "OF_MFD_CELL_REG" entries will handle new
.dts source files.

And of course the patch that creates OF_MFD_CELL_REG() needs to precede
this change.

I would remove the fallback code in the existing patch that tries to
handle an incorrect binding.  Just error out if the binding is not
used properly.

-Frank

> 
> Although it's not "broken", it just works when it really shouldn't.
> 
> I will be fixing the 'ab8500-pwm' case in due course.
> 
>> Moving forward, your proposed OF_MFD_CELL_REG() method seems a good
>> approach (I have not completely read the actual code in the patch yet
>> though).
> 
> Thanks.
> 

