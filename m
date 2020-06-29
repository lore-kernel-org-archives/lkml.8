Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35450C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 22:45:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E579220780
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 22:45:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="FE7MpQEc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728380AbgF2Wpi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 18:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbgF2Wph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 18:45:37 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE5DFC03E979
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 15:45:36 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id s14so7659781plq.6
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 15:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xKWgfmUWOlb+dTGThUrunVvLc4+EdQONAVPrPzv8zys=;
        b=FE7MpQEceOHv0Lw22wW4W0nYDHzvxwYQQrNcu51bBcOUqpi+As6IGR27bnwXHlpfZL
         su0eQoQaQ/lcmbl2G53HGnPhcRWpMnfPFlDO6OAB1PlCyQLhApiwgUNqtXvbehc5LH1v
         gf6yash1nAU10L6WW+QNXtmU4P47gICSO+m5WNJX3DWC/J/ZerE91QdrQpHl3BEuFvr0
         2lfOrmN0+R3TZSAT2IiDTxQWAT7QOxZV57saRVC22tjNe4F2nWQ/Ble9a/Gz2eaS+Zgy
         tLy0B7o48jCehYcr8Ktnb0i321ytzzERIE1P1Oe4hvap03cJx+Gc9Bvnxk1GRem530Co
         MiyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xKWgfmUWOlb+dTGThUrunVvLc4+EdQONAVPrPzv8zys=;
        b=a0ZpaQRal5BQzLR4GU0PPSWuB11QSoL6dYPw1X9J/ATG6kZBd9XXLT4JW/HtA9Frt8
         IRFoEedX44brG9Q8IDdY1mwhEx3lx+Qi39/59G7rZjeClnCMur/luxM/WMt/1+iQuLSh
         Cr4Pzsnv29bDyjgNm6ndYIrHN0P9iseiMhWValG5InlatOBGvUXd6Ivj4bhk7B4udEdc
         U+tGZ5iGBkR6cJ7vygr52qsozeCO0LD0Abj44BUOoC29Z2S1rjvBZnqfp9GillxKZLh4
         WU1HAkwpVgxKFWY6OGgJtR+673B8yag23bFZDTYyw/DfXPtTs2po4daVBM5bHo3Z02UP
         wynQ==
X-Gm-Message-State: AOAM531BmUMStkfZMYeM/cLXqZ64IGkkx8KxIgQOD30Q2Gj2HkIzsqtE
        kvLrWd9VpV8ikvqVjLs4h9vTJUSc0LFg+g==
X-Google-Smtp-Source: ABdhPJyZEXUWwmz7SIKd8+fTWij6NgTR4fM2ol9AwKPFe3WKi6k/QuW+Cre/T20Ko/jIDTcq0HhXLg==
X-Received: by 2002:a17:90a:65c9:: with SMTP id i9mr19870342pjs.201.1593470735932;
        Mon, 29 Jun 2020 15:45:35 -0700 (PDT)
Received: from [192.168.86.197] (cpe-75-85-219-51.dc.res.rr.com. [75.85.219.51])
        by smtp.gmail.com with ESMTPSA id z11sm600366pfg.169.2020.06.29.15.45.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2020 15:45:35 -0700 (PDT)
Subject: Re: linux-next: Fixes tag needs some work in the block tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Pavel Begunkov <asml.silence@gmail.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20200629080533.5f44d445@canb.auug.org.au>
 <3949fc27-da62-6e26-cf07-59d3c78e2b64@gmail.com>
 <fa5b0279-32a6-f9c6-f325-cedc2786b74a@kernel.dk>
 <20200630083617.46d6a08b@canb.auug.org.au>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e781f9f5-c4dd-a91b-dccb-f951756c84ee@kernel.dk>
Date:   Mon, 29 Jun 2020 16:45:33 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200630083617.46d6a08b@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/29/20 4:36 PM, Stephen Rothwell wrote:
> Hi all,
> 
> On Mon, 29 Jun 2020 10:25:01 -0600 Jens Axboe <axboe@kernel.dk> wrote:
>>
>> On 6/29/20 10:21 AM, Pavel Begunkov wrote:
>>> On 29/06/2020 01:05, Stephen Rothwell wrote:  
>>>> Hi all,
>>>>
>>>> In commit
>>>>
>>>>   8c9cb6cd9a46 ("io_uring: fix refs underflow in io_iopoll_queue()")
>>>>
>>>> Fixes tag
>>>>
>>>>   Fixes: a1d7c393c47 ("io_uring: enable READ/WRITE to use deferred completions")  
>>>
>>> Jens, could you please fix this up after me?
>>> full hash: a1d7c393c4711a9ce6c239c3ab053a50dc96505a  
>>
>> I don't think that's a grave enough concern to rebase, it's just "missing" a
>> single digit of the sha.
> 
> Yeah, its more of a "please fix your git config". :-)

Agree! But I'm guessing that Pavel did this manually, which I end up
doing a lot too... And then mistakes happen.

-- 
Jens Axboe

