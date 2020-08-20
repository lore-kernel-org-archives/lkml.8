Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4050BC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 15:35:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E3022075E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 15:35:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Gx3WkAn2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729084AbgHTPfm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 11:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728802AbgHTPfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 11:35:40 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC617C061385
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 08:35:40 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id v2so1994434ilq.4
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 08:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PxqJ+KF8eoddVjwmOfVLMrEOv7rCZfLqXLoNuUj+Zlk=;
        b=Gx3WkAn2m+9rZYeJ4Yj2+hdg/EPV01H8G+7/Gsqhur1h6k0KOFYJbYKLivEr0k5xgo
         oTf84GKs0mBt92dxmGAE6bvtUI8LAAD8zJ7nDQd4XCZlztd3gmbtZ2oI5XMCTUa0okWW
         0CchrZUt8iw/MkXiuD9NhXNyzg7/rwRWUWayK+A48usffsv8JHWCbE0YRuT7Nm/sPBgR
         YcZAgskjGG/YX1X2Qmve3did5048r2k+SYjW6Zk4kwBBA+9WwkBR+kOd4E+PCbzd98gp
         arEPDuqYAO2ULaDiEiVkhb/Ieg7bjTZcZggxnrFkzFBKcaJZo9lpcYNxid06tJktNpw/
         weFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PxqJ+KF8eoddVjwmOfVLMrEOv7rCZfLqXLoNuUj+Zlk=;
        b=KbVZN9a3a+mBiBTgj1ox5xVLdHpCl7vtUfL1rh9TynhetqLqmkTdZXZwhTf7dF/h77
         3rvqUorXZYv2KcvkGNqUcTW1wdY/GphiB6DxScZmmtI9b0H4hQSngKdgTX1zyJOhSsFF
         3V3UupQb4lYQqdJuAbIkRW2BPC0e3kDJfTzZWTDP+UjHl23mgzlrgNsmczsmC6u5XS4X
         6gE+T+C3QNcivRDGsPu33UTWP0L4HdvOIlAhQ7TmaGniXFTCMdTisA7ilvZoVJH423LH
         hfChZDoPkvknxaigBU4rMGntXFhvR4r7tYczPf2upECBvFs+IMsD6GHOjE3oAUij/2eQ
         7Y/g==
X-Gm-Message-State: AOAM533aRPjogsnjEQTsVvTl54kEiQ4FVLrTDW6hU+Ru07I+oakTs5Oy
        hkLQ6ok4ZBAD8afOpkVM3GQpWIpTH9tZPDHUoPE=
X-Google-Smtp-Source: ABdhPJyCloxNG7waNd9sWsZwA6ta0Vff204AhHHDxwrSM9UwR/2kdEHIIpqsrahxt/2SIObwmiFzLg==
X-Received: by 2002:a92:99d4:: with SMTP id t81mr2984047ilk.95.1597937739765;
        Thu, 20 Aug 2020 08:35:39 -0700 (PDT)
Received: from [192.168.1.58] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id c76sm1897226ill.63.2020.08.20.08.35.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2020 08:35:39 -0700 (PDT)
Subject: Re: v5.9-rc1 commit reliably breaks pci nvme detection
From:   Jens Axboe <axboe@kernel.dk>
To:     Keith Busch <kbusch@kernel.org>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>
Cc:     linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        linux-kernel@vger.kernel.org
References: <20200817135011.GA2072@lx-t490>
 <20200817155658.GB1221871@dhcp-10-100-145-180.wdl.wdc.com>
 <d077aec4-d79b-b52e-cdd9-bcc89fbbde5f@fb.com>
Message-ID: <2356f514-9408-6a6f-871d-046984963533@kernel.dk>
Date:   Thu, 20 Aug 2020 09:35:38 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <d077aec4-d79b-b52e-cdd9-bcc89fbbde5f@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/17/20 9:58 AM, Jens Axboe wrote:
> On 8/17/20 8:56 AM, Keith Busch wrote:
>> On Mon, Aug 17, 2020 at 03:50:11PM +0200, Ahmed S. Darwish wrote:
>>> Hello,
>>>
>>> Below v5.9-rc1 commit reliably breaks my boot on a Thinkpad e480
>>> laptop. PCI nvme detection fails, and the kernel becomes not able
>>> anymore to find the rootfs / parse "root=".
>>>
>>> Bisecting v5.8=>v5.9-rc1 blames that commit. Reverting it *reliably*
>>> fixes the problem and makes me able to boot v5.9-rc1.
>>
>> The fix is staged in the nvme tree here:
>>
>>   http://git.infradead.org/nvme.git/commit/286155561ecd13b6c85a78eaf2880d3baea03b9e
> 
> That would have been nice to have in -rc1...

And now we're getting very close to shipping items for -rc2, and it's still
not in. Can we please get the nvme pull request out for -rc2?

-- 
Jens Axboe

