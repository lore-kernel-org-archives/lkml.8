Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C11BC433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 14:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 792782077D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 14:35:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Ripf+8nv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbgFAOfH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 10:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbgFAOfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 10:35:06 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66004C03E96B
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 07:35:04 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id x11so16232plv.9
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 07:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BYjlMWMX+w4rGY423Gm8SdYzNmV4yO5dT2R9qllwqiQ=;
        b=Ripf+8nvKMhWWgU1eelOSFnSn1oOvCpOiQNMrOpGsI1bToTYeIhMloQ//T6NA8X2ay
         o4fOqkTi+3xglQvwgbp5WorSUoWxTQ+8Er2DD8je2Q5JZ8gSV75DJZme2AT7p3ziLVtM
         E2plWHIo/LNO1XYVnvXk48I+rVAfBUrOP2NfY0bXnkXmdz5SABKusA22WTaV7SMjU6T0
         2jR1IWk0cNaA7eYbftzfGpWoeRwWgjBWKcKRi3r62riIm4VRNE9K161KnEy2z+Q1KeDa
         f//bpa1QRa87nNRMbxsf9P/qKjGvkxf5+tnFF0ppFcZf38LR05Zx33krRd5WWr1C320M
         bHNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BYjlMWMX+w4rGY423Gm8SdYzNmV4yO5dT2R9qllwqiQ=;
        b=FPmYsSQNtcmg8mXYQswb4KO38cNTY1KC6rvT0FB3F5I31F1kx4PCXYiOn46YBixWVJ
         JQo3Xm5/P0bpW2sjjSAfpE6E1Y/88DFC6Zvt4PV1Fx/Bz3uQhoqF4YceIPJ/DAzgFV6A
         L8GnCFcNDqhJIz/vDV4MM+6my2vXeGhihUeFgwtVmuAgHq+wNiotHVXcP2n97VvaEBs2
         Hmr2ymPahAW9xkUZ1XJTz4pqNAT5ivwu9zg3d3ONMcl+ApUl+j4kepVYC+gTBhX+I6nu
         M2v+O6rJ5M4QCidBLJrePRMs5cOQ8yukqQ4fhVkOnqrvQL/1ZaAsclWeSYS/qyIb311B
         e98w==
X-Gm-Message-State: AOAM533vQZRa8ENKhW5ICoiISJdZoP8QOrZhSuqC0h4Qk1RwWWT8C9bo
        ErCvrtMed7CkBEulpLINEalGWw==
X-Google-Smtp-Source: ABdhPJyi6fGAj6YRMVEKQXpjs6sg6hV6icwsH9xAhUOG9BvC/DxGVV6zF173TL65jPi1QGHst/9Uyw==
X-Received: by 2002:a17:902:a60d:: with SMTP id u13mr5850657plq.46.1591022103704;
        Mon, 01 Jun 2020 07:35:03 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id t64sm13192087pgd.24.2020.06.01.07.35.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jun 2020 07:35:03 -0700 (PDT)
Subject: Re: [PATCHSET v5 0/12] Add support for async buffered reads
From:   Jens Axboe <axboe@kernel.dk>
To:     sedat.dilek@gmail.com
Cc:     io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org
References: <20200526195123.29053-1-axboe@kernel.dk>
 <CA+icZUWfX+QmroE6j74C7o-BdfMF5=6PdYrA=5W_JCKddqkJgQ@mail.gmail.com>
 <bab2d6f8-4c65-be21-6a8e-29b76c06807d@kernel.dk>
 <CA+icZUUgazqLRwnbQgFPhCa5vAsAvJhjCGMYs7KYBZgA04mSyw@mail.gmail.com>
 <CA+icZUUwz5TPpT_zS=P4MZBDzzrAcFvZMUce8mJu8M1C7KNO5A@mail.gmail.com>
 <CA+icZUVJT8X3zyafrgbkJppsp4nJEKaLjYNs1kX8H+aY1Y10Qw@mail.gmail.com>
 <CA+icZUWHOYcGUpw4gfT7xP2Twr15YbyXiWA_=Mc+f7NgzZCETw@mail.gmail.com>
 <230d3380-0269-d113-2c32-6e4fb94b79b8@kernel.dk>
 <CA+icZUXxmOA-5+dukCgxfSp4eVHB+QaAHO6tsgq0iioQs3Af-w@mail.gmail.com>
 <CA+icZUV4iSjL8=wLA3qd1c5OQHX2s1M5VKj2CmJoy2rHmzSVbQ@mail.gmail.com>
 <CA+icZUXkWG=08rz9Lp1-ZaRCs+GMTwEiUaFLze9xpL2SpZbdsQ@mail.gmail.com>
 <cdb3ac15-0c41-6147-35f1-41b2a3be1c33@kernel.dk>
 <CA+icZUUfxAc9LaWSzSNV4tidW2KFeVLkDhU30OWbQP-=2bYFHw@mail.gmail.com>
 <b24101f1-c468-8f6b-9dcb-6dc59d0cd4b9@kernel.dk>
Message-ID: <455dd2c1-7346-2d43-4266-1367c368cee1@kernel.dk>
Date:   Mon, 1 Jun 2020 08:35:01 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <b24101f1-c468-8f6b-9dcb-6dc59d0cd4b9@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/1/20 8:14 AM, Jens Axboe wrote:
> On 6/1/20 8:13 AM, Sedat Dilek wrote:
>> On Mon, Jun 1, 2020 at 4:04 PM Jens Axboe <axboe@kernel.dk> wrote:
>>>
>>> On 6/1/20 7:35 AM, Sedat Dilek wrote:
>>>> Hi Jens,
>>>>
>>>> with Linux v5.7 final I switched to linux-block.git/for-next and reverted...
>>>>
>>>> "block: read-ahead submission should imply no-wait as well"
>>>>
>>>> ...and see no boot-slowdowns.
>>>
>>> Can you try with these patches applied instead? Or pull my async-readahead
>>> branch from the same location.
>>>
>>
>> Yes, I can do that.
>> I pulled from linux-block.git#async-readahead and will report later.
>>
>> Any specific testing desired by you?
> 
> Just do your boot timing test and see if it works, thanks.

Actually, can you just re-test with the current async-buffered.6 branch?
I think the major surgery should wait for 5.9, we can do this a bit
easier without having to touch everything around us.

-- 
Jens Axboe

