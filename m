Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48399C43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 06:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F11FF206D4
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 06:51:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="BWe9Fs7U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbgIGGvC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 02:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbgIGGu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 02:50:58 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6432AC061573
        for <linux-kernel@vger.kernel.org>; Sun,  6 Sep 2020 23:50:56 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id u4so13877557ljd.10
        for <linux-kernel@vger.kernel.org>; Sun, 06 Sep 2020 23:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1wiamZiSqOZYsHvayxqUn7pqDinjO3WGVZRcAVghQGw=;
        b=BWe9Fs7UY5hMTg1jX+30qqCiCf9RwV7KMCDkQ2cklvsiLZQPuGkE7p78Dg7U/pHo5S
         iIc58p8AuTtPfPQZ3Jw/ac8wEhmYoEvmcpq9tJEXjzwT3GFQvyRyv9BRBl8zXkSrxSGO
         UZyIASZDkT4LcKoUjauMgnTWsJwcea368uJG8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1wiamZiSqOZYsHvayxqUn7pqDinjO3WGVZRcAVghQGw=;
        b=kLJL3eydMTt5pMkVZIaBWM1lQy8wK4A8I5dI5VAeSUDOy1EfKvNCdfu8StcCO5YGYZ
         Hj+OJSIfozNrF6VKkhVjKmopoYKOMw4KcTmwpf+jS0kOJUQ9GQozl64G6PlmSV/wyqB8
         TLY+MrrML+Uj/+Zoz/Jv+OWwYCdLKMkxRcmt8O17we3tJViksyI+EIPmI668nD0xiAG8
         8b2t+s/pClA01ugvgoeTifoO4jd9MmzpkE8K3pnX1al+UYIeM/C4vB9INemkp/odQzHa
         E8nagdJWXo+MuAzAKf84itkXVRsuDDhXVWus3PNpgFcRA67tfx2+OYD9fzZdBNER7mGh
         7ybA==
X-Gm-Message-State: AOAM533ngpDmki1XniTD7bRGAsWmhLAPol9HniFHd/JpiJOSZcjoS4jr
        u1oKfQb/oWB+VjQxzWz4aE83BXPavP/v/4awekI=
X-Google-Smtp-Source: ABdhPJyykUmfGWhJYO26lt/rteoq/QrNE6oIBGAl5GFaq10qZmw+x9Edsu4PY9l8iodW3b63i7TytQ==
X-Received: by 2002:a2e:a0d5:: with SMTP id f21mr10362793ljm.364.1599461454862;
        Sun, 06 Sep 2020 23:50:54 -0700 (PDT)
Received: from [172.16.11.132] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id f9sm6182599ljc.129.2020.09.06.23.50.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Sep 2020 23:50:54 -0700 (PDT)
Subject: Re: [PATCH] /dev/zero: also implement ->read
To:     Christoph Hellwig <hch@lst.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        christophe.leroy@csgroup.eu, linux-kernel@vger.kernel.org
References: <20200903155922.1111551-1-hch@lst.de>
 <8d430999-b155-dbfa-e7db-f414b48014b1@rasmusvillemoes.dk>
 <20200907062026.GA19076@lst.de>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <4a981ee8-2d57-c7ce-a1ca-43ad237471d2@rasmusvillemoes.dk>
Date:   Mon, 7 Sep 2020 08:50:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200907062026.GA19076@lst.de>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/09/2020 08.20, Christoph Hellwig wrote:
> On Mon, Sep 07, 2020 at 12:34:37AM +0200, Rasmus Villemoes wrote:
>> On 03/09/2020 17.59, Christoph Hellwig wrote:
> 
>>> +static ssize_t read_zero(struct file *file, char __user *buf,
>>> +			 size_t count, loff_t *ppos)
>>> +{
>>> +	size_t cleared = 0;
>>> +
>>> +	while (count) {
>>> +		size_t chunk = min_t(size_t, count, PAGE_SIZE);
>>> +
>>> +		if (clear_user(buf + cleared, chunk))
>>> +			return cleared ? cleared : -EFAULT;
>>
>> Probably nobody really cares, but currently doing
>>
>> read(fd, &unmapped_page - 5, 123);
>>
>> returns 5, and those five bytes do get cleared; if I'm reading the above
>> right you'd return -EFAULT for that case.
>>
>>
>>> +		cleared += chunk;
>>> +		count -= chunk;
>>> +
>>> +		if (signal_pending(current))
>>> +			return cleared ? cleared : -ERESTARTSYS;
>>
>> I can't see how we can get here without 'cleared' being positive, so
>> this can just be 'return cleared' (and if you fix the above EFAULT case
>> to more accurately track how much got cleared, there's probably no
>> longer any code to be symmetric with anyway).
> 
> Yeah, I'll fix these up and resend.
> 

Actually, while you're micro-optimizing it, AFAIK VFS already handles
count==0, so you can avoid the initial branch and the last
cond_resched() by writing it something like

  while (1) {
    size_t chunk = min_t(size_t, count, PAGE_SIZE), c;
    c = chunk - clear_user(buf + cleared, chunk);
    if (unlikely(!c))
       return cleared ?: -EFAULT;
    cleared += c;
    count -= c;
    if (!count || signal_pending())
       return cleared;
    cond_resched();
  }

For the dd test case with the default bs=512 that avoids cond_resched()
and signal_pending() altogether.

Rasmus
