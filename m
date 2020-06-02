Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DABEC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 01:30:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3A80206A4
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 01:30:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MRRpth0e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728449AbgFBBad (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 21:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728390AbgFBBac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 21:30:32 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B76CBC061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 18:30:32 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id fs4so597669pjb.5
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 18:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lPKPD4jUMApOZS8i8QV2BMWxx+MsEAh+NI2ZDLQ3XIg=;
        b=MRRpth0eLQ+GyTgwvmvuV9B1fXupW3ayEgwdwqbpu8ZcO6piS93DwqhYhcE8rglGLq
         XMInlF9mXknq3I40/aNcMc6jsJu2zc2swX4p6By00sxDhft+gtpEfJCRuEjAuqfy5Jyw
         68W0ZJYo7ad/TBmAaOuGByx03eDlBVJmXyWmRFKnhkRTfJMFYbRjQZb3V+YSzwG5OcEP
         3de/cPSMQ8PmhC0r3vTMlBKgf+VK6wI3XGKuxWOEOw6VENBktdhJE1X3hC9TaNWFkeLK
         YKn47JFGjmOamE8K+xiV4w+2D5rbJ9dS/bkv5UkmL/0XZ3KEacpg8XalZU3cAi7j/m4a
         p56g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lPKPD4jUMApOZS8i8QV2BMWxx+MsEAh+NI2ZDLQ3XIg=;
        b=KKv72S34th4e/ByHejbKrEQYxqNQwhF6S8N/ZaZyc1dENKTGOVZ358ZO4ub431mRnw
         me9JEZBrwL9IuW8r8jYqNchPPzXpahn5sivOhIeFQPAFlHPWLEnDpgpGQaJHxRskBNAS
         JcM5OCp+tMTvA24Zt0zMjK26GfttLh2n0mNYdKrcrA56rKdJpyUR8R6R7ZtrEncm/dPs
         v/CdRiCKrwghN/1qwUXpdpDNNkwQHrzWqE1k++4LzyEvA99YBFYmrHA3tAP7qqE21/+j
         8juUeWsWwu/kzXwsYs8AEo2motPcpvAVbYE5W7nqgUzNvBaOlBoG9ZA5YSbBICe/WBcY
         oOUA==
X-Gm-Message-State: AOAM531TNDGdHadnpXBI5dL0U/8rS5jvpsjRZeGqnrdDk4/XX9O7NZuo
        9FpA2dBMk1Jo/8CPMjd1HOZ7JEqx
X-Google-Smtp-Source: ABdhPJylYb87tEYhMgBgHmebGsK/v9kJ5TZVhlVMfrSBbqANAUKJOd5gTuXP/ltFtUbxNSfJsT2mvw==
X-Received: by 2002:a17:90a:17e9:: with SMTP id q96mr2570576pja.56.1591061432157;
        Mon, 01 Jun 2020 18:30:32 -0700 (PDT)
Received: from [10.230.188.43] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id v127sm545815pfv.99.2020.06.01.18.30.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jun 2020 18:30:31 -0700 (PDT)
Subject: Re: Regression with PM / wakeup: Show wakeup sources stats in sysfs"
To:     Tri Vo <trong@android.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Stephen Boyd <swboyd@chromium.org>
References: <11459cde-7f57-c95b-8cac-4301f0a2390e@gmail.com>
 <9d75a67b-87f0-161c-02d7-c9fc4efe97e7@intel.com>
 <CANA+-vBURc0ivB=UHXK5Xg_tVJOV_h9Uz_Ke4ZG3Gu_sMhfTvQ@mail.gmail.com>
 <78faec4a-bf98-a731-b505-a1ccfb6e4557@gmail.com>
 <CANA+-vCDrE7Kmr3XspSCwCue1ic4tKyW=FuXS7PhsK0581_+Mg@mail.gmail.com>
 <92e9cb5a-48f3-5809-3ca7-427ee8b4f29e@gmail.com>
 <CANA+-vBei-vRN0hFxYCDcm41k+j1cJXuE8MvpiZH_prrc--bhw@mail.gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <76a613a5-a55e-32ed-de72-91e51209b443@gmail.com>
Date:   Mon, 1 Jun 2020 18:30:30 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <CANA+-vBei-vRN0hFxYCDcm41k+j1cJXuE8MvpiZH_prrc--bhw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/30/2020 3:33 PM, Tri Vo wrote:
> On Sat, May 30, 2020 at 11:52 AM Florian Fainelli <f.fainelli@gmail.com> wrote:
>>
>>
>>
>> On 5/29/2020 4:14 PM, Tri Vo wrote:
>>> On Fri, May 29, 2020 at 3:37 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
>>>>
>>>> On 5/29/20 3:28 PM, Tri Vo wrote:
>>>>> On Fri, May 29, 2020 at 9:51 AM Rafael J. Wysocki
>>>>> <rafael.j.wysocki@intel.com> wrote:
>>>>>>
>>>>>> On 5/28/2020 10:46 PM, Florian Fainelli wrote:
>>>>>>> Hi,
>>>>>>>
>>>>>>> Commit c8377adfa78103be5380200eb9dab764d7ca890e ("PM / wakeup: Show
>>>>>>> wakeup sources stats in sysfs") is causing some of our tests to fail
>>>>>>> because /sys/class/net/*/device/power/wakeup_count is now 0, despite
>>>>>>> /sys/kernel/debug/wakeup_sources clearly indicating that the Ethernet
>>>>>>> device was responsible for system wake-up.
>>>>>>>
>>>>>>> What's more in looking at /sys/class/wakekup/wakeup2/event_count, we
>>>>>>> have the number of Wake-on-LAN wakeups recorded properly, but
>>>>>>> wakeup_count is desperately 0, why is that?
>>>>>>
>>>>>> I need to look at that commit in detail to find out what is going on.
>>>>>
>>>>> It would be helpful to see the contents of
>>>>> /sys/kernel/debug/wakeup_sources, /sys/class/net/*/device/power/*, and
>>>>> /sys/class/wakekup/* corresponding to the device in question. The
>>>>> values in these files are queried from the same struct wakeup_source.
>>>>> So it's odd if wakeup_count diverges.
>>>>
>>>> Most certainly, below is the information you want, the two cat
>>>> /s/k/d/wakeup_sources were done before Wake-on-LAN and after waking-up
>>>> from LAN. /sys/class/wakeup/wakeup2 maps to the Ethernet device.
>>>>
>>>> The Ethernet device calls pm_wakeup_event() against the struct device
>>>> that is embedded in the platform_device that it was probed with. I will
>>>> try to debug this myself over the weekend, time permitting.
>>>>
>>>>
>>>> # ethtool -s eth0 wol g
>>>> # cat /sys/kernel/debug/wakeup_sources
>>>> name            active_count    event_count     wakeup_count
>>>> expire_count    active_since    total_time      max_time        last_changep
>>>> revent_suspend_time
>>>> 47d580000.ethernet      0               0               0
>>>> 0               0               0               0               0  0
>>>> alarmtimer      0               0               0               0
>>>>         0               0               0               0          0
>>>> 47c408400.waketimer     2               2               0
>>>> 0               0               0               0               6144
>>>> 1               0
>>>> # pml -w20
>>>> [ 3449.937142] brcm-waketimer 47c408400.waketimer: Using sysfs
>>>> attributes, consider using 'rtcwake'
>>>> Pass 1 out of 1, mode=none, tp_al[ 3449.952654] PM: suspend entry (shallow)
>>>> l=1, cycle_tp=, sleep=, [ 3449.959004] Filesystems sync: 0.000 seconds
>>>> wakeup_time=20
>>>> [ 3449.965984] Freezing user space processes ... (elapsed 0.001 seconds)
>>>> done.
>>>> [ 3449.974087] OOM killer disabled.
>>>> [ 3449.977316] Freezing remaining freezable tasks ... (elapsed 0.006
>>>> seconds) done.
>>>> [ 3449.991114] printk: Suspending console(s) (use no_console_suspend to
>>>> debug)
>>>> AMS: System is entering S2...
>>>> [ 3450.022381] bcmgenet 47d580000.ethernet eth0: Link is Down
>>>> [ 3450.048340] Disabling non-boot CPUs ...
>>>> [ 3450.049344] CPU1: shutdown
>>>> [ 3450.050393] psci: CPU1 killed (polled 1 ms)
>>>> [ 3450.051332] Enabling non-boot CPUs ...
>>>> [ 3450.051712] Detected PIPT I-cache on CPU1
>>>> [ 3450.051812] CPU1: Booted secondary processor 0x0000000001 [0x410fd083]
>>>> [ 3450.052435] CPU1 is up
>>>> [ 3450.683588] bcmgenet 47d580000.ethernet eth0: Link is Up - 1Gbps/Full
>>>> - flow control rx/tx
>>>> [ 3450.729677] OOM killer enabled.
>>>> [ 3450.732908] Restarting tasks ... done.
>>>> [ 3450.738539] PM: suspend exit
>>>> ------------------------------
>>>> [ 3450.744239] brcm-waketimer 47c408400.waketimer: Using sysfs
>>>> attributes, consider using 'rtcwake'
>>>> # cat /sys/kernel/debug/wakeup_sources
>>>> name            active_count    event_count     wakeup_count
>>>> expire_count    active_since    total_time      max_time        last_changep
>>>> revent_suspend_time
>>>> 47d580000.ethernet      1               1               0
>>>> 0               0               0               0               3450
>>>> 054             0
>>>> alarmtimer      0               0               0               0
>>>>         0               0               0               0          0
>>>> 47c408400.waketimer     2               2               0
>>>> 0               0               0               0               6144
>>>> 1               0
>>>> # cat /sys/class/net/*/device/power/*
>>>> cat: read error: Input/output error
>>>> auto
>>>> 0
>>>> unsupported
>>>> 0
>>>> enabled
>>>> 0
>>>> 0
>>>> 1
>>>> 0
>>>> 0
>>>> 3450054
>>>> 0
>>>> 0
>>>
>>> UUIC, 47d580000.ethernet is the device of interest here. It's
>>> wakeup_count was 0 before wake up, and we expect it to be 1 after wake
>>> up. One of the files you cat'ed here has a 1 in it. I can't tell which
>>> value corresponds to which file though, but I suspect that's
>>> wakeup_count.
>>
>> That file is actually event_count which is not what is expected:
>>
>> # sh print.sh
>> /sys/class/wakeup/wakeup2/uevent:
>> /sys/class/wakeup/wakeup2/event_count: 1
>> /sys/class/wakeup/wakeup2/max_time_ms: 0
>> /sys/class/wakeup/wakeup2/wakeup_count: 0
>> /sys/class/wakeup/wakeup2/total_time_ms: 0
>> /sys/class/wakeup/wakeup2/expire_count: 0
>> /sys/class/wakeup/wakeup2/active_count: 1
>> /sys/class/wakeup/wakeup2/last_change_ms: 3450054
>> /sys/class/wakeup/wakeup2/prevent_suspend_time_ms: 0
>> /sys/class/wakeup/wakeup2/name: 47d580000.ethernet
>> /sys/class/wakeup/wakeup2/active_time_ms: 0
> 
> Thanks! Although 0 is not the expected wakeup_count, both
> /sys/kernel/debug/wakeup_sources and /sys/class/wakeup/* are reporting
> the same thing. So it's probably not an issue with how these values
> are reported. The underlying struct wakeup_source has 0 wakeup_count
> recorded.
> 
> How sure are you that commit c8377adfa78103be5380200eb9dab764d7ca890e
> introduces the regression? (That commit adds sysfs attributes to
> display wakeup source information, so it seems unlikely that actual
> wakeup event accounting is affected by it.)

Not anymore, it looks like my automated bisection was flawed, I will
restart it now and find out the offending commit when this started to
break. Thanks for reviewing the logs!
-- 
Florian
