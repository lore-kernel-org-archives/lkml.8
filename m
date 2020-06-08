Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7A8EC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 20:12:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88CB5206D5
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 20:12:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paritcher.com header.i=@paritcher.com header.b="xNwCWwiD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mWqz/9Ta"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbgFHUM7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 16:12:59 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:35005 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726415AbgFHUMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 16:12:55 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id AE7F1350;
        Mon,  8 Jun 2020 16:12:53 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 08 Jun 2020 16:12:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=paritcher.com;
         h=subject:to:cc:references:from:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm2; bh=q
        zVPq2pKKNr8EU47M+BKxSI+2rgoyGVbawOMfALqHU8=; b=xNwCWwiDDWbz+CWdK
        v3IGLjnHTaFAGxUBf/s6G9evaDcr8Fvhs9iraBQTW1ceNqzj8+1snN/0nfEJNA8g
        D1+5qR7v2MAfzJVvNiAR50wW2DbAwZWgIpI0GmCuZelRvgdJU73Zh0Bosz2X238b
        qG7pAw/8mMvIFzacfbLapAYsL5SDKOzVDERCWN+ZHWqxc3YtR3ZayFcuMNuEbgzJ
        ApFH01kFWi6fovLVUcWahgUg0F/RyK2p5ck1WyBZlOKZksCfOVlX5IVbAqeg7kWK
        5jU6qiK1c8N5LFQNOL+n+maT46c8ef6pl+QPlx0VRXEL78mbpwYRUFURJgs68b8p
        4w26Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=qzVPq2pKKNr8EU47M+BKxSI+2rgoyGVbawOMfALqH
        U8=; b=mWqz/9TahznBqAZOXrguLXNEoxvPdRWbB+22aN1crvT9KkWPQjT4qwbM2
        A7WUHv2cDfqsJfVU5R1RpRAEeZiks+SC9WK3Ez/5+HZOD3lwYDjsc4FRUmOCO3pL
        quVFgMU6qnN6/qKFmKZJMAv9o4Ii7EFi+GBuxyTcbCgpUq34NhqHoEmEdJamKoNX
        SLcJVeVzzk7L43U3kc07N35LFzFMsu/7ZaBKuQ8TYANoHWQGim2+wmWxhsfaF+8C
        k9azKgQoM2EhjlkwDHL1E8IL8X0pRMktWtyfEM1fFffgL4AeBj+rIV1nfqyFHTGB
        xmZS2tEs9gQrTVLuXqk6GqqKE0AXA==
X-ME-Sender: <xms:xZveXuA_cInJNQ96FuiOfhV4duiY7ubt-aiO2s03D-0f-umQ09_pAA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudehvddgkeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefuvfhfhffkffgfgggjtgfgsehtke
    ertddtfeejnecuhfhrohhmpegjucfrrghrihhttghhvghruceohidrlhhinhhugiesphgr
    rhhithgthhgvrhdrtghomheqnecuggftrfgrthhtvghrnhepudelteehtdduieekhfekie
    eileefkeekvdfhvdffjeejkeejhfdukeehjedvgfelnecukfhppeeijedrkeegrdduleeg
    rddujeehnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomh
    ephidrlhhinhhugiesphgrrhhithgthhgvrhdrtghomh
X-ME-Proxy: <xmx:xZveXoiOpMgWwDcRAA_JKUsZyHOHLxpj1A_nFiVHAfEJzIVbGHASIQ>
    <xmx:xZveXhk435LBXeBB79MFY_y30ZQ5ThoGrFFgvsVqh04aiG4fexLrSA>
    <xmx:xZveXszEYL98NhZI8feBFe1G94BRkJGQhYXnG6TReetZawLkoTGgLA>
    <xmx:xZveXqIdhwaG2NCc97YLxTdmcMtuU24jxfbyRc-C9S5MayXWWEBOhw>
Received: from [192.168.0.106] (ool-4354c2af.dyn.optonline.net [67.84.194.175])
        by mail.messagingengine.com (Postfix) with ESMTPA id E7447328005A;
        Mon,  8 Jun 2020 16:12:52 -0400 (EDT)
Subject: Re: [PATCH 2/3] platform/x86: dell-wmi: add new keymap type 0x0012
To:     Mario.Limonciello@dell.com
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        mjg59@srcf.ucam.org, pali@kernel.org
References: <cover.1591584631.git.y.linux@paritcher.com>
 <0dc191a3d16f0e114f6a8976433e248018e10c43.1591584631.git.y.linux@paritcher.com>
 <83fe431cacbc4708962767668ac8f06f@AUSX13MPC105.AMER.DELL.COM>
From:   Y Paritcher <y.linux@paritcher.com>
Message-ID: <79bd59ee-dd37-bdc5-f6b4-00f2c33fdcff@paritcher.com>
Date:   Mon, 8 Jun 2020 16:12:52 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <83fe431cacbc4708962767668ac8f06f@AUSX13MPC105.AMER.DELL.COM>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/8/20 11:40 AM, Mario.Limonciello@dell.com wrote:
>> -----Original Message-----
>> From: platform-driver-x86-owner@vger.kernel.org <platform-driver-x86-
>> owner@vger.kernel.org> On Behalf Of Y Paritcher
>> Sent: Sunday, June 7, 2020 11:22 PM
>> Cc: linux-kernel@vger.kernel.org; platform-driver-x86@vger.kernel.org;
>> Matthew Garrett; Pali Rohár
>> Subject: [PATCH 2/3] platform/x86: dell-wmi: add new keymap type 0x0012
>>
>>
>> [EXTERNAL EMAIL]
>>
>> Ignore events with a type of 0x0012 and a code of 0xe035,
>> this silences the following messages being logged when
>> pressing the Fn-lock key on a Dell Inspiron 5593:
>>
>> dell_wmi: Unknown WMI event type 0x12
>> dell_wmi: Unknown key with type 0x0012 and code 0xe035 pressed
> 
> Event type 0x12 is for "System Events".  This is the type of events that
> you typically would see come in for things "like" the wrong power adapter
> being plugged in on Windows or stuff about plugging a Thunderbolt dock into
> a port that doesn't support Thunderbolt.
> 
> A message might look something like (paraphrased)
> "Your system requires a 180W power adapter to charge effectively, but you
> plugged in a 60W adapter."
> 
> There often is extended data with these events.  As such I don't believe all
> information in event type 0x0012 should be treated like scan codes like those in
> 0x10 or 0x11.
> 
> I would guess that Fn-lock on this machine probably has extended data in the next
> showing whether it was turned on and off.  If it does, perhaps it makes sense to
> send this information to userspace as an evdev switch instead.
> 

You are right.
I had assumed (incorrectly) the were the same.
I turned on dyndbg and got the events with the extended data.

Fn lock key switched to multimedia keys
dell_wmi: Received WMI event (02 00 12 00 35 e0 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00)
the extended data is e0 01

Fn-lock switched to function keys
dell_wmi: Received WMI event (02 00 12 00 35 e0 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00)
the extended data is e0 00

Therefore i agree this should have it's own case in `dell_wmi_process_key` but i am
not sure yet how to deal with it. any suggestion are helpful.

About sending it to userspace, I just followed what was already done, if that is not
desired we should change it for all the models.
>>
>> Signed-off-by: Y Paritcher <y.linux@paritcher.com>
>> ---
>>  drivers/platform/x86/dell-wmi.c | 17 +++++++++++++++++
>>  1 file changed, 17 insertions(+)
>>
>> diff --git a/drivers/platform/x86/dell-wmi.c b/drivers/platform/x86/dell-
>> wmi.c
>> index 0b4f72f923cd..f37e7e9093c2 100644
>> --- a/drivers/platform/x86/dell-wmi.c
>> +++ b/drivers/platform/x86/dell-wmi.c
>> @@ -334,6 +334,14 @@ static const struct key_entry
>> dell_wmi_keymap_type_0011[] = {
>>  	{ KE_IGNORE, KBD_LED_AUTO_100_TOKEN, { KEY_RESERVED } },
>>  };
>>
>> +/*
>> + * Keymap for WMI events of type 0x0012
>> + */
>> +static const struct key_entry dell_wmi_keymap_type_0012[] = {
>> +	/* Fn-lock button pressed */
>> +	{ KE_IGNORE, 0xe035, { KEY_RESERVED } },
>> +};
>> +
>>  static void dell_wmi_process_key(struct wmi_device *wdev, int type, int
>> code)
>>  {
>>  	struct dell_wmi_priv *priv = dev_get_drvdata(&wdev->dev);
>> @@ -425,6 +433,7 @@ static void dell_wmi_notify(struct wmi_device *wdev,
>>  			break;
>>  		case 0x0010: /* Sequence of keys pressed */
>>  		case 0x0011: /* Sequence of events occurred */
>> +		case 0x0012: /* Sequence of events occurred */
>>  			for (i = 2; i < len; ++i)
>>  				dell_wmi_process_key(wdev, buffer_entry[1],
>>  						     buffer_entry[i]);
>> @@ -556,6 +565,7 @@ static int dell_wmi_input_setup(struct wmi_device
>> *wdev)
>>  			 ARRAY_SIZE(dell_wmi_keymap_type_0000) +
>>  			 ARRAY_SIZE(dell_wmi_keymap_type_0010) +
>>  			 ARRAY_SIZE(dell_wmi_keymap_type_0011) +
>> +			 ARRAY_SIZE(dell_wmi_keymap_type_0012) +
>>  			 1,
>>  			 sizeof(struct key_entry), GFP_KERNEL);
>>  	if (!keymap) {
>> @@ -600,6 +610,13 @@ static int dell_wmi_input_setup(struct wmi_device
>> *wdev)
>>  		pos++;
>>  	}
>>
>> +	/* Append table with events of type 0x0012 */
>> +	for (i = 0; i < ARRAY_SIZE(dell_wmi_keymap_type_0012); i++) {
>> +		keymap[pos] = dell_wmi_keymap_type_0012[i];
>> +		keymap[pos].code |= (0x0012 << 16);
>> +		pos++;
>> +	}
>> +
>>  	/*
>>  	 * Now append also table with "legacy" events of type 0x0000. Some of
>>  	 * them are reported also on laptops which have scancodes in DMI.
>> --
>> 2.27.0
> 
