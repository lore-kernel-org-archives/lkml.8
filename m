Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A291C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 07:24:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 190A92074B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 07:24:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbgFKHYf convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 03:24:35 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:40382 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726375AbgFKHYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 03:24:33 -0400
Received: from mail-pl1-f198.google.com ([209.85.214.198])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1jjHZe-0006XP-U0
        for linux-kernel@vger.kernel.org; Thu, 11 Jun 2020 07:24:31 +0000
Received: by mail-pl1-f198.google.com with SMTP id s7so3231176plp.13
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 00:24:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=SoZ5V9zbRLgaegUDNwwyEPCdc+OC+RVdcppcKFcouRM=;
        b=H4VanI6UQCuiLIrat9y6k9o8s7VQn8qUWBJXSI+p+zXRka7bqraJYpQcMUVxaL49uL
         KlLcR5AgLF+nhSKaHERz7KpScUT0yQLUt93IcGd2PMMJuL7sTemQ9ajPQMHzbX/1esZ3
         uIvX0tDBD4uw8QcTz1I0Zzlsvk7kwmAV5/PQpdlPagX3TKofTQBbP51zz5Sbd0Z4rfjJ
         ghDmgeFfWpkw1CQ/hWTMvUJjW6WZcyV7nMvVPTUj4a4spUYnEMw2LI3yxcIrAdYL7SNe
         JyaKF6nJWkTsmkWiXzRPmXDJQeSw43ini715OwMUcVhg1ao1OGWwUGM5pyxRNxjR/XvL
         82Zg==
X-Gm-Message-State: AOAM533ytrbWuuxTluh5z4McRBpif63qLnsMjewvpOVqTHqW0Qu9VTHs
        77EB4B8fikHTX7vO+ROZ2u/58oVM6R9bwC79hxMpeWCJ4TyyuUlArISf4QCSMgSZpEQTjFsbV69
        SqiUMjLTaGWAQasLp67ftelTPU82CLfRE02bH/6xJNA==
X-Received: by 2002:a17:90a:266f:: with SMTP id l102mr7241916pje.190.1591860269337;
        Thu, 11 Jun 2020 00:24:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyi8wDANIhDLxT/nZLs6HcB4H24a5vgsYTvue3cQSog96kQYqFqggwWBL2fS2o5Mbi3Kwf7vg==
X-Received: by 2002:a17:90a:266f:: with SMTP id l102mr7241899pje.190.1591860268989;
        Thu, 11 Jun 2020 00:24:28 -0700 (PDT)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id e124sm2052968pfh.140.2020.06.11.00.24.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Jun 2020 00:24:28 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH] platform/x86: intel-hid: Use hp-wireless for rfkill on HP
 platforms
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <0affa00e-8a52-9e29-56d4-39dff952d736@canonical.com>
Date:   Thu, 11 Jun 2020 15:24:26 +0800
Cc:     Mario.Limonciello@dell.com, dvhart@infradead.org,
        andy@infradead.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <A98FC3F7-2295-4B49-95DD-1D861BC56B9A@canonical.com>
References: <20200610153747.27040-1-kai.heng.feng@canonical.com>
 <4d0714fe5e2548b6b638ea447ad19490@AUSX13MPC105.AMER.DELL.COM>
 <0affa00e-8a52-9e29-56d4-39dff952d736@canonical.com>
To:     Alex Hung <alex.hung@canonical.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jun 11, 2020, at 01:41, Alex Hung <alex.hung@canonical.com> wrote:
> 
> On 2020-06-10 9:49 a.m., Mario.Limonciello@dell.com wrote:
>>> -----Original Message-----
>>> From: platform-driver-x86-owner@vger.kernel.org <platform-driver-x86-
>>> owner@vger.kernel.org> On Behalf Of Kai-Heng Feng
>>> Sent: Wednesday, June 10, 2020 10:38 AM
>>> To: alex.hung@canonical.com
>>> Cc: Kai-Heng Feng; Darren Hart; Andy Shevchenko; open list:INTEL HID EVENT
>>> DRIVER; open list
>>> Subject: [PATCH] platform/x86: intel-hid: Use hp-wireless for rfkill on HP
>>> platforms
>>> 
>>> 
>>> [EXTERNAL EMAIL]
>>> 
>>> Wireless hotkey on HP platforms can trigger two events, if both
>>> hp-wireless and intel-hid are supported. Two events at the same time
>>> renders wireless hotkey useless.
>>> 
>>> HP confirmed that hp-wireless (HPQ6001) should always be the canonical
>>> source of wireless hotkey event, so skip registering rfkill hotkey if
>>> HPQ6001 is present.
>>> 
>>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>>> ---
>>> drivers/platform/x86/intel-hid.c | 31 ++++++++++++++++++++++++++++++-
>>> 1 file changed, 30 insertions(+), 1 deletion(-)
>>> 
>>> diff --git a/drivers/platform/x86/intel-hid.c b/drivers/platform/x86/intel-
>>> hid.c
>>> index 9ee79b74311c..31091c8faf70 100644
>>> --- a/drivers/platform/x86/intel-hid.c
>>> +++ b/drivers/platform/x86/intel-hid.c
>>> @@ -25,6 +25,8 @@ static const struct acpi_device_id intel_hid_ids[] = {
>>> };
>>> MODULE_DEVICE_TABLE(acpi, intel_hid_ids);
>>> 
>>> +static bool hp_wireless_present;
>>> +
>>> /* In theory, these are HID usages. */
>>> static const struct key_entry intel_hid_keymap[] = {
>>> 	/* 1: LSuper (Page 0x07, usage 0xE3) -- unclear what to do */
>>> @@ -49,6 +51,29 @@ static const struct key_entry intel_hid_keymap[] = {
>>> 	{ KE_END },
>>> };
>>> 
>>> +static const struct key_entry intel_hid_no_rfkill_keymap[] = {
>>> +	/* 1: LSuper (Page 0x07, usage 0xE3) -- unclear what to do */
>>> +	/* 2: Toggle SW_ROTATE_LOCK -- easy to implement if seen in wild */
>>> +	{ KE_KEY, 3, { KEY_NUMLOCK } },
>>> +	{ KE_KEY, 4, { KEY_HOME } },
>>> +	{ KE_KEY, 5, { KEY_END } },
>>> +	{ KE_KEY, 6, { KEY_PAGEUP } },
>>> +	{ KE_KEY, 7, { KEY_PAGEDOWN } },
>>> +	/* 8: rfkill -- use hp-wireless instead */
>>> +	{ KE_KEY, 9, { KEY_POWER } },
>>> +	{ KE_KEY, 11, { KEY_SLEEP } },
>>> +	/* 13 has two different meanings in the spec -- ignore it. */
>>> +	{ KE_KEY, 14, { KEY_STOPCD } },
>>> +	{ KE_KEY, 15, { KEY_PLAYPAUSE } },
>>> +	{ KE_KEY, 16, { KEY_MUTE } },
>>> +	{ KE_KEY, 17, { KEY_VOLUMEUP } },
>>> +	{ KE_KEY, 18, { KEY_VOLUMEDOWN } },
>>> +	{ KE_KEY, 19, { KEY_BRIGHTNESSUP } },
>>> +	{ KE_KEY, 20, { KEY_BRIGHTNESSDOWN } },
>>> +	/* 27: wake -- needs special handling */
>>> +	{ KE_END },
>>> +};
>>> +
>>> /* 5 button array notification value. */
>>> static const struct key_entry intel_array_keymap[] = {
>>> 	{ KE_KEY,    0xC2, { KEY_LEFTMETA } },                /* Press */
>>> @@ -317,7 +342,8 @@ static int intel_hid_input_setup(struct platform_device
>>> *device)
>>> 	if (!priv->input_dev)
>>> 		return -ENOMEM;
>>> 
>>> -	ret = sparse_keymap_setup(priv->input_dev, intel_hid_keymap, NULL);
>>> +	ret = sparse_keymap_setup(priv->input_dev, hp_wireless_present ?
>>> +			intel_hid_no_rfkill_keymap : intel_hid_keymap, NULL);
>>> 	if (ret)
>>> 		return ret;
>>> 
>>> @@ -575,6 +601,9 @@ check_acpi_dev(acpi_handle handle, u32 lvl, void
>>> *context, void **rv)
>>> 			dev_info(&dev->dev,
>>> 				 "intel-hid: created platform device\n");
>>> 
>>> +	if (!strcmp(acpi_device_hid(dev), "HPQ6001"))
>>> +		hp_wireless_present = true;
> 
> (Resend with format removed)
> 
> This can impact all HP systems that do not have this problem.

HP is certain that HPQ6001 should always be used over INT33D5.

If this patch breaks other platform, then we should fix HPQ6001 instead.

> How about
> a DMI quirk that is limited to this particular system?

We should avoid using DMI quirk for this one, as this is to follow the HP's spec.

Kai-Heng

> 
> 
>> 
>> Just having the ACPI device present doesn't actually mean that the user
>> has a kernel compiled with hp-wireless or that it has finished initializing.
>> 
>> I would think this needs a better handshake in case hp-wireless was unloaded
>> or not present so the event could still come through intel-hid in this
>> circumstance.
>> 
>>> +
>>> 	return AE_OK;
>>> }
>>> 
>>> --
>>> 2.17.1
>> 
> 
> 
> -- 
> Cheers,
> Alex Hung

