Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A3E6C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 18:15:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8D9920720
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 18:15:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727844AbgGJSPo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 14:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726925AbgGJSPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 14:15:43 -0400
Received: from smtp.al2klimov.de (smtp.al2klimov.de [IPv6:2a01:4f8:c0c:1465::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFA4AC08C5DC;
        Fri, 10 Jul 2020 11:15:43 -0700 (PDT)
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by smtp.al2klimov.de (Postfix) with ESMTPA id E2427BC0CB;
        Fri, 10 Jul 2020 18:15:38 +0000 (UTC)
Subject: Re: [PATCH] Replace HTTP links with HTTPS ones: BACKLIGHT
 CLASS/SUBSYSTEM
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     lee.jones@linaro.org, daniel.thompson@linaro.org,
        jingoohan1@gmail.com, b.zolnierkie@samsung.com,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200708163847.15250-1-grandmaster@al2klimov.de>
 <20200710173533.GD17565@ravnborg.org>
From:   "Alexander A. Klimov" <grandmaster@al2klimov.de>
Message-ID: <71396370-b68d-1409-fa08-0020c6417f34@al2klimov.de>
Date:   Fri, 10 Jul 2020 20:15:38 +0200
MIME-Version: 1.0
In-Reply-To: <20200710173533.GD17565@ravnborg.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp.al2klimov.de;
        auth=pass smtp.auth=aklimov@al2klimov.de smtp.mailfrom=grandmaster@al2klimov.de
X-Spamd-Bar: /
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Am 10.07.20 um 19:35 schrieb Sam Ravnborg:
> Hi Alexander.
Hi,

> 
> On Wed, Jul 08, 2020 at 06:38:47PM +0200, Alexander A. Klimov wrote:
>> Rationale:
>> Reduces attack surface on kernel devs opening the links for MITM
>> as HTTPS traffic is much harder to manipulate.
>>
>> Deterministic algorithm:
>> For each file:
>>    If not .svg:
>>      For each line:
>>        If doesn't contain `\bxmlns\b`:
>>          For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
>> 	  If neither `\bgnu\.org/license`, nor `\bmozilla\.org/MPL\b`:
>>              If both the HTTP and HTTPS versions
>>              return 200 OK and serve the same content:
>>                Replace HTTP with HTTPS.
>>
>> Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
>> ---
>>   Continuing my work started at 93431e0607e5.
>>   See also: git log --oneline '--author=Alexander A. Klimov <grandmaster@al2klimov.de>' v5.7..master
>>   (Actually letting a shell for loop submit all this stuff for me.)
>>
>>   If there are any URLs to be removed completely or at least not HTTPSified:
>>   Just clearly say so and I'll *undo my change*.
>>   See also: https://lkml.org/lkml/2020/6/27/64
>>
>>   If there are any valid, but yet not changed URLs:
>>   See: https://lkml.org/lkml/2020/6/26/837
>>
>>   If you apply the patch, please let me know.
>>
>>
>>   drivers/video/backlight/led_bl.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/video/backlight/led_bl.c b/drivers/video/backlight/led_bl.c
>> index 3f66549997c8..2c48957e9b60 100644
>> --- a/drivers/video/backlight/led_bl.c
>> +++ b/drivers/video/backlight/led_bl.c
>> @@ -1,6 +1,6 @@
>>   // SPDX-License-Identifier: GPL-2.0
>>   /*
>> - * Copyright (C) 2015-2019 Texas Instruments Incorporated -  http://www.ti.com/
>> + * Copyright (C) 2015-2019 Texas Instruments Incorporated -  https://www.ti.com/
>>    * Author: Tomi Valkeinen <tomi.valkeinen@ti.com>
>>    *
>>    * Based on pwm_bl.c
> 
> $grep http drivers/video/backlight/*
> drivers/video/backlight/cr_bllcd.c: * Intel funded Tungsten Graphics (http://www.tungstengraphics.com) to
> drivers/video/backlight/ili9320.c: *	http://armlinux.simtec.co.uk/
> drivers/video/backlight/ili9320.h: * http://armlinux.simtec.co.uk/
> drivers/video/backlight/led_bl.c: * Copyright (C) 2015-2019 Texas Instruments Incorporated -  http://www.ti.com/
> drivers/video/backlight/vgg2432a4.c: *	http://armlinux.simtec.co.uk/
> 
> Why are they not covered?
Didn't check them, but likely because they're new.

Don't worry, I'll do a second scan once the results of this one get into 
master.

> 
> 	Sam
> 
> 
>> -- 
>> 2.27.0
>>
>> _______________________________________________
>> dri-devel mailing list
>> dri-devel@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
