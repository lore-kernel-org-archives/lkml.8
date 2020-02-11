Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 222F7C352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 12:48:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6C34208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 12:48:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ikWx2cpm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728732AbgBKMsE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 07:48:04 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:48282 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728680AbgBKMsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 07:48:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Wow2V2wSrgauWzev0Bhb5YG00cQ+K8D0/cORVHfU1r4=; b=ikWx2cpmEg0yhJFXb5yTZsVeJU
        tyYI7ynFJTAnWCgARyB0PPf9VAsrO1JtIBaRJMRRH87+WJC/EFv9epxiHvwnqC3qRvzdcrlQaZSt4
        6GKABv/WOPWo658JTIIpHGiwXtwcjDp+42lMyAm86hb+eJctv1Sye87AxwXSxMY+KRghzYI5ND6jh
        /NVyTeKTl3+Iutif4D9yGjArftJkWoTpKijX3AcddkrjZUX+u6Ro8wpsnMhEFnAeMRQrvsjuL5qCZ
        9svaqcTh58JpfJH3PRLx6XmGyxia4BR9qZs6AyPDngtuy6wqD13q8p9w8MK7HtT0xmDbCTRtimPjJ
        eB9KMy+w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j1UxH-0004ft-ID; Tue, 11 Feb 2020 12:47:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 447A030793E;
        Tue, 11 Feb 2020 13:46:05 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EE53A2B88D75F; Tue, 11 Feb 2020 13:47:53 +0100 (CET)
Date:   Tue, 11 Feb 2020 13:47:53 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Marco Elver <elver@google.com>
Cc:     Qian Cai <cai@lca.pw>, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] locking/osq_lock: annotate a data race in osq_lock
Message-ID: <20200211124753.GP14914@hirez.programming.kicks-ass.net>
References: <20200211040651.1993-1-cai@lca.pw>
 <CANpmjNPWCu+w3O8cg++X4=viVFsWNehTXzTuqbwV8-DcXXpFng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNPWCu+w3O8cg++X4=viVFsWNehTXzTuqbwV8-DcXXpFng@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2020 at 11:16:05AM +0100, Marco Elver wrote:
> On Tue, 11 Feb 2020 at 05:07, Qian Cai <cai@lca.pw> wrote:
> >
> > prev->next could be accessed concurrently as noticed by KCSAN,
> >
> >  write (marked) to 0xffff9d3370dbbe40 of 8 bytes by task 3294 on cpu 107:
> >   osq_lock+0x25f/0x350
> >   osq_wait_next at kernel/locking/osq_lock.c:79
> >   (inlined by) osq_lock at kernel/locking/osq_lock.c:185
> >   rwsem_optimistic_spin
> >   <snip>
> >
> >  read to 0xffff9d3370dbbe40 of 8 bytes by task 3398 on cpu 100:
> >   osq_lock+0x196/0x350
> >   osq_lock at kernel/locking/osq_lock.c:157
> >   rwsem_optimistic_spin
> >   <snip>
> >
> > Since the write only stores NULL to prev->next and the read tests if
> > prev->next equals to this_cpu_ptr(&osq_node). Even if the value is
> > shattered, the code is still working correctly. Thus, mark it as an
> > intentional data race using the data_race() macro.
> 
> I have said this before: we're not just guarding against load/store
> tearing, although on their own, they make it deceptively easy to
> reason about data races.
> 
> The case here seems to be another instance of a C-CAS, to avoid
> unnecessarily dirtying a cacheline.
> 
> Here, the loop would make me suspicious, because a compiler could
> optimize out re-loading the value. Due to the smp_load_acquire,
> however, at the least we have 1 implied compiler barrier in this loop
> which means that will likely not happen.

The loop has cpu_relax() (as any spin loop should have), that implies a
compiler barrier() and should disallow the compiler from being funny.

That said; I feel it would be very good to mandate a comment with every
use of data_race(), just like we mandate a comment with memory barriers.
This comment can then explain why the data_race() annotation is correct.
