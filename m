Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF8E2C83004
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 21:01:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94F44206F0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 21:01:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H9LCYrG0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbgD2VB5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 17:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726456AbgD2VB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 17:01:57 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A30BC03C1AE
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 14:01:57 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id g12so3598808wmh.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 14:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+TvQcFiU3aloZC/hJe73C/3yo1nULr9/ZJUA32G7jIE=;
        b=H9LCYrG0FR/boqVhN935EFeTEvmRileVmKdUA0aVoLMMqYWBxAGooFAv607/oc09gQ
         jcrZAm3GONS/8m39QndXY49RaLER9NEFUa653B2ngCBn7ZCGrcdAVjocnNbTrSf25qN4
         vPvKoFVeAsf11wHlPIf7AXMWs6x32q9H7Kzt+1uk4dVUYBPU4TtvcZ8TPmOVqPjx5PWT
         mBAtkgsL671JFF5+qX11uhNIFLn7WPMlr5vI+VKPn92kxe2x9O7zW+lmuKzIekqSOCzv
         Oj3bjL5fQnRn0ScVfPNGTWPkxyJaZbsHQllHV1J0X1F0BbTLG0gkXmvNdH8gq58yCwdh
         DveA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+TvQcFiU3aloZC/hJe73C/3yo1nULr9/ZJUA32G7jIE=;
        b=ftQMCtCnSXYZvgiaDkO3vdbLVK3IsGvPSkgSSzRMKDpOYN6h8LAX+8x3EGpLYaC0HG
         oydkUfX3nyP7uNQuczbWevi8N0BMWUB7a0iz+tQOf3h5pNubq8TR79iJLjiGqiepk1V9
         QhxYsz2LplYsZgToNpjyjZpd8fsmefS5UFBhi17zxvoXuif03UL//NEVgU1WtZen+M6H
         e2CBmMoZyWqnxE+NVKkjIqlt3AzkL6rB4ErMAnBAPLcWCe2H0kvENzcVfc6Lgq9v1f6a
         FsgU5TVYWfBiuBLK5YGrdl/UjjHYUAJ3dUxbH4jelsAS7KTTTcnBglkg23z5G/AprUzs
         DldQ==
X-Gm-Message-State: AGi0PubJ9dzsfgpWCqMZ9LdXXXQqyHGIl4ILIxswP+5GifzdLHTuMiF+
        hGTc9Zw+tOX8pEfJYSrQ8boqq5w9WOw=
X-Google-Smtp-Source: APiQypIvQ29o70NDaZXlBpTOIaRhPrpz0gn3DVu8Qm0SOXFFXbUtbluMOqQ01NrQtAIBEVVefhXGfg==
X-Received: by 2002:a05:600c:2f88:: with SMTP id t8mr5151772wmn.46.1588194115762;
        Wed, 29 Apr 2020 14:01:55 -0700 (PDT)
Received: from [192.168.0.41] (lns-bzn-59-82-252-135-148.adsl.proxad.net. [82.252.135.148])
        by smtp.googlemail.com with ESMTPSA id i25sm9242483wml.43.2020.04.29.14.01.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Apr 2020 14:01:55 -0700 (PDT)
Subject: Re: [PATCH v4 4/4] thermal: cpuidle: Register cpuidle cooling device
To:     Lukasz Luba <lukasz.luba@arm.com>, rui.zhang@intel.com,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "open list:CPU IDLE TIME MANAGEMENT FRAMEWORK" 
        <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:CPUIDLE DRIVER - ARM PSCI" 
        <linux-arm-kernel@lists.infradead.org>
References: <20200429103644.5492-1-daniel.lezcano@linaro.org>
 <20200429103644.5492-4-daniel.lezcano@linaro.org>
 <99b3bc79-f48a-3d51-a8ae-8b9ca4856d36@arm.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <04b5da25-d591-b08a-e554-6e084d7ea908@linaro.org>
Date:   Wed, 29 Apr 2020 23:01:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <99b3bc79-f48a-3d51-a8ae-8b9ca4856d36@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/04/2020 22:02, Lukasz Luba wrote:
> 
> 
> On 4/29/20 11:36 AM, Daniel Lezcano wrote:
>> The cpuidle driver can be used as a cooling device by injecting idle
>> cycles. The DT binding for the idle state added an optional
>>
>> When the property is set, register the cpuidle driver with the idle
>> state node pointer as a cooling device. The thermal framework will do
>> the association automatically with the thermal zone via the
>> cooling-device defined in the device tree cooling-maps section.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---
>>   - V4:
>>     - Do not check the return value as the function does no longer
>> return one
>> ---

[ ... ]

> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

Thanks Lukasz for the review.

Rafael, as Lorenzo and Sudeep are not responsive, could you consider ack
this patch so I can merge the series through the thermal tree ?


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
