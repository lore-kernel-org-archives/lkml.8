Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E71A1C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 01:21:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5F8120737
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 01:21:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vg0WFDos"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727665AbgCZBVo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 21:21:44 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45324 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727556AbgCZBVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 21:21:43 -0400
Received: by mail-lj1-f196.google.com with SMTP id t17so4658214ljc.12;
        Wed, 25 Mar 2020 18:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qWf72sTi+DfPJzFkWpDTqdYgKhOjGmnLule3/VM/h6c=;
        b=Vg0WFDos92YnBWnT6RIwtqXZb9emrUGwWLA1uSucEIu02a2f0mmXsjeIeplvapx0Nw
         0JxC6cTh5RtUL8UTHSNjmKKTr/YZ00P/B/iOdAdg5ilGRvKi3InvKrcKwaJ1zFu68ONx
         jlfojV7dJ22dy1w9WxQqEYgb5jscwtHp2Bu5B9TdXcwoeEmvvd1b1V9hAfNEMgPl8Jgr
         7oNBMwHOl1zx/kTTNphnaO+JarTPG1r/5ydwkkorz3eNriFXn0rY+jImXrLxum2zRUQ/
         GaYxusKwhaD4eBRN4+ZA2hqWZa/Z2eSbA95lNfeKIlGmQ0v0v2TMdBbkbB4xG6Wl29zI
         32oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qWf72sTi+DfPJzFkWpDTqdYgKhOjGmnLule3/VM/h6c=;
        b=W2nXXSnxkcCpijrmjGCmBhgNrGpooTJ4mKDwa4d9joPaSTL/VAFYwV4sf5bs8jAByi
         VM3UkTQ+OlPDd78ykPhrZlpClKlc5nsyt8o6LRcq2QN7f+Bi/FBOG+w2PTe/iboE9bY1
         GdopbCkgKHtTIFwk8wcmrma2uPoJuPqJItsakZ8Y5nSD4jGcxNxkQ+ai3d4i6EFRWf+e
         sKhCq34en0R+U/sCgkp4qcHEnHTR5Uh1QsuqAbJbiT9+khLIhDbTkez0jbn8PXlMEPER
         4nhQMOFqFB9WkIW3HztMXzkbEOtW42Ok6mYanBeZaRt7i9HtTaZKQOa1SmBul8GM+s/1
         L09g==
X-Gm-Message-State: AGi0PuZG009UEhncOA182CufD3my+Ni0n6lc5HmmtOcH+z9XyF6x7xnP
        mcToZXZ6SjSIkPqlYgeoXXZPbCCL
X-Google-Smtp-Source: APiQypLUpnRCoKAUxn+NgNm2eKCzuUJxC1de2Q+g2SNO1RfZAMLzVqbS96P4irFJeIY5VoXf/zFcLg==
X-Received: by 2002:a2e:b00e:: with SMTP id y14mr3625840ljk.146.1585185700699;
        Wed, 25 Mar 2020 18:21:40 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.googlemail.com with ESMTPSA id o5sm366492lfb.52.2020.03.25.18.21.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Mar 2020 18:21:39 -0700 (PDT)
Subject: Re: [tip: timers/core] clocksource/drivers/timer-probe: Avoid
 creating dead devices
To:     Jon Hunter <jonathanh@nvidia.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        linux-kernel@vger.kernel.org,
        Saravana Kannan <saravanak@google.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-tip-commits@vger.kernel.org, x86 <x86@kernel.org>,
        liviu.dudau@arm.com, sudeep.holla@arm.com,
        lorenzo.pieralisi@arm.com,
        linux-tegra <linux-tegra@vger.kernel.org>
References: <20200111052125.238212-1-saravanak@google.com>
 <158460766637.28353.11325960928759668587.tip-bot2@tip-bot2>
 <20200324175955.GA16972@arm.com>
 <e75ae529-264c-9aa6-f711-2afe28ceec36@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <a34e69a2-9e55-b4a2-ed8f-06e315db612f@gmail.com>
Date:   Thu, 26 Mar 2020 04:21:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <e75ae529-264c-9aa6-f711-2afe28ceec36@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

26.03.2020 00:29, Jon Hunter пишет:
> 
> On 24/03/2020 17:59, Ionela Voinescu wrote:
>> Hi guys,
>>
>> On Thursday 19 Mar 2020 at 08:47:46 (-0000), tip-bot2 for Saravana Kannan wrote:
>>> The following commit has been merged into the timers/core branch of tip:
>>>
>>> Conommit-ID:     4f41fe386a94639cd9a1831298d4f85db5662f1e
>>> Gitweb:        https://git.kernel.org/tip/4f41fe386a94639cd9a1831298d4f85db5662f1e
>>> Author:        Saravana Kannan <saravanak@google.com>
>>> AuthorDate:    Fri, 10 Jan 2020 21:21:25 -08:00
>>> Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
>>> CommitterDate: Tue, 17 Mar 2020 13:10:07 +01:00
>>>
>>> clocksource/drivers/timer-probe: Avoid creating dead devices
>>>
>>> Timer initialization is done during early boot way before the driver
>>> core starts processing devices and drivers. Timers initialized during
>>> this early boot period don't really need or use a struct device.
>>>
>>> However, for timers represented as device tree nodes, the struct devices
>>> are still created and sit around unused and wasting memory. This change
>>> avoid this by marking the device tree nodes as "populated" if the
>>> corresponding timer is successfully initialized.
>>>
>>> Signed-off-by: Saravana Kannan <saravanak@google.com>
>>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>> Link: https://lore.kernel.org/r/20200111052125.238212-1-saravanak@google.com
>>> ---
>>>  drivers/clocksource/timer-probe.c | 2 ++
>>>  1 file changed, 2 insertions(+)
>>>
>>> diff --git a/drivers/clocksource/timer-probe.c b/drivers/clocksource/timer-probe.c
>>> index ee9574d..a10f28d 100644
>>> --- a/drivers/clocksource/timer-probe.c
>>> +++ b/drivers/clocksource/timer-probe.c
>>> @@ -27,8 +27,10 @@ void __init timer_probe(void)
>>>  
>>>  		init_func_ret = match->data;
>>>  
>>> +		of_node_set_flag(np, OF_POPULATED);
>>>  		ret = init_func_ret(np);
>>>  		if (ret) {
>>> +			of_node_clear_flag(np, OF_POPULATED);
>>>  			if (ret != -EPROBE_DEFER)
>>>  				pr_err("Failed to initialize '%pOF': %d\n", np,
>>>  				       ret);
>>>
>>
>> This patch is creating problems on some vexpress platforms - ones that
>> are using CLKSRC_VERSATILE (drivers/clocksource/timer-versatile.c).
>> I noticed issues on TC2 and FVPs (fixed virtual platforms) starting with
>> next-20200318 and still reproducible with next-20200323.
> 
> I am also seeing a regression on tegra30-cardhu-a04 when testing system
> suspend on -next. Bisect is pointing to this commit and reverting on top
> of -next fixes the problem. Unfortunately, there is no crash dump
> observed, but the device hangs somewhere when testing suspend.
> 
> I have not looked into this any further but wanted to report the problem.

IIUC, this should also break the watchdog driver on Tegra because the
device tree node is shared by both clocksource and watchdog.
