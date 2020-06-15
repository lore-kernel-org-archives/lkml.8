Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B48F1C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 10:44:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FC7C20663
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 10:44:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dR554GJo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729612AbgFOKod (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 06:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728861AbgFOKoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 06:44:30 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B5A3C05BD43
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 03:44:30 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id l11so16591805wru.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 03:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=STl0WSgH8gdPrNVl908k2Vddvy5AFuFoB4TQNkl6L5c=;
        b=dR554GJo3lF8qbT4IoPwXgADwg2M0gh64ESXTwHoOU3HagSWhcfJQrRhztU/fldBNH
         CtNftI/I5aN5xjGJwDLoSvLEWoS1MqoeuKIIvoMAqYz+7qCqNSJCDw7sbWpnPw+ZCGAh
         AKYhGc/uicdbDy4Fc+G8NG/hRwH1yVkQLVj8n8OifvhY+hsec0Lq5ZHmSZaTj/KEvh7G
         Y2V0zBb2KREz4B/ItEpC+BAO9UARrQfP/4LAu0SNxMSWqA2WCvg8qVS3yEjVcgMFmb6Y
         TPRAEiGCBYXziFRHMLPKIfQoCZXxTvhE4mjunVzMr9QugeNRJCYx4/cT7tR/93Sn/TuF
         eI4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=STl0WSgH8gdPrNVl908k2Vddvy5AFuFoB4TQNkl6L5c=;
        b=OIrCT56ZdD36sXyHOEscda7hFOk2XztOEn+FTrGVBhSO0oLP2javTDrKh1Z6a1sAwE
         dqfIQrBelMZDd8Ioh/K5jRyTRa9yYrsiKc5whB/sw631lREnFxvwcJgjqtKbvLwUYjgT
         KHTMw9Y5jEECLyK+tGamWVUBns0EqxoxL73hCAjaO3JPj1X24KhX4kDohCzZURIG5cPg
         XavJ2vi5Q4rUyy1tKNNE943yfViyPWLWYOaqE9Wsm5/xNlzH+r5VtRx3jHPhMZZAuftK
         bK389+s8f0QWhmq5KADIKUDcgQ0cffFqKdahQ0rRMsQOejWpPuzk3QdH0+54o0EVnasp
         Sw5A==
X-Gm-Message-State: AOAM532J0tQOHbek9VHAFl06AuRspAomHmZbvYrYguLpeg/XScYNvnun
        kQfQUxJzsc35qYvcg9w1+/9vOA==
X-Google-Smtp-Source: ABdhPJyWJ5Lm4oZYuxKHZmjX+xqR2kjaG55OMowFZTVgK9OpNe4PNZlq+VYDLN5wigiUhtvmQnEcVg==
X-Received: by 2002:adf:f251:: with SMTP id b17mr26925155wrp.289.1592217868512;
        Mon, 15 Jun 2020 03:44:28 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id h7sm23129000wml.24.2020.06.15.03.44.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jun 2020 03:44:27 -0700 (PDT)
Subject: Re: [RFC v2 1/3] dt-bindings: nvmem: Add devicetree bindings for
 qfprom-efuse
To:     Doug Anderson <dianders@chromium.org>,
        Ravi Kumar Bokka <rbokka@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        dhavalp@codeaurora.org, mturney@codeaurora.org,
        sparate@codeaurora.org, c_rbokka@codeaurora.org,
        mkurumel@codeaurora.org
References: <1591868882-16553-1-git-send-email-rbokka@codeaurora.org>
 <1591868882-16553-2-git-send-email-rbokka@codeaurora.org>
 <CAD=FV=WjvAWVmq3fTh=_f2p1Dv+sXg1RV-CqZr8KRgHe8_wT0w@mail.gmail.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <0ee1d7fa-0520-a347-6a55-6ab646284b1a@linaro.org>
Date:   Mon, 15 Jun 2020 11:44:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAD=FV=WjvAWVmq3fTh=_f2p1Dv+sXg1RV-CqZr8KRgHe8_wT0w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/06/2020 22:59, Doug Anderson wrote:
> Hi,
> 
> On Thu, Jun 11, 2020 at 2:49 AM Ravi Kumar Bokka <rbokka@codeaurora.org> wrote:
>>
>> This patch adds dt-bindings document for qfprom-efuse controller.
>>
>> Signed-off-by: Ravi Kumar Bokka <rbokka@codeaurora.org>
>> ---
>>   .../devicetree/bindings/nvmem/qfprom.yaml          | 52 ++++++++++++++++++++++
>>   1 file changed, 52 insertions(+)
> 
> Overall comment: I reviewed your v1 series and so I'm obviously
> interested in your series.  Please CC me on future versions.
> 
> I would also note that, since this is relevant to Qualcomm SoCs that
> you probably should be CCing "linux-arm-msm@vger.kernel.org" on your
> series.
> 
> 
>>   create mode 100644 Documentation/devicetree/bindings/nvmem/qfprom.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/nvmem/qfprom.yaml b/Documentation/devicetree/bindings/nvmem/qfprom.yaml
>> new file mode 100644
>> index 0000000..7c8fc31
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/nvmem/qfprom.yaml
>> @@ -0,0 +1,52 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/nvmem/qfprom.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Qualcomm Technologies Inc, QFPROM Efuse bindings
>> +
>> +maintainers:
>> +  - Ravi Kumar Bokka <rbokka@codeaurora.org>
>> +
>> +allOf:
>> +  - $ref: "nvmem.yaml#"
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - qcom,qfprom
> 
> As per discussion in patch #1, I believe SoC compatible should be here
> too in case it is ever needed.  This is standard practice for dts
> files for IP blocks embedded in an SoC.  AKA, this should be:
> 
>      items:
>        - enum:
>            - qcom,apq8064-qfprom
>            - qcom,apq8084-qfprom
>            - qcom,msm8974-qfprom
>            - qcom,msm8916-qfprom
>            - qcom,msm8996-qfprom
>            - qcom,msm8998-qfprom
>            - qcom,qcs404-qfprom
>            - qcom,sc7180-qfprom
>            - qcom,sdm845-qfprom


Above is not required for now in this patchset, as we can attach data at 
runtime specific to version of the qfprom.

This can be added when required!

>        - const: qcom,qfprom
> 
> NOTE: old SoCs won't have both of these and thus they will get flagged
> with "dtbs_check", but I believe that's fine (Rob can correct me if
> I'm wrong).  The code should still work OK if the SoC isn't there but
> it would be good to fix old dts files to have the SoC specific string
> too.
> 
> 
>> +
>> +  reg:
>> +    maxItems: 3
> 
> Please address feedback feedback on v1.  If you disagree with my
> feedback it's OK to say so (I make no claims of being always right),
> but silently ignoring my feedback and sending the next version doesn't
> make me feel like it's a good use of my time to keep reviewing your
> series.  Specifically I suggested that you actually add descriptions
> rather than just putting "maxItems: 3".
> 
> With all that has been discussed, I think the current best thing to
> put there is:
> 
>      # If the QFPROM is read-only OS image then only the corrected region
>      # needs to be provided.  If the QFPROM is writable then all 3 regions
>      # must be provided.
>      oneOf:
>        - items:
>            - description: The start of the corrected region.
>        - items:
>            - description: The start of the raw region.
>            - description: The start of the config region.
>            - description: The start of the corrected region.
> 
>> +
> 
> You missed a bunch of things that you should document:
> 
>    # Clocks must be provided if QFPROM is writable from the OS image.
>    clocks:
>      maxItems: 1
>    clock-names:
>      const: sec
> 
>    # Supply reference must be provided if QFPROM is writable from the OS image.
>    vcc-supply:
>      description: Our power supply.
> 
>    # Needed if any child nodes are present.
>    "#address-cells":
>      const: 1
>    "#size-cells":
>      const: 1
> 
>> +required:
>> +   - compatible
>> +   - reg
>> +   - reg-names
> 
> reg-names is discouraged.  Please remove.  I always point people here
> as a reference:
> 
> https://lore.kernel.org/r/CAL_Jsq+MMunmVWqeW9v2RyzsMKP+=kMzeTHNMG4JDHM7Fy0HBg@mail.gmail.com/
> 
> You can just figure out whether there are 3 register fields or 1 register field.

Am not sure if I understand this correctly, reg-names are very useful in 
this particular case as we are dealing with multiple memory ranges with 
holes. I agree with not having this for cases where we have only one 
resource.

But having the ordering in DT without proper names associated with it 
seems fragile to me! And it makes very difficult to debug issues with 
wrong resource ordering in DT.

Rob, Is this the guidance for new bindings?

I have not seen any strong suggestion or guidance either in
 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/resource-names.txt?h=v5.8-rc1 
  Or in ./drivers/of/address.c

Am I missing anything here?
