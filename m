Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 201A8C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 01:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7806206A5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 01:18:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cD48EiHK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726389AbgHJBRE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Aug 2020 21:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbgHJBRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Aug 2020 21:17:04 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E5A3C061756
        for <linux-kernel@vger.kernel.org>; Sun,  9 Aug 2020 18:17:03 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id u10so3974636plr.7
        for <linux-kernel@vger.kernel.org>; Sun, 09 Aug 2020 18:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GKRxSAO1CESdO76PS1s8YHcqbEE81UNuCm63qCXJa7E=;
        b=cD48EiHKLuS8p9K6/Tc3KD/rDH0r2VFynL4T3Yj2U6/X8LvP+15FrM0hIhr9fdds7w
         Cot3wxR6ygAeHWml2ZGZttVWK5xTG7ERaPIv5xx5R6mnAWKJH2nAFR0UxbwuqWaWUcMG
         KXB6Hrvq9UR5ZDxlUld778hykEBJkPu5bx/zqwoPL9VgAA4iSQckiemQbZwc7U2Dq77/
         J3cgiM54nfjkaEKhaciK7dgdLMhje/bhX8Zc2pruOi1BcvyrD0gyE865s66ng1ykM2Qd
         KG+c9tSOPgfDxEXPDRDlyZ21Od+skGfvEJ7uLjhI8+e5YyUqE0HSJ7pBr9OcaxD7ETZT
         yJNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=GKRxSAO1CESdO76PS1s8YHcqbEE81UNuCm63qCXJa7E=;
        b=VV0dlxqQwxaFiHHOGQhQvz6qHFuuAnxvlFyjJJkEN717POrp9vvHjmYQ5rM3HEW1vA
         oawk+W1flbdtC5Sjw9dS6Qs2RLiQEwu1GZh4EcNEQftV3Wu/9z/H5mjszr5EFhLowuwW
         qYPKbLwf4Q2QC7BS18RHRa0CK6LOVGNpTs1JAjsHkF9XEiZ8ZNbhJPs2dfj2rwiSwER7
         H9n+uxsdcXW7sFQi9OhPRusu+69+NBFTbW9Y19VNMyh8ookl5jEfAjsRjh8hRt5GnBqZ
         FRE4l7tMOxXftEZpdL66m2DkCH6JywvOMaxLuVqo0ifjpn7kblZ8h4+tHXZi2ZS1wUY0
         GUEw==
X-Gm-Message-State: AOAM533j3Yj5KJzZ1fwrCNAN0482jUadjRQgLNy04+83QBhruoUDsB28
        xYEUbzoXa28c8md5O3juJrfd7yNu
X-Google-Smtp-Source: ABdhPJz67FT7JWOeuhqoetUPyviqJczLQCnXxdqidlXspP/MjMWEO49wZ8aPG0CKo2Mn9GxM3XQkog==
X-Received: by 2002:a17:902:aa93:: with SMTP id d19mr21285241plr.272.1597022222910;
        Sun, 09 Aug 2020 18:17:02 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l67sm17109291pga.41.2020.08.09.18.17.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Aug 2020 18:17:01 -0700 (PDT)
Subject: Re: [PATCH 2/9] macintosh/via-macii: Poll the device most likely to
 respond
To:     Finn Thain <fthain@telegraphics.com.au>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Joshua Thompson <funaho@jurai.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org,
        Laurent Vivier <lvivier@redhat.com>,
        Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <cover.1593318192.git.fthain@telegraphics.com.au>
 <5836f80886ebcfbe5be5fb7e0dc49feed6469712.1593318192.git.fthain@telegraphics.com.au>
 <20200809185541.GA133779@roeck-us.net>
 <alpine.LNX.2.23.453.2008100844450.8@nippy.intranet>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <e3252495-2d5e-269f-6fa2-f46bbf609a53@roeck-us.net>
Date:   Sun, 9 Aug 2020 18:16:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <alpine.LNX.2.23.453.2008100844450.8@nippy.intranet>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/9/20 3:58 PM, Finn Thain wrote:
> On Sun, 9 Aug 2020, Guenter Roeck wrote:
> 
>> Hi,
>>
>> On Sun, Jun 28, 2020 at 02:23:12PM +1000, Finn Thain wrote:
>>> Poll the most recently polled device by default, rather than the lowest
>>> device address that happens to be enabled in autopoll_devs. This improves
>>> input latency. Re-use macii_queue_poll() rather than duplicate that logic.
>>> This eliminates a static struct and function.
>>>
>>> Fixes: d95fd5fce88f0 ("m68k: Mac II ADB fixes") # v5.0+
>>> Tested-by: Stan Johnson <userm57@yahoo.com>
>>> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
>>
>> With this patch applied, the qemu "q800" emulation no longer works and 
>> is stuck in early boot. Any idea why that might be the case, and/or how 
>> to debug it ?
>>
> 
> The problem you're seeing was mentioned in the cover letter,
> https://lore.kernel.org/linux-m68k/cover.1593318192.git.fthain@telegraphics.com.au/
> 
> Since this series was merged, Linus' tree is no longer compatible with 
> long-standing QEMU bugs.
> 
> The best way to fix this is to upgrade QEMU (latest is 5.1.0-rc3). Or use 
> the serial console instead of the framebuffer console.
> 

I have no problem with that. Actually, I had checked the qemu commit log,
 but somehow I had missed missed the commits there.

> I regret the inconvenience but the alternative was worse: adding code to 
> Linux to get compatibility with QEMU bugs (which were added to QEMU due to 
> Linux bugs).
> 
> My main concern is correct operation on actual hardware, as always. But 
> some QEMU developers are working on support for operating systems besides 
> Linux.
> 
> Therefore, I believe that both QEMU and Linux should aim for compatibility 
> with actual hardware and not bug compatibility with each other.
> 
I absolutely agree.

I repeated the test on the mainline kernel with qemu v5.1-rc3, and it works.
I also made sure that older versions of Linux still work with the qemu
v5.1.0-rc3. So everything is good, and sorry for the noise.

Thanks,
Guenter
