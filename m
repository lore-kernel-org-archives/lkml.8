Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2FBBC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 14:14:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B338220738
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 14:14:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="cPAowrvg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbgFAOO5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 10:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbgFAOO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 10:14:56 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73E06C03E96B
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 07:14:56 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id a4so3525074pfo.4
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 07:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9vOcJSYuJJnYePrRcpmlNi98VlvUeqMvdIZYemDmBzo=;
        b=cPAowrvg3+8qpPhWODryKeUzF16vt+n1EfUw78CDYf7Lmd27WHSykd1EAJniDvxoHr
         iGcxqup+zi2L/8Xbac/DxZOOAa7a9GrvsICk2grrQ5f/PK8GuJJ1LgXraOaaG0Y+tfF9
         kx2d6ZjJKrNhnEth5VY4l2ltmhRhjlCNlnp4AokjwZSnNxl5D3NExhU5MtUgSUUkMEvw
         3ncRizoIv+h1P3kk2/tvP/fTQqdAr+f9fNzLUXrK9MjDSWl9mqob5TZxOkaqCXdkKXwz
         YdOJtPJAD6CaC31PGpqhjkREk/45yfElugELO9/U6LpN5A08ZVxv19ginlCQKZWb+ce/
         8EkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9vOcJSYuJJnYePrRcpmlNi98VlvUeqMvdIZYemDmBzo=;
        b=sUpqgpcPAHWjU18aJ8G3ykQBfd6NsYIordCBwkVFcwhs3wJhNCtWiAUmP1nLKhm/gE
         uP4HTwv8ed4TSeCtEji2jCeM5i3ZMVnT/stAnEMXa0e5r3XtcrlEvIFJNrP/I08gMldb
         LUJG+ffdfq6ER8Ipftg2JLci8Cnw48fdNzMAi5nriiT4AAMRt/9gKap4Ettv387xm7Y0
         KdME/La81wyHQK5wKIDRgPrFQpdOXcUAvsr0hOOEGlIU8MlvDuvGMhcrXxOImsNMFvRE
         beZdNtG3r2/IN4zMC5ddVHlc7cVo0udhHvfUjZPu25nEF7V1NM6jBzVMdEqZ5viPNc7F
         Ks0Q==
X-Gm-Message-State: AOAM5337pc7nAOg2XkSaI6o7tEOzxBP40UT3y9J/T+kHE9nMSR545iEx
        4pGME3fpqOMQFWSAZGfc6as5DQ==
X-Google-Smtp-Source: ABdhPJzre5AcvNL/dtRANT5mUdNrjeNyCn2H4102/mC652nMm3G+J97guUP+QFSgYAFiENMgxqf2bA==
X-Received: by 2002:a62:ed02:: with SMTP id u2mr21244554pfh.60.1591020895906;
        Mon, 01 Jun 2020 07:14:55 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id z29sm14780695pff.120.2020.06.01.07.14.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jun 2020 07:14:55 -0700 (PDT)
Subject: Re: [PATCHSET v5 0/12] Add support for async buffered reads
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
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b24101f1-c468-8f6b-9dcb-6dc59d0cd4b9@kernel.dk>
Date:   Mon, 1 Jun 2020 08:14:53 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CA+icZUUfxAc9LaWSzSNV4tidW2KFeVLkDhU30OWbQP-=2bYFHw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/1/20 8:13 AM, Sedat Dilek wrote:
> On Mon, Jun 1, 2020 at 4:04 PM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> On 6/1/20 7:35 AM, Sedat Dilek wrote:
>>> Hi Jens,
>>>
>>> with Linux v5.7 final I switched to linux-block.git/for-next and reverted...
>>>
>>> "block: read-ahead submission should imply no-wait as well"
>>>
>>> ...and see no boot-slowdowns.
>>
>> Can you try with these patches applied instead? Or pull my async-readahead
>> branch from the same location.
>>
> 
> Yes, I can do that.
> I pulled from linux-block.git#async-readahead and will report later.
> 
> Any specific testing desired by you?

Just do your boot timing test and see if it works, thanks.

-- 
Jens Axboe

