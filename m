Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D5A0C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 14:35:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBF9C2070A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 14:35:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gMB3dIrK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbgETOf2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 10:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726443AbgETOf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 10:35:27 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E79EC061A0F
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 07:35:26 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id l18so3395204wrn.6
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 07:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DFoNYpMUYo51+NmcYVvrMZ3MPx9S36R6KDYc+bOo7Ms=;
        b=gMB3dIrKvXM5blrXc0IvCPshQmW897nI/fQ6Z4uVl39cB25Mjhn1lhIWckFXNyW9jY
         mPoWYvJ6S+Ow8OMdz9Rd5VdXgz5V9mcpqDmc1aRY5FARjWyOp4jNjd4r/0wB2iM3kumY
         KTFlEssWtQVheNeNL9+fUFB6eTr2mWhW02hWCj+HbJ1dzi9/ZjV2Wv0zKe2RvE2NPW1x
         DFrnZqw/f2le/D+RpaMI45oVt/bgkrE2pvMarf64PFQWO9trtsYx7Sut0okgeMWh/5lK
         l70adAwUAISQG3mcY7UKqmpLqYNnxXwT6edE24uWoIea9rUyEoapQ35Yfo4LFMD+HvzK
         NRKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DFoNYpMUYo51+NmcYVvrMZ3MPx9S36R6KDYc+bOo7Ms=;
        b=bd2+wlCCgE4AeU66eRV12vf7cf0cOdG7IVKqdUue5idM/dBCbUBDpJ6CINzkKObexe
         b334Sa/O/40TlQ83Fy3P5aIkH7govDXvz1SyVuNodY4n7OmTN52nKOm75GJlCGsEP5qo
         Ya6KfjjB0zCoL1pxB6pGPfgom0nYA3WR22ribBEPwutbjvl5DQeexouMRvOMJHbV3D4x
         Fp8qi49KVrHfw24wMsChFwIyrfa7W1EG1tshc8k4X9DIyd5ueHGiKssxByPwX6Dpwb9w
         2RCq6pWAihbnqDMZVhNtJt7MmYmKUy955xzogp700Mm+3KydSB1AG3Fr9/xq33JK/fLT
         3JaA==
X-Gm-Message-State: AOAM532EZCJ4EHVBZzkkLPymPKWqEH7vXRC9mv0VCZB7m6ejFEATy+lN
        2XZGi4StFMh56v8DhbeWVSjcRw==
X-Google-Smtp-Source: ABdhPJzaQJCyStXWwEJX5MaAJCVaX6UZKbeeFGmVkNn1wTrVqS/Tz21ueG9lqeJl80eCdBr1oo61Rw==
X-Received: by 2002:adf:d0d1:: with SMTP id z17mr4771072wrh.175.1589985325340;
        Wed, 20 May 2020 07:35:25 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id w13sm3019016wrm.28.2020.05.20.07.35.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 May 2020 07:35:24 -0700 (PDT)
Subject: Re: [RFC v1 2/3] drivers: nvmem: Add driver for QTI qfprom-efuse
 support
To:     Doug Anderson <dianders@chromium.org>
Cc:     "Ravi Kumar Bokka (Temp)" <rbokka@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        dhavalp@codeaurora.org, mturney@codeaurora.org,
        sparate@codeaurora.org, c_rbokka@codeaurora.org,
        mkurumel@codeaurora.org
References: <1589307480-27508-1-git-send-email-rbokka@codeaurora.org>
 <1589307480-27508-3-git-send-email-rbokka@codeaurora.org>
 <ffaccce7-95c0-2f95-ad3b-55f1da42eaee@linaro.org>
 <14e1fa51-066c-6e1b-01a4-2103612de9e9@codeaurora.org>
 <d5902226-21b3-7941-6405-688d7a115142@linaro.org>
 <b80aaca0-0594-e04b-5320-b5b3c4478161@codeaurora.org>
 <d76e4eb2-fa6a-0b76-3912-83bce678bc96@linaro.org>
 <CAD=FV=XW7GymV_pr_0SvUPWwL6WnPhqMq-crq-RbR_us3-ShNA@mail.gmail.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <9864496c-b066-3fe8-5608-bd9af69663f4@linaro.org>
Date:   Wed, 20 May 2020 15:35:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAD=FV=XW7GymV_pr_0SvUPWwL6WnPhqMq-crq-RbR_us3-ShNA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18/05/2020 19:31, Doug Anderson wrote:
> Hi,
> 
> On Mon, May 18, 2020 at 3:45 AM Srinivas Kandagatla
> <srinivas.kandagatla@linaro.org> wrote:
>>
>> On 18/05/2020 11:39, Ravi Kumar Bokka (Temp) wrote:
>>>
>>> Based on the compatible, do i need to separate probe function for
>>> qfprom-efuse and maintain separate nvmem object to register nvmem
>>> framework. Is this what you are suggesting to implementing this in to
>>> one existing driver?
>>
>> Yes for same driver we should add new compatible string and add support
>> to this in existing qfprom driver.
>> Ideally we should allocate nvmem_config object at probe with different
>> parameters based on compatible string.
> 
> I wish I had better documentation for exactly what was in the SoC
> instead of the heavily redacted stuff Qualcomm provides.  Really the
> answer here is: how do you best describe the hardware?  OK, so I just
> spent the past hour or so trying to patch together all the bits and
> fragments that Qualcomm provided me.  Just like a scavenger hunt!
> Fun!  The best I can patch together is that there is a single QFPROM
> with these ranges:
> 
> 0x00780000 - 0x007800FF
> QFPROM HW registers, range 1/2
> 
> 0x00780120 - 0x007808FF
> QFPROM "raw" space
> 

so this is the only region is the QFPROM fuses can be programmed!

> 0x00782000 - 0x007820FF
> QFPROM HW registers, range 2/2
> 
> 0x00784120 - 0x007848FF
> QFPROM "corrected" space

Is this some kind of FEC corrected regions?


> 
> 0x00786000 - 0x00786FFF
> QFPROM memory range that I don't really understand and maybe we don't
> worry about right now?

> 
> Did I get that right?  If so, is there a prize for winning the scavenger hunt?
> 
> ---
> 
> If so then, IMO, it wouldn't be insane to actually keep it as two
> drivers and two device tree nodes, as you've done.  I'd defer to
> Srinivas and Rob Herring, though.  The existing driver would be a
> read-only driver and provide access to the "corrected" versions of all
> the registers.  Its node would have "#address-cells = <1>" and
> "#size-cells = <1>" because it's expected that other drivers might
> need to refer to data stored here.
> 
> Your new driver would be read-write and provide access to the "raw"
> values.  A read from your new driver would not necessarily equal a
> read from the old driver if the FEC (forward error correction) kicked

Is this only applicable for corrected address space?

> in.  Other drivers should never refer to the non-corrected values so
> you wouldn't have "#address-cells" and "#size-cells".  The only way to
> really read or write it would be through sysfs.
> 
> It would be super important to document what's happening, of course.
> ...and ideally name them to make it clearer too.
> 
> ---
> 
> Another alternative (if Srinivas and/or Rob H prefer it) would be to
> deprecate the old driver and/or bindings and say that there really
> should just be one node and one driver.  In that case you'd replace
> the old node with:
> 
> qfprom@780000 {
>    compatible = "qcom,sc7180-qfprom-efuse";

May be "qcom,sc7180-qfprom"


>    reg = <0 0x00780000 0 0x6fff>;
>    #address-cells = <1>;
>    #size-cells = <1>;
> 
>    clocks = <&gcc GCC_SEC_CTRL_CLK_SRC>;
>    clock-names = "sec";
> 
>    qusb2p_hstx_trim: hstx-trim-primary@25b {
>      reg = <0x25b 0x1>;
>      bits = <1 3>;
>    };
> };
> 
> You'd use the of_match_table solution to figure out the relevant
> offsets (0x120, 0x2000, 0x4120, 0x6000) for sc7180 and this new driver
> would be responsible for being able to read the corrected values and


Encompassing these offsets in driver as part of the register defines 
itself should be a good start!

It will also be nice to understand how similar this thing is with w.rt 
other Qcom SoCs?


> also for programming.  In this case I'm not sure how (assuming it's
> valuable) you'd provide read access to the uncorrected data.
I will leave this question to the author of the driver.

--srini

> 
> 
> -Doug
> 
