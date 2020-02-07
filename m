Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DD36C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 22:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B23B21775
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 22:42:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kUFJMdRY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbgBGWmZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 17:42:25 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:41794 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726947AbgBGWmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 17:42:25 -0500
Received: by mail-qt1-f196.google.com with SMTP id l19so641453qtq.8
        for <linux-kernel@vger.kernel.org>; Fri, 07 Feb 2020 14:42:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=b8ELsuL/4y/dUcHo4qnKyfHC0iWe18inSa5wdgKcHxo=;
        b=kUFJMdRYsNQuOdrZ+ABMAyIosWWcZCk8bVtE09I5nBZk150XJ8ccNCwLhwPDtiZ6SP
         g84G9A94zFls5rr4/PNlY+MRl5nS6BKRw8rZZRsnQuGRYWIEbye5mx3A4BOoYjCUzGTW
         XAIFkDqCM0eM/FK4DhA2H8gPoPGToEt57dXh7Phsq38A5xf5+a9SmkJYMI4IbmSVSHg1
         4Ayln3HuEqHZ7h0LYftHWOoW02wUVgEFTBKS36wKEbdm5cUkF1Wyke0UmymG/50xMSrz
         +rPmhZoWYM53b+PoN8+q4kq2ahMsSkMOt9vajE4uAG5CH6IpZfowhJq9oU2YNXOOBF1O
         pDqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=b8ELsuL/4y/dUcHo4qnKyfHC0iWe18inSa5wdgKcHxo=;
        b=srRAJPVgOlkFb00s8gctpFC9dTN+cAuKFDCE6OgQYn7YtovuY5mijpPoHYkaucAm/3
         v00TwR1l3enrDMITSUtcIYgw36mwS9MkTOn9TiC2c8nErsEs3tAxybE4K47b/r7vzbkX
         KLA2KvKp4paA07X3NPjfLvqGSpnsRgvvszECli8+hUpayvR01Aw3kOMsBJWY6+srj4zt
         8UPBKOujo9eCM2Uhe2wHpsNpvSbAoSnViaoC7Ms1ugr/5TQ4usbc4O1VCk2lwQJlblU3
         nOPEJP8SORFKHiFCVoVm0KYYzfSeMZMbgI/X0hHEr20sGp2Tw3oH2oxfKzn1YJNEqatL
         2Tpg==
X-Gm-Message-State: APjAAAUOiLGIVMQUq5dee7DrN/ITDqHSNDE6HPcDNaNKAYl8FFLly5Vu
        sO1TD9MDTVGLhiyr4YEY+mZcqvvdMyw54g==
X-Google-Smtp-Source: APXvYqzItnSeeiyruaBgKjwA8c9GpIQShz/uAt6QeYtx5HVfnYN2TfA/Reop+IjxDGY+J0+3a42l/A==
X-Received: by 2002:ac8:1977:: with SMTP id g52mr625423qtk.18.1581115342812;
        Fri, 07 Feb 2020 14:42:22 -0800 (PST)
Received: from [192.168.1.169] (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.gmail.com with ESMTPSA id g18sm2019071qki.13.2020.02.07.14.42.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Feb 2020 14:42:22 -0800 (PST)
Subject: Re: [Patch v9 7/8] sched/fair: Enable tuning of decay period
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Peter Zijlstra <peterz@infradead.org>
References: <1580250967-4386-1-git-send-email-thara.gopinath@linaro.org>
 <1580250967-4386-8-git-send-email-thara.gopinath@linaro.org>
 <4eb10687-1a62-cee3-7285-3f50cc023071@infradead.org>
 <5E380D1D.7020500@linaro.org>
 <20200203155549.GL14914@hirez.programming.kicks-ass.net>
 <cc83634f-b3af-6024-7f89-9b231b153070@arm.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>, mingo@redhat.com,
        ionela.voinescu@arm.com, vincent.guittot@linaro.org,
        rui.zhang@intel.com, qperret@google.com, daniel.lezcano@linaro.org,
        viresh.kumar@linaro.org, rostedt@goodmis.org, will@kernel.org,
        catalin.marinas@arm.com, sudeep.holla@arm.com,
        juri.lelli@redhat.com, corbet@lwn.net,
        linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        javi.merino@kernel.org, amit.kucheria@verdurent.com
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <5E3DE7CC.3060300@linaro.org>
Date:   Fri, 7 Feb 2020 17:42:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <cc83634f-b3af-6024-7f89-9b231b153070@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/04/2020 03:39 AM, Dietmar Eggemann wrote:
> On 03/02/2020 16:55, Peter Zijlstra wrote:
>> On Mon, Feb 03, 2020 at 07:07:57AM -0500, Thara Gopinath wrote:
>>> On 01/28/2020 06:56 PM, Randy Dunlap wrote:
>>>> Hi,
>>>>
>>>> On 1/28/20 2:36 PM, Thara Gopinath wrote:
>>>>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>>>>> index e35b28e..be4147b 100644
>>>>> --- a/Documentation/admin-guide/kernel-parameters.txt
>>>>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>>>>> @@ -4376,6 +4376,11 @@
>>>>>  			incurs a small amount of overhead in the scheduler
>>>>>  			but is useful for debugging and performance tuning.
>>>>>  
>>>>> +	sched_thermal_decay_shift=
>>>>> +			[KNL, SMP] Set decay shift for thermal pressure signal.
>>>>> +			Format: integer between 0 and 10
>>>>> +			Default is 0.
>>>>> +
>>>>
>>>> That tells an admin [or any reader] almost nothing about this kernel parameter
>>>> or what it does.  And nothing about what unit the value is in.
>>>> Does the value 0 disable this feature?
>>>
>>> Thanks for the review. 0 does not disable "thermal pressure" feature. 0
>>> means the default decay period for averaging PELT signals (which is
>>> usually 32 but configurable) will also be applied for thermal pressure
>>> signal. A shift will shift the default decay period.
>>>
>>> You are right. It needs more explanation here. I will fix it and send v10.
>>
>> Or just send an update for this patch? I'm thinking most of this is
>> looking good.
> 
> I do agree. IMHO, there are just two little things outstanding:
> 
> (1) arch_scale_thermal_pressure() instead  of
>     arch_cpu_thermal_pressure() in v8 4/7

The "scale_" part was discussed in v6. Ionela had suggested that having
"scale" is not suited for this function because "thermal pressure" is
not exactly scaled but subtracted. I actually agree with that.

https://lore.kernel.org/lkml/20191223175005.GA31446@arm.com/

Having said that if everyone feel the same about naming of this
function, I can change it one last time.

> 
> (2) guarding of thermal pressure code in Arm's arch_topology driver  w/
>     CONFIG_HAVE_SCHED_THERMAL_PRESSURE plus disabling it by default for
>     Arm64.
It was enabled by default as per your suggestion in v9.

The patch can be dropped.

I don't understand the need to guard arch_topology with
CONFIG_HAVE_SCHED_THERMAL_PRESSURE. CONFIG_HAVE_SCHED_THERMAL_PRESSURE
is for scheduler to enable/disable averaging of thermal pressure. We
wanted to separate updating and retrieving of instantaneous thermal
pressure from scheduler. Guarding it with
CONFIG_HAVE_SCHED_THERMAL_PRESSURE is to me equivalent to putting back
this whole code in the scheduler framework. I am against it. I also do
not see other arch_ functions guarded similarly.

> 


-- 
Warm Regards
Thara
