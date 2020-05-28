Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E8BDC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 21:14:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 391082075F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 21:14:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="tVtux6su"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407547AbgE1VOs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 17:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407489AbgE1VOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 17:14:45 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43C28C08C5C6
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 14:14:44 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id l10so815959wrr.10
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 14:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Md5HCLgP2FEvxYLu9x06BehC1qjXovJHaXEUB6IGroo=;
        b=tVtux6suf22nedoh998nr2nUX5JUphMEZFx1Mo5ltS8yQR6kIabLVyb+3YEpbDz5OG
         vQXWDGS1o1GyJcdyLG/lH+pz8BSLyVItVBFyS1IDgO033yA5fsTuAysRfzYRrHiwtbxP
         t9F33VrCQRi12tf3yFgiOPMHjDXOjcKQ8rFW4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Md5HCLgP2FEvxYLu9x06BehC1qjXovJHaXEUB6IGroo=;
        b=dJMUcI8lfWO5Qc8cCFOUTL7ECoCv/EenZk/L6AyUqwkOnOPLwFtnMngOaCOoZnGpTb
         GzxTcEuGyMVDeope4IG6xIOoqmNENojf0Wp2deDxD2jqB7fljxmNuGd/WYFoxo9Ek9La
         bOquYQK1jci76xt9O/mpDPgG5HJHYOoXymFBo0WzuL5lz3U5AD06UpS23DGswsv38/MC
         Uh4miMKWYXDFuTL0rx8Nx7ItRg6WNe0pQXKQeyBM/6dzDhNU4VOIRUgwKnAtIzTOqC9p
         WniP3SDiq+cbJI03xeBSJDayCG6Zvi1RmOu8A8usu3GB7Eb1T/ed55CLOvcJHCR92Lfc
         e94A==
X-Gm-Message-State: AOAM532Qj0xqsCoc6OV/y6DuJ89+0NabTdHTHUOTAaqIMxJjwJvRQqTh
        34dz21MMN6F2A2YHrD2C6Z9eGLCnS+uCNym+
X-Google-Smtp-Source: ABdhPJy9x8tatjpCo/n0+suEu+dHg+NV6QVGsjjs9Au1vBlu6M/wADBmns2Aje7ULPrXqU9Km8vpNQ==
X-Received: by 2002:adf:ed51:: with SMTP id u17mr4889766wro.285.1590700482631;
        Thu, 28 May 2020 14:14:42 -0700 (PDT)
Received: from localhost ([2a01:4b00:8432:8a00:56e1:adff:fe3f:49ed])
        by smtp.gmail.com with ESMTPSA id k26sm8205312wmi.27.2020.05.28.14.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 14:14:41 -0700 (PDT)
Date:   Thu, 28 May 2020 22:14:41 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Michal Hocko <mhocko@kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH] mm, memcg: reclaim more aggressively before high
 allocator throttling
Message-ID: <20200528211441.GA3410@chrisdown.name>
References: <20200520143712.GA749486@chrisdown.name>
 <CALvZod7rSeAKXKq_V0SggZWn4aL8pYWJiej4NdRd8MmuwUzPEw@mail.gmail.com>
 <20200528194831.GA2017@chrisdown.name>
 <20200528202944.GA76514@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200528202944.GA76514@cmpxchg.org>
User-Agent: Mutt/1.14.2 (2020-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Johannes Weiner writes:
>> I don't feel strongly either way, but current->memcg_nr_pages_over_high can
>> be very large for large allocations.
>>
>> That said, maybe we should just reclaim `max(SWAP_CLUSTER_MAX, current -
>> high)` for each loop? I agree that with this design it looks like perhaps we
>> don't need it any more.
>>
>> Johannes, what do you think?
>
>How about this:
>
>Reclaim memcg_nr_pages_over_high in the first iteration, then switch
>to SWAP_CLUSTER_MAX in the retries.
>
>This acknowledges that while the page allocator and memory.max reclaim
>every time an allocation is made, memory.high is currently batched and
>can have larger targets. We want the allocating thread to reclaim at
>least the batch size, but beyond that only what's necessary to prevent
>premature OOM or failing containment.
>
>Add a comment stating as much.
>
>Once we reclaim memory.high synchronously instead of batched, this
>exceptional handling is no longer needed and can be deleted again.
>
>Does that sound reasonable?

That sounds good to me, thanks. I'll change that in v2 soonish and update the 
changelog.
