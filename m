Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B53A8C3B187
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 22:52:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BCB721569
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 22:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581547964;
	bh=CRev1luXwdujbwtyZQWOhQiyui/cJ+jDftyaZlu3U4Y=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=kcy3EP/sWVqEaIKyESz7QoFa6laqUKU48I7NhoYiYy7r4EYJbkT5PTXR3DUh4CBWB
	 Vi1/YwiJpZ8ltKY6oXfYcblPs9nwBjZpvmbQJgAOd0tjH5syZGdpcqtbXVS8FaHftX
	 Y7aewiJ3TQ3q0Mn1evrGvHsrohwrsutYggFtWpSM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729185AbgBLWwo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 17:52:44 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:41831 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728185AbgBLWwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 17:52:43 -0500
Received: by mail-il1-f196.google.com with SMTP id f10so3241361ils.8
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 14:52:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RbZn7NBPUx8xwAK1CHGdzIBD9eDqney+TnaE+OAg8mI=;
        b=dN9EQ3nB3q7uyXHZZCeUKYuZZMbCoMMndb7Vca2/9RWVsJKA5Kii0vsUb4OaZHsOxS
         DCuxSlKrVXKAUx/Uf5ZTSW3YmMojhrssIQ3koKoLCqpj5OoDZ8fOAtJLU71OgTx7UNuD
         XyUg8FkgjmF2g4ujNm+fXpTZE0KW57WQLXbzY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RbZn7NBPUx8xwAK1CHGdzIBD9eDqney+TnaE+OAg8mI=;
        b=UkrKzFUdoQChZZQhs/Rd9p46qOj90pWxsnf2AQZqqv8R0GnoTspq4i6Yc2N1Ey224M
         nt94Ns25e+W3gZvhV8pdFQUgMSnCGeF7fCXSllymjOHTNav1nkUgb+BIMABeRxE9ap3D
         Cnex/CxdHPI4lSk9r0ZgodKgLFhv5AMqXe/t9p+KFIsGrScbJyo+Sr+pycBaNVgdeWAO
         UWIBCkMMv0+pCg7+DxKxlSdpazmHqv8YWC/ysVZQzBG0n6iVICy17P/5rUJT0cLG8JNr
         vIvhV599HU/lHqhTmqUVYLpspH5yLmu+l22tyKYx+Re7KPcht6Q2vDjyHupVMVHZCad4
         L/MQ==
X-Gm-Message-State: APjAAAVK+Unce8JHXjfaFe+vKNTBNAtmcDmvb4IjaGPCGoulVDsDQLT7
        yd4C8G0I8a4BqPwr5Tbo80HPbrno5Js=
X-Google-Smtp-Source: APXvYqyQJgB8KL/SxBQ64+lBNmvNex3b/CGx4perVHk/sNcI0Gt37Y4ZfsGV5v2iasQKz7uy2UcImw==
X-Received: by 2002:a92:5c8f:: with SMTP id d15mr3218328ilg.102.1581547961756;
        Wed, 12 Feb 2020 14:52:41 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id 203sm150734ilb.42.2020.02.12.14.52.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2020 14:52:41 -0800 (PST)
Subject: Re: [PATCH v3 3/3] IMA: Add module name and base name prefix to log.
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        joe@perches.com, linux-integrity@vger.kernel.org
Cc:     sashal@kernel.org, nramas@linux.microsoft.com,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20200211231414.6640-1-tusharsu@linux.microsoft.com>
 <20200211231414.6640-4-tusharsu@linux.microsoft.com>
 <1581517770.8515.35.camel@linux.ibm.com>
 <1581521161.3494.7.camel@HansenPartnership.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <d428f807-7e67-a173-183d-f2ab15bdef9e@linuxfoundation.org>
Date:   Wed, 12 Feb 2020 15:52:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1581521161.3494.7.camel@HansenPartnership.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/12/20 8:26 AM, James Bottomley wrote:
> On Wed, 2020-02-12 at 09:29 -0500, Mimi Zohar wrote:
>> On Tue, 2020-02-11 at 15:14 -0800, Tushar Sugandhi wrote:
>>> The #define for formatting log messages, pr_fmt, is duplicated in
>>> the
>>> files under security/integrity.
>>>
>>> This change moves the definition to security/integrity/integrity.h
>>> and
>>> removes the duplicate definitions in the other files under
>>> security/integrity. Also, it adds KBUILD_MODNAME and
>>> KBUILD_BASENAME prefix
>>> to the log messages.
>>>
>>> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
>>> Reviewed-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
>>> Suggested-by: Joe Perches <joe@perches.com>
>>> Suggested-by: Shuah Khan <skhan@linuxfoundation.org>
>>
>> <snip>
>>
>>> diff --git a/security/integrity/integrity.h
>>> b/security/integrity/integrity.h
>>> index 73fc286834d7..b1bb4d2263be 100644
>>> --- a/security/integrity/integrity.h
>>> +++ b/security/integrity/integrity.h
>>> @@ -6,6 +6,12 @@
>>>    * Mimi Zohar <zohar@us.ibm.com>
>>>    */
>>>   
>>> +#ifdef pr_fmt
>>> +#undef pr_fmt
>>> +#endif
>>> +
>>> +#define pr_fmt(fmt) KBUILD_MODNAME ": " KBUILD_BASENAME ": " fmt
>>> +
>>>   #include <linux/types.h>
>>>   #include <linux/integrity.h>
>>>   #include <crypto/sha.h>
>>
>> Joe, Shuah, including the pr_fmt() in integrity/integrity.h not only
>> affects the integrity directory but everything below it.  Adding
>> KBUILD_BASENAME to pr_fmt() modifies all of the existing IMA and EVM
>> kernel messages.  Is that ok or should there be a separate pr_fmt()
>> for the subdirectories?
> 

> Log messages are often consumed by log monitors, which mostly use
> pattern matching to find messages they're interested in, so you have to
> take some care when changing the messages the kernel spits out and you
> have to make sure any change gets well notified so the distributions
> can warn about it.
> 
> For this one, can we see a "before" and "after" message so we know
> what's happening?
> 

Mimi and James,

My suggestion was based on thinking that simplifying this by removing
duplicate defines. Some messages are missing modules names, adding
module name to them does change the messages.

If using one pr_fmt for all modules changes the world and makes it
difficult for log monitors, I would say it isn't a good change.

I will leave this totally up to Mimi to decide. Feel free to throw
out my suggestion if it leads more trouble than help. :)

thanks,
-- Shuah

