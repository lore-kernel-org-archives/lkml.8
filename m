Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ABA5C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 09:28:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B21C2070A
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 09:28:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j804CPzg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbgCFJ2w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 04:28:52 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37578 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbgCFJ2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 04:28:51 -0500
Received: by mail-wr1-f65.google.com with SMTP id 6so1481918wre.4
        for <linux-kernel@vger.kernel.org>; Fri, 06 Mar 2020 01:28:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5yQoJXwrvo+WtRzZGUb19+x7EsnL6uep2cEHCqPc+Is=;
        b=j804CPzg1KtyMNP0P2LCDHyB+PjWdIoTmVXcCQq+qFy5Th3A1XhTQXjmBgNSdnsyZL
         Y7F6i4u+nir1nH9rdFLg3g8XYZt0RbeSjqZ15zT1SknVDRxYPdqGiOZ6pnWp2w0YMpw+
         0QuTKyUC0xaHQe9SB99ORqpmEQga0uV8MnftM8Z8CSB2dnDGLCdyLts0DK3QeCAt7Skn
         pgfasgPMHJJLIHhypJY/D0lFoGZyJHjHswJcuaiSyR2pyFns0xy33ZP/MUrH5rRqt1BO
         Ay8DzWEV3TPOZcdJZBgZVrqmljE2v5f6YLHW8ItoYfVjq3Iz3rcSW3JR27G9xFCghFXT
         K3fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=5yQoJXwrvo+WtRzZGUb19+x7EsnL6uep2cEHCqPc+Is=;
        b=N7RtOpLv7XDktGgTHZCnjP9GDEp7sa5MAa3lt96N1ht7OqEFjxeKliyIBthf0GBNl3
         RWduHixiPbpapZ43JGpxi9OFF03RvWva6TkmzX3d0UmwgsKIvTzXG3QX+VbhS5Vu9pgv
         hYpxyb2aFh4ffZ3/8gSPHhhbtavxH760PeB96jzN9kq8ckOCGvak86GNoZlPjEwDYnYx
         9iSgONJ5L6+64JZ9MYLa6n8IF5Nai+lkxtH++UE9/9apa79vJFw2tVwiH22zTKDQm94j
         Ad7kF0NSqRejjoGacj4mPxFePitxVPX2heEIAEW2HcWqAG8PUi3Zt1hWTXpfEFS29WR/
         QgmQ==
X-Gm-Message-State: ANhLgQ22OwGlHR7NhpTJF9BPAOuodEgx+tUpxL4bYLviR3QDIYBHqqoG
        waNd2X0W0ur6q9JWV6kXw07/lA==
X-Google-Smtp-Source: ADFU+vv0C4+GMl8xG++Pj9956yZbG2OfqIl0SNvZ9W0Ap+U1gQ4ziIQ7CF+BZt4U2gDKcHVpO5b20g==
X-Received: by 2002:adf:e68b:: with SMTP id r11mr2954493wrm.138.1583486928690;
        Fri, 06 Mar 2020 01:28:48 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:10d8:56c2:f55d:11e3? ([2a01:e34:ed2f:f020:10d8:56c2:f55d:11e3])
        by smtp.googlemail.com with ESMTPSA id m11sm1325470wrn.92.2020.03.06.01.28.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Mar 2020 01:28:47 -0800 (PST)
Subject: Re: [PATCH] sched: fair: Use the earliest break even
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        "open list:SCHEDULER" <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20200304114844.17700-1-daniel.lezcano@linaro.org>
 <jhjimjk16xi.mognet@arm.com>
 <a3ab2f17-92b8-20f7-50cd-060385ff655e@linaro.org>
 <jhjh7z40y6p.mognet@arm.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Autocrypt: addr=daniel.lezcano@linaro.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <1bb2f7db-7f7f-506c-f4b3-22787c30931f@linaro.org>
Date:   Fri, 6 Mar 2020 10:28:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <jhjh7z40y6p.mognet@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Valentin,

[cc'ing Thomas Gleixner]

On 04/03/2020 19:31, Valentin Schneider wrote:
> 
> On Wed, Mar 04 2020, Daniel Lezcano wrote:
>>> With that said, that comment actually raises a valid point: picking
>>> recently idled CPUs might give us warmer cache. So by using the break
>>> even stat, we can end up picking CPUs with colder caches (have been
>>> idling for longer) than the current logic would. I suppose more testing
>>> will tell us where we stand.
>>
>> Actually I'm not sure this comment still applies. If the CPU is powered
>> down, the cache is flushed or we can be picking up CPU with their cache
>> totally trashed by interrupt processing.
>>
>>>> +++ b/kernel/sched/sched.h
>>>> @@ -1015,6 +1015,7 @@ struct rq {
>>>>  #ifdef CONFIG_CPU_IDLE
>>>>       /* Must be inspected within a rcu lock section */
>>>>       struct cpuidle_state	*idle_state;
>>>> +	s64			break_even;
>>>
>>> Why signed? This should be purely positive, right?
>>
>> It should be, but s64 complies with the functions ktime_to_ns signature.
>>
>> static inline s64 ktime_to_ns(const ktime_t kt)
>>
> 
> Would there be harm then in simply storing:
> 
>   ktime_get_ns() + idle_state->exit_latency_ns
> 
> (which is u64)?

Actually I'm not sure, ktime_get_ns() is correct, it returns an u64 but
it is actually returning:

	return ktime_to_ns(ktime_get());

where ktime_to_ns is returning a s64.

There are the following functions:

static inline u64 ktime_get_coarse_ns(void)
static inline u64 ktime_get_coarse_real_ns(void)
static inline u64 ktime_get_coarse_boottime_ns(void)
static inline u64 ktime_get_coarse_clocktai_ns(void)
static inline u64 ktime_get_ns(void)
static inline u64 ktime_get_real_ns(void)
static inline u64 ktime_get_boottime_ns(void)
static inline u64 ktime_get_clocktai_ns(void)
static inline u64 ktime_get_raw_ns(void)

extern u64 ktime_get_mono_fast_ns(void);
extern u64 ktime_get_raw_fast_ns(void);
extern u64 ktime_get_boot_fast_ns(void);
extern u64 ktime_get_real_fast_ns(void);

They are all based on ktime_get_ns() which returns a s64.

Not sure this type mismatch was done on purpose or not.

Thomas?



-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

