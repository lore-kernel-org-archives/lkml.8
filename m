Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82F11C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 17:41:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56BE920706
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 17:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592502114;
	bh=V3/8KDcL+ix6Np43ENGawP52NUg+DxdaW3kXs1ViTT0=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=19eDXIATCMAftI9p5nSq7K5ZLbf1i/jtXx6q4sxo3z1UiB4IgFsmgOTAc99zZJ3AT
	 MFgUsSDyzFXTs42F+UQ1VOmKuy1IL5VUT6WYji5RESSNQ4oaI/YXB6H7Ffqdvj8M1G
	 /heoRxsigfl2Y16Yh4rRdk4le5y/yWml1y7M/HxY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732276AbgFRRlt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 13:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731544AbgFRRlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 13:41:46 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87D95C06174E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 10:41:46 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id n5so5227056otj.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 10:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Lj1OUnCiEL7PTb7sWZrbfYeYh4fsbN5F5NZdzahAeVM=;
        b=iS7A+R/PQVXP2W8n9q0y8fisfHp/ivhVnFUztyN4rIj6i5bAhxr1cZJ+/Tnxlsxv60
         O02SAY/YLf/uzvA20YQjycidu3BQ5drQVc0SAv2+dCZ0td/W9IGVTG1jJdLbWr3AZuQt
         o0uUHNLNnJ3sTZKmqXCuwQhzIZfvUcD3XL9gU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Lj1OUnCiEL7PTb7sWZrbfYeYh4fsbN5F5NZdzahAeVM=;
        b=CAkNlumwqp912jLqNFrzyZsC9LUu3nUcGGIcZHTrmvU+IHNTbP0o+5rI+ACDkggO7t
         BqL+eIrANDMMv+ygchulNZXb+KhneUr9zgOq5mwHGWpJllsd5WjpaxZbCFzazGKSn1o9
         5kzioLTwuk6/rOQ8FDnnfwAD5Drg0b1H+NNZ7VwxgFQzB3CgnoS6fo+aG2GdEz3pz2lf
         14l/MNMFMvfYfGcSuBcOnhskWPaKqdKqW+O7t1IGhvsnaQwQRFKsS1dhIf7qTyCjP6Hv
         iqWbVxYCu/DxXOcTso0e16yoejTbrUlhD5hyslYDoI3TJiwnsEkIpONyJhPeW5zZT8tk
         k93A==
X-Gm-Message-State: AOAM533kbuRHJeT5yBO0d52bHxhIJNf2HhmTNF+a9WianNcWfDDn565U
        dp04obZc8RuTF+UZKh+wC1NrcOJXCt0=
X-Google-Smtp-Source: ABdhPJx6zbH9zK6AjJTN6l6B0AqjYjqOqKk0tGRiB1y9/wvjnCM0jZ5TyMFv576NhAvH9MJgpjDVbQ==
X-Received: by 2002:a9d:6e03:: with SMTP id e3mr4281845otr.71.1592502103915;
        Thu, 18 Jun 2020 10:41:43 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id f7sm832299otl.60.2020.06.18.10.41.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jun 2020 10:41:43 -0700 (PDT)
Subject: Re: [PATCH] usbip: tools: fix module name in man page
To:     Antonio Borneo <borneo.antonio@gmail.com>,
        Valentina Manea <valentina.manea.m@gmail.com>,
        Shuah Khan <shuah@kernel.org>, matt mooney <mfm@muteddisk.com>,
        linux-usb@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org
References: <20200618000818.1048203-1-borneo.antonio@gmail.com>
 <7902323e-fd72-8301-9a11-e6b912b61890@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <038c9454-9598-8b86-e63b-3b04e88a8cd5@linuxfoundation.org>
Date:   Thu, 18 Jun 2020 11:41:42 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <7902323e-fd72-8301-9a11-e6b912b61890@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/18/20 10:56 AM, Shuah Khan wrote:
> On 6/17/20 6:08 PM, Antonio Borneo wrote:
>> Commit 64e62426f40d ("staging: usbip: edit Kconfig and rename
>> CONFIG options") renamed the module usbip as usbip-host, but the
>> example in the man page still reports the old module name.
>>
>> Fix the module name in usbipd.8
>>
>> Signed-off-by: Antonio Borneo <borneo.antonio@gmail.com>
>> Fixes: 64e62426f40d ("staging: usbip: edit Kconfig and rename CONFIG 
>> options")
>> ---
>>   tools/usb/usbip/doc/usbipd.8 | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/usb/usbip/doc/usbipd.8 b/tools/usb/usbip/doc/usbipd.8
>> index ac4635db3f03..fb62a756893b 100644
>> --- a/tools/usb/usbip/doc/usbipd.8
>> +++ b/tools/usb/usbip/doc/usbipd.8
>> @@ -73,7 +73,7 @@ USB/IP client can connect and use exported devices.
>>   .SH EXAMPLES
>> -    server:# modprobe usbip
>> +    server:# modprobe usbip-host
>>       server:# usbipd -D
>>           - Start usbip daemon.
>>
>> base-commit: b3a9e3b9622ae10064826dccb4f7a52bd88c7407
>>
> 
> Looks good. Thanks for fixing this.
> 
> Acked-by: Shuah Khan <skhan@linuxfoundation.org>
> 

+ Adding Greg

Odd. Looks like get_maintainers gave a very old address
for Greg Kroah-Hartman <gregkh@suse.de>.


thanks,
-- Shuah
