Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FA13C47254
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 04:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF9C720836
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 04:21:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="YzmzeI6x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728189AbgEAEVz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 00:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726153AbgEAEVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 00:21:54 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8384CC035494
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 21:21:54 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id d3so4070679pgj.6
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 21:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qZHNPXY+VTbm7N7GaannHtaXZdAjYtMYWNGs5o8TEew=;
        b=YzmzeI6xz5S+smmboDtAuuvUdQGBRsBntKMDP2fjMBAyeQEgbx6QUBVkqqD5Uz5Boy
         RLy79t1R3hKfhMGM3Nh/EnJD+nCy+AfcU54C0N0CECOfZRA7OxYd/9TL+2yrJ9Kd6HTT
         8TrI1w9lbJnzYn8cJbFiVvnlDexCuCw9BMfDrC76omtIY06KSjHcQ0+KHiXXVW9kL632
         /9dkDiaDIn4FK5Vfth+oMEiFoHRyKIgdjQIPyGov8o+kJbQIeB2ugFDPZRfgFlU41Ru/
         znFIDOetIAX8aPOOFpSH0JVle5mOO7fMQVGtW1FuPYHyfI8YjYZVu5nT/TWsV4UcB57F
         jGyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qZHNPXY+VTbm7N7GaannHtaXZdAjYtMYWNGs5o8TEew=;
        b=uCtxyc5+fqHLBI7DKRNLPABcqLSfmZTN/Q0HFdKaooAaMsglm+FoJ6c3FkqSsbnCVQ
         y3mnjWWKgIQnVDeWCsQuNo4OxjlzXXSR5kg5ftwmO7swKqKeN3BcONaeVEr4Ba5qz/FC
         n1Yl+oSeyYqI88Bqxr0SAvG7hudpKQHIQRWTrmqw14gspEFj0ObCtDSc2stEOAI0lek8
         dGBoWUfdZbqet6PLm5mmgV3ovSriuJ7tUTlnQGhSN6Y4VN9OmUpB1Ei4/Mf21ywl8LkC
         buOrT1ca02o/lK37URFb7Bg6Q4vBElo2+X4DnYkAyKBcKx6InwketTNhdUrfuqwkPhFN
         9AwA==
X-Gm-Message-State: AGi0Pua7DS2qFDNsrZaVJtT8R7Y2xxiO9JYMq53jBxqzIIkASxUrFnR/
        9K2pOgLnflLa8elCl16I4BxL1fB9AHhHvw==
X-Google-Smtp-Source: APiQypI/M9SF/2cancLSbCaQVwKb5vIVsonHN4uSzVZ3JfjAjy2t2l4/9I7INa5SyIMPmK2feGga0A==
X-Received: by 2002:aa7:843a:: with SMTP id q26mr2180988pfn.240.1588306913353;
        Thu, 30 Apr 2020 21:21:53 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id dw12sm984795pjb.31.2020.04.30.21.21.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Apr 2020 21:21:52 -0700 (PDT)
Subject: Re: [PATCH] pipe: read/write_iter() handler should check for
 IOCB_NOWAIT
From:   Jens Axboe <axboe@kernel.dk>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <273d8294-2508-a4c2-f96e-a6a394f94166@kernel.dk>
 <20200501035820.GH23230@ZenIV.linux.org.uk>
 <210c6b72-179a-993f-1ec8-1960db107174@kernel.dk>
Message-ID: <269ef3a5-e30f-ceeb-5f5e-58563e7c5367@kernel.dk>
Date:   Thu, 30 Apr 2020 22:21:51 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <210c6b72-179a-993f-1ec8-1960db107174@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/30/20 10:14 PM, Jens Axboe wrote:
> On 4/30/20 9:58 PM, Al Viro wrote:
>> On Thu, Apr 30, 2020 at 10:24:46AM -0600, Jens Axboe wrote:
>>> Pipe read/write only checks for the file O_NONBLOCK flag, but we should
>>> also check for IOCB_NOWAIT for whether or not we should handle this read
>>> or write in a non-blocking fashion. If we don't, then we will block on
>>> data or space for iocbs that explicitly asked for non-blocking
>>> operation. This messes up callers that explicitly ask for non-blocking
>>> operations.
>>
>> Why does io_uring allow setting IOCB_NOWAIT without FMODE_NOWAIT, anyway?
> 
> To do per-io non-blocking operations. It's not practical or convenient
> to flip the file flag, nor does it work if you have multiple of them
> going. If pipes honor the flag for the read/write iter handlers, then
> we can handle them a lot more efficiently instead of requiring async
> offload.

Sorry, I think I misread you and the answer, while correct by itself, is
not the answer to the question you are asking. You're saying we should
not be using IOCB_NOWAIT if FMODE_NOWAIT isn't set, which is fair. I'll
re-do the patch, we can probably just use FMODE_NOWAIT for the final
check in io_uring instead.

For pipes, we should include the setting of FMODE_NOWAIT for fifo_open()
with the patch, at least.

-- 
Jens Axboe

