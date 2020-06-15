Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A568C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 14:39:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C1F820679
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 14:39:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Cz/M8iME"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730657AbgFOOjA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 10:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729243AbgFOOi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 10:38:59 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D2DC061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 07:38:59 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id d66so7906243pfd.6
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 07:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AlD+LICwiIvLTtYfnuORDdMvLerlM40fltHFm8HguOM=;
        b=Cz/M8iMEWh8OWbvja/EPnEx0btECakHXcsdrblbrdDTGLRbPcy6CZOpsFeQVJ2FGZz
         /6j9sLx92AvAQzPITwU5GaPHOfTiw7bM9q1LRlV9xmoz7QdLa3xA46nJ9UkA7rujWngW
         8FkRD/2tP/pqaOjwSDPMui1ktuCk4YtyxHGLTzd44rN8kGown+rFsmhfM8WJ02t2MrUi
         ZGSCUWKUo9j+XF64O9IZYGrpeeiB1UKvrS8/CoGlDYJWaBTINSCRhVxI/1h/73GlDhGC
         vWqsrzR5oK7Mu9cxdcK4JxTg0syHXBn4FSedCXbVxu/LIJj1BxSdVXePGm8bOdKSsP56
         NE+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AlD+LICwiIvLTtYfnuORDdMvLerlM40fltHFm8HguOM=;
        b=ZW/XDp34b6s8qfM1d3ummJz5b2+SP9V3g7rz2GgWVst2aLS6zQ0ZxXvmZSYv+xK3FR
         bSwZaa5fD8WXzp5UMZgHBWRxSrbKaIpegWFnyMEdDGrYYe4Cli5cizqWiTNfTwVBbMQn
         HpASXzE2MK9llE5xm5kLS1YfZpJvxepYV6uDJE/naPNX0U8fPn4QDfomu4f6jmYUWG8g
         obyGT1dUc1DLoDaWaipWIBHvFBZEkgD8rVAzTI4+gBZ3u2v16AcYHwSExNkglvBpeOnW
         Ez8bwLEfyOj748nTxmqtOmQY4KfumWfZ9arkCp5WmRo8zC7rw+wOYlvi9VKsVmoHisBd
         qp+g==
X-Gm-Message-State: AOAM533IscmzcHzcVz3lNpB53eU93xvfZQzZ2RMfTrQKKDwJI7Aa7xwN
        0S9wwol1zfdyyv6HRDLJ9FC0hw==
X-Google-Smtp-Source: ABdhPJwtJQzYR8PxiFBA9wMHX6eviM/MV1mSOHg9ZiqJpLfPtZFIqxDSEdsoLEVCdK0d5Wgw7CRy5w==
X-Received: by 2002:aa7:9d02:: with SMTP id k2mr23687864pfp.288.1592231938656;
        Mon, 15 Jun 2020 07:38:58 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id 4sm3732181pgk.68.2020.06.15.07.38.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2020 07:38:58 -0700 (PDT)
Subject: Re: [PATCH 1/1] io_uring: fix lazy work init
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     jiufei.xue@linux.alibaba.com
References: <a75c1537cc655cb766e8e2517e18f74e13d60f1b.1592228129.git.asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <eaeab71d-6a53-95e8-03d3-5e22d7e6de49@kernel.dk>
Date:   Mon, 15 Jun 2020 08:38:57 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <a75c1537cc655cb766e8e2517e18f74e13d60f1b.1592228129.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/15/20 7:36 AM, Pavel Begunkov wrote:
> Don't leave garbage in req.work before punting async on -EAGAIN
> in io_iopoll_queue().
> 
> [  140.922099] general protection fault, probably for non-canonical
>      address 0xdead000000000100: 0000 [#1] PREEMPT SMP PTI
> ...
> [  140.922105] RIP: 0010:io_worker_handle_work+0x1db/0x480
> ...
> [  140.922114] Call Trace:
> [  140.922118]  ? __next_timer_interrupt+0xe0/0xe0
> [  140.922119]  io_wqe_worker+0x2a9/0x360
> [  140.922121]  ? _raw_spin_unlock_irqrestore+0x24/0x40
> [  140.922124]  kthread+0x12c/0x170
> [  140.922125]  ? io_worker_handle_work+0x480/0x480
> [  140.922126]  ? kthread_park+0x90/0x90
> [  140.922127]  ret_from_fork+0x22/0x30

Applied, thanks.

-- 
Jens Axboe

