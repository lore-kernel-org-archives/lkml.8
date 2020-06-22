Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9F3CC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 14:32:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 890E820720
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 14:32:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m9k+rF8p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729199AbgFVOcL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 10:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728504AbgFVOcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 10:32:10 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE473C061573;
        Mon, 22 Jun 2020 07:32:09 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id 80so3789231qko.7;
        Mon, 22 Jun 2020 07:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TXogEme4bqUxO34K0A3AJrGuAe0dPCNbW8XLwKX6Qak=;
        b=m9k+rF8pl4tsm5fONIgWjlshb3IW8ctO5jsqpqlBPQ0YqAkNSRpw3UVLk8bCRIlKIJ
         0AUHoIhMKUqeaHWF+2nn8qTUPYwSreSrTivhGPbIzHnjTJf1xke2njekTwpa/dkmiADu
         90N3tgjGxzRr5/5y8TVcFK1LtMO2njqltIpHcZF32IprwUBAgzupb8ENbs8r/yw7Bzo2
         tXhv/ggmmo4YnXeWbeLR+Yt72a9ZknXy+xpsB1nYjr4fqBhKDZzD/F2CcJKV/hBk0OIK
         gnX/QXUIawADRS4U5npLyZvBseCy3kZdUQ1/c2LXGk8s0okBIT9vrpQIVWHD2lk2vcX4
         /xwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TXogEme4bqUxO34K0A3AJrGuAe0dPCNbW8XLwKX6Qak=;
        b=l7acBUhBb2hdzjOfNVtzx5ylBxsKvVweQZ4z/wk3IOLea6y9u5dHRs/PaX1DQbUXQV
         ef5m0+NFWKz+fdSwYxjMcBpMH1XohHlJAmwIYMBekeDAgMjTycmLYW8V6/XAGmP+tVl4
         8MVrj4qALtucA1cXSPCqqGJ2+IwrSzzilImey+3a2WzKW0gmUUITDLAtBxiTBg/mQw7r
         ih/EcxfIK3iMbG4Z9M1G6YHVWibd6dw20xqlaBT0aEHVGj+8PLjC+r0jnJMtPM7Y+hah
         I+o+G4l9wn1X0fW0N5jNi0vOTl46d1HsQNZbbsO0HHNbijw/y8A6k+KGxZ8YeY8M+Q7t
         a42w==
X-Gm-Message-State: AOAM532RBqK27fsjtxYhuhdm9ojOrtGXYTozer8QuRJ5HrevnTMeXvuH
        LBIJ8WuKjhrbhtrtkCSpTNQ=
X-Google-Smtp-Source: ABdhPJwLDBKD458Y8D+UaHV/hH4w9aAld11X7aA1o9BInPk5XdG/YAzoocg5QolxXBwl1bHcsaKUug==
X-Received: by 2002:a37:2f43:: with SMTP id v64mr9976403qkh.312.1592836329027;
        Mon, 22 Jun 2020 07:32:09 -0700 (PDT)
Received: from [192.168.1.46] (c-73-88-245-53.hsd1.tn.comcast.net. [73.88.245.53])
        by smtp.gmail.com with ESMTPSA id y23sm8151189qkj.25.2020.06.22.07.32.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jun 2020 07:32:08 -0700 (PDT)
Subject: Re: [PATCH v2 1/3] mfd: core: Make a best effort attempt to match
 devices with the correct of_nodes
To:     Lee Jones <lee.jones@linaro.org>
Cc:     andy.shevchenko@gmail.com, michael@walle.cc, robh+dt@kernel.org,
        broonie@kernel.org, devicetree@vger.kernel.org,
        linus.walleij@linaro.org, linux@roeck-us.net,
        andriy.shevchenko@linux.intel.com, robin.murphy@arm.com,
        gregkh@linuxfoundation.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>
References: <20200611191002.2256570-1-lee.jones@linaro.org>
 <4b188fb5-6667-720d-46e1-6f103efe8966@gmail.com>
 <20200615092644.GA2608702@dell>
 <eef50a78-8571-5600-4fee-c824fd4a7f69@gmail.com>
 <20200622085009.GP954398@dell>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <cd8952da-cc55-8087-b9f6-876417beb188@gmail.com>
Date:   Mon, 22 Jun 2020 09:32:07 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200622085009.GP954398@dell>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-06-22 03:50, Lee Jones wrote:
> On Thu, 18 Jun 2020, Frank Rowand wrote:
> 
>> On 2020-06-15 04:26, Lee Jones wrote:
>>> On Sun, 14 Jun 2020, Frank Rowand wrote:
>>>
>>>> Hi Lee,
>>>>
>>>> I'm looking at 5.8-rc1.
>>>>
>>>> The only use of OF_MFD_CELL() where the same compatible is specified
>>>> for multiple elements of a struct mfd_cell array is for compatible
>>>> "stericsson,ab8500-pwm" in drivers/mfd/ab8500-core.c:
>>>>
>>>>         OF_MFD_CELL("ab8500-pwm",
>>>>                     NULL, NULL, 0, 1, "stericsson,ab8500-pwm"),
>>>>         OF_MFD_CELL("ab8500-pwm",
>>>>                     NULL, NULL, 0, 2, "stericsson,ab8500-pwm"),
>>>>         OF_MFD_CELL("ab8500-pwm",
>>>>                     NULL, NULL, 0, 3, "stericsson,ab8500-pwm"),
>>
>>          OF_MFD_CELL("ab8500-pwm",
>>                      NULL, NULL, 0, 0, "stericsson,ab8500-pwm"),
>>
>>          OF_MFD_CELL_REG("ab8500-pwm-mc",
>>                          NULL, NULL, 0, 0, "stericsson,ab8500-pwm", 0),
>>          OF_MFD_CELL_REG("ab8500-pwm-mc",
>>                          NULL, NULL, 0, 1, "stericsson,ab8500-pwm", 1),
>>          OF_MFD_CELL_REG("ab8500-pwm-mc",
>>                          NULL, NULL, 0, 2, "stericsson,ab8500-pwm", 2),
>>
>>>>
>>>> The only .dts or .dtsi files where I see compatible "stericsson,ab8500-pwm"
>>>> are:
>>>>
>>>>    arch/arm/boot/dts/ste-ab8500.dtsi
>>>>    arch/arm/boot/dts/ste-ab8505.dtsi
>>>>
>>>> These two .dtsi files only have a single node with this compatible.
>>>> Chasing back to .dts and .dtsi files that include these two .dtsi
>>>> files, I see no case where there are multiple nodes with this
>>>> compatible.
>>>>
>>>> So it looks to me like there is no .dts in mainline that is providing
>>>> the three "stericsson,ab8500-pwm" nodes that drivers/mfd/ab8500-core.c
>>>> is expecting.  No case that there are multiple mfd child nodes where
>>>> mfd_add_device() would assign the first of n child nodes with the
>>>> same compatible to multiple devices.
>>>>
>>>> So it appears to me that drivers/mfd/ab8500-core.c is currently broken.
>>>> Am I missing something here?
>>>>
>>>> If I am correct, then either drivers/mfd/ab8500-core.c or
>>>> ste-ab8500.dtsi and ste-ab8505.dtsi need to be fixed.
>>>
>>> Your analysis is correct.
>>
>> OK, if I'm not overlooking anything, that is good news.
>>
>> Existing .dts source files only have one "ab8500-pwm" child.  They already
>> work correcly.
>>
>> Create a new compatible for the case of multiple children.  In my example
>> I will add "-mc" (multiple children) to the existing compatible.  There
>> is likely a better name, but this lets me provide an example.
>>
>> Modify drivers/mfd/ab8500-core.c to use the new compatible, and new .dts
>> source files with multiple children use the new compatible:
>>
>>          OF_MFD_CELL("ab8500-pwm",
>>                      NULL, NULL, 0, 0, "stericsson,ab8500-pwm"),
>>
>>          OF_MFD_CELL_REG("ab8500-pwm-mc",
>>                          NULL, NULL, 0, 0, "stericsson,ab8500-pwm", 0),
>>          OF_MFD_CELL_REG("ab8500-pwm-mc",
>>                          NULL, NULL, 0, 1, "stericsson,ab8500-pwm", 1),
>>          OF_MFD_CELL_REG("ab8500-pwm-mc",
>>                          NULL, NULL, 0, 2, "stericsson,ab8500-pwm", 2),
>>
>> The "OF_MFD_CELL" entry is the existing entry, which will handle current
>> .dts source files.  The new "OF_MFD_CELL_REG" entries will handle new
>> .dts source files.
> 
> Sorry, but I'm not sure what the above exercise is supposed to solve.
> 
> Could you explain it for me please?

The OF_MFD_CELL() entry handles all of the existing .dts source files
that only have one ab8500-pwm child nodes.  So existing .dtb blobs
continue to work.

The OF_MFD_CELL_REG() entries will handle all of the new .dts source
files that will have up to 3 ab8500-pwm child nodes.

Compatibility is maintained for existing .dtb files.  A new kernel
version with the changes will support new .dtb files that contain
multiple ab8500-pwm child nodes.

> 
>> And of course the patch that creates OF_MFD_CELL_REG() needs to precede
>> this change.
>>
>> I would remove the fallback code in the existing patch that tries to
>> handle an incorrect binding.  Just error out if the binding is not
>> used properly.
> 
> What fallback code?

Based on reading the patch description, I expected some extra code to try
to handle the case where the compatible in more than one struct mfd_cell
entry is "stericsson,ab8500-pwm" and there are multiple ab8500-pwm child
nodes.

Looking at the actual code (which I had not done before), I see that the
"best effort attempt to match" is keeping a list of child nodes that
have already been used (mfd_of_node_list) and avoiding re-use of such
nodes.  This allows an invalid .dtb (one with multple "stericsson,ab8500-pwm"
child nodes) to possibly be assigned unique child nodes for multiple
struct mfd_cell entries to be "stericsson,ab8500-pwm".

So it is confusing for me to call that "fallback code".  It really is
"best effort attempt to match" for a broken .dtb code.

There should be no best effort for a broken .dtb.  The broken .dtb should
instead result in an error.

-Frank

> 
>>> Although it's not "broken", it just works when it really shouldn't.
>>>
>>> I will be fixing the 'ab8500-pwm' case in due course.
>>>
>>>> Moving forward, your proposed OF_MFD_CELL_REG() method seems a good
>>>> approach (I have not completely read the actual code in the patch yet
>>>> though).
>>>
>>> Thanks.
>>>
>>
> 

