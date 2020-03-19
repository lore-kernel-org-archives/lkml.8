Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6CDBC4332E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 14:02:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD855208D6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 14:02:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="q7UfSe/x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727414AbgCSOCA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 10:02:00 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:40430 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726998AbgCSOCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 10:02:00 -0400
Received: by mail-qt1-f193.google.com with SMTP id i9so1197390qtw.7
        for <linux-kernel@vger.kernel.org>; Thu, 19 Mar 2020 07:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zI26wqa5aEpYDkabLs6lF79jALpaQpgQCRaGe0rAb3k=;
        b=q7UfSe/xw2kxQTUEkAej8462MqfU323vE3e2pP+VlGXnZwuJVSdhYFj+Yj/cawOF28
         iE5GnZb/gHfvtBqXJTzG1sBnGIu/Si9ClU+bvRba3yM1OxXUylBhFGR8yb1HvgqM2W+T
         xlelStGIOPNQgDQIeDixYPKp1rbY8vyVGaQKeE9nANjtyoJFq8JDSKyvRhP6JtUcKIbR
         xVHLZdP6F/D80hPJpeJBLFvX0KgWBepwVk9njKdFvp37BmXztXGBjaNzs7ARXwlRUd7N
         HNDAmamF5fMBk7QYpAjQA8ML7Q9YyzIJG5t8ttvxIsuisO3eL+PGgPJG6Mjjx/tZkuWh
         pp8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zI26wqa5aEpYDkabLs6lF79jALpaQpgQCRaGe0rAb3k=;
        b=fqBUPnQHCU9ldSZfy9HUpPA6LfhsVK2gF5KYYsuLPX+lZnF0pcIgDldnImmSAJKiKO
         sKAbAI5hKuwtDMPtJbvprp6Zs+PdBIBVDFlw1AlHSBfkvpqnT7ub3KkQVaVp5tysRhgC
         b/WXPvLFnWJpRZ1nnr4/5Zv4anQiDGE1hCqVj7w0X8MJkscgwsGknRUFlnCBoBphrnML
         ditn3R505CEAZNFgMLRRJ+/AO2/p4euWFRJUBgiCT5TMXSPiMJvpVoUIet76r/uKJ2zA
         XVhwpT2sMukPcXg2D4YUzB24aoAhEdsewpjattiyCsRk7KpqnG8L6+u1dJF2JttTL3VE
         oLQw==
X-Gm-Message-State: ANhLgQ0z582XmthfWGEdvZf1O6F95E5UtgTszrEwsVgyvZcbVAbNSTff
        Q6JOUVNLV7U2FWc/J4g1A9Z/jw==
X-Google-Smtp-Source: ADFU+vvqSwO6Laoiqlw0Vb0ZWC3d9hwN2kFyKBXlgShZonLtCPb91pyqHWP2V0+l5Vq6xXh4LGz3sA==
X-Received: by 2002:aed:2b83:: with SMTP id e3mr3004742qtd.361.1584626517415;
        Thu, 19 Mar 2020 07:01:57 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:a9a9])
        by smtp.gmail.com with ESMTPSA id f16sm1653251qtk.61.2020.03.19.07.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 07:01:56 -0700 (PDT)
Date:   Thu, 19 Mar 2020 10:01:54 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     shakeelb@google.com, vbabka@suse.cz, willy@infradead.org,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [v4 PATCH 1/2] mm: swap: make page_evictable() inline
Message-ID: <20200319140154.GB187654@cmpxchg.org>
References: <1584500541-46817-1-git-send-email-yang.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1584500541-46817-1-git-send-email-yang.shi@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 18, 2020 at 11:02:20AM +0800, Yang Shi wrote:
> When backporting commit 9c4e6b1a7027 ("mm, mlock, vmscan: no more
> skipping pagevecs") to our 4.9 kernel, our test bench noticed around 10%
> down with a couple of vm-scalability's test cases (lru-file-readonce,
> lru-file-readtwice and lru-file-mmap-read).  I didn't see that much down
> on my VM (32c-64g-2nodes).  It might be caused by the test configuration,
> which is 32c-256g with NUMA disabled and the tests were run in root memcg,
> so the tests actually stress only one inactive and active lru.  It
> sounds not very usual in mordern production environment.
> 
> That commit did two major changes:
> 1. Call page_evictable()
> 2. Use smp_mb to force the PG_lru set visible
> 
> It looks they contribute the most overhead.  The page_evictable() is a
> function which does function prologue and epilogue, and that was used by
> page reclaim path only.  However, lru add is a very hot path, so it
> sounds better to make it inline.  However, it calls page_mapping() which
> is not inlined either, but the disassemble shows it doesn't do push and
> pop operations and it sounds not very straightforward to inline it.
> 
> Other than this, it sounds smp_mb() is not necessary for x86 since
> SetPageLRU is atomic which enforces memory barrier already, replace it
> with smp_mb__after_atomic() in the following patch.
> 
> With the two fixes applied, the tests can get back around 5% on that
> test bench and get back normal on my VM.  Since the test bench
> configuration is not that usual and I also saw around 6% up on the
> latest upstream, so it sounds good enough IMHO.
> 
> The below is test data (lru-file-readtwice throughput) against the v5.6-rc4:
> 	mainline	w/ inline fix
>           150MB            154MB
> 
> With this patch the throughput gets 2.67% up.  The data with using
> smp_mb__after_atomic() is showed in the following patch.
> 
> Shakeel Butt did the below test:
> 
> On a real machine with limiting the 'dd' on a single node and reading 100 GiB
> sparse file (less than a single node).  Just ran a single instance to not
> cause the lru lock contention. The cmdline used is
> "dd if=file-100GiB of=/dev/null bs=4k".  Ran the cmd 10 times with drop_caches
> in between and measured the time it took.
> 
> Without patch: 56.64143 +- 0.672 sec
> 
> With patches: 56.10 +- 0.21 sec
> 
> Fixes: 9c4e6b1a7027 ("mm, mlock, vmscan: no more skipping pagevecs")
> Cc: Matthew Wilcox <willy@infradead.org>
> Reviewed-and-Tested-by: Shakeel Butt <shakeelb@google.com>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
