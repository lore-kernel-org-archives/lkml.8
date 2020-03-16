Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C3B6C0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 23:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C59920663
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 23:47:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CognDl13"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732947AbgCPXrH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 19:47:07 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:38502 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732900AbgCPXrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 19:47:07 -0400
Received: by mail-ot1-f67.google.com with SMTP id t28so17165310ott.5
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 16:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aVXf02gC+H4hnLytwgf022jEbvbc1T3drxGD+ZV/fXY=;
        b=CognDl138DrQV5mRCWSZeKD5h8R45GijjA7lHIVKHSd3M2gwoWTuh1CcWFxzJggwT9
         +mbFzZina4y6S4NrXLQtdNputZ25VHTvUZvB7PuH8rhkzW+olXLws4Z5JEsrXpgZfghh
         Q5ewT2IWI6/Qc4K8qvjubZSvWQN7lfmzEv3dch7MOqipMe7tm/IgsUgUSKKPoW1pTniu
         CaxxmKPSIIxvIj3Q/XUIfSEDQhibdE0swIgP8XyaUOWD4Exih2jFC98zL4qtxgiqWHxZ
         ufbESvKXQ695ue4yzniVnGXSGcrOVedTcuuISqN6pfzXeBMLpy3wjLO4n5wgoeUzdTWF
         la3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aVXf02gC+H4hnLytwgf022jEbvbc1T3drxGD+ZV/fXY=;
        b=FaUOulssSeJOqvBLSdq8Kn5+Izp582ihVS/jkqrLssz0MmYxf5FfZ9ljKsiQUVfTxX
         Tgw0MZE9fu60GzC9BXuyb31rQqRx29dwkHtNuFZu/ThifX7T5QfUXyy/F6+MIzq8gwr8
         I5X/mIQdYMEgvbi95VwyIH30r0BzMr1tOfSC2BGpGU7SQft4mRReKuDrw2fRenceTycH
         QAOVgRGkUOwGvviQLmK5WcyU7rrLZhDeEW22e5e+FHNgZyAJTjEJCatYBn/XhZJZIld+
         /dCZvczGtpZ0S1CHIRqGan714xp3jPgYSG81kGBBs/M3jPScIlMQ5icLptlnj6gtybTt
         fgqQ==
X-Gm-Message-State: ANhLgQ1SfcWazP+2OfQdDTuvht8yDjQuxyidL8+hT0SacZeBaBFITqBO
        Ko+mCUGGibIbCfBfP6qwQrHL1AoCGkUX2gLk4/hO96CbHcY=
X-Google-Smtp-Source: ADFU+vtLX9oIptyOrpGbEjvdyuNKgTeAthRn4FGLayQM9052N1kUTixf37hS0KhTcqxCa/Be6gmO09gRriEIpnqMuwI=
X-Received: by 2002:a9d:6c99:: with SMTP id c25mr1407317otr.124.1584402425776;
 Mon, 16 Mar 2020 16:47:05 -0700 (PDT)
MIME-Version: 1.0
References: <1584397455-28701-1-git-send-email-yang.shi@linux.alibaba.com>
In-Reply-To: <1584397455-28701-1-git-send-email-yang.shi@linux.alibaba.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 16 Mar 2020 16:46:54 -0700
Message-ID: <CALvZod72O-9Qm5bvr2MWKPRiDV3oFCmujawr28DnsSdJx+PmjQ@mail.gmail.com>
Subject: Re: [v2 PATCH 1/2] mm: swap: make page_evictable() inline
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 16, 2020 at 3:24 PM Yang Shi <yang.shi@linux.alibaba.com> wrote:
>
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
>         mainline        w/ inline fix
>           150MB            154MB
>
> With this patch the throughput gets 2.67% up.  The data with using
> smp_mb__after_atomic() is showed in the following patch.
>
> Fixes: 9c4e6b1a7027 ("mm, mlock, vmscan: no more skipping pagevecs")
> Cc: Shakeel Butt <shakeelb@google.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>


So, I tested on a real machine with limiting the 'dd' on a single node
and reading 100 GiB sparse file (less than a single node). I just ran
a single instance to not cause the lru lock contention. The cmd I used
is "dd if=file-100GiB of=/dev/null bs=4k". I ran the cmd 10 times with
drop_caches in between and measured the time it took.

Without patch: 56.64143 +- 0.672 sec

With patches: 56.10 +- 0.21 sec

Reviewed-and-Tested-by: Shakeel Butt <shakeelb@google.com>
