Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 970A0C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 23:31:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A595D2076E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 23:31:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="kpY/ogzU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728557AbgHCXb4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 19:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728024AbgHCXbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 19:31:55 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCDF5C061756
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 16:31:55 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id h12so9699606pgf.7
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 16:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fZxCVfA6iknjcbmtmcuTWJVxz+9CZiJohccd0QRpV6Y=;
        b=kpY/ogzUJeO4850neK1HrcSyV6FS6F7t/BgPOcyvklRhrxiRB23ceDISCdfkcpJTiJ
         xZNkqmIE6MLe4d2q2zSpXIOhVfkyVeqiuEmJ8wmLj6nlU8Wl+nie0+vYpN7hxxHIZNi0
         DnRQEswdDzYlQIXw9scaPJmrPVmnY5THraZHPusiJV7m7CVLu8m5PLkpztidLAWUNQ4H
         P3UBone94oiNcDb2stj8QIMaDfV/rOmGRVWBVytBUmWN+XfzY1lML/JsTBSmuLq9RLL3
         SJVWN9t/m0A15tn4Yx6IYLSGXofQl24aA8lW/vgE2nKWxF48CPJ/2hngrNlUBdkvS5JU
         zU0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fZxCVfA6iknjcbmtmcuTWJVxz+9CZiJohccd0QRpV6Y=;
        b=UB2DKYkIm2DwCRjozCEjhq/JBVJVPEpiX9R6v7ngTix2/CtmeogJ8X+40y1KwguIJa
         7bALnbLIwYhc628O0iPRnxGmS2VkApnvPan84bamComHchnJ2IiNu0bv0zkBHsRZwHan
         FiT/5CeZuXSQRC6zoxiR8xNojeBM+w/9YnoXUUYQDTcQRBVWkDZHMjc0EGPq/EWV2YCU
         GRVGk1UyMeuOypNoONSqLj/hWzfusFQwz6GTFx64JIpKg3x1fyUvwVsgUKqqa248lJmk
         mVn8KJw9/tIk/R1Mla6RQ+xWqSzIeYF5E5uvpgGAm30ZSBrG8D8V44/yEyZmJt74Nb5B
         rhmA==
X-Gm-Message-State: AOAM530R5aoxG2WIjKC1pgNEGrB2CyHc9bi/GPPS3oH38A57+GcLezxW
        Plfz8dBYe7+YwG15fPrKqmud9f5YDwo=
X-Google-Smtp-Source: ABdhPJwuzBFsODmNQbfT4Cm7zJ5mCxetTs66DsE0rYPUAq4lpaD8sjNI8OlmdSUwKBeJDUjUCxB3Fg==
X-Received: by 2002:a65:5cc7:: with SMTP id b7mr16832799pgt.445.1596497515029;
        Mon, 03 Aug 2020 16:31:55 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id 21sm20249913pfa.4.2020.08.03.16.31.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Aug 2020 16:31:54 -0700 (PDT)
Subject: Re: [GIT PULL] io_uring changes for 5.9-rc1
From:   Jens Axboe <axboe@kernel.dk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     io-uring <io-uring@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <50466810-9148-e245-7c1e-e7435b753582@kernel.dk>
 <CAHk-=wgaxWMA7DVTQq+KxqaWHPDrXDuScX9orzRgxdi7SBfmoA@mail.gmail.com>
 <cd478521-e6ec-a1aa-5f93-29ad13d2a8bb@kernel.dk>
 <56cb11b1-7943-086e-fb31-6564f4d4d089@kernel.dk>
Message-ID: <025dcd45-46df-b3fa-6b4a-a8c6a73787b0@kernel.dk>
Date:   Mon, 3 Aug 2020 17:31:53 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <56cb11b1-7943-086e-fb31-6564f4d4d089@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/3/20 5:18 PM, Jens Axboe wrote:
> On 8/3/20 4:30 PM, Jens Axboe wrote:
>>> Adding random kiocb helper functions to a core header file, when they
>>> are only used in one place, and when they only make sense in that one
>>> place?
>>>
>>> Not ok.
>>
>> I'll move that into io_uring instead.
> 
> I see that you handled most of the complaints already, so thanks for
> that. I've run some basic testing with master and it works for me,
> running some more testing on production too.
> 
> I took a look at the rewrite you queued up, and made a matching change
> on the io_uring side:
> 
> https://git.kernel.dk/cgit/linux-block/commit/?h=io_uring-5.9&id=419ebeb6f2d0d56f6b2844c0f77034d1048e37e9

Updated to honor exclusive return value as well:

https://git.kernel.dk/cgit/linux-block/commit/?h=io_uring-5.9&id=f6fd3784c9f7d3309507fdb6dcc818f54467bf3e

-- 
Jens Axboe

