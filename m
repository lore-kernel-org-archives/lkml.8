Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 547A9C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 10:10:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29E0420B1F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 10:10:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xFwo+1KO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729077AbgFRKKh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 06:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728909AbgFRKKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 06:10:25 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B3DDC0613EE
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 03:10:24 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id l17so4596855wmj.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 03:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OwJsflTboOZP6LbxLiR2D3X1/RtjhErKQOO0ZRCejlo=;
        b=xFwo+1KO0qIziXEjKjKhDmQG5DAT7HTL3vfq9JYjUk7rnRXpQj8eiQadVojy5j/xR7
         HSXQcwXFdcyV4jtE2nvrXgHpaJeCX9H7VIN32wE2ftr7UKz0N3NLuqxBuQUVRxBz8hTO
         zsHKCSkRgIVEzHVcAf3QBNmvfh/pCff1zuCXfiorC/V12+E0zAdJWyoZpDMwb8NRR3e2
         rVI+lf/SrA7/FjEU6+NX4/TBwm8b+xUNdwp88MeoNJsRln0n9kEiW3Z/iGGZejhoD+/c
         2bQeOcBW85u59Xcvoj9sk4xGmv3DdbHfGDnoDh4EpQBcSNj5Qaz8eeO4TfABflhPnfHs
         fqPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OwJsflTboOZP6LbxLiR2D3X1/RtjhErKQOO0ZRCejlo=;
        b=Kpiaha0RpHZmtdiigjbUWlEaE1S8C92hYYTfsnRdclLb9FjQh37IOWH8sgWhug5+/r
         R/qracFbfjXSshFMWaqSlrCUuAPnSVZ/W7XHrD4s35Kcxtqa4rM4gps9wqcWV3ly8oeD
         ziaFX/BjihbNhySEUr79h2yLrVWSf7O4wnqoIU0p94B2wAguwGskT4Tb//GEpcNEoraa
         wFVdjAGuKHP8i/ti6sNmvRU07Y2Wiu9RD04HwSoYxIgCvYzSivQLInrHgq/3GneAxYmW
         EvgmiBxkm95sWzo7HNVrKowdsKiv43gfcPUbIisbo06yp+o4cjTUOk0sZTsjjWwiTV3e
         pa+A==
X-Gm-Message-State: AOAM5300vi6qnawEx2XHrWhI+0cAO5hQ74nfvDiV4XS2inf9A/pogbzv
        C00H2v0DPRKOPjFAPKvZB2Vo39k4Ux8=
X-Google-Smtp-Source: ABdhPJwTDt4perkWCiEvn8HgFTKm3VTLE8DTiPNTY6XLRlvvmmlvQKQkRZGYVY9PPZIPgOd27rCXwA==
X-Received: by 2002:a1c:b656:: with SMTP id g83mr3345799wmf.151.1592475022767;
        Thu, 18 Jun 2020 03:10:22 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id u130sm3121602wmg.32.2020.06.18.03.10.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jun 2020 03:10:22 -0700 (PDT)
Subject: Re: [PATCH v3 2/4] dt-bindings: nvmem: Add properties needed for
 blowing fuses
To:     Doug Anderson <dianders@chromium.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>, dhavalp@codeaurora.org,
        mturney@codeaurora.org, Rajendra Nayak <rnayak@codeaurora.org>,
        Ravi Kumar Bokka <rbokka@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        sparate@codeaurora.org, mkurumel@codeaurora.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        swboyd@chromium.org
References: <20200617145116.247432-1-dianders@chromium.org>
 <20200617074930.v3.2.I3b5c3bfaf5fb2d28d63f1b5ee92980900e3f8251@changeid>
 <254998b9-c45e-bd6b-bc9a-b5934c0fea8e@linaro.org>
 <CAD=FV=Vec5FVrDVkmUQTfa6bP+1d3yOtj_FsgVAFdHLLbZ8VDA@mail.gmail.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <db6cc914-0520-5286-f852-473fc63bd6c7@linaro.org>
Date:   Thu, 18 Jun 2020 11:10:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAD=FV=Vec5FVrDVkmUQTfa6bP+1d3yOtj_FsgVAFdHLLbZ8VDA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Adding SBoyd.

On 17/06/2020 18:22, Doug Anderson wrote:
> Hi,
> 
> On Wed, Jun 17, 2020 at 8:19 AM Srinivas Kandagatla
> <srinivas.kandagatla@linaro.org> wrote:
>>
>>
>>
>> On 17/06/2020 15:51, Douglas Anderson wrote:
>>> From: Ravi Kumar Bokka <rbokka@codeaurora.org>
>>>
>>> On some systems it's possible to actually blow the fuses in the qfprom
>>> from the kernel.  Add properties to support that.
>>>
>>> NOTE: Whether this is possible depends on the BIOS settings and
>>> whether the kernel has permissions here, so not all boards will be
>>> able to blow fuses in the kernel.
>>>
>>> Signed-off-by: Ravi Kumar Bokka <rbokka@codeaurora.org>
>>> Signed-off-by: Douglas Anderson <dianders@chromium.org>
>>> ---
>>>
>>> Changes in v3:
>>> - Add an extra reg range (at 0x6000 offset for SoCs checked)
>>> - Define two options for reg: 1 item or 4 items.
>>> - No reg-names.
>>> - Add "clocks" and "clock-names" to list of properties.
>>> - Clock is now "sec", not "secclk".
>>> - Add "vcc-supply" to list of properties.
>>> - Fixed up example.
>>>
>>>    .../bindings/nvmem/qcom,qfprom.yaml           | 45 ++++++++++++++++++-
>>>    1 file changed, 43 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
>>> index 5efa5e7c4d81..b195212c6193 100644
>>> --- a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
>>> +++ b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
>>> @@ -17,8 +17,27 @@ properties:
>>>        const: qcom,qfprom
>>>
>>>      reg:
>>> -    items:
>>> -      - description: The corrected region.
>>> +    # If the QFPROM is read-only OS image then only the corrected region
>>> +    # needs to be provided.  If the QFPROM is writable then all 4 regions
>>> +    # must be provided.
>>> +    oneOf:
>>> +      - items:
>>> +          - description: The corrected region.
>>> +      - items:
>>> +          - description: The corrected region.
>>> +          - description: The raw region.
>>> +          - description: The config region.
>>> +          - description: The security control region.
>>> +
>>> +  # Clock must be provided if QFPROM is writable from the OS image.
>>> +  clocks:
>>> +    maxItems: 1
>>
>>
>>> +  clock-names:
>>> +    const: sec
>>
>> Do we need clock-names for just one clock here?
> 
> I think technically you can get by without, but convention is that
> clock-names are always provided for clocks.  It's talked about in the
> same link I sent that talked about reg-names:
> 
> https://lore.kernel.org/r/CAL_Jsq+MMunmVWqeW9v2RyzsMKP+=kMzeTHNMG4JDHM7Fy0HBg@mail.gmail.com/
> 

TBH, This is total confusion!!!

when to use "*-names" Device tree bindings is totally depended on Linux 
Subsystem interfaces!

And what is the starting point to draw this line?


> Specifically, Rob said:
> 
>> That probably is because the clock binding has had clock-names from
>> the start (it may have been the first one). That was probably partly
>> due to the clock API also was mainly by name already if we want to
>> admit Linux influence on bindings
> 
> Basically the standard way for getting clocks in Linux is
> clk_get(name).  With just one clock you can call clk_get(NULL) and I
> believe that works, but when you add the 2nd clock then you have to
> switch APIs to one of the less-commonly-used variants.

In previous NON-DT life clk_get api name argument comes from the clk 
names that clk provider registered the clocks with.

If I remember this correctly, the name that is refereed here for 
clk_get() is old clkdev api based on clk_lookups and is not the same as 
clk-names that we have in Device tree. Atleast in this case!

clk-names has two objectives in DT:
1> To find the index of the clock in the clocks DT property.

2> If actual clk name is specified then if "1" fails then name could 
potentially fallback to use old clkdev based clk_lookups.

In this specific case we have "sec" as clock-names which is totally used 
for indexing into clocks property and it can not be used for (2) as 
there is no clk named "sec" registered by any of the clk providers.

So this does not justify the reasoning why "clock-names" should be used 
while "reg-names" should not be used!. Both of them are going to be 
finally used for indexing into there respective properties.

This also brings in greater confusion for both existing and while adding 
bindings with "*-names" for new interfaces.

Rob, can you please provide some clarity and direction on when to 
use/not-use *-names properties!


Thanks,
srini
> 
> -Doug
> 
