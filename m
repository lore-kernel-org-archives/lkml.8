Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9DBEC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 20:12:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9957720775
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 20:12:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paritcher.com header.i=@paritcher.com header.b="SENs+vwW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fyhwi3La"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbgFHUMx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 16:12:53 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:47185 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726415AbgFHUMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 16:12:52 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 5F9E42DC;
        Mon,  8 Jun 2020 16:12:51 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 08 Jun 2020 16:12:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=paritcher.com;
         h=subject:to:cc:references:from:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm2; bh=F
        g0Vn542WYrchSzh9EDRhXWTXxfkIgKI/zgQ0z7ezXU=; b=SENs+vwWrP+5Sa59w
        +/K+9wnjBHI9dc7amVZS4qXIqz88tOciilWKckWoc9ZzlwbwR4skIOQiGxJhkBxm
        OaEYuL9cmPrf741SMTUeYy1Cv+i3pMBQC0mqshvcIuSGHGJT7sN1fxyVK6oF4kLG
        aCuRCngT1KYoO+mh5q+2YNbTAvetYMbmUzQ7HTSYjUOxSAOmboz+TulRRuc/mrHm
        AY3VlaWlhVzkBRlYYByBXpO6mJe+yC1bcFNfF0CTBggDfkXCgMCd4PwlxsY0hOTR
        YBAOaWQ0CW+Rbjh20mVIDoJxyrC/XgHAY13nyu4WciyJD3vNoYXTzSczl5yseSCX
        uO8Kw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=Fg0Vn542WYrchSzh9EDRhXWTXxfkIgKI/zgQ0z7ez
        XU=; b=fyhwi3LamzgKwpMTTokM9r/gVQZCjXV4nUwRASfXEfMbzhKHbh9BQ+og2
        us9P+/6g5dJyto0GAAr7Wd23atgMDaFHznmRQntOQ0dXK5X5wrvBrMPVArXzHURy
        hcLxkk4ii0ndzoHZucubICjYO6S+oWS6gdQ72os03jvjjcJ+y1zbaTNf1d8TOies
        9lM++sbY5T2ieFMrqVS2BAf9sXpB/nj1QrD4umGzGjXkOcVDfi+tA7oCqn7t0AEw
        zc48Gzhd6gKUnZNPgZxs0sH0aQ/xI0eE9IEKnM4vlSTXPqb5gy2gniNZPjlC/VYn
        NLhO1+TwdXFsbrCpFL3/kqg8QESnw==
X-ME-Sender: <xms:wpveXn-RMoRUHcQ6xwAlHowa7H2eNvyEmbH4hYCvV4ioQZlpKlOhCQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudehvddgkeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvfhfhkffffgggjggtgfesthekredttdefjeenucfhrhhomhepjgcurfgr
    rhhithgthhgvrhcuoeihrdhlihhnuhigsehprghrihhttghhvghrrdgtohhmqeenucggtf
    frrghtthgvrhhnpeduleethedtudeikefhkeeiieelfeekkedvhfdvffejjeekjefhudek
    heejvdfgleenucfkphepieejrdekgedrudelgedrudejheenucevlhhushhtvghrufhiii
    gvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpeihrdhlihhnuhigsehprghrihhttghh
    vghrrdgtohhm
X-ME-Proxy: <xmx:wpveXjspSkPXVpwYXEpAIUXV83ckn0BXCRBTHOUduV6hwDlTkEVlMQ>
    <xmx:wpveXlDoYmugzN37_gW_DLwrNtd1eIJEugEKO5iEqRPFW3ZgDSTq6w>
    <xmx:wpveXjc2eGRjCBiL5CIIeBL9G0C8g6qiZBSB6MdEUV97cri8BKAQCg>
    <xmx:w5veXmW_5rF0vOVClheYEQwkGsoVmyvpe1RVfU5Tu7NTZ7p6cSlIgg>
Received: from [192.168.0.106] (ool-4354c2af.dyn.optonline.net [67.84.194.175])
        by mail.messagingengine.com (Postfix) with ESMTPA id 87E703280066;
        Mon,  8 Jun 2020 16:12:50 -0400 (EDT)
Subject: Re: [PATCH 2/3] platform/x86: dell-wmi: add new keymap type 0x0012
To:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Matthew Garrett <mjg59@srcf.ucam.org>
References: <cover.1591584631.git.y.linux@paritcher.com>
 <0dc191a3d16f0e114f6a8976433e248018e10c43.1591584631.git.y.linux@paritcher.com>
 <20200608085012.ve2zefw26hisagso@pali>
From:   Y Paritcher <y.linux@paritcher.com>
Message-ID: <18ead8db-eb6f-8492-f5a4-4175de51e659@paritcher.com>
Date:   Mon, 8 Jun 2020 16:12:50 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200608085012.ve2zefw26hisagso@pali>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/8/20 4:50 AM, Pali Rohár wrote:
> Hello!
> 
> On Monday 08 June 2020 00:22:25 Y Paritcher wrote:
>> Ignore events with a type of 0x0012 and a code of 0xe035,
>> this silences the following messages being logged when
>> pressing the Fn-lock key on a Dell Inspiron 5593:
> 
> Could you please explain why to ignore these events instead of sending
> them to userspace via input layer? I think that userspace can be
> interested in knowing when Fn lock key was pressed and I can imagine
> that some it can use it for some purposes.
> 

I followed what was already done for the Fn lock key on other models.
The Fn lock key toggle is adjusted by the keyboard controller so there is 
nothing userspace should do with it.

If this is wrong the behavior should be changed for all Fn lock key entries.
>> dell_wmi: Unknown WMI event type 0x12
>> dell_wmi: Unknown key with type 0x0012 and code 0xe035 pressed
> 
> These messages are printed to inform about fact that some events were
> not processed. And they should not be silenced without reason. If for
> some reasons it is needed to completely ignore some kind of events then
> this reason should be documented (e.g. in commit message) so other
> developers would know why that code is there. Not all Linux developers
> have all those Dell machines for testing so they do not know all
> hardware details.
> 

I could be wrong, but i understood these messages to inform about a unknown event.
once the event is identified there should be no reason for them.
>> Signed-off-by: Y Paritcher <y.linux@paritcher.com>
>> ---
>>  drivers/platform/x86/dell-wmi.c | 17 +++++++++++++++++
>>  1 file changed, 17 insertions(+)
>>
>> diff --git a/drivers/platform/x86/dell-wmi.c b/drivers/platform/x86/dell-wmi.c
>> index 0b4f72f923cd..f37e7e9093c2 100644
>> --- a/drivers/platform/x86/dell-wmi.c
>> +++ b/drivers/platform/x86/dell-wmi.c
>> @@ -334,6 +334,14 @@ static const struct key_entry dell_wmi_keymap_type_0011[] = {
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
>>  static void dell_wmi_process_key(struct wmi_device *wdev, int type, int code)
>>  {
>>  	struct dell_wmi_priv *priv = dev_get_drvdata(&wdev->dev);
>> @@ -425,6 +433,7 @@ static void dell_wmi_notify(struct wmi_device *wdev,
>>  			break;
>>  		case 0x0010: /* Sequence of keys pressed */
>>  		case 0x0011: /* Sequence of events occurred */
>> +		case 0x0012: /* Sequence of events occurred */
> 
> It is really sequence of events? Because you wrote that Fn-lock key was
> pressed (and not generic event). Also it is really sequence? And not
> just one event/key-press (with possibility of some additional details in
> buffer)? It would be nice to put documentation for this type of events
> to check and review that implementation is correct.
> 

see Mario Limonciello's answer
>>  			for (i = 2; i < len; ++i)
>>  				dell_wmi_process_key(wdev, buffer_entry[1],
>>  						     buffer_entry[i]);
>> @@ -556,6 +565,7 @@ static int dell_wmi_input_setup(struct wmi_device *wdev)
>>  			 ARRAY_SIZE(dell_wmi_keymap_type_0000) +
>>  			 ARRAY_SIZE(dell_wmi_keymap_type_0010) +
>>  			 ARRAY_SIZE(dell_wmi_keymap_type_0011) +
>> +			 ARRAY_SIZE(dell_wmi_keymap_type_0012) +
>>  			 1,
>>  			 sizeof(struct key_entry), GFP_KERNEL);
>>  	if (!keymap) {
>> @@ -600,6 +610,13 @@ static int dell_wmi_input_setup(struct wmi_device *wdev)
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
>>
