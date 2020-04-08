Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E91EC2BA1B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 19:27:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 404D02072F
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 19:27:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m8rt2Xhy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729960AbgDHT1P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 15:27:15 -0400
Received: from mail-qv1-f67.google.com ([209.85.219.67]:32870 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727717AbgDHT1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 15:27:15 -0400
Received: by mail-qv1-f67.google.com with SMTP id p19so4310108qve.0;
        Wed, 08 Apr 2020 12:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oJV+TvCO+VY9DO+jZTnnzXFI3BZ6Ed8DSfpwoOZDIjE=;
        b=m8rt2XhycVFsFwCJs971W8tfd4kvUrZ1DGawZM4WWJZfOJO8ATmciRBkiNvxCt+Y22
         HJvU6OGiO2GBAhyiU0BzCiVe9mEMTgcwAILdykWB+Ei6v9/dtVAreQ1QfwiSfJAYtbp5
         Hp8jD05EUdJ3kkVb4JnT2lL/ckqY0xg1SF3ESxlBrFSgEDFcCl0ZgQ6WhR/zC6K2zl9U
         4mQd1QA3rVBTN1cbIRxXZUOoDYW/nEIejkXcbjeMjbNXku8OXka6f5f20dyBv22kJbEd
         eeKZTgU5UW9cnaFudA5TbukVoXfj8G9Vypqv0pFVmL3AvzfffHeaZZhztoyIqmz6LHm/
         2zmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oJV+TvCO+VY9DO+jZTnnzXFI3BZ6Ed8DSfpwoOZDIjE=;
        b=UElA1umSQZj2RORnWYFR2XaVXpiRtVZMN/Nqz0mjKV9HZFLwFLszX1SQdt+cMEH92O
         xNNcCr3n/DnHlqem+PWkih3M5OSU/tDQZ/1080/CG0hlS0HC9FJb0b4GVWcRk5R8M0ls
         V5hyG0L8g+wtRYhWjt4o6iUjOwrIbDzItVpKr3RqX9IiwNGHzEBznAj85SI/j1m4O28Y
         qkoXghMnUv56jntecA/+SaAJl0YWI5jYmPXBUA8/IX7WdF9GCyMhWdea5NWAr7kT+yrU
         bBeDpUJ9EgMxoK+7qk6QVqsIWBawjxwbslnZa8mvLv5+ERTw4q0zBp+t9/oYBBC6G2lX
         F+SA==
X-Gm-Message-State: AGi0PuYlEZTTqj6KUlcLYkKCYOMUQNzJxqhLIj0V46nlsRlNWxAIsDW4
        4R9JY2W9G7u4aI8gaPysvcQ=
X-Google-Smtp-Source: APiQypJT1y2+pe84RYUVofBuROMqGUOExowdWQXdnWGTNSf3OUWv6Wa4vkyfGj3ws9+DFIgs9LK74w==
X-Received: by 2002:ad4:5448:: with SMTP id h8mr9106996qvt.23.1586374033710;
        Wed, 08 Apr 2020 12:27:13 -0700 (PDT)
Received: from [192.168.1.46] (c-73-88-245-53.hsd1.tn.comcast.net. [73.88.245.53])
        by smtp.gmail.com with ESMTPSA id a136sm20267507qkb.15.2020.04.08.12.27.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Apr 2020 12:27:13 -0700 (PDT)
Subject: Re: [PATCH] of: remove unneeded variable
From:   Frank Rowand <frowand.list@gmail.com>
To:     Ding Xiang <dingxiang@cmss.chinamobile.com>, robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1585562702-360-1-git-send-email-dingxiang@cmss.chinamobile.com>
 <92c6b7e9-4d55-a5c3-8c7f-5611edeb55c9@gmail.com>
Message-ID: <94145488-c077-4b40-943f-f53f21f660c4@gmail.com>
Date:   Wed, 8 Apr 2020 14:27:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <92c6b7e9-4d55-a5c3-8c7f-5611edeb55c9@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/8/20 11:00 AM, Frank Rowand wrote:
> On 3/30/20 5:05 AM, Ding Xiang wrote:
>> rc is unneeded, just return 0.
> 
> of: of_detach_node() remove unneeded local return variable

never mind, this is not the subject line...  My mistake.

-Frank

> 
>>
>> Signed-off-by: Ding Xiang <dingxiang@cmss.chinamobile.com>
>> ---
>>  drivers/of/dynamic.c | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
>> index 08fd823..fe64430 100644
>> --- a/drivers/of/dynamic.c
>> +++ b/drivers/of/dynamic.c
>> @@ -286,7 +286,6 @@ int of_detach_node(struct device_node *np)
>>  {
>>  	struct of_reconfig_data rd;
>>  	unsigned long flags;
>> -	int rc = 0;
>>  
>>  	memset(&rd, 0, sizeof(rd));
>>  	rd.dn = np;
>> @@ -301,7 +300,7 @@ int of_detach_node(struct device_node *np)
>>  
>>  	of_reconfig_notify(OF_RECONFIG_DETACH_NODE, &rd);
>>  
>> -	return rc;
>> +	return 0;
>>  }
>>  EXPORT_SYMBOL_GPL(of_detach_node);
>>  
>>
> 
> 
> Reviewed-by: Frank Rowand <frank.rowand@sony.com>
> 

