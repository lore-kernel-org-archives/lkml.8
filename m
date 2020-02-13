Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5311CC2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 14:12:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26CF820873
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 14:12:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uudxXBwl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730204AbgBMOMP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 09:12:15 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:33406 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730078AbgBMOMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 09:12:14 -0500
Received: by mail-qt1-f195.google.com with SMTP id d5so4475945qto.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 06:12:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=UWVGrtC1xzF3CZGN2hTr0nJdmYUVr4tW24nwqjlUpQg=;
        b=uudxXBwlWr9Ec2e8mde/Q29p4Uuw8nAN8xG8oA870p+vX2GSPOno5ejEuyn2/Cfktg
         5DfIpWe/d5lL/OQxMVVk4jIxv8l7EISCQmP49batud1+uMss09n+b8U5lFAUu88Fu9KW
         4ltWG5mpr9Upa4IzIl/aZjdMbPgh/E0S8SA0Jbj4UctOd0k5UwwwHujxVDMwfHFuGrsA
         MMul/EbIjJznJhzhMR1vqwTAyAx68uKHBVTeyK3zcRUWHmpRebmsZf3dJpuIng6ONHaC
         gS8G7mvtwNXfRbBwYCZwfKF2rr5GzT3FbH03CeJM+BFj3ZEfrLhUSES4imaAO7pk8AYk
         ecAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=UWVGrtC1xzF3CZGN2hTr0nJdmYUVr4tW24nwqjlUpQg=;
        b=T0iHz1tNsH56B+L2C9fbb0vhr1pgMOkU6PCw+C7eMwdbUcdhnzE+jw0mQIx6Qo7zXn
         Y3ja9HQ5Hh4tWMI1GYt1+ZdxVyLKTPsTIhWTy0uIHHHnFjo4dh6Df+CW8WcAgSzmPpsl
         xOMyRcaSoI4rzys1n/aRsFuhaDXYGJBJcZ7rvRNwb0SRRgBUHIzd+HieHpJqhk0kLGde
         a/hXolpYqCLPhMZI/JInEkawWkteV1k37uF5nWa/AEOrSKSk0nwGLLbz8kMj/F1x/hXy
         FJc7vGNgvlemP9sV9AbTUijHhLEw/jpb0nrjrl3Il2eASe2UpFuDBOXjanj0jgK46ol2
         G92Q==
X-Gm-Message-State: APjAAAUQrp9EANnU6mceHFZToV8YdYIGEN9KHJSvuonPKx5i9PU2fRlD
        D210IjsSwGsHv/HoSeHYZmiiDg==
X-Google-Smtp-Source: APXvYqw8QRDmHJF+ap/br2Tx5RRLxzn7Rp3FB7sDZpyyzOf08dFuLFBG82coWY3t2v9WvHHQYmQgVA==
X-Received: by 2002:ac8:5055:: with SMTP id h21mr23876387qtm.30.1581603133949;
        Thu, 13 Feb 2020 06:12:13 -0800 (PST)
Received: from [192.168.1.169] (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.gmail.com with ESMTPSA id q21sm1356651qkj.102.2020.02.13.06.12.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Feb 2020 06:12:13 -0800 (PST)
Subject: Re: [Patch v9 5/8] sched/fair: update cpu_capacity to reflect thermal
 pressure
To:     Amit Kucheria <amit.kucheria@verdurent.com>
References: <1580250967-4386-1-git-send-email-thara.gopinath@linaro.org>
 <1580250967-4386-6-git-send-email-thara.gopinath@linaro.org>
 <CAHLCerM1SeZWZa3-1bjtZHS-d1d9=yKGDt=ZQTpbYqPZFBGwkg@mail.gmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, ionela.voinescu@arm.com,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Zhang Rui <rui.zhang@intel.com>, qperret@google.com,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>, corbet@lwn.net,
        LKML <linux-kernel@vger.kernel.org>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Javi Merino <javi.merino@kernel.org>
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <5E45593C.2030600@linaro.org>
Date:   Thu, 13 Feb 2020 09:12:12 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <CAHLCerM1SeZWZa3-1bjtZHS-d1d9=yKGDt=ZQTpbYqPZFBGwkg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/13/2020 07:47 AM, Amit Kucheria wrote:
> On Wed, Jan 29, 2020 at 4:06 AM Thara Gopinath
> <thara.gopinath@linaro.org> wrote:
>>
>> cpu_capacity initially reflects the maximum possible capacity of a cpu.
>> Thermal pressure on a cpu means this maximum possible capacity is
>> unavailable due to thermal events. This patch subtracts the average thermal
>> pressure for a cpu from its maximum possible capacity so that cpu_capacity
>> reflects the actual maximum currently available capacity.
>>
>> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
>> ---
>>
>> v8->v9:
>>         - Use thermal_load_avg to read rq->avg_thermal.load_avg.
>>
>>  kernel/sched/fair.c | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 5f58c03..d879077 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -7753,8 +7753,15 @@ static unsigned long scale_rt_capacity(struct sched_domain *sd, int cpu)
>>         if (unlikely(irq >= max))
>>                 return 1;
>>
>> +       /*
>> +        * avg_rt.util avg and avg_dl.util track binary signals
> 
> For avg_rt, s/util avg/util_avg/
> For avg_dl, s/util/util_avg/    ?

Yep. Will fix it.

> 
>> +        * (running and not running) with weights 0 and 1024 respectively.
>> +        * avg_thermal.load_avg tracks thermal pressure and the weighted
>> +        * average uses the actual delta max capacity(load).
>> +        */
>>         used = READ_ONCE(rq->avg_rt.util_avg);
>>         used += READ_ONCE(rq->avg_dl.util_avg);
>> +       used += thermal_load_avg(rq);
>>
>>         if (unlikely(used >= max))
>>                 return 1;
>> --
>> 2.1.4
>>


-- 
Warm Regards
Thara
