Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1486CC10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 08:39:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDFAA2083E
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 08:39:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbgCIIjw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 04:39:52 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:58146 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726217AbgCIIjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 04:39:52 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id AFFB928E874
Subject: Re: [PATCH] platform/chrome: Kconfig: Remove CONFIG_ prefix from
 MFD_CROS_EC section
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Collabora Kernel ML <kernel@collabora.com>, groeck@chromium.org,
        bleung@chromium.org, dtor@chromium.org, gwendal@chromium.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>
References: <20200305102838.108967-1-enric.balletbo@collabora.com>
 <4131a083-3319-a6e3-a7e2-cfba67016844@infradead.org>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <c753c3b5-a844-5035-a62c-4ed9009a8961@collabora.com>
Date:   Mon, 9 Mar 2020 09:39:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <4131a083-3319-a6e3-a7e2-cfba67016844@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/3/20 16:54, Randy Dunlap wrote:
> On 3/5/20 2:28 AM, Enric Balletbo i Serra wrote:
>> Remove the CONFIG_ prefix from the select statement for MFD_CROS_EC.
>>
>> Fixes: 2fa2b980e3fe1 ("mfd / platform: cros_ec: Rename config to a better name")
>> Reported-by: Randy Dunlap <rdunlap@infradead.org>
>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> 
> Acked-by: Randy Dunlap <rdunlap@infradead.org>
> 

Queued for 5.7.

> Thanks.
> 
>> ---
>>
>>  drivers/platform/chrome/Kconfig | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/platform/chrome/Kconfig b/drivers/platform/chrome/Kconfig
>> index 15fc8b8a2db8..5ae6c49f553d 100644
>> --- a/drivers/platform/chrome/Kconfig
>> +++ b/drivers/platform/chrome/Kconfig
>> @@ -7,7 +7,7 @@ config MFD_CROS_EC
>>  	tristate "Platform support for Chrome hardware (transitional)"
>>  	select CHROME_PLATFORMS
>>  	select CROS_EC
>> -	select CONFIG_MFD_CROS_EC_DEV
>> +	select MFD_CROS_EC_DEV
>>  	depends on X86 || ARM || ARM64 || COMPILE_TEST
>>  	help
>>  	  This is a transitional Kconfig option and will be removed after
>>
> 
> 
