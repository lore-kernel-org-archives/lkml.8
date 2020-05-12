Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 404EFCA90AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 19:08:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C2B420731
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 19:08:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qKZiXMSg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728309AbgELTIE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 15:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbgELTID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 15:08:03 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96C91C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 12:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RVdj44/VzSen6iR6rQOWCntv4FGd6/Yn4+ie5a9/Rko=; b=qKZiXMSgcjdtQ6CmvZLKE2h6sw
        HHpe7Vgsdlq9c+mtnM9CFRMqxVnqgdOeWNVOwPVnF503dAs5Nag1VCtPV9NKrgnWlC0/3GoEXcdOd
        WnDUmVQrHJ+01SxntoNQBTRcY26ZbJWiKcLFCP2v8+najyvWAzjUeEkisNB1QpBnUtcyq5OgQH+HA
        nd7sY86AuC2JcsxzEANyGeJKmZHogaWD8kcu1hNHjX/uB7Gv30BUKfqTtZhm8FfMYlV3uLacmkXoR
        7kDJI2LMLrq9sI8nvfHXBk58E0wnnnVHfsaRxLyk+zCxlsBOT1kOUzaBPLMUhCxrUwNm2B5exkFnO
        9tnLKakg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jYaFx-00013o-Pq; Tue, 12 May 2020 19:07:57 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4EFD8305EEF;
        Tue, 12 May 2020 21:07:55 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3A13628B27272; Tue, 12 May 2020 21:07:55 +0200 (CEST)
Date:   Tue, 12 May 2020 21:07:55 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Marco Elver <elver@google.com>
Cc:     Will Deacon <will@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v5 00/18] Rework READ_ONCE() to improve codegen
Message-ID: <20200512190755.GL2957@hirez.programming.kicks-ass.net>
References: <20200511204150.27858-1-will@kernel.org>
 <20200512081826.GE2978@hirez.programming.kicks-ass.net>
 <CANpmjNNo3rhwqG=xEbpP9JiSd8-Faw8fkoUhYJjesHK5S5_KQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNNo3rhwqG=xEbpP9JiSd8-Faw8fkoUhYJjesHK5S5_KQQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 12, 2020 at 07:53:00PM +0200, Marco Elver wrote:
> I just ran a bunch of KCSAN tests. While this series alone would have
> passed the tests, there appears to be a problem with
> __READ_ONCE/__WRITE_ONCE. I think they should already be using
> 'data_race()', as otherwise we will get lots of false positives in
> future.
> 
> I noticed this when testing -tip/locking/kcsan, which breaks
> unfortunately, because I see a bunch of spurious data races with
> arch_atomic_{read,set} because "locking/atomics: Flip fallbacks and
> instrumentation" changed them to use __READ_ONCE()/__WRITE_ONCE().
> From what I see, the intent was to not double-instrument,
> unfortunately they are still double-instrumented because
> __READ_ONCE/__WRITE_ONCE doesn't hide the access from KCSAN (nor KASAN
> actually). I don't think we can use __no_sanitize_or_inline for the
> arch_ functions, because we really want them to be __always_inline
> (also to avoid calls to these functions in uaccess regions, which
> objtool would notice).
> 
> I think the easiest way to resolve this is to wrap the accesses in
> __*_ONCE with data_race().

But we can't... because I need arch_atomic_*() and __READ_ONCE() to not
call out to _ANYTHING_.

Sadly, because the compilers are 'broken' that whole __no_sanitize thing
didn't work, but I'll be moving a whole bunch of code into .c files with
all the sanitizers killed dead. And we'll be validating it'll not be
calling out to anything.

data_race() will include active calls to kcsan_{dis,en}able_current(),
and this must not happen.
