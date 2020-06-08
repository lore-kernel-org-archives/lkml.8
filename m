Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07C04C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 21:03:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9D162076A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 21:03:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paritcher.com header.i=@paritcher.com header.b="tlltoOT6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bGdhJjbo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbgFHVDI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 17:03:08 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:37987 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726740AbgFHVDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 17:03:05 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 237B677B;
        Mon,  8 Jun 2020 17:03:04 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 08 Jun 2020 17:03:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=paritcher.com;
         h=from:subject:to:cc:references:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm2; bh=p
        OWXdGs3kvPg7JyyoqF2/rCAjMFyH/sKvBht+kvvXSg=; b=tlltoOT6Frux0YC2w
        zsuSmeNKJ+EcBcz/vTurHpWE6u1hsA2qeQC44dk1c4EvGV3ZtvQgTsdLGSDHvzbI
        pcuSMeRDjkniamV9PFz0SPCaeI5H3bC9TXuLk76vJGuV1aM/ia3iik7t1l/pciqI
        fkGjtFxzpSp6Pbb6lJIEEvr1eDC5VM7xxrcywST2UCydIk8xp9ZVv6W6hmsh3bSn
        XzgofKmMloXG2ms/l3Xj/D1mDhJKenSdCEqn+JDqOKkyINeRCbrcb1zw5hMaLLeD
        joxn7NQk5cDQvlGPXLXF/o9MZxQMJJ1GKo7GWfzTMV2SlnOrdgkIAAsnzdrgRDms
        wqEYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=pOWXdGs3kvPg7JyyoqF2/rCAjMFyH/sKvBht+kvvX
        Sg=; b=bGdhJjboEnbfiMG7qQ58VDSsdEC+8UW9uHm9D0BvracagH6FyPfU8H05q
        K9AdM2G/bf9SepiRJIrLJ6af5rbIz+eSIuukgKzt+hfLBTDBaiG/OdBnAo0SyMtk
        coZlA6UzhfWOqCBORsJhZUw6lZ8A1PfDVRQJhdgeMS+JqvbkpD5UR45VuV+w4uT0
        K3af9Wl+9OYhhFZCS9ruAcbIvXX1FYegj4C/+LgAwiq4I6S7abL6wOo0/SJZKbAH
        jirUJWy9I7mkBDnyXxKlB3idCA0Mo1yc1cIjdnepZsJH7xBFwunqvj99VMpdrwXD
        1D5RV9p+GrsubBr+7Nc0tl9c0IBmQ==
X-ME-Sender: <xms:hqfeXqb2wbr05-kliIk_jtb0AHK9dWlGskUCgaFsq4uAZPphvkr5qw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudehvddgleeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhuffvfhfkffgfgggjtgfgsehtke
    ertddtfeejnecuhfhrohhmpegjucfrrghrihhttghhvghruceohidrlhhinhhugiesphgr
    rhhithgthhgvrhdrtghomheqnecuggftrfgrthhtvghrnheptefhhefgtdegfeeludfgtd
    evledtheejheeiiedvueeigfekvdeljeeileeiieeunecukfhppeeijedrkeegrdduleeg
    rddujeehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    ephidrlhhinhhugiesphgrrhhithgthhgvrhdrtghomh
X-ME-Proxy: <xmx:hqfeXtZELWVL-ujSg5cI2VPCkcezlFaSJmlSMw6AbgL-85Q8UdD3hQ>
    <xmx:hqfeXk_rxsDZwfRQt4yJIBzYmwJoY-Jn56Caanto_NzZWXdqBYaaSw>
    <xmx:hqfeXsqW0n-OCK1rm6hQePKmib0Gh9E4wZp_Ayh-Umc4Nazw5KWZCg>
    <xmx:h6feXs3yntt8FAIME-YvTfn6i2_KoUfY5oOI7bkCQu1eI9sE8W0F6A>
Received: from [192.168.0.106] (ool-4354c2af.dyn.optonline.net [67.84.194.175])
        by mail.messagingengine.com (Postfix) with ESMTPA id 0D4C43280069;
        Mon,  8 Jun 2020 17:03:02 -0400 (EDT)
From:   Y Paritcher <y.linux@paritcher.com>
Subject: Re: [PATCH 2/3] platform/x86: dell-wmi: add new keymap type 0x0012
To:     Mario.Limonciello@dell.com, hdegoede@redhat.com
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        mjg59@srcf.ucam.org, pali@kernel.org
References: <cover.1591584631.git.y.linux@paritcher.com>
 <0dc191a3d16f0e114f6a8976433e248018e10c43.1591584631.git.y.linux@paritcher.com>
 <83fe431cacbc4708962767668ac8f06f@AUSX13MPC105.AMER.DELL.COM>
 <79bd59ee-dd37-bdc5-f6b4-00f2c33fdcff@paritcher.com>
 <7f9f0410696141cfabb0237d33b7b529@AUSX13MPC105.AMER.DELL.COM>
Message-ID: <01169d6e-1bb1-6fc5-0690-0e8f44941cce@paritcher.com>
Date:   Mon, 8 Jun 2020 17:03:01 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <7f9f0410696141cfabb0237d33b7b529@AUSX13MPC105.AMER.DELL.COM>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/8/20 4:36 PM, Mario.Limonciello@dell.com wrote:
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

this is the WMI event from pressing the Fn lock key.
this indicates which mode it is switching to.

this changes if the default for pressing the F[1-12] should be Function or media.
the scancodes of the Fn keys are properly transmitted, this just inverts which
ones are sent by default and which are sent when pressing the Fn+F[1-12]

In other words, there are 24 scancode the only difference is which 12 are default
and which 12 are when pressing with the Fn key
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
> 
>>>>
>>>> Signed-off-by: Y Paritcher <y.linux@paritcher.com>
>>>> ---
>>>>  drivers/platform/x86/dell-wmi.c | 17 +++++++++++++++++
>>>>  1 file changed, 17 insertions(+)
>>>>
>>>> diff --git a/drivers/platform/x86/dell-wmi.c
>> b/drivers/platform/x86/dell-
>>>> wmi.c
>>>> index 0b4f72f923cd..f37e7e9093c2 100644
>>>> --- a/drivers/platform/x86/dell-wmi.c
>>>> +++ b/drivers/platform/x86/dell-wmi.c
>>>> @@ -334,6 +334,14 @@ static const struct key_entry
>>>> dell_wmi_keymap_type_0011[] = {
>>>>  	{ KE_IGNORE, KBD_LED_AUTO_100_TOKEN, { KEY_RESERVED } },
>>>>  };
>>>>
>>>> +/*
>>>> + * Keymap for WMI events of type 0x0012
>>>> + */
>>>> +static const struct key_entry dell_wmi_keymap_type_0012[] = {
>>>> +	/* Fn-lock button pressed */
>>>> +	{ KE_IGNORE, 0xe035, { KEY_RESERVED } },
>>>> +};
>>>> +
>>>>  static void dell_wmi_process_key(struct wmi_device *wdev, int type, int
>>>> code)
>>>>  {
>>>>  	struct dell_wmi_priv *priv = dev_get_drvdata(&wdev->dev);
>>>> @@ -425,6 +433,7 @@ static void dell_wmi_notify(struct wmi_device *wdev,
>>>>  			break;
>>>>  		case 0x0010: /* Sequence of keys pressed */
>>>>  		case 0x0011: /* Sequence of events occurred */
>>>> +		case 0x0012: /* Sequence of events occurred */
>>>>  			for (i = 2; i < len; ++i)
>>>>  				dell_wmi_process_key(wdev, buffer_entry[1],
>>>>  						     buffer_entry[i]);
>>>> @@ -556,6 +565,7 @@ static int dell_wmi_input_setup(struct wmi_device
>>>> *wdev)
>>>>  			 ARRAY_SIZE(dell_wmi_keymap_type_0000) +
>>>>  			 ARRAY_SIZE(dell_wmi_keymap_type_0010) +
>>>>  			 ARRAY_SIZE(dell_wmi_keymap_type_0011) +
>>>> +			 ARRAY_SIZE(dell_wmi_keymap_type_0012) +
>>>>  			 1,
>>>>  			 sizeof(struct key_entry), GFP_KERNEL);
>>>>  	if (!keymap) {
>>>> @@ -600,6 +610,13 @@ static int dell_wmi_input_setup(struct wmi_device
>>>> *wdev)
>>>>  		pos++;
>>>>  	}
>>>>
>>>> +	/* Append table with events of type 0x0012 */
>>>> +	for (i = 0; i < ARRAY_SIZE(dell_wmi_keymap_type_0012); i++) {
>>>> +		keymap[pos] = dell_wmi_keymap_type_0012[i];
>>>> +		keymap[pos].code |= (0x0012 << 16);
>>>> +		pos++;
>>>> +	}
>>>> +
>>>>  	/*
>>>>  	 * Now append also table with "legacy" events of type 0x0000. Some of
>>>>  	 * them are reported also on laptops which have scancodes in DMI.
>>>> --
>>>> 2.27.0
>>>
