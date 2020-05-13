Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32EC1C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 17:56:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE44F206A5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 17:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589392576;
	bh=vxWmhfB5vjfKB/0ZB+Z7fShTQfkkErFyZOnc5LMDdUE=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=ufOmZ6/6wulMqfQOAWOWdiMcsM2WFQlyhZpQ7cu1mY0qQVNDjQctMw6MI1RnLANEF
	 Wg2rFcPgblca5OxIIWy+G9oP2UEAv/DQJTNrRbyGaXiIF2iLz45DdEFHNbTjIzzd3j
	 H22KhgJ+647AzpK3vP6SbpaUUu+vSLtdPmQWgaDk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733202AbgEMR4P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 13:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732986AbgEMR4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 13:56:14 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4555C061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 10:56:14 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id n11so565225ilj.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 10:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=F16QtRSzf878DRAHE3ucRhzTHi9PQVc2FyzR7+y/rko=;
        b=gC6Ys2Z0X4VwL2tBzGS4x3OiTHrcdcOLARYEx4CguoyfFZEmU4tW2Ja48mydzgWx9B
         AS/BjGGUEfFjY2ALTRclJ/53GMtL/GU0s43O9XH4Hj+ik2iurcHuGpCjz+H302iTMblx
         EaeAJujlOc/UM+k5YOzD/iG25gUfMG5IiyWx4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=F16QtRSzf878DRAHE3ucRhzTHi9PQVc2FyzR7+y/rko=;
        b=dClh+vF4D3cSkj0bVeN84+Sc43zYzxw6NIMmHBljwh/CnkUoZcb/KYT+JRYnAqT+QV
         CaNrEVEkBssS00Lw2vqZSJkCBqNpTJEX4z41dbFdkMiBLw04/1NjCTz3u2bQnzdDL8s+
         1fESu/lGiFtW5NNK2FR7sJYfHO6AVbejUYsYky1eF56vFgkznZxfMG2nkZ8WkPrJfpAN
         akLzmUheQuRJKA0uLuS50Ngl3j1ldj2wp1hpBUGi6tvrogeMr7DXTd6FNXZocxyk1qvi
         v4w6oipX+s/+QHt9Q/tZ05BLMyOmFkcoNuPWXk5I3/MW2/QM9D8yPextWDArXdgiV1nR
         ZuHg==
X-Gm-Message-State: AOAM533Qxs0Mb504ENsROUd3IoYrFBjRYBWCqJUhHekbk8eS+JaI4dnE
        dxW5W6o/uszZQ9tm4i19D8HeXA==
X-Google-Smtp-Source: ABdhPJwUOgAGpAYb/jTO3l+3l7qXYKvLIv6vcxoLLkh3FRieCG+8TXXKp1Lml1CQgay7kjWqptMGsQ==
X-Received: by 2002:a92:8144:: with SMTP id e65mr313116ild.242.1589392573981;
        Wed, 13 May 2020 10:56:13 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id e13sm88045ils.27.2020.05.13.10.56.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2020 10:56:13 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] fs: avoid fdput() after failed fdget() in
 kernel_read_file_from_fd()
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     axboe@kernel.dk, zohar@linux.vnet.ibm.com, mcgrof@kernel.org,
        keescook@chromium.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <cover.1589311577.git.skhan@linuxfoundation.org>
 <1159d74f88d100521c568037327ebc8ec7ffc6ef.1589311577.git.skhan@linuxfoundation.org>
 <20200513054950.GT23230@ZenIV.linux.org.uk>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <19709a34-68be-abb2-a8e1-f42e37a103ee@linuxfoundation.org>
Date:   Wed, 13 May 2020 11:56:11 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200513054950.GT23230@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/12/20 11:49 PM, Al Viro wrote:
> On Tue, May 12, 2020 at 01:43:05PM -0600, Shuah Khan wrote:
>> Fix kernel_read_file_from_fd() to avoid fdput() after a failed fdget().
>> fdput() doesn't do fput() on this file since FDPUT_FPUT isn't set
>> in fd.flags. Fix it anyway since failed fdget() doesn't require
>> a fdput().
>>
>> This was introduced in a commit that added kernel_read_file_from_fd() as
>> a wrapper for the VFS common kernel_read_file().
>>
>> Fixes: b844f0ecbc56 ("vfs: define kernel_copy_file_from_fd()")
>> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
>> ---
>>   fs/exec.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/exec.c b/fs/exec.c
>> index 06b4c550af5d..ea24bdce939d 100644
>> --- a/fs/exec.c
>> +++ b/fs/exec.c
>> @@ -1021,8 +1021,8 @@ int kernel_read_file_from_fd(int fd, void **buf, loff_t *size, loff_t max_size,
>>   		goto out;
>>   
>>   	ret = kernel_read_file(f.file, buf, size, max_size, id);
>> -out:
>>   	fdput(f);
>> +out:
>>   	return ret;
> 
> Again, that goto is a pointless obfuscation; just return -EBADF
> and be done with that.
> 

My reasoning is if this routine ends up growing it might be useful
to handle the return this way.

In any case, I will send v3 for both of these patches.

thanks,
-- Shuah
