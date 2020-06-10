Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A28DFC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 17:41:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 881FE204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 17:41:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbgFJRlO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 13:41:14 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:46896 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbgFJRlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 13:41:13 -0400
Received: from mail-pf1-f197.google.com ([209.85.210.197])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <alex.hung@canonical.com>)
        id 1jj4is-0000ht-Tb
        for linux-kernel@vger.kernel.org; Wed, 10 Jun 2020 17:41:11 +0000
Received: by mail-pf1-f197.google.com with SMTP id 137so2402231pfw.5
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 10:41:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nuT88j+Mklv7GLmEhalqmxpxwoOBOcrzhFFLKY+heTQ=;
        b=Yv0ajVmOPfXDR5v/iHA+gOsN+jJv82KLLnjvY6o20+LfuB9fbIlQf/bWqEPPARsWJa
         L6KpfN2SqkS4PKy2PM8lzcFplQkkCmoXHJCiBmz5xAFT+0xFZMaFwt7OxKmFjNdbPlDt
         yH1IZYxhSV17sI4Us0qopbazqFIF0gwKNAnEtXu82MegJbBcRivsTg4CssPX0cH8OVVX
         Io48QRb/MdhIBRKHpZDCi55GlddtOEGA1kS4aapxEA9/mDIO8FDYtqihMLwpUp5dLERL
         mLm4RgzuInAOqOiyi7BULCWuoxAcPLzsDknFZTlwCw9gSujq7C+NDXAFzMy7T7Mnln2E
         0d3w==
X-Gm-Message-State: AOAM530CrJo9EojavchWVXhMiDBEQKYjFBT/3OM5RonGe5i4rj+zreXf
        vyrnGbmuwSQG8tqnUmGG3yxCWxJWmL+wdZc2iz2AKt/ZdPLJeas/F8Vm4AFLlkNQ1+3dyYudKEZ
        7KDdiO7HsssctCoJqbw+lGBVRGiV/nEtJUKYhWgGKQg==
X-Received: by 2002:a62:2545:: with SMTP id l66mr3606251pfl.12.1591810869131;
        Wed, 10 Jun 2020 10:41:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzmMMfRw6JstLTtGTJmFoegbukw+1UJuJOa7bAjjumQCZGx+8xA+8diqIe7hIyigUaS2SBcGA==
X-Received: by 2002:a62:2545:: with SMTP id l66mr3606226pfl.12.1591810868767;
        Wed, 10 Jun 2020 10:41:08 -0700 (PDT)
Received: from [192.168.0.119] (d66-222-144-129.abhsia.telus.net. [66.222.144.129])
        by smtp.gmail.com with ESMTPSA id p16sm400985pgj.53.2020.06.10.10.41.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jun 2020 10:41:07 -0700 (PDT)
Subject: Re: [PATCH] platform/x86: intel-hid: Use hp-wireless for rfkill on HP
 platforms
To:     kai.heng.feng@canonical.com
Cc:     Mario.Limonciello@dell.com, dvhart@infradead.org,
        andy@infradead.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200610153747.27040-1-kai.heng.feng@canonical.com>
 <4d0714fe5e2548b6b638ea447ad19490@AUSX13MPC105.AMER.DELL.COM>
From:   Alex Hung <alex.hung@canonical.com>
Message-ID: <0affa00e-8a52-9e29-56d4-39dff952d736@canonical.com>
Date:   Wed, 10 Jun 2020 11:41:06 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <4d0714fe5e2548b6b638ea447ad19490@AUSX13MPC105.AMER.DELL.COM>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-06-10 9:49 a.m., Mario.Limonciello@dell.com wrote:
>> -----Original Message-----
>> From: platform-driver-x86-owner@vger.kernel.org <platform-driver-x86-
>> owner@vger.kernel.org> On Behalf Of Kai-Heng Feng
>> Sent: Wednesday, June 10, 2020 10:38 AM
>> To: alex.hung@canonical.com
>> Cc: Kai-Heng Feng; Darren Hart; Andy Shevchenko; open list:INTEL HID EVENT
>> DRIVER; open list
>> Subject: [PATCH] platform/x86: intel-hid: Use hp-wireless for rfkill on HP
>> platforms
>>
>>
>> [EXTERNAL EMAIL]
>>
>> Wireless hotkey on HP platforms can trigger two events, if both
>> hp-wireless and intel-hid are supported. Two events at the same time
>> renders wireless hotkey useless.
>>
>> HP confirmed that hp-wireless (HPQ6001) should always be the canonical
>> source of wireless hotkey event, so skip registering rfkill hotkey if
>> HPQ6001 is present.
>>
>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>> ---
>>  drivers/platform/x86/intel-hid.c | 31 ++++++++++++++++++++++++++++++-
>>  1 file changed, 30 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/platform/x86/intel-hid.c b/drivers/platform/x86/intel-
>> hid.c
>> index 9ee79b74311c..31091c8faf70 100644
>> --- a/drivers/platform/x86/intel-hid.c
>> +++ b/drivers/platform/x86/intel-hid.c
>> @@ -25,6 +25,8 @@ static const struct acpi_device_id intel_hid_ids[] = {
>>  };
>>  MODULE_DEVICE_TABLE(acpi, intel_hid_ids);
>>
>> +static bool hp_wireless_present;
>> +
>>  /* In theory, these are HID usages. */
>>  static const struct key_entry intel_hid_keymap[] = {
>>  	/* 1: LSuper (Page 0x07, usage 0xE3) -- unclear what to do */
>> @@ -49,6 +51,29 @@ static const struct key_entry intel_hid_keymap[] = {
>>  	{ KE_END },
>>  };
>>
>> +static const struct key_entry intel_hid_no_rfkill_keymap[] = {
>> +	/* 1: LSuper (Page 0x07, usage 0xE3) -- unclear what to do */
>> +	/* 2: Toggle SW_ROTATE_LOCK -- easy to implement if seen in wild */
>> +	{ KE_KEY, 3, { KEY_NUMLOCK } },
>> +	{ KE_KEY, 4, { KEY_HOME } },
>> +	{ KE_KEY, 5, { KEY_END } },
>> +	{ KE_KEY, 6, { KEY_PAGEUP } },
>> +	{ KE_KEY, 7, { KEY_PAGEDOWN } },
>> +	/* 8: rfkill -- use hp-wireless instead */
>> +	{ KE_KEY, 9, { KEY_POWER } },
>> +	{ KE_KEY, 11, { KEY_SLEEP } },
>> +	/* 13 has two different meanings in the spec -- ignore it. */
>> +	{ KE_KEY, 14, { KEY_STOPCD } },
>> +	{ KE_KEY, 15, { KEY_PLAYPAUSE } },
>> +	{ KE_KEY, 16, { KEY_MUTE } },
>> +	{ KE_KEY, 17, { KEY_VOLUMEUP } },
>> +	{ KE_KEY, 18, { KEY_VOLUMEDOWN } },
>> +	{ KE_KEY, 19, { KEY_BRIGHTNESSUP } },
>> +	{ KE_KEY, 20, { KEY_BRIGHTNESSDOWN } },
>> +	/* 27: wake -- needs special handling */
>> +	{ KE_END },
>> +};
>> +
>>  /* 5 button array notification value. */
>>  static const struct key_entry intel_array_keymap[] = {
>>  	{ KE_KEY,    0xC2, { KEY_LEFTMETA } },                /* Press */
>> @@ -317,7 +342,8 @@ static int intel_hid_input_setup(struct platform_device
>> *device)
>>  	if (!priv->input_dev)
>>  		return -ENOMEM;
>>
>> -	ret = sparse_keymap_setup(priv->input_dev, intel_hid_keymap, NULL);
>> +	ret = sparse_keymap_setup(priv->input_dev, hp_wireless_present ?
>> +			intel_hid_no_rfkill_keymap : intel_hid_keymap, NULL);
>>  	if (ret)
>>  		return ret;
>>
>> @@ -575,6 +601,9 @@ check_acpi_dev(acpi_handle handle, u32 lvl, void
>> *context, void **rv)
>>  			dev_info(&dev->dev,
>>  				 "intel-hid: created platform device\n");
>>
>> +	if (!strcmp(acpi_device_hid(dev), "HPQ6001"))
>> +		hp_wireless_present = true;

(Resend with format removed)

This can impact all HP systems that do not have this problem. How about
a DMI quirk that is limited to this particular system?


> 
> Just having the ACPI device present doesn't actually mean that the user
> has a kernel compiled with hp-wireless or that it has finished initializing.
> 
> I would think this needs a better handshake in case hp-wireless was unloaded
> or not present so the event could still come through intel-hid in this
> circumstance.
> 
>> +
>>  	return AE_OK;
>>  }
>>
>> --
>> 2.17.1
> 


-- 
Cheers,
Alex Hung
