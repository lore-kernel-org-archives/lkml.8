Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D2BCC3F2CE
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 18:37:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 524032166E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 18:37:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="iB6D5Kmy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730234AbgCDShs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 13:37:48 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:44277 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729703AbgCDShr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 13:37:47 -0500
Received: by mail-io1-f65.google.com with SMTP id u17so3508414iog.11
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 10:37:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wh0qFjW/qHneQSqg+QQx1XFOZYzFNeLir404hhmmk8A=;
        b=iB6D5KmyEc3L8QegN7XRaZrSaz+3zxQkc9SriWcXcKD5qmINgB237OLXeEG3VIIufZ
         FvcVyrcvqBEKHtgKJcOPxk0q0ghNUJPqL6gHXxeQS+vZsIYY1oT2XqA8KYFBZgY7xzlt
         QzDuoRgNtzNN14mC1S1RlEXMdj7luaqoLjH9jbn033e2Yg7yKPLpYDUQ68orP1GLOokD
         HAaRyA4w3EhgOHVDb8fzIQbNZEIKGKas0uXpvco/6TWXkYyYAn4/WQr+1trfzaAyM4Xv
         5UraL+b08FmBCu5kqtheb1dGuTsE8WJEUNQixqV6yuvc4jdNKDeXf+OZVhlQyPtyx8pb
         JkpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wh0qFjW/qHneQSqg+QQx1XFOZYzFNeLir404hhmmk8A=;
        b=lGsZAw2/uuW4aalWPZ5qc/n+4FuVeOhM0if7KlhiouQkB6XquAxOKE6bSnK7q3VKKd
         t1Qsbnpgjx0xW1AcKNgMOCi0qCc8iuDdRCNY07dhSm+7nsXXvNW0LdLdOe0BSoXbaVh+
         yzEnBuEXjkZkmgQfSsV3O1NlIO4BMhzOVHN46uxhMtjawqrMs4sKDi5rMS9lH+O+JT0/
         xoP5y7YLs2aBtODykfVS6PdG2y9EPjvKDsGrDq/miGrUSqijX2zreDtBuZMhgPLXRrBL
         lYuauiSIzDgd7cNsu2AMY2eW3F0w5LWD4QtfYwtDb78rW0a9Yif7NQkvzdVeRTJhii0Y
         UjmQ==
X-Gm-Message-State: ANhLgQ1YmAyj1sI0yph0UVJ3ok3/MeOwlBy2o/3oiiDr5dKKsKG/ANos
        my2GKYw9+mPNGe6J/qbQ1M+PEn87ykA=
X-Google-Smtp-Source: ADFU+vsarnSkFGccdJ+tjh1uW/LPY+9/izVSa2ywAEhv/Y2brEmeYq0uF0XYMk03CKqAXA5hAXDoOg==
X-Received: by 2002:a02:780f:: with SMTP id p15mr3875002jac.91.1583347066713;
        Wed, 04 Mar 2020 10:37:46 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id h14sm2049272iow.23.2020.03.04.10.37.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Mar 2020 10:37:46 -0800 (PST)
Subject: Re: [PATCH -next] io_uring: Fix unused function warnings
To:     Stefano Garzarella <sgarzare@redhat.com>,
        YueHaibing <yuehaibing@huawei.com>
Cc:     viro@zeniv.linux.org.uk, io-uring@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200304075352.31132-1-yuehaibing@huawei.com>
 <20200304164806.3bsr2v7cvpq7sw5e@steredhat>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <5a1c612a-9efa-1fc8-e264-1a064d4a4435@kernel.dk>
Date:   Wed, 4 Mar 2020 11:37:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200304164806.3bsr2v7cvpq7sw5e@steredhat>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/4/20 9:48 AM, Stefano Garzarella wrote:
> On Wed, Mar 04, 2020 at 03:53:52PM +0800, YueHaibing wrote:
>> If CONFIG_NET is not set, gcc warns:
>>
>> fs/io_uring.c:3110:12: warning: io_setup_async_msg defined but not used [-Wunused-function]
>>  static int io_setup_async_msg(struct io_kiocb *req,
>>             ^~~~~~~~~~~~~~~~~~
>>
>> There are many funcions wraped by CONFIG_NET, move them
>> together to simplify code, also fix this warning.
>>
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>> ---
>>  fs/io_uring.c | 98 ++++++++++++++++++++++++++++++++++-------------------------
>>  1 file changed, 57 insertions(+), 41 deletions(-)
>>
> 
> Since the code under the ifdef/else/endif blocks now are huge, would it make
> sense to add some comments for better readability?
> 
> I mean something like this:
> 
> #if defined(CONFIG_NET)
> ...
> #else /* !CONFIG_NET */
> ...
> #endif /* CONFIG_NET */

I applied it with that addition. Also had to adapt it quite a bit, as
the prototypes changed. I'm guessing the branch used was a few days
old?

-- 
Jens Axboe

