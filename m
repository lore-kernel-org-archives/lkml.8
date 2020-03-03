Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DC61C3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 18:05:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43D5320836
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 18:05:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="1BVMSz5o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388197AbgCCSFQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 13:05:16 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:46956 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387409AbgCCR6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 12:58:31 -0500
Received: by mail-il1-f195.google.com with SMTP id e8so3518245ilc.13
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 09:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=G5nat7TjfwsYKukhiu6yJ6peKaEgkq8tBpj9OwyiAts=;
        b=1BVMSz5op5aH4SjFm/0AsfcMaTUcTjYDE6RYQdIeeh6bJpDEvM4lczmgOBYIgehYU6
         3wROaS6Xl/bSaiSQf1ruWmaWuuF7FyuSv7ZRENnxDrZxheVkOjHnLQ/GNJEQR6lM2VMp
         koVVCUE6aU9BJMHhq9kh3VRjDq/M2GUjetqQFWni8tEoSBPcIpKb/zSSIGmjFAU8NrFZ
         k9n15D7kPTkUMdfLUV+6X4ZmzIunA0Bdsim+Bap2Su7dPEHZWa8OxFn7XfKDdc1KYiFZ
         W681UKO6qansKW5nNWQcDpAYHf2w6E0cACcLMNMmocdS+Fkal/VR09QiiT4H4Y3s67uc
         vMJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=G5nat7TjfwsYKukhiu6yJ6peKaEgkq8tBpj9OwyiAts=;
        b=bbdRqlV2XtttjWG9s/pXgJhWT2irF70MCoWv+KcZ7ov+lfvIX4i93yqsH+Gl0P8/nG
         /3q8qiB649Wdefy7EOqolWIe5KsLoWVHLTqGvgzVoBw5hcV70kZW91BQMFnzU23tWVww
         QgtMZoCPu0lqOJzFUhtJbP+Gms3/HT/GFIFGcdkfvsmtqsVJ32VFFCy++jKQQjVl8IDS
         rrBZDbVznSkZxQvmALGVuCSUnY1yBonMaLivvOHZk+Xb2C1zlbTxNngd8cd1cyq2qywa
         Qcn4jRmuWMoUFxIyKgwIKQMxmb2b8M6MysKC5WtNsVl61bi+UZKGUhmxnkSY8GPAjsES
         YKpA==
X-Gm-Message-State: ANhLgQ3sZIyXmG2OysGETqQzfQfuin0x+YDsk8xDs/IEtonUX+ukujR5
        LAactQtc0yl6hc9dHKVGwtDDTA==
X-Google-Smtp-Source: ADFU+vtV+apP8mi6vB9ANWxLbJfeoFiJDA7yX1gYyG13Gfv6reOP037TkZVssoM3D1a1NrpJRw0hBA==
X-Received: by 2002:a92:de03:: with SMTP id x3mr5968538ilm.146.1583258310639;
        Tue, 03 Mar 2020 09:58:30 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id k16sm8140521ili.35.2020.03.03.09.58.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Mar 2020 09:58:30 -0800 (PST)
Subject: Re: [PATCH 5.5 072/176] bcache: ignore pending signals when creating
 gc and allocator thread
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, Coly Li <colyli@suse.de>,
        Sasha Levin <sashal@kernel.org>
References: <20200303174304.593872177@linuxfoundation.org>
 <20200303174312.994115258@linuxfoundation.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <24e19cd9-8eea-a41a-27f7-84ffcd872977@kernel.dk>
Date:   Tue, 3 Mar 2020 10:58:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200303174312.994115258@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/3/20 10:42 AM, Greg Kroah-Hartman wrote:
> From: Coly Li <colyli@suse.de>
> 
> [ Upstream commit 0b96da639a4874311e9b5156405f69ef9fc3bef8 ]
> 
> When run a cache set, all the bcache btree node of this cache set will
> be checked by bch_btree_check(). If the bcache btree is very large,
> iterating all the btree nodes will occupy too much system memory and
> the bcache registering process might be selected and killed by system
> OOM killer. kthread_run() will fail if current process has pending
> signal, therefore the kthread creating in run_cache_set() for gc and
> allocator kernel threads are very probably failed for a very large
> bcache btree.
> 
> Indeed such OOM is safe and the registering process will exit after
> the registration done. Therefore this patch flushes pending signals
> during the cache set start up, specificly in bch_cache_allocator_start()
> and bch_gc_thread_start(), to make sure run_cache_set() won't fail for
> large cahced data set.

Ditto this one, of course.

Did someone send this in for stable? It's not marked stable in the
original commit.

-- 
Jens Axboe

