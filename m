Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E8A2C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 15:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B7D0206A4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 15:53:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728590AbgFKPxX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 11:53:23 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:55947 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728649AbgFKPxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 11:53:21 -0400
Received: from mail-pf1-f199.google.com ([209.85.210.199])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <alex.hung@canonical.com>)
        id 1jjPW3-00005f-1O
        for linux-kernel@vger.kernel.org; Thu, 11 Jun 2020 15:53:19 +0000
Received: by mail-pf1-f199.google.com with SMTP id y16so4790004pfp.11
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 08:53:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=py21r8N7J3kdOfOe9CdPL7ULZnWM2zECpY1Cr6mg3K0=;
        b=kPGxV2JFf/EZmhOP5UmGOhbNQcKE/akPN/xFGo9MGeAyrQpfCMpC6NlVnH1Zg4WHKC
         hfy5UkYFXWo46p76gZN0+PXtgE+GzPtDd8J88dg9gaTocswGrwM4NAyjlty9wRpkDuIL
         msCZR2flOucYSJNgEp6Vo+xKMcY5XSBvQDDhDgE9xln8XPKmjAgTb1mJZWAEdAr7oj5t
         QOAioLYnXqQD90JCxSf2a8prN2BmGw+sm5Dti0N0gix5qyFre5ci1lc6fdOVEdCWlTMc
         lDfD08ctyaDIx0hDWR8l79jDPIAYC9UfIOyWjNK1Sr7NbUKWJk7lbHowIvs+CO+AxRyH
         q+hA==
X-Gm-Message-State: AOAM530YIFJ7RByF0HUzRJR/GcS+PbDpPiGnJYM1SRSqazK785aPSijd
        S/seeO2GIWetxg3GilnDaVfOP0/AE1YhYgnvDkV2fZEUpns+9kyK6Jh6SyqAmmjhkmEDI0vCQ1q
        hqg7+1stHNNhn7fBtunGuos3TWsTteFOWI6KCRA+tIw==
X-Received: by 2002:a63:7d1:: with SMTP id 200mr2123696pgh.117.1591890797071;
        Thu, 11 Jun 2020 08:53:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzpKJ7/y13HZqbfsiEwBtbgXcSOLDaHNJMgwNSkcL9qzGKBCJbNK+S5uZIpaCNJdi7+KOD4Kw==
X-Received: by 2002:a63:7d1:: with SMTP id 200mr2123675pgh.117.1591890796595;
        Thu, 11 Jun 2020 08:53:16 -0700 (PDT)
Received: from [192.168.0.119] (d66-222-144-129.abhsia.telus.net. [66.222.144.129])
        by smtp.gmail.com with ESMTPSA id z85sm3635610pfc.66.2020.06.11.08.53.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jun 2020 08:53:16 -0700 (PDT)
Subject: Re: [PATCH] platform/x86: intel-hid: Use hp-wireless for rfkill on HP
 platforms
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Mario.Limonciello@dell.com, dvhart@infradead.org,
        andy@infradead.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200610153747.27040-1-kai.heng.feng@canonical.com>
 <4d0714fe5e2548b6b638ea447ad19490@AUSX13MPC105.AMER.DELL.COM>
 <0affa00e-8a52-9e29-56d4-39dff952d736@canonical.com>
 <A98FC3F7-2295-4B49-95DD-1D861BC56B9A@canonical.com>
From:   Alex Hung <alex.hung@canonical.com>
Message-ID: <0c381c46-a4ab-b973-8ed6-4bc8aa06022a@canonical.com>
Date:   Thu, 11 Jun 2020 09:53:15 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <A98FC3F7-2295-4B49-95DD-1D861BC56B9A@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-06-11 1:24 a.m., Kai-Heng Feng wrote:
> 
> 
>> On Jun 11, 2020, at 01:41, Alex Hung <alex.hung@canonical.com> wrote:
>>
>> On 2020-06-10 9:49 a.m., Mario.Limonciello@dell.com wrote:
>>>> -----Original Message-----
>>>> From: platform-driver-x86-owner@vger.kernel.org <platform-driver-x86-
>>>> owner@vger.kernel.org> On Behalf Of Kai-Heng Feng
>>>> Sent: Wednesday, June 10, 2020 10:38 AM
>>>> To: alex.hung@canonical.com
>>>> Cc: Kai-Heng Feng; Darren Hart; Andy Shevchenko; open list:INTEL HID EVENT
>>>> DRIVER; open list
>>>> Subject: [PATCH] platform/x86: intel-hid: Use hp-wireless for rfkill on HP
>>>> platforms
>>>>
>>>>
>>>> [EXTERNAL EMAIL]
>>>>
>>>> Wireless hotkey on HP platforms can trigger two events, if both
>>>> hp-wireless and intel-hid are supported. Two events at the same time
>>>> renders wireless hotkey useless.
>>>>
>>>> HP confirmed that hp-wireless (HPQ6001) should always be the canonical
>>>> source of wireless hotkey event, so skip registering rfkill hotkey if
>>>> HPQ6001 is present.
>>>>
>>>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>>>> ---
>>>> drivers/platform/x86/intel-hid.c | 31 ++++++++++++++++++++++++++++++-
>>>> 1 file changed, 30 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/platform/x86/intel-hid.c b/drivers/platform/x86/intel-
>>>> hid.c
>>>> index 9ee79b74311c..31091c8faf70 100644
>>>> --- a/drivers/platform/x86/intel-hid.c
>>>> +++ b/drivers/platform/x86/intel-hid.c
>>>> @@ -25,6 +25,8 @@ static const struct acpi_device_id intel_hid_ids[] = {
>>>> };
>>>> MODULE_DEVICE_TABLE(acpi, intel_hid_ids);
>>>>
>>>> +static bool hp_wireless_present;
>>>> +
>>>> /* In theory, these are HID usages. */
>>>> static const struct key_entry intel_hid_keymap[] = {
>>>> 	/* 1: LSuper (Page 0x07, usage 0xE3) -- unclear what to do */
>>>> @@ -49,6 +51,29 @@ static const struct key_entry intel_hid_keymap[] = {
>>>> 	{ KE_END },
>>>> };
>>>>
>>>> +static const struct key_entry intel_hid_no_rfkill_keymap[] = {
>>>> +	/* 1: LSuper (Page 0x07, usage 0xE3) -- unclear what to do */
>>>> +	/* 2: Toggle SW_ROTATE_LOCK -- easy to implement if seen in wild */
>>>> +	{ KE_KEY, 3, { KEY_NUMLOCK } },
>>>> +	{ KE_KEY, 4, { KEY_HOME } },
>>>> +	{ KE_KEY, 5, { KEY_END } },
>>>> +	{ KE_KEY, 6, { KEY_PAGEUP } },
>>>> +	{ KE_KEY, 7, { KEY_PAGEDOWN } },
>>>> +	/* 8: rfkill -- use hp-wireless instead */
>>>> +	{ KE_KEY, 9, { KEY_POWER } },
>>>> +	{ KE_KEY, 11, { KEY_SLEEP } },
>>>> +	/* 13 has two different meanings in the spec -- ignore it. */
>>>> +	{ KE_KEY, 14, { KEY_STOPCD } },
>>>> +	{ KE_KEY, 15, { KEY_PLAYPAUSE } },
>>>> +	{ KE_KEY, 16, { KEY_MUTE } },
>>>> +	{ KE_KEY, 17, { KEY_VOLUMEUP } },
>>>> +	{ KE_KEY, 18, { KEY_VOLUMEDOWN } },
>>>> +	{ KE_KEY, 19, { KEY_BRIGHTNESSUP } },
>>>> +	{ KE_KEY, 20, { KEY_BRIGHTNESSDOWN } },
>>>> +	/* 27: wake -- needs special handling */
>>>> +	{ KE_END },
>>>> +};
>>>> +
>>>> /* 5 button array notification value. */
>>>> static const struct key_entry intel_array_keymap[] = {
>>>> 	{ KE_KEY,    0xC2, { KEY_LEFTMETA } },                /* Press */
>>>> @@ -317,7 +342,8 @@ static int intel_hid_input_setup(struct platform_device
>>>> *device)
>>>> 	if (!priv->input_dev)
>>>> 		return -ENOMEM;
>>>>
>>>> -	ret = sparse_keymap_setup(priv->input_dev, intel_hid_keymap, NULL);
>>>> +	ret = sparse_keymap_setup(priv->input_dev, hp_wireless_present ?
>>>> +			intel_hid_no_rfkill_keymap : intel_hid_keymap, NULL);
>>>> 	if (ret)
>>>> 		return ret;
>>>>
>>>> @@ -575,6 +601,9 @@ check_acpi_dev(acpi_handle handle, u32 lvl, void
>>>> *context, void **rv)
>>>> 			dev_info(&dev->dev,
>>>> 				 "intel-hid: created platform device\n");
>>>>
>>>> +	if (!strcmp(acpi_device_hid(dev), "HPQ6001"))
>>>> +		hp_wireless_present = true;
>>
>> (Resend with format removed)
>>
>> This can impact all HP systems that do not have this problem.
> 
> HP is certain that HPQ6001 should always be used over INT33D5.

and OEMs can change all the time.

> 
> If this patch breaks other platform, then we should fix HPQ6001 instead.

Looks like a firmware bug, and this is a workaround.

In this case, both HP6001 and INT33D5 receive wireless toggle events -
which is an incorrect firmware behaviour.

In scenario that both HP6001 and INT33D5 are present and wireless toggle
events are only sent to INT33D5 (a correct firmware behaviour), this
patch will break and this is concerning.

> 
>> How about
>> a DMI quirk that is limited to this particular system?
> 
> We should avoid using DMI quirk for this one, as this is to follow the HP's spec.

INT33D5 is defined by Intel, and HP spec says an event from HP6001, and
nothing about interactions with INT33D5.

Workarounds are unavoidable. It doesn't have to be DMI quirks but it has
to be done without affecting good systems.

> 
> Kai-Heng
> 
>>
>>
>>>
>>> Just having the ACPI device present doesn't actually mean that the user
>>> has a kernel compiled with hp-wireless or that it has finished initializing.
>>>
>>> I would think this needs a better handshake in case hp-wireless was unloaded
>>> or not present so the event could still come through intel-hid in this
>>> circumstance.
>>>
>>>> +
>>>> 	return AE_OK;
>>>> }
>>>>
>>>> --
>>>> 2.17.1
>>>
>>
>>
>> -- 
>> Cheers,
>> Alex Hung
> 


-- 
Cheers,
Alex Hung
