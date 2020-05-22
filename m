Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C71D5C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 11:18:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F383206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 11:18:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rNWZvqeB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729511AbgEVLS4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 07:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728371AbgEVLSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 07:18:54 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99F00C061A0E
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 04:18:54 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id w7so9748273wre.13
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 04:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PQaA1BXYGXEU/4e3RtmxbwANUSTglo0skacPQ+pmgxs=;
        b=rNWZvqeB6A5nA7+Z1yTMGU8mzlDIgg4uplcVi8fj3kKiSADOqIIczSCATeGDPRLKcF
         7BSUaN1EtpHxUAxGdW6Oh4kth+1JYtYpFqFuW8eNIJOJELl7UQiA9O3z03H3S8Sz/bQR
         qtaOPo1ZpXfCXc3w7eE5WjxpKX6stD26UJyJVnhIWv2svY1BdLf2yDDeBQ0Dm9LK7FUc
         4B972qWpS+82wRpdRo6mLAISyn6rqT4w8Lxz1pQNtcYgH6RKj9I9UxQNrJDFubCSHYDv
         ZiQhtLJwk1Sabv2wcAiigL3OHYS3wCOh9TPkM5q9DL1LWZs8c3Fo2Jry6Sct0JpZNDE1
         9IGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PQaA1BXYGXEU/4e3RtmxbwANUSTglo0skacPQ+pmgxs=;
        b=B+aNxeo3GkszJ/1BZtQ4t3HZwQt5ARNTG4OEYzH9SSAUJpntJwWWILXYxc5IJhKplL
         ExE+1XWdjXKrInWyPDfJX0f0wZiZezw65I1u5xUicoEMb0kXBRVrXF6pK+L+lNUo6N5V
         8foBV0+l75VVVl7rFJpvjDkk5Hs39vp5oBzWTmcWMIsyxXlXThW4hGVD5ONJKXCKawih
         sU5oV+JYXMGAME8f69kwDmUMbNv7vv0xH9ox86DjMdxfLKsHc8S3BTmYxrojkW2zgy4C
         CoN+tRNx888U03SeFikUDfCO1N31CjakyxMpQlMuLigUAOxM8vZ3NsNUtTaE6JVrZSwT
         eIBw==
X-Gm-Message-State: AOAM5329jSCxUQVqJwc+nsyD1FzmxbKEJLCjIwi9k+zL3+RLtZ71Xumt
        968MsoV90hV3jyHYRLtRJjh3DA==
X-Google-Smtp-Source: ABdhPJyYN68epObRtqyyXcfRBHrRRbZLoLE6Sd1BSLbux5sR05wl6ZElgF70Uxpj1Yh45EDLgZi3og==
X-Received: by 2002:adf:df0e:: with SMTP id y14mr3032945wrl.6.1590146333170;
        Fri, 22 May 2020 04:18:53 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id u7sm3654218wrm.23.2020.05.22.04.18.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 May 2020 04:18:52 -0700 (PDT)
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
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <871dd2c1-4b16-f883-b8c5-806a0df1edf8@linaro.org>
Date:   Fri, 22 May 2020 12:18:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAD=FV=XbbUkeSwvcverBS8t6BCHuw3UT0_KYfx9LFGqmZyY2hA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21/05/2020 22:28, Doug Anderson wrote:
> Hi,
> 
> On Thu, May 21, 2020 at 8:56 AM Srinivas Kandagatla
> <srinivas.kandagatla@linaro.org> wrote:
>>
>> On 21/05/2020 16:10, Doug Anderson wrote:
>>>> On 20/05/2020 23:48, Doug Anderson wrote:
>>>>>> Is this only applicable for corrected address space?
>>>>> I guess I was proposing a two dts-node / two drive approach here.
>>>>>
>>>>> dts node #1:just covers the memory range for accessing the FEC-corrected data
>>>>> driver #1: read-only and reads the FEC-corrected data
>>>>>
>>>>> dts node #2: covers the memory range that's_not_  the FEC-corrected
>>>>> memory range.
>>>>> driver #2: read-write.  reading reads uncorrected data
>>>>>
>>>>> Does that seem sane?
>>>> I see your point but it does not make sense to have two node for same thing.
>>> OK, so that sounds as if we want to go with the proposal where we
>>> "deprecate the old driver and/or bindings and say that there really
>>> should just be one node and one driver".
>>>
>>> Would this be acceptable to you?
>>>
>>> 1. Officially mark the old bindings as deprecated.
>>
>> Possibly Yes for some reasons below!
>>
>>>
>>> 2. Leave the old driver there to support the old deprecated bindings,
>>> at least until everyone can be transferred over.  There seem to be
>>> quite a few existing users of "qcom,qfprom" and we're supposed to make
>>> an attempt at keeping the old device trees working, at least for a
>>> little while.  Once everyone is transferred over we could decide to
>>> delete the old driver.
>> we could consider "qcom,qfrom" to be only passing corrected address
>> space. Till we transition users to new bindings!
>>
>>>
>> Yes.
>>
>>> 3. We will have a totally new driver here.
>> No, we should still be using the same driver. But the exiting driver
>> seems to incorrect and is need of fixing.
>>
>> Having a look at the memory map for old SoCs like msm8996 and msm8916
>> shows that memory map that was passed to qfprom driver is corrected
>> address space. Writes will not obviously work!
>>
>> This should also be true with sdm845 or sc7180
>>
>> That needs to be fixed first!
> 
> OK, so to summarize:
> 

> 1. We will have one driver: "drivers/nvmem/qfprom.c"

Yes, we should one driver for this because we are dealing with exactly 
same IP.

> 
> 2. If the driver detects that its reg is pointing to the corrected
> address space then it should operate in read-only mode.  Maybe it can
> do this based on the compatible string being just "qcom,qfprom" or
> maybe it can do this based on the size of the "reg".

I found out that there is a version register at offset of 0x6000 which 
can give MAJOR, MINOR and STEP numbers.

So we could still potentially continue using "qcom,qfprom"

The address space can be split into 3 resources, which is inline with 
Specs as well

1. Raw address space ("raw")
2. Configuration address space ("conf" or "core")
3. Corrected address space ("corrected")

Exiting qfprom entries or read-only qfprom  will have "corrected" 
address space which can be the only resource provided by device tree 
entries.
Other two entries("raw" and "conf") are optional.

qfprom: qfprom@780000 {
         compatible = "qcom,qfprom";
	reg = <0 0x00780000 0 0x8ff>,
		<0 0x00782000 0 0x100>,
		<0 0x00784000 0 0x8ff>;
	reg-names = "raw", "conf", "corrected";

	vcc-supply = <&vreg_xyz>;

	clocks = <&gcc GCC_SEC_CTRL_CLK_SRC>;
	clock-names = "secclk";

	assigned-clocks = <&gcc GCC_SEC_CTRL_CLK_SRC>;
         assigned-clock-rates = <19200000>;

	qcom,fuse-blow-frequency = <4800000>

         #address-cells = <1>;
         #size-cells = <1>;

	qusb2p_hstx_trim: hstx-trim-primary@25b {
		reg = <0x25b 0x1>;
		bits = <1 3>;
	};
};

Regarding clk rate setting, the default rate can be set using 
assigned-clock-rates property, however the blow frequency can go as new 
binding.
regarding voltage range for regulator, it should come as part of board 
specific voltage regulator node. In worst case we can discuss on adding 
new bindings for allowing specific range.

for Older SoCs: we still continue to use old style with just one 
resource corresponding to corrected by default.

qfprom: qfprom@784000 {
         compatible = "qcom,qfprom";
         reg = <0 0x00784000 0 0x8ff>;
         #address-cells = <1>;
         #size-cells = <1>;

         qusb2p_hstx_trim: hstx-trim-primary@1eb {
                 reg = <0x1eb 0x1>;
                 bits = <1 4>;
         };

         qusb2s_hstx_trim: hstx-trim-secondary@1eb {
                 reg = <0x1eb 0x2>;
                 bits = <6 4>;
         };
};


I see the patch as adding write support to qfprom, rather than adding 
new driver or new SoC support.

This in summary should give us good direction for this patch!

Correct me if I miss understood something here!


Thanks,
srini

> 
> 3. If that driver sees a newer compatible string (one that includes
> the SoC name in it) it will assume that its "reg" points to the start
> of qfprom space.
> 
> 4. We should post patches to transition all old dts files away from
> the deprecated bindings.
> 
> 
>>> 4. A given device tree will_not_  be allowed to have both
>>> "qcom,qfprom" specified and "qcom,SOC-qfprom" specified.  ...and by
>>> "qcom,SOC-qfprom" I mean that SOC should be replaced by the SoC name,
>>> so "qcom,sc7180-qfprom" or "qcom,sdm845-qfprom".  So once you switch
>>> to the new node it replaces the old node.
>>
>> Secondly, this IP is clearly an integral part of Secure Control Block,
>> which clearly has versioning information.
>>
>> Versioning information should be part of compatible string in msm8996 it
>> should be "qcom,qfprom-5.1.0"
>> for msm8916 it should be "qcom,qfprom-4.0.0" this translates to
>> "qcom,qfprom-<MAJOR-NUMBER>-<MINOR-NUMBER>-<STEP>"
> 
> I don't know much about this versioning info, but I'm curious: can we
> read it from the chip?  If so then it actually _doesn't_ need to be in
> the compatible string, I think.  Device tree shouldn't include things
> that can be probed.  So if this can be probed then maybe we could have
> the compatible as:
> 
> compatible = "qcom,msm8996-qfprom", "qcom,qfprom"
> 
> ...where the SoC is there just in case we need it but we'd expect to
> just match on "qcom,qfprom" and then probe.
> 
> 
> If this can't be probed then having the version info is nice, so then
> I guess you'd have the compatible string:
> 
> compatible = "qcom,msm8996-qfprom", "qcom,qfprom-5.1.0"
> 
> ...where (again) you'd have the SoC specific string there just in case
> but you'd expect that you could just use the generic string.
> 
> 
> Does that sound right?
> 
> 
>> Thirdly we should be able to have common read for all these as they tend
>> to just read from corrected address space.
>>
>> Offsets to corrected address space seems to always constant across SoCs too.
>>
>> platform specific device tree nodes should also be able to specify
>> "read-only" property to not allow writes on to this raw area.
> 
> Yeah, I was thinking we probably wanted a read-only property.  That
> sounds sane to me.
> 
> 
> -Doug
> 
