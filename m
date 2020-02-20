Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DE28C11D0B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 14:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0525820656
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 14:40:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HHUJzc46"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728173AbgBTOkT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 09:40:19 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:32873 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727915AbgBTOkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 09:40:19 -0500
Received: by mail-pg1-f196.google.com with SMTP id 6so2056042pgk.0;
        Thu, 20 Feb 2020 06:40:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2NmViLIJERdQfyun4Ab99x7zwWufktbDx8lsNKAcbjM=;
        b=HHUJzc461SXI2L7U7rRVMzdb+1LWAcbkkrDxqtax01/BLJngq6+6V3KtJHdr065gOB
         8OxU1v3F+9Yt06h0RmFXeYHvUGgVk6TQDmgc9qAIFEoMs8k1eU2RncFa+fQy3jiiF5ez
         vmeZ6y6TTP4qkVS2LfMeken4Wlu5YWnUsGoQQdSXM0jTKvEK1io/EYb8zGOd9rXbibHI
         C4jzG4ao1ef+Dh451gppcQ6mhlRrEoTrYlr/9fcUZN+1daPWm9uohtYEvJgrOlz1qyBQ
         RSsySX3so5o5vxmCeJrIedY8e1ayw2LgY20BGaPyYxW8YZu0S59wz7eGREXLX/SQGmvn
         /K4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2NmViLIJERdQfyun4Ab99x7zwWufktbDx8lsNKAcbjM=;
        b=jU3a+DAubx3hfpB1Cu0SQcvu/AeicMcsI4sAI0ObaVqgacxweAU2ZdobIRrHbK4hP+
         LAE7DW2iYN3r8mO6yb+CXPmpYZ2SnVuuKYfqVYp3TgmJsf56R/6J9jOWdoHJtRx2hGGZ
         3aAPKMp/WEV+kRBSUDhs/+gaVKqpL0sHq00wZxrSiiH1hi1YBecNdFoaEUvtagJKA4xl
         aObhJc4An0AtdVZmhr60huRHBMQUITeOtmmMf+7ncagY+tmDXt14gfEjuCKlXPeO0IrL
         H1lO7YyHCatIDfh4a+9kHa6tYm2LrIygb8eLAqEShWOT3BIdh9MSYW5mOMEIfIKlNLmb
         hsQA==
X-Gm-Message-State: APjAAAVAvtG6qn24KM9QNR84poTW3H0GyB9j2bNKFklxX6FuUzM5QBTI
        gjYJy08VI5W6dLYW9RXmIkM=
X-Google-Smtp-Source: APXvYqy11uYC3oE0cdOdqrJAguSj4Q2u44MLsZmYBj9oa/Pv9LY4iNkDioAHYZeMZkPy4k8rbF3KXw==
X-Received: by 2002:a63:4281:: with SMTP id p123mr32962830pga.371.1582209617775;
        Thu, 20 Feb 2020 06:40:17 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t11sm3816738pjo.21.2020.02.20.06.40.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2020 06:40:16 -0800 (PST)
Subject: Re: w83627ehf crash in 5.6.0-rc2-00055-gca7e1fd1026c
To:     "Dr. David Alan Gilbert" <linux@treblig.org>,
        Meelis Roos <mroos@linux.ee>
Cc:     linux-hwmon@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Chen Zhou <chenzhou10@huawei.com>
References: <434212bb-4eb9-7366-3255-79826d0e65bc@linux.ee>
 <20200220121451.GA18071@gallifrey>
 <6050ed14-f7a6-cb99-7268-072129226d48@linux.ee>
 <20200220135709.GB18071@gallifrey>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <ad023dc1-1878-dcd9-a183-06003ed698af@roeck-us.net>
Date:   Thu, 20 Feb 2020 06:40:15 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200220135709.GB18071@gallifrey>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/20/20 5:57 AM, Dr. David Alan Gilbert wrote:
> * Meelis Roos (mroos@linux.ee) wrote:
>>> It looks like not all chips have temp_label, so I think we need to change w83627ehf_is_visible
>>> which has:
>>>
>>>                   if (attr == hwmon_temp_input || attr == hwmon_temp_label)
>>>                           return 0444;
>>>
>>> to
>>>                   if (attr == hwmon_temp_input)
>>>                           return 0444;
>>>                   if (attr == hwmon_temp_label) {
>>>                           if (data->temp_label)
>>> 				return 0444;
>>> 			else
>>> 				return 0;

Nitpick: else after return isn't necessary. Too bad I didn't notice that before;
static analyzers will have a field day :-)

>>>                   }
>>>
>>> Does that work for you?
>> Yes, it works - sensors are displayed as they should be, with nothing in dmesg.
>>
>> Thank you for so quick response!
> 
> Great, I need to turn that into a proper patch; (I might need to wait till
> Saturday for that, although if someone needs it before then please shout).
> 

We'll want this fixed in the next stable release candidate, so I wrote one up
and submitted it.

Thanks,
Guenter
