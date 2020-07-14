Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9835FC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 17:14:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D57922574
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 17:14:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QeIs1Pa7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728825AbgGNROp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 13:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726169AbgGNROo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 13:14:44 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38349C061755;
        Tue, 14 Jul 2020 10:14:44 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id x9so7298838plr.2;
        Tue, 14 Jul 2020 10:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Q1yP5MjK68khXRUCkC/tMY60bn7lSwmNLj1+YFBxTWQ=;
        b=QeIs1Pa7YD1iGhw4n/zGMhkL8GtA9hfQkiaBw1JRei+FBMOtuB8jgazx6JA7yzkeWq
         trJGGbCKJKy+gD1qYDAyAEQTHdYKtMfz2abpOOZNF5zB74RyACPLneALJuDaT6Ddzy+j
         aF+cSgu190I45dT+AS0x/UGgYyWqbUkL6KDc16k1vNqDnekD5Hq5XV51BqEWHWsTQwFd
         /i/KxAyfY5y6jywnIz0GaApJbZZV6z41wnmJCUJYbXn6XAnE+RCMbSdU/ZokrdM+2TKS
         XH6d1s02Oslo3PfPlZxG2YAuIiAMgvdQjNE9kEjgcvEfRivfl8mbR/iybvagWs/E+bgZ
         Jybg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Q1yP5MjK68khXRUCkC/tMY60bn7lSwmNLj1+YFBxTWQ=;
        b=jAp33x9/74QAVc2Vg4HZcMgdCx93iN0/XPPcF4XpOVr9M5xW6ZYkMoOr531OA1zVUc
         ePZyrOgQu5vPAIL3F6M9oTLIKH8LZNvBZ521z1WOn0DheftsoNcPZIDT1AbEFswDrbp4
         e4msWoAYql0M8Is9rxXdTSlnxZooM8G33ECaWzsvv33L+g+vHpn1TjaLnWccLB89s3Bb
         LUd1H6FlCw4rh4tg7VD191us7lo3ZFz1mF8xtLX8ZX5oQBaWHsjoDa7ZbNloai0g1BbP
         pgv7/frgIPZSKZ8wPbmXnCwvKiprv7BW2zwBkbVNpeJ/4SvV2dKJ8W2PTNpFLA4f8QjO
         XIdA==
X-Gm-Message-State: AOAM533gKJW7Rzt2qNvgGyeWYJq4/1hbScA3oeAtl7E02j1RnqqL8lSX
        TWToIZ+x/Z/NoB7UJ6B3ky83KUiA6ZM=
X-Google-Smtp-Source: ABdhPJwiYN9U+BM+9hxgQIYscYAzySsq1JbBAPx+shplhicxzcZ0T9ZedwhzPZHoMuKj6nmRQlmANQ==
X-Received: by 2002:a17:902:30d:: with SMTP id 13mr2335102pld.251.1594746883454;
        Tue, 14 Jul 2020 10:14:43 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u2sm17557409pfl.21.2020.07.14.10.14.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jul 2020 10:14:42 -0700 (PDT)
Subject: Re: [PATCH v2] hwmon: (drivetemp) Avoid SCT usage on Toshiba DT01ACA
 family drives
To:     "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <8325438e25a3a5a7e6d12ef6ede8f4350e4c65be.1594500029.git.mail@maciej.szmigiero.name>
 <50fb6686-5d36-ccb6-4620-c516472c6c0f@roeck-us.net>
 <0bf1376f-9e55-aecb-e03d-75b5fdf31339@maciej.szmigiero.name>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <211fa8c0-3b09-fbb5-b376-bb10ee6e13e3@roeck-us.net>
Date:   Tue, 14 Jul 2020 10:14:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <0bf1376f-9e55-aecb-e03d-75b5fdf31339@maciej.szmigiero.name>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/14/20 7:11 AM, Maciej S. Szmigiero wrote:
> On 14.07.2020 16:02, Guenter Roeck wrote:
>> On 7/11/20 1:41 PM, Maciej S. Szmigiero wrote:
>>> It has been observed that Toshiba DT01ACA family drives have
>>> WRITE FPDMA QUEUED command timeouts and sometimes just freeze until
>>> power-cycled under heavy write loads when their temperature is getting
>>> polled in SCT mode. The SMART mode seems to be fine, though.
>>>
>>> Let's make sure we don't use SCT mode for these drives then.
>>>
>>> While only the 3 TB model was actually caught exhibiting the problem let's
>>> play safe here to avoid data corruption and extend the ban to the whole
>>> family.
>>>
>>> Fixes: 5b46903d8bf3 ("hwmon: Driver for disk and solid state drives with temperature sensors")
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
>>> ---
>>>
>>> Notes:
>>>     This behavior was observed on two different DT01ACA3 drives.
>>>     
>>>     Usually, a series of queued WRITE FPDMA QUEUED commands just time out,
>>>     but sometimes the whole drive freezes. Merely disconnecting and
>>>     reconnecting SATA interface cable then does not unfreeze the drive.
>>>     
>>>     One has to disconnect and reconnect the drive power connector for the
>>>     drive to be detected again (suggesting the drive firmware itself has
>>>     crashed).
>>>     
>>>     This only happens when the drive temperature is polled very often (like
>>>     every second), so occasional SCT usage via smartmontools is probably
>>>     safe.
>>>     
>>>     Changes from v1:
>>>     'SCT blacklist' -> 'SCT avoid models'
>>>
>>>  drivers/hwmon/drivetemp.c | 37 +++++++++++++++++++++++++++++++++++++
>>>  1 file changed, 37 insertions(+)
>>>
>>> diff --git a/drivers/hwmon/drivetemp.c b/drivers/hwmon/drivetemp.c
>>> index 0d4f3d97ffc6..da9cfcbecc96 100644
>>> --- a/drivers/hwmon/drivetemp.c
>>> +++ b/drivers/hwmon/drivetemp.c
>>> @@ -285,6 +285,36 @@ static int drivetemp_get_scttemp(struct drivetemp_data *st, u32 attr, long *val)
>>>  	return err;
>>>  }
>>>  
>>> +static const char * const sct_avoid_models[] = {
>>> +/*
>>> + * These drives will have WRITE FPDMA QUEUED command timeouts and sometimes just
>>> + * freeze until power-cycled under heavy write loads when their temperature is
>>> + * getting polled in SCT mode. The SMART mode seems to be fine, though.
>>> + *
>>> + * While only the 3 TB model was actually caught exhibiting the problem
>>> + * let's play safe here to avoid data corruption and ban the whole family.
>>> + */
>>> +	"TOSHIBA DT01ACA0",
>>> +	"TOSHIBA DT01ACA1",
>>> +	"TOSHIBA DT01ACA2",
>>> +	"TOSHIBA DT01ACA3",
>>> +};
>>> +
>>> +static bool drivetemp_sct_avoid(struct drivetemp_data *st)
>>> +{
>>> +	struct scsi_device *sdev = st->sdev;
>>> +	unsigned int ctr;
>>> +
>>> +	if (!sdev->model)
>>> +		return false;
>>> +
>>> +	for (ctr = 0; ctr < ARRAY_SIZE(sct_avoid_models); ctr++)
>>> +		if (strncmp(sdev->model, sct_avoid_models[ctr], 16) == 0)
>>
>> Why strncmp, and why length 16 ? Both strings are, as far as I can see,
>> 0 terminated. A fixed length only asks for trouble later on as more models
>> are added to the list.
> 
> The first 16 bytes of sdev->model contain the model number, the rest
> seems to be the drive serial number.
> There is no NULL separator between them.
> 

If the "16" is based on some SCSI standard, there should be
a define for it somewhere. Otherwise, the comparison should
use strlen(sct_avoid_models[ctr]) and explain the reason.
In the latter case, it might possibly make sense to match
"TOSHIBA DT01ACA" to also catch later models.

Thanks,
Guenter

> See how the SCSI device model is printed for the sysfs "model"
> attribute:
> https://elixir.bootlin.com/linux/v5.8-rc4/source/drivers/scsi/scsi_sysfs.c#L654
> 
>> Also, please use "!" instead of "== 0".
> 
> Will do.
> 
> Thanks,
> Maciej
> 

