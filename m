Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54821C433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 08:33:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2410A206C9
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 08:33:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="GcPJjKvd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729808AbgIDIdb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 04:33:31 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:32671 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbgIDIdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 04:33:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1599208406; x=1630744406;
  h=references:from:to:cc:subject:in-reply-to:date:
   message-id:mime-version;
  bh=q7FxclsURvMFLB4KzgyOyXIzenqxhAB++84k34J/Njo=;
  b=GcPJjKvdLfiOh008m+5DyvCNKQ5Te4JMLwkquIbSmjYV7wfosvuH4OBs
   QBSpZ4hROguGziNPmC+OeeGwpJMg1Oz8NJNHlrybyzLciNa8Ux9p59vU1
   ferBNuJoygiB/HBWvTGg+ScEO4JirTMSeOak+ysZdp4g8PlhIjjXiCvmt
   qSr0QU5xJnwX4ZRjSNtpLSMhD0LnF1K58dbZFwKxZcrp6fWYaR8W8oOhy
   kp3LoBeMTUnhLhcRMwJh2mS5o3lAZ4vIMJgtmczqUBIT5xxy7llEEfMuM
   5EK/uSFXafb4wmDyRgyjHKXOjbxXdv3/7qlWxwf0dsoIERdrHPxxIkb3H
   Q==;
IronPort-SDR: jBtz3COpuZ437EHW3+7MUlyGi+NWPaovslUEAsagCbvg/mLBURmJpyg+dbwcAe5KQ4MRlIpd/V
 F3f4YSULETNBQGYmyiCF0IZBiPu7qQTc1P1WJibgBf30aUwr2mi3BPjIHZr6tWu1n/xs2RzpB7
 bLLTRb+n73doHDJxyT+Yz6tjwUTXZgv6++7uVO4zAtRQYkqZnqmmDRnOqEmwKH19OOxNhRUj8W
 4zMYKfs81bTQQ5rVezkOCwPcTR/wM3MAu7mnOVUM1WJTJ3kNigNaWUroohVM4K/g7WYiOd19Va
 gaM=
X-IronPort-AV: E=Sophos;i="5.76,389,1592895600"; 
   d="scan'208";a="89822923"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Sep 2020 01:33:25 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 4 Sep 2020 01:33:13 -0700
Received: from soft-dev15.microsemi.net.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3
 via Frontend Transport; Fri, 4 Sep 2020 01:33:11 -0700
References: <20200903134704.8949-1-lars.povlsen@microchip.com> <8ca270c9-5561-3176-61cf-7a9fbee10d1f@roeck-us.net>
From:   Lars Povlsen <lars.povlsen@microchip.com>
To:     Guenter Roeck <linux@roeck-us.net>
CC:     Lars Povlsen <lars.povlsen@microchip.com>,
        Jean Delvare <jdelvare@suse.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        <linux-hwmon@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, "Zhang Rui" <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Amit Kucheria" <amitk@kernel.org>
Subject: Re: [PATCH] hwmon: sparx5: Fix initial reading of temperature
In-Reply-To: <8ca270c9-5561-3176-61cf-7a9fbee10d1f@roeck-us.net>
Date:   Fri, 4 Sep 2020 10:33:11 +0200
Message-ID: <87v9guvt4o.fsf@soft-dev15.microsemi.net>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Guenter Roeck writes:

> On 9/3/20 6:47 AM, Lars Povlsen wrote:
>> If the temperature is read before the internal calibration is
>> completed, the driver returns -EIO. Instead it should return -EAGAIN
>> to encourage repeating the operation.
>>
>> Signed-off-by: Lars Povlsen <lars.povlsen@microchip.com>
>> ---
>>  drivers/hwmon/sparx5-temp.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/hwmon/sparx5-temp.c b/drivers/hwmon/sparx5-temp.c
>> index 1a2b1026b026..98be48e3a22a 100644
>> --- a/drivers/hwmon/sparx5-temp.c
>> +++ b/drivers/hwmon/sparx5-temp.c
>> @@ -56,7 +56,7 @@ static int s5_read(struct device *dev, enum hwmon_sensor_types type,
>>       case hwmon_temp_input:
>>               stat = readl_relaxed(hwmon->base + TEMP_STAT);
>>               if (!(stat & TEMP_STAT_VALID))
>> -                     return -EIO;
>> +                     return -EAGAIN;
>
> The problem is that this may result in a hard loop and effectively hang the system,
> or at least the calling process. It may be better to return -ENODATA in this situation.
>

Guenther,

Thank you for your response.

The motivation for the patch was as I tried to use thermal support to
control a fan, and I noticed an initial quip from
thermal_core.c:update_temperature() - it will throw a dev_warn() for
anything else than an "EAGAIN". The EAGAIN also seems to be used by
several other hwmon drivers in similar situations.

The bottom line is that I would like to get rid of the warning
message. Changing the error code to ENODATA does not fix what I am
trying to accomplish.

Do you have any suggestions on how to achieve the objective?

Sincerely,

---Lars

> Guenter
>
>>               value = stat & TEMP_STAT_TEMP;
>>               /*
>>                * From register documentation:
>> --
>> 2.27.0
>>

-- 
Lars Povlsen,
Microchip
