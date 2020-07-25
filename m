Return-Path: <SRS0=eufF=BE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 024A8C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 20:21:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7EE1206D8
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 20:21:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="M82R7Oo1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727912AbgGYUVj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 16:21:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726727AbgGYUVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 16:21:39 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D64A9C08C5C0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jul 2020 13:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nEVDy9qer+ckQqB0/s8J9oIrB0Y28OWoQKAT4jlVuho=; b=M82R7Oo1Bq7KxP1RWnK9b0Een7
        ZePghvSlHu5G14h3UgVI23HBwSLhrQ2fRNvpsD8sN8qBZGELtpaPEcA1NtLSVBGaC9N70bngDsxYX
        zJM8fFRI5f+8xEweV1YZ4B+tlAz78KiwB4DLRp66mO3hts4NZgvXeUCx6V601ck4DUFmA8HHuZykL
        N9bxt82OE3YEaGKvNXy2pW/j+SfZIwOexkFLDZUA7lQpRTxUMfd03H653mhJRo0EMgzW6TTCohKqV
        aQjWrk4uHAunDY+OxGlwh9jgEyRr38S3w102tt8Mk+RBsST6WiSOE+7Ys6Nqk5w/eunNs1awcB56X
        nC7oCUlg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jzQfl-0000FO-VL; Sat, 25 Jul 2020 20:21:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8A970301179;
        Sat, 25 Jul 2020 22:21:31 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6E7582141FBB0; Sat, 25 Jul 2020 22:21:31 +0200 (CEST)
Date:   Sat, 25 Jul 2020 22:21:31 +0200
From:   peterz@infradead.org
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kcsan: Add option to allow watcher interruptions
Message-ID: <20200725202131.GM43129@hirez.programming.kicks-ass.net>
References: <20200220141551.166537-1-elver@google.com>
 <20200220185855.GY2935@paulmck-ThinkPad-P72>
 <20200220213317.GA35033@google.com>
 <20200725145623.GZ9247@paulmck-ThinkPad-P72>
 <CANpmjNPhuvrhRHAiuv2Zju1VNSe7dO0aaYn+1TB99OF2Hv0S_A@mail.gmail.com>
 <20200725174430.GH10769@hirez.programming.kicks-ass.net>
 <20200725193909.GB9247@paulmck-ThinkPad-P72>
 <20200725201013.GZ119549@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200725201013.GZ119549@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 25, 2020 at 10:10:13PM +0200, peterz@infradead.org wrote:
> On Sat, Jul 25, 2020 at 12:39:09PM -0700, Paul E. McKenney wrote:

> > This gets me the following for __rcu_read_lock():
> > 
> > 00000000000000e0 <__rcu_read_lock>:
> >       e0:	48 8b 14 25 00 00 00 	mov    0x0,%rdx
> >       e7:	00 
> >       e8:	8b 82 e0 02 00 00    	mov    0x2e0(%rdx),%eax
> >       ee:	83 c0 01             	add    $0x1,%eax
> >       f1:	89 82 e0 02 00 00    	mov    %eax,0x2e0(%rdx)
> >       f7:	c3                   	retq   
> >       f8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
> >       ff:	00 
> > 
> > One might hope for a dec instruction, but this isn't bad.  We do lose
> > a few instructions compared to the C-language case due to differences
> > in address calculation:
> > 
> > 00000000000000e0 <__rcu_read_lock>:
> >       e0:	48 8b 04 25 00 00 00 	mov    0x0,%rax
> >       e7:	00 
> >       e8:	83 80 e0 02 00 00 01 	addl   $0x1,0x2e0(%rax)
> >       ef:	c3                   	retq   
> 
> Shees, that's daft... I think this is one of the cases where GCC is
> perhaps overly cautious when presented with 'volatile'.
> 
> It has a history of generating excessively crap code around volatile,
> and while it has improved somewhat, this seems to show there's still
> room for improvement...
> 
> I suppose this is the point where we go bug a friendly compiler person.

Having had a play with godbolt.org, it seems clang isn't affected by
this particular flavour of crazy, but GCC does indeed refuse to fuse the
address calculation and the addition.
