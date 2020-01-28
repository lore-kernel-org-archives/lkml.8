Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_DBL_ABUSE_MALW,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67441C2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 16:52:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AAA3214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 16:52:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="1VZRq8GW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbgA1Qwe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 11:52:34 -0500
Received: from merlin.infradead.org ([205.233.59.134]:42354 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbgA1Qwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 11:52:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=65hiUb5MefbH8f+PDl0IMq1gSfIHpN1RqmM1DlOSyZU=; b=1VZRq8GWECgS2kShLBVECaj24
        DOQfjGfr1CX3/24Kw61/jgWqLGc+CQXLCVGviM36Zi/4k4pDHex+KH2/vQAz9oPYWfQv3aE5Tjkql
        MrMQ6A40sNd6m5c92WZjVrk70gkMmiPLCJexVpmrS3OM+NYLu+Rs29kwBimK/IWA4jpPt5oYjMM6x
        r/txGjRFhCObHT8CWKbKmHJpoK8CM4mjMW3YoRZJbHcuT9r74GkekW8Sw+Rb3xjfXZpAP/freLEWW
        gxRbdA2B6ZH0/vNcBzsWcWpBoAkF5vblcCANkEY5r3HXb2iySAuo+yAOK/gTbV0NSBU/3x2j31QqE
        hN71XiNLg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iwU65-0001Gy-V8; Tue, 28 Jan 2020 16:52:18 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9720C306012;
        Tue, 28 Jan 2020 17:50:32 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 083A42B7159FB; Tue, 28 Jan 2020 17:52:15 +0100 (CET)
Date:   Tue, 28 Jan 2020 17:52:15 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Marco Elver <elver@google.com>
Cc:     Qian Cai <cai@lca.pw>, Will Deacon <will@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "paul E. McKenney" <paulmck@kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Subject: Re: [PATCH] locking/osq_lock: fix a data race in osq_wait_next
Message-ID: <20200128165214.GL14914@hirez.programming.kicks-ass.net>
References: <20200122165938.GA16974@willie-the-truck>
 <A5114711-B8DE-48DA-AFD0-62128AC08270@lca.pw>
 <20200122223851.GA45602@google.com>
 <A90E2B85-77CB-4743-AEC3-90D7836C4D47@lca.pw>
 <20200123093905.GU14914@hirez.programming.kicks-ass.net>
 <E722E6E0-26CB-440F-98D7-D182B57D1F43@lca.pw>
 <CANpmjNNo6yW-y-Af7JgvWi3t==+=02hE4-pFU4OiH8yvbT3Byg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNNo6yW-y-Af7JgvWi3t==+=02hE4-pFU4OiH8yvbT3Byg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 28, 2020 at 12:46:26PM +0100, Marco Elver wrote:
> On Tue, 28 Jan 2020 at 04:11, Qian Cai <cai@lca.pw> wrote:
> >
> > > On Jan 23, 2020, at 4:39 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > On Wed, Jan 22, 2020 at 06:54:43PM -0500, Qian Cai wrote:
> > >> diff --git a/kernel/locking/osq_lock.c b/kernel/locking/osq_lock.c
> > >> index 1f7734949ac8..832e87966dcf 100644
> > >> --- a/kernel/locking/osq_lock.c
> > >> +++ b/kernel/locking/osq_lock.c
> > >> @@ -75,7 +75,7 @@ osq_wait_next(struct optimistic_spin_queue *lock,
> > >>                 * wait for either @lock to point to us, through its Step-B, or
> > >>                 * wait for a new @node->next from its Step-C.
> > >>                 */
> > >> -               if (node->next) {
> > >> +               if (READ_ONCE(node->next)) {
> > >>                        next = xchg(&node->next, NULL);
> > >>                        if (next)
> > >>                                break;
> > >
> > > This could possibly trigger the warning, but is a false positive. The
> > > above doesn't fix anything in that even if that load is shattered the
> > > code will function correctly -- it checks for any !0 value, any byte
> > > composite that is !0 is sufficient.
> > >
> > > This is in fact something KCSAN compiler infrastructure could deduce.
> 
> Not in the general case. As far as I can tell, this if-statement is
> purely optional and an optimization to avoid false sharing. This is
> specific knowledge about the logic that (without conveying more
> details about the logic) the tool couldn't safely deduce. Consider the
> case:
> 
> T0:
> if ( (x = READ_ONCE(ptr)) ) use_ptr_value(*x);
> 
> T1:
> WRITE_ONCE(ptr, valid_ptr);
> 
> Here, unlike the case above, reading ptr without READ_ONCE can clearly
> be dangerous.

There is a very big difference here though. In the osq case the result
of the load is only every compared to 0, after which the value is
discarded. While in your example you let the variable escape and use it
again later.

I'm claiming that in the first case, the only thing that's ever done
with a racy load is comparing against 0, there is no possible bad
outcome ever. While obviously if you let the load escape, or do anything
other than compare against 0, there is.
