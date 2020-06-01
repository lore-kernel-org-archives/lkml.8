Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C573CC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 09:25:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A06D7206A4
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 09:25:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S4URR1x2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbgFAJZA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 05:25:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725290AbgFAJY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 05:24:59 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DB07C061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 02:24:59 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id c3so10676561wru.12
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 02:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=c6xSikhGKkfptbh/HXNSApAtmH7NCDX83zLJZkiINCI=;
        b=S4URR1x2RZfJNvQahQAbvB9xHndSlhMl/Ts/G+pFspHQ1j24DFpgC8JmnhBNRdM5tw
         D6iI9vNeS7p+BJT0gWbECb92TvWmw5GQePbtcj3gDrULU8AT+x4akP9jZN9cZxkAo98a
         vGYX1V14VNxB/578GLM3/Hc3+R7arZkbj2O3SA8sCpTmQBlwo9tZBnhkmMCcspy01nXs
         T0IuT1k7nuuvJ7Rn4q/5GtweSOE9zkkHeZeGEiBoC+H728DqG+MYYh5x3AExKJql5skr
         1oQz7yFPyBxn8SJDDwyR2llrG3J8FfATChAEb6U9F3DLHIymqjVp/9EbX1sWg5m7oaFN
         1WKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=c6xSikhGKkfptbh/HXNSApAtmH7NCDX83zLJZkiINCI=;
        b=TIKqat8NqivsI2WMyT1DqLEFjPVxLJkrboYo/mSxI0VtaFuevzhH03NdcHpSBGMOlc
         QNKSnCcMpsXMHgrf6SZlFyrhiSnVQP/fe1TsBsl6xMS2sbHmBRW4D0o8p1s4Ag1MUZ02
         DXuNOsoRNhJoFnyN7g9Rf2rVEjrTySgmyZ65BTgYRau2XiC2i+x9YG7q126VxgC7bfpX
         iqrhC5kpOI2srxb9C8txVk8v/No82SZVpl0VGFYgM0w8mzWn5JZPWsvMewspoMvX5Mcd
         R32Gm4Fcu3vfeM62hc7ZErVvw6hKFQb7qz3xF4SkalpDMFqiqUM2JqEFcGpb2URXY5fS
         JDqQ==
X-Gm-Message-State: AOAM532yv0W/ZB0TajrV8W319m7DOWHuMDFW5YDYpX3174O7HyOMdW+B
        FfMdbuwfaRrkTDNNaUehRAOP2Q==
X-Google-Smtp-Source: ABdhPJxqNj0yEnBLbGzNsbsBZ6rl7H1dfx84b1Emoz7Lpp2LeWwbLhxxlqi7T4u49RYcQ7xQl5KFMA==
X-Received: by 2002:adf:d84c:: with SMTP id k12mr20921780wrl.265.1591003497710;
        Mon, 01 Jun 2020 02:24:57 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id j68sm20808466wrj.28.2020.06.01.02.24.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Jun 2020 02:24:56 -0700 (PDT)
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
 <9864496c-b066-3fe8-5608-bd9af69663f4@linaro.org>
 <CAD=FV=UbZPQ74COXJbOikq9Wcx1UvtuMuMA+nqkx44uySoqggg@mail.gmail.com>
 <99f07eaa-d072-f391-098e-e6f7a50a1960@linaro.org>
 <CAD=FV=W+UES1f3reMhvPPUho5FbaZXdU-2jkRaPcbBEzDWT+WQ@mail.gmail.com>
 <9ecb5790-47fe-583b-6fc3-8f4f3ce7860e@linaro.org>
 <CAD=FV=XbbUkeSwvcverBS8t6BCHuw3UT0_KYfx9LFGqmZyY2hA@mail.gmail.com>
 <871dd2c1-4b16-f883-b8c5-806a0df1edf8@linaro.org>
 <CAD=FV=UCwUO5aKrUj7e+v6Bpkh_O+wuSXD5tJHdGOfaVTL0t1w@mail.gmail.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <1211660e-f1b0-0636-2dcf-1bc765118de3@linaro.org>
Date:   Mon, 1 Jun 2020 10:24:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAD=FV=UCwUO5aKrUj7e+v6Bpkh_O+wuSXD5tJHdGOfaVTL0t1w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 26/05/2020 23:31, Doug Anderson wrote:
> Hi,
> 
> On Fri, May 22, 2020 at 4:18 AM Srinivas Kandagatla
> <srinivas.kandagatla@linaro.org> wrote:
>>
>> On 21/05/2020 22:28, Doug Anderson wrote:
>>> Hi,
>>>
>>> On Thu, May 21, 2020 at 8:56 AM Srinivas Kandagatla
>>> <srinivas.kandagatla@linaro.org> wrote:
>>>>
>>>> On 21/05/2020 16:10, Doug Anderson wrote:
>>>>>> On 20/05/2020 23:48, Doug Anderson wrote:
>>>>>>>> Is this only applicable for corrected address space?
>>>>>>> I guess I was proposing a two dts-node / two drive approach here.
>>>>>>>
>>>>>>> dts node #1:just covers the memory range for accessing the FEC-corrected data
>>>>>>> driver #1: read-only and reads the FEC-corrected data
>>>>>>>
>>>>>>> dts node #2: covers the memory range that's_not_  the FEC-corrected
>>>>>>> memory range.
>>>>>>> driver #2: read-write.  reading reads uncorrected data
>>>>>>>
>>>>>>> Does that seem sane?
>>>>>> I see your point but it does not make sense to have two node for same thing.
>>>>> OK, so that sounds as if we want to go with the proposal where we
>>>>> "deprecate the old driver and/or bindings and say that there really
>>>>> should just be one node and one driver".
>>>>>
>>>>> Would this be acceptable to you?
>>>>>
>>>>> 1. Officially mark the old bindings as deprecated.
>>>>
>>>> Possibly Yes for some reasons below!
>>>>
>>>>>
>>>>> 2. Leave the old driver there to support the old deprecated bindings,
>>>>> at least until everyone can be transferred over.  There seem to be
>>>>> quite a few existing users of "qcom,qfprom" and we're supposed to make
>>>>> an attempt at keeping the old device trees working, at least for a
>>>>> little while.  Once everyone is transferred over we could decide to
>>>>> delete the old driver.
>>>> we could consider "qcom,qfrom" to be only passing corrected address
>>>> space. Till we transition users to new bindings!
>>>>
>>>>>
>>>> Yes.
>>>>
>>>>> 3. We will have a totally new driver here.
>>>> No, we should still be using the same driver. But the exiting driver
>>>> seems to incorrect and is need of fixing.
>>>>
>>>> Having a look at the memory map for old SoCs like msm8996 and msm8916
>>>> shows that memory map that was passed to qfprom driver is corrected
>>>> address space. Writes will not obviously work!
>>>>
>>>> This should also be true with sdm845 or sc7180
>>>>
>>>> That needs to be fixed first!
>>>
>>> OK, so to summarize:
>>>
>>
>>> 1. We will have one driver: "drivers/nvmem/qfprom.c"
>>
>> Yes, we should one driver for this because we are dealing with exactly
>> same IP.
>>
>>>
>>> 2. If the driver detects that its reg is pointing to the corrected
>>> address space then it should operate in read-only mode.  Maybe it can
>>> do this based on the compatible string being just "qcom,qfprom" or
>>> maybe it can do this based on the size of the "reg".
>>
>> I found out that there is a version register at offset of 0x6000 which
>> can give MAJOR, MINOR and STEP numbers.
>>
>> So we could still potentially continue using "qcom,qfprom"
> 
> OK, sounds good.  I think it's still good practice to include both the
> SoC specific and the generic.  Even if the driver never does anything
> with the SoC-specific compatible string it doesn't hurt to have it
> there.  Thus, we'd want:
> 
> compatible = "qcom,msm8996-qfprom", "qcom,qfprom"
> 
> The driver itself would never need to refer to the SoC-specific name
> but that does give us more flexibility.
> 
> 
>> The address space can be split into 3 resources, which is inline with
>> Specs as well
>>
>> 1. Raw address space ("raw")
>> 2. Configuration address space ("conf" or "core")
>> 3. Corrected address space ("corrected")
> 
> Sure, this is OK with me then.  Originally Ravi had 3 ranges but then
> he was (in the driver) treating it as one range.  As long as the
> driver truly treats it as 3 ranges I have no problem doing it like
> this.
> 
> In general, over the years, there has been a push to keep
> implementation details out of the dts and rely more on the "of_match"
> table to add SoC-specific details.  This becomes really important when
> 1 year down the road you realize that you need one more random
> property or address range to fix some bug and then you need to figure
> out how to try to keep old "dts" files compatible.  It's not a
> hard-and-fast rule, though.

Am not 100% sure if "qcom,fuse-blow-frequency" is something integration 
specific or SoC Specific, My idea was that this will give more 
flexibility in future. As adding new SoC Support does not need driver 
changes.

Having said that, Am okay either way!
Incase we go compatible way, I would like to see compatible strings 
having proper IP versions to have ip version rather than SoC names.

Having SoC names in compatible string means both driver and bindings 
need update for every new SoC which can be overhead very soon!

Rob can help review once we have v2 bindings out!

> 
> 
>> Exiting qfprom entries or read-only qfprom  will have "corrected"
>> address space which can be the only resource provided by device tree
>> entries.
>> Other two entries("raw" and "conf") are optional.
>>
>> qfprom: qfprom@780000 {
>>           compatible = "qcom,qfprom";
>>          reg = <0 0x00780000 0 0x8ff>,
>>                  <0 0x00782000 0 0x100>,
>>                  <0 0x00784000 0 0x8ff>;
>>          reg-names = "raw", "conf", "corrected";
>>
>>          vcc-supply = <&vreg_xyz>;
>>
>>          clocks = <&gcc GCC_SEC_CTRL_CLK_SRC>;
>>          clock-names = "secclk";
>>
>>          assigned-clocks = <&gcc GCC_SEC_CTRL_CLK_SRC>;
>>           assigned-clock-rates = <19200000>;
>>
>>          qcom,fuse-blow-frequency = <4800000>
>>
>>           #address-cells = <1>;
>>           #size-cells = <1>;
>>
>>          qusb2p_hstx_trim: hstx-trim-primary@25b {
>>                  reg = <0x25b 0x1>;
>>                  bits = <1 3>;
>>          };
>> };
>>
>> Regarding clk rate setting, the default rate can be set using
>> assigned-clock-rates property, however the blow frequency can go as new
>> binding.
>> regarding voltage range for regulator, it should come as part of board
>> specific voltage regulator node. In worst case we can discuss on adding
>> new bindings for allowing specific range.
> 
> I'd up to you (and Rob H, who probably will wait for the next rev of
> the binding before chiming in) but the "qcom,fuse-blow-frequency" is
> the type of property that feels better in the driver and achieved from
> the of_match table.  Then you don't need to worry about adding it to
> the bindings.  Voltage (if needed) would be similar, but I would hope
> we don't need it.
> 
> 
>> for Older SoCs: we still continue to use old style with just one
>> resource corresponding to corrected by default.
>>
>> qfprom: qfprom@784000 {
>>           compatible = "qcom,qfprom";
>>           reg = <0 0x00784000 0 0x8ff>;
>>           #address-cells = <1>;
>>           #size-cells = <1>;
>>
>>           qusb2p_hstx_trim: hstx-trim-primary@1eb {
>>                   reg = <0x1eb 0x1>;
>>                   bits = <1 4>;
>>           };
>>
>>           qusb2s_hstx_trim: hstx-trim-secondary@1eb {
>>                   reg = <0x1eb 0x2>;
>>                   bits = <6 4>;
>>           };
>> };
>>
>>
>> I see the patch as adding write support to qfprom, rather than adding
>> new driver or new SoC support.
>>
>> This in summary should give us good direction for this patch!
>>
>> Correct me if I miss understood something here!
> 
> Sounds sane to me.

Cool! lets see how v2 will endup like!

--srini
> 
> 
> -Doug
> 
