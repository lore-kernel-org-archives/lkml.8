Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B5ECC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 21:26:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 456A5208B8
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 21:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590787570;
	bh=B+AzIROHTOVO7dpR1e5lrmZOwMSAxlU1AoumV6m2+lM=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=B7ld1GQxU/LLTbxg55DD46BNiFrFafGQKGxEdP8tRSxR14sVnPSEOsTauchXQUFzL
	 P6QVRBG+FNlEzxdN+AfYw8BFKUVMxFWIFJbldWKgGCF+AS3bEQ9i2zREFtepK0TWfX
	 F/KNhoF6n1VT2WYzJ5klLsJb/Uox6V0slVNpQpzI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728371AbgE2V0J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 17:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728071AbgE2V0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 17:26:09 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 053CBC08C5C9
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 14:26:09 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id h7so3101400otr.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 14:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=p8dAPHZz+ht/nN+XghF1uMTld/TMP+BOizxf53N3zQw=;
        b=EBp/atAcNaFN+6puN/Jwb4WUQOnZtbjjBHlfOyk5q7ALw8VT2t5On9HYf8HxTqJNVO
         TqhBj4hRJC/0T8uzNoKe+c2rPuMyrCaCgsZPDHg4BT3UJ6/b8iUE8SQ15qBpk19qHVVG
         0o8CsdaoQRbPfklS3B0KS0zjqfQ1pVpf+sNZg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=p8dAPHZz+ht/nN+XghF1uMTld/TMP+BOizxf53N3zQw=;
        b=j53RZz6aAb07jaGqms7X7nQttxVC4OkRsZb9Zmc4O7u5Kgt9Q9PpDKNSXX9If6jeDK
         SaknM6VGwslR7DSqN9JdL1DvJHxPoavLeXQKcix86MeGIXUuqW0p7WPlOqzQdGdlzlGU
         ZOd3rxGm07kTIe4FrqrmLXHwisBD9PcnbC3mzcO7KGcowhnyaj8reTRJ2YS5qEI61BnF
         rphwka0uwp0AVDmsTDpKNyDKS9UrmIer/ac4Uos7Pi4+2FdsK4T+g3R7y/6VrX4gzTik
         8WTDD3nR/yWwudqzY5LXWxwvNONAVMRhplcAwJFfKe6f3jBa9iDQsF7sMNSP1uzbUbMD
         /jeQ==
X-Gm-Message-State: AOAM533GBfBMOaKMYcP9q6CjKJ2AgfuqIMiyF9EutB2QrJ+Tj5gsW0xU
        xDvNCpe1WAIr2oHMfYeDUUncpi+PpXs=
X-Google-Smtp-Source: ABdhPJxEZN3jHXCnJyt5F95GaRnw9TqHldrmjpzX0qnxxu2yYQJLNj90XywZQvbi5zTEizxNkgqYhQ==
X-Received: by 2002:a05:6830:120f:: with SMTP id r15mr4105004otp.348.1590787568026;
        Fri, 29 May 2020 14:26:08 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id f15sm2782569otf.81.2020.05.29.14.26.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2020 14:26:07 -0700 (PDT)
Subject: Re: [PATCH v2] selftests/ftrace: Use printf instead of echo in kprobe
 syntax error tests
To:     Seth Forshee <seth.forshee@canonical.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200304222009.34663-1-seth.forshee@canonical.com>
 <20200529203704.GA57013@ubuntu-x1>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <de431b0e-6337-b95a-15c5-1c0c6abe697e@linuxfoundation.org>
Date:   Fri, 29 May 2020 15:26:06 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200529203704.GA57013@ubuntu-x1>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/29/20 2:37 PM, Seth Forshee wrote:
> On Wed, Mar 04, 2020 at 04:20:09PM -0600, Seth Forshee wrote:
>> Test cases which use echo to write strings containing backslashes
>> fail with some shells, as echo's treatment of backslashes in
>> strings varies between shell implementations. Use printf instead,
>> as it should behave consistently across different shells. This
>> requires adjustments to the strings to escape \ and % characters.
>> ftrace_errlog_check() must also re-escape these characters after
>> processing them to remove ^ characters.
>>
>> Signed-off-by: Seth Forshee <seth.forshee@canonical.com>
> 
> Ping. Someone just asked me about this patch, and I noticed that it
> hasn't been applied or received any feedback.
> 

I pulled in this patch from Masami:

selftests/ftrace: Use printf for backslash included command
https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/commit/?h=next&id=8e923a2168afd221ea26e3d9716f21e9578b5c4d

Looks like a duplicate.

Seth,
Is your patch still needed?

+ Steve and Masami

thanks,
-- Shuah
