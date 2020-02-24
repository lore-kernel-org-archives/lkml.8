Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AE62C11D2F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 14:33:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F282820836
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 14:33:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QfjzaEZh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727746AbgBXOd0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 09:33:26 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:41054 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727640AbgBXOd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 09:33:26 -0500
Received: by mail-qv1-f65.google.com with SMTP id s7so4205968qvn.8
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 06:33:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KtVE+M/QzqjMA0LXVSAcGGMxNRrQrUffaB41/q7Jg7E=;
        b=QfjzaEZh6clLZyrsSHBjJB+To7NtJfJxhD5peI+XskEUG/RgcoA7WjXzki6TFtfVd9
         6pQwY/8J2YuRA9AJgCLb1JB6K8eGI03JqEjvUwBUR8jByLJl7WLLWDypOGdr4CRoyGUJ
         pPdBen41DO+mXyqv54p5ITDQBky8Bwj+bTkip5sjyG06mwrFCbIZpnQmHeIpoWRcEP0D
         Uvsw6A6s5FCzT9s74Y5An4aVXJXrRquWj+KsOGdaibeqtVYRc15SlGN1oe3cfcamxw4E
         21E+lbWk748iykOqWMR9E9+EF7ZYB6Nd1fu1tssSFnPAt37x/6F9mgDZ5Ywzz5YLpsSP
         qfTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KtVE+M/QzqjMA0LXVSAcGGMxNRrQrUffaB41/q7Jg7E=;
        b=K0uMCZ/vomwbD/enLSq7ex1LGk4DOdE9hQlasgoJdzwkcvtQznbFyYYNxiX1mrIXB6
         G4ZzLYEvtyQqTUauank1zmf0yL+L+gh9zTRmPmJanbzvRi+XlA6OFJOvr9ptWAG2M2W6
         RZtRGhuOkiqtav3MqUmJINWxviu37VCJQ1rBxPcz3KkHwZNHtcRV4nQIq+Fwfe6oJJ5F
         DCNRdm/zxwJLnz1BCvt+DsI/YWRcJ/egtHXzRQ54uInwd0D3yQyXicLeSuanusOadyPl
         m+P/YRfP1P3oKvdNwplSMJNq4TPww+TGcM+BDzmwSTVEkZCYp6EfHNjcvtUexAt8tSLk
         uQXw==
X-Gm-Message-State: APjAAAUeONepWtPJRNC+sD+fJEt3R0q5RymP7zwxZw5Y8PLs/JlE3bJA
        RT8LfClBmFSt4BKHTF7dKIkRPA==
X-Google-Smtp-Source: APXvYqx7/SfIzF+cHNZN/EI637voNvWoHEIAqnXo0ChgnO1pODCGwfLwDVJctrQiu4iLZ9qfO9weMA==
X-Received: by 2002:a0c:f6cd:: with SMTP id d13mr43722790qvo.20.1582554804777;
        Mon, 24 Feb 2020 06:33:24 -0800 (PST)
Received: from [192.168.1.92] (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.gmail.com with ESMTPSA id g2sm4813805qka.42.2020.02.24.06.33.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2020 06:33:24 -0800 (PST)
Subject: Re: [Patch v10 1/9] sched/pelt: Add support to track thermal pressure
To:     Randy Dunlap <rdunlap@infradead.org>, mingo@redhat.com,
        peterz@infradead.org, ionela.voinescu@arm.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rui.zhang@intel.com, qperret@google.com, daniel.lezcano@linaro.org,
        viresh.kumar@linaro.org, rostedt@goodmis.org, will@kernel.org,
        catalin.marinas@arm.com, sudeep.holla@arm.com,
        juri.lelli@redhat.com, corbet@lwn.net
Cc:     linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        javi.merino@kernel.org, amit.kucheria@verdurent.com
References: <20200222005213.3873-1-thara.gopinath@linaro.org>
 <20200222005213.3873-2-thara.gopinath@linaro.org>
 <db1a554a-1c8a-0078-def5-4b5f1ee68c99@infradead.org>
 <d7890dc4-f5d8-9bad-8473-062c0206da09@linaro.org>
 <a3102cf8-bb77-fed4-ffc7-8ef74e9feb23@infradead.org>
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <2c680a71-31ee-3a9a-4859-5c4cbc9dc0e1@linaro.org>
Date:   Mon, 24 Feb 2020 09:33:22 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <a3102cf8-bb77-fed4-ffc7-8ef74e9feb23@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/22/20 1:50 PM, Randy Dunlap wrote:
> On 2/22/20 10:27 AM, Thara Gopinath wrote:
>>
>>
>> On 2/21/20 7:59 PM, Randy Dunlap wrote:
>>> On 2/21/20 4:52 PM, Thara Gopinath wrote:
>>>> diff --git a/init/Kconfig b/init/Kconfig
>>>> index 2a25c769eaaa..8d56902efa70 100644
>>>> --- a/init/Kconfig
>>>> +++ b/init/Kconfig
>>>> @@ -464,6 +464,10 @@ config HAVE_SCHED_AVG_IRQ
>>>>        depends on IRQ_TIME_ACCOUNTING || PARAVIRT_TIME_ACCOUNTING
>>>>        depends on SMP
>>>>    +config HAVE_SCHED_THERMAL_PRESSURE
>>>> +    bool "Enable periodic averaging of thermal pressure"
>>>
>>> This prompt string makes this symbol user-configurable, but
>>> I don't think that's what you want here.
>>
>> Hi Randy,
>> Thank you for the review.
>> Actually I thought being user-configurable is a good idea as it will allow users to easily enable it and see if the benefits their systems. (I used menuconfig while developing, to enable it).
>> Do you see a reason why this should not be so?
>>
>>>
>>>> +    depends on SMP
>>>> +
>>>>    config BSD_PROCESS_ACCT
>>>>        bool "BSD Process Accounting"
>>>>        depends on MULTIUSER
> 
> Hi Thara,
> Is there some other way that HAVE_SCHED_THERMAL_PRESSURE can become
> set/enabled?  for example, is it selected by any other options?
> 
> The Kconfig symbols that begin with HAVE_ are usually something that
> are platform-specific and are usually set (selected) by other options,
> or they are "default y".
> 
> In init/Kconfig, I see 15 other HAVE_ Kconfig symbols,
> and none of them have user prompt strings.  They are either selected
> elsewhere or set inside their Kconfig block.
> 
> Maybe you just want to rename the Kconfig symbol so that it does not
> being with HAVE_.

  Hi Randy,

I see what you mean. I will send an update to this patch with HAVE_ 
removed. It is not selected by any other options. Best is for user to 
select it or platform/SoC configs to enable it.
> 
> 

-- 
Warm Regards
Thara
