Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6937C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 15:01:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAD6124649
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 15:01:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rkxaeZPM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729499AbgBNPBJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 10:01:09 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:44651 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729268AbgBNPBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 10:01:08 -0500
Received: by mail-qk1-f196.google.com with SMTP id v195so9420043qkb.11
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 07:01:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=PZM2aXQLz6EGVmRob1//c/oSoiPKekrSfa4uLtVv4nQ=;
        b=rkxaeZPMCtLStsYRndTgSrzO9UsxBW9lI3HGrZM5t8dv8MUzFk8tTMiwDRecR6vlna
         M0dFl8n80k6Q+TTHqnUCklACuoCYTemyZGG+/qhjbP3NBMpr8qhjaeu+1KCNtB8yZOkj
         gS/H8Mfqm43tAd5J+PFMigStoFTrx5j3g6EHv38rk/iBL90FAzC6VJzWbN4lUddOqPQ5
         oMNUSJZIHmNhXF2q5LLEcev+MRuGoBdz0t1yYjHkYlZPAWyB4FrwwV0yQtrOGqE3U/ID
         psAumSjUzo6pUxluoQTl7PeGpeFyxmGwmf0alzjPFqQRRwaH6QGPVfiVMQuXyDXUC8OW
         xlIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=PZM2aXQLz6EGVmRob1//c/oSoiPKekrSfa4uLtVv4nQ=;
        b=F6I96Ax5dyg4/m4B1trXu/o+SMPLQuSsvZKy+LOrxKoDqh7+QDAqxNUfbZDgpRzwx/
         62rioXY6j/FdLDorz6e/0lIH8q9zoyDxLmVSPrR2X3eivy3UICSjOR4yJ8p76CskC8Fh
         9Zq7AYkU1C89m3b8caAgorj8uKSp/nuqUijIvq+k3k3XS/8MkMiPkzuMc0xTnMSTpZNe
         vvL1UTJY1YVKisAxzA/Uu1igW/RIysP0UWYFPfhhvOvZ+y2V711rDe5g84QpE4irvp0k
         /cIiKmPJhDWJw+sL+yitjAFu1I0umUwaEgoYFIrSdTZSa1cifhi34h106GmjL/fb3r43
         WOAg==
X-Gm-Message-State: APjAAAVG2SwzHwDSl1V/joX8oggSdXtYWODgKT3qJTo6pk8az+PW8YAf
        se8mJthtmUlCXuCYbc3skxIHQw==
X-Google-Smtp-Source: APXvYqzxwWwbQc8Fy9WaLsQmAQYUqbdW45CKA6H5ACMS/PUyQwXmLIjwnHZy9GwxqU24tCgfl/swoQ==
X-Received: by 2002:a37:9d44:: with SMTP id g65mr2716368qke.15.1581692467642;
        Fri, 14 Feb 2020 07:01:07 -0800 (PST)
Received: from [192.168.1.169] (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.gmail.com with ESMTPSA id h14sm3355056qke.99.2020.02.14.07.01.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Feb 2020 07:01:06 -0800 (PST)
Subject: Re: [Patch v9 3/8] arm,arm64,drivers:Add infrastructure to store and
 update instantaneous thermal pressure
To:     Amit Kucheria <amit.kucheria@verdurent.com>
References: <1580250967-4386-1-git-send-email-thara.gopinath@linaro.org>
 <1580250967-4386-4-git-send-email-thara.gopinath@linaro.org>
 <CAHLCerMEieWMyk8RcM-y8c3Usq_e5CTYJ4AqhCQOzihRTUWbTg@mail.gmail.com>
 <5E4557B1.8020809@linaro.org>
 <CAHLCerNB3qSRG0cz+bW50h00Nbz+3s0rW0sjWjK5NL+6CbV2WA@mail.gmail.com>
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
Message-ID: <5E46B631.5020406@linaro.org>
Date:   Fri, 14 Feb 2020 10:01:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <CAHLCerNB3qSRG0cz+bW50h00Nbz+3s0rW0sjWjK5NL+6CbV2WA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/13/2020 09:38 AM, Amit Kucheria wrote:
> On Thu, Feb 13, 2020 at 7:35 PM Thara Gopinath
> <thara.gopinath@linaro.org> wrote:
>>
>> On 02/13/2020 07:25 AM, Amit Kucheria wrote:
>>> On Wed, Jan 29, 2020 at 4:06 AM Thara Gopinath
>>> <thara.gopinath@linaro.org> wrote:
>>>>
>>>> Add architecture specific APIs to update and track thermal pressure on a
>>>> per cpu basis. A per cpu variable thermal_pressure is introduced to keep
>>>> track of instantaneous per cpu thermal pressure. Thermal pressure is the
>>>> delta between maximum capacity and capped capacity due to a thermal event.
>>>
>>> s/capped/decreased to have consistent use throughout the series e.g. in patch 1.
>>>
>>> Though personally, I like "capped capacity"  in which case
>>> s/decreased/capped in patch 1 and elsewhere.
>>
>> I will fix this
>>>
>>>>
>>>> topology_get_thermal_pressure can be hooked into the scheduler specified
>>>> arch_cpu_thermal_capacity to retrieve instantaneous thermal pressure of a
>>>> cpu.
>>>>
>>>> arch_set_thermal_pressure can be used to update the thermal pressure.
>>>>
>>>> Considering topology_get_thermal_pressure reads thermal_pressure and
>>>> arch_set_thermal_pressure writes into thermal_pressure, one can argue for
>>>> some sort of locking mechanism to avoid a stale value.  But considering
>>>> topology_get_thermal_pressure can be called from a system critical path
>>>> like scheduler tick function, a locking mechanism is not ideal. This means
>>>> that it is possible the thermal_pressure value used to calculate average
>>>> thermal pressure for a cpu can be stale for upto 1 tick period.
>>>>
>>>> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
>>>> ---
>>>>
>>>> v6->v7:
>>>>         - Changed the input argument in arch_set_thermal_pressure from
>>>>           capped capacity to delta capacity(thermal pressure) as per
>>>>           Ionela's review comments.
>>>>
>>>>  arch/arm/include/asm/topology.h   |  3 +++
>>>>  arch/arm64/include/asm/topology.h |  3 +++
>>>
>>> Any particular reason to enable this for arm/arm64 in this patch
>>> itself? I'd have enabled them in two separate patches after this one.
>>
>> No reason. No reason not to as well as arch_topology is "Arm specific
>> cpu topology file" and changes are one-liners.
> 
> One reason to do this, IMHO, is to keep platform conversions separate
> from the core infrastructure in a series, so the core can get merged
> while platform maintainers can take their time to decide if, when, how
> to merge this.

That makes sense. I will split it out. I did not think of it from a
merging point of view.

> 


-- 
Warm Regards
Thara
