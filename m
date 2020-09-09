Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F08F5C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 21:56:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A905821D82
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 21:56:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="o7niafP1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727900AbgIIV4X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 17:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbgIIV4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 17:56:20 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BF9EC061573
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 14:56:19 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id k25so3266178qtu.4
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 14:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FNykoWm0eKUq3lNLrS/20TUqU1lX96BWDe+AeQ3hX4M=;
        b=o7niafP1tG73NDS6Rak5c4MU8M6FuPVOxUkR2TgX6qIQZIo3PV1ANkqmjY4edFvaOu
         AVuGmflvLPrQXIpQY8Xs5atmd6KxCQvkHrBZEQpFPr0PZy50PkhgXGh6cBogYqgTIwfI
         LzbvJlocqjOcF4mUju0RgmYUBzE+MaArTTMgY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FNykoWm0eKUq3lNLrS/20TUqU1lX96BWDe+AeQ3hX4M=;
        b=mVd3//0xG72Ll2W90gG55M6uvROsn/T3VkKuJuOsB+8QlHVp5q8cHYZB2Zl0bDxjuc
         X6USA3NGsszOS1P9GIdIMvn2GRDwuixN64G/kLEW4xsE/GTj5rnW091QVUpjG/TABw/K
         CXK2Ya1hcJyWZbtt/827HUwjS/l4SljtoHeKuHLn/KabPLMJjutFZuRpYxJ14K0GKUFy
         sLYN7NzUwMEWbLyziRkZBHNCOZEBKLSe5Lx47dRCNloHvgjRvp4Uv2kHxtL42shGKu94
         exM+dMf8EXGPpl/BfGfZbA0subj0MsPqfov/x6MUQ/j3eJyv6ECBrXs87LxyT6vxdQfx
         cgbA==
X-Gm-Message-State: AOAM532F/QDi/UsUZQvcGEZKLKz0g/tn7PyCz7L2WHbE/eTdILxeTAT0
        rHvttlXHguFiZMmJuBx97wGjfj/hHJOm3/ke
X-Google-Smtp-Source: ABdhPJz6L+hKjWQOSF4yQSfpykqjuYZnU31TfIhXJAUlxm+lqpiInC0VLpBZz1mEpp5VKCSc6yrCWw==
X-Received: by 2002:ac8:4e09:: with SMTP id c9mr3724070qtw.347.1599688578484;
        Wed, 09 Sep 2020 14:56:18 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:16fd])
        by smtp.gmail.com with ESMTPSA id x49sm4625877qtc.94.2020.09.09.14.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 14:56:17 -0700 (PDT)
Date:   Wed, 9 Sep 2020 22:56:16 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>, zangchunxin@bytedance.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: Re: [PATCH v2] mm/vmscan: fix infinite loop in drop_slab_node
Message-ID: <20200909215616.GA1609213@chrisdown.name>
References: <20200909152047.27905-1-zangchunxin@bytedance.com>
 <16906d44-9e3c-76a1-f1a9-ced61e865467@suse.cz>
 <20200909214724.GA1577471@chrisdown.name>
 <20200909215209.GP6583@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200909215209.GP6583@casper.infradead.org>
User-Agent: Mutt/1.14.6 (2020-07-11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox writes:
>On Wed, Sep 09, 2020 at 10:47:24PM +0100, Chris Down wrote:
>> Vlastimil Babka writes:
>> > - Exit also on other signals such as SIGABRT, SIGTERM? If I write to drop_caches
>> > and think it's too long, I would prefer to kill it by ctrl-c and not just kill
>>
>> Oh dear, fatal_signal_pending() doesn't consider cases with no more
>> userspace instructions due to SIG_DFL on TERM/INT etc, that seems misleading
>> :-( I had (naively) believed it internally checks the same set as
>> TASK_KILLABLE.
>>
>> Chuxin, Muchun, can you please make it work using TASK_KILLABLE in a similar
>> way to how schedule_timeout_killable and friends do it instead, so that
>> other signals will be caught?
>
>You're mistaken.
>
>        if (sig_fatal(p, sig) &&
>            !(signal->flags & SIGNAL_GROUP_EXIT) &&
>            !sigismember(&t->real_blocked, sig) &&
>            (sig == SIGKILL || !p->ptrace)) {
>...
>                                sigaddset(&t->pending.signal, SIGKILL);
>
>static inline int __fatal_signal_pending(struct task_struct *p)
>{
>        return unlikely(sigismember(&p->pending.signal, SIGKILL));
>}

Oh great, that makes things way easier. Thanks!
