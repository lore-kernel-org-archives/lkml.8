Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2698C433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 14:11:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFD9A22510
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 14:11:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728200AbgGNOLz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 10:11:55 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113]:51252 "EHLO vps-vb.mhejs.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728187AbgGNOLy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 10:11:54 -0400
Received: from MUA
        by vps-vb.mhejs.net with esmtps (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.93.0.4)
        (envelope-from <mail@maciej.szmigiero.name>)
        id 1jvLev-0002OD-6U; Tue, 14 Jul 2020 16:11:49 +0200
Subject: Re: [PATCH v2] hwmon: (drivetemp) Avoid SCT usage on Toshiba DT01ACA
 family drives
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <8325438e25a3a5a7e6d12ef6ede8f4350e4c65be.1594500029.git.mail@maciej.szmigiero.name>
 <50fb6686-5d36-ccb6-4620-c516472c6c0f@roeck-us.net>
From:   "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Autocrypt: addr=mail@maciej.szmigiero.name; prefer-encrypt=mutual; keydata=
 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 mA==
Message-ID: <0bf1376f-9e55-aecb-e03d-75b5fdf31339@maciej.szmigiero.name>
Date:   Tue, 14 Jul 2020 16:11:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <50fb6686-5d36-ccb6-4620-c516472c6c0f@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.07.2020 16:02, Guenter Roeck wrote:
> On 7/11/20 1:41 PM, Maciej S. Szmigiero wrote:
>> It has been observed that Toshiba DT01ACA family drives have
>> WRITE FPDMA QUEUED command timeouts and sometimes just freeze until
>> power-cycled under heavy write loads when their temperature is getting
>> polled in SCT mode. The SMART mode seems to be fine, though.
>>
>> Let's make sure we don't use SCT mode for these drives then.
>>
>> While only the 3 TB model was actually caught exhibiting the problem let's
>> play safe here to avoid data corruption and extend the ban to the whole
>> family.
>>
>> Fixes: 5b46903d8bf3 ("hwmon: Driver for disk and solid state drives with temperature sensors")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
>> ---
>>
>> Notes:
>>     This behavior was observed on two different DT01ACA3 drives.
>>     
>>     Usually, a series of queued WRITE FPDMA QUEUED commands just time out,
>>     but sometimes the whole drive freezes. Merely disconnecting and
>>     reconnecting SATA interface cable then does not unfreeze the drive.
>>     
>>     One has to disconnect and reconnect the drive power connector for the
>>     drive to be detected again (suggesting the drive firmware itself has
>>     crashed).
>>     
>>     This only happens when the drive temperature is polled very often (like
>>     every second), so occasional SCT usage via smartmontools is probably
>>     safe.
>>     
>>     Changes from v1:
>>     'SCT blacklist' -> 'SCT avoid models'
>>
>>  drivers/hwmon/drivetemp.c | 37 +++++++++++++++++++++++++++++++++++++
>>  1 file changed, 37 insertions(+)
>>
>> diff --git a/drivers/hwmon/drivetemp.c b/drivers/hwmon/drivetemp.c
>> index 0d4f3d97ffc6..da9cfcbecc96 100644
>> --- a/drivers/hwmon/drivetemp.c
>> +++ b/drivers/hwmon/drivetemp.c
>> @@ -285,6 +285,36 @@ static int drivetemp_get_scttemp(struct drivetemp_data *st, u32 attr, long *val)
>>  	return err;
>>  }
>>  
>> +static const char * const sct_avoid_models[] = {
>> +/*
>> + * These drives will have WRITE FPDMA QUEUED command timeouts and sometimes just
>> + * freeze until power-cycled under heavy write loads when their temperature is
>> + * getting polled in SCT mode. The SMART mode seems to be fine, though.
>> + *
>> + * While only the 3 TB model was actually caught exhibiting the problem
>> + * let's play safe here to avoid data corruption and ban the whole family.
>> + */
>> +	"TOSHIBA DT01ACA0",
>> +	"TOSHIBA DT01ACA1",
>> +	"TOSHIBA DT01ACA2",
>> +	"TOSHIBA DT01ACA3",
>> +};
>> +
>> +static bool drivetemp_sct_avoid(struct drivetemp_data *st)
>> +{
>> +	struct scsi_device *sdev = st->sdev;
>> +	unsigned int ctr;
>> +
>> +	if (!sdev->model)
>> +		return false;
>> +
>> +	for (ctr = 0; ctr < ARRAY_SIZE(sct_avoid_models); ctr++)
>> +		if (strncmp(sdev->model, sct_avoid_models[ctr], 16) == 0)
> 
> Why strncmp, and why length 16 ? Both strings are, as far as I can see,
> 0 terminated. A fixed length only asks for trouble later on as more models
> are added to the list.

The first 16 bytes of sdev->model contain the model number, the rest
seems to be the drive serial number.
There is no NULL separator between them.

See how the SCSI device model is printed for the sysfs "model"
attribute:
https://elixir.bootlin.com/linux/v5.8-rc4/source/drivers/scsi/scsi_sysfs.c#L654

> Also, please use "!" instead of "== 0".

Will do.

Thanks,
Maciej
