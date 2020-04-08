Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC1FAC2D0F4
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 03:59:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3D0620678
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 03:59:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbgDHD7X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 23:59:23 -0400
Received: from mail.itouring.de ([188.40.134.68]:45750 "EHLO mail.itouring.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726464AbgDHD7X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 23:59:23 -0400
Received: from tux.applied-asynchrony.com (p5B07E2B3.dip0.t-ipconnect.de [91.7.226.179])
        by mail.itouring.de (Postfix) with ESMTPSA id 14A1B4160ED7;
        Wed,  8 Apr 2020 05:59:21 +0200 (CEST)
Received: from [192.168.100.223] (ragnarok.applied-asynchrony.com [192.168.100.223])
        by tux.applied-asynchrony.com (Postfix) with ESMTP id BD004F01600;
        Wed,  8 Apr 2020 05:59:20 +0200 (CEST)
Subject: Re: hwmon: drivetemp: bogus values after wake up from suspend
To:     Guenter Roeck <linux@roeck-us.net>,
        LKML <linux-kernel@vger.kernel.org>
References: <1af049a1-63ae-ee55-05d5-0e55eb00bd0e@applied-asynchrony.com>
 <03b3159b-e9ca-011d-d95c-6572cc07d895@roeck-us.net>
From:   =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
Organization: Applied Asynchrony, Inc.
Message-ID: <51052162-6d79-f5c0-a811-b77587b51195@applied-asynchrony.com>
Date:   Wed, 8 Apr 2020 05:59:20 +0200
MIME-Version: 1.0
In-Reply-To: <03b3159b-e9ca-011d-d95c-6572cc07d895@roeck-us.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/7/20 3:41 AM, Guenter Roeck wrote:
> On 4/6/20 9:23 AM, Holger Hoffstätte wrote:
>>
>> I've been giving the drivetemp hwmon driver a try and am very happy
>> with it; works right away and - much to my surprise - doesn't wake up
>> HDDs that have gone to sleep. Nice!
>>
>> I did notice one tiny thing though: after waking up from suspend, my SSD
>> (Samsung 850 Pro) reports a few initial bogus values - suspiciously -128°,
>> which is definitely not the temperature in my office. While this is more
>> a cosmetic problem, it cramps my monitoring setup and leads to wrong graphs.
>> Can't have that!
>>
>> So I looked into the source and found that the values are (understandably)
>> passed on unfiltered/uncapped. Since it's unlikely any active device has
>> operating temperature below-zero, I figured the laziest way is to cap the
>> value to positive:
>>
>> diff -rup a/drivers/hwmon/drivetemp.c b/drivers/hwmon/drivetemp.c
>> --- a/drivers/hwmon/drivetemp.c    2020-04-02 08:02:32.000000000 +0200
>> +++ b/drivers/hwmon/drivetemp.c    2020-04-06 18:13:04.892554087 +0200
>> @@ -147,7 +147,7 @@ static LIST_HEAD(drivetemp_devlist);
>>   #define INVALID_TEMP        0x80
>>   
>>   #define temp_is_valid(temp)    ((temp) != INVALID_TEMP)
>> -#define temp_from_sct(temp)    (((s8)(temp)) * 1000)
>> +#define temp_from_sct(temp)    (max(0, ((s8)(temp)) * 1000))
>>   
>>   static inline bool ata_id_smart_supported(u16 *id)
>>   {
>>
>> The assumption is of course *theoretically* wrong since some
>> equipment might indeed operate in negative C°. One way might be
>> to use the device's "low" operating point first, but then that
>> might not be available and we'd be back to capping to 0.
>> I'm open to other suggestions. :)
>>
> 
> Looking into the code, 0x80 or -128 indeed reflects an invalid temperature.

Excellent, that's of course much better than just capping to 0.

> Any chance you can apply the following to see if it helps ?
> 
> diff --git a/drivers/hwmon/drivetemp.c b/drivers/hwmon/drivetemp.c
> index 370d0c74eb01..c27239eb28cf 100644
> --- a/drivers/hwmon/drivetemp.c
> +++ b/drivers/hwmon/drivetemp.c
> @@ -264,6 +264,8 @@ static int drivetemp_get_scttemp(struct drivetemp_data *st, u32 attr, long *val)
>                  return err;
>          switch (attr) {
>          case hwmon_temp_input:
> +               if (!temp_is_valid(buf[SCT_STATUS_TEMP]))
> +                       return -ENODATA;
>                  *val = temp_from_sct(buf[SCT_STATUS_TEMP]);
>                  break;
>          case hwmon_temp_lowest:
> 
> I am not sure what the best error code would be - suggestions welcome.

Gave it a try and had to wait overnight for things to cool down
(just suspending for an hour wouldn't do it). Right after wakeup sensors
now shows "N/A" as expected, and no illegal values in drivetemp or my
monitoring; missing values are perfectly fine.
After a few minutes correct values show up and all is good.

In case you submit this as official patch feel free to add my
Reported-by/Tested-by. Thanks for looking into it!

cheers
Holger
