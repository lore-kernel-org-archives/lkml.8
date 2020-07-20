Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 733FDC433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:36:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50E3820734
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:36:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="IJM4F9kE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388890AbgGTQgr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 12:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388787AbgGTQgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 12:36:43 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12D4EC0619D2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 09:36:43 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id t4so13870304iln.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 09:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gBnhc9kYq0E6+vqUJS1jDU/1F1sS+K3Lh6YLjAXrPIA=;
        b=IJM4F9kEuWWZ9HWNrJw+/v44b3wlVooucvBHu8ZYu8BUTGD5nEtsKNyzUXoTwNSTEY
         +bYLs/oEfkJ7TI+wg3wqDbe/+j2D8FZZ+9w2kK7V4HwSe+AzjwElQJfRiaflWvmPXZgr
         bXgpTKOrNGv2fnoAHU35bus/WtnzUUcC7j8iH6Sp3HbSK+FymkGn0BgI/YffgYLJR0ox
         sBgfdmHN6KCjmzreGDBnzbbO3cvKE4LDgna3CAHCOSG27AtgoCLXhS4OGzLlFFlF/CaO
         SvOcMUX2AWEnvyi4W69b4nj3DC+Yr5/MXaC6sOpNKcUKRHLr/ofvZzc87WX/VE814Tgs
         C6qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gBnhc9kYq0E6+vqUJS1jDU/1F1sS+K3Lh6YLjAXrPIA=;
        b=Z4cy62n6y0tmRhaPosCpRu0AVhj56AYLFdagXm3KBvJsUH9MjyF9c29UzFrAVaQqfe
         JDpdGwmsO1KiZupb24Qus1BfgPwb6/xzwmLdHYi0oekpDT8SZmvM8keD3Q66kLenUJRu
         v/HF+BSMFklNCiXygCwOLoN7bOb6oAhVgsmSSne/w4LqctzZQJMsIGIO4W1SkBiwX4bm
         1wqHWffqU1ddOEEUZxTxqWAICFbf/+SJHQueqhS3qbrESnQn0R2iL/OILtGHfxAJh/vL
         xHTsmHMIOx0jYnW0c+pPic0f8Uet9+lgeY4nogBeSRviPj0u7JqkBgPf4xLbR+ushrnA
         iFKg==
X-Gm-Message-State: AOAM532ER2iIy5VSHIlTarKCKo3mauGR7ih8vqMvc7SefpEhaK+VeUtT
        j/iAB+UkPm8Ncc+k2R3DK9osQwleXBnLhg==
X-Google-Smtp-Source: ABdhPJxukhVb2zn3N2KCfVMsxmqpS2RZySUveN6hPJ2GEvDdyWHhLuaqHOHq9wpkvxNqmBkiJFxtrA==
X-Received: by 2002:a92:7306:: with SMTP id o6mr23184732ilc.90.1595263002078;
        Mon, 20 Jul 2020 09:36:42 -0700 (PDT)
Received: from [192.168.1.58] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id w15sm9315257ila.65.2020.07.20.09.36.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jul 2020 09:36:41 -0700 (PDT)
Subject: Re: io_uring vs in_compat_syscall()
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, io-uring@vger.kernel.org
References: <20200720061046.GA10678@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ceb21006-26d0-b216-84a9-5da0b89b5fbf@kernel.dk>
Date:   Mon, 20 Jul 2020 10:36:40 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200720061046.GA10678@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/20/20 12:10 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> I just found a (so far theoretical) issue with the io_uring submission
> offloading to workqueues or threads.  We have lots of places using
> in_compat_syscall() to check if a syscall needs compat treatmenet.
> While the biggest users is iocttl(), we also have a fair amount of
> places using in_compat_task() in read and write methods, and these
> will not do the wrong thing when used with io_uring under certain
> conditions.  I'm not sure how to best fix this, except for making sure
> in_compat_syscall() returns true one way or another for these cases.

We can probably propagate this information in the io_kiocb via a flag,
and have the io-wq worker set TS_COMPAT if that's the case.

-- 
Jens Axboe

