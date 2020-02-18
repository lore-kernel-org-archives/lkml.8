Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14EE1C34040
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 14:48:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA17020658
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 14:48:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B0a4incY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbgBROsM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 09:48:12 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38096 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726667AbgBROsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 09:48:11 -0500
Received: by mail-wm1-f66.google.com with SMTP id a9so3214974wmj.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 06:48:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BRsmd+nJRBqiO0UVP+1rIxeSyPLLEYBByX1n2Ouuk+0=;
        b=B0a4incYG46ULAS3He56W1WJHbusdfxsFhgZ8ochxdPDdlVr/gSJJJP43eudvN8aIS
         yyJT7gsetwiKMLeBiGGI9alFGqJVRgEniHCi7JD0JEPnB/Vvzb1GcIRQtlWQaP1AlJjW
         iFpi1LSgjTPyWaAC/zSAz6TikRiEkPMfWd2s3ase82+ISGRmC1B2F2Jh3eSP3xmfk5FC
         ITn5BEMmQkcJ1Ra+cgKTIbq0U9KrhueUs058DRksIrijYaicdoa9tEXFnyUTc3D3jlyW
         MGy6fOhYs0/TLcFGuqSzwVPZple98XL9WHd6bmwgMD0NkCGFB+dWL2vevFSAxIXvYXqC
         foZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BRsmd+nJRBqiO0UVP+1rIxeSyPLLEYBByX1n2Ouuk+0=;
        b=caN4XKfH1Q48ShAn7bSBGkLpu3lEoHuPfknYCQM2RrOXGrGqIqOIySFXgG5Ki1jSXL
         b0R4bRD5btlLoXWTD6VZ3iXBu0wB6kHp4vit8db2+SeH6RM/zRCwv0FJ1/3Ak8726tcl
         JY6TJP8CRN8++ZrHWhHWDt1hDC/NRMyTGx8mZTbJvSbj5KcHh8GHP/7sRFtuHbOErxy9
         qTk/yoPdFjSmxA2hKGycpHSoIE1iMirJRCdHXEp2eS3osIi/lawUFq4cxNrd1qnjIOGQ
         SFIyNldwsHDrxFzlF2hxgmEDvMvAHtC6pzlahwXmHAc51i2W59+Fe7TY/mdJuki+c2ez
         +GNA==
X-Gm-Message-State: APjAAAXn4ZRAjw3i6GDp2G8V6XsqHmqxOcxex7jxLDzaFl0jmn1JF2KC
        m1Yq7RAFSlGRNX/mdfmY54OLjg==
X-Google-Smtp-Source: APXvYqz8FjJ/isZ29SxNHhkGEO8YebWRzu952yOfgt/LpaxpcIdR5rRWMH8k1WDdUQNchignN2uQHw==
X-Received: by 2002:a1c:4c0c:: with SMTP id z12mr3548617wmf.63.1582037288879;
        Tue, 18 Feb 2020 06:48:08 -0800 (PST)
Received: from [192.168.0.38] ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id z21sm3751179wml.5.2020.02.18.06.48.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2020 06:48:08 -0800 (PST)
Subject: Re: [PATCH v4 2/2] Embedded USB Debugger (EUD) driver
To:     "Dwivedi, Avaneesh Kumar (avani)" <akdwived@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ckadabi@codeaurora.org, tsoni@codeaurora.org,
        bryanh@codeaurora.org, psodagud@codeaurora.org,
        rnayak@codeaurora.org, satyap@codeaurora.org,
        pheragu@codeaurora.org
References: <1580445811-15948-1-git-send-email-akdwived@codeaurora.org>
 <1580445811-15948-3-git-send-email-akdwived@codeaurora.org>
 <20200203193533.GL3948@builder>
 <5008a446-a90c-b68a-aaa4-3e7cd90418fa@linaro.org>
 <d09f8a1d-0544-838f-e6f8-1c47f58e4f1f@codeaurora.org>
 <8a854c02-7435-46c6-5bd1-05273e5249e4@linaro.org>
 <aa942701-d11b-dcf2-d28f-144582af0d2f@codeaurora.org>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Message-ID: <a6cbc859-184e-2a0d-bd2b-0ad9653e5ee2@linaro.org>
Date:   Tue, 18 Feb 2020 14:48:16 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <aa942701-d11b-dcf2-d28f-144582af0d2f@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/02/2020 13:23, Dwivedi, Avaneesh Kumar (avani) wrote:
> 
> On 2/18/2020 1:14 AM, Bryan O'Donoghue wrote:
>> On 16/02/2020 16:07, Dwivedi, Avaneesh Kumar (avani) wrote:
>>>
>>> On 2/4/2020 8:40 AM, Bryan O'Donoghue wrote:
>>>> On 03/02/2020 19:35, Bjorn Andersson wrote:
>>>>> On Thu 30 Jan 20:43 PST 2020, Avaneesh Kumar Dwivedi wrote:
>>>>
>>>> Hi Avaneesh.
>>>
>>> Hello Bryan, Thank you very much for your review comments.
>>>
>>> Will be replying to your comments and will be posting new patchset 
>>> soon as per review comments.
>>>
>>>>
>>>>> Please aim for keeping the sort order in this file (ignore QCOM_APR
>>>>> which obviously is in the wrong place)
>>>>>
>>>>>> +       tristate "QTI Embedded USB Debugger (EUD)"
>>>>>> +       depends on ARCH_QCOM
>>>>
>>>> If we persist with the model of EXTCON you should "select EXTCON" here.
>>
>>> I have asked this query with Bjorn Also against his review comments, 
>>> whether we need to persist with extcon or need to switch to usb role 
>>> switch framework, as we are notifying not only to usb controller but 
>>> also to pmic charger so in case we adopt usb role switch then how we 
>>> will notify to pmic charger to enable charging battery ? Also as i 
>>> mentioned there my dilema is it does not look very apt to model EUD 
>>> hw IP as c type connector, so please let me know your views.
>>
>> I think there's a desire to model USB ports as connector child nodes 
>> of a USB controllers as opposed to the more generic extcon so, I think 
>> the effort should probably be made to model it up as typec.
> this comment is irrespective of your below comment (If we were to 
> support Control Peripheral where the local DWC3 controller has the 
> signals routed away entirely, then I think we would need to look into 
> modelling that in device tree - and using an overlay to show the DWC3 
> controller going away in Control Peripheral mode and coming back. )?

Yes, I think irrespective we should model this as a connector not an 
extcon and I think you could do think you could do that as a typec

1. Using role-switch
2. Use the regulator API to capture EUD related charger messages
    and trigger changes in the PMIC as opposed to using extcon
    to notify.

I could be wrong about #2

>> Can that work for you ?
> Did not comprehend this comment fully. if possible can you give some 
> example.

My understanding is we are generally being encouraged to model ports as 
connectors instead of extcon. I think it is possible to model your port 
driver as a typec connector using USB role-switching and the regulator 
API i.e. I don't think you really need extcon here.

>> Ah so, the EUD is a mux, that sits between the connector and the 
>> controller, routing UTMI signals to an internal USB hub, which in-turn 
>> has debug functions attached to the hub...
> Yes that is correct understanding.
>>
>> Can the Arm core see the hub ? I assume not ?
> Not sure what is it mean by "Can the Arm core see the hub"?

In Debug mode will a DWC3 controller in host mode enumerate the internal 
hub ? If so, is that a supported use-case ?

>> There are a few different modes - you should probably be clear on 
>> which mode it is you are supporting.
>>
>> Normal mode: (Bypass)
>> Port | EUD | Controller
>>
>> Normal + debug hub mode: (Debug)
>> Port | EUD | Controller + HUB -> debug functions
>>
>> Debug hub mode: (Control Peripheral)
>> Port | EUD | HUB -> debug functions
>>
>> its not clear to me from the documentation or the code which mode it 
>> is we are targeting to be supported here.
> Its debug mode which we are supporting in driver.
>>
>> I think you should support Debug mode only here, so that the Arm core 
>> never has to deal with the situation where the USB connector "goes away".
> Can you please help what you mean by "so that the Arm core never has to 
> deal with the situation where the USB connector "goes away""

So my thinking is

- DWC3 in host mode
   For argument sake, lets say an external self-powered hub is connected
   and a number of USB devices are enumerated
- EUD switches to Control Peripheral mode

In this case what would happen ?

>>
>> If we were to support Control Peripheral where the local DWC3 
>> controller has the signals routed away entirely, then I think we would 
>> need to look into modelling that in device tree - and using an overlay 
>> to show the DWC3 controller going away in Control Peripheral mode and 
>> coming back.
> debug mode is set run time via user, i will check how we can model such 
> scenario where device tree corresponding to a h/w module is only valid 
> in some scenario at run time. if possible please elaborate bit more on 
> your suggestion

If Debug mode is all you are trying to do support then I don't think you 
really need to model that in DT.

However if intend to support Control Peripheral mode which as I 
understand it, switches the UTMI signals away from a DWC3 controller in 
Host mode, then I think you would need to use a DT overlay to switch off 
the controller, before switching.

That's why I'm asking you about Control Peripheral mode - do you want to 
support it - and if so, then what happens to DWC3 in host mode when the 
UTMI signals go away ?

I think you've said you only want to support Debug mode, which makes 
more sense to me.

Is Debug mode only valid when the DWC3 controller is in 
peripheral/device mode and if so, should we be checking/enforcing that 
somewhere - DT or EUD-driver code ?

>> Also final thought since the EUD can operate in different modes, it 
>> really should be a string that gets passed in - with the string name 
>> aligning to the documentation "bypass", "debug" and so on, so that the 
>> mode we are switching to is obvious to anybody who has the spec and 
>> the driver.
> 
> you mean we should document that this driver works in debug mode only? 
> not clear on where one should pass "debug" and "bypass" string?

You have a routine to switch to debug mode that takes a parameter from 
user-space right ?

Bjorn mentioned you could write 42. My question/suggestion is why isn't 
the value written a string which corresponds to the supported modes from 
the EUD spec ?
"bypass" as default "debug" the mode you want to add, at a later time 
you could optionally add in "control-periperhal" mode.

Makes a little more sense to me than writing just 0, 1 or 42 :) into 
your store routine.

---
bod
