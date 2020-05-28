Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51DF7C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 19:48:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A040207D3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 19:48:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="tqHUV/QE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406783AbgE1Tsj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 15:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406704AbgE1Tse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 15:48:34 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2E30C08C5C6
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 12:48:33 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id l10so467669wrr.10
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 12:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2+YFw/wWl/gn1xFnRRoYscp8dj86Zd6xiRRZw5MlcAI=;
        b=tqHUV/QEgE202z+GHgPg+fGlRS0xZIz4uyNfmy01XYON7v71D5ZVVMVzwMsmXRUNCI
         +wNnZXjkMRgh04H+0uTAJCwfBZkoEkVZ2TXn4uuWhvn/5WhRwgj7zAmDEeqDyjIBwvFQ
         0yUVIbbFUXGJfXQzBRIqhjggve4tOXbOWWNl4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2+YFw/wWl/gn1xFnRRoYscp8dj86Zd6xiRRZw5MlcAI=;
        b=AncZZmvPRD6ReOBH5fOSSOEP/bPq0cDXlyn2Rn/ZqSvSMFevGD8ndxpw1zxzdhCWwx
         d8v0+simuk34OtTAEMxECKe27yv71g/kA3R940JtRXynkQWatii8LCKtAkBTkNl2sMSO
         y6Aog69vAiVB7dZZpMLQUAph3QtKeYfdpOhnuVAu4eLa7gIAbwqZI6TIbTCGLdW2HTSv
         k7Vei0zvPJQNfju9LJJKG+PK/o+qzNAGvmoLoIXi9UFuIfHfFx+Z0x6ZyqLk8J125f+M
         ohCj+ai5lOP/t3882DMf4UaL7QFzH3uB0ZpdolsEwZQ8OZ9VB9+y7Lgblf0jKMweVwGl
         uIsA==
X-Gm-Message-State: AOAM531ZC5KYPHTNVJaegU6qEbCPz2qeRVUIZ9PAqDRiuAIUg9epmQuf
        UYivvW/za9m/jkp8PHzgmZE7OA==
X-Google-Smtp-Source: ABdhPJwbCOVC5ocul7Wfmi+oZbpyKXkSi2NcpQnG2t0XZ9mSJ4faNZIYvWaeTEZWugouk/oUeG8yXQ==
X-Received: by 2002:adf:a283:: with SMTP id s3mr4706803wra.147.1590695312615;
        Thu, 28 May 2020 12:48:32 -0700 (PDT)
Received: from localhost ([2a01:4b00:8432:8a00:56e1:adff:fe3f:49ed])
        by smtp.gmail.com with ESMTPSA id l204sm8225768wmf.19.2020.05.28.12.48.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 12:48:32 -0700 (PDT)
Date:   Thu, 28 May 2020 20:48:31 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, Michal Hocko <mhocko@kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH] mm, memcg: reclaim more aggressively before high
 allocator throttling
Message-ID: <20200528194831.GA2017@chrisdown.name>
References: <20200520143712.GA749486@chrisdown.name>
 <CALvZod7rSeAKXKq_V0SggZWn4aL8pYWJiej4NdRd8MmuwUzPEw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CALvZod7rSeAKXKq_V0SggZWn4aL8pYWJiej4NdRd8MmuwUzPEw@mail.gmail.com>
User-Agent: Mutt/1.14.2 (2020-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shakeel Butt writes:
>What was the initial reason to have different behavior in the first place?

This differing behaviour is simply a mistake, it was never intended to be this 
deviate from what happens elsewhere. To that extent this patch is as much a bug 
fix as it is an improvement.

>>  static void high_work_func(struct work_struct *work)
>> @@ -2378,16 +2384,20 @@ void mem_cgroup_handle_over_high(void)
>>  {
>>         unsigned long penalty_jiffies;
>>         unsigned long pflags;
>> +       unsigned long nr_reclaimed;
>>         unsigned int nr_pages = current->memcg_nr_pages_over_high;
>
>Is there any benefit to keep current->memcg_nr_pages_over_high after
>this change? Why not just use SWAP_CLUSTER_MAX?

I don't feel strongly either way, but current->memcg_nr_pages_over_high can be 
very large for large allocations.

That said, maybe we should just reclaim `max(SWAP_CLUSTER_MAX, current - high)` 
for each loop? I agree that with this design it looks like perhaps we don't 
need it any more.

Johannes, what do you think?
