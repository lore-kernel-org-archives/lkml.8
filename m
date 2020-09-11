Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F96C43461
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 07:58:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B2B421D6C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 07:58:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G8EdYaLJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725810AbgIKH6P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 03:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725786AbgIKH6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 03:58:08 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70919C061756
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 00:58:08 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id a9so3854322wmm.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 00:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1IUSu/d3w6Wkl/EvaZBQs8+EfTzsdofYI5H0K7F7L1o=;
        b=G8EdYaLJeEp/GI1N1GuZ1b6OOHrLRNIm7B4ikRMq59wmBHu+2vXE0NCCGTbKaI0cDY
         i5rmWNN/1W1pgiRv91f7fwtLZ5IFfsG+QAZlx0iFPFKz/2hPlPsZ45vmCzjdIkkMpTqJ
         NoIyfmZIGHoRe3/GiYdqSpTV3WBNS9cJ0AGCMY/besJr2+jj8/RUnyBXhPOv/urktqvT
         REJN8+U/97Lt7BmQeF2SD8v63wLxGu6X2bZObIpqpcgx2OVE4EppIo6ac0nVmnJ1M6tm
         cD2lfKQ5oelMZAKuX0ksH9ci/b7GXigp1ojqJSldTdfvDvdjgtkFQFpAp6IpRr6sOsPt
         KYNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1IUSu/d3w6Wkl/EvaZBQs8+EfTzsdofYI5H0K7F7L1o=;
        b=O1NTbO331nHyDCYabDRf82I2qXhKNPaYwXd6bTu4JiNvuTWg2JoG5AsuuXrQEX/PE6
         CFz7Qf6/2KlR71iH4H/JJV/FUN6XyXGg88uWDKPnKTx3HYKopfafnCktR+knCbZXldKB
         PjeWsBFQ4B5O50hab/ytzBaiJ/pWKS8sc4GTf4NuCCTT+qPNjUsMq734kXJdmj0gtcmA
         MhWJX/rKOFh/Xi6F5BFm0UmLw8pzU9bs6WJNue2kJnWFFnWICkxDGtEl8578MxxoOJt5
         oHclVKmwEI1zYQUfeJthTwIoGE7nsdmcwEOoGd71J60omzAIvFT7Fk5sBooOUxA5KmrH
         mMqQ==
X-Gm-Message-State: AOAM531BTVfDYGN5VWMlp9XaFjxLQXS6pcFYV2mnh/MlR+i7LESAHc7+
        cY4lZWKhdsIaYJ8ZQvW7fFqJUQ==
X-Google-Smtp-Source: ABdhPJw/Gu3pU0oETNVFOVI21iaEBCzb7k6eX911WqCSdEToMWwhB+YQcOHFra5+8PgT6gg0FDX0KA==
X-Received: by 2002:a7b:cb82:: with SMTP id m2mr799532wmi.56.1599811085439;
        Fri, 11 Sep 2020 00:58:05 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:d5d9:c908:efdc:8b45? ([2a01:e34:ed2f:f020:d5d9:c908:efdc:8b45])
        by smtp.googlemail.com with ESMTPSA id a85sm2831561wmd.26.2020.09.11.00.58.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Sep 2020 00:58:04 -0700 (PDT)
Subject: Re: [PATCH RFC] powercap/drivers/energy_model: protocode: Add
 powercap energy model based
To:     Amit Kucheria <amitk@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Ram Chandrasekar <rkumbako@codeaurora.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>
References: <20200707171457.31540-1-daniel.lezcano@linaro.org>
 <CAHLCerPq_f3t=cgS0MXvWuRvPaBrAs2dZEyeNSOyZ3OXHgHNeg@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <d8338e31-3d9b-a0b4-bf0f-6e74a7ae4fbf@linaro.org>
Date:   Fri, 11 Sep 2020 09:58:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAHLCerPq_f3t=cgS0MXvWuRvPaBrAs2dZEyeNSOyZ3OXHgHNeg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Amit,

thanks for taking the time to review the series and read this long
description.

On 10/09/2020 11:48, Amit Kucheria wrote:

[ ... ]

>> +
>> +config POWERCAP_EM
>> +        bool "Energy model based power capping"
>> +       depends on ENERGY_MODEL
>> +       default y
> 
> Don't make it default ;-)

Thanks for pointing this out :D

[ ... ]

>> +       pc_package = powercap_em_register(pct, "package", pc_soc,
>> +                                         &zone_ops, 1, &constraint_ops);
> 
> Will the soc and package hierarchy eventually be dynamically read from
> devicetree or similar and these hardcoded registration removed?

Yes, that's correct.

> For the rest of the devices, IMO, it makes sense to use the genpd
> hierarchy to reflect the powercap hierarchy. I whipped up the
> following patch to show how it might be achieved. What needs to be
> done is to now reflect the parent-child/sibling relationships of genpd
> into powercap. Initially I thought we'd need to additional DT
> properties in the genpd bindings but I think we might be able to read
> the device-specific energy model data directly to populate the
> powercap constraints.

We need a way to describe the power constraints relationship of the
domains to populate the hierarchy of the powercap directories.

In the DT it may look like that (very roughly):

power-constraints {
	power-constraint: package {
		compatible = "power-constraint,virtual";
	};

	power-constraint: perfdomain0 {
		compatible = "power-constraint,cpu";
		device = <&cpu_l0>;
		parent = <&package>;
	};

	power-constraint: perfdomain1 {
		compatible = "power-constraint,cpu";
		device = <&cpu_b0>;
		parent = <&package>;
	};

	power-constraint: gpu {
		compatible = "power-constraint,gpu";
		parent = <&package>
	};
};


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
