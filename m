Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AB7BC38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 19:05:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D84E20870
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 19:05:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Odrj/j3H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728347AbgEGTF1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 15:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726320AbgEGTF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 15:05:26 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F27EC05BD09
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 12:05:25 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id f3so2117987ioj.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 12:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ALX0KlPOa5CmEMJbE+NcOQr52VcvkvocxSaJgPs417g=;
        b=Odrj/j3H0R7hU8+KYumKak54Bi+Nji00rmKhdstid0P4Ewljc7iDKHNEpARAT40gcH
         hzH0vj3WvTXm1ES6BIUNbnVw2YbUtEj9vl83wkIK26sOKxDubnJIlLmHbJ1mjPVGiK6b
         V1OEl8KM5n50UmVKne7i3ftrx8lMD6VoGvRH6+fK95wyRGwyZKJN3MlIz3wWy8IVhmQk
         mMBrDJSDXA5gBqgXRyntLHSM4Bx6J518MDCJ0dGdveW3Tgt0BO1sr6zDJc3v52Y35Gly
         r2SOi/5yoxTMcu8YaGwcTiCPZyC9uKNhDP3mmP0BIDXVx9OMi3OleEt5p85oOyO06FQb
         XmLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ALX0KlPOa5CmEMJbE+NcOQr52VcvkvocxSaJgPs417g=;
        b=WSOBzKR9LXwnBW3y8Z4/3P0xvNbJSvlqk73he2tjuRNatldjWoVOhnURJTykjoAa+n
         qA+xEnYw8hV+RVvCZT8bdklRsehIbCLMdb1UzTFPali/CD4daYK9YlJyhEMRf4JnTeC8
         KOpPrc0knd7WAREZ5ElOfrVdlnizLJeyImnhFTCpzoSJJPwYSzssm3zZDmZTKtoe2MPE
         OWGAJ8+TYZ7W3EAmW0JeK3LuVlGnxqn5AO/xrstwnzuVm78kB5KTlm8FsbypzJ18K0P7
         TWYoYLMavzclpfPPgK8uTwrpgeRxnqFuvPkSan2sdpvMQHaoBPXq6lu5cqs5ZwibBTyC
         0KdA==
X-Gm-Message-State: AGi0PubPDE/kCqfyys0B2ty6LtH0rIec2/V2/4qY6E6mE+V0yccf50FC
        RPv5R6t0tsHQpfYR1QEldYpQXg==
X-Google-Smtp-Source: APiQypIJCHCIpoM48c4qIZqQu9tdwVZS1I9D2iSqJLjDdhQcB6uT+NCdo27NSUgNnuII8pu0E8zfpA==
X-Received: by 2002:a6b:90f:: with SMTP id t15mr15169184ioi.188.1588878324422;
        Thu, 07 May 2020 12:05:24 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id u16sm3076929ilg.55.2020.05.07.12.05.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 May 2020 12:05:23 -0700 (PDT)
Subject: Re: [PATCH] fs/io_uring: fix O_PATH fds in openat, openat2, statx
To:     Al Viro <viro@zeniv.linux.org.uk>, Max Kellermann <mk@cm4all.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20200507185725.15840-1-mk@cm4all.com>
 <20200507190131.GF23230@ZenIV.linux.org.uk>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <4cac0e53-656c-50f0-3766-ae3cc6c0310a@kernel.dk>
Date:   Thu, 7 May 2020 13:05:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200507190131.GF23230@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/7/20 1:01 PM, Al Viro wrote:
> On Thu, May 07, 2020 at 08:57:25PM +0200, Max Kellermann wrote:
>> If an operation's flag `needs_file` is set, the function
>> io_req_set_file() calls io_file_get() to obtain a `struct file*`.
>>
>> This fails for `O_PATH` file descriptors, because those have no
>> `struct file*`
> 
> O_PATH descriptors most certainly *do* have that.  What the hell
> are you talking about?

Yeah, hence I was interested in the test case. Since this is
bypassing that part, was assuming we'd have some logic error
that attempted a file grab for a case where we shouldn't.

-- 
Jens Axboe

