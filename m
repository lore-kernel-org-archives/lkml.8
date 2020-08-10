Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6350AC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 17:50:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C55720791
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 17:50:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="lf4Z8/x6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727918AbgHJRuj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 13:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727003AbgHJRuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 13:50:37 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA42CC061756
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 10:50:36 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id r11so5955183pfl.11
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 10:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KCbZaA2H4gGqQIl7shuSw8Q2zg/8QxZHjSgK2lY23U4=;
        b=lf4Z8/x61x8hstJllWMdWgDivN0szStCTsr10NgTwRvrfLe/GFeTVyC9gtQBk1tKP0
         jHXSY9/ck8F+Yn5/Q2QpHC4qieLwewS3ogyL3T7dyHWbn1Fs0aB7d8VObfIpKOvsej4I
         3+JmUWtymVuGSKfm7NQSTf3UIiQ1H0OEsds3zUKPg+IuJWCqc97PzHHhBoFNBAvt6okK
         Rnb8WJdFbY1GHrKcyav5ph0ZXWBYGgRfd/5RKstm5Fm7juT/cRbbY/7T3czKtSeTkZ45
         sVwxgzwowa3lumTTVx84B38OIzqFWIWNtu2VLA809BDOptCs8KE+6dBb8xmL/fRCuA4B
         b/tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KCbZaA2H4gGqQIl7shuSw8Q2zg/8QxZHjSgK2lY23U4=;
        b=oP3loaGaJy3iFJUbsoBAob+Gf9wKvvXq1BskvhyCAXrTLRDsedjnuLUriBWSWQoBE3
         CZYmIlcoYzV6rDz88Nl+foUGQ347S3wQQD/9vBHH0AJmlxuph1k+wv+wbZqymX8F4NwK
         XKJmSB/3r2VsNNWPOvJbkyuM73BMEygKfDgD30mgTAvgiWG6QhjdXK91JupWnu+/ioyC
         UgdM/dz9ZK7ErvoRYO0lp7DNOiN8PEIR2kaoGPCEQWNNhj/7cyUmLvOik3vyU+qT8Y9Z
         5sH7u7w+buxbrX9mulAfOQIe9RL0wjNbws+Hki9BMvG6maFTcgLhx5coIqurhJERd2vx
         H0+w==
X-Gm-Message-State: AOAM530JbxX84w1+5N3bRuDF5mvyKVYLg+EeVuH/ZfAKMj5+tRiHHKvl
        2fsEwLEscA1bsZj4PT410ZiV2A==
X-Google-Smtp-Source: ABdhPJwiA6SSdo/T7MTHmUtxtnsZ23rKpLiJmI0TswWscbOsqjpnTSbRfknrF1/cU7UM9SPqQ/mANQ==
X-Received: by 2002:aa7:9f92:: with SMTP id z18mr2114507pfr.260.1597081836160;
        Mon, 10 Aug 2020 10:50:36 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id k23sm18703716pgb.92.2020.08.10.10.50.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Aug 2020 10:50:35 -0700 (PDT)
Subject: Re: [PATCH] kernel: update callers of task_work_add() to use
 TWA_RESUME
From:   Jens Axboe <axboe@kernel.dk>
To:     peterz@infradead.org
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>
References: <10debfb3-25f2-20ed-d4f3-1d95ba4c2129@kernel.dk>
 <20200810114407.GT2674@hirez.programming.kicks-ass.net>
 <21d27dfe-91f8-ebc3-6390-a0345603ac28@kernel.dk>
Message-ID: <2aeafd33-7e26-cdfc-9a4c-98965faeccfb@kernel.dk>
Date:   Mon, 10 Aug 2020 11:50:33 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <21d27dfe-91f8-ebc3-6390-a0345603ac28@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/10/20 8:37 AM, Jens Axboe wrote:
> On 8/10/20 5:44 AM, peterz@infradead.org wrote:
>> On Sat, Aug 08, 2020 at 03:43:50PM -0600, Jens Axboe wrote:
>>> Any pre-existing caller of this function uses 'true' to signal to use
>>> notifications or not, but we now also have signaled notifications.
>>> Update existing callers that specify 'true' for notify to use the
>>> updated TWA_RESUME instead.
>>>
>>> This was noted in the original commit as well:
>>>
>>> e91b48162332 ("task_work: teach task_work_add() to do signal_wake_up()")
>>>
>>> Cc: Oleg Nesterov <oleg@redhat.com>
>>> Cc: Peter Zijlstra <peterz@infradead.org>
>>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>>>
>>
>> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>>
>> How do you want to route this?
> 
> I don't really care, as I have no dependencies on it. Feel free to queue
> it up! It's just sitting at the top of my io_uring branch right now,
> but that's because I had to stuff it somewhere. Easy to pop off the top.

FWIW, I dropped this from my branch, so would be great if you or Oleg
could push this one upstream.

-- 
Jens Axboe

