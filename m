Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01C19C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 20:13:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4AD52078B
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 20:13:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paritcher.com header.i=@paritcher.com header.b="1aObuU6L";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tJOEOvZD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbgFHUND (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 16:13:03 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:56469 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726753AbgFHUM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 16:12:57 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 77760491;
        Mon,  8 Jun 2020 16:12:55 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 08 Jun 2020 16:12:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=paritcher.com;
         h=subject:to:cc:references:from:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm2; bh=g
        RK+BCrhaf312eRzNReP3lU8nxw/gDtTmJ1835g0IjU=; b=1aObuU6Lc9ewwKVxm
        TMKXuQ3wNLUS30ti9+DRR0tphQIJQL3R686c0vxlvFPexbWIehv9K73BTuOt75KR
        mb/j3zzV00AknCxqmZqm5f+VnmI3EWhfukDV/SOPhyOxJZTp0aXkJyYEMnISk/l7
        HCEPSsEvOoG5V02PVYvaa0gIj8nsrdkFSIdTw0tSsk8+jow6ZrpTmlmYF7pMRDlw
        7MCV7Cm+Vs2+zvECnBf4CQc+18FodPximiZB9yegNGeT+K3mY16O3FIR9lLRbE6d
        ghdOE9Y5Nahd21GhTkFyd3jHve4+PeRlPF4wwEbsjrLObLQL0Ke8Nml2nulEoPvo
        4kzJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=gRK+BCrhaf312eRzNReP3lU8nxw/gDtTmJ1835g0I
        jU=; b=tJOEOvZDVFVaw3nOSQ7S1t4qoEzZRW58L0nNKHi2/Yjt17eG9UBnNQCLF
        z08LUaCWKgiYfAl8vSDrbxx6wuxNAAK3pC9woEcabkJxTQLrcWXMaojNUZK0bkEk
        lNrTSSWOXXH9ilgVpa+0wIDrtH4PRkdqhJJLROH9ONYbp9Xw5O8yJ8sExl+jLBt9
        rhnH0pLUS6BK93smAH+yTUa5TWFHStBvOlGwJ1Yyinc2l3qjRmNNOWNQxcMgmAQR
        BPUF7vCLULOwJopbKB7rS6yo+ltuESqkGJL4Z95vpoc7IrpWQn/dPYBaHemuSRqY
        VhhXFT9Zm4OyE1/tOUyp7H2WhUFyw==
X-ME-Sender: <xms:x5veXoxOLgLBt0kjWijVKm1NCQlNTSjpfApMo_KmnutOyXFxJip1mA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudehvddgkeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefuvfhfhffkffgfgggjtgfgsehtke
    ertddtfeejnecuhfhrohhmpegjucfrrghrihhttghhvghruceohidrlhhinhhugiesphgr
    rhhithgthhgvrhdrtghomheqnecuggftrfgrthhtvghrnhepudelteehtdduieekhfekie
    eileefkeekvdfhvdffjeejkeejhfdukeehjedvgfelnecukfhppeeijedrkeegrdduleeg
    rddujeehnecuvehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehmrghilhhfrhhomh
    ephidrlhhinhhugiesphgrrhhithgthhgvrhdrtghomh
X-ME-Proxy: <xmx:x5veXsRVT6EFMbOaZFUT4HEVS_TULPu3v_gyM4QMKYdvz5q9VYZ9zw>
    <xmx:x5veXqX05fWoZbmaX4ZQcX5FUfa7WQqTosocHu680vpnmw4tEyD-8w>
    <xmx:x5veXmjUtC-TWggR8sI5qjQmlA4MfgPMVNrTcw3731NG4-l1NBd7EQ>
    <xmx:x5veXr4Em9xn7ui-STCIkTx3pwmFgPgrjSm3BvoSW3fiRKQJ3Zha9Q>
Received: from [192.168.0.106] (ool-4354c2af.dyn.optonline.net [67.84.194.175])
        by mail.messagingengine.com (Postfix) with ESMTPA id DA6F3328006C;
        Mon,  8 Jun 2020 16:12:54 -0400 (EDT)
Subject: Re: [PATCH 3/3] platform/x86: dell-wmi: add keys to
 bios_to_linux_keycode
To:     Mario.Limonciello@dell.com, pali@kernel.org
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        mjg59@srcf.ucam.org
References: <cover.1591584631.git.y.linux@paritcher.com>
 <13951508596a3f654c6d47f5380ddb4f38e2f6b5.1591584631.git.y.linux@paritcher.com>
 <20200608090017.4qgtbosz7oullex2@pali>
 <8baab72e3d2e407792c3ffa1d9fffba8@AUSX13MPC105.AMER.DELL.COM>
From:   Y Paritcher <y.linux@paritcher.com>
Message-ID: <e447a347-a2a2-4196-b3f8-01389323d268@paritcher.com>
Date:   Mon, 8 Jun 2020 16:12:54 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <8baab72e3d2e407792c3ffa1d9fffba8@AUSX13MPC105.AMER.DELL.COM>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/8/20 11:46 AM, Mario.Limonciello@dell.com wrote:
>> -----Original Message-----
>> From: platform-driver-x86-owner@vger.kernel.org <platform-driver-x86-
>> owner@vger.kernel.org> On Behalf Of Pali Rohár
>> Sent: Monday, June 8, 2020 4:00 AM
>> To: Y Paritcher
>> Cc: linux-kernel@vger.kernel.org; platform-driver-x86@vger.kernel.org;
>> Matthew Garrett
>> Subject: Re: [PATCH 3/3] platform/x86: dell-wmi: add keys to
>> bios_to_linux_keycode
>>
>>
>> [EXTERNAL EMAIL]
>>
>> Hello!
>>
>> On Monday 08 June 2020 00:22:26 Y Paritcher wrote:
>>> Increase length of bios_to_linux_keycode to 2 bytes to allow for a new
>>> keycode 0xffff, this silences the following messages being logged at
>>> startup on a Dell Inspiron 5593
> 
> Which event type?  Can you show the whole WMI buffer that came through?
> 
>>>
>>> dell_wmi: firmware scancode 0x48 maps to unrecognized keycode 0xffff
>>> dell_wmi: firmware scancode 0x50 maps to unrecognized keycode 0xffff
>>>
>>> Signed-off-by: Y Paritcher <y.linux@paritcher.com>
>>> ---
>>>  drivers/platform/x86/dell-wmi.c | 3 ++-
>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/platform/x86/dell-wmi.c b/drivers/platform/x86/dell-
>> wmi.c
>>> index f37e7e9093c2..5ef716e3034f 100644
>>> --- a/drivers/platform/x86/dell-wmi.c
>>> +++ b/drivers/platform/x86/dell-wmi.c
>>> @@ -196,7 +196,7 @@ struct dell_dmi_results {
>>>  };
>>>
>>>  /* Uninitialized entries here are KEY_RESERVED == 0. */
>>> -static const u16 bios_to_linux_keycode[256] = {
>>> +static const u16 bios_to_linux_keycode[65536] = {
>>
>> This change dramatically increase memory usage. I guess other that
>> maintainers would not like such change.
>>
>>>  	[0]	= KEY_MEDIA,
>>>  	[1]	= KEY_NEXTSONG,
>>>  	[2]	= KEY_PLAYPAUSE,
>>> @@ -237,6 +237,7 @@ static const u16 bios_to_linux_keycode[256] = {
>>>  	[37]	= KEY_UNKNOWN,
>>>  	[38]	= KEY_MICMUTE,
>>>  	[255]	= KEY_PROG3,
>>> +	[65535]	= KEY_UNKNOWN,
>>
>> Also it seems that this change is not complete. It looks like that you
>> map two different scancodes (0x48 and 0x50) to same keycodes, moreover
>> both are unknown.
>>
>> Could you please describe which key presses (or events) generate
>> delivering these WMI scancode events?
>>
>> Note that purpose of printing unknown/unrecognized keys messages is to
>> inform that current pressed key was not processed or that it was
>> ignored.
>>
>> For me it looks like this just just hide information that key was not
>> processed correctly as this change does not implement correct processing
>> of this key.


The dell_wmi: firmware scancode XXXX maps to unrecognized keycode XXXX
events are emitted at startup when processing DMI table entries that dell-wmi
does not recognize.

my DMI table contains among others:
48 00 FF FF 
50 00 FF FF

the scan/keycodes are 2 bytes the array was only 1 byte until now as there were
never any reported keycodes with the higher byte set.


unlike my other patches this one is not for key press events. None of the keys on my laptop correspond to these scancode/keycode.

the reason for this type of log event is in a comment:

/*
 * Log if we find an entry in the DMI table that we don't
 * understand.  If this happens, we should figure out what
 * the entry means and add it to bios_to_linux_keycode.
 */

therefore I tried adding this to the list of known keycodes.
As of now almost half of the keycodes in the list are KEY_UNKNOWN.

If anyone has a way of figuring out how to map this to a specific key,
i will try to identify it further.


>>
>> Also, could you share documentation about these 0x48/0x50 events? Or it
>> is under NDA?
>>

I am just a regular user. I have no clue what they are nor any inside info.
>>>  };
>>>
>>>  /*
>>> --
>>> 2.27.0
>>>
> 
> I would actually question if there is value to lines in dell-wmi.c like this:
> 
> pr_info("Unknown WMI event type 0x%x\n", (int)buffer_entry[1]);
> 
> and
> 
> pr_info("Unknown key with type 0x%04x and code 0x%04x pressed\n", type, code);
> 
> In both of those cases the information doesn't actually help the user, by default it's
> ignored by the driver anyway.  It just notifies the user it's something the driver doesn't
> comprehend.  I would think these are better suited to downgrade to debug.  And if
> a key combination isn't doing something expected the user can use dyndbg to turn it
> back on and can be debugged what should be populated or "explicitly" ignored.
> 

I agree with this. The only reason i am adding these definitions is to get rid of 
annoying log messages. They should really be debug. 
