Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CDD5C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 13:29:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDCA820575
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 13:29:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="X0delyun"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732140AbgDNN3q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 09:29:46 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:59478 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731984AbgDNN1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 09:27:46 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 03EDRh3K105395;
        Tue, 14 Apr 2020 08:27:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1586870863;
        bh=SSfo+2V2r4HztN+793q2itLtIjCsMsYwUH2PGgw2Yz8=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=X0delyuncZhCV0OGsmD9lstXqLhF0FAqH2lQdTlMguyuuRliTtNz9Y54y3JDpcxYc
         xtStYyFpW2pUQgsUBzuox4NrDXLMJR8ajILcGl2MeIB84YWTH2hrKGgTjhsdTsZPoG
         1sm+m2f0SIetbuLzMDB2rSfFtmYjwXI+y9QdgJoc=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 03EDRhpp106857
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 14 Apr 2020 08:27:43 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 14
 Apr 2020 08:27:42 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 14 Apr 2020 08:27:42 -0500
Received: from [10.250.52.63] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 03EDRgXw112322;
        Tue, 14 Apr 2020 08:27:42 -0500
Subject: Re: [PATCH v19 04/18] leds: multicolor: Introduce a multicolor class
 definition
To:     =?UTF-8?B?VmVzYSBKw6TDpHNrZWzDpGluZW4=?= <dachaac@gmail.com>,
        <jacek.anaszewski@gmail.com>, <pavel@ucw.cz>
CC:     <linux-leds@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20200402204311.14998-1-dmurphy@ti.com>
 <20200402204311.14998-5-dmurphy@ti.com>
 <78a577ba-667e-804a-b59f-6cc442adb4eb@gmail.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <a3f75fad-b235-e627-ab85-740e4533c33b@ti.com>
Date:   Tue, 14 Apr 2020 08:21:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <78a577ba-667e-804a-b59f-6cc442adb4eb@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vesa

On 4/9/20 12:25 AM, Vesa Jääskeläinen wrote:
> Hi,
>
> On 2.4.2020 23.42, Dan Murphy wrote:
>> Introduce a multicolor class that groups colored LEDs
>> within a LED node.
>>
>> The multi color class groups monochrome LEDs and allows controlling two
>> aspects of the final combined color: hue and lightness. The former is
>> controlled via <color>_intensity files and the latter is controlled
>> via brightness file.
>>
>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
>> ---
>>   .../ABI/testing/sysfs-class-led-multicolor    |  42 ++++
>>   Documentation/leds/index.rst                  |   1 +
>>   Documentation/leds/leds-class-multicolor.rst  |  95 ++++++++
>>   drivers/leds/Kconfig                          |  10 +
>>   drivers/leds/Makefile                         |   1 +
>>   drivers/leds/led-class-multicolor.c           | 206 ++++++++++++++++++
>>   include/linux/led-class-multicolor.h          | 121 ++++++++++
>>   7 files changed, 476 insertions(+)
>>   create mode 100644 
>> Documentation/ABI/testing/sysfs-class-led-multicolor
>>   create mode 100644 Documentation/leds/leds-class-multicolor.rst
>>   create mode 100644 drivers/leds/led-class-multicolor.c
>>   create mode 100644 include/linux/led-class-multicolor.h
>>
>> diff --git a/Documentation/ABI/testing/sysfs-class-led-multicolor 
>> b/Documentation/ABI/testing/sysfs-class-led-multicolor
>> new file mode 100644
>> index 000000000000..1f50324d24fd
>> --- /dev/null
>> +++ b/Documentation/ABI/testing/sysfs-class-led-multicolor
>> @@ -0,0 +1,42 @@
>> +What:        /sys/class/leds/<led>/brightness
>> +Date:        March 2020
>> +KernelVersion:    5.8
>> +Contact:    Dan Murphy <dmurphy@ti.com>
>> +Description:    read/write
>> +        Writing to this file will update all LEDs within the group to a
>> +        calculated percentage of what each color LED intensity is set
>> +        to. The percentage is calculated for each grouped LED via the
>> +        equation below:
>> +
>> +        led_brightness = brightness * color_intensity/max_brightness
>> +
>> +        For additional details please refer to
>> +        Documentation/leds/leds-class-multicolor.rst.
>> +
>> +        The value of the color is from 0 to
>> +        /sys/class/leds/<led>/max_brightness.
>> +
>> +What:        /sys/class/leds/<led>/color_index
>> +Date:        March 2020
>> +KernelVersion:    5.8
>> +Contact:    Dan Murphy <dmurphy@ti.com>
>> +Description:    read
>> +        The color_index array, when read, will output the LED colors
>> +        by name as they are indexed in the color_intensity array.
>> +
>> +What:        /sys/class/leds/<led>/num_colors
>> +Date:        March 2020
>> +KernelVersion:    5.8
>> +Contact:    Dan Murphy <dmurphy@ti.com>
>> +Description:    read
>> +        The num_colors indicates the number of LEDs defined in the
>> +        color_intensity and color_index arrays.
>> +
>> +What:        /sys/class/leds/<led>/color_intensity
>> +Date:        March 2020
>> +KernelVersion:    5.8
>> +Contact:    Dan Murphy <dmurphy@ti.com>
>> +Description:    read/write
>> +        Intensity level for the LED color within the array.
>> +        The intensities for each color must be entered based on the
>> +        color_index array.
>
> For what it is worth --
>
> I see that this interface covers our use cases and I assume that GPIO 
> LED and PWM LED drivers can be implemented for this after this set is 
> integrated.
>
Thank you for looking

Dan


> Thanks,
> Vesa Jääskeläinen
