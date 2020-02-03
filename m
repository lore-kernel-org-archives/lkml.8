Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FE86C35249
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 15:43:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16F4520CC7
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 15:43:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="OC9GYtA5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728130AbgBCPnc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 10:43:32 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:37363 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727339AbgBCPnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 10:43:32 -0500
Received: by mail-il1-f193.google.com with SMTP id v13so12992727iln.4
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 07:43:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tqYcgHc5VOj+fbH6k9sfeEL1lPZODVdx63DLzZEZWGM=;
        b=OC9GYtA5uaUGUTNxpxQP/8l4Y2Kmkh6U/EDEHCHesaZEfX9yBWA2ezdOt6+moxwlHA
         fvWoLToypZUAE/X/KcjKoMOUwGFX1jv2lDCMzgP13MzrkTXz9IqkvAsBru1XMrBRMX8y
         xwfcccVkfpWsSPduRMbDU/ECQFb1hqkDshtDOEmOYITnJDsj1tyUheUp2g8/yT2kLcAU
         /z8WF2AHtU/dPDmdye//GZGZ4BuyeFI+8KokNEPRHRRQ2v9LycDhYeQQmGo/4iSwu7pF
         NhLsacjk8qNBsYCduXgCE+Ap+uOTU+s7qcWhCmSK04kTXkUHuySuSo6uk+XW1NLRNoHA
         1lyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tqYcgHc5VOj+fbH6k9sfeEL1lPZODVdx63DLzZEZWGM=;
        b=ZFLEzgOdND3yL1CI912DbkF7Khv6CgVYMsXa+bV0GGKya2OrLeXnAn0m//LxwAqlFg
         pxm4yZzM/p1G7Xj0+kAG2RbUAHNhiASWYZCapDSYMdDWrGBUknEtlLaYeFFoUbZFTl1q
         g9f3+Ud/fAqTYiTfOsfpUcvn2h50p/Ty7esI4BqLXl+reVDSqCb1CvO5/mnEoiB35jnk
         E25JXrb4Gw3RM4nxJc0gaPCk1qEhd3NJ2PVL6kKOuxdjvV0OJ7NaBahU/4hA5t6+vc4J
         yoXU5sGHjBsAuxdrW9rN4akvTTjGnp4U5gCfWAAWrp28XRkpn8QPLXtsNFcSU7fkaKip
         ePHA==
X-Gm-Message-State: APjAAAVnQZmYchK4lmYy8isGsvItl+n29A38uMurvOXPt7UX+3gNuaxI
        w7oq15lb6OvabjMDBoW51WOhUkjzISs=
X-Google-Smtp-Source: APXvYqzcTRKaGJoUO23/z186pV0Ri5qk49RtXpG070hlIWnLWwd1jK0I3EojhgnXaUiM+3Vq9ztGGA==
X-Received: by 2002:a92:4818:: with SMTP id v24mr14416711ila.96.1580744609930;
        Mon, 03 Feb 2020 07:43:29 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id x62sm7393197ill.86.2020.02.03.07.43.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Feb 2020 07:43:29 -0800 (PST)
Subject: Re: [PATCH liburing v2 1/1] test: add epoll test case
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     linux-kernel@vger.kernel.org, io-uring@vger.kernel.org
References: <20200131142943.120459-1-sgarzare@redhat.com>
 <20200131142943.120459-2-sgarzare@redhat.com>
 <00610b2b-2110-36c2-d6ce-85599e46013f@kernel.dk>
 <20200203090406.mlgmw2u7lv7a76vd@steredhat>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d3763cdb-dee0-9312-2a4c-08ed939eae70@kernel.dk>
Date:   Mon, 3 Feb 2020 08:43:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200203090406.mlgmw2u7lv7a76vd@steredhat>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/3/20 2:04 AM, Stefano Garzarella wrote:
> On Fri, Jan 31, 2020 at 08:41:49AM -0700, Jens Axboe wrote:
>> On 1/31/20 7:29 AM, Stefano Garzarella wrote:
>>> This patch add the epoll test case that has four sub-tests:
>>> - test_epoll
>>> - test_epoll_sqpoll
>>> - test_epoll_nodrop
>>> - test_epoll_sqpoll_nodrop
>>
>> Since we have EPOLL_CTL now, any chance you could also include
>> a test case that uses that instead of epoll_ctl()?
> 
> Sure, I'll add a test case for EPOLL_CTL!

Awesome, thanks!

-- 
Jens Axboe

