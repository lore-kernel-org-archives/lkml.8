Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3EF3C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 20:11:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B86F20774
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 20:11:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paritcher.com header.i=@paritcher.com header.b="NwLPg3nR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jrz12uST"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbgFHULx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 16:11:53 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:60853 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726415AbgFHULw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 16:11:52 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id F0CD4313;
        Mon,  8 Jun 2020 16:11:50 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 08 Jun 2020 16:11:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=paritcher.com;
         h=subject:to:cc:references:from:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm2; bh=o
        Q3eFUYRYB5GJ6owFc7O9icm98DQlBRwJrj/V8orrW0=; b=NwLPg3nRKGjJmpd9v
        gpVdTKJZzNjQtk1phCPYmLfvL1mFLG4eAuQVGGyVljvKUuutTvCp40ZjbwWGmml+
        X1yNdSiRJ8UFcT91CyqnS21aUIQQhYuigX6lKI+eoNB3h3vpodII0588ODdJMeFI
        z2aUl8eVE5SdjLNA5byh91OXb4fKESELWx3tz95kIFQ/61DslKVNbfowCekbnfpG
        GXXw32BtSQ7TU6qY4+aPndiMG/c6wd12U3u+yvDmSQLROvXbBSrY2xRI8rmI6UUr
        NlgxEIiNTCWoLJqbdliJ0WbXIEuyj6S+MFOqCw3l2DxDxMh1rky3Wm/ZU4/9+tXq
        L1iBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=oQ3eFUYRYB5GJ6owFc7O9icm98DQlBRwJrj/V8orr
        W0=; b=jrz12uST4MK9FfgrkS3OufHV+oLr2uc6DW+f0YB3v090AQ879N9RP2pdL
        9jQT/nn6f6bkslO+lZjZ/9UL2whj5fwuvjsc1A8h/zIYGr4DM0NUF0dX+K/yVRbS
        Zu278fTtq8dj/RhxCxm+ql6IOay71Cwe4pNOO1+GOb5S4/RgAc6mmcqNIdp2l3Kg
        3ZOt/uf90HgAf9X1WaXszkGjiEnk0yz6HjLkt9CtBOA+cFYWA51iXQ0pD2Wr+2j1
        8HkkQ4Lbvouc7cajioDlLLzsf06MvO6JEOrGT4/7kRkKFDYfyOSe5v4/Pocx9cJs
        +lfTEWu9YGeBD26t6DAnK8Dpb1mQQ==
X-ME-Sender: <xms:hZveXml-svMWq85C_oTou895S6RwqnbCE3wQfQ5EwImsr4E_dDIKFg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudehvddgkeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefuvfhfhffkffgfgggjtgfgsehtke
    ertddtfeejnecuhfhrohhmpegjucfrrghrihhttghhvghruceohidrlhhinhhugiesphgr
    rhhithgthhgvrhdrtghomheqnecuggftrfgrthhtvghrnhepudelteehtdduieekhfekie
    eileefkeekvdfhvdffjeejkeejhfdukeehjedvgfelnecukfhppeeijedrkeegrdduleeg
    rddujeehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    ephidrlhhinhhugiesphgrrhhithgthhgvrhdrtghomh
X-ME-Proxy: <xmx:hZveXt1EVP_H-ZKXKRZYMhD4zmEdK17mc91MlFqpeV0vD4HQAKNXEw>
    <xmx:hZveXko43IVa5AHRVYALc9j_lkoXYxaNP71FmkG9NHj7KzvGDcNnDA>
    <xmx:hZveXqnfcS7TZRWn9FPkSZgPYl4IY0raAOAZELGqHoqyFdgDLEY7cQ>
    <xmx:hpveXh_XWxytbPiwBVnOz6KApn-JY_KJwWsGnRLy5ZxMD_TKN39kew>
Received: from [192.168.0.106] (ool-4354c2af.dyn.optonline.net [67.84.194.175])
        by mail.messagingengine.com (Postfix) with ESMTPA id 3C368328005E;
        Mon,  8 Jun 2020 16:11:49 -0400 (EDT)
Subject: Re: [PATCH 1/3] platform/x86: dell-wmi: add new backlight events
To:     Mario.Limonciello@dell.com, pali@kernel.org
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        mjg59@srcf.ucam.org
References: <cover.1591584631.git.y.linux@paritcher.com>
 <7dbe4e9e5ed64e4704b1c4ae13ac84df644ccc13.1591584631.git.y.linux@paritcher.com>
 <20200608083503.l5g5iq52ezxkobvv@pali>
 <3e0d394545954ed79b8f883e1ac93338@AUSX13MPC105.AMER.DELL.COM>
From:   Y Paritcher <y.linux@paritcher.com>
Message-ID: <e91bb21e-98fa-f469-cc24-abc9ae200e4d@paritcher.com>
Date:   Mon, 8 Jun 2020 16:11:49 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <3e0d394545954ed79b8f883e1ac93338@AUSX13MPC105.AMER.DELL.COM>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/8/20 11:30 AM, Mario.Limonciello@dell.com wrote:
>> -----Original Message-----
>> From: platform-driver-x86-owner@vger.kernel.org <platform-driver-x86-
>> owner@vger.kernel.org> On Behalf Of Pali Rohár
>> Sent: Monday, June 8, 2020 3:35 AM
>> To: Y Paritcher
>> Cc: linux-kernel@vger.kernel.org; platform-driver-x86@vger.kernel.org;
>> Matthew Garrett
>> Subject: Re: [PATCH 1/3] platform/x86: dell-wmi: add new backlight events
>>
>>
>> [EXTERNAL EMAIL]
>>
>> On Monday 08 June 2020 00:22:24 Y Paritcher wrote:
>>> Ignore events with a type of 0x0010 and a code of 0x57 / 0x58,
>>> this silences the following messages being logged on a
>>> Dell Inspiron 5593:
>>>
>>> dell_wmi: Unknown key with type 0x0010 and code 0x0057 pressed
>>> dell_wmi: Unknown key with type 0x0010 and code 0x0058 pressed
>>>
>>> Signed-off-by: Y Paritcher <y.linux@paritcher.com>
>>> ---
>>>  drivers/platform/x86/dell-wmi.c | 4 ++++
>>>  1 file changed, 4 insertions(+)
>>>
>>> diff --git a/drivers/platform/x86/dell-wmi.c b/drivers/platform/x86/dell-
>> wmi.c
>>> index c25a4286d766..0b4f72f923cd 100644
>>> --- a/drivers/platform/x86/dell-wmi.c
>>> +++ b/drivers/platform/x86/dell-wmi.c
>>> @@ -252,6 +252,10 @@ static const struct key_entry
>> dell_wmi_keymap_type_0010[] = {
>>>  	/* Fn-lock switched to multimedia keys */
>>>  	{ KE_IGNORE, 0x1, { KEY_RESERVED } },
>>>
>>> +	/* Backlight brightness level */
>>> +	{ KE_KEY,    0x57, { KEY_BRIGHTNESSDOWN } },
>>> +	{ KE_KEY,    0x58, { KEY_BRIGHTNESSUP } },
>>> +
> 
> For these particular events are they emitted by another interface as well in this
> platform?
> 
> If so they should be KE_IGNORE so you don't end up with double notifications to
> userspace.
Thank you both for the review,
This is my first patch so if i am doing something wrong please let me know.

Both before and after this change they are only emitted once (verified via showkeys)
this is because `dell_wmi_process_key()` calls `acpi_video_handles_brightness_key_presses()`
for brightness events, and `acpi_video_handles_brightness_key_presses()` makes sure no duplicate acpi-video events are sent.
> 
>>>  	/* Keyboard backlight change notification */
>>>  	{ KE_IGNORE, 0x3f, { KEY_RESERVED } },
>>
>> Please, keep codes sorted.

Will fix
>>
>>>
>>> --
>>> 2.27.0
>>>
