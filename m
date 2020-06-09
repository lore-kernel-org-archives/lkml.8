Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD372C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 10:44:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75922207C3
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 10:44:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lk0Dyg+T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728118AbgFIKoo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 06:44:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54782 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727122AbgFIKom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 06:44:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591699479;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qwMP1QMJ9V7sG+1vGh6zwbNZIAwnK+PCEmicjBiezlI=;
        b=Lk0Dyg+Ta8X+/O1kOgHjI+oGBQuxkgQO1caSB0hUpyWfrRIbxcisqSzp8kg38lpiKGtzS2
        NNadweUKATDvSi4g22PVMMhK2U2yzpo9UYc9zmS1B5pmOiMt+pFcLfWX0nrOovzKFTRJSA
        IEoJt0psKGi29UTrNhfljMqaDVPi278=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-212-LAVprhMWObmXhJ99-2WTxw-1; Tue, 09 Jun 2020 06:44:37 -0400
X-MC-Unique: LAVprhMWObmXhJ99-2WTxw-1
Received: by mail-ed1-f69.google.com with SMTP id y5so2549548edt.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 03:44:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qwMP1QMJ9V7sG+1vGh6zwbNZIAwnK+PCEmicjBiezlI=;
        b=Ru1TRSIx4N2bYYhcWALlO3N3rGXoD/+sTXWmA3wYrNskjFzatQJtiNZwAyLnOByV9C
         DvENXfYQL6CSpBjZATTzCOXoX4qD0Mx0ii3XouUjZq7TOB/J4nRZ9s1CCoDG9t7pztGD
         ljbojk2DYnI2M1QC/whBTVQbDj9sQr6w9rlhd6L2i630nuXcbUJOGF1U+2Bnk6AH4mew
         ShGIyqVFCyIcrOYBGsdN5Lct7RWXf11aDlr5a5K9Gk7no07V0ugTl6RvdioU9y1SFbFG
         WQknR8+iWYsFrNktHxGCdLYVXLTrMRjx5rrmoLKsTo5OYm2r73GAMYNIDlLVxY8CxZgl
         RvmA==
X-Gm-Message-State: AOAM532wGHdInIHHkzF1WlHR75ecfyOpjRRGR6or0rYh+iHYhylYvo12
        UiKjM34EiHCnRyDnQuRvBjPC0prUz3RJsm/hhEKq8b7Tu8tLRUvKnOCPnwBvy4H/firOLVjNAQ6
        DaPuT8urvUda1lz0Bzim9YWU7
X-Received: by 2002:a17:907:212b:: with SMTP id qo11mr25748297ejb.235.1591699476424;
        Tue, 09 Jun 2020 03:44:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyemFCrRYmtb3dPH+yP/k2MMt08xf+6m1XHEQzhn+cwsTk/l13kv9nL/DFFIlNl58nR0vpSYw==
X-Received: by 2002:a17:907:212b:: with SMTP id qo11mr25748281ejb.235.1591699476092;
        Tue, 09 Jun 2020 03:44:36 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id q3sm9548450eds.0.2020.06.09.03.44.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2020 03:44:35 -0700 (PDT)
Subject: Re: [PATCH 2/3] platform/x86: dell-wmi: add new keymap type 0x0012
To:     Mario.Limonciello@dell.com, y.linux@paritcher.com
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        mjg59@srcf.ucam.org, pali@kernel.org
References: <cover.1591584631.git.y.linux@paritcher.com>
 <0dc191a3d16f0e114f6a8976433e248018e10c43.1591584631.git.y.linux@paritcher.com>
 <83fe431cacbc4708962767668ac8f06f@AUSX13MPC105.AMER.DELL.COM>
 <79bd59ee-dd37-bdc5-f6b4-00f2c33fdcff@paritcher.com>
 <7f9f0410696141cfabb0237d33b7b529@AUSX13MPC105.AMER.DELL.COM>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <137d8e69-a83f-6129-19e0-316ef0a51076@redhat.com>
Date:   Tue, 9 Jun 2020 12:44:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <7f9f0410696141cfabb0237d33b7b529@AUSX13MPC105.AMER.DELL.COM>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 6/8/20 10:36 PM, Mario.Limonciello@dell.com wrote:
>> -----Original Message-----
>> From: Y Paritcher <y.linux@paritcher.com>
>> Sent: Monday, June 8, 2020 3:13 PM
>> To: Limonciello, Mario
>> Cc: linux-kernel@vger.kernel.org; platform-driver-x86@vger.kernel.org;
>> mjg59@srcf.ucam.org; pali@kernel.org
>> Subject: Re: [PATCH 2/3] platform/x86: dell-wmi: add new keymap type 0x0012
>>
>>
>> [EXTERNAL EMAIL]
>>
>> On 6/8/20 11:40 AM, Mario.Limonciello@dell.com wrote:
>>>> -----Original Message-----
>>>> From: platform-driver-x86-owner@vger.kernel.org <platform-driver-x86-
>>>> owner@vger.kernel.org> On Behalf Of Y Paritcher
>>>> Sent: Sunday, June 7, 2020 11:22 PM
>>>> Cc: linux-kernel@vger.kernel.org; platform-driver-x86@vger.kernel.org;
>>>> Matthew Garrett; Pali Rohár
>>>> Subject: [PATCH 2/3] platform/x86: dell-wmi: add new keymap type 0x0012
>>>>
>>>>
>>>> [EXTERNAL EMAIL]
>>>>
>>>> Ignore events with a type of 0x0012 and a code of 0xe035,
>>>> this silences the following messages being logged when
>>>> pressing the Fn-lock key on a Dell Inspiron 5593:
>>>>
>>>> dell_wmi: Unknown WMI event type 0x12
>>>> dell_wmi: Unknown key with type 0x0012 and code 0xe035 pressed
>>>
>>> Event type 0x12 is for "System Events".  This is the type of events that
>>> you typically would see come in for things "like" the wrong power adapter
>>> being plugged in on Windows or stuff about plugging a Thunderbolt dock
>> into
>>> a port that doesn't support Thunderbolt.
>>>
>>> A message might look something like (paraphrased)
>>> "Your system requires a 180W power adapter to charge effectively, but you
>>> plugged in a 60W adapter."
>>>
>>> There often is extended data with these events.  As such I don't believe
>> all
>>> information in event type 0x0012 should be treated like scan codes like
>> those in
>>> 0x10 or 0x11.
>>>
>>> I would guess that Fn-lock on this machine probably has extended data in
>> the next
>>> showing whether it was turned on and off.  If it does, perhaps it makes
>> sense to
>>> send this information to userspace as an evdev switch instead.
>>>
>>
>> You are right.
>> I had assumed (incorrectly) the were the same.
>> I turned on dyndbg and got the events with the extended data.
>>
>> Fn lock key switched to multimedia keys
>> dell_wmi: Received WMI event (02 00 12 00 35 e0 01 00 00 00 00 00 00 00 00
>> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00)
>> the extended data is e0 01
>>
>> Fn-lock switched to function keys
>> dell_wmi: Received WMI event (02 00 12 00 35 e0 00 00 00 00 00 00 00 00 00
>> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00)
>> the extended data is e0 00
> 
> To be clear - do the function keys not send different scan codes on this laptop
> in the two different modes?  I expected that they should be sending separate scan
> codes.  If they are not sending different scan codes, then this actually needs
> to be captured in the kernel and a translation map is needed which is platform
> specific.
> 
>>
>> Therefore i agree this should have it's own case in `dell_wmi_process_key`
>> but i am
>> not sure yet how to deal with it. any suggestion are helpful.
>>
>> About sending it to userspace, I just followed what was already done, if
>> that is not
>> desired we should change it for all the models.
> 
> Right, I don't think this was a bad first attempt.  I just think it's different
> than the 0x10/0x11 events.
> 
> I'm not saying it shouldn't apply to more models, but just that events from
> this 0x12 table should be treated differently.
> 
> I feel we need a different way to send these types of events to userspace
> than a keycode.
> 
> I for example think that the power adapter and dock events are also potentially
> useful but realistically userspace needs to be able to show translated messages to
> a user.
> 
> Hans,
> 
> Can you please comment here how you would like to see events like this should come
> through to userspace?
> 
> * Wrong power adapter (you have X and should have Y)
> * You have plugged a dock into the wrong port
> * Fn-lock mode

Note just thinking out loud here.

I'm thinking we just need a mechanism to show a "user notification". This would
be just a plain text string passed from the kernel to userspace. I guess we
may also want some mechanism to build (on the kernel side) a small file
with all possible messages for translation from US English to other languages.

So the idea would be that e.g. gnome-shell can listen for these in some way
and then show a notification in its notification mechanism with the message,
like how it does for when software updates are available for example.

I think we can make this as simple as using the normal printk buffer for this
and prefixing the messages with "USER NOTIFY", we already have some messages
in the kernel which would qualify for this, e.g. in the USB core we have:

                 dev_info(&udev->dev, "not running at top speed; "
                         "connect to a high speed hub\n");

This one is about USB1 vs USB2 ports, but we have a similar one somewhere
for USB2 vs USB3 ports (I think) which would also be an interesting message
to actually show to the user inside the desktop environment.

So sticking with the above example, we could change that to

#define USER_NOTIFY "USER NOTIFY: "

dev_info(&udev->dev, USER_NOTIFY "not running at top speed; connect to a high speed hub\n");

And then userspace would trigger on the "USER NOTIFY: " part, keep the
bit before it (which describes the device) as is, try to translate
the text after it and then combine the text before it + the possibly
translated text after it and show that as a notification.

The reason for (ab)using the printk ring-buffer for this is that
we will still want to have these messages in dmesg too anyways,
so why add a new mechanism and send the same message twice if
we can just tag the messages inside the printk ring-buffer ?

Note the dev_info above would likely be replaced with some new
helper which also does some magic to help with gathering a
list of strings to translate.

Again just thinking out loud here. If anyone has any initial
reaction to this please let me know...

Regards,

Hans










> 
>>>>
>>>> Signed-off-by: Y Paritcher <y.linux@paritcher.com>
>>>> ---
>>>>   drivers/platform/x86/dell-wmi.c | 17 +++++++++++++++++
>>>>   1 file changed, 17 insertions(+)
>>>>
>>>> diff --git a/drivers/platform/x86/dell-wmi.c
>> b/drivers/platform/x86/dell-
>>>> wmi.c
>>>> index 0b4f72f923cd..f37e7e9093c2 100644
>>>> --- a/drivers/platform/x86/dell-wmi.c
>>>> +++ b/drivers/platform/x86/dell-wmi.c
>>>> @@ -334,6 +334,14 @@ static const struct key_entry
>>>> dell_wmi_keymap_type_0011[] = {
>>>>   	{ KE_IGNORE, KBD_LED_AUTO_100_TOKEN, { KEY_RESERVED } },
>>>>   };
>>>>
>>>> +/*
>>>> + * Keymap for WMI events of type 0x0012
>>>> + */
>>>> +static const struct key_entry dell_wmi_keymap_type_0012[] = {
>>>> +	/* Fn-lock button pressed */
>>>> +	{ KE_IGNORE, 0xe035, { KEY_RESERVED } },
>>>> +};
>>>> +
>>>>   static void dell_wmi_process_key(struct wmi_device *wdev, int type, int
>>>> code)
>>>>   {
>>>>   	struct dell_wmi_priv *priv = dev_get_drvdata(&wdev->dev);
>>>> @@ -425,6 +433,7 @@ static void dell_wmi_notify(struct wmi_device *wdev,
>>>>   			break;
>>>>   		case 0x0010: /* Sequence of keys pressed */
>>>>   		case 0x0011: /* Sequence of events occurred */
>>>> +		case 0x0012: /* Sequence of events occurred */
>>>>   			for (i = 2; i < len; ++i)
>>>>   				dell_wmi_process_key(wdev, buffer_entry[1],
>>>>   						     buffer_entry[i]);
>>>> @@ -556,6 +565,7 @@ static int dell_wmi_input_setup(struct wmi_device
>>>> *wdev)
>>>>   			 ARRAY_SIZE(dell_wmi_keymap_type_0000) +
>>>>   			 ARRAY_SIZE(dell_wmi_keymap_type_0010) +
>>>>   			 ARRAY_SIZE(dell_wmi_keymap_type_0011) +
>>>> +			 ARRAY_SIZE(dell_wmi_keymap_type_0012) +
>>>>   			 1,
>>>>   			 sizeof(struct key_entry), GFP_KERNEL);
>>>>   	if (!keymap) {
>>>> @@ -600,6 +610,13 @@ static int dell_wmi_input_setup(struct wmi_device
>>>> *wdev)
>>>>   		pos++;
>>>>   	}
>>>>
>>>> +	/* Append table with events of type 0x0012 */
>>>> +	for (i = 0; i < ARRAY_SIZE(dell_wmi_keymap_type_0012); i++) {
>>>> +		keymap[pos] = dell_wmi_keymap_type_0012[i];
>>>> +		keymap[pos].code |= (0x0012 << 16);
>>>> +		pos++;
>>>> +	}
>>>> +
>>>>   	/*
>>>>   	 * Now append also table with "legacy" events of type 0x0000. Some of
>>>>   	 * them are reported also on laptops which have scancodes in DMI.
>>>> --
>>>> 2.27.0
>>>

