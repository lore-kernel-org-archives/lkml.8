Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38E0BC33CB7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 18:29:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1293D24687
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 18:29:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XmbQONEh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbgA0S3G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 13:29:06 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42652 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbgA0S3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 13:29:05 -0500
Received: by mail-wr1-f65.google.com with SMTP id q6so12609622wro.9
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jan 2020 10:29:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:from:to:cc:references:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BYPi1F64HA0CcHOQxpTTA4TK/HU+UwAMlkaUgiWU0YE=;
        b=XmbQONEhW9EqTPyOiYfRdK00bgKmL0ChAL3hQ0MJB+N8m/8fh4IlmseZw7zF2iJrAl
         G6dvx/FPytKlRmd/pauwV7ZYbcbgGJpHSyalotjGNBkkFJoYdJax5Vrp3dh9p+Tpmoab
         hTjmQ6v3irDCW1QYJ4ZPtDHnVg1Z6oLhE+d2dDq4+XStQF0eug+zIF3OKF7PjNcVVxrR
         /xQ6h7IH10wkHhPGV7qyfBJ194iHl6hL2EzRMJDRVRO8QfJSPLtNXzRR18chYDOMEo24
         xW1YgJ5+bF3UY4bBb8dvgbUMxRN5KYKxfTuZnDWL+PTZfRipsl6ulLtsPWGSFUGnR5CU
         uFLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=BYPi1F64HA0CcHOQxpTTA4TK/HU+UwAMlkaUgiWU0YE=;
        b=KDsA1OYtSyhxKsvYFhsNztPv+Q2EUIBbEfD2OouqphiVSqCPhvIzRXDibmMJWDFwJQ
         xhDpuVaExB0tmbPVQOtOUtjozTl4YWbc0uuz23uKA3T7y585np7XlnqJWBt1SW8jHVZP
         gT4s9wvJHlPM8vZOOTQJHTcZhZMEmsZvBPHZzNbQujDzJnEDil778MUVeY04L6/Tcx0O
         SEHFRIOaQRprexYMuO7bBbhFar8gGneBFnorB6iMBc+v4anbJ9JsQn8WKsvcD1fmsmsw
         Wme2sn2fUdX61vlq0RvBX0G/cy3wdTXUFn5DNHQgK2TMgybJ+qnHy7fUbH2Ndp5sdq49
         lAig==
X-Gm-Message-State: APjAAAXJWU6+9J97NqnOugwGs7a8AbXDDYbUBvW8i5lqg8lON9MNDI6r
        SFP1J1BqIuMFua7eX17DAWKXk3bNCAJaaA==
X-Google-Smtp-Source: APXvYqzneyFyI0RFisUPVWjCYTBAn/WxxKd1qwsNkucd5SBlUdWtZgpZxc8ytnNGWMctsiJHs+OMzg==
X-Received: by 2002:adf:d0c1:: with SMTP id z1mr24908913wrh.371.1580149742571;
        Mon, 27 Jan 2020 10:29:02 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:25cd:3fb1:37ba:f055? ([2a01:e34:ed2f:f020:25cd:3fb1:37ba:f055])
        by smtp.googlemail.com with ESMTPSA id i10sm22349348wru.16.2020.01.27.10.29.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jan 2020 10:29:01 -0800 (PST)
Subject: Re: [PATCH 1/2] DT: bindings: Add cooling cells for idle states
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20191219221932.15930-1-daniel.lezcano@linaro.org>
 <20200108140333.GA12276@bogus>
 <3b94b423-ca26-b96f-90fa-2662dbc523d8@linaro.org>
 <CAL_JsqK8gu-Ts_aMpcXgtvqW=gWGLTrUvNWDm+8fB7--62FmnQ@mail.gmail.com>
 <5b82ab42-7804-a726-2d42-a63e83626666@linaro.org>
Autocrypt: addr=daniel.lezcano@linaro.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <423e0595-e799-62c1-a2f1-a384175da339@linaro.org>
Date:   Mon, 27 Jan 2020 19:29:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <5b82ab42-7804-a726-2d42-a63e83626666@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Rob,

a gentle ping on the questions below.


On 13/01/2020 18:52, Daniel Lezcano wrote:
> On 13/01/2020 17:16, Rob Herring wrote:
>> On Sat, Jan 11, 2020 at 11:32 AM Daniel Lezcano
>> <daniel.lezcano@linaro.org> wrote:
>>>
>>> Hi Rob,
>>>
>>>
>>> On Wed, 8 Jan 2020 at 15:03, Rob Herring <robh@kernel.org> wrote:
>>>>
>>>> On Thu, Dec 19, 2019 at 11:19:27PM +0100, Daniel Lezcano wrote:
>>>>> Add DT documentation to add an idle state as a cooling device. The CPU
>>>>> is actually the cooling device but the definition is already used by
>>>>> frequency capping. As we need to make cpufreq capping and idle
>>>>> injection to co-exist together on the system in order to mitigate at
>>>>> different trip points, the CPU can not be used as the cooling device
>>>>> for idle injection. The idle state can be seen as an hardware feature
>>>>> and therefore as a component for the passive mitigation.
>>>>>
>>>>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>>>> ---
>>>>>  Documentation/devicetree/bindings/arm/idle-states.txt | 11 +++++++++++
>>>>>  1 file changed, 11 insertions(+)
>>>>
>>>> This is now a schema in my tree. Can you rebase on that and I'll pick up
>>>> the binding change.
>>>
>>> Mmh, I'm now having some doubts about this binding because it will
>>> restrict any improvement of the cooling device for the future.
>>>
>>> It looks like adding a node to the CPU for the cooling device is more
>>> adequate.
>>> eg:
>>> CPU0: cpu@300 {
>>>    device_type = "cpu";
>>>    compatible = "arm,cortex-a9";
>>>    reg = <0x300>;
>>>    /* cpufreq controls */
>>>    operating-points = <998400 0
>>>           800000 0
>>>           400000 0
>>>           200000 0>;
>>>    clocks = <&prcmu_clk PRCMU_ARMSS>;
>>>    clock-names = "cpu";
>>>    clock-latency = <20000>;
>>>    #cooling-cells = <2>;
>>>    thermal-idle {
>>>       #cooling-cells = <2>;
>>>    };
>>> };
>>>
>>> [ ... ]
>>>
>>> cooling-device = <&{/cpus/cpu@300/thermal-idle}
>>>                         THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
>>>
>>> A quick test with different configurations combination shows it is much
>>> more flexible and it is open for future changes.
>>>
>>> What do you think?
>>
>> Why do you need #cooling-cells in both cpu node and a child node?
> 
> The cooling-cells in the CPU node is for the cpufreq cooling device and
> the one in the thermal-idle is for the idle cooling device. The first
> one is for backward compatibility. If no cpufreq cooling device exists
> then the first cooling-cells is not needed. May be we can define
> "thermal-dvfs" at the same time, so we do the change for both and
> prevent mixing the old and new bindings?
> 
>> It's really only 1 device.
> 
> The main problem is how the thermal framework is designed. When we
> register a cooling device we pass the node pointer and the core
> framework checks it has a #cooling-cells. Then cooling-maps must have a
> phandle to the node we registered before as a cooling device. This is
> when the thermal-zone <-> cooling device association is done.
> 
> With the cpufreq cooling device, the "CPU slot" is now used and we can't
> point to it without ambiguity as we can have different cooling device
> strategies for the same CPU at different temperatures.
> 
> Is it acceptable the following?
> 
> CPU0: cpu@300 {
>    [ ... ]
>    thermal-idle {
>       #cooling-cells = <2>;
>    };
> 
>    thermal-dvfs {
>       #cooling-cells = <2>;
>    }
> };
> 
> Or alternatively, can we define a passive-cooling node?
> 
> thermal-cooling: passive0 {
>    #cooling-cells = <2>;
>    strategy="dvfs" | "idle"
>    cooling-device=<&CPU0>
> };
> 
> cooling-device = <&passive0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> 
>> Maybe you could add another cell to contain an idle state node if that
> helps?
> 
> (Assuming you are referring to a phandle to an idle state) The idle
> states are grouped per cluster because the CPUs belonging to the same
> cluster have the same idle states characteristics. Because of that, the
> phandle will point to the same node and it will be impossible to specify
> a per cpu cooling device, only per cluster.
> 
> 
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

