Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67EF5C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 18:52:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3773A204EF
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 18:52:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HbNQ1qSp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729295AbgE3SwS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 14:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729006AbgE3SwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 14:52:17 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55335C03E969
        for <linux-kernel@vger.kernel.org>; Sat, 30 May 2020 11:52:17 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id f5so7394091wmh.2
        for <linux-kernel@vger.kernel.org>; Sat, 30 May 2020 11:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SAP6DokjgrEskmM1jU8GCcgjlGjjKT89cK/sjstM7Wg=;
        b=HbNQ1qSp+F1lWXcq+VExZF2Kkqvl5tRlAWm1VcXy8ll7+Su9qwXI1kLshviJM2tm48
         WQ4l3/9ro6lpLVsBRoCfs2Pv+62CdayO0S4ZVrbC7F1CjIJ0l4bm26UTyd37RPstwhZ0
         VKhQ+NHIvlYZCXjMZwx41Wy0Gz5Mu4rzbYN0p+AWJ0tsT2IfzHfEaGI2E7bvv/9FfNDM
         u0OVKsxjUBMXy4lbkc0VUPDK7Cnblj4DOUubfdAaOUQSioQTGLFD0yV3ZtOqZx7Y+Zv9
         asq/1VOCa4F6FGweaaVHRGAmSWKUiNoVLJC01LWenjNHOED+ShDB3mGhlEnQixXFVwAM
         ztPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SAP6DokjgrEskmM1jU8GCcgjlGjjKT89cK/sjstM7Wg=;
        b=gWpMZdpOITjxvGtz390AqLtNXh0pM43RSiCYpSnSvF7DwdkrWfJPczaTtJwOSE73Jm
         JtnxibO4nUQ3TIt2fRDnSajarxGZrAuM7rxjA+agPAtf8eveVGwKAtFsThCtjIFnH+5r
         hN7PCVEl43sCHqJwJV4/kuZNeY1cxHpaiFz3vZpM3h/vnBv5jUEKF2tpT8J+zeX/dUR0
         7KM/Tq1fgNYFkTcKTO+rN4DdKezgRY5tynyqW6tVqcUhKNfEvlrqnLk5b4xgKSDJLdr2
         z/bDPZxDtT/ZwcanmXKv4YaGHvyIl4Bz8f5zXlmP/OW7YhQsU47b9Q/b7QCVRVmYNZQ7
         TRmw==
X-Gm-Message-State: AOAM531bgSMkf2u/aPdIYIX2x98fr3sHpUyWvV5h25UE4q3Roc2lOFvb
        zVsaBra0vw4Vz8x3F4tXPRQ=
X-Google-Smtp-Source: ABdhPJxzXP7pYgIEuFDXRX0DU7pUWFL0JwEKnL3J9dwnXtm7yRU1hfgcKIAkGhohsKMjlzo62Wo6Jw==
X-Received: by 2002:a1c:f708:: with SMTP id v8mr13853483wmh.131.1590864734327;
        Sat, 30 May 2020 11:52:14 -0700 (PDT)
Received: from [192.168.1.3] (ip68-111-84-250.oc.oc.cox.net. [68.111.84.250])
        by smtp.gmail.com with ESMTPSA id u13sm4245177wmm.6.2020.05.30.11.52.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 May 2020 11:52:13 -0700 (PDT)
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
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <92e9cb5a-48f3-5809-3ca7-427ee8b4f29e@gmail.com>
Date:   Sat, 30 May 2020 11:52:12 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <CANA+-vCDrE7Kmr3XspSCwCue1ic4tKyW=FuXS7PhsK0581_+Mg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/29/2020 4:14 PM, Tri Vo wrote:
> On Fri, May 29, 2020 at 3:37 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
>>
>> On 5/29/20 3:28 PM, Tri Vo wrote:
>>> On Fri, May 29, 2020 at 9:51 AM Rafael J. Wysocki
>>> <rafael.j.wysocki@intel.com> wrote:
>>>>
>>>> On 5/28/2020 10:46 PM, Florian Fainelli wrote:
>>>>> Hi,
>>>>>
>>>>> Commit c8377adfa78103be5380200eb9dab764d7ca890e ("PM / wakeup: Show
>>>>> wakeup sources stats in sysfs") is causing some of our tests to fail
>>>>> because /sys/class/net/*/device/power/wakeup_count is now 0, despite
>>>>> /sys/kernel/debug/wakeup_sources clearly indicating that the Ethernet
>>>>> device was responsible for system wake-up.
>>>>>
>>>>> What's more in looking at /sys/class/wakekup/wakeup2/event_count, we
>>>>> have the number of Wake-on-LAN wakeups recorded properly, but
>>>>> wakeup_count is desperately 0, why is that?
>>>>
>>>> I need to look at that commit in detail to find out what is going on.
>>>
>>> It would be helpful to see the contents of
>>> /sys/kernel/debug/wakeup_sources, /sys/class/net/*/device/power/*, and
>>> /sys/class/wakekup/* corresponding to the device in question. The
>>> values in these files are queried from the same struct wakeup_source.
>>> So it's odd if wakeup_count diverges.
>>
>> Most certainly, below is the information you want, the two cat
>> /s/k/d/wakeup_sources were done before Wake-on-LAN and after waking-up
>> from LAN. /sys/class/wakeup/wakeup2 maps to the Ethernet device.
>>
>> The Ethernet device calls pm_wakeup_event() against the struct device
>> that is embedded in the platform_device that it was probed with. I will
>> try to debug this myself over the weekend, time permitting.
>>
>>
>> # ethtool -s eth0 wol g
>> # cat /sys/kernel/debug/wakeup_sources
>> name            active_count    event_count     wakeup_count
>> expire_count    active_since    total_time      max_time        last_changep
>> revent_suspend_time
>> 47d580000.ethernet      0               0               0
>> 0               0               0               0               0  0
>> alarmtimer      0               0               0               0
>>         0               0               0               0          0
>> 47c408400.waketimer     2               2               0
>> 0               0               0               0               6144
>> 1               0
>> # pml -w20
>> [ 3449.937142] brcm-waketimer 47c408400.waketimer: Using sysfs
>> attributes, consider using 'rtcwake'
>> Pass 1 out of 1, mode=none, tp_al[ 3449.952654] PM: suspend entry (shallow)
>> l=1, cycle_tp=, sleep=, [ 3449.959004] Filesystems sync: 0.000 seconds
>> wakeup_time=20
>> [ 3449.965984] Freezing user space processes ... (elapsed 0.001 seconds)
>> done.
>> [ 3449.974087] OOM killer disabled.
>> [ 3449.977316] Freezing remaining freezable tasks ... (elapsed 0.006
>> seconds) done.
>> [ 3449.991114] printk: Suspending console(s) (use no_console_suspend to
>> debug)
>> AMS: System is entering S2...
>> [ 3450.022381] bcmgenet 47d580000.ethernet eth0: Link is Down
>> [ 3450.048340] Disabling non-boot CPUs ...
>> [ 3450.049344] CPU1: shutdown
>> [ 3450.050393] psci: CPU1 killed (polled 1 ms)
>> [ 3450.051332] Enabling non-boot CPUs ...
>> [ 3450.051712] Detected PIPT I-cache on CPU1
>> [ 3450.051812] CPU1: Booted secondary processor 0x0000000001 [0x410fd083]
>> [ 3450.052435] CPU1 is up
>> [ 3450.683588] bcmgenet 47d580000.ethernet eth0: Link is Up - 1Gbps/Full
>> - flow control rx/tx
>> [ 3450.729677] OOM killer enabled.
>> [ 3450.732908] Restarting tasks ... done.
>> [ 3450.738539] PM: suspend exit
>> ------------------------------
>> [ 3450.744239] brcm-waketimer 47c408400.waketimer: Using sysfs
>> attributes, consider using 'rtcwake'
>> # cat /sys/kernel/debug/wakeup_sources
>> name            active_count    event_count     wakeup_count
>> expire_count    active_since    total_time      max_time        last_changep
>> revent_suspend_time
>> 47d580000.ethernet      1               1               0
>> 0               0               0               0               3450
>> 054             0
>> alarmtimer      0               0               0               0
>>         0               0               0               0          0
>> 47c408400.waketimer     2               2               0
>> 0               0               0               0               6144
>> 1               0
>> # cat /sys/class/net/*/device/power/*
>> cat: read error: Input/output error
>> auto
>> 0
>> unsupported
>> 0
>> enabled
>> 0
>> 0
>> 1
>> 0
>> 0
>> 3450054
>> 0
>> 0
> 
> UUIC, 47d580000.ethernet is the device of interest here. It's
> wakeup_count was 0 before wake up, and we expect it to be 1 after wake
> up. One of the files you cat'ed here has a 1 in it. I can't tell which
> value corresponds to which file though, but I suspect that's
> wakeup_count.

That file is actually event_count which is not what is expected:

# sh print.sh
/sys/class/wakeup/wakeup2/uevent:
/sys/class/wakeup/wakeup2/event_count: 1
/sys/class/wakeup/wakeup2/max_time_ms: 0
/sys/class/wakeup/wakeup2/wakeup_count: 0
/sys/class/wakeup/wakeup2/total_time_ms: 0
/sys/class/wakeup/wakeup2/expire_count: 0
/sys/class/wakeup/wakeup2/active_count: 1
/sys/class/wakeup/wakeup2/last_change_ms: 3450054
/sys/class/wakeup/wakeup2/prevent_suspend_time_ms: 0
/sys/class/wakeup/wakeup2/name: 47d580000.ethernet
/sys/class/wakeup/wakeup2/active_time_ms: 0

-- 
Florian
