Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7D63C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 00:44:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 838AD2078C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 00:44:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paritcher.com header.i=@paritcher.com header.b="qy6MLXNW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pZ9T+kPr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730141AbgFIAoM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 20:44:12 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:33737 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733202AbgFIAnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 20:43:49 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 4B3C165B;
        Mon,  8 Jun 2020 20:43:47 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 08 Jun 2020 20:43:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=paritcher.com;
         h=subject:to:cc:references:from:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm2; bh=f
        LjvxKnzBlU2/AwYQDorUH1w/KM8Bzu09pNDDnCY9xQ=; b=qy6MLXNWTkwvtrKTV
        qWmWFBeHUr5AFfev13ZwjUvlHXpm2yTFfSYdpyfcsJK/nM5e77NQWZ5vzsI6GVpP
        QBlUHduMLQ2kLvl8wZwBVZEximq9cZpwu2eDULRGItfwF8voKVjTv+pEGXFgqxA/
        KpUJwgyLVUGoy2Q20hxgm2zsjVdRnAjn3WQvth1UTpaSn7zpB6jIkmkawEY0/Z9W
        JxL3RvbxfnRD945qVwyFfAgIAgjPyu3nZ8hEw54yolJnFatpW9gS2FEM8IfHJLpH
        44d9r0eDU7uadx+ZIVIzFfKe90GSeZL+8l37k8WEi9Opt+CSAOKO3cjv5pdpY5qa
        mvcQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=fLjvxKnzBlU2/AwYQDorUH1w/KM8Bzu09pNDDnCY9
        xQ=; b=pZ9T+kPrNHNqdJriTFuYA5HWAeQ3rSfAsvaDIEXiu6PC+k3k+1qCOWqUG
        +DLDaC6SJVT5yjRaLEWiw/EwF9iPKqLwFPwVM26YrwSlNZxi5GSKiv0F7eEX7xV3
        s0ssxxlEnZt86JWD6O8o5zbaZVCWKeIcbWPWETTYoqxib+BDS1fSojEyTSwHgyv5
        Dts+44smXtgsNuK5bZS+lue1UZYVNHRUp5/I6IDaWGbTI/lr3EUK5+a5Nr7JYjzj
        hZPVgZDFM3zxRCuKKUpKs3B/B5vyhC7PYPjsvNJXwBpKl/cmvopqbS239NUK2MLB
        SCN+NJIEYktzQG0Tuc1dPGGGRBmWg==
X-ME-Sender: <xms:QtveXthGl_svqHM36Txk7DSStUtSGZ7B5jYSm3Cq_BnFqidg9YH5pg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudehfedgfeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvfhfhkffffgggjggtgfesthekredttdefjeenucfhrhhomhepjgcurfgr
    rhhithgthhgvrhcuoeihrdhlihhnuhigsehprghrihhttghhvghrrdgtohhmqeenucggtf
    frrghtthgvrhhnpeduleethedtudeikefhkeeiieelfeekkedvhfdvffejjeekjefhudek
    heejvdfgleenucfkphepieejrdekgedrudelgedrudejheenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeihrdhlihhnuhigsehprghrihhttghh
    vghrrdgtohhm
X-ME-Proxy: <xmx:QtveXiBWJfBKfVYLIxKgiaG99O0-0fAeejUrshoaeuqwU-qUTcdHMw>
    <xmx:QtveXtHDJuhq3eTdbdB5LH7N7yYsbsEx6gmrdU_5GD_1oqZ0L_c3Hw>
    <xmx:QtveXiSS_rNTcfLV5tuFKPaJv6-sefclZkPaCxMGKsxjVonNyYQwTw>
    <xmx:QtveXl_sixDGiwq2VZyuRI9xI7GMIG5zQ2T7N-HwkLTVZr4rzit6mQ>
Received: from [192.168.0.106] (ool-4354c2af.dyn.optonline.net [67.84.194.175])
        by mail.messagingengine.com (Postfix) with ESMTPA id 6722B3061856;
        Mon,  8 Jun 2020 20:43:46 -0400 (EDT)
Subject: Re: [PATCH v2 3/3] platform/x86: dell-wmi: add new dmi keys to
 bios_to_linux_keycode
To:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Mario.Limonciello@dell.com
References: <cover.1591584631.git.y.linux@paritcher.com>
 <cover.1591656154.git.y.linux@paritcher.com>
 <d585d2a0f01a6b9480352530b571dec2d1afd79f.1591656154.git.y.linux@paritcher.com>
 <8053252a-83ad-bcaa-2830-ccfbca1b4152@infradead.org>
 <20200608235508.wthtgilgmifwfgz2@pali>
From:   Y Paritcher <y.linux@paritcher.com>
Message-ID: <d48b54ab-09ad-381b-c130-c5f3cdb4da10@paritcher.com>
Date:   Mon, 8 Jun 2020 20:43:45 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200608235508.wthtgilgmifwfgz2@pali>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/8/20 7:55 PM, Pali Rohár wrote:
> Hello!
> 
> On Monday 08 June 2020 16:27:10 Randy Dunlap wrote:
>> Hi--
>>
>> On 6/8/20 4:05 PM, Y Paritcher wrote:
>>> Increase length of bios_to_linux_keycode to 2 bytes (the true size of a
>>> keycode) to allow for a new keycode 0xffff, this silences the following
>>> messages being logged at startup on a Dell Inspiron 5593:
>>>
>>>     dell_wmi: firmware scancode 0x48 maps to unrecognized keycode 0xffff
>>>     dell_wmi: firmware scancode 0x50 maps to unrecognized keycode 0xffff
> 
> Which keys generate these two scancodes? Or how have you been able to
> trigger these scancodes (in case they are not generated by key press)?
> 
> It is important to know for which key or event or feature we need to
> include this patch and therefore what feature is currently
> non-functional on that laptop.
> 

As I said before:
The DMI contains a table of firmware scancode to linux keycode mappings.
this is parsed at boot and used together with the bios_to_linux_keycode
entries & dell_wmi_keymap_type_ tables to create a keymap.

If a DMI entry does not have a corresponding entry in bios_to_linux_keycode
we log a message to allow adding the correct linux keycode if known.
This is regardless of if the key actually exists on the device.

To date, I have not been able to generate this keycode on my computer.

>>> as per this code comment:
>>>
>>>    Log if we find an entry in the DMI table that we don't
>>>    understand.  If this happens, we should figure out what
>>>    the entry means and add it to bios_to_linux_keycode.
>>>
>>> These are keycodes included in the 0xB2 DMI table, for which the
>>> corosponding keys are not known.
>>
>>   corresponding
>>
>>>
>>> Now when a user will encounter this key, a proper message wil be printed:
>>>
>>>     dell_wmi: Unknown key with type 0xXXXX and code 0xXXXX pressed
>>>
>>> This will then allow the key to be identified properly.
>>>
>>> Signed-off-by: Y Paritcher <y.linux@paritcher.com>
>>> ---
>>>  drivers/platform/x86/dell-wmi.c | 8 +++-----
>>>  1 file changed, 3 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/platform/x86/dell-wmi.c b/drivers/platform/x86/dell-wmi.c
>>> index 6b510f8431a3..dae1db96b5a0 100644
>>> --- a/drivers/platform/x86/dell-wmi.c
>>> +++ b/drivers/platform/x86/dell-wmi.c
>>> @@ -196,7 +196,7 @@ struct dell_dmi_results {
>>>  };
>>>  
>>>  /* Uninitialized entries here are KEY_RESERVED == 0. */
>>> -static const u16 bios_to_linux_keycode[256] = {
>>> +static const u16 bios_to_linux_keycode[65536] = {
>>
>> It surely seems odd to me to expand an array from 512 bytes to 128 Kbytes
>> just to handle one special case.  Can't it be handled in code as a
>> special case?
> 
> I already wrote that more developers would not be happy about this
> change. I would rather to see e.g. that Randy's suggestion with 0xffff
> check as increasing memory usage.
> 

Will change

>>>  	[0]	= KEY_MEDIA,
>>>  	[1]	= KEY_NEXTSONG,
>>>  	[2]	= KEY_PLAYPAUSE,
>>> @@ -237,6 +237,7 @@ static const u16 bios_to_linux_keycode[256] = {
>>>  	[37]	= KEY_UNKNOWN,
>>>  	[38]	= KEY_MICMUTE,
>>>  	[255]	= KEY_PROG3,
>>> +	[65535]	= KEY_UNKNOWN,
> 
> Looking at the last two lines... and for me it looks like that 0x00FF
> and 0xFFFF are just "placeholders" or special values for unknown /
> custom / unsupported / reserved / special / ... codes.
> 

Probably so, but i have no way of knowing.

I just don't think there is a point spamming a users log with info that
they can't do anything with. If this is turned into a debug print then
i don't care to leave this as is, i had thought this might be helpful
just to know that this keycode mapping appears in the wild.

> It is really suspicious why first 38 values are defined, then there is
> gap, then one value 255 and then huge gap to 65535.
> 
> Mario, this looks like some mapping table between internal Dell BIOS key
> code and standard Linux key code. Are you able to get access to some
> documentation which contains explanation of those Dell key numbers?
> It could really help us to understand these gaps and what is correct
> interpretation of these numbers.
> 
> E.g. I remember that pressing Fn+Q or Fn+W on some Dell Latitude
> generates code 255, which could prove my thesis about "special codes"
> (which are probably not found in e.g. Windows or Linux mapping tables).
> 
>>>  };
>>>  
>>>  /*
>>> @@ -503,10 +504,7 @@ static void handle_dmi_entry(const struct dmi_header *dm, void *opaque)
>>>  					&table->keymap[i];
>>>  
>>>  		/* Uninitialized entries are 0 aka KEY_RESERVED. */
>>> -		u16 keycode = (bios_entry->keycode <
>>> -			       ARRAY_SIZE(bios_to_linux_keycode)) ?
>>> -			bios_to_linux_keycode[bios_entry->keycode] :
>>> -			KEY_RESERVED;
>>> +		u16 keycode = bios_to_linux_keycode[bios_entry->keycode];
>>>  
>>>  		/*
>>>  		 * Log if we find an entry in the DMI table that we don't
>>>
>>
>> Something like:
>>
>> 		u16 keycode;
>>
>> 		keycode = bios_entry->keycode == 0xffff ? KEY_UNKNOWN :
>> 			(bios_entry->keycode <
>> 			       ARRAY_SIZE(bios_to_linux_keycode)) ?
>> 			bios_to_linux_keycode[bios_entry->keycode] :
>> 			KEY_RESERVED;
>>
>>
>>
>> Also please fix this:
>> (no To-header on input) <>
> 
> Hint: specifying git send-email with '--to' argument instead of '--cc'
> should help.
> 

Sorry about that.
>>
>> -- 
>> ~Randy
>>
