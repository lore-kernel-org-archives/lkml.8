Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BD5FC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 00:57:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4AD120810
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 00:57:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paritcher.com header.i=@paritcher.com header.b="hXheiBW4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KA0rqrHJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388077AbgFIA5q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 20:57:46 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:35437 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388072AbgFIA5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 20:57:41 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id EE72D2F2;
        Mon,  8 Jun 2020 20:57:39 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 08 Jun 2020 20:57:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=paritcher.com;
         h=subject:to:cc:references:from:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm2; bh=3
        uB/AS8OlyUmZfxPmXBWQ1X5t4/4QgNSUJVNp3R/cNM=; b=hXheiBW4CxclW4DSz
        /vaNhCa+3KR6XdpeXpReFJ/IsoANuQnKseZP/g1Vsg3al8/pwu2ovduCu2NM4Z44
        pFMTgoWGWyDvSMEbueElYhaoofG66i+yyrRTlUGSR2g89JFLCLkni8ZV0Sbi+ZIb
        tO03lE18nneSBfj0cuTie34URelsMIifqda8VIGDmh+pBgRyHCB1TiCz9H6w+DxD
        tgmEMG7tJRWPGV+Ejpj1aRLtWcrLQyj7ZrN6qJNKaCvCa64PB1UbnDElh5cfSxDI
        vhHdpnNR1y//Xebekcl5nVb0nMzfJ6aUo83Tx/YKB2p5vLYuSq2xaSF/0zBX+CpK
        bB/cA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=3uB/AS8OlyUmZfxPmXBWQ1X5t4/4QgNSUJVNp3R/c
        NM=; b=KA0rqrHJ7pSiEwdU9STX/E9KMjQEGG/zQ5ctBTVthMqd7mIA32yQNAB0V
        YcnlRJf7rNi1S6cjT3w0Q3xJ9SM54ACsH/oNreSc/s5TmHXcz0LCSsj015mKAQ64
        l+cX1S5Pg1oe18HVgPDXg/AvBkCheg3NufXSVyRZI96Gi9os23FO+eVnKYxQoJrr
        cvEAjDtnXf85iOLVZHPzW4Uyg+QQpkKkwrVWrXIB6K1GHqPnzl66wDf4HoI/PnXg
        +2GCfQzXJjA5L746vCqMg96YKVd76RjyPxPEi4dWMHRFtJsqpLUnejLscnyinfMl
        H8zt5PgsYJLu4QXe7cokiAXwHfz3A==
X-ME-Sender: <xms:g97eXikICCQgSYdrSqxyPAD71M0rxJqywSElI2bQNAW-R-QbMi7nYw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudehfedggeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefuvfhfhffkffgfgggjtgfgsehtke
    ertddtfeejnecuhfhrohhmpegjucfrrghrihhttghhvghruceohidrlhhinhhugiesphgr
    rhhithgthhgvrhdrtghomheqnecuggftrfgrthhtvghrnhepudelteehtdduieekhfekie
    eileefkeekvdfhvdffjeejkeejhfdukeehjedvgfelnecukfhppeeijedrkeegrdduleeg
    rddujeehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    ephidrlhhinhhugiesphgrrhhithgthhgvrhdrtghomh
X-ME-Proxy: <xmx:g97eXp1rgur5dfy-AD7W2ezoVdQUJ5RkKX3sZJNg4kt-WxD6lyl6Iw>
    <xmx:g97eXgo4U1jFpmLPuVCg_ikPXu5gCEbZbwcraCbwM61Ph2cviggMog>
    <xmx:g97eXmlE4_ljHsQT_JaLxQSQYsJoCOyE7BMGDEcdK-4Vav01xThFHQ>
    <xmx:g97eXt8TTZO0-W-dDBQR1lRHPX_9iF9f0HIEuXFyahu9rsyGnyC6FQ>
Received: from [192.168.0.106] (ool-4354c2af.dyn.optonline.net [67.84.194.175])
        by mail.messagingengine.com (Postfix) with ESMTPA id 22F353060FE7;
        Mon,  8 Jun 2020 20:57:39 -0400 (EDT)
Subject: Re: [PATCH v2 2/3] platform/x86: dell-wmi: add new keymap type 0x0012
To:     Mario.Limonciello@dell.com, pali@kernel.org
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        mjg59@srcf.ucam.org
References: <cover.1591584631.git.y.linux@paritcher.com>
 <cover.1591656154.git.y.linux@paritcher.com>
 <74fdb288757cf5970a558f920f531b3bd1c51b47.1591656154.git.y.linux@paritcher.com>
 <20200608233303.57ubv4rxo4tnaaxa@pali>
 <295ad85ecc464a57bffd5b783d4170a1@AUSX13MPC105.AMER.DELL.COM>
From:   Y Paritcher <y.linux@paritcher.com>
Message-ID: <2d4b308d-ce03-b13b-0140-4bbe669878c4@paritcher.com>
Date:   Mon, 8 Jun 2020 20:57:38 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <295ad85ecc464a57bffd5b783d4170a1@AUSX13MPC105.AMER.DELL.COM>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/8/20 8:26 PM, Mario.Limonciello@dell.com wrote:
>> -----Original Message-----
>> From: Pali Rohár <pali@kernel.org>
>> Sent: Monday, June 8, 2020 6:33 PM
>> To: Y Paritcher
>> Cc: linux-kernel@vger.kernel.org; platform-driver-x86@vger.kernel.org;
>> Matthew Garrett; Limonciello, Mario
>> Subject: Re: [PATCH v2 2/3] platform/x86: dell-wmi: add new keymap type
>> 0x0012
>>
>>
>> [EXTERNAL EMAIL]
>>
>> On Monday 08 June 2020 19:05:29 Y Paritcher wrote:
>>> These are events with extended data. The extended data is
>>> currently ignored as userspace does not have a way to deal
>>> it.
>>>
>>> Ignore event with a type of 0x0012 and a code of 0xe035, as
>>> the keyboard controller takes care of Fn lock events by itself.
>>
>> Nice! This is information which is really important and need to have it
>> documented.
>>
>>> This silences the following messages being logged when
>>> pressing the Fn-lock key on a Dell Inspiron 5593:
>>>
>>> dell_wmi: Unknown WMI event type 0x12
>>> dell_wmi: Unknown key with type 0x0012 and code 0xe035 pressed
>>>
>>> This is consistent with the behavior for the Fn-lock key
>>> elsewhere in this file.
>>>
>>> Signed-off-by: Y Paritcher <y.linux@paritcher.com>
>>
>> I'm fine with this patch now.
>>
>> Reviewed-by: Pali Rohár <pali@kernel.org>
>>
>>> ---
>>>  drivers/platform/x86/dell-wmi.c | 20 +++++++++++++++++++-
>>>  1 file changed, 19 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/platform/x86/dell-wmi.c b/drivers/platform/x86/dell-
>> wmi.c
>>> index 0b2edfe2767d..6b510f8431a3 100644
>>> --- a/drivers/platform/x86/dell-wmi.c
>>> +++ b/drivers/platform/x86/dell-wmi.c
>>> @@ -334,6 +334,15 @@ static const struct key_entry
>> dell_wmi_keymap_type_0011[] = {
>>>  	{ KE_IGNORE, KBD_LED_AUTO_100_TOKEN, { KEY_RESERVED } },
>>>  };
>>>
>>> +/*
>>> + * Keymap for WMI events of type 0x0012
>>> + * They are events with extended data
>>> + */
>>> +static const struct key_entry dell_wmi_keymap_type_0012[] = {
>>> +	/* Fn-lock button pressed */
>>> +	{ KE_IGNORE, 0xe035, { KEY_RESERVED } },
>>> +};
>>> +
>>>  static void dell_wmi_process_key(struct wmi_device *wdev, int type, int
>> code)
>>>  {
>>>  	struct dell_wmi_priv *priv = dev_get_drvdata(&wdev->dev);
>>> @@ -418,10 +427,11 @@ static void dell_wmi_notify(struct wmi_device
>> *wdev,
>>>
>>>  		switch (buffer_entry[1]) {
>>>  		case 0x0000: /* One key pressed or event occurred */
>>> +		case 0x0012: /* Event with extended data occurred */
> 
> I don't really like this being handled as a key as it's just discarding all
> that extended data.
> 
>>
>> Mario, are you able to get some official documentation for these 0x0012
>> event types? I think it could be really useful for community so they can
>> understand and add easily new type of code and events. Because currently
>> we are just guessing what it could be. (It is sequence? Or single event?
>> Or single event with extended data? It is generic event? Or it is real
>> keypress? etc...)
> 
> It's a single event with more data in the subsequent words.  It is definitely
> not a real keypress.  It's supposed to be data that a user application would show.
> 
> Remember the way WMI works on Linux and Windows is different.  On Windows
> userland applications get the events directly.  On Linux kernel drivers get the
> events and either use it internally, pass to another kernel driver or pass to
> userland in the form of a translated event.
> 
> So on Windows the whole buffer gets looked at directly by the application and the
> application will decode it to show a translated string.
> 
> I can certainly discuss internally about our team releasing a patch to export
> all these other events.  I would like to know what interface to recommend it pass
> to userspace though, because as I said this is more than just a keycode that
> comes through in the event.  It's not useful to just do dev_info, it really should
> be something that userspace can act on and show a translated message.
> I don't think we want to add another 15 Dell specific keycodes to the kernel for the
> various events and add another 4 more when a laptop introduces another set of keys.
> 

We can treat this as a key for now. This gets rid of the unnecessary log messages.

When adecision is made about how to handle extended events it will be very easy
just to make this its own case statement and handle with it separately.

However if you want to pass Fn lock event to userspace there are keys from older
models of type 0010:
    /* Fn-lock switched to function keys */
    { KE_IGNORE, 0x0, { KEY_RESERVED } },

    /* Fn-lock switched to multimedia keys */
    { KE_IGNORE, 0x1, { KEY_RESERVED } },

They should also be changed to be passed to userspace and they don't signify status
with extended data rather by which event is called.

This means that passing these types of events to userspace is a separate task, that
might require rethinking the entire design of how all event types are treated.

The current patch will be necessary regardless of what is decided in regards to
passing the events on, and continues the status quo.
>>
>>>  			if (len > 2)
>>>  				dell_wmi_process_key(wdev, 0x0000,
>>>  						     buffer_entry[2]);
>>> -			/* Other entries could contain additional information */
>>> +			/* Extended data is currently ignored */
>>>  			break;
>>>  		case 0x0010: /* Sequence of keys pressed */
>>>  		case 0x0011: /* Sequence of events occurred */
>>> @@ -556,6 +566,7 @@ static int dell_wmi_input_setup(struct wmi_device
>> *wdev)
>>>  			 ARRAY_SIZE(dell_wmi_keymap_type_0000) +
>>>  			 ARRAY_SIZE(dell_wmi_keymap_type_0010) +
>>>  			 ARRAY_SIZE(dell_wmi_keymap_type_0011) +
>>> +			 ARRAY_SIZE(dell_wmi_keymap_type_0012) +
>>>  			 1,
>>>  			 sizeof(struct key_entry), GFP_KERNEL);
>>>  	if (!keymap) {
>>> @@ -600,6 +611,13 @@ static int dell_wmi_input_setup(struct wmi_device
>> *wdev)
>>>  		pos++;
>>>  	}
>>>
>>> +	/* Append table with events of type 0x0012 */
>>> +	for (i = 0; i < ARRAY_SIZE(dell_wmi_keymap_type_0012); i++) {
>>> +		keymap[pos] = dell_wmi_keymap_type_0012[i];
>>> +		keymap[pos].code |= (0x0012 << 16);
>>> +		pos++;
>>> +	}
>>> +
>>>  	/*
>>>  	 * Now append also table with "legacy" events of type 0x0000. Some of
>>>  	 * them are reported also on laptops which have scancodes in DMI.
>>> --
>>> 2.27.0
>>>
