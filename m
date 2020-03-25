Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2B7BC18E5B
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 09:15:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 979C62078A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 09:15:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VDt0wkbp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbgCYJPp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 05:15:45 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33741 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726103AbgCYJPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 05:15:45 -0400
Received: by mail-wm1-f67.google.com with SMTP id w25so1617867wmi.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 02:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0fP8SfQZSAtyERg1yN0AyfU/uWwG6IasGOC+cQcTr0k=;
        b=VDt0wkbpFc00q2fb/ca75QtoCPIzB+JkGS5SpH5ocOnGlj4qesJOqx/FDTeiJ9UAyx
         covDdC3RXIBl9KC6rlt967kBTLvOuRTjS30n3BS/Nx+PRch+4RRsMqvAZCerahTGqw3/
         BIeQHDrltoP1c6/y7ruAkz4oH0DFL4mHtUicoUGdzg5cDlZpVg5oqj7vLshVmYuV1uHE
         NVXYx+fHPeUJWnK4GKr9u5/aHNAOJfvKW3EXZ5qvkgD6ARfTMTpcS4ZSgUDGkSVXW6hJ
         BnghYdt7QM5TFYT+aWvinnDmPalci2nXVNMu/mxNP3AXRhw5CF9XFUtvzbYGLK3VznHP
         5M+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0fP8SfQZSAtyERg1yN0AyfU/uWwG6IasGOC+cQcTr0k=;
        b=ZEM+PKCu+IsnTEFqxuhlNq2+UhDkWGScgvPoxsLIWIvFg9e3+vNHA1bGJ7EX0YqZDN
         vTFVKa24FD2Eu//JS8F9QKEqnQoItLUHPcFoivALfQfqsJuN5+KMChcYRh4Ont1pWdYD
         koWlviHJW/F9YAGUazTC3qT2BjN62oynTvqSio8cTIVa9d61sw7pWvjqJXPUX0tVKcup
         PaGv1xTh18a26oS/igi2xxEXXMJb8mFwe4JMXZCLQpwQduFm+kq1g4dn8eowf8RXnZgt
         IZY0dETQd0nC3KkOKv/0Hd1ZVuzPmzbiCOZMTbyMQaORuStYc8ByIM45FlhzcvjXCKq/
         1QgA==
X-Gm-Message-State: ANhLgQ1ginbUR7Kk1YYbUjqOaWRiW2WmJTX7OoxsRXdUoWNdvLgCgMen
        wDMkeNQACmIMtMfF+KM11oH4rcDsLZk=
X-Google-Smtp-Source: ADFU+vsU5rJmD8bRLepEPziMM4bPoMmkEutYGK5Ijzd3ms5qifVgYl95iA2yXDT1S4rZV4jbg/Ef2w==
X-Received: by 2002:a1c:3d83:: with SMTP id k125mr1295044wma.177.1585127741285;
        Wed, 25 Mar 2020 02:15:41 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id k204sm8448759wma.17.2020.03.25.02.15.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Mar 2020 02:15:40 -0700 (PDT)
Subject: Re: [PATCH 3/3] nvmem: core: use is_bin_visible for permissions
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        nicholas.johnson-opensource@outlook.com.au
References: <20200324171600.15606-1-srinivas.kandagatla@linaro.org>
 <20200324171600.15606-4-srinivas.kandagatla@linaro.org>
 <20200324174642.GA2524667@kroah.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <efa9f7c5-f96c-5dcd-26ea-397997b5b5c0@linaro.org>
Date:   Wed, 25 Mar 2020 09:15:39 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200324174642.GA2524667@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24/03/2020 17:46, Greg KH wrote:
> On Tue, Mar 24, 2020 at 05:16:00PM +0000, Srinivas Kandagatla wrote:
>> By using is_bin_visible callback to set permissions will remove a large list
>> of attribute groups. These group permissions can be dynamically derived in
>> the callback.
>>
>> Suggested-by: Greg KH <gregkh@linuxfoundation.org>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>   drivers/nvmem/nvmem-sysfs.c | 74 +++++++++----------------------------
>>   1 file changed, 18 insertions(+), 56 deletions(-)
>>
>> diff --git a/drivers/nvmem/nvmem-sysfs.c b/drivers/nvmem/nvmem-sysfs.c
>> index 8759c4470012..1ff1801048f6 100644
>> --- a/drivers/nvmem/nvmem-sysfs.c
>> +++ b/drivers/nvmem/nvmem-sysfs.c
>> @@ -103,6 +103,17 @@ static ssize_t bin_attr_nvmem_write(struct file *filp, struct kobject *kobj,
>>   
>>   	return count;
>>   }
>> +static umode_t nvmem_bin_attr_is_visible(struct kobject *kobj,
>> +					 struct bin_attribute *attr, int i)
>> +{
>> +	struct device *dev = container_of(kobj, struct device, kobj);
>> +	struct nvmem_device *nvmem = to_nvmem_device(dev);
>> +
>> +	if (nvmem->root_only)
>> +		return nvmem->read_only ? 0400 : 0600;
>> +
>> +	return nvmem->read_only ? 0444 : 0644;
>> +}
> 
> I don't know why this is so hard for me to read, but how about this
> instead:
> 
> static umode_t nvmem_bin_attr_is_visible(struct kobject *kobj,
> 					 struct bin_attribute *attr, int i)
> {
> 	struct device *dev = container_of(kobj, struct device, kobj);
> 	struct nvmem_device *nvmem = to_nvmem_device(dev);
> 	umode_t mode = 0400;
> 
> 	if (!nvmem->root_only)
> 		mode |= 0044;
> 
> 	if (!nvmem->read_only)
> 		mode |= 0200;
> 
> 	return mode;
> }
> 
> Did I get the logic corect?

That looks perfect and matches what is in upstream!
Thanks for suggesting this cleanup!

I will send v2 with this change!

--srini
> 
> thanks,
> 
> greg k-h
> 
