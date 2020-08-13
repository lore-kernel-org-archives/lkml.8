Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36580C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 15:40:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00B8620829
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 15:40:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="mhfJ083G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbgHMPkG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 11:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbgHMPkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 11:40:03 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A89F2C061757
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 08:40:03 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id d14so5515466qke.13
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 08:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=K6SkAOrGKcjRY+yhyH0qCJ6Gsotdol6Tl8RV+rGqmCQ=;
        b=mhfJ083GRlJUkPiwVXMO9T1daKwgJ43+ouGmjEel2lLAE5cShfg6XTgVErn12vdSgi
         Pti3KERJIgMLjXfNqmJIJ5JkY36zA6jPoeIx6TDWSCDpRpVfw4r5KZOv+AvpMU/9PiNC
         T3aMkbTbky8P02pmTRD6kPjG4gHDeOscNuo4johMQe84MbUfiNPx2Gfuuqmns1+fGtHN
         O4DJzQ/VK/EmHkD7YOHM5RoLzhIejlHD7dJn2TgD0JkWDTBYDz/m4UEbv21Kb0l5fAM9
         YXAvhZRSXrGz+SKlsvsf+s4JRjnLi7K86irYNkB8Rb70C9L+lIt+qPY9m6voSTbou2TB
         exYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=K6SkAOrGKcjRY+yhyH0qCJ6Gsotdol6Tl8RV+rGqmCQ=;
        b=KHQaJ2GaUQYIawt/Cmnp8kfiho2nmexuyc6xC06zHWCxC09ry2mdwv84kntZNm40CI
         kMXWNSc2edwX4wqj3qV9WsIgK8HMr+2vYIY9R410II6mIqvdv0I1D1cmdXHiFAUi2hhK
         f4LVsCZ+NnlA2GGJfUqpm5+7bMjkBgh8leKckzI2Iq6MnZ8RKRT7DBiDJJPOByIWc8fb
         CRsB83akY4IBaql20hR+QgnrHf9DRrTrVi/w0iO2GZqB6LbBZyACsWbYc5CQZFVSgy5z
         kF+T0lvNJiaMrVPXoX7VlMh28KrUUQSl3RovDmEQnkrnf9Vfq3yY8/Ms2kJM3rVXCwu5
         wsiQ==
X-Gm-Message-State: AOAM531N3TkwIe8UgA2pSWfqFv5ywvRARYUUKsnVlbswT2ENOkb7NvPv
        gfslUpr8eL72bOLv8fZzodpWTA==
X-Google-Smtp-Source: ABdhPJzO7FfjFRSvgKU9zDx0wbHBiRPRxQpL1y0Z0l7g0EYvAarRoJ7G+2qB0t4ccDiGe3UcWAo+xw==
X-Received: by 2002:a05:620a:8c4:: with SMTP id z4mr5505141qkz.146.1597333202826;
        Thu, 13 Aug 2020 08:40:02 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:11d9::10a7? ([2620:10d:c091:480::1:8f88])
        by smtp.gmail.com with ESMTPSA id w2sm5557765qkf.6.2020.08.13.08.40.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Aug 2020 08:40:01 -0700 (PDT)
Subject: Re: [PATCH][v2] proc: use vmalloc for our kernel buffer
To:     Christoph Hellwig <hch@lst.de>
Cc:     viro@ZenIV.linux.org.uk, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, kernel-team@fb.com,
        willy@infradead.org
References: <20200813145305.805730-1-josef@toxicpanda.com>
 <20200813153356.857625-1-josef@toxicpanda.com>
 <20200813153722.GA13844@lst.de>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <974e469e-e73d-6c3e-9167-fad003f1dfb9@toxicpanda.com>
Date:   Thu, 13 Aug 2020 11:40:00 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200813153722.GA13844@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/13/20 11:37 AM, Christoph Hellwig wrote:
> On Thu, Aug 13, 2020 at 11:33:56AM -0400, Josef Bacik wrote:
>> Since
>>
>>    sysctl: pass kernel pointers to ->proc_handler
>>
>> we have been pre-allocating a buffer to copy the data from the proc
>> handlers into, and then copying that to userspace.  The problem is this
>> just blind kmalloc()'s the buffer size passed in from the read, which in
>> the case of our 'cat' binary was 64kib.  Order-4 allocations are not
>> awesome, and since we can potentially allocate up to our maximum order,
>> use vmalloc for these buffers.
>>
>> Fixes: 32927393dc1c ("sysctl: pass kernel pointers to ->proc_handler")
>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>> ---
>> v1->v2:
>> - Make vmemdup_user_nul actually do the right thing...sorry about that.
>>
>>   fs/proc/proc_sysctl.c  |  6 +++---
>>   include/linux/string.h |  1 +
>>   mm/util.c              | 27 +++++++++++++++++++++++++++
>>   3 files changed, 31 insertions(+), 3 deletions(-)
>>
>> diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
>> index 6c1166ccdaea..207ac6e6e028 100644
>> --- a/fs/proc/proc_sysctl.c
>> +++ b/fs/proc/proc_sysctl.c
>> @@ -571,13 +571,13 @@ static ssize_t proc_sys_call_handler(struct file *filp, void __user *ubuf,
>>   		goto out;
>>   
>>   	if (write) {
>> -		kbuf = memdup_user_nul(ubuf, count);
>> +		kbuf = vmemdup_user_nul(ubuf, count);
> 
> Given that this can also do a kmalloc and thus needs to be paired
> with kvfree shouldn't it be kvmemdup_user_nul?
> 

There's an existing vmemdup_user that does kvmalloc, so I followed the existing 
naming convention.  Do you want me to change them both?  Thanks,

Josef
