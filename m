Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F16BC3F2D7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 18:19:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07FDA20656
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 18:19:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="UZSZiVIu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730879AbgCCSTc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 13:19:32 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:44491 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727070AbgCCSTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 13:19:31 -0500
Received: by mail-io1-f65.google.com with SMTP id u17so4627882iog.11
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 10:19:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nPvek0ZtRCNTYdhlOy/oh4ZQVPcCFziBknkZ1GwpcJY=;
        b=UZSZiVIuzflEmSQZMD4XoiyUvp0ADjwPChHhEM2E6Pq2eoLde85hugz1zHkWUWi3O7
         6DV9EmkMGGqbiRbl4DuvW2KNSGOvLZLwF07VVy6GE9h9dbLed9bQ4KWbxmfBpKeYVNEp
         /114VJiF0/fd3Vs3Rma/uGqdeO8/5EFjiHg4GRlA/OPFhoPgzXn7+zjCNccz2GejfWk7
         UQxbRyVTdMVsmQyKfyOaApOBQ+/nLZRj2s6yZgedgZvSMbr6hjussMHCmwHXdDHwQJ+1
         iEJa7/n9NDRFQRkKqvgsyjVJzkK3PGMbH6TdsVlpCp7r3SNPZ0lmxsU0Rb9VZnmbfbeP
         Vqew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nPvek0ZtRCNTYdhlOy/oh4ZQVPcCFziBknkZ1GwpcJY=;
        b=jEEPwTohZgJjYTTnNduHR9PHjoxh/CpTE6U+ndw8plbDZPqRW85SiOnZGBCgjUB4Qp
         QnjpZKw8E0LaUsvX/XroB+uTw9wYz3R6acuTKEMjBkD5hmuSVT3ZWVJz2NcQ1PjRuv8u
         AaEQBiHU0ppY2bbbcK+l6+LWbxr/b712rL4W0xz3XT6yZVxb2TAo39phpYcojtsiygW6
         K/6eMSAvuR9aDTCH5WVS8HuyBnzN+RwV4IXPou7PMILoEG/0Gp63g4lg2O7jCy/GvSve
         fwMfmDDe4r5jN+PI3gncScW8g8+keXfnjYUmtHs2Twwyk5dZJ5dAMxcPPyGcU1sfl+ww
         hLCw==
X-Gm-Message-State: ANhLgQ0VQ7IQlGGPB8UINczTfv/wlB0tXL9v+akaDX7aONL+r/Ee5w9b
        nKvHfSxCq23014PQYTMFTOujgg==
X-Google-Smtp-Source: ADFU+vu/2n6F/Kxthc40wuYGRz3+W2Q2JeJIi3zJZf6LK08fX7k3pJlntIPp8Kx1DFUNXDwaV91N1w==
X-Received: by 2002:a02:85e8:: with SMTP id d95mr5089329jai.92.1583259569483;
        Tue, 03 Mar 2020 10:19:29 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id x25sm5829658iol.6.2020.03.03.10.19.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Mar 2020 10:19:29 -0800 (PST)
Subject: Re: [PATCH 5.4 062/152] bcache: ignore pending signals when creating
 gc and allocator thread
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Coly Li <colyli@suse.de>, Sasha Levin <sashal@kernel.org>
References: <20200303174302.523080016@linuxfoundation.org>
 <20200303174309.501274295@linuxfoundation.org>
 <db776832-64ff-6757-de09-ced1ea8b368f@kernel.dk>
 <20200303181228.GA1014382@kroah.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <950f1d0a-6b01-6c80-8627-b1a9b2d2c89b@kernel.dk>
Date:   Tue, 3 Mar 2020 11:19:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200303181228.GA1014382@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/3/20 11:12 AM, Greg Kroah-Hartman wrote:
> On Tue, Mar 03, 2020 at 10:55:04AM -0700, Jens Axboe wrote:
>> On 3/3/20 10:42 AM, Greg Kroah-Hartman wrote:
>>> From: Coly Li <colyli@suse.de>
>>>
>>> [ Upstream commit 0b96da639a4874311e9b5156405f69ef9fc3bef8 ]
>>>
>>> When run a cache set, all the bcache btree node of this cache set will
>>> be checked by bch_btree_check(). If the bcache btree is very large,
>>> iterating all the btree nodes will occupy too much system memory and
>>> the bcache registering process might be selected and killed by system
>>> OOM killer. kthread_run() will fail if current process has pending
>>> signal, therefore the kthread creating in run_cache_set() for gc and
>>> allocator kernel threads are very probably failed for a very large
>>> bcache btree.
>>>
>>> Indeed such OOM is safe and the registering process will exit after
>>> the registration done. Therefore this patch flushes pending signals
>>> during the cache set start up, specificly in bch_cache_allocator_start()
>>> and bch_gc_thread_start(), to make sure run_cache_set() won't fail for
>>> large cahced data set.
>>
>> Please drop this one, it's being reverted in mainline.
> 
> Dropped from all trees now, thanks.

Thanks!

-- 
Jens Axboe

