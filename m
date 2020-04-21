Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 150E8C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 07:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E491F2073A
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 07:40:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aFGdBAse"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbgDUHkX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 03:40:23 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:38100 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726628AbgDUHkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 03:40:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587454821;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+us8s3+TLsdGNnZMoTiZF6Ytfj6NBMCN4gguLEIxdtQ=;
        b=aFGdBAseniVBn7J4fh9urCMjNgN5Bs3Y7HuxqEWLyK7fO2Z3y8Wrl5Q4rSKPYzIbGs8qRA
        5xtYefpZuBwA6eItS0duJFgTs5dOBIcRqD/Y/upgFUL8EcQ4O8PFixUzRXx+YqgkCmKhxv
        htfcH/3fUhVs+Tgn2X9K0ENdigZM+hs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-415-cl6xhkBJPzq05fL8WtJL5g-1; Tue, 21 Apr 2020 03:40:10 -0400
X-MC-Unique: cl6xhkBJPzq05fL8WtJL5g-1
Received: by mail-wr1-f70.google.com with SMTP id a3so7116137wro.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 00:40:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+us8s3+TLsdGNnZMoTiZF6Ytfj6NBMCN4gguLEIxdtQ=;
        b=XrmVQ6Y338taFmXsTlOfmyjxMk09cIaaCY+m+omllkqHw+vnMjwbIY34qk3RKIgIB0
         6/+2/AhmMwrao/vK9v1yS6BVIclgrp9+X1YqYXGDGkVWO9OJtmY1p5/r2+Arkin9coxV
         B4gybiysrKJZnotLVrqtCYMEQYXsn6mSq4OB+FMcREnk5qiHn+dn81hKpcB/9MEQ33PS
         M5pbOLnSOfJ8okeJztj1qze8dqxfRjUGUNToIKt7DcSAKUVqLY/ysrWuphZSZ5F8c5ko
         8YbzUEpXH0Nmmtu8rPKUK1LaZrGu2Z2eON6ELXh8d1RbXg+lsF5ZOCyGttOoVEn50dVE
         dDhg==
X-Gm-Message-State: AGi0PuZn7Jq30gfMScxXlUlmeEdiG9XcXiWhKrtWAquo+ldnO+LRYidd
        tfPhl87AtrkqU3uCPI8Xx8sLKd+g1AKJey9JvOPIIAAMSU99Be8nP/k4q2eHPR5W9ai9O976Urv
        0DTy5rDzEk9TQdscPGxtsCSl6
X-Received: by 2002:a5d:4b90:: with SMTP id b16mr24211693wrt.16.1587454809426;
        Tue, 21 Apr 2020 00:40:09 -0700 (PDT)
X-Google-Smtp-Source: APiQypIscKJFG2sAbiYiJ0K2c8RaMl7hB9OOkoo2bRUwbF9yAD4GP4X7AKWvXg51YPHtGx3nroITVg==
X-Received: by 2002:a5d:4b90:: with SMTP id b16mr24211675wrt.16.1587454809210;
        Tue, 21 Apr 2020 00:40:09 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id t2sm2442383wmt.15.2020.04.21.00.40.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2020 00:40:08 -0700 (PDT)
Subject: Re: [PATCH] platform/x86: surface3_power: i2c_acpi_new_device()
 returns a PTR_ERR
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20200420220421.171298-1-hdegoede@redhat.com>
 <CAHp75VfC7-saRXnGDpee1dxAqDSDcveHMoC872WN9-SL4sDH4Q@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <b01d598f-f3ae-b092-3be8-07e178370289@redhat.com>
Date:   Tue, 21 Apr 2020 09:40:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VfC7-saRXnGDpee1dxAqDSDcveHMoC872WN9-SL4sDH4Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 4/21/20 12:33 AM, Andy Shevchenko wrote:
> On Tue, Apr 21, 2020 at 1:04 AM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> i2c_acpi_new_device() never returns NULL, it either returns an i2c_client
>> or a PTR_ERR. Adjust the mshw0011_probe() error handling to take this
>> into account.
>>
>> Note the goto out_err will cause i2c_unregister_device() to get called
>> even though the i2c_acpi_new_device() fails, this is ok as it accepts
>> a NULL pointer argument (and treats it as a no-op).
>>
> 
> Thanks, I guess it repeats [1].
> 
> [1]: http://git.infradead.org/linux-platform-drivers-x86.git/commitdiff/4dbccb873f2b35ad1b26419ff88c80509e2d4cbb

I guess it does and Dan's solution for the error handling is
claner then mine, a direct return indeed is the proper thing
to do here.

Regards,

Hans



> 
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>   drivers/platform/x86/surface3_power.c | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/platform/x86/surface3_power.c b/drivers/platform/x86/surface3_power.c
>> index 946ac2dc08ae..32e6e86e27dd 100644
>> --- a/drivers/platform/x86/surface3_power.c
>> +++ b/drivers/platform/x86/surface3_power.c
>> @@ -522,8 +522,10 @@ static int mshw0011_probe(struct i2c_client *client)
>>          strlcpy(board_info.type, "MSHW0011-bat0", I2C_NAME_SIZE);
>>
>>          bat0 = i2c_acpi_new_device(dev, 1, &board_info);
>> -       if (!bat0)
>> -               return -ENOMEM;
>> +       if (IS_ERR(bat0)) {
>> +               error = PTR_ERR(bat0);
>> +               goto out_err;
>> +       }
>>
>>          data->bat0 = bat0;
>>          i2c_set_clientdata(bat0, data);
>> --
>> 2.26.0
>>
> 
> 

