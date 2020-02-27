Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B28F2C11D3D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 19:01:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86ADF2467B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 19:01:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g7/WDSV9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729994AbgB0TBp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 14:01:45 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:25678 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729170AbgB0TBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 14:01:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582830104;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+JGruyus+zzmL4BgjL6ah3OjgOQ1bfPqt6JzzXGlf80=;
        b=g7/WDSV9sNQMZ+fXXn0kBO9QZmrUQXjgC8RHjo7pA2Kjorr8eU2GLGIQ5yzjoDEARuBPnw
        DQK2h6FmfeD+GMwZ4D8p7BZVX7VOTqGN3hmMAQyA8zHbMwi+LaPSwrLxtpy16oobPXxmcm
        0sVFliniq7BZ2D4g6ieFLDdUaR/9sXM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-305-m01AMzW7PJWRGdquqv5A3A-1; Thu, 27 Feb 2020 14:01:28 -0500
X-MC-Unique: m01AMzW7PJWRGdquqv5A3A-1
Received: by mail-wm1-f72.google.com with SMTP id z7so145956wmi.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 11:01:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+JGruyus+zzmL4BgjL6ah3OjgOQ1bfPqt6JzzXGlf80=;
        b=nbgplJfzDdqLVOQg0Vp9pyPl08T+oU83pIiKn7AhD1fgQHh8uvn6gq8ts2WvZEIyST
         Lu8ZLtVXqGeXvzQlVLs3cOsAfnYAB5X3apkEDJ3Xx8ZvU0PG6qL4/G9lo2LSNTCVDQIE
         QuYvEw5OOEThoKJY5oswJsGB+Y3vPX9ECaeVFFiXYTHM4S/y/zloRnjHkxkjdZUc3jeo
         Sp0lq59SUkRJiZd0nrANq0gzMXgPginrfiRtYKsfkgc/81M1uDTVVD7bi7nOWVqTIvQ0
         Cl/IEI4k4jP5tPUYnVVBW7ho1XpD/+aGksvtF7s73yRk64N58IhBtIVWohD1OkHHeEQi
         PIuA==
X-Gm-Message-State: APjAAAUczl5gQkZ+OErGDXPVfKIV0dheI1Vu9cypS1gvAas0Wh6nV9GU
        t59/boTcC46pE1UmICT3m/29JHjKQsPXbnIiicrzcDdG5GQm0yr6Zi9G8b6Bhd7BqHPHP9/jizT
        03IiQSUtrnwZdOd9bZxEnE5r5
X-Received: by 2002:adf:90e1:: with SMTP id i88mr287829wri.95.1582830087064;
        Thu, 27 Feb 2020 11:01:27 -0800 (PST)
X-Google-Smtp-Source: APXvYqx2rl9n2Z1Mt6ymZ4mzBXqCXk9u948IIcM8fsQq5WrgonWtq/eObeNUK776U7L3634OT1I8Vw==
X-Received: by 2002:adf:90e1:: with SMTP id i88mr287799wri.95.1582830086800;
        Thu, 27 Feb 2020 11:01:26 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-fc7e-fd47-85c1-1ab3.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:fc7e:fd47:85c1:1ab3])
        by smtp.gmail.com with ESMTPSA id l6sm9497307wrb.75.2020.02.27.11.01.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2020 11:01:26 -0800 (PST)
Subject: Re: [PATCH] platform/x86: i2c-multi-instantiate: Replace zero-length
 array with flexible-array member
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200213005525.GA11420@embeddedor.com>
 <f8281f16-b47e-41d6-f67b-1300bc5affff@embeddedor.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <582c09ec-a6aa-72fe-7566-7fb70c156c4d@redhat.com>
Date:   Thu, 27 Feb 2020 20:01:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <f8281f16-b47e-41d6-f67b-1300bc5affff@embeddedor.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


On 2/27/20 8:03 PM, Gustavo A. R. Silva wrote:
> Hi all,
> 
> Friendly ping: who can take this?

FWIW, the patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> On 2/12/20 18:55, Gustavo A. R. Silva wrote:
>> The current codebase makes use of the zero-length array language
>> extension to the C90 standard, but the preferred mechanism to declare
>> variable-length types such as these ones is a flexible array member[1][2],
>> introduced in C99:
>>
>> struct foo {
>>          int stuff;
>>          struct boo array[];
>> };
>>
>> By making use of the mechanism above, we will get a compiler warning
>> in case the flexible array does not occur last in the structure, which
>> will help us prevent some kind of undefined behavior bugs from being
>> inadvertently introduced[3] to the codebase from now on.
>>
>> Also, notice that, dynamic memory allocations won't be affected by
>> this change:
>>
>> "Flexible array members have incomplete type, and so the sizeof operator
>> may not be applied. As a quirk of the original implementation of
>> zero-length arrays, sizeof evaluates to zero."[1]
>>
>> This issue was found with the help of Coccinelle.
>>
>> [1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
>> [2] https://github.com/KSPP/linux/issues/21
>> [3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")
>>
>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>> ---
>>   drivers/platform/x86/i2c-multi-instantiate.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/platform/x86/i2c-multi-instantiate.c b/drivers/platform/x86/i2c-multi-instantiate.c
>> index ffb8d5d1eb5f..6acc8457866e 100644
>> --- a/drivers/platform/x86/i2c-multi-instantiate.c
>> +++ b/drivers/platform/x86/i2c-multi-instantiate.c
>> @@ -28,7 +28,7 @@ struct i2c_inst_data {
>>   
>>   struct i2c_multi_inst_data {
>>   	int num_clients;
>> -	struct i2c_client *clients[0];
>> +	struct i2c_client *clients[];
>>   };
>>   
>>   static int i2c_multi_inst_count(struct acpi_resource *ares, void *data)
>>
> 

