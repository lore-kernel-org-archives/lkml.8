Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DA3CC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 11:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0101020709
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 11:03:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KQhWFuX/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726217AbgEOLDN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 07:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbgEOLDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 07:03:12 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0382FC061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 04:03:11 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id z4so716181wmi.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 04:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iqpq12gc8bTtNBtY5ZIVdxCDS9UGGhps1DCBy7t56Sc=;
        b=KQhWFuX/FjBpvSsD5C4JlqNzD53keqf6x1HZUfMWY9SjMgRvTGdIRcgtfxx+yEhOua
         7FJGFLE/tL21fgq7R1DP6qTmAsILkA7I4iQbUswloXIptvbMaIjLiQ+JuFAqdrgh1K0q
         MbxDuvveGypUJvaM4vhgWjhk+g01QInFSXY+fXcmb8H23HUhzpdgrUgoAPnLuzrQOkWm
         MTgueJG/9fB0PYlgMmHxWSLuDK4wk/ybO7LPPQ3E9Jono3Ly/QGKv6JYwPBZAB34Hyb6
         0R3efCIjIciXDeRMX/oaSGKEeTMXO5WiPRNUMAvLtFGnUIaQHpXivbwnoRATQBzMBAMS
         ZKfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iqpq12gc8bTtNBtY5ZIVdxCDS9UGGhps1DCBy7t56Sc=;
        b=Vo2CZ8RutbRmCIVELzzGHwpSaTSaWyZwz1e0ajTszDvRhCu4MRN8+8Volp687hcMXZ
         ICfOXuZTFUw49c4ZF7Vkuec34+cn8C3j2QMRM5YqtAJwQUBsiX1tlTcijsEhmX/hTc9u
         U88xzIGxZ8OrrZ6Uy6qEnqHLpy32FWh0n21aCud4fQ60Cc6682gy9cIxBhGtNJjm2Nq6
         Zt8uzQoYONjntQYA8Y3L8mEX7o0aUlVmhkW94JveMwvvK0yQt52YxK/9mkt4B+jKERnG
         QorWl/YkUKPhvf0AGSf+qXOxboz08RFthwryDQucZntSxvEtL/lIvWNsRywA38fLXqSp
         aryw==
X-Gm-Message-State: AOAM530sP7I0IPjVz+yuo2V+MU4qB9Su/Gw1zO90JXAqp3P95t8Hwomi
        iv2IgOmizFTn/e3ICd46M2JpVw==
X-Google-Smtp-Source: ABdhPJz09zqvaqC1JaFDugl18vq78E+RNFXiDIdWvrDoMdsvhWsiQds56u5FrbQHPH1HGgUnZIcgDA==
X-Received: by 2002:a1c:bbc5:: with SMTP id l188mr3289666wmf.163.1589540589509;
        Fri, 15 May 2020 04:03:09 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:28df:6b80:d69f:9c0a? ([2a01:e34:ed2f:f020:28df:6b80:d69f:9c0a])
        by smtp.googlemail.com with ESMTPSA id z12sm458111wmc.6.2020.05.15.04.03.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2020 04:03:08 -0700 (PDT)
Subject: Re: [PATCH v4 4/4] thermal: cpuidle: Register cpuidle cooling device
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Lukasz Luba <lukasz.luba@arm.com>, rui.zhang@intel.com,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "open list:CPU IDLE TIME MANAGEMENT FRAMEWORK" 
        <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:CPUIDLE DRIVER - ARM PSCI" 
        <linux-arm-kernel@lists.infradead.org>
References: <20200429103644.5492-1-daniel.lezcano@linaro.org>
 <20200429103644.5492-4-daniel.lezcano@linaro.org>
 <99b3bc79-f48a-3d51-a8ae-8b9ca4856d36@arm.com>
 <04b5da25-d591-b08a-e554-6e084d7ea908@linaro.org>
 <f3cee834-4946-10bd-a504-df6cf62d9e90@linaro.org>
 <20200515095751.GA25267@bogus>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <6faac4ac-b711-11ad-32e7-26ae930db6fa@linaro.org>
Date:   Fri, 15 May 2020 13:03:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200515095751.GA25267@bogus>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/05/2020 11:58, Sudeep Holla wrote:
> On Mon, May 04, 2020 at 08:00:01PM +0200, Daniel Lezcano wrote:
>>
>> Hi,
>>
>> On 29/04/2020 23:01, Daniel Lezcano wrote:
>>> On 29/04/2020 22:02, Lukasz Luba wrote:
>>>>
>>>>
>>>> On 4/29/20 11:36 AM, Daniel Lezcano wrote:
>>>>> The cpuidle driver can be used as a cooling device by injecting idle
>>>>> cycles. The DT binding for the idle state added an optional
>>>>>
>>>>> When the property is set, register the cpuidle driver with the idle
>>>>> state node pointer as a cooling device. The thermal framework will do
>>>>> the association automatically with the thermal zone via the
>>>>> cooling-device defined in the device tree cooling-maps section.
>>>>>
>>>>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>>>> ---
>>>>>   - V4:
>>>>>     - Do not check the return value as the function does no longer
>>>>> return one
>>>>> ---
>>>
>>> [ ... ]
>>>
>>>> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
>>>
>>> Thanks Lukasz for the review.
>>>
>>> Rafael, as Lorenzo and Sudeep are not responsive, could you consider ack
>>> this patch so I can merge the series through the thermal tree ?
>>
>> Gentle ping ... Sudeep, Lorenzo or Rafael ?
>>
> 
> Sorry for the delay. I ignore this as it was generic and I was fine with
> it. Didn't know you were waiting me, sorry for that.

No problem, thanks for the ack.

> Acked-by: Sudeep Holla <sudeep.holla@arm.com>

Rafael, if you are ok with that, I'll take this patch in the thermal
tree along with the others.


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
