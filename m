Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF92BC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 14:06:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAE7C20678
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 14:06:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UamQ/jqM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726978AbgHJOG6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 10:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726845AbgHJOG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 10:06:58 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25C24C061756
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 07:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0NkcUhh2BgxISPZreSijRxme2NhNix1+tFt4ONKujyE=; b=UamQ/jqMujk+F8HamiNl6Rxl36
        P5XIgyW2bMiXe7mXZ3ty7215KWppEzzOB+SMCtBGUaXjPYoSl7i3bprOIdiXw5mwNt6RebEkj0QtP
        ET2BcmGpZpaaPQxxv19Z8LZBqsSd6MgXHYwFCT3gc1rkxmxAbojJoFfwLtM8aKqitQi8AXGkKA1jd
        tGUO9eWMKyXNmp1S6gNEGTGuAfQlIk91E+5l0Q4ePobrJLyEOxbdW7iaA4jfmIH/4aEVWkbo8hpoT
        eL64na/ZbDfXDzvoaq16VPLNWNH45XyEOrsY/K7t5Yk+4WyBSxqEMAY3YLckSXAVjXcyg+j3/Sh7V
        w2sV5mLQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k58Rt-0005F0-Sm; Mon, 10 Aug 2020 14:06:50 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7618430015A;
        Mon, 10 Aug 2020 16:06:48 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 618082B2C802B; Mon, 10 Aug 2020 16:06:48 +0200 (CEST)
Date:   Mon, 10 Aug 2020 16:06:48 +0200
From:   peterz@infradead.org
To:     Marco Elver <elver@google.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        syzbot <syzbot+8db9e1ecde74e590a657@syzkaller.appspotmail.com>
Subject: Re: [PATCH] kcsan: Treat runtime as NMI-like with interrupt tracing
Message-ID: <20200810140648.GZ2674@hirez.programming.kicks-ass.net>
References: <20200807090031.3506555-1-elver@google.com>
 <20200807170618.GW4295@paulmck-ThinkPad-P72>
 <CANpmjNPqEeQvg53wJ5EsyfssSqyOqCsPG+YTV6ytj6wsc+5BPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNPqEeQvg53wJ5EsyfssSqyOqCsPG+YTV6ytj6wsc+5BPQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 10, 2020 at 10:07:44AM +0200, Marco Elver wrote:
> On Fri, 7 Aug 2020 at 19:06, Paul E. McKenney <paulmck@kernel.org> wrote:
> > On Fri, Aug 07, 2020 at 11:00:31AM +0200, Marco Elver wrote:
> > > Since KCSAN instrumentation is everywhere, we need to treat the hooks
> > > NMI-like for interrupt tracing. In order to present an as 'normal' as
> > > possible context to the code called by KCSAN when reporting errors, we
> > > need to update the IRQ-tracing state.
> > >
> > > Tested: Several runs through kcsan-test with different configuration
> > > (PROVE_LOCKING on/off), as well as hours of syzbot testing with the
> > > original config that caught the problem (without CONFIG_PARAVIRT=y,
> > > which appears to cause IRQ state tracking inconsistencies even when
> > > KCSAN remains off, see Link).
> > >
> > > Link: https://lkml.kernel.org/r/0000000000007d3b2d05ac1c303e@google.com
> > > Fixes: 248591f5d257 ("kcsan: Make KCSAN compatible with new IRQ state tracking")
> > > Reported-by: syzbot+8db9e1ecde74e590a657@syzkaller.appspotmail.com
> > > Co-developed-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> 
> Peter, if you're fine with it, I think we'll require your
> Signed-off-by (since Co-developed-by).

Sure:

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
