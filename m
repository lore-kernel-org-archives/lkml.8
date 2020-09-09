Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39A2EC2D0E1
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 21:52:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED89020C09
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 21:52:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uhJlBGKa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728442AbgIIVwR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 17:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726226AbgIIVwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 17:52:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E40DBC061573
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 14:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9AelBTRGGkaycQWCIOP8/Ny69L3JnwJ2r2LMDHo8IXc=; b=uhJlBGKaw4qHaktb6IwOYqmKKP
        fjkviTcwwyFqfqZ3qvJZ88vgCUgR5rDFTt6bStcnT1bXx3rH9LlCWapM1lQ3hdU+/cNPY2Qo2jFaX
        LWCLK6t49O/+R09xAutwb83n97LxQmkPai5qBqGobBdwOxN1g/gDe/diTqFrGjw5vK2kQEeYvRVpg
        qJ4EMLxgqEQCIpHJJ+pdvAO1K3RJxBRvuQDqkXOrbbm4KhMpyJ4+bZD6PR4dxTA4DED/srM96Q7MI
        f7OUL8bQR2yJPtremyonRj/QIN0GHlKD3x2X71y5Samsejj6VTX08qM2JskDow2G9rVdd81fIp96e
        1ZW5+piw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kG80f-0000Zc-4A; Wed, 09 Sep 2020 21:52:09 +0000
Date:   Wed, 9 Sep 2020 22:52:09 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Chris Down <chris@chrisdown.name>
Cc:     Vlastimil Babka <vbabka@suse.cz>, zangchunxin@bytedance.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: Re: [PATCH v2] mm/vmscan: fix infinite loop in drop_slab_node
Message-ID: <20200909215209.GP6583@casper.infradead.org>
References: <20200909152047.27905-1-zangchunxin@bytedance.com>
 <16906d44-9e3c-76a1-f1a9-ced61e865467@suse.cz>
 <20200909214724.GA1577471@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200909214724.GA1577471@chrisdown.name>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 09, 2020 at 10:47:24PM +0100, Chris Down wrote:
> Vlastimil Babka writes:
> > - Exit also on other signals such as SIGABRT, SIGTERM? If I write to drop_caches
> > and think it's too long, I would prefer to kill it by ctrl-c and not just kill
> 
> Oh dear, fatal_signal_pending() doesn't consider cases with no more
> userspace instructions due to SIG_DFL on TERM/INT etc, that seems misleading
> :-( I had (naively) believed it internally checks the same set as
> TASK_KILLABLE.
> 
> Chuxin, Muchun, can you please make it work using TASK_KILLABLE in a similar
> way to how schedule_timeout_killable and friends do it instead, so that
> other signals will be caught?

You're mistaken.

        if (sig_fatal(p, sig) &&
            !(signal->flags & SIGNAL_GROUP_EXIT) &&
            !sigismember(&t->real_blocked, sig) &&
            (sig == SIGKILL || !p->ptrace)) {
...
                                sigaddset(&t->pending.signal, SIGKILL);

static inline int __fatal_signal_pending(struct task_struct *p)
{
        return unlikely(sigismember(&p->pending.signal, SIGKILL));
}

