Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21EC3C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 14:35:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E82672075A
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 14:35:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XkssSAvs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729213AbgFVOfx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 10:35:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728504AbgFVOfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 10:35:52 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85105C061573;
        Mon, 22 Jun 2020 07:35:52 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id f18so15687940qkh.1;
        Mon, 22 Jun 2020 07:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LNUClnRY10+qwIAllr11lVvbbWYvmqFCQZTj4sTxqsA=;
        b=XkssSAvsNqyxhCz25lhiRn5A2OZXtv9ecnYO2mo4br+L9CDc+1dhURng6Q/siaJmP+
         WzADCSm/Uu+lZkfwMlis9tnwGfqkMFJ7yDSPqB6/QmMdGyBJCZdaCNw+Pu420E93yz41
         DBh0yUOSuMw2LOeZOn3UcV1+ciUzlt4NFvwi3NAXLLC1IYRekUqQ8fArGWGJAz61ixJQ
         8tTj/KIyGk9O8Rt9n4NpQBL0EleRzCgZHHg/D5oCjWnIvg9X6dgg9TkCf4SiCe+qLqPi
         wxVwiAnQKTFTnEdWAHD03BFgOprM4uIoQ4fsWHDx80AC78MNJiAYb9G2H251NZ3qDsCD
         bXqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LNUClnRY10+qwIAllr11lVvbbWYvmqFCQZTj4sTxqsA=;
        b=sCfOBpqaWEyHJ0C8KBoYzANsL9Djw2SPEKQHv4RvKww68sqMqCt9p5oZM1hmXbGiOH
         5NiICuGjpl+1+aVUIVdzaJgeYvdCg15rOIyWi520JgwscThE4zaMtyUtoUbVEusHiKhC
         7iI9pmx4xfvuVWdB9jif1Cysq7rE7VuNF5Cek6sUP23iFAFep+wL6agGYTgaTPepg25w
         cxGcrAmSk37FanmJnWNtx2cVo42LysCnySI45haJrz7q5l6XIv2NMmnH7bJxKVdB2Yuw
         drgl7L3xlvc+3s3OxicrFZiFR5mNI2JZ2y/kltD5d6YZ5I95H5CSxrEhyqmqfLDO+R+U
         M6vw==
X-Gm-Message-State: AOAM533b/Jg20YzFgpfIRL1rP94OXt3XeamhYIMvSFhhltI7YbkKnmX+
        Q1o+5/cMumCIEbJmYQPAahw=
X-Google-Smtp-Source: ABdhPJwVMUaj2ibSKyvSlkN0GGpFLwTe7z0TOUh/6k7zDmq0OdgkXhSXA+czB6invWnrGMhGFEkFpQ==
X-Received: by 2002:a37:46c1:: with SMTP id t184mr16597057qka.192.1592836551697;
        Mon, 22 Jun 2020 07:35:51 -0700 (PDT)
Received: from [192.168.1.46] (c-73-88-245-53.hsd1.tn.comcast.net. [73.88.245.53])
        by smtp.gmail.com with ESMTPSA id c24sm4395128qtd.82.2020.06.22.07.35.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jun 2020 07:35:51 -0700 (PDT)
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
 <eef50a78-8571-5600-4fee-c824fd4a7f69@gmail.com>
 <20200622085009.GP954398@dell>
 <cd8952da-cc55-8087-b9f6-876417beb188@gmail.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <f1e03639-a202-ab91-df38-453320d1ddeb@gmail.com>
Date:   Mon, 22 Jun 2020 09:35:50 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <cd8952da-cc55-8087-b9f6-876417beb188@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-06-22 09:32, Frank Rowand wrote:
> On 2020-06-22 03:50, Lee Jones wrote:
>> On Thu, 18 Jun 2020, Frank Rowand wrote:
>>
>>> On 2020-06-15 04:26, Lee Jones wrote:
>>>> On Sun, 14 Jun 2020, Frank Rowand wrote:
>>>>
>>>>> Hi Lee,
>>>>>
>>>>> I'm looking at 5.8-rc1.
>>>>>
>>>>> The only use of OF_MFD_CELL() where the same compatible is specified
>>>>> for multiple elements of a struct mfd_cell array is for compatible
>>>>> "stericsson,ab8500-pwm" in drivers/mfd/ab8500-core.c:
>>>>>
>>>>>         OF_MFD_CELL("ab8500-pwm",
>>>>>                     NULL, NULL, 0, 1, "stericsson,ab8500-pwm"),
>>>>>         OF_MFD_CELL("ab8500-pwm",
>>>>>                     NULL, NULL, 0, 2, "stericsson,ab8500-pwm"),
>>>>>         OF_MFD_CELL("ab8500-pwm",
>>>>>                     NULL, NULL, 0, 3, "stericsson,ab8500-pwm"),
>>>
>>>          OF_MFD_CELL("ab8500-pwm",
>>>                      NULL, NULL, 0, 0, "stericsson,ab8500-pwm"),
>>>
>>>          OF_MFD_CELL_REG("ab8500-pwm-mc",
>>>                          NULL, NULL, 0, 0, "stericsson,ab8500-pwm", 0),
>>>          OF_MFD_CELL_REG("ab8500-pwm-mc",
>>>                          NULL, NULL, 0, 1, "stericsson,ab8500-pwm", 1),
>>>          OF_MFD_CELL_REG("ab8500-pwm-mc",
>>>                          NULL, NULL, 0, 2, "stericsson,ab8500-pwm", 2),
>>>
>>>>>
>>>>> The only .dts or .dtsi files where I see compatible "stericsson,ab8500-pwm"
>>>>> are:
>>>>>
>>>>>    arch/arm/boot/dts/ste-ab8500.dtsi
>>>>>    arch/arm/boot/dts/ste-ab8505.dtsi
>>>>>
>>>>> These two .dtsi files only have a single node with this compatible.
>>>>> Chasing back to .dts and .dtsi files that include these two .dtsi
>>>>> files, I see no case where there are multiple nodes with this
>>>>> compatible.
>>>>>
>>>>> So it looks to me like there is no .dts in mainline that is providing
>>>>> the three "stericsson,ab8500-pwm" nodes that drivers/mfd/ab8500-core.c
>>>>> is expecting.  No case that there are multiple mfd child nodes where
>>>>> mfd_add_device() would assign the first of n child nodes with the
>>>>> same compatible to multiple devices.
>>>>>
>>>>> So it appears to me that drivers/mfd/ab8500-core.c is currently broken.
>>>>> Am I missing something here?
>>>>>
>>>>> If I am correct, then either drivers/mfd/ab8500-core.c or
>>>>> ste-ab8500.dtsi and ste-ab8505.dtsi need to be fixed.
>>>>
>>>> Your analysis is correct.
>>>
>>> OK, if I'm not overlooking anything, that is good news.
>>>
>>> Existing .dts source files only have one "ab8500-pwm" child.  They already
>>> work correcly.
>>>
>>> Create a new compatible for the case of multiple children.  In my example
>>> I will add "-mc" (multiple children) to the existing compatible.  There
>>> is likely a better name, but this lets me provide an example.
>>>
>>> Modify drivers/mfd/ab8500-core.c to use the new compatible, and new .dts
>>> source files with multiple children use the new compatible:
>>>
>>>          OF_MFD_CELL("ab8500-pwm",
>>>                      NULL, NULL, 0, 0, "stericsson,ab8500-pwm"),
>>>
>>>          OF_MFD_CELL_REG("ab8500-pwm-mc",
>>>                          NULL, NULL, 0, 0, "stericsson,ab8500-pwm", 0),
>>>          OF_MFD_CELL_REG("ab8500-pwm-mc",
>>>                          NULL, NULL, 0, 1, "stericsson,ab8500-pwm", 1),
>>>          OF_MFD_CELL_REG("ab8500-pwm-mc",
>>>                          NULL, NULL, 0, 2, "stericsson,ab8500-pwm", 2),
>>>
>>> The "OF_MFD_CELL" entry is the existing entry, which will handle current
>>> .dts source files.  The new "OF_MFD_CELL_REG" entries will handle new
>>> .dts source files.
>>
>> Sorry, but I'm not sure what the above exercise is supposed to solve.
>>
>> Could you explain it for me please?
> 
> The OF_MFD_CELL() entry handles all of the existing .dts source files
> that only have one ab8500-pwm child nodes.  So existing .dtb blobs
> continue to work.
> 
> The OF_MFD_CELL_REG() entries will handle all of the new .dts source
> files that will have up to 3 ab8500-pwm child nodes.
> 
> Compatibility is maintained for existing .dtb files.  A new kernel
> version with the changes will support new .dtb files that contain
> multiple ab8500-pwm child nodes.
> 
>>
>>> And of course the patch that creates OF_MFD_CELL_REG() needs to precede
>>> this change.
>>>
>>> I would remove the fallback code in the existing patch that tries to
>>> handle an incorrect binding.  Just error out if the binding is not
>>> used properly.
>>
>> What fallback code?
> 
> Based on reading the patch description, I expected some extra code to try
> to handle the case where the compatible in more than one struct mfd_cell
> entry is "stericsson,ab8500-pwm" and there are multiple ab8500-pwm child
> nodes.
> 
> Looking at the actual code (which I had not done before), I see that the
> "best effort attempt to match" is keeping a list of child nodes that
> have already been used (mfd_of_node_list) and avoiding re-use of such
> nodes.  This allows an invalid .dtb (one with multple "stericsson,ab8500-pwm"
> child nodes) to possibly be assigned unique child nodes for multiple

> struct mfd_cell entries to be "stericsson,ab8500-pwm".

  struct mfd_cell entries that each have the same compatible value
  "stericsson,ab8500-pwm".

Some day I'll learn how to speak my native language. :-)

-Frank

> 
> So it is confusing for me to call that "fallback code".  It really is
> "best effort attempt to match" for a broken .dtb code.
> 
> There should be no best effort for a broken .dtb.  The broken .dtb should
> instead result in an error.
> 
> -Frank
> 
>>
>>>> Although it's not "broken", it just works when it really shouldn't.
>>>>
>>>> I will be fixing the 'ab8500-pwm' case in due course.
>>>>
>>>>> Moving forward, your proposed OF_MFD_CELL_REG() method seems a good
>>>>> approach (I have not completely read the actual code in the patch yet
>>>>> though).
>>>>
>>>> Thanks.
>>>>
>>>
>>
> 

