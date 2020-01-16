Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38CEBC33CB3
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 04:50:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E4EB2077B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 04:50:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="ZfjwP8mM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731019AbgAPEuz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 23:50:55 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41476 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729138AbgAPEuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 23:50:54 -0500
Received: by mail-pg1-f194.google.com with SMTP id x8so9261155pgk.8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 20:50:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=S/UKnCMf1wphMoJ4OYkcWAh+SusvLOSqiimKcfL2Y9A=;
        b=ZfjwP8mMty/3gY8/7UyP5mWSz503gg00xAVxGRihUuAduwFvWaB5lLxfmhETa49rMr
         x4GYE1l0nvMUbDVJ9Lvx/+zMU1/HCc9pieJX9hHMpJj3da7TCmRWlTN2dvnSvSpY1++A
         Qj5gfy3a35lBXVXhgQZoAIy2jcQpQ128Dd7BtTaiNtc3Y2mZurC9MLwSC9Cj7u8nzC1+
         hbpb2au3IUCG9bUfDSMUji+kJlXbCsVJqnDoCIndvE5bv8w9j8f4m9QGdN/AUlllv347
         8jYF57jjhMVk0zVu5pBjqRI1AaBTR7Ujbr+B3rAGYirbKAIIv5hUb4d52TaU8aA37eDf
         3AYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=S/UKnCMf1wphMoJ4OYkcWAh+SusvLOSqiimKcfL2Y9A=;
        b=e7iaGHLu+yndbkVlsRUfdQGKVg66SHHxgRFBSyvyhcDIelSV2CmZGugf2H4RlCi1f0
         GvvXlQ+YNGC6jI3KKL9ZSBMcZIQFXFocm5Gv1UwPx4FJuH+BSkGPMr7sKxX43ZlbBkbe
         9pTvw0/x9NMJMdixiIllit9BpzamZHxCCTQZTxqKwUVb06JgAaTI83QIWOGBun7qcDK8
         Np7XzP/LRRtTuwfQ3pHbBPm8ay95HvZTSOpv9TNjsf56cW9dGiKs8GLrpzqurh7Wko1N
         tB3qdIZ+0gCfangNtXI7DEfhj8MN8jK76haeE1YEv+EwoNjAI0YtawQMUbhD2lrmNHwY
         JjPg==
X-Gm-Message-State: APjAAAXTFEubyG847qsAVMdfuK2DNc+vsXyQKQs/qWhcqpT+HfDRyZ13
        Oz85jsskyQn+wvLFb0CDcTtI27JatAs=
X-Google-Smtp-Source: APXvYqx8W8T4r676wWslp3VTMNL+6BkVR5IFd2Wz44CBYJOKTlTYL/G6uYUGnCSjOZMsZRMCILUWpg==
X-Received: by 2002:a05:6a00:90:: with SMTP id c16mr34347767pfj.230.1579150254055;
        Wed, 15 Jan 2020 20:50:54 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id i66sm24001901pfg.85.2020.01.15.20.50.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jan 2020 20:50:53 -0800 (PST)
Subject: Re: linux-next: build warning after merge of the block tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20200116115430.74ba615a@canb.auug.org.au>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <4d97c033-c00f-bf96-30f5-9eadab8a2214@kernel.dk>
Date:   Wed, 15 Jan 2020 21:50:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200116115430.74ba615a@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/15/20 5:54 PM, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the block tree, today's linux-next build (arm
> multi_v7_defconfig) produced this warning:
> 
> fs/io_uring.c: In function '__io_sqe_files_update':
> fs/io_uring.c:5567:8: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
>  5567 |  fds = (__s32 __user *) up->fds;
>       |        ^
> 
> Introduced by commit
> 
>   813668c6099b ("io_uring: avoid ring quiesce for fixed file set unregister and update")

Fixed up, thanks.

-- 
Jens Axboe

