Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2937EC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 13:13:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFBF12078C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 13:13:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pvHKyllE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729251AbgFJNN0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 09:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729120AbgFJNNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 09:13:25 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BB53C03E96B;
        Wed, 10 Jun 2020 06:13:24 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id w20so976606pga.6;
        Wed, 10 Jun 2020 06:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RxjiQHsXFSQLMiCRKLHNqPd8XA5uDKM3V9DGImaLPuk=;
        b=pvHKyllEhoNXkoOuEb3jE87bmiPizOpRsNGPaAgRTaItk32Th40oA1+aJsu4W90vLZ
         +FlEliTd9CxEOHsfoCWx2iHrZRzNvrzomxnRmtROx+w+vaBWSgfLRWZzGiJjL1NRKEGb
         UMiZZae7pNXIJEumGgOrOrd8BTd3n9pZAQoelhHejrNivnH/B9xcpRbJMf/psmJOsAxg
         bsmZrCJXG3rnpkHgl0MDnb5JUs8GCs+8nwvL+zMiDSXXLJV7H15ymUgpxTpg1IdGBC1A
         foKedd3hOcDpB6FpjoVcx3JVHWFZ5JrOnQjboPs17ZOWByQZRLsGWXTanVJmMGxEzYW2
         Pv4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=RxjiQHsXFSQLMiCRKLHNqPd8XA5uDKM3V9DGImaLPuk=;
        b=L6bcagcZq/1+2cZOMqz/XYxfXNQSpv57I7C1pdmyL/ReID0/bA3UHa7E+um5HE0wrQ
         tdyZkZgYZpc3sPjnJfgt3rSPxhNReSgm0ADLqjEbGqa1ff6SRiVP4mRc7cd3474FXlRA
         XhMnMYS8GTKGxIEFupgOIAfDjhMhO1+9jsBNYWeheRlVHFhhuSZIa6B/09PFKiqTWeyS
         uzZiepXBm8OLsjYcWrNO49Tci0ofM6pSwP1yagkrzgU+32fPoWv1RxJ6ZFd3Fs0D/RxT
         vHXeOB8c7IDn2v4Ud4wi/phfVBbLw+53gtKutxb2Ttn097iWGZMyd8NySxgqbLV65YSi
         GGmQ==
X-Gm-Message-State: AOAM531VwjatKyZjHmLNtJHMekRLgbdvtniMolPI6zU59yAk7ydjmhWE
        6RxrMfudyxQvgtMchuzddxDF1I3G
X-Google-Smtp-Source: ABdhPJx1Pk7h1yPNelyMW4GTFW3HEYvCv+scjSdQh7NrMIZFediX3j4btZVsfqmi2mPogV/oFSzM3g==
X-Received: by 2002:a63:1a11:: with SMTP id a17mr2636973pga.227.1591794803795;
        Wed, 10 Jun 2020 06:13:23 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y26sm13015071pff.26.2020.06.10.06.13.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jun 2020 06:13:22 -0700 (PDT)
Subject: Re: [RFC] drivers/hwmon: Corsair Commander Pro driver
To:     Marius Zachmann <mail@mariuszachmann.de>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <20200610040145.GA83576@roeck-us.net> <5812362.fiZtzxMu5m@marius>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <f2bd5bd9-d664-61af-86c9-8d3926c53b55@roeck-us.net>
Date:   Wed, 10 Jun 2020 06:13:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <5812362.fiZtzxMu5m@marius>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/10/20 5:03 AM, Marius Zachmann wrote:
[ ... ]
>>> +Kernel driver corsair-cpro
>>> +==========================
>>> +
>>> +Supported devices:
>>> +
>>> +  * Corsair Commander Pro
>>> +  * Corsair Commander Pro (1000D)
>>> +
>>> +Author: Marius Zachmann
>>> +
>>> +Description
>>> +-----------
>>> +
>>> +This driver implements the sysfs interface for the Corsair Commander Pro.
>>> +The Corsair Commander Pro is a USB device with 6 fan connectors,
>>> +4 temperature sensor connectors and 2 Corsair LED connectors.
>>> +It can read the voltage levels on the SATA power connector.
>>> +
>>> +Usage Notes
>>> +-----------
>>> +
>>> +Since it is a USB device, hotswapping is possible. The device is autodetected.
>>> +
>>> +Sysfs entries
>>> +-------------
>>> +
>>> +in0_input		Voltage on SATA 12v
>>> +in1_input		Voltage on SATA 5v
>>> +in2_input		Voltage on SATA 3.3v
>>> +
>>> +temp[0-3]_input		Connected temperature sensors
>>> +
>> Index starts with 1 for everything except inX.
>>
>>> +fan[0-5]_input		Connected fan rpm.
>>> +fan[0-5]_label		Shows connection status of the fan as detected by the
>>> +			device.
>>> +			"fanX nc"   no connection
>>> +			"fanX 3pin" 3-pin fan detected
>>> +			"fanX 4pin" 4-pin fan detected
>>> +fan[0-5]_enable		the driver only reports fan speeds when 1
>>> +pwm[0-5]		Sets the fan speed. Values from 0-255.
>>> +			When reading, it reports the last value, which
>>> +			was set by the driver.

Change to:
			When reading, it reports the last value if it was set by the driver.
			Otherwise returns 0.

[ ... ]

>>> +	case hwmon_pwm:
>>> +		switch (attr) {
>>> +		case hwmon_pwm_input:
>>> +			*val = ccp->pwm[channel];
>>
>> This returns 0 if pwm wasn't set. Is this indeed not readable from the
>> device ?
> 
> I could not find any possibility, because the official Corsair software does not use it.
> I am not sure, whether it would be better to return an error, if it was not set.
> 
Bummer. Then change the documentation as suggested above, and add
a comment here explaining that it is unknown how to read pwm values
from the device.

Thanks,
Guenter
